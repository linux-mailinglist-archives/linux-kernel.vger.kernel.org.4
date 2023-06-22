Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD173A5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjFVQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjFVQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:10:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654D1BF0;
        Thu, 22 Jun 2023 09:10:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-553b2979fceso2281392a12.3;
        Thu, 22 Jun 2023 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687450206; x=1690042206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmTEYMEORosWT3g8FeP7BMzLvgLTEsW/HH8xExKw8yE=;
        b=S0vfIew63z49OKINjcENT8D/SoYwUq2hV4c3eSqksmi3DTHy0qmNKl397nZhlw5PzS
         FGPE5UHJw8yoHeGFcswaz/uTWC9lQzJ8BQ5MCaOW6fNQv8napx8hh5CBvnxVW/UNgPOx
         4OGieWVui/vWgj6i0iGd2VDd5eIWwbHVuJ2iXWV7TmMUdlKyqwlzTAoZ4F1gRq1CwwqH
         GSzbYRniN6gmBGdIgCg3541O+d14BV47dVM4htepfGQWNhfdi7YJ7f1tPwZCXW6HqU73
         HbZ44zfEDEQINpiEuIdJYTBitj2vyXBhfyx3x029qVZ+qsQiQO4/8kVoXrk84A8Eevy5
         fZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450206; x=1690042206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmTEYMEORosWT3g8FeP7BMzLvgLTEsW/HH8xExKw8yE=;
        b=VAT1N7tIOWOmSy7wPfYdjiYrngT+LdmfadJNnMu/BAFeQWlP/y9ismmAJqawEgW3kN
         7kS1J/qEg6Jm8tHhKCD5b8mwxOWGbnHal+8vQmUOqBoI2ryJSCv7ehNbEgf4CYBIq91Z
         7C7e6rKaI5NKsO7CiEdQOfECcNoDdpWWDca0OzEXFoAEZXFE0QEb3V88nkC9OVS4EKh4
         DJrhKNK2P6+ktFRk7HKxSnv9Dk1aMombc6Yl33gNz0TFIQ2PbN/ObJeRjbBIy8kF4bz6
         D1VQGr98TFnOIpSxXsRZy1lTkJ4sSdvQVSFn8MMXqnz27KmzuPvkXNAS0MHZzPrjuoEc
         tYsA==
X-Gm-Message-State: AC+VfDyHeOTVtc5TsnfaiwwCHyPuq4oav8Nt68c0swiOdwxCN+UtLnEC
        DISA4K17prMxs+syweJrC+YIRp2XQC37IcAMWWw=
X-Google-Smtp-Source: ACHHUZ72gyVyZay61h+/VDC+gL6mGnZWS9w9xopzG/XDNzZQl9j4SmmjDmLPiVkESb6BDtk9Wk+eKearVvf7lPONL5E=
X-Received: by 2002:a17:90a:a66:b0:258:99d1:6b84 with SMTP id
 o93-20020a17090a0a6600b0025899d16b84mr14543737pjo.41.1687450206133; Thu, 22
 Jun 2023 09:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230615215314.5402-1-aford173@gmail.com>
In-Reply-To: <20230615215314.5402-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 22 Jun 2023 11:09:54 -0500
Message-ID: <CAHCN7x+Ga6yq0O369XOJNryS0bb4E96Em5q8fQsdTgxEpxR=hA@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] arm64: dts: imx8mn/imx8mm-beacon: Add HDMI
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 15, 2023 at 4:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The DSI updates are in the DRM tree and Linux next with some updates
> that now allow the DSI to connect to an HDMI bridge and successfully
> sync displays at various resolutions and refresh rates.
>
>

Shawn,

Is it too late to get this series into the 6.5 merge window?

adam

> V3:  Alphabetize regulator names.
>      Add register names for EDID and Packet
>      Add I2C address change for the camera since it
>      conflicted with the I2C address of the HDMI bridge.
>
> V2:  Make 'compatible' the first thing in the new nodes.
>
> Adam Ford (3):
>   arm64: dts: imx8mn-beacon: Add HDMI video with sound
>   arm64: dts: imx8mm-beacon: Change camera I2C address
>   arm64: dts: imx8mm-beacon: Add HDMI video with sound
>
>  .../freescale/imx8mm-beacon-baseboard.dtsi    |   4 +-
>  .../boot/dts/freescale/imx8mm-beacon-kit.dts  | 131 +++++++++++++++++
>  .../boot/dts/freescale/imx8mn-beacon-kit.dts  | 133 ++++++++++++++++++
>  3 files changed, 266 insertions(+), 2 deletions(-)
>
> --
> 2.39.2
>
