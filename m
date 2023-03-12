Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC356B651E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCLKxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCLKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:53:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF961ACDF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:53:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so6667284edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678618408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDgh3TknbmiCf9s5DB9Gz3iSw4R2xeve7Km/8RLVnf4=;
        b=HkZpWGwJREJqDZQikjfKjHaIJngkUxd4ELvmStTTwt/H/j1Rz2ggHSPXlTn2UmdaeB
         fK20JJX3qFJO9x1t08yWKJDUEi98z3aByu3GGoHXm6IXLrR67VpA1nY6CXX71Y2mtMHp
         TnmC8TAu9m9RnBk6ocmTDKh3YGpWEmEzjdWEihg3/ib9joNpBXSoKWyXSwJYI5YeqjYA
         WxkEKDaEw9fofMvYKVmELeAe+2/+eFJRRdWpAkJJcPGG2aM85/6Z8IR+ZfDCQJIO0Kwg
         FaO7CrYSEKBjuUzirOUqob6VtlVo1h6tOCF9DNGc6UdI5LJDO9/nCX6f2VFsMOtlHDlR
         Hb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDgh3TknbmiCf9s5DB9Gz3iSw4R2xeve7Km/8RLVnf4=;
        b=Poha4AcJ6H5HlaQLYmYxLATdGe/NOIqt4bX61tSeidHOd1jCoEc57z4WNUeXbQ/grY
         a1xjhxKjuCeBIG3ee2G6HieF0OAbE+j6qQk5Jm7LELYjvwv0uWObA8T1kr+Xu+Hmr3aw
         V0FmyMpots4B5kPyiItLRy6/XuihjD9IcIVtO05XnPMYrAmfBgnxKIVYvgfRdG/kgHmo
         tvHI/CP3h9jKAVqJftTSoi9g9I7PApa9bdF6nwquwwvLytTod63nRYllyJ9sLA0mfw3N
         3LeHz0UmKBefgLc112QPT4DcEAoxWpB65ypgVuVkKIcpFaQvLq1nHpqEe2pSGYZwvCaw
         SlhA==
X-Gm-Message-State: AO0yUKV5fKlTvRxgNHsRr7/+vxR0Fjd1b18C2lr52b70wlou21gosR4d
        5wlV71m4hC1Q+qiShgKbbmcTPQ==
X-Google-Smtp-Source: AK7set+XxjaL3DjEjXJy9nMY+u0ze34tQDgIslNmdhYHn3RhxWs81Lxo/05eqsrtNMO4dMzhbmPcjQ==
X-Received: by 2002:a50:ed8c:0:b0:4c3:b607:f5a2 with SMTP id h12-20020a50ed8c000000b004c3b607f5a2mr27404830edr.11.1678618408337;
        Sun, 12 Mar 2023 03:53:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id s18-20020a056402037200b004fc1bb4285fsm222049edw.93.2023.03.12.03.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:53:28 -0700 (PDT)
Message-ID: <b65d54e3-b78b-654b-4932-03afefa2e950@linaro.org>
Date:   Sun, 12 Mar 2023 11:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <640dae27.2e0a0220.d5632.151c@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640dae27.2e0a0220.d5632.151c@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 11:49, Sergey Lisov wrote:
>>
>> Anyway, I said last time this looks compatible-specific, so I don't
>> think we need another property.
>>
>> Best regards,
>> Krzysztof
> 
> I agree, but I'm afraid of introducing regressions by enabling this
> workaround on systems that don't actually need it.

I don't understand why would you enable it for systems which do not need it?

Best regards,
Krzysztof

