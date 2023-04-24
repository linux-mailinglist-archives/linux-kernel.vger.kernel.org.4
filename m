Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A36EC3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDXC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:59:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BD18C;
        Sun, 23 Apr 2023 19:59:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2478485fd76so2731976a91.2;
        Sun, 23 Apr 2023 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682305163; x=1684897163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDVbfdA1Byb3adLSZmoHUuZbEggT7Bxo54ij5TOkI7k=;
        b=RQ2T7jBKwF+2UhIdUGTTxznzyfqSMdFXFcgrpnSrjcSjfAKoUlgHhYmQJbue4izvo2
         S6zqlJNhKCG3/kmAhnnwZRDlTWSwq0vmw9oCrxPVjCDYsvHcT5BQAbyO/PLWngS2IyWO
         Jsza3gC/GUvV07c7IulxcwGzPbguI4aAT12nQtZqR/aoQjkIvJr1HqGNOLIRkjhvHaGq
         wKwrZCCrYiYyPOu6GjgQTbw42R42QElZZwrTLiJgT/+tsdpA93b0vItQZS+aSMGDNQqd
         G6eMEgOdSjEIWQ7JUoLEUohxzkvic4DhDiIEcBCDxZ3AES25u+UdaMTHGvAjfzRXRfDa
         oDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682305163; x=1684897163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDVbfdA1Byb3adLSZmoHUuZbEggT7Bxo54ij5TOkI7k=;
        b=i5oMrQVRy9ZJuy8yRp9o/ay1SJlANCHUCXDwBAlQ7Q64ZtYKaKlnU2PHEKVB9Jrxsa
         sRjf7NERrHmAomsZ9IcpLDDSySkMiOAjpPo5f9WGyZhj28RVGlWcwoHphYIfZKUyG7hu
         LYjZzeGakesPDI1Vby6eDOKANfYyMeoiqf3dWDtqA8PoeLCLNwWTuKv/fDZwg1VsdQbv
         Mh3ni0DLEcba/oBGItoJ5xkc1xxV4WHazuwsaFty/+i3TeCaOSqVvbYhiN5xKP7f8d8j
         AQJ+3H+O3b5qbuLt3ePgX873CWLyHfDDTpmdSsRghFIdW9UzbGa0T5t3iqmDcrNcMZpp
         8UCg==
X-Gm-Message-State: AAQBX9egSMgoejPb8d2Ps/8KauE2H0h9Cfo3XUTApt+fn85A+Pjiln8S
        mHkKsdb7yFtiUSdlrAoXMpLBmAD+63CE56h6MV4=
X-Google-Smtp-Source: AKy350ZyhY2GCJ4RhqH8dHoZ5LwxPKEVmJCSxstOe6TI8Ls+gszI92/4VN38xFwoAugbQMcTCE+GS/1Q0muLC3ScQ/U=
X-Received: by 2002:a17:90a:8589:b0:249:7224:41cb with SMTP id
 m9-20020a17090a858900b00249722441cbmr13023418pjn.31.1682305162905; Sun, 23
 Apr 2023 19:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230423212656.1381002-1-aford173@gmail.com> <20230424004706.GL21943@pendragon.ideasonboard.com>
 <CAHCN7xKM38RgFW9DAc9co_xcC7NjfymcVEwzu3LMwgYxytCpLA@mail.gmail.com>
