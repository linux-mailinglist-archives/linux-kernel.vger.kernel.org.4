Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6001A6CDA16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC2NH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjC2NH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:07:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185044C02;
        Wed, 29 Mar 2023 06:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 305F1CE2402;
        Wed, 29 Mar 2023 13:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40378C433A8;
        Wed, 29 Mar 2023 13:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680095244;
        bh=64OVEta+8cwYkwrCXKWVXG9McVRJXZTO5LX36p5K5KQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=da3xQ3WAUJLpDJMDKtepK1aRetwmoI55sJpq3a8EswUK/icNIaY9hfMAMIT+3xZNM
         7JM9/IeA2dRTwU68j/h2+1+bX42lN+q0s8eFi0alaIhCo/+AeNMhwrXPZQm+3pl00M
         WdYAVEl4QdoqgFGSTD3jAUUfy3JNWekoDDm23ihZXgJtdnCOFPZ7x3NKJbLw3WNhVq
         mhTwq5mQadQLupUBo88QJOvbW5hvcUdsacMTGbX16aL1dqd/Zqi7zXuaQEUJVn5X7r
         2cewsUMi7bICrn4En/qApKzuCPmUYNEx/OQVknYayqIk0j9nmNh/m7FoM8HFM7XrJb
         cP34LVWpqSeLQ==
Received: by mail-yb1-f173.google.com with SMTP id r187so19191052ybr.6;
        Wed, 29 Mar 2023 06:07:24 -0700 (PDT)
X-Gm-Message-State: AAQBX9dDJu1IjLso0spHIxW3u+QVd30RcE7l8rF67YrOow8+ePnI19z8
        Gxc3jNeK3TJnkhhK33zlD3gjt7WMD8f+YyUOhw==
X-Google-Smtp-Source: AKy350bwcTIPA/G3ETRQktnXdBJhdzSnaF6sl6bCmHm1c0aOLy6nbEarw0pjdIo3RIbbloaB2gT0TDTk8aI9coR2H5Y=
X-Received: by 2002:a05:6902:1586:b0:98e:6280:74ca with SMTP id
 k6-20020a056902158600b0098e628074camr12456018ybu.1.1680095243200; Wed, 29 Mar
 2023 06:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-7-ychuang570808@gmail.com>
In-Reply-To: <20230328021912.177301-7-ychuang570808@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Mar 2023 08:07:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
Message-ID: <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 9:19=E2=80=AFPM Jacky Huang <ychuang570808@gmail.co=
m> wrote:
>
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> Rename the bindings/arm/npcm directory as nuvoton.
> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
> Add initial bindings for ma35d1 series development boards.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>  .../nuvoton,npcm-gcr.yaml}                    |  2 +-
>  .../npcm.yaml =3D> nuvoton/nuvoton,npcm.yaml}   |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton=
,ma35d1.yaml
>  rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml =3D>=
 nuvoton/nuvoton,npcm-gcr.yaml} (93%)

Since you are moving it, this one should be moved to bindings/soc/nuvoton/

>  rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml =3D> nuvoto=
n/nuvoton,npcm.yaml} (93%)
