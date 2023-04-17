Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4E6E4608
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDQLHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDQLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:07:51 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8AA5FC0;
        Mon, 17 Apr 2023 04:06:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3294eacb2f6so3900725ab.3;
        Mon, 17 Apr 2023 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681729512; x=1684321512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELltBzgQq2kMsFk/gBLyDUWGvL72bzaDJeO1HjsJ+nU=;
        b=i0uxx4P8b7+jO8mRYbbxdG6Tfr1WANwEY6VPHvQYQbrvN/wUdd/DblekpGVF6pDzlY
         voV/o3DikT2W9GSUxV8PGX7PgfRr+oJ2/26tGn5E6SCJHSidR3lWL+XGuQ8Y/E0uX/6o
         yUYpESxqjjR+uiztIKF4TGwbKx82yutq9a+6+7lkrY3hhmlRRnSbAs4+nlLWIYosPCdr
         VYPzJjqLIKc+QNtj2YBSCuC9SQtJSjUeIWNYZQzpZ97q2RCobF7EpuOXqia9CzHkptXH
         uzHiB8VIFKT+R6a/v5sqMghm04M3C/3Y00UFKX3Y1H35WpHUnBybtY0az8JRLi/Xr97S
         2Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681729512; x=1684321512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELltBzgQq2kMsFk/gBLyDUWGvL72bzaDJeO1HjsJ+nU=;
        b=aaolkxrWArmJOxV3i487gmPkF0RamzX7OjscjsMe+vbJRVeAbZ76AS9VbdKVyKzuA6
         8K8G28i9xGCr8z+d8tdWCJbnaoYdAKRDjHtxsq8i08TKWyD4JPONQYv3TahQiIZ5l+//
         iNhC4Yv1u78eYL8wOB0VtVNh9H6DxYQasr9i80NGaLnM8tBb09D3vvjT0k4QslFFGkNe
         dry/8cn7+vo9HShdqajlp2IfmBAkvyS0/RJNqnlrsg7Xq0N5+B1gwWL3R8DwvHbS0NC0
         a8XGzSYdpg4Bkoe5laplj/tV36nNasXTiwQLLTjC5lzaNl9TPeKkwlWhFTmInMhYUGt5
         L3qA==
X-Gm-Message-State: AAQBX9dmbf1eploYHvOGhivNvIzqAmoskTLe3DBommOgGkxRELl6CMqX
        RWRfOqyoA2aWrULfGWcLn2cJbYKNiIbbyUqw5gY=
X-Google-Smtp-Source: AKy350ZM1nWgkQHtj558qYXfvl4irLs4ErPelGgapvsZkr0Tr0xC6WGBmnrJkha7B4Xh3iK8iVpXCIb6HF/fktL4JCE=
X-Received: by 2002:a92:cf43:0:b0:32b:1c9f:3c48 with SMTP id
 c3-20020a92cf43000000b0032b1c9f3c48mr1115197ilr.1.1681729512244; Mon, 17 Apr
 2023 04:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412185608.64628-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU9qrSaJqNL_PsrvbyrBAEB17yVMmLPon8AbvE3kjbTUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU9qrSaJqNL_PsrvbyrBAEB17yVMmLPon8AbvE3kjbTUQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 17 Apr 2023 12:04:46 +0100
Message-ID: <CA+V-a8sVjK7jm6m=7XC9B8JBeUqL+aL_wvFjM-e=-p+4xWuszQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Mon, Apr 17, 2023 at 9:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Wed, Apr 12, 2023 at 8:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable CRU, CSI on RZ/V2L SMARC EVK and tie the CSI to the OV5645 senso=
r
> > using Device Tree overlay. RZ/G2L SMARC EVK and RZ/V2L SMARC EVK have t=
he
> > same connections for connecting the CSI to OV5645 sensor so just reuse
> > the existing r9a07g044l2-smarc-cru-csi-ov5645.dtso and create a symboli=
c
> > link to this file for RZ/V2L SMARC EVK.
>
> Perhaps it makes more sense to rename r9a07g044l2-smarc-cru-csi-ov5645.dt=
so
> to rzg2l-smarc-cru-csi-ov5645.dtso instead?
>
ok, and then for g2lc [0] I add rzg2lc-smarc-cru-csi-ov5645.dtso ?

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023041311=
4016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
