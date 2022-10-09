Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5060E5F8AFA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJILsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJILsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75C72D74F;
        Sun,  9 Oct 2022 04:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 626AF60B9E;
        Sun,  9 Oct 2022 11:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6786C433C1;
        Sun,  9 Oct 2022 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316120;
        bh=RNdMc/upqP/HYJ68heIn2uj20s8Dh7LI83jmdVsUqQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZ5xZ6ARsO2+lgGO0XIhGF+DcKU5XmGYroe3bkUgrjpHzhRQlMjr67ipvsQT8O9S+
         rbFfzIU2zpvzjWzBYstka3bthUJtk13BYsvHYvnmyhXgfIXD+jJGBkG+0vj/08gJog
         q5vynTIGFBkdmuoLwRauWe/+FS8RuB5qd4KNHv7wgQtvt2cJTnvndL02PqiZpjkajF
         Z5/rI+q/PGmtc48QTdXpyFj+Kw9uJj545VmU4e6E/pGISnearvw22uOZYlsauACM+H
         xcEDumiky/Ch50ka9IxHEP8G/JmzcNuCXZcLtvmmE8ieWttBm03W5V3dVYpsirqCVV
         KbHpPBgzc+u8w==
Received: by pali.im (Postfix)
        id 37E697C1; Sun,  9 Oct 2022 13:48:38 +0200 (CEST)
Date:   Sun, 9 Oct 2022 13:48:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-turris-mox: Add missing
 interrupt for RTC
Message-ID: <20221009114838.fsw5xqa3dtntejde@pali>
References: <20220924115826.7891-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924115826.7891-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory: PING

On Saturday 24 September 2022 13:58:26 Pali Rohár wrote:
> MCP7940MT-I/MNY RTC has connected interrupt line to GPIO2_5.
> 
> Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 5840ed129309..802862fe2060 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -125,9 +125,12 @@
>  	/delete-property/ mrvl,i2c-fast-mode;
>  	status = "okay";
>  
> +	/* MCP7940MT-I/MNY RTC */
>  	rtc@6f {
>  		compatible = "microchip,mcp7940x";
>  		reg = <0x6f>;
> +		interrupt-parent = <&gpiosb>;
> +		interrupts = <5 0>; /* GPIO2_5 */
>  	};
>  };
>  
> -- 
> 2.20.1
> 
