Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998936254C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiKKH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:58:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7332316C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:58:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so7230357lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwU5CkjoRIEtbAhM41+6jkxe2GJWOzFr6ZG3QP2ECFg=;
        b=ZaSv/KRfXBtxkGUSgji6I7GnV9tr2AB9YForlVDX5XFX6IR3erR2a1qmlIrpvxkUYj
         i3hyWfIpzIWcI+Kq3vmbpOTVnsxd+HJLwV8+NALZ0Lxz9b9hGPZ9Gp++JIr+YOgt5VL1
         raGG3kk0h2+gCCfZD7YOrHpjkw6SF0I8Ya2k3q0dSyXiHlIfUxbg2WmCbUpTwH67JFo7
         pTBjIYjYffG0o2U+5Pkkf7pLKPRicVhZnL49LIfTlet+92BuI8MvbYaEk8L2wMN573O1
         eM2YItr/iN5Gpd38qPIlTs2i59ZVUMNFqlEM+QMpcTcKplFbHiLss68f/a2jd2Hrw93c
         513A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwU5CkjoRIEtbAhM41+6jkxe2GJWOzFr6ZG3QP2ECFg=;
        b=heTUxxRGn21oZtiGP7Oa2fab2CjfzKG+tvrmgVY30A6TmJ4jDpd8j5MPiOjE4/MgSq
         ldEIS07aq8KlEf8JbTatKuy5rMdWDYjPd2rcC1fT/+qzGFgsYag+gpnZXKdScLBO5zMQ
         ZYV+BpfOkIrM4sHNAxRC8QLwNvO9Pm3uqKqufvsfsztVz5XmK94kaCXVZLJ9GGdXwfFE
         JChRuvLG/+5u1JjUKHL6XijFduoR3K1Q8uG4HGfi4KS9WTw2ukIwuQByGmBlskfNMgn8
         wMMyQ8qFRYdMrmWRD08bd6ZBpFYLVdkQa9ggQ3YR+knrQAMX3izDd9MCNoVZo7SKQXNn
         Rjsg==
X-Gm-Message-State: ANoB5pkFSxKdmJVZNqhnLRDvoXFEHREX3C2fGhewB+TqNKNXaJ7GwMvR
        HKebwy1BbvzwAx+VydR9xHnuHQ==
X-Google-Smtp-Source: AA0mqf6p3rZ6O0OVw4hUrGNozzgAitQ9QVJ9blTJGAml+eH1lWfauMEDnESpyUls6Sygn0NkeUXOEw==
X-Received: by 2002:a05:6512:456:b0:4b1:5bf0:df51 with SMTP id y22-20020a056512045600b004b15bf0df51mr419009lfk.674.1668153529875;
        Thu, 10 Nov 2022 23:58:49 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a18-20020a056512391200b004b097f2c73dsm199930lfu.253.2022.11.10.23.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 23:58:49 -0800 (PST)
Message-ID: <ca66fe57-33c8-a98e-b6c7-cf1c94473a64@linaro.org>
Date:   Fri, 11 Nov 2022 08:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: Convert active-semi PMIC docs to YAML
 schemas
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        list@opendingux.net
References: <20221105225803.39197-1-paul@crapouillou.net>
 <02c45ae9-61a4-9fc5-4daf-8c4c9df9a4a0@linaro.org>
 <NEH5LR.URZKYH8VLESF1@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <NEH5LR.URZKYH8VLESF1@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 22:08, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le dim. 6 nov. 2022 à 10:55:11 +0100, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> a écrit :
>> On 05/11/2022 23:58, Paul Cercueil wrote:
>>>  Create YAML bindings for the Active-semi PMICs and remove the old 
>>> text
>>>  files.
>>>
>>>  The bindings aren't perfect, for instance I couldn't find good
>>>  descriptions for the vendor properties in the "charger" node of the
>>>  ACT8945A because I am not familiar with the hardware and these
>>>  properties were not documented anywhere.
>>>
>>>  The YAML schemas are a bit different than what is described in the 
>>> old
>>>  text files, because these were sometimes wrong or had missing
>>>  information. This is the case for the ACT8600 documentation, which
>>>  specified the valid node names for the regulators, while the driver 
>>> was
>>>  expecting different names. This led to the current situation where 
>>> we
>>>  have two different boards using different names for the regulators:
>>>  - arch/mips/boot/dts/ingenic/ci20.dts uses the names documented in 
>>> the
>>>    text file,
>>>  - arch/mips/boot/dts/ingenic/gcw0.dts uses the names that the driver
>>>    expects.
>>>  In theory, the driver should be fixed to follow the documentation, 
>>> and
>>>  accept both naming schemes. In practice though, when the PMIC node 
>>> was
>>>  added to the ci20.dts board file, the names were already wrong in
>>>  regards to what the driver expected, so it never really worked
>>>  correctly and wasn't tested properly. Furthermore, in that board the
>>>  consumers of the regulators aren't working for various other reasons
>>>  (invalid GPIOs, etc.).
>>>
>>>  For that reason, for the ACT8600 bindings I decided to only use the 
>>> node
>>>  names that the driver expects (and that gcw0.dts uses), instead of
>>>  accepting both old and new names. A follow-up patch will update the 
>>> CI20
>>>  board to use the new regulator names.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  ---
>>>
>>>  Notes:
>>>      v2:
>>>      - Avoid | character in descriptions that can be single-line
>>>      - Remove unevaluatedProperties when additionalProperties is 
>>> also present
>>>      - Remove useless inner parentheses in regular expressions
>>>      - Rename I2C nodes to just... i2c
>>>      - Remove node handles
>>>
>>>      Note:
>>>      I set Liam Girdwood and Mark Brown as the maintainers by 
>>> default, since
>>>      it doesn't appear that anybody is managing the Active-semi 
>>> drivers, but
>>>      if anybody steps up I can update it.
>>
>> It should not be Liam and Mark, but someone having/knowing this
>> particular hardware.
> 
> Well, who would that be?
> 
> I do have a board with the ACT8600, but that's about it.

You or driver maintainer or recent contributors.

Best regards,
Krzysztof

