Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2956CF460
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjC2UTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2UTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:19:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FA4ED5;
        Wed, 29 Mar 2023 13:19:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TKJYro047752;
        Wed, 29 Mar 2023 15:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680121174;
        bh=T+Eko+LLwZmsGd120Z+3Lj9F1hIzzlrX0hwtefoHhpw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AkSpg4dwQ0o+NnHt6qWUFm7i/Oh/O0SCDZDY1zxM9usBpUECpx21wdCoIHkuFTD9P
         wbLSWN/rLzeMmp003zvxBImG7hyX5sChYqjaXHodp0Xt4nClhtW4ER3s04U14sPD3S
         qA6MV02JIBsQ7yz43A5YVFgsfyGruOv9kU6UFNlw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TKJYOw010119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 15:19:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 15:19:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 15:19:34 -0500
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TKJYRY021351;
        Wed, 29 Mar 2023 15:19:34 -0500
Message-ID: <48c03b5a-6557-9eee-8b85-24d72cfbfcd1@ti.com>
Date:   Wed, 29 Mar 2023 15:19:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add MAIN domain R5F
 cluster nodes
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230329093627.30719-1-hnagalla@ti.com>
 <20230329093627.30719-2-hnagalla@ti.com>
 <20230329125247.w45k5fjzmcgjdyso@delicate>
Content-Language: en-US
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20230329125247.w45k5fjzmcgjdyso@delicate>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 07:52, Nishanth Menon wrote:
>>      MAIN R5FSS0 Core0: j784s4-main-r5f0_0-fw (both in LockStep and Split modes)
>>      MAIN R5FSS0 Core1: j784s4-main-r5f0_1-fw (needed only in Split mode)
>>      MAIN R5FSS1 Core0: j784s4-main-r5f1_0-fw (both in LockStep and Split modes)
>>      MAIN R5FSS1 Core1: j784s4-main-r5f1_1-fw (needed only in Split mode)
>>      MAIN R5FSS2 Core0: j784s4-main-r5f2_0-fw (both in LockStep and Split modes)
>>      MAIN R5FSS2 Core1: j784s4-main-r5f2_1-fw (needed only in Split mode)
> Why are the patches split up into main and mcu - if you are adding r5f
> cores, do them as a single patch.
> 
Thought would be cleaner with separated patches for resolving potential 
merge conflicts. But, can combine into one for v2.

 >> +
 >> +	main_r5fss0: r5fss@5c00000 {
 >> +		compatible = "ti,j721s2-r5fss";
 >> +		ti,cluster-mode = <1>;
 >> +		#address-cells = <1>;
 >> +		#size-cells = <1>;
 >> +		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
 >> +			 <0x5d00000 0x00 0x5d00000 0x20000>;
 >> +		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
 >> +
 >> +		main_r5fss0_core0: r5f@5c00000 {
 >> +			compatible = "ti,j721s2-r5f";
 >> +			reg = <0x5c00000 0x00010000>,
 >> +			      <0x5c10000 0x00010000>;
 >> +			reg-names = "atcm", "btcm";
 >> +			ti,sci = <&sms>;
 >> +			ti,sci-dev-id = <339>;
 >> +			ti,sci-proc-ids = <0x06 0xff>;
 >> +			resets = <&k3_reset 339 1>;
 >> +			firmware-name = "j784s4-main-r5f0_0-fw";
 >> +			ti,atcm-enable = <1>;
 >> +			ti,btcm-enable = <1>;
 >> +			ti,loczrama = <1>;
 >> +			status = "disabled";
 > Why are these disabled by default?
Well, the idea is to let the board specific device tree enable needed 
remote core nodes in *-evm/sk.dts and disable by default in SoC device 
tree files by default.
