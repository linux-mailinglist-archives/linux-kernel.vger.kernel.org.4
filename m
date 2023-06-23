Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4F73B513
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFWKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjFWKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:18:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8626B9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:18:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31297125334so469112f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687515485; x=1690107485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHZhWGgo76NH04cF8GjDPfERCPW0cF8Z2+fMP4OyHqQ=;
        b=KotL6elRZiyHJbzzU4+dTZy09rPZ+IgouoMwJH7RGSLWSlSdV1mkJv7t/hIzx5UHLO
         1usSOWcVS5tqcmu9y42pl4mh0WzHXaS+MYqkVQJz/5jYg72w4f3nqReTTG8s83ggX2TO
         fHDeMeg/bq1VN8fUYUqObn/rq3zVsUkYWMAKzQfmxOHMzj5h5Xe1KAoWNJm2mCKdnXRQ
         Bh/5cFNi93Rro4mB9hRXZ5kNWHg/OzEKvNTMbsp4wnl+jcoH0eP5UuQ6rA0g+cwyrkCA
         Dufk4OdbChKRdjMnDCRt4b/7CiLH38so/fP0oWkWQ8A073iIVyLnJSHkglcXrzNAFu2r
         EBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515485; x=1690107485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHZhWGgo76NH04cF8GjDPfERCPW0cF8Z2+fMP4OyHqQ=;
        b=G9r6oqhiXq4dLW2rSeg19SDRFxBVkK7rtiR2wWWtfLBMkklexRo3ZEJeoV/xpBPZ5A
         +RttMHTUC9lRocLajbjtC7BvyQND6F4zgnm6Gecqndfe47a/cQLCC8w/MfRk/+JW4Ij8
         hp2OqC0Yw6uP32bYDkZD40MDmr6QQKuJH7Ne79uqAHWG7YoPBZSe4MqXwUG7shiP72H9
         ojyVelJKMYVElT+2hr5aA/Ctu+ZT7ROB+GB0+CozdQsU+D9UOIP3B8LfnY4vr9q7SEVt
         fVlecXZD91D3velz9jJFw+FeH3gQYh+ghpQATRdGhs1CGx8x451lKNajOfZ5yU5cpwi2
         ltmw==
X-Gm-Message-State: AC+VfDxKo3WAynGJh0ClhaUQcl8psDqvSL93QvM5PaBU1N8c5if961x/
        prw04Tcj0uhgBMdWbKHxW3bDSA==
X-Google-Smtp-Source: ACHHUZ54DxkRUdIGChdHo1KpYidQIMlPEVyjCTwb7Ch5HWkPJvWak6Qi61VB6TOh39zHDoWFCVIMgw==
X-Received: by 2002:adf:e88a:0:b0:311:19ad:a082 with SMTP id d10-20020adfe88a000000b0031119ada082mr18835654wrm.3.1687515484807;
        Fri, 23 Jun 2023 03:18:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w3-20020adfee43000000b0030e5b1fffc3sm9272268wro.9.2023.06.23.03.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:18:03 -0700 (PDT)
Message-ID: <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
Date:   Fri, 23 Jun 2023 12:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Content-Language: en-US
To:     "Lee, Kah Jing" <kah.jing.lee@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 12:03, Lee, Kah Jing wrote:
>>>>>
>>>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
>>>>> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
>>>>> ---
>>>>>  arch/arm64/configs/defconfig | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig
>>>>> b/arch/arm64/configs/defconfig index a24609e14d50..23a6ebcb1a9e
>>>> 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -470,6 +470,8 @@ CONFIG_IPMI_DEVICE_INTERFACE=m
>>>> CONFIG_IPMI_SI=m
>>>>> CONFIG_HW_RANDOM=y  CONFIG_HW_RANDOM_VIRTIO=y
>>>>> +CONFIG_MTD_UBI=y
>>>>> +CONFIG_UBIFS_FS=y
>>>>
>>>> Not modules?
>>> Yes, we need to boot with rootfs with UBIFS.
>>
>> So you miss init ramdisk.
> Currently we are using the bootargs to mount the rootfs from QSPI NOR flash:
> [    0.000000] Kernel command line: earlycon panic=-1 ubi.mtd=1 root=ubi0:rootfs rootfstype=ubifs rw rootwait
> Is it possible to mount the ubifs rootfs with the ubifs=m config during boot?

I think yes. rootfs devices are for example modules, so filesystem can
be as well.


Best regards,
Krzysztof

