Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA4D6FD7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjEJG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjEJG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:58:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8065AA;
        Tue,  9 May 2023 23:58:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D594E547;
        Wed, 10 May 2023 08:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683701913;
        bh=wKVr1locEFsxOBccteNejWE1+GEN4PEuEBpf3bfDlmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/QpRh83DbMyolA8zVLS0gIWkj00asNkPebM17+tnWLSGKmC5fzrJ6oCV74IEwlRO
         GoXrXjFH9WYc50IGQsnkG6czDdLkrEaUKu7IvLM5rDd31YdHZR2lJy7iteLmHXkNku
         QIFz9C8qyuQ/S2rGsMSCOEm7vgmu/g4OTbAOPbWo=
Date:   Wed, 10 May 2023 09:58:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/23] arm64: zynqmp: Sync node name address with reg
 (mailbox)
Message-ID: <20230510065835.GE11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <5d8e80383912b8ff75409764efb75f3b85917087.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d8e80383912b8ff75409764efb75f3b85917087.1683034376.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:34PM +0200, Michal Simek wrote:
> Address in node name should match with the first reg property in DT.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index c2d80c7967e9..61c7045eb992 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -135,7 +135,7 @@ zynqmp_ipi: zynqmp_ipi {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		ipi_mailbox_pmu1: mailbox@ff990400 {
> +		ipi_mailbox_pmu1: mailbox@ff9905c0 {
>  			reg = <0x0 0xff9905c0 0x0 0x20>,
>  			      <0x0 0xff9905e0 0x0 0x20>,
>  			      <0x0 0xff990e80 0x0 0x20>,

-- 
Regards,

Laurent Pinchart
