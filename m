Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E975B722456
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjFELPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjFELOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:14:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF5CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:14:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97460240863so547249666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685963686; x=1688555686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8//RqwzjIxIP+ALwiHp3sokuN8ZCSiJzLBMoQsY5CE=;
        b=jCU7igTdupcUJCX8E7894HApfv5OytuMuGCk344oPgVFZ2qy2XjEi4kV8ehHubn53E
         EICjwbELmcZAwhIj1+jj52Cgi1eFJw73ZkWAU5AB2PWQ6N6g3hdXMxxO+VagU1Qzr2dB
         Q9jBejz0oWil01ylA+xx7weKsSiEwBKxUykPVTFpE28329jpu5W6o5bqwZ821B62HrJV
         dgrFYWe3+s+2m5g4NOM/o2ExuAva73koW+o6NMks5ZsQtYeeExX+ZhK530+jXpWaFLqY
         PH8CWlsTJqE7xEDy3XNwGAyR0A9uiH7GrIR4LABWq1Yjk67kdsEBeupJfuePJO6Pj7dc
         Mn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963686; x=1688555686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8//RqwzjIxIP+ALwiHp3sokuN8ZCSiJzLBMoQsY5CE=;
        b=EFE5Z7PMWGZPPpTCBHlBpuBYgvTZrJYcnLP1GRM8jldsVqWYsEWPhm8LsY0vfnRuf5
         G5PjS/q5FNxXgU3FinFiyVRXyUSI/Orhsrx4jWhJCpTjFCkTwX4qdW57Dv0ekHmC8Eqq
         S8fcQcJLmtLJJe0WrDaotouVAN6SiFnyScAQ6vrG4AT6wDc5dHTCnzFOJHjUWku1ESaU
         RG4zC+ZGXYS8B87lo0sFPbE+1c8cMDHqu7FgHaSwexCZc0FrrakT6xykTWWxOjmC2Qom
         Q+HE/jFpjWI4SnZwn4Ap9epdaX6VcL4Us1Z5Sj/79wu+JuEPsozuuW9R0PFyV6jIv/yx
         QGSA==
X-Gm-Message-State: AC+VfDwm9thWYytjvFnPIxVoel8IRUfXl3tx4mAm9BL0TkeUoConrnBG
        JSappjGD5i31jUR/4Be9wkzZTIoGSFCn09xmE30cCA==
X-Google-Smtp-Source: ACHHUZ678NhnIwPzwRWzBjPTECqeOS9yeqEJHgl5zI8VGYvxIY3RTrTyMSpnoCmVIzoHLR/YdieCMuKReB33b85Bx0Y=
X-Received: by 2002:a17:907:1c10:b0:961:a67:29c with SMTP id
 nc16-20020a1709071c1000b009610a67029cmr7232081ejc.70.1685963686593; Mon, 05
 Jun 2023 04:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <108cbbbab29e13d386d38a779fd582f10844a030.1685443337.git.michal.simek@amd.com>
In-Reply-To: <108cbbbab29e13d386d38a779fd582f10844a030.1685443337.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 5 Jun 2023 13:14:34 +0200
Message-ID: <CAHTX3d+pU+J2xWiu_1NG1_MM3CuTuNxrcNmv6XRhB8KWt72eRA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: zynqmp: Switch to amd.com emails
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, git@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 30. 5. 2023 v 12:42 odes=C3=ADlatel Michal Simek <michal.simek@amd.=
com> napsal:
>
> Update my and DPs email address to match current setup.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>
> Changes in v3:
> - Add Laurent's reviewed-by line
> - Also convert DP email in xm019 DT
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
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 4 ++--
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
>  24 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm=
64/boot/dts/xilinx/avnet-ultra96-rev1.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/=
boot/dts/xilinx/zynqmp-clk-ccf.dtsi
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/=
arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/=
arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> index ae2d03d98322..b1e933b8a2cd 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> @@ -4,8 +4,8 @@
>   *
>   * (C) Copyright 2015 - 2021, Xilinx, Inc.
>   *
> - * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
> - * Michal Simek <michal.simek@xilinx.com>
> + * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
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
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
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
> --
> 2.36.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
