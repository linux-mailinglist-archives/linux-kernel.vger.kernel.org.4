Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226563DAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiK3Qap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiK3Qag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:30:36 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F884DEC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:30:33 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-381662c78a9so176446507b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1KePKFD5wUleBsUGiUAfFEL2WjX4h155nTTvycN3Go=;
        b=xgppepmDN4Sn1z3cCq1ItxvjJIjEgwHQYcS+TDUIDxyBXV5+5+dCGK2/I9HUQ27SXE
         aZFQ9yML8RJP3Jf5GWx7B5tIMt3+GgFpAmT7jg/rr8UI+Ntu45pvBmgkRPHRkmv+xQTe
         DK+H8hVJxRqkUjB2PPsfdYuvg7/9HDBBQHyTS5lU0HkLY2QXrCHxwNz00uUI6ALhdxqy
         uF+efwlOBUgZ/O2QDeynsMFSVBZiPG9i7vJZMsqYfqFNWZ0i0Il/AbIt40rYtg8apnGH
         F8DJHqHbF/BF0L25zV+OmnlGyhlNKODsILpXNnkokzV4PiRnWtoWsyqPtSHWi7ewKc2I
         Wo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1KePKFD5wUleBsUGiUAfFEL2WjX4h155nTTvycN3Go=;
        b=UEdvGhuMDvJ2bRAXQ3QEwm+X0wN3/PFumHn/w4UVAkkP6GD9/QT8gB9wwlvbv+pRZW
         Jq1V/PJxtCUlJ5ktgl+U9xQw7Nmm/beJ7hosVHoZ0pqj65TjjoHKpOeVZhAW2Y1D6lX0
         ztNqlL6K7qFLO3eRJU3NXAqDfu2ZNPQiodSIyCV4kp+QtHfrryjy4Uv3RS7Fu08nPMjT
         ec9GmQ3495MaUXU4pHiNYGt3xNK5EEKCxxWMWbENL/BOA7/SP83x9VA6Sn0BoQ8ryBmR
         eBYfgJJkIGv3qjETx9zXHCk1MvAC1mvs6LjIcs6SoItpv+nTt6/PYV3aJNOHh+vbWTnW
         NHtg==
X-Gm-Message-State: ANoB5pkpXrEp+BXFLgkH0BJ6Ac4FDlBalbLM5Hv3k/lmlHThilt+o27D
        iPrdC1oTV/NWNZ99gElaSOaFVuqGp8DIXUtC+CPxgEjmuE8=
X-Google-Smtp-Source: AA0mqf7Sh10TxLusp3H5Xs6v8gJQLOHk4kplyBo2pUbEMpqQClf9caUiZQ8J+BLtZM8d8uhcRNdPMPWiUlfv9ZcCgH0=
X-Received: by 2002:a81:910e:0:b0:3cf:723f:32aa with SMTP id
 i14-20020a81910e000000b003cf723f32aamr8401101ywg.309.1669825832547; Wed, 30
 Nov 2022 08:30:32 -0800 (PST)
MIME-Version: 1.0
References: <3297772b58953e4afd91f7a4bd845713e36e1e27.1652713489.git.michal.simek@amd.com>
In-Reply-To: <3297772b58953e4afd91f7a4bd845713e36e1e27.1652713489.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 30 Nov 2022 17:30:21 +0100
Message-ID: <CAHTX3dJ2_0AZ+rVyRTSJt40P7NzWrWDbGXnZPN-5au1jViA-JA@mail.gmail.com>
Subject: Re: [PATCH] arm64: xilinx: Fix opp-table-cpu
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com
Cc:     David Heidelberg <david@ixit.cz>,
        Durga Challa <vnsl.durga.challa@xilinx.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Mounika Grace Akula <mounika.grace.akula@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 16. 5. 2022 v 17:04 odes=C3=ADlatel Michal Simek <monstr@monstr.eu> naps=
al:
>
> OPP table name now should start with "opp-table" and OPP entries
> shouldn't contain commas and @ signs in accordance to the new schema
> requirement.
>
> The same change was done by commit c6d4a8977598 ("ARM: tegra: Rename CPU
> and EMC OPP table device-tree nodes"), commit ffbe853a3f5a ("ARM: dts:
> sunxi: Fix OPPs node name") or commit b7072cc5704d ("arm64: dts: qcom:
> qcs404: Rename CPU and CPR OPP tables").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index f86b92071367..7a332a53815a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -76,7 +76,7 @@ CPU_SLEEP_0: cpu-sleep-0 {
>                 };
>         };
>
> -       cpu_opp_table: cpu-opp-table {
> +       cpu_opp_table: opp-table-cpu {
>                 compatible =3D "operating-points-v2";
>                 opp-shared;
>                 opp00 {
> --
> 2.36.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
