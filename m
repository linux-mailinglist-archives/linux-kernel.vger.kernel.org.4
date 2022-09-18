Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA45BBDFB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIRNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:22:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8392018A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:22:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t14so43165364wrx.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=qe70WmdNsVt7D6f6WRbeUCANYSNWq1ba7xme+qOpCj8=;
        b=qDtOVc8u19Cde231bxT92BzaZi14aziR6OA52P1kHGWTLQTHX92mwYFuK0BSAg9G1k
         NuLRGMpvXm1yWW9/DZmr6ylAKR8WXyQCmqQGx3As8W+70r4LBZ8zFoJS+sYwtwjMI57v
         v7cadDoCQpaxyZMv8DbVM+RKv3nOd7jiTT9b9NnnDgJ8BTVEasVrGKPqE8hldOgK0gIH
         QF3XGnjryS2ty32by7Mu6fBypTOXJZnbpGrgW3nv/p1iqgsp1Xj0fXF8IT01wdz0jAXu
         OG+gybzC3crOL5+6qmUicIlF4yG8ygXFA4C0FS4wggQyGrvHSC2saOXLESgjvWSGikQ3
         G0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qe70WmdNsVt7D6f6WRbeUCANYSNWq1ba7xme+qOpCj8=;
        b=gqc/IPtIZgRqmnj491lN/sHY0Ow8Wo+SqSqL7U3Fsw66zVqS/G7dfILV8kb3YPJY32
         5ngU/l1DRTPflgx1o4Tz3oEw4LCSqKyr4+sQy++ndQTGloGTRDwkBsO3XqD7VQlScZds
         7UVO0hpbqkOMSh/Gh0rA7rAy4vVZGzTT8nTrBlNUwpWaDBrJSZJ9a0gAoMXusA4QyWAY
         J/FuzN9mcLf9PDL/0T+Z/MiuIHEBnQ56EuTyxZJYdZDWoqA/a9ZHMZvWS1tibFugfhkj
         KrxKvKh0i8MtDQFav8RcJmHiOS3x+fy8erLFEx6G4JucLpBCz5MaP7C6N9B0y0792Ht5
         yqxQ==
X-Gm-Message-State: ACrzQf2rCPdhYNhsKjlvRT2DeLoe16py1hP/0N5FqXAIOfy+uixpJooP
        2b23lsGrDVjGnZmrGL6ZUcI=
X-Google-Smtp-Source: AMsMyM4KPaQoCCsfqvY5cDcSXaYx7GlY+PhVoFFA2zC7ZRVdOMv+TM5LWHHDdR0gr+YTGYjXUQ1ptQ==
X-Received: by 2002:a5d:6f0d:0:b0:229:a479:989e with SMTP id ay13-20020a5d6f0d000000b00229a479989emr7762430wrb.158.1663507363013;
        Sun, 18 Sep 2022 06:22:43 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b0022ae401e9e0sm6148033wrs.78.2022.09.18.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 06:22:42 -0700 (PDT)
Date:   Sun, 18 Sep 2022 15:22:40 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Message-ID: <20220918132240.GA7818@elementary>
References: <20220828164517.185092-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220828164517.185092-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, Aug 28, 2022 at 06:45:14PM +0200, José Expósito wrote:
> Hello everyone,
> 
> This series is a follow up on my work adding KUnit test to the XRGB8888
> conversion functions. This time RGB888, XRGB2101010 and gray8 are added.
> 
> Best wishes,
> Jose
> 
> v1 -> v2:
> 
>     Tested-by: Maíra Canal <mairacanal@riseup.net>
>     Reviewed-by: David Gow <davidgow@google.com>
> 
> v2 -> v3:
> 
>     Export symbol drm_fb_xrgb8888_to_xrgb2101010()

This patchset is being in the mailing list for a while. Unless someone
has a reason to not merge it, I'd like to push it next week.

Thanks,
Jose
 
> José Expósito (3):
>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
>   drm/format-helper: Add KUnit tests for
>     drm_fb_xrgb8888_to_xrgb2101010()
>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()
> 
>  drivers/gpu/drm/drm_format_helper.c           |   1 +
>  .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
>  2 files changed, 191 insertions(+)
> 
> 
> base-commit: 61a9fa154d217c13eea90aa5bc635bc4b1fcb66e
> -- 
> 2.25.1
> 
