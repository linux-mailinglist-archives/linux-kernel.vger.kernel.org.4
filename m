Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E236E964B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjDTNuh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjDTNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:50:28 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFC8728D;
        Thu, 20 Apr 2023 06:50:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id n193so2132176ybf.12;
        Thu, 20 Apr 2023 06:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681998618; x=1684590618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQjI0+XJTWPgzTnyACSUbI+nXJQlQt/RnE/NaV2CVFc=;
        b=K53lXnPCZiiHJxxi8Gbj7ROjrUgqE4uQxFTywRDb0bkbl7Q/H6vhJBlV47Y4aIxIGH
         J5ImUJQBFq6nG+poF/g4wemrnKHacscr4xJ8jXMLm/jcQeiBI5T6lYfobCpkyBdiaB04
         5mR1o9u9skcGlQsowrF24onzObGUIRoOPioHC9sPdlmK0WKbMPTGihT8r2QhoA6FUDWo
         YXAJlITuqeoUFtsMWaWPUrh+hfeMbT/3p7BJyA7e3j8G6qrawgEW0yQktwLUWqLOX5iM
         HwSl+zb3bj/PiTumkUYC+3AckR1G0Ud778AOO3a9ZrVzR4QKfcfP+k3GKIrMQY3GBOIo
         I7oA==
X-Gm-Message-State: AAQBX9d8dp9oRbvqI7Xh0b71dvh86Ccg1z3HPP9OS3BuuQowBWn0kOzM
        l3NLVoZDQuLTf7QrLPAmLcAfAOsFn8vDboRW
X-Google-Smtp-Source: AKy350Z+FeqPST2nyp4gS8L8dPlD/jGOSURjvJEf4IMiGGY3lSLFDDFMo15BF/gh+5zOsWTYP08DQQ==
X-Received: by 2002:a05:6902:1887:b0:b8f:1d7f:f537 with SMTP id cj7-20020a056902188700b00b8f1d7ff537mr1642898ybb.62.1681998618281;
        Thu, 20 Apr 2023 06:50:18 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id p13-20020a056902014d00b00b8bcaf1e660sm32682ybh.4.2023.04.20.06.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:50:17 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-552ae3e2cbeso41003247b3.13;
        Thu, 20 Apr 2023 06:50:17 -0700 (PDT)
X-Received: by 2002:a0d:c2c1:0:b0:555:be69:a805 with SMTP id
 e184-20020a0dc2c1000000b00555be69a805mr758092ywd.51.1681998617250; Thu, 20
 Apr 2023 06:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412185608.64628-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdU9qrSaJqNL_PsrvbyrBAEB17yVMmLPon8AbvE3kjbTUQ@mail.gmail.com>
 <CA+V-a8sVjK7jm6m=7XC9B8JBeUqL+aL_wvFjM-e=-p+4xWuszQ@mail.gmail.com> <CAMuHMdX1kkxaKfRJ+HbJA6nxX8x9KRsszo+Kq0g87Rf3eo0v7A@mail.gmail.com>
In-Reply-To: <CAMuHMdX1kkxaKfRJ+HbJA6nxX8x9KRsszo+Kq0g87Rf3eo0v7A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 15:50:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVj6_Z4i23Zoiv1PcGYfXOsdPuy8vRZUm--rLHLRuNyKw@mail.gmail.com>
Message-ID: <CAMuHMdVj6_Z4i23Zoiv1PcGYfXOsdPuy8vRZUm--rLHLRuNyKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 1:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Apr 17, 2023 at 1:05 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Apr 17, 2023 at 9:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Apr 12, 2023 at 8:56 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Enable CRU, CSI on RZ/V2L SMARC EVK and tie the CSI to the OV5645 sensor
> > > > using Device Tree overlay. RZ/G2L SMARC EVK and RZ/V2L SMARC EVK have the
> > > > same connections for connecting the CSI to OV5645 sensor so just reuse
> > > > the existing r9a07g044l2-smarc-cru-csi-ov5645.dtso and create a symbolic
> > > > link to this file for RZ/V2L SMARC EVK.
> > >
> > > Perhaps it makes more sense to rename r9a07g044l2-smarc-cru-csi-ov5645.dtso
> > > to rzg2l-smarc-cru-csi-ov5645.dtso instead?
> > >
> > ok, and then for g2lc [0] I add rzg2lc-smarc-cru-csi-ov5645.dtso ?
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Oh wait... had missed that one. Let me catch up and get a better
> view on the big picture first... ;-)

Let's keep it for now...
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
