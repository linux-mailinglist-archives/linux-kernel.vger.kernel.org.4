Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9731D5EF881
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiI2PSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiI2PS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:18:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1A14F805;
        Thu, 29 Sep 2022 08:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6B64B824B7;
        Thu, 29 Sep 2022 15:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1235C433C1;
        Thu, 29 Sep 2022 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664464705;
        bh=yGsaOq9kyzvgGji/8EN1OKXb4Lsu/CQzHqSAuKNquJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rlop4KQiRbV4FLf3OtbnMhWNrGyei2AYFTiwHCsZCysnV2HV0hIg09ZsBiP7eWedX
         KJjhFhhMQNfaqSQBQqqp6+hKBJqmw9ejR3tlSdILRiof25BoPkfVO7p7qd2auPI0pk
         kISeVPEr/gW+N6LZ/UmetUeWt3hddSlb9cmkmmDLtq+qGbDyALCCoIe8mCRLLHaJhS
         KtOVzBnqpd5pP8wAxUaSQSQnrzLA2wHow/qMxqG8QOC4onC2VARuGrk9Q35QE0Y4l1
         iRIRx5OvqAJB4swQr/dkxE4kJwwfu56CwLhSd3nLcHu54TDA9ZIL6vhc5rYDX0BgkT
         NnE2UMgyMBwTg==
Message-ID: <76b5195a-a11c-0c75-b3dd-36aa78c58397@kernel.org>
Date:   Thu, 29 Sep 2022 10:18:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
 <20cbd2a2-752e-8537-4cbd-6665ef9afd69@kernel.org>
 <bd024e66-25bb-0463-b346-b110c1b46681@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <bd024e66-25bb-0463-b346-b110c1b46681@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 09:38, Krzysztof Kozlowski wrote:
> On 29/09/2022 16:20, Dinh Nguyen wrote:
>>>
>>> So this change will not be backwards compatible with existing DTBs. I
>>> noticed that patch2 updates the DTS files for the arm64 platforms, but
>>> there seems to be some arm32 platforms too. Isn't this going to be a
>>> problem?
>>>
>>
>> The arm32 platforms makes the clk-phase adjustment through the clock
>> driver. There was a discussion when I originally submitted the support
>> for the arm32 platforms, and we landed on going through the clock driver
>> instead of using the MMC driver. The updates to the arm32 platforms can
>> be done after this patch series.
> 
> How the update "can be done after"? Didn't you break all boards in- and
> out-of-tree?
> 

I don't think so! At least, I don't see how, for the arm32 boards, here 
are the dts entry for setting the clock-phase:

sdmmc_clk: sdmmc_clk {
	#clock-cells = <0>;
	compatible = "altr,socfpga-gate-clk";
	clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>,<&per_nand_mmc_clk>;
	clk-gate = <0xa0 8>;
	clk-phase = <0 135>;   <-----
};

sdmmc_clk_divided: sdmmc_clk_divided {
	#clock-cells = <0>;
	compatible = "altr,socfpga-gate-clk";
	clocks = <&sdmmc_clk>;
	clk-gate = <0xa0 8>;
	fixed-divider = <4>;
	};

...
mmc: dwmmc0@ff704000 {
	compatible = "altr,socfpga-dw-mshc";
	reg = <0xff704000 0x1000>;
	interrupts = <0 139 4>;
	fifo-depth = <0x400>;
	#address-cells = <1>;
	#size-cells = <0>;
	clocks = <&l4_mp_clk>, <&sdmmc_clk_divided>;
	clock-names = "biu", "ciu";
	resets = <&rst SDMMC_RESET>;
	status = "disabled";
	};


So the setting for the clk-phase is done in the clock driver, 
(drivers/clk/socfpga/clk-gate.c). This has been done many years now, 
before the clk-phase-hs-sd concept was added to the sdmmc driver.

When I originally submitted the patches for the ARM64 clock driver 
support, I forgot to add the clk-phase support for the SD controller. 
Now that I realized we needed it, the concept to set the clk-phase is in 
the SD driver, thus I'm just adding the support for arm64.

The arm32 support does not change in any way, so I don't see how it will 
break it.

I can update the arm32 support with the same function in patch3 after 
this series. Because updating the arm32 will require me to remove the 
support in the clock driver, thus, I want to break it out.

Dinh




