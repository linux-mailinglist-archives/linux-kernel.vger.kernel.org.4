Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92E6EE189
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjDYMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjDYMBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072A055BD;
        Tue, 25 Apr 2023 05:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593F662DD3;
        Tue, 25 Apr 2023 12:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA0C433EF;
        Tue, 25 Apr 2023 12:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682424075;
        bh=FoyA/x6xus9tzAuqlHs02L0mTHeDvM7gvVaIHLuCK8Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=owF/cGnVfoEYCCRCJpAXYBq83PP1ZrJwFH6O0oWXSHh2W8Fl/OzLW8P4xXdMc5xa7
         GFX/PeQ6XI1l1pzAExYBirrtSLtXEyoMNRSOROuft4BEb57zMmMa6TXjxHKGaGazb/
         D50UFqf7SJFkxs9RCuN+gNa3UecN8wpbrvEpG+UFT0XJ/Q4KMF7dGEFpH92Qgl722L
         8QQ/f3UTg+SYQeZetSwO+o4ilje/wvj3vSELbdmz39wBYpS/2YnBuc2xKtBhyz6W7K
         mIu4WqiLf2BDvqGnexotAVj3hShgGUatg74kAHkj+xB8l9k8Tfuk975qP/8bK3KLz9
         vxrn+ZH2J8w9w==
Message-ID: <efe734a5-8d6f-b597-c4fd-bdf0879ed9c4@kernel.org>
Date:   Tue, 25 Apr 2023 15:01:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v14 5/8] arm64: dts: ti: k3-j721s2-common-proc-board: Add
 USB support
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, afd@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        vaishnav.a@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
 <20230331090028.8373-6-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230331090028.8373-6-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2023 12:00, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> The board uses lane 1 of SERDES for USB. Set the mux
> accordingly.
> 
> The USB controller and EVM supports super-speed for USB0
> on the Type-C port. However, the SERDES has a limitation
> that up to 2 protocols can be used at a time. The SERDES is
> wired for PCIe, eDP and USB super-speed. It has been
> chosen to use PCIe and eDP as default. So restrict
> USB0 to high-speed mode.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> I had reviewed this patch in the v5 series [0].
> Since I'm taking over upstreaming this series, I removed the self
> Reviewed-by tag.
> 
> [0] - https://lore.kernel.org/all/96058a13-4903-2b8c-8de2-f37fdfd3672b@ti.com/
> 
> Changes from v13:
> * No changes. Only rebased on top of linux-next
> 
> Changes from v12:
> * No change
> 
> Changes from v11:
> * No change
> 
> Changes from v10:
> * Removed Link tag from commit message
> 
> Changes from v9:
> * Enabled USB nodes
> 
> Changes from v8:
> * No change
> 
> Changes from v7:
> * No change
> 
> Changes from v6:
> * No change
> 
> Changes from v5:
> * Removed Cc tags from commit message
> 
> Changes from v4:
> * No change
> 
> Changes from v3:
> * No change
> 
> Changes from v2:
> * No change
> 
> Changes from v1:
> * No change
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index 1afefaf3f974..5c4ffb8124ca 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -147,6 +147,12 @@
>  			J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
>  		>;
>  	};
> +
> +	main_usbss0_pins_default: main-usbss0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */

What about USB0_ID pin?

> +		>;
> +	};
>  };
>  
>  &wkup_pmx0 {
> @@ -345,6 +351,23 @@
>  	};
>  };
>  
> +&usb_serdes_mux {
> +	idle-states = <1>; /* USB0 to SERDES lane 1 */
> +};
> +
> +&usbss0 {
> +	status = "okay";
> +	pinctrl-0 = <&main_usbss0_pins_default>;
> +	pinctrl-names = "default";
> +	ti,vbus-divider;
> +	ti,usb2-only;
> +};
> +
> +&usb0 {
> +	dr_mode = "otg";
> +	maximum-speed = "high-speed";

Why is super-speed not possible?
I understood that SERDES lane 1 can be used for USB super-speed.

> +};
> +
>  &mcu_mcan0 {
>  	status = "okay";
>  	pinctrl-names = "default";

cheers,
-roger
