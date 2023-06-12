Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2EC72C468
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjFLMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjFLMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:36:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F2130
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:36:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so5156803e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686573365; x=1689165365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cs0olSYEItKtn767ESE540fraVlcmbticwKxKjHPy6A=;
        b=OxPnUC7HiMXz859dtF70HMax8lhjTJyqpzGATRXKW4hUW7ulL8hUVjBcNbx8HeTzsi
         RybQNfBGUuytrAMeOQ97QGSnEcv22EZj8iFS5wSbwLDy7dDET4sCFnTRUWqD42gpjvUz
         FiLXT6gee53N12m3WprnMTq77FY76PadA/06c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686573365; x=1689165365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs0olSYEItKtn767ESE540fraVlcmbticwKxKjHPy6A=;
        b=f4q8DlahOK0Ig1tadnTBhGe/AkvQQKDPdyMekg0zbfgASlPUZ5VWaWqmtARPRsRlli
         HrBbYz3WDVtgZJaEEitUEiVMsKwUMgPPmewBImLU27fArLyrdbaHFzjscVFzDwxpxeDx
         Mp6QtBkpVtGKstdWqHbIDjo7eGTDHNnbXbtMpx5rPhQYRczBQFD584Nssg1UoG1RdC5z
         wEbTi0iJDIYzditncWTXUCF2DBWtUzfttXcfQacdnRm7jtpj983WN3YUVyDbguLfz3Vd
         uUpQAl/ntdlyxrKPz7N0axO959yL2ZC/NKC38lDegavP2V3T1NmK72E3luz5SW7WBrl0
         hZEQ==
X-Gm-Message-State: AC+VfDyErjyWCMHxrX4aHpHrjpRbZFUqz8q0vjGHQU4NS3MtXy08ELzS
        cTudVAXG7n4vazxo/aZfIOgmQK+26QDJ2dX/icP92A==
X-Google-Smtp-Source: ACHHUZ4Cejd5jOArObXHcQm3kWtkiB+UPGBXUzfi+0xU5ER7MSdmDxzJBBxjvkl1rAyhuigY+2/Hnw==
X-Received: by 2002:a19:2d12:0:b0:4ea:e60a:2f5d with SMTP id k18-20020a192d12000000b004eae60a2f5dmr3537309lfj.40.1686573365111;
        Mon, 12 Jun 2023 05:36:05 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t11-20020a19ad0b000000b004f3940c2b07sm1422021lfc.274.2023.06.12.05.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:36:04 -0700 (PDT)
Message-ID: <2a2fa3c5-739c-6bcf-3c41-3db1aac5ccca@rasmusvillemoes.dk>
Date:   Mon, 12 Jun 2023 14:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/8] dt-bindings: rtc: Move isil,isl12022 from
 trivial-rtc.yaml into own schema file
Content-Language: en-US, da
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-3-linux@rasmusvillemoes.dk>
 <168657279982.4044345.9896354759743085279.robh@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <168657279982.4044345.9896354759743085279.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 14.26, Rob Herring wrote:
> 
> On Mon, 12 Jun 2023 13:30:52 +0200, Rasmus Villemoes wrote:
>> Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
>> intersil,isl12022.yaml file, in preparation for adding more bindings.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  .../bindings/rtc/intersil,isl12022.yaml       | 42 +++++++++++++++++++
>>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>>  2 files changed, 42 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml: 'maintainers' is a required property
> 	hint: Metaschema for devicetree binding documentation
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

Hm ok. Can/should I copy the value from the trivial-rtc.yaml? Alexandre,
would that be ok with you?

Is there some simple way to do that dt_binding_check for a single file
or just a few? It seems to take forever to run on the whole tree.

Rasmus

