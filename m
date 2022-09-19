Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBB5BC44F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiISI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiISI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:29:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307221265
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:29:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n10so15718734wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=WXCToHfQiSix6PvjVjohUsg//yZJDPaLAeIA+KqtiOI=;
        b=KgMKYhel6t7u9jg288YAF26uIfAPwmvcCFYE/z+gjfGW/VZNzC+t8kfsQghe9c4w5w
         83JfkeFfvj7CDaugxJB5ZSC3Cyc+6ZNts95DNOWYaP//NcwGOHZT62OKTtzwgczBMoiM
         HuccyFu7LAPE2m5cLKiW8YSTGSaZGDbn+XSM0unQQWYySxwP7ej24OCXtK2Ub6isH+Jc
         xiRqxiI3n1b6N98tAzh1FS3ZxzdNgRdewCS8Wg7XwuyrtE/Z/WeyjVy5eRMA7+1Y9bJl
         5O/WcoQ4CUwo1Y2bysXz33XgObnsLL8YOXOY/7sGY4TdwWpsa3aqIjd9UUVdMHyod9Nv
         szYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WXCToHfQiSix6PvjVjohUsg//yZJDPaLAeIA+KqtiOI=;
        b=o836gjCLJjz0g4atmYxvYe9xEgIhOll+9xQGMz/J5Z4EwbJrgAzT+K/0iaTWNV5TEB
         BQQhetT+LwntiTSM9NtcWN0Gkh0yqGgDaj1n8ulOrx6iirnEw+qneyR2j+rDrWR+RGQC
         Z3CqnSvSqt/aKECzJMuwDnP65SIBBi7TcmDDzOxUAywH6/EP6uKqJjOR/B4TZ/aOQuag
         7llK+qojaWvtMMAvLZRbklp7olfQAYZsdze/cAREnrxM9F0wMWqDd5rrcnUpTmR3tCQs
         qLFZazrXAPBcKRhTUl+MBmvDocvGt9/qZQzJvLyInQdzflb9lH4UI3IkSqR0VAEpm6ax
         rtzA==
X-Gm-Message-State: ACrzQf1xgOzK5k+ld48GlYVrIXdMLHlK2DqteihoMBT0zZgA7HyaxdbX
        e9XmN6CKuckgEPuJxDtYktE=
X-Google-Smtp-Source: AMsMyM7BJlzxPe+aIM0WiE73TyvATgkKl5lyzhtImNW8NVwkL5+RaNi2UmRGdLoqFJS/UqVwlu3KTw==
X-Received: by 2002:a05:6000:184e:b0:228:bb9d:f98a with SMTP id c14-20020a056000184e00b00228bb9df98amr9535880wri.479.1663576158316;
        Mon, 19 Sep 2022 01:29:18 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b003b4727d199asm13141011wmp.15.2022.09.19.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:29:17 -0700 (PDT)
Date:   Mon, 19 Sep 2022 10:29:14 +0200
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
Message-ID: <20220919082914.GA290343@elementary>
References: <20220919071531.105124-1-jose.exposito89@gmail.com>
 <20220919071531.105124-4-jose.exposito89@gmail.com>
 <20220919073645.uf64enluhiwd2b2i@houat>
 <20220919081801.GA144802@elementary>
 <20220919082519.s5d7llmynot76xsx@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220919082519.s5d7llmynot76xsx@houat>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:25:19AM +0200, Maxime Ripard wrote:
> On Mon, Sep 19, 2022 at 10:18:01AM +0200, José Expósito wrote:
> > Hi Maxime,
> > 
> > Thanks for looking into the patches.
> > 
> > On Mon, Sep 19, 2022 at 09:36:45AM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Mon, Sep 19, 2022 at 09:15:31AM +0200, José Expósito wrote:
> > > > Extend the existing test cases to test the conversion from XRGB8888 to
> > > > grayscale.
> > > > 
> > > > Tested-by: Maíra Canal <mairacanal@riseup.net>
> > > > Reviewed-by: David Gow <davidgow@google.com>
> > > > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > > > ---
> > > >  .../gpu/drm/tests/drm_format_helper_test.c    | 62 +++++++++++++++++++
> > > >  1 file changed, 62 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > > > index 09d358b54da0..71722e828abe 100644
> > > > --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> > > > +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > > > @@ -37,6 +37,11 @@ struct convert_to_xrgb2101010_result {
> > > >  	const u32 expected[TEST_BUF_SIZE];
> > > >  };
> > > >  
> > > > +struct convert_to_gray8_result {
> > > > +	unsigned int dst_pitch;
> > > > +	const u8 expected[TEST_BUF_SIZE];
> > > > +};
> > > > +
> > > >
> > > > [...]
> > > >
> > > >  static struct kunit_case drm_format_helper_test_cases[] = {
> > > >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb332, convert_xrgb8888_gen_params),
> > > >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb565, convert_xrgb8888_gen_params),
> > > >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888_test, convert_xrgb8888_gen_params),
> > > >  	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_xrgb2101010_test, convert_xrgb8888_gen_params),
> > > > +	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_gray8_test, convert_xrgb8888_gen_params),
> > > 
> > > The trailing test feels redundant,
> > 
> > Why do you feel like it is redundant? Under the hood, most conversion
> > functions reuse the same code, but the *_line() function is unique and
> > I think that it is worth testing it.
> 
> Sure, I wasn't commenting on the code itself, but the trailing "test" in
> the test name: drm_test_fb_xrgb8888_to_gray8_test
>                                              ^
> 
> Which is redundant since we already have "test" in the prefix.
> 
> Maxime

Ah! OK, I misunderstood your first sentence. Indeed, the _test sufix
should be removed, added to my TODO list.

Thanks!!
