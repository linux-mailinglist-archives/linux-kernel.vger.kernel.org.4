Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3936B8319
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCMUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCMUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:51:06 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29C5B5D1;
        Mon, 13 Mar 2023 13:51:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t4so13346328ybg.11;
        Mon, 13 Mar 2023 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVDMl7afmqyNlWSHMur8DAhwbfy3QB/KArfD3iReUEI=;
        b=B63VOA5e2wKkVcBEVSVoYEXb2Go0SDMEhh+LXaSd577dRWZ+e0U/tz01Gfnn/xkroW
         zWjWhyr5eSl4Z0wiQPdvWI9DoKWaHjxikit6td0QbTDJfe/LeE5Qmxxsf/Uq16XLkTzh
         Va96ApIncTvS/jt1nZZMdUMemKiXey/196v1yqitx6khbaO4bsWowdqar4So/UJRDEGX
         r6H00BmSAtQhTdrq7IjZAYpS+O5C1i+IQYkL2diQ3k3ZxsF2FowW2mQIK8lJ6sVOe7K1
         C1ffHctIGOFHVWXDVZpKlGfzj0XWD3K0dDG474gb6ZkXi9dp0IQ7vkNMpwloJVQlj1+l
         jjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVDMl7afmqyNlWSHMur8DAhwbfy3QB/KArfD3iReUEI=;
        b=LVQgwG0SgGtJYN2DittIYzErdv2CS5KzGGICaTwpxG4te2Ky1AAMyw1run1BK0SD78
         fx9TPWNPA30/xhfc3HIhhVqJPBRg30L/bFHMy8sGirTwZwZeWEs1nAR6VDQ9cAdPoPTT
         VnGM4XFLMQJDYEAulx1BNWhecm+d14Fh6MoT5444Erv3+VWX0Vv29ZjCeBd9+gCBPYBf
         kV6khRjZ4a2hG43Ps8eYUmZKm2zzaWK+4NuzGEkoliKkcf4YdfVmW5svqwmQV8ci3vgj
         BGSOIQcFtGt/U9i+iujTwkXqpdRX4+UX72TFkrfaOWg8SBtRzIjfc0cyc3jeE9LAxAAm
         FqJQ==
X-Gm-Message-State: AO0yUKWkqntb9WmaF92P5/uInBhhYa7pyipRpqBrK96VZskarjThWn5d
        QHNG4RDDv2FMTwcZ2IMRrnAYu4VmtI7IKsRPdspomZNELpc=
X-Google-Smtp-Source: AK7set/16PVBhq1JojqFSgrUinwqY6HQJkTPq3MtOLV3VZja0XFjc+yYK0Uhgyzjh1cV+fQIdXifmJegQ8CKDeFBg6w=
X-Received: by 2002:a05:6902:251:b0:9f1:6c48:f95f with SMTP id
 k17-20020a056902025100b009f16c48f95fmr9928550ybs.5.1678740664174; Mon, 13 Mar
 2023 13:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com> <20230308230001.GF31765@pendragon.ideasonboard.com>
In-Reply-To: <20230308230001.GF31765@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 13 Mar 2023 20:50:38 +0000
Message-ID: <CA+V-a8uQ8fAc-F=7WokcH4otbap0F_ik9Dnw4GpB8ALdVRuWgg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Mar 8, 2023 at 10:59=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Mar 06, 2023 at 08:27:19PM +0100, Geert Uytterhoeven wrote:
> > Hi Prabhakar,
> >
> > On Thu, Feb 16, 2023 at 6:57=E2=80=AFPM Prabhakar <prabhakar.csengg@gma=
il.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > OV5645 sensor can be connected to the CN1 connector on the
> > > carrier board. This patch adds the ov5645 node under i2c0 node.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > > @@ -6,6 +6,10 @@
> > >   */
> > >
> > >  /dts-v1/;
> > > +
> > > +/* comment the #define statement if OV5645 is not connected to CN1  =
*/
> > > +#define CAM_INTERFACE_OV5645   1
> >
> > I believe the camera is optional ("can be connector" above).
> > So shouldn't this be commented out by default?
>
> Even better, could you turn this into a DT overlay ?
>
Please let me know your thoughts on this.

> > The rest LGTM, so with the above sorted out:
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
Cheers,
Prabhakar
