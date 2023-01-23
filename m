Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F266786D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjAWTus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjAWTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:50:04 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F526591
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:50:01 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h10so9929926qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGE93gPkAvU6p1g6zMI0ZGEEXbMUYmA6Yp6gqSuvvww=;
        b=JC7Ly8pZDPQTNo3K1tQHv+sSYUXo//MGnfsKJgowshH4fueBckQk0UMvGHMjxH6f5+
         7f18QnmMsJ7SZnBI4yNFw/69kxVaralcZtCpLimACvpSfTVeP3ymesdBwdbPZvUEwpnV
         mw59hgJ1P4k0KWyYwxp9/szWNZ6AZZIWacpC6/SXXH524y84tXbrwsltUjuiFP0HORFd
         BascxnfgUZWEui4L5G2GnqnpQirCorVXlsSXXeitcLdSJ/itjcyRvT2w2oX4Exuegi7N
         as/sQTcUgVr7VR3BO7xnQXs8Xi0OQUxF9SS8TigQVQDj0iPUDa7UUAaKmwktKTmr+emu
         0H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGE93gPkAvU6p1g6zMI0ZGEEXbMUYmA6Yp6gqSuvvww=;
        b=VrXdIxwWQ58Yrd1kcaV4L8fMPusCwXb25F56ea5/svg7O5wFbjRPyW+PPBtgAaj9Y+
         zccwwwVNfkU78AedKSvfgeNAY+fH8rGc+48HK5yQv2KfnFmIQfmVeqGyXZ8NHGcEqfhK
         THH/Tc1LziMOt1pntZJBzDp1rLZgawAEE3xOnnDBPIMKYSpdnrknrbkTtMn9RLY3rTu9
         nfgYPXT+Yt0y/MWIFpNbg9cefQn1rKMWAnrpxBmJTMaKyBCBXrmyFx4qD62f7JSl7Uc9
         gIcHB0X0XBlJNChh5Gkxe1bzVmW5K07o6cX5IIy9xM/cqDvojJW9MqEyY+GR/9E4MVIv
         d0sA==
X-Gm-Message-State: AFqh2kqJnmcLoSp6nyoxKNXauWEO1A+gUAYQg6atuJAdTMpMqkRcDRqT
        3sbSYZclncvz/qMfVRQ9eFNNew==
X-Google-Smtp-Source: AMrXdXvZjnmLfOqTE0yM40ZLDkWU26o0u88ybKg/YPkagVEAyWBdG8miScE/MquEbFPqLcKaW6B8fQ==
X-Received: by 2002:a05:6214:5f09:b0:4c7:5b:75ba with SMTP id lx9-20020a0562145f0900b004c7005b75bamr45249216qvb.31.1674503401130;
        Mon, 23 Jan 2023 11:50:01 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 198-20020a3705cf000000b006fed58fc1a3sm24016qkf.119.2023.01.23.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:50:00 -0800 (PST)
Message-ID: <2517e0aef49a934efa7c1a90e32fa811d060771d.camel@ndufresne.ca>
Subject: Re: [PATCH RESEND 0/2] media: rockchip: rga: Add rk3568 support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Date:   Mon, 23 Jan 2023 14:49:59 -0500
In-Reply-To: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
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

Hi Micheal,

Le vendredi 20 janvier 2023 =C3=A0 10:14 +0100, Michael Tretter a =C3=A9cri=
t=C2=A0:
> The RGA2 on the Rockchip rk3568 is the same core as the RGA2 on the Rockc=
hip
> rk3288.
>=20
> This series adds the necessary device tree binding and node in the device=
 tree
> to enable the RGA2 on the Rockchip rk3568.
>=20
> I tested the driver with the GStreamer v4l2convert element on a Rock3 Mod=
el A
> board.
>=20
> This is a RESEND including the linux-media list, as Heiko asked for an
> Acked-by from someone from media.

I don't think there will be any concern about this on media side.

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
>=20
>=20
> Michael
>=20
> To: Jacob Chen <jacob-chen@iotwrt.com>
> To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>=20
> ---
> Michael Tretter (2):
>       media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
>       arm64: dts: rockchip: Add RGA2 support to rk356x
>=20
>  Documentation/devicetree/bindings/media/rockchip-rga.yaml |  4 +++-
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi                  | 11 +++++++++=
++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> ---
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> change-id: 20230119-rk3568-rga-d1b0cccc7b82
>=20
> Best regards,

