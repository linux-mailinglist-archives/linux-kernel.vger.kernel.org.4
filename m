Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A06BD2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCPOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCPOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:48:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E52A132E1;
        Thu, 16 Mar 2023 07:48:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd5so8651162edb.7;
        Thu, 16 Mar 2023 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678978085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKWEEXtwpzWyoke4EDt/SjsZs9hzq1bNd8Ga2FZNSkY=;
        b=R2baROw3Ek92CnTov526LJmaVacryhnvdk1pmAOCFMq0bxAt8jLYnm/3vwU0Xtyebd
         tciViUG94zTQf6BBD1yMAqUykGu40R45DlkwuCeZ7kdOY2DWawvscv1JZqcw1jRa4tw9
         alitaa+86NgYQX4u48ENXgyRqPqLVnjiQbGW3ZUrZpGmeD/DGNkq5BGYjueTM1QNNgzw
         ULe/wHcltfT9nsmGMbWRHbKf2VUlGEsHzjFk070gyhYlMmpmy5ny7xzc+ZpkNwnnss68
         qx5fs2QW7uT+KSv0+Z/Lek2F+aLUU3qv1Hhfd/DQ0flZHcg2ptaBoUnGA11rbLPm5Pb/
         /7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKWEEXtwpzWyoke4EDt/SjsZs9hzq1bNd8Ga2FZNSkY=;
        b=fTbHJ/PJvFfnmhkGvM/n2myllXfz3v3qhQFjz7F08KAj5Q2oPqCbmIULJ2atB+G3zN
         OAdlVrSiOlg8iJHQOZwEs8tkAeg0bgfjlUBamGQgnf89y8+5F5e9sDyjv105clSWy121
         RRpoTNxRBbRHceiIBXtg6PFfp8hG/VxhWh22V4sAUzpJNL3zZLK9zZZ6gGNUstgb6qWp
         yw+FFiNS4mhK0RVzNqJtTajvA3rst+nurLSC+2pZI9Hx2CMBLPFzBo6RcdJbPPj/G12c
         pg50swcUB8p9b/wEC1LU4ClrtRY+Cnpzw7dL8bMT5hdSzvN3f4LFan12LdmfOXNKpbew
         J2ig==
X-Gm-Message-State: AO0yUKWhGoa5SeZEK1Arqv/fij5cucKEz2xKrashSn5yoMCOKn+xnP1m
        NFj5NxsoVFoLAvBvtdkSgKWiQN+YEYnqbiyq71A=
X-Google-Smtp-Source: AK7set/xWVcJOMfkQHMVyXDiy81VQPzKWcMSSS6wnn/vPpsZk8RESi9bQhzNLJ68PkVD0u1TpUCENB3mosHwO6afNtk=
X-Received: by 2002:a50:99d6:0:b0:4fb:f19:883 with SMTP id n22-20020a5099d6000000b004fb0f190883mr3700885edb.1.1678978084578;
 Thu, 16 Mar 2023 07:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230315160228.2362-1-cnsztl@gmail.com> <20230315160228.2362-5-cnsztl@gmail.com>
 <CA+E=qVei7T4T0FWhdUFnr5JbCWSgFbGLcmU2OHxx54yvnNR6mw@mail.gmail.com>
 <CAOP2_TiU815F528jVGvDbcg3kSG+ykepU-ZYz7VWMO84GgcwMg@mail.gmail.com>
 <71b16513-49b1-d9b3-b0b9-4c47e68563ba@kwiboo.se> <CAOP2_TgieY2PNBJz9tE_+hxX14wBQ7RtFNfFhYd2_MCSnoZLxg@mail.gmail.com>
In-Reply-To: <CAOP2_TgieY2PNBJz9tE_+hxX14wBQ7RtFNfFhYd2_MCSnoZLxg@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Thu, 16 Mar 2023 22:47:53 +0800
Message-ID: <CAOP2_Tii7auK7rHrFF1FT76LnC5coBfhZtGaEpk6Nd=az0UQVg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 16, 2023 at 4:46=E2=80=AFPM Tianling Shen <cnsztl@gmail.com> wr=
ote:
>
> Hi Jonas,
>
> On Thu, Mar 16, 2023 at 3:37=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> w=
rote:
> >

[...]

> >
> > Generic ethernet phy driver is not resetting the phy in the same way
> > that snsp,reset-gpio does, please see top two commits at [1].
> >
> > I have been meaning to send that out as an RFC but I got stuck in a
> > u-boot rabbit hole, and I also do not know what the correct way to fix
> > this would be, so I played with both device tree and code changes.
> > Will prioritize this and send out a RFC later today.
> >
> > [1] https://github.com/Kwiboo/linux-rockchip/commits/rk3568-eth-phy-res=
et
>
> Thanks for the hint! I will test your patches tonight.

I'm currently playing your patches at
https://github.com/1715173329/imoutowrt/commits/master-rockchip-mdio

I applied commit 8597fcfa0c5c792dabb44a2db7b283c56c99ec6a to NanoPi
R5S, it worked perfectly.

However, with commit c338ed260bfd87277c41aa0290f1f2aad8d629b1 + moving
reset properties into the phy node,
the driver still failed to lookup phy. I'm not sure if I missed /
misunderstood anything.

Thanks,
Tianling.

[...]
