Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536DC6D463F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjDCNwk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDCNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:52:38 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7335BB;
        Mon,  3 Apr 2023 06:52:37 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id e65so34782338ybh.10;
        Mon, 03 Apr 2023 06:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3dsuy9SysKm463aIidfzRiqsaM6ZWpxf2+nNV1AuG4=;
        b=Hg0rpX2kOa/Xcd901s48x1fAf1/WLx0e5aznyqTHTGRz5aqjH5Mla+Uie3pbIBB7p5
         3nFKWiBm+OBQ3NEWcnckUVt6sZXW7Aa81bFDCwZQtfTOt01Pzgq5fkFZbpWSc0NWswTr
         wQt9mI1lmjEYqk/OSX/jILOrdwjh6Qupp2nfRMU4XlczOekqVXWRIEgdC9CA1rxoG5wY
         6sYOpzzicWFa98epN83C2m80x3GONDNVEQJiWnQoh97n2Doe5Q865zD9K9zA7Xh7xqZX
         e94wmdi119MPQKAeOmAmNpOu3G3u0OV8AhRsRyGfXZo75eFNQcRhAXqM8/zxChHbfrX4
         iFag==
X-Gm-Message-State: AAQBX9c829Yoymu6H0DL/1kzT1gyrNUBBLpcIpcPwDq+hYqgbMq0dqG7
        7xkCACIVWnPGc1LS5bxupsfcUPQRsDF/pX+V
X-Google-Smtp-Source: AKy350bW6glImCBOrEW0z9I4DFpYTTUX5hJPgXV5ttDmPYFZoNoWizU4TjZlKz0sN89D5ab8xL4BUA==
X-Received: by 2002:a25:1506:0:b0:b74:7922:5f3f with SMTP id 6-20020a251506000000b00b7479225f3fmr32221445ybv.52.1680529956196;
        Mon, 03 Apr 2023 06:52:36 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 188-20020a8114c5000000b00545a081848esm2547840ywu.30.2023.04.03.06.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:52:35 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id cf7so34847408ybb.5;
        Mon, 03 Apr 2023 06:52:35 -0700 (PDT)
X-Received: by 2002:a25:bb85:0:b0:b7c:1144:a708 with SMTP id
 y5-20020a25bb85000000b00b7c1144a708mr16700229ybg.12.1680529955037; Mon, 03
 Apr 2023 06:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680273039.git.geert+renesas@glider.be> <01484ce3-2366-5000-3aa6-727448145f36@suse.de>
In-Reply-To: <01484ce3-2366-5000-3aa6-727448145f36@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Apr 2023 15:52:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYnbxLsJp3bnH74yfZAHG=8Da360C4AjKQg-Ynv6hiMw@mail.gmail.com>
Message-ID: <CAMuHMdXYnbxLsJp3bnH74yfZAHG=8Da360C4AjKQg-Ynv6hiMw@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm: shmobile: Fixes and enhancements
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Apr 3, 2023 at 3:14 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 31.03.23 um 16:48 schrieb Geert Uytterhoeven:
> > Currently, there are two drivers for the LCD controller on Renesas
> > SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
> >    1. sh_mobile_lcdcfb, using the fbdev framework,
> >    2. shmob_drm, using the DRM framework.
> > However, only the former driver can be used, as all platform support
> > integrates the former.  None of these drivers support DT-based systems.
> >
> > This patch series is a first step to enable the SH-Mobile DRM driver for
> > Renesas ARM-based SH-Mobile and R-Mobile SoCs.  The next step planned is
> > to add DT support.
> >
> > This has been tested on the R-Mobile A1-based Atmark Techno
> > Armadillo-800-EVA development board, using a temporary
> > platform-enablement patch[1].
>
> Since you have the hardware for shmobile, would you be able to test
> patches occasionally?

Sure!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
