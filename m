Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7E71579D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE3Hwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE3Hwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:52:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543AA8;
        Tue, 30 May 2023 00:52:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205206011.34.openmobile.ne.jp [126.205.206.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9170A27C;
        Tue, 30 May 2023 09:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685433132;
        bh=KnvDw9sNiNP3DyTfZRaL2+6QBTeVToFZu9acKww5o4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy5GKgHeTgVib4AtSpZ/WBvSfvItBLLWFzNvRx4DP0aOHuBbiqmNzV7vsW+6Uy/uP
         8toQ5jGanMObTd6jCCo7fyo+XaE1ypMGJUb0PesFFMqhqXdY1p9xRLs+rg9771LB7x
         RbZMSUEIWzqeQA/ZrP832eqEtVuxzmrTPMPmxzys=
Date:   Tue, 30 May 2023 10:52:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: zynqmp: Switch to amd.com emails
Message-ID: <20230530075233.GD6865@pendragon.ideasonboard.com>
References: <80baafe923977bcfc4001dc5016de0731c1bf38e.1684766863.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80baafe923977bcfc4001dc5016de0731c1bf38e.1684766863.git.michal.simek@amd.com>
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

On Mon, May 22, 2023 at 04:48:00PM +0200, Michal Simek wrote:
> Update my and DPs email address to match current setup.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Remove all copyright changes
> - Fix DPs name
> 
>  arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 4 ++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 4 ++--
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 2 +-
>  24 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> index 88aa06fa78a8..4c1bd69e7553 100644
> --- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> +++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2018, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 719ea5d5ae88..f04716841a0c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -5,7 +5,7 @@
>   * (C) Copyright 2017 - 2022, Xilinx, Inc.
>   * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index bebbe955eec1..669fe6084f3f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -9,7 +9,7 @@
>   * "Y" - A01 board modified with legacy interposer (Nexperia)
>   * "Z" - A01 board modified with Diode interposer
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 8e66448f35a9..7886a19139ee 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2020 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 464e28bf078a..c1ab1ab690df 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2020 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> index c70966c1f344..85b0d1677240 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2020 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include "zynqmp-sm-k26-revA.dts"
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> index f1598527e5ec..48d6a7202406 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2017 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> index 04efa1683eaa..e80484f9b137 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> @@ -4,8 +4,8 @@
>   *
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> - * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
> + * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index f89ef2afcd9e..1a7995ee62ce 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 868ca655a220..869b733a0634 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> index 381cc682cef9..38b0a312171b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2016 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> index 6e0106bf1294..05be71eab722 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> index ae2d03d98322..5ccb343df4fb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> @@ -5,7 +5,7 @@
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>

Shouldn't this address be updated too ? You're using @amd.com above and
below.

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 70c48079575d..544801814bd5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2016 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   * Nathalie Chan King Choy
>   */
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> index 6647e97edba3..c8f71a1aec89 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2016 - 2018, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include "zynqmp-zcu102-revB.dts"
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
> index b6798394fcf4..705369766a55 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2016 - 2020, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include "zynqmp-zcu102-rev1.0.dts"
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index d600eeb5b2b7..230ef94d5dcb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> index f7d718ff116b..63419deb5b33 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2016 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  #include "zynqmp-zcu102-revA.dts"
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 473fae564906..d178a4f898c9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2017 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index c8ba9ed157be..38b11594c074 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2017 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 09773b7200f8..8af0879806cf 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2016 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index e0305dcbb010..f76687914e30 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2017 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
> index 4874e0ad914e..e615286b8eff 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
> @@ -4,8 +4,8 @@
>   *
>   * (C) Copyright 2017 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> - * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
> + * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 850b497d7a81..a961bb6f31ff 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2014 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as

-- 
Regards,

Laurent Pinchart
