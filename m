Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176F706098
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEQHCi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEQHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:02:35 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BB110;
        Wed, 17 May 2023 00:02:34 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-56187339d6eso3610177b3.2;
        Wed, 17 May 2023 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306953; x=1686898953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb66cM90aorprDoD+fU8o0Tfbn5W3STJm5DAIXq91ZM=;
        b=XzKd2LyGyOvu7LlRsapXUe2kDlvGPJUUY6A8NbBub63uucS4W7P5xPLw1CG6Jx1vCP
         b9QC7N7xlm5KgNB0vqsAXj62ROuFc4YmM0b9CCBZaJCR9vNs7LdaMEyFkoVqlZDOivE/
         VzvzyffYARzNKeMjALk25BX2DwwdA3yLNdCYfCPykRDsdsx8i/NxtnqGvvs11jkfu9xx
         FVu9F+xq0L1Qy8FYSc0SgLsy1/3vOXHVH+WLI+spVgD1Sb/7IBTvkA6zMMd7PATU515d
         11r32hTptU64GKwqwdYpE3REiq8JqKdVl3ZZxkKmUGR6MeVr+HeON6VPa0kPTxJrsO9/
         GkMQ==
X-Gm-Message-State: AC+VfDzeRv1ZQ/aCLiqeYUcelfXCcPxIxNUFgDOhKEyy8g4goxtphKne
        WSEh6e17trTilBM7B7SOqF8GrQUtcPJhGg==
X-Google-Smtp-Source: ACHHUZ52YnWPDly5F0UgVvYnbGgNqwSJn/ORs5ens3GtLtGctfvcvNnTS7kjIyYWZvGBikXgvFUbXg==
X-Received: by 2002:a81:d54b:0:b0:54f:895e:70f7 with SMTP id l11-20020a81d54b000000b0054f895e70f7mr36008728ywj.9.1684306953281;
        Wed, 17 May 2023 00:02:33 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id p6-20020a0dcd06000000b0055a72f6a462sm483065ywd.19.2023.05.17.00.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:02:31 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso128687276.3;
        Wed, 17 May 2023 00:02:31 -0700 (PDT)
X-Received: by 2002:a25:c7cb:0:b0:ba7:5f08:ba07 with SMTP id
 w194-20020a25c7cb000000b00ba75f08ba07mr10396212ybe.33.1684306950735; Wed, 17
 May 2023 00:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230516202257.559952-1-arnd@kernel.org>
In-Reply-To: <20230516202257.559952-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 May 2023 09:02:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgVsY8Ur7s9Xy1xMGxOW0WFXWq934aAE9Z884tGuWG_A@mail.gmail.com>
Message-ID: <CAMuHMdWgVsY8Ur7s9Xy1xMGxOW0WFXWq934aAE9Z884tGuWG_A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: fbmem: mark get_fb_unmapped_area() static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Hi Arnd,

On Tue, May 16, 2023 at 10:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> There is a global function with this name on sparc, but no
> global declaration:
>
> drivers/video/fbdev/core/fbmem.c:1469:15: error: no previous prototype for 'get_fb_unmapped_area'
>
> Make the generic definition static to avoid this warning. On
> sparc, this is never seen.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1468,7 +1468,7 @@ __releases(&info->lock)
>  }
>
>  #if defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && !defined(CONFIG_MMU)
> -unsigned long get_fb_unmapped_area(struct file *filp,
> +static unsigned long get_fb_unmapped_area(struct file *filp,
>                                    unsigned long addr, unsigned long len,
>                                    unsigned long pgoff, unsigned long flags)
>  {

LGTM, as this is unrelated to the SPARC function, and SPARC does
not support nommu (yet? ;-)

drivers/video/fbdev/Kconfig:config FB_PROVIDE_GET_FB_UNMAPPED_AREA
drivers/video/fbdev/Kconfig-    bool
drivers/video/fbdev/Kconfig-    depends on FB
drivers/video/fbdev/Kconfig-    help
drivers/video/fbdev/Kconfig-      Allow generic frame-buffer to
provide get_fb_unmapped_area
drivers/video/fbdev/Kconfig-      function.

Probably you want to update this help text, too. E.g.
"to provide shareable character device support on nommu"?

This seems to be selected only by DRM_STM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
