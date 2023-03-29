Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096296CF186
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjC2R5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2R5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C5A6;
        Wed, 29 Mar 2023 10:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8584761D60;
        Wed, 29 Mar 2023 17:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B73C433EF;
        Wed, 29 Mar 2023 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680112656;
        bh=BMoNbmsfNfOkhi4yfXSxjV/u4Ku/ne70lJ45WdOhIak=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=tPxX9AwvmGxPoycDrTNASDSW2TYQKIfoY3al4wIpwboHI/R/TPM2nfBUDbtTLl6JT
         i3WucSNoU9cAJ59zceMPQMlOkilhk5QsY3nB1XIgA6Ba7/Dp/CU7N4qDxZ8xuWBQDy
         PQHhNkXUmKj+tavQ0hvXdWZwPJVnxmWNVwrYTix2ywq/MNJHl/VYQSNGx9+uF1K02L
         JNm2Uy+9bGxJDcARduByqbWQbt2xBM1QU6yUNtRoRa0A0kM2nrKTt7i5OCg65pD/JL
         vZqH2I5M42SztBj6lsOqfdkVOqlgXUgsQN+CwDlsQ4GdnxSdGm1HfHUO52xqPTrUgI
         cNnnmbCoUxp6w==
Message-ID: <1125013051e5f6578fde8aa006c9bcbd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <41d84c24-a363-7f73-1590-c23cc2ecbdc5@quicinc.com>
References: <20230327163249.1081824-1-quic_mohs@quicinc.com> <20230327163249.1081824-5-quic_mohs@quicinc.com> <f2fa0b0813b26c0eb1893ef4c4c4c672.sboyd@kernel.org> <41d84c24-a363-7f73-1590-c23cc2ecbdc5@quicinc.com>
Subject: Re: [PATCH v1 4/4] clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock registration
From:   Stephen Boyd <sboyd@kernel.org>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        quic_visr@quicinc.com, robh+dt@kernel.org, swboyd@chromium.org
Date:   Wed, 29 Mar 2023 10:57:34 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-29 02:24:43)
>=20
> The main issue with sc7280.dtsi file.
>=20
> Required to upstream remoteproc_adsp node for audioreach adsp based=20
> solution.
> The base address for remoteproc_adsp dts node is 0x3000000.
>=20
> Please refer below link audioreach dts patch:
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1675700201-12890=
-4-git-send-email-quic_srivasam@quicinc.com/
>=20
> remoteproc_adsp: remoteproc@3000000 {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 compatible =3D =
"qcom,sc7280-adsp-pil";
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D <0 0x03=
000000 0 0x5000>, <0 0x0355b000 0 0x10>;
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg-names =3D "=
qdsp6ss_base", "lpass_efuse";
>=20
> and in sc7280.dtsi lpasscc node base address also same.
>=20
> lpasscc: lpasscc@3000000 {
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 compatible =3D =
"qcom,sc7280-lpasscc";
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =3D <0 0x03=
000000 0 0x40>,
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0 0x03c04000 0 0x4>,
>=20
> In single dtsi file should not have same physical address node.
> Required to sort the nodes based on physical address.

Yes the same address shouldn't be used twice, but it still compiles,
right? The node name is different, remoteproc vs. clock-controller, so
it should work for the interim while the qcom,sc7280-lpasscc-2 binding
is written that only has one reg property.

I'm suggesting you don't change the existing binding. Instead, deprecate
the compatible and add a new compatible for the binding that omits the
second reg property. Then the driver patch can work with old and new dts
files.
