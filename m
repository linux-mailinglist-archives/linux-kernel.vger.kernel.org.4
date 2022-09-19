Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322A5BC420
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiISISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:18:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4B91D0F2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:18:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso4050995wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=ZHoX1E0pKQsE6388AWWZYn9R8dI2szExvawhZ0L+wnU=;
        b=km5dCJC4r54rG/sqDz+HpYtwhcza885+XiPyOOLZlmh73YtKl7wk2/DtvxHii3twB9
         //O7B3T9bC4CDZumBJVWQnT04N3dRuxGd8nPm/cAWGX4lnzoaiRuPNOTrazrKF9O5+TF
         mJODf3vMg4x1A93Mm4QXO3kAlWp81ytvw+anZLK7a0+C/a53Xt89SkBr6ji6qONSu8lt
         iHL5IcaP6YJPRC86QqYw5j+qTsiSEieEXyjP3Es3b/2i/+2WF8sFmGnSg8SrqVzPeYJj
         2I2M7vfmjs8NL44M9IaLGuNwYQ/rNMu4m+O8KZC5aVPho/FN4NBrbOzHW187j2nD7+Ol
         L2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZHoX1E0pKQsE6388AWWZYn9R8dI2szExvawhZ0L+wnU=;
        b=1tGMddNFxZmeqJFfU1qQQwHPKwk+hg2p/VzPU8JOu/wvAKfnAd+niB1PpTFUR5AcbM
         NlgF4h0SVuNjszevNAW2zacpb/PCDHaY3QzCgQ6hqp68W2eG7XlMGB9PAYEMwl5Qt910
         BswP6APjCQoF1oAZaytpP1aSh1DgLuEd820p4qmPHntnEGtqTdVF4Pm7aF2xPcR/H1QM
         cwJETbmfRiXwligbrD+1dDLJvgQUwh2KRQBpSqQjn6HhDctrs5Teq8vl5puFnnstnUzP
         PINcuiLMFOqDfEKHztVkIGk95MAKkDffL596FXR/Mkz/UOKndc7MD91G76em+qyOPRDZ
         Rh5g==
X-Gm-Message-State: ACrzQf0MzOQ8vCuX8fKZuEyK2BNSwFStkUInULq4eEsYxfpUiAmHExdM
        14/XKZumtswvk6lwTETziA8=
X-Google-Smtp-Source: AMsMyM5wJs0YA4BjfQrX6Et+Flxuo6Ydr8qqfocaSk56SSD0ldp9+zwH2mFoYMFYWT4aTGTmV7XXdw==
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id ay24-20020a05600c1e1800b003b3b9f82186mr11862430wmb.151.1663575490638;
        Mon, 19 Sep 2022 01:18:10 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4bc3000000b002238ea5750csm15623562wrt.72.2022.09.19.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:18:10 -0700 (PDT)
Date:   Mon, 19 Sep 2022 10:18:01 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     javierm@redhat.com, davidgow@google.com, dlatypov@google.com,
        tzimmermann@suse.de, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Subject: Re: [PATCH v4 3/3] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_gray8()
Message-ID: <20220919081801.GA144802@elementary>
References: <20220919071531.105124-1-jose.exposito89@gmail.com>
 <20220919071531.105124-4-jose.exposito89@gmail.com>
 <20220919073645.uf64enluhiwd2b2i@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220919073645.uf64enluhiwd2b2i@houat>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for looking into the patches.

On Mon, Sep 19, 2022 at 09:36:45AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Sep 19, 2022 at 09:15:31AM +0200, José Expósito wrote:
> > Extend the existing test cases to test the conversion from XRGB8888 to
> > grayscale.
> > 
> > Tested-by: Maíra Canal <mairacanal@riseup.net>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  .../gpu/drm/tests/drm_format_helper_test.c    | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > index 09d358b54da0..71722e828abe 100644
> > --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> > +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > @@ -37,6 +37,11 @@ struct convert_to_xrgb2101010_result {
> >  	const u32 expected[TEST_BUF_SIZE];
> >  };
> >  
> > +struct convert_to_gray8_result {
> > +	unsigned int dst_pitch;
> > +	const u8 expected[TEST_BUF_SIZE];
> > +};
> > +
> >
> > [...]
> >
> >  static struct kunit_case drm_format_helper_test_cases[] = {
> >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb332, convert_xrgb8888_gen_params),
> >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb565, convert_xrgb8888_gen_params),
> >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888_test, convert_xrgb8888_gen_params),
> >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_xrgb2101010_test, convert_xrgb8888_gen_params),
> > +	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_gray8_test, convert_xrgb8888_gen_params),
> 
> The trailing test feels redundant,

Why do you feel like it is redundant? Under the hood, most conversion
functions reuse the same code, but the *_line() function is unique and
I think that it is worth testing it.

> and we should order them
> alphabetically to avoid conflicts as much as possible.

Good point, I'll sort them alphabetically.

> Feel free to add my
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> 
> And fix this while applying
> 
> Maxime

Thanks!
Jose
