Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CF9745C4C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjGCMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGCMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:33:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60A10C0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:33:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so64886281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688387593; x=1690979593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhfrXDCit7gC6UNJ9zxd5YYkATKXfztakGAxqCORjpU=;
        b=PTl2J96D/DXP0ioiXlDXQjPk2eQQE0gU3gHy4fVUouQkTXVBHc8HamEz+VFjkBb/Wo
         rSVDk0IS1EdDa0cFQv/xbkQSySukP+PEITp0V0QJ6FOpe69lLDqBgOTAzRKow0TebR31
         mHxl8FJ50wsSJ+6kbVX3++u/E97yiO+LPniBpIeFcSlacKIWjqwUuVUfydTwPQXZxztA
         C0DZSgrkLC8Wov3PEWDplUxli2LpSxnrhNIHt7J/y4LQE6Fj1KBKsf50qSWLTuK3Jh+O
         fj1qQEF2eGAwLRsswRc5B8hPB1Eph+og0ER3Khp1FCR8mwgNFsQznxvG/3AGjKA1hiYL
         O3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688387593; x=1690979593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhfrXDCit7gC6UNJ9zxd5YYkATKXfztakGAxqCORjpU=;
        b=TVizQVaDHBzPu+DobwYSac6Du8ZwPDvkqkQT/N3xsAKHAw9kRc0tBB6/2TaR90DPTC
         Na0peHT/jVYDLpRaoRlWBs7hJG2jZ3g9rvywwXUkvHZz6Nmw48uy/MmZG/sIe2m3jn9i
         XYQcwLPAiNAgJb3OMAQYNctGzSHBEi2Tm7dZH0RZg3XMxPOnosfupzThure+U+OS4Y2W
         rGfIeQ/Hg0B1fufaNFYx9qCew+lq4MInflWBVIaxwhkSR7aX6ikTNjrc/k5oKvKz8ot3
         tDN4CuBFuSxMECkdtWG6wVMZQdJNMTDnXfWOti6b5dXCG+x+WFjDHBeFbI0t5gMDkKPV
         pVZQ==
X-Gm-Message-State: ABy/qLYypYHFIXtf98jg3arqNAp94Y8IkB6QdtpmIC11kASzrzCHXW8e
        vLTxLX9ttoUbRMLZn2vAKDkFBA==
X-Google-Smtp-Source: APBJJlGgueiIvReR4RZC34W5mgNbDVir3z0bbYJoEIBN1p28sRET5jJ5DVkKA1f1FPRpigRYzKtQvA==
X-Received: by 2002:a2e:81d3:0:b0:2b6:ef5d:965c with SMTP id s19-20020a2e81d3000000b002b6ef5d965cmr242828ljg.44.1688387593103;
        Mon, 03 Jul 2023 05:33:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b0098e17ea781csm11095329ejb.94.2023.07.03.05.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 05:33:12 -0700 (PDT)
Message-ID: <df7440e2-58b0-9f12-8f37-4f0d9050f934@linaro.org>
Date:   Mon, 3 Jul 2023 14:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 3/3] ARM: dts: Add Chameleon v3 video node
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mchehab@kernel.org, upstream@semihalf.com,
        amstan@chromium.org, ribalda@chromium.org
References: <20230630144006.1513270-1-pan@semihalf.com>
 <20230630144006.1513270-4-pan@semihalf.com>
 <20230630-scrimmage-antelope-7d1f82d491fc@spud>
 <CAF9_jYT1Fz4hBQrNtgkM6mU-JVH=ZxsJnkaLDsa5uoEV_hTLVA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF9_jYT1Fz4hBQrNtgkM6mU-JVH=ZxsJnkaLDsa5uoEV_hTLVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 13:44, Paweł Anikiel wrote:
>>> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
>>> index 422d00cd4c74..5e66363d4ab5 100644
>>> --- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
>>> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
>>> @@ -10,6 +10,60 @@ / {
>>>       compatible = "google,chameleon-v3", "enclustra,mercury-aa1",
>>>                    "altr,socfpga-arria10", "altr,socfpga";
>>>
>>> +     soc {
>>> +             video@c0060500 {
>>> +                     compatible = "google,chv3-video";
>>
>> This compatible does not seem to be documented & I did not see a comment
>> about the lack of a binding in the cover letter. What am I missing?
> 
> Yes, the compatible is not documented for now (I'll do that in a later
> patchset), sorry for not mentioning that in the cover letter.

You cannot add undocumented compatible. This cannot be fixed in "a later
patchset".

Best regards,
Krzysztof