In-Reply-To: <CAHCN7xKM38RgFW9DAc9co_xcC7NjfymcVEwzu3LMwgYxytCpLA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 23 Apr 2023 21:59:11 -0500
Message-ID: <CAHCN7xLNeN52vhNt0ampSsMfdGx7L+oc3YhUtrvYv-1imQj9eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Enable CSI and ISI Nodes
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 9:22=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Sun, Apr 23, 2023 at 7:46=E2=80=AFPM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Adam,
> >
> > Thank you for the patch.
> >
> > On Sun, Apr 23, 2023 at 04:26:55PM -0500, Adam Ford wrote:
> > > The CSI in the imx8mn is the same as what is used in the imx8mm,
> > > but it's routed to the ISI on the Nano. Add both the ISI and CSI
> > > nodes, and pointing them to each other. Since the CSI capture is
> > > dependent on an attached camera, mark both ISI and CSI as
> > > disabled by default.
> >
> > I'd then write the subject line as "Add CSI and ISI nodes".
>
> That makes sense, especially since I disabled them by default.
> >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/b=
oot/dts/freescale/imx8mn.dtsi
> > > index 8be8f090e8b8..102550b41f22 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > @@ -1104,6 +1104,24 @@ dsim_from_lcdif: endpoint {
> > >                               };
> > >                       };
> > >
> > > +                     isi: isi@32e20000 {
> > > +                             compatible =3D "fsl,imx8mn-isi";
> > > +                             reg =3D <0x32e20000 0x100>;
> >
> > The i.MX8MN reference manual documents the ISI registers block size to
> > be 64kB. Should we use the same here, even if all the registers we need
> > are within the first 256 bytes ?
>
> I can do that.

There is a typo in the Nano Ref Manual.  Even though the table in
"Table 2-6. AIPS4 Memory Map" reads 64K, the DISPLAY_BLK_CTRL starts
at 32e2_8000.  The largest size we can do is 0x8000 (32k)

> >
> > > +                             interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEV=
EL_HIGH>;
> > > +                             clocks =3D <&clk IMX8MN_CLK_DISP_AXI_RO=
OT>,
> > > +                                      <&clk IMX8MN_CLK_DISP_APB_ROOT=
>;
> > > +                             clock-names =3D "axi", "apb";
> > > +                             fsl,blk-ctrl =3D <&disp_blk_ctrl>;
> > > +                             power-domains =3D <&disp_blk_ctrl IMX8M=
N_DISPBLK_PD_ISI>;
> > > +                             status =3D "disabled";
> > > +
> > > +                             port {
> > > +                                     isi_in: endpoint {
> > > +                                             remote-endpoint =3D <&m=
ipi_csi_out>;
> > > +                                     };
> > > +                             };
> >
> > This will fail to validate against the ISI DT binding, as they require =
a
> > "ports" node. When a single port is present using a "port" node directl=
y
> > is fine from an OF graph point of view, but to avoid too much complexit=
y
> > in the ISI binding the consensus was to always require a "ports" node
> > for the ISI.
>
>
> Argh!  I pulled from the wrong test repo.  I remember the discussion
> from a few months back.  I'll fix it and the others when I submit V2.

It appears that using ports still throws warnings:

arch/arm64/boot/dts/freescale/imx8mn.dtsi:1118.11-1128.7: Warning
(graph_child_address): /soc@0/bus@32c00000/isi@32e20000/ports: graph
node has single child node 'port@0', #address-cells/#size-cells are
not necessary

I'll leave it like this because we were told to do so.

adam
>
> >
> > > +                     };
> > > +
> > >                       disp_blk_ctrl: blk-ctrl@32e28000 {
> > >                               compatible =3D "fsl,imx8mn-disp-blk-ctr=
l", "syscon";
> > >                               reg =3D <0x32e28000 0x100>;
> > > @@ -1147,6 +1165,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> > >                               #power-domain-cells =3D <1>;
> > >                       };
> > >
> > > +                     mipi_csi: mipi-csi@32e30000 {
> > > +                             compatible =3D "fsl,imx8mm-mipi-csi2";
> > > +                             reg =3D <0x32e30000 0x1000>;
> > > +                             interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEV=
EL_HIGH>;
> > > +                             assigned-clocks =3D <&clk IMX8MN_CLK_CA=
MERA_PIXEL>,
> > > +                                               <&clk IMX8MN_CLK_CSI1=
_PHY_REF>;
> > > +                             assigned-clock-parents =3D <&clk IMX8MN=
_SYS_PLL2_1000M>,
> > > +                                                       <&clk IMX8MN_=
SYS_PLL2_1000M>;
> > > +                             assigned-clock-rates =3D <333000000>;
> > > +                             clock-frequency =3D <333000000>;
> > > +                             clocks =3D <&clk IMX8MN_CLK_DISP_APB_RO=
OT>,
> > > +                                      <&clk IMX8MN_CLK_CAMERA_PIXEL>=
,
> > > +                                      <&clk IMX8MN_CLK_CSI1_PHY_REF>=
,
> > > +                                      <&clk IMX8MN_CLK_DISP_AXI_ROOT=
>;
> > > +                             clock-names =3D "pclk", "wrap", "phy", =
"axi";
> > > +                             power-domains =3D <&disp_blk_ctrl IMX8M=
N_DISPBLK_PD_MIPI_CSI>;
> > > +                             status =3D "disabled";
> > > +
> > > +                             ports {
> > > +                                     #address-cells =3D <1>;
> > > +                                     #size-cells =3D <0>;
> > > +
> > > +                                     port@0 {
> > > +                                             reg =3D <0>;
> > > +                                     };
> > > +
> > > +                                     port@1 {
> > > +                                             reg =3D <1>;
> > > +
> > > +                                             mipi_csi_out: endpoint =
{
> > > +                                                     remote-endpoint=
 =3D <&isi_in>;
> > > +                                             };
> > > +                                     };
> > > +                             };
> > > +                     };
> > > +
> > >                       usbotg1: usb@32e40000 {
> > >                               compatible =3D "fsl,imx8mn-usb", "fsl,i=
mx7d-usb", "fsl,imx27-usb";
> > >                               reg =3D <0x32e40000 0x200>;
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
