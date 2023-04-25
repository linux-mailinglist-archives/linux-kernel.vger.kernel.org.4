Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F46EE136
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjDYLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjDYLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87B72A9;
        Tue, 25 Apr 2023 04:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561F562BA2;
        Tue, 25 Apr 2023 11:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D99BC433D2;
        Tue, 25 Apr 2023 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682423127;
        bh=lhPUiRP8Ufw0OGb0XCGRithOUfaDqWV6hZnqnru0Z/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kHOoY2zhDR/X9kyFZnm4TQwF96PgPyqzZIRccbxRf2F/TxAl7nX1e7JN6z/Og8f4J
         NrUCLKEdOCpLKvDwjhJtTuFY5A3uBlsMQt8ivu5T3ERC6wAEXpjKZmJXh0nJCBq+lW
         C245lvfwCfzgG7paUXNuDXqvPBueOaN/dDcuA/stWsZBp1NekvoZfCE6oyH3kZOQP9
         sA/sx2oYl/blgfgkZeBp1mIgRPBWChpBAybJtcUDEvNESytK2Uh5bzHysKij5bV9Mh
         vPxiJaYfutwYGEs2l0mEJSsowHyIwh5XjrZeKkAbrXdxEog4KKAVH+QBkm4DqxNRyB
         0XoPjT0kh/UGg==
Message-ID: <86ab17b2-d35a-16e2-7791-9e7a13c8e632@kernel.org>
Date:   Tue, 25 Apr 2023 14:45:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v14 4/8] arm64: dts: ti: k3-j721s2-common-proc-board:
 Enable SERDES0
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, afd@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        vaishnav.a@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
 <20230331090028.8373-5-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230331090028.8373-5-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/03/2023 12:00, Ravi Gunasekaran wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Configure first lane to PCIe, the second lane to USB and the last two lanes
> to eDP. Also, add sub-nodes to SERDES0 DT node to represent SERDES0 is
> connected to PCIe.

Is USB0 expected to work in super-speed on this board?
If yes then you need to add USB0 lane information as well.
Otherwise please ignore my comment.

> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> I had reviewed this patch in the v5 series [0].
> Since I'm taking over upstreaming this series, I removed the self
> Reviewed-by tag.
> 
> [0] - https://lore.kernel.org/all/71ce4ecd-2a50-c69d-28be-f1a8d769970e@ti.com/
> 
> changes from v13:
> * No changes. Only rebased on top of linux-next
> 
> Changes from v12:
> * Removed enabling of "serdes_wiz" node that is already enabled in [2/8]
>   in this version
> 
> Changes from v11:
> * No change
> 
> Changes from v10:
> * Removed Link tag from commit message
> 
> Changes from v9:
> * Enabled serdes related nodes
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
> index b4b9edfe2d12..1afefaf3f974 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -9,6 +9,9 @@
>  
>  #include "k3-j721s2-som-p0.dtsi"
>  #include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/mux/ti-serdes.h>
>  
>  / {
>  	compatible = "ti,j721s2-evm", "ti,j721s2";
> @@ -322,6 +325,26 @@
>  	phy-handle = <&phy0>;
>  };
>  
> +&serdes_ln_ctrl {
> +	idle-states = <J721S2_SERDES0_LANE0_PCIE1_LANE0>, <J721S2_SERDES0_LANE1_USB>,
> +		      <J721S2_SERDES0_LANE2_EDP_LANE2>, <J721S2_SERDES0_LANE3_EDP_LANE3>;
> +};
> +
> +&serdes_refclk {
> +	clock-frequency = <100000000>;
> +};
> +
> +&serdes0 {
> +	status = "okay";
> +	serdes0_pcie_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +		resets = <&serdes_wiz0 1>;
> +	};
> +};
> +
>  &mcu_mcan0 {
>  	status = "okay";
>  	pinctrl-names = "default";

cheers,
-roger
