Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53269DEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjBULit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjBULin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:38:43 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD98B44E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:38:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F8D75C0196;
        Tue, 21 Feb 2023 06:38:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 21 Feb 2023 06:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676979518; x=
        1677065918; bh=f0q6/VIS/EDAASz/wLLcZiAjmhuxTz7A6V8IY7t66Yc=; b=p
        A2OU+H+HOfI9IUp+LSwrVgR72ozeKu6R/zyeo6dbrO9FI68IVO4JbvnE5SDQp6Qa
        bEWPbKtbrd4/N/WDjKmkI9JEWoZNqUNA9PRiwVdxX7tY4HUWa0U5S58MMl7IFSAM
        R9nwv+GMK0p3ZuDJOj+iR2xgXJ+VS75LHz2PEcLITiq5kMQHb5kkzXfj9WO5vzAW
        fiipUZagK0b9v6Mre0O6HUbbznVVyGK81YwmyW09iz1czFcjTNGH9adO1HbonSy4
        gsG4UpAFWUvSNfEdtOv0CMgbDAQMIwVUPC0/LZWTi7sX4Eisr6UOL5y+6Oy2rg9S
        Gw+8ZkfKxzx18fbIPsemQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676979518; x=
        1677065918; bh=f0q6/VIS/EDAASz/wLLcZiAjmhuxTz7A6V8IY7t66Yc=; b=m
        CzQb66yUMbQ95HiOdj05fe871tKiiXyEhnXndz3xBASQWvYy2+0aIDn5CougZ5wp
        Jg4b3aSTfN9pXl2ApNqsB4GwhAIvbrEOiVv+ztiQer7WxPI1yltCcXLOCUbwWBBd
        +qRPrtGYD9VaAH6xxKtcquCVQ6bOjar/j28ZFYZ2RXwZXxdDVXivHJOUbXi0o40H
        ajPb8HyTk0unQzC2SdvtLnKwcmg1Ubo7X3GJpoaPS7TwsqAfvJzfbr2/KKpuWm77
        MSb5LEuCM1P1sAquPFtUbWRbsXWFygbx3KGRQzg21VgyWXNMo72r6EvZMB7J6SH8
        BDHHgP0896CKymr6laBrQ==
X-ME-Sender: <xms:Pa30Y88-9JxKSyL95yqp6h9OFzMcPXsAKBWXUhIW0hEgAmPLP20JWg>
    <xme:Pa30Y0vUNvXDc-WKtOPrDKji1csejiyc0YggdFnKALN1cEVn3YG5aKTWMKRoqhl97
    A2DHdmePQyYwF8UqoE>
X-ME-Received: <xmr:Pa30YyAemGFDn54JE1uLtv8YuIfG0dOakoyTrIjeIOHP9J4Qioxx5H9c9XUaTsyG5PRns5cynC2E9MMp3p-_KMgHA2kGsLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Pa30Y8f_OAOwdujjIgT5tBXlQI72zBP_in7MNwz4Gr90AXL0aytEkA>
    <xmx:Pa30YxN2yS69ureMIgQ7o8cdPYG4QjO5pKUTccWLM2Skc5kkGMnY5g>
    <xmx:Pa30Y2n0RsDdcK7VSOrBmSpoEg8GkunW9vaVaO1PdvI7bg8Ew5Cc-g>
    <xmx:Pq30Y4nHyP4jNtyJ_NV8Ob2atwcs_reVNKG2qA8UkRHr_j5OM5Iq5g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 06:38:37 -0500 (EST)
Date:   Tue, 21 Feb 2023 12:38:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/9] drm/vc4: Switch to container_of_const
Message-ID: <20230221113834.i3nitxp4soev6cks@houat>
References: <20221207-rpi-hdmi-improvements-v2-0-8ace2d8221ad@cerno.tech>
 <20221207-rpi-hdmi-improvements-v2-1-8ace2d8221ad@cerno.tech>
 <c70e40fe-6834-2382-ec89-28714a67fd1f@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c70e40fe-6834-2382-ec89-28714a67fd1f@xs4all.nl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Sat, Feb 18, 2023 at 11:45:04AM +0100, Hans Verkuil wrote:
> > diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> > index 86d629e45307..d0a00ed42cb0 100644
> > --- a/drivers/gpu/drm/vc4/vc4_bo.c
> > +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> > @@ -609,7 +609,7 @@ static void vc4_free_object(struct drm_gem_object *=
gem_bo)
> >  static void vc4_bo_cache_time_work(struct work_struct *work)
> >  {
> >  	struct vc4_dev *vc4 =3D
> > -		container_of(work, struct vc4_dev, bo_cache.time_work);
> > +		container_of_const(work, struct vc4_dev, bo_cache.time_work);
>=20
> ...I think this is misleading. It's definitely not const, so switching to
> container_of_const suggests that there is some 'constness' involved, which
> isn't the case. I'd leave this just as 'container_of'. This also reduces =
the
> size of the patch, since this is done in quite a few places.

The name threw me off too, but it's supposed to keep the argument
pointer constness, not always take and return a const pointer. I still
believe that it's beneficial since, if the work pointer was ever to
change constness, we would have that additional check.

Maxime
