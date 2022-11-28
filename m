Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706DF63AE48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiK1RBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiK1RBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:01:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080032DFB;
        Mon, 28 Nov 2022 09:01:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id be13so18392551lfb.4;
        Mon, 28 Nov 2022 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GpRyDK/46++YKz2EFwIeDbSAjaRlIbxnLXBLKlVstM=;
        b=b3QD0v4al1qJqnBl/vris9v0AeyQVbu1VFPxBZbgKIDBiPGb4cMW9uDvmhTiTwrfaI
         MzKU3/U7DnUtrNfrzqLC93sda7bjb4PDp45kdGZQ7twTHb5BZndmjYl3BO1M4BafSxgW
         RFraXOc/UuT8LhvGaxwCGzT9KLOovxKydh4RbMSOyckWTs4EuFuAwxKKFVIXnrZ8H6+e
         OgkP45zamkKRGV/sWuGc5aitnfDLS9Uco2oLqwvIbHy85vAWxq8Uw1ZaZBtU20TTaT7R
         I6R3p2CemGo1zAMxNL4An5P1OCPL4KvnjM24rf9u/Fvh/oFIa4ekJGDcRXDSqXNQR2Xw
         vTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GpRyDK/46++YKz2EFwIeDbSAjaRlIbxnLXBLKlVstM=;
        b=N8KPeTymRsuEdRCP2DJQLwp0LtKhL8M/76o0LfsdKbAC2UEirzfHW6/cuDvFrQ9tti
         sZteGsG83FQI+MoMM7W/O4HdWiYrSOytzrnuHX5yIcarAaUpYvFYcAJxy4aJwVP2bME9
         hgG7wPXtm5sQ9MB+v8l+sfpKzD2mVdIIC4nqUy0HiuUNlG78+TrIWpDO0vpmeYwPMO5w
         vf7guR6gLof/5KWHwQlcLMeX26/8pYrdOppnpsQ3q/CjSS94A5+CiSwZB4G39Q++xwm2
         Ice4ETEswaEZqkSKYWkLiDoHy28bcAwkJr4Z/eo19msusV/W+GZTOpKK6SURUleYdGr4
         igoA==
X-Gm-Message-State: ANoB5plEoCHWedcohyxSr0SRhbN85l32mthT1vACWubbbow9Nmo8WjUD
        2fFvtaRDCEY+9BXVAgDSU0P82AKczpffDw==
X-Google-Smtp-Source: AA0mqf7GjM56yI7ibfyIeX/9Yjd43Ezpc7UZ0t1luF9D869H/74eJ853fXC+TpaBY7Aij7yDCKDIAA==
X-Received: by 2002:a05:6512:3e2a:b0:4ab:534b:1b2c with SMTP id i42-20020a0565123e2a00b004ab534b1b2cmr12791293lfv.426.1669654871020;
        Mon, 28 Nov 2022 09:01:11 -0800 (PST)
Received: from [192.168.0.251] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512028c00b004b40c1f1c70sm1801315lfp.212.2022.11.28.09.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:01:10 -0800 (PST)
Message-ID: <90d231c6-1f16-74ea-ddf7-5e09a51a93ea@gmail.com>
Date:   Mon, 28 Nov 2022 19:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125223400.94515-1-matti.lehtimaki@gmail.com>
 <a64d31a5-5e55-35b9-57e3-bb4214fe3e28@linaro.org>
Content-Language: en-US
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <a64d31a5-5e55-35b9-57e3-bb4214fe3e28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.2022 16.41, Konrad Dybcio wrote:
> 
> On 25.11.2022 23:34, Matti Lehtimäki wrote:
>> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
>> index 1c52337af560..859e91c16c61 100644
>> --- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
>> @@ -133,7 +133,8 @@ wcnss@d200000 {
>>   			no-map;
>>   		};
>>   
>> -		adsp@d900000 {
>> +		/delete-node/ adsp@dc00000;
> Please delete nodes by referencing the label like so:
> 
> /delete-node/ &adsp_region;

When I created the devicetree I was asked to do the opposite for the
smem_region [1] which I had originally deleted using the label near top 
of the
file but then moved next to the relevant node, where I cannot use label
when deleting it. Should the smem_region also be moved to the top of the
file if I move this delete-node there so the file would be consistent?

[1] 
https://lore.kernel.org/linux-arm-msm/CAA8EJpqUH_v1GXEYF62Z3DBtFu_305_h4D36aCnBr38bo5HoJw@mail.gmail.com/
-- 
Matti
