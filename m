Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A76618C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKCWvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiKCWuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:50:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B32338F;
        Thu,  3 Nov 2022 15:50:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k22so2974912pfd.3;
        Thu, 03 Nov 2022 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzlnAL2Mlz+Qt/VfNof7jTDDGCycah09T++gJSmpTTA=;
        b=ntLcVgCR9rZzJd95UWdX3SpYnEfDo/L5rXfesPn3Xxv6gmPk9SJfs2V07x6rV8jdsD
         Izjy+nS6wDf5pvhAuqcZXxQJwos2irodrEK2wbmdounSy7QSQaRvsO2vrhdo1+v0OVhC
         1IC1vsWRdfdgRLxDgYV1cyU3hyjWuSh/nnW4MJ8m2bG6HBxdDXBic/D41zqV+tWaOI8v
         webq0TEewfKe2h/2uDgdMK46dUmGc4RJa9yJfGxb4ddZBhOAqEa7+YmLg3Cgq6O5rh1s
         /W1SwywUN4V1NbIyh6oGTqG2uCX2+SQp5YO6L03S4jK1zGn49bNzVAE0QbPcEwv/Ekid
         Lecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzlnAL2Mlz+Qt/VfNof7jTDDGCycah09T++gJSmpTTA=;
        b=05fh23tsjC31FX/AHM/K9WnDaUbtUFLKB+FLQa/9iesLvLKC4W2Rb6h/iMZSvr4laU
         d/WvtrNWHYem+5c4wS5cKJuOvnyrYg4/u7PSk0viIDqtxt1hoSps2QmN0IOliwr7Xypn
         aQ9EJtuhiRWqukRgeUCTxpiY7F6NqmpAut9LGbS+2dKpF70qfTSYkufK6xX0n+n25KCX
         W3Z4JqbMikcN1rOG1ECzRJWdWlbJ/kG5S95fPjDacr/iSKAsgoKpd+5da1pZrdY5AuE/
         WqTeq0aJmSdMydO/Au2UEPBFhpvmEXBrbCbMEp2SUavCuv+ZOu26RdfaJyN3Saror+Fj
         TIFA==
X-Gm-Message-State: ACrzQf0Bw3+yHoFSQfMYIZ26XhYkcRUSf+LNJeCDbKoSdXSMSE8HylRb
        CPi+aPfYfY/pyoroDALOgWM=
X-Google-Smtp-Source: AMsMyM5a+X0XGuEFLf1aUjy72aqKZyGXlrDwqUQtW6X1RafqMGBJ/sEfaUJYEZqEiKk5IeoTmLsPQg==
X-Received: by 2002:a05:6a00:848:b0:56e:4e85:33fc with SMTP id q8-20020a056a00084800b0056e4e8533fcmr4916407pfk.40.1667515801502;
        Thu, 03 Nov 2022 15:50:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id gf7-20020a17090ac7c700b00214247989dfsm522102pjb.13.2022.11.03.15.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:50:00 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:49:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/13] Convert omapfb drivers to gpiod API
Message-ID: <Y2RFlW2sRrmcNiFg@google.com>
References: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:46:35PM -0700, Dmitry Torokhov wrote:
> This series converts various OMAPFB drivers to use the newer gpiod API
> that respects line polarity specified in DTS.
> 
> Unfortunately existing DTS files specify incorrect (active high) polarity
> for reset lines. As discussed in [1] we will not try to correct existing
> DTSes, but instead follow the path established by DRM drivers for the same
> components, and continue using inverted polarity in the FB drivers.
> 
> [1] https://lore.kernel.org/all/20221004213503.848262-1-dmitry.torokhov@gmail.com/

Sorry, it looks like I did not clear temporary directory, so there is a
bit of mess in the patches. I'll resend properly in a second.

> 
> To: Helge Deller <deller@gmx.de>
> To: Tony Lindgren <tony@atomide.com>
> To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> To: Sebastian Reichel <sre@kernel.org>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Dmitry Torokhov (13):
>       omapfb: connector-hdmi: switch to using gpiod API
>       omapfb: panel-sony-acx565akm: remove support for platform data
>       omapfb: panel-sony-acx565akm: switch to using gpiod API
>       omapfb: encoder-tfp410: switch to using gpiod API
>       omapfb: panel-dsi-cm: switch to using gpiod API
>       omapfb: panel-tpo-td043mtea1: switch to using gpiod API
>       omapfb: panel-nec-nl8048hl11: switch to using gpiod API
>       omapfb: panel-dpi: remove support for platform data
>       omapfb: connector-analog-tv: remove support for platform data
>       omapfb: encoder-opa362: fix included headers
>       omapfb: panel-lgphilips-lb035q02: remove backlight GPIO handling
>       omapfb: panel-tpo-td028ttec1: stop including gpio.h
>       omapfb: panel-sharp-ls037v7dw01: fix included headers
> 
>  .../omap2/omapfb/displays/connector-analog-tv.c    |  60 ++---------
>  .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  49 +++------
>  .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |   4 +-
>  .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  67 ++++--------
>  .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |  83 ++-------------
>  .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 116 ++++++++-------------
>  .../omapfb/displays/panel-lgphilips-lb035q02.c     |  21 +---
>  .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  72 ++++---------
>  .../omapfb/displays/panel-sharp-ls037v7dw01.c      |   3 +-
>  .../omap2/omapfb/displays/panel-sony-acx565akm.c   | 105 ++++++-------------
>  .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |   1 -
>  .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  59 +++--------
>  include/video/omap-panel-data.h                    |  71 -------------
>  13 files changed, 170 insertions(+), 541 deletions(-)
> ---
> base-commit: 61c3426aca2c71052ddcd06c32e29d92304990fd
> change-id: 20221103-omapfb-gpiod-87ca2550bd90
> 
> -- 
> Dmitry
> 

-- 
Dmitry
