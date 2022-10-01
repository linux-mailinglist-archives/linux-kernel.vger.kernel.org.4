Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0DF5F1BB4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJAKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJAKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:06:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19ED1116E7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 03:06:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 25so25026lft.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JdYvlqF5E77ETGsiA3+iUVd/M7BniVM0ttBqGKQmW/g=;
        b=cm2DPW+cKfk1EdEZh3iq/2iqecYirZEhqgCi2lGiBe7QUqCgd8QeCso7EWeuymDOE8
         5qJGqBSDWlyJYG0aELHtS9PXMPiw1pSnwE2lGqdNt4f6Y0iGDVHf1n/mTZHpNC7G1vNU
         R0dRWUpo3BNX55fvpctYeuXJ59TXG8NcCqDv7qJMzXsun4YV20yNQJOaJ2tMgW3fiV6M
         sjAHCGPGLVNWwnORr+0Cg0QwG81dfo0JHRznCcDu1+IOuy0kIemaq1Wfz+OH9jcOKPTV
         8ImslYg59ja2TxlIuUGosk6OB50ohAzZZlFGj9/DXmS9iTf3ZQDgfFhHVH85YJC8QOmB
         6Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JdYvlqF5E77ETGsiA3+iUVd/M7BniVM0ttBqGKQmW/g=;
        b=YD9tew562XNnCECslM+F4thKvWunNQvFrXrCCFmC9MCNL7MSmlo0MRNchqtcE0tUu3
         XtGEIFi7DAkY6UHFEWxHZ4iPmlKZAgu4Hcgnt2uctutZq+BApffNsoP4YlGfqi39r4nQ
         ZT0rKz+Zc9ncW5x9tRekCGMo1JEKOzagDeUzYt2PXkxbPQugQlw/TZ1Ns4R4f5XAjCsi
         uoGAgRuRy4e8pG3nuRtlEuq04DLLrNMs8bEJMmEtPOzXm3fmiWimUWnFz21KewK4bzmM
         +hXfWEGq9b0A9rnKvbqnUHRD0IkWWtmawkTiRcPfQhIvnCTB7XSCmGJZztBKus4TR9zW
         30Zg==
X-Gm-Message-State: ACrzQf2xyxVkiP4ryysVZXn0A+PO12Da3p8Jv/eZhq4Q2Q5Q5fuKZlDq
        ZRPY2NarTsyBoOcDPBUiJGJQ4Q==
X-Google-Smtp-Source: AMsMyM45A6R0pQsdtCOvYDNxlkvuWYbEn7IGIapPLGQF9tCCYOF4+X4vI5Q9/ELGCAp7Mny8hQ8j8Q==
X-Received: by 2002:a05:6512:3d07:b0:498:f201:5679 with SMTP id d7-20020a0565123d0700b00498f2015679mr5098811lfv.161.1664618773150;
        Sat, 01 Oct 2022 03:06:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o12-20020a056512230c00b0049a5a59aa68sm720497lfu.10.2022.10.01.03.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 03:06:12 -0700 (PDT)
Message-ID: <a12831f1-c9ab-357f-f7c9-f04310fbfe72@linaro.org>
Date:   Sat, 1 Oct 2022 12:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
 <20cbd2a2-752e-8537-4cbd-6665ef9afd69@kernel.org>
 <bd024e66-25bb-0463-b346-b110c1b46681@linaro.org>
 <76b5195a-a11c-0c75-b3dd-36aa78c58397@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <76b5195a-a11c-0c75-b3dd-36aa78c58397@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 17:18, Dinh Nguyen wrote:
> 
> 
> On 9/29/22 09:38, Krzysztof Kozlowski wrote:
>> On 29/09/2022 16:20, Dinh Nguyen wrote:
>>>>
>>>> So this change will not be backwards compatible with existing DTBs. I
>>>> noticed that patch2 updates the DTS files for the arm64 platforms, but
>>>> there seems to be some arm32 platforms too. Isn't this going to be a
>>>> problem?
>>>>
>>>
>>> The arm32 platforms makes the clk-phase adjustment through the clock
>>> driver. There was a discussion when I originally submitted the support
>>> for the arm32 platforms, and we landed on going through the clock driver
>>> instead of using the MMC driver. The updates to the arm32 platforms can
>>> be done after this patch series.
>>
>> How the update "can be done after"? Didn't you break all boards in- and
>> out-of-tree?
>>
> 
> I don't think so! At least, I don't see how, for the arm32 boards, here 
> are the dts entry for setting the clock-phase:
> 
> sdmmc_clk: sdmmc_clk {
> 	#clock-cells = <0>;
> 	compatible = "altr,socfpga-gate-clk";
> 	clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>,<&per_nand_mmc_clk>;
> 	clk-gate = <0xa0 8>;
> 	clk-phase = <0 135>;   <-----

It's different node...

> };
> 
> sdmmc_clk_divided: sdmmc_clk_divided {
> 	#clock-cells = <0>;
> 	compatible = "altr,socfpga-gate-clk";
> 	clocks = <&sdmmc_clk>;
> 	clk-gate = <0xa0 8>;
> 	fixed-divider = <4>;
> 	};
> 
> ...
> mmc: dwmmc0@ff704000 {
> 	compatible = "altr,socfpga-dw-mshc";
> 	reg = <0xff704000 0x1000>;
> 	interrupts = <0 139 4>;
> 	fifo-depth = <0x400>;
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	clocks = <&l4_mp_clk>, <&sdmmc_clk_divided>;
> 	clock-names = "biu", "ciu";
> 	resets = <&rst SDMMC_RESET>;
> 	status = "disabled";

And this one does not have clk-phase-sd-hs

> 	};
> 
> 
> So the setting for the clk-phase is done in the clock driver, 
> (drivers/clk/socfpga/clk-gate.c). This has been done many years now, 
> before the clk-phase-hs-sd concept was added to the sdmmc driver.

Yes and the driver now requires clk-phase-sd-hs or altr,sysmgr-syscon
which is not present in DTS.

> 
> When I originally submitted the patches for the ARM64 clock driver 
> support, I forgot to add the clk-phase support for the SD controller. 
> Now that I realized we needed it, the concept to set the clk-phase is in 
> the SD driver, thus I'm just adding the support for arm64.
> 
> The arm32 support does not change in any way, so I don't see how it will 
> break it.

Isn't your driver returning ERRNO for all existing DTS (so without patch
#2) and for all out of tree DTS?

> 
> I can update the arm32 support with the same function in patch3 after 
> this series. Because updating the arm32 will require me to remove the 
> support in the clock driver, thus, I want to break it out.


Best regards,
Krzysztof

