Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79E6513CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiLSUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLSUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:22:58 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B92E6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:22:55 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g7so9305795qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yPJmhSw0v+DBD18ezfqwoFIbrDfIDYOSBxHcqB6pM8c=;
        b=ufVdqxl3U6xcJrbMBBFjMYH38pbQ8C6rVXD6M9PFyOz3uu0fDzG2Yu6KQZswL9JaGN
         wG7DzfGPl/r6Svs/ipSN7jvEGwxUKQ+00RD6Y3NB9PLWam3zdT9A5/DFNXf+ZUSh6phG
         R/KjqYya3cLAoNHMVJOgasgPmJJwwqPTAcKeg3ILK/9RwmHxbV+XPkvD2IeD2IAn1Qx8
         50Ao/VfcuqqTb2wAk5zUI6HcAmZlPGLhzBR84BQTjH88KnxYvqdbURxEHjUcRLKzNO4J
         QjqAAOSXmpNCyjuqRyc0gmfAZUrvUYejPgcXj5YfNYOm33BCed/ks902Ma8S+VLq2KuK
         gwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPJmhSw0v+DBD18ezfqwoFIbrDfIDYOSBxHcqB6pM8c=;
        b=eVTkxFtNiLVy+/AYBeyk4Bs2nqfUXxSaiz/57uEox+Bg9GHrnTRnQy8SMSWF2K01I9
         nRD8zxsrCdGEt+ibVWrbgPTWdkycHBIq799fHuQ7PvXkd+x3FsxrQ8HB+yiGKTgtQCvX
         SBa21LN7g9E4q3Qe1EYBDkPDrgliCDRsK7mX7jBSmebWCo3kLXs1JcLWeBrBa3nxgxQJ
         8wrWBFGzAL+IfoVztVx6x1OWjCC0H9MvHZCJqlRLhiT1aE3vZt7CXulf6uWb7I3qzUJJ
         CEWDi3ieN3r89n7nuzeBOd7QE0lNTA1QGlKstRPI2K8FSDYPMPIDbePlc0b/JvJsSzhl
         gDgQ==
X-Gm-Message-State: ANoB5pkc/oaNicZI/UOQ0RdsbstROdL3/XkH7kwiVKE8Qe+age5ehJD7
        3OX/P7eQMQD/GWrAg+BZNZeBUw==
X-Google-Smtp-Source: AA0mqf6bgQRtffH6JrJGneylIPV58q03NN7jZ14+JAv/Q5A3ejlRDvtnveprymGmtEXa1aT0ulFYrA==
X-Received: by 2002:a05:622a:1cc5:b0:3a4:bc76:969c with SMTP id bc5-20020a05622a1cc500b003a4bc76969cmr54004924qtb.55.1671481374827;
        Mon, 19 Dec 2022 12:22:54 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id w7-20020ac86b07000000b003a50d92f9b4sm6521847qts.1.2022.12.19.12.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:22:54 -0800 (PST)
Message-ID: <e675cfd9f11f68f95ff7bdc17c64466ab92ddfe1.camel@ndufresne.ca>
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Mon, 19 Dec 2022 15:22:50 -0500
In-Reply-To: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 19 d=C3=A9cembre 2022 =C3=A0 16:56 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> This series implement AV1 stateless decoder for RK3588 SoC.
> The harware support 8 and 10 bits bitstreams up to 7680x4320.
> AV1 feature like film grain or scaling are done by the postprocessor.
> The driver can produce NV12_4L4 and NV12 pixel formats.
> A native 10bits NV12_4L4 format is possible but need more investigation
> to be completly documented and enabled.
>=20
> It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches and
> Sebastian's device-tree patches for RK3588.
>=20
> The full branch can be found here:
> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_deco=
der_v1
>=20
> Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStreamer-A=
V1-V4L2SL-Gst1.0.
> The failing tests are:
> - 10bits bitstream because 10bits output formats aren't yet implemented.
> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
> - tests with resolution < hardware limit (64x64)

Its nice to note that we tested 10bit support by forcing P010 output from t=
he
postprocessor, with all bitstream working except for filmgrain. Hopefully w=
e'll
get 10bit properly sorted out, but we don't think the uAPI have any issues
specifically for 10bit (Mediatek driver does not support 10bit or filmgrain=
).

>=20
> Benjamin
>=20
> Benjamin Gaignard (9):
>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>   media: verisilicon: Add AV1 decoder mode and controls
>   media: verisilicon: Save bit depth for AV1 decoder
>   media: verisilicon: Check AV1 bitstreams bit depth
>   media: verisilicon: Compute motion vectors size for AV1 frames
>   media: verisilicon: Add AV1 entropy helpers
>   media: verisilicon: Add Rockchip AV1 decoder
>   media: verisilicon: Add film grain feature to AV1 driver
>   media: verisilicon: Enable AV1 decoder on rk3588
>=20
>  .../bindings/media/rockchip-vpu.yaml          |    1 +
>  drivers/media/platform/verisilicon/Makefile   |    3 +
>  drivers/media/platform/verisilicon/hantro.h   |    5 +
>  .../media/platform/verisilicon/hantro_drv.c   |   54 +
>  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>  .../platform/verisilicon/hantro_postproc.c    |    3 +
>  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
>  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++++
>  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
>  14 files changed, 8291 insertions(+)
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entro=
pymode.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entro=
pymode.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmg=
rain.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmg=
rain.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw=
_av1_dec.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_re=
gs.h
>=20

