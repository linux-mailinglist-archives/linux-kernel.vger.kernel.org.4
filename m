Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41C7249D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbjFFRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjFFRH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:57 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC61736
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686071216; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=TeqIs6VNP33WxwuTKd12ENO3dx+DVRpR7YgKZTYY43iBeORMFWwHbjzOr9hl5Cf001YaW4UjAiu4pdCT/6Odxps86kwVxjsBHFYpZ0LvIUTzOhQnjAogSoxQDITW1FaZflMTl4xnh2xbsIJzaQANupP1xCGLfTcl8QGERjuazmw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686071216; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Skp2Jt0s0n1zpvQS9KKzyWhrNJUPXxN9cPVb5N8Tvco=; 
        b=Vht/F9pHnqkVRJeKfqeciQnNKw0wVcuG2foUXN0oFjFGFfxtZrZbyOKlUaJIj1g+eFrpoPDIJvCjaJRsKagZnkQHNR0d3ctEiFZpg5NN26SEYFNlB5H0EEvkL330Nu6no237NwM78Dqo1o7RT5FeE9OCk8zBacZPt8nlezwhbXM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686071216;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Skp2Jt0s0n1zpvQS9KKzyWhrNJUPXxN9cPVb5N8Tvco=;
        b=B0BofOy6bRg7j6QAEE+5bE4n2TlzP+xKANhf3K8Gzu/zqSLSY1wTM5rs1QPhgeJx
        D2HYPQCuRfhwOrP1IcL4RQkXFroiqSIaD9hDEZ8Jg/t6VZYEphQkQwPeJ0sk5fmEyMe
        s3QBEUSenlFF0cGi9hYgc8zIwmTNMTdKUDJF10wk=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 168607118569857.07043308212849; Tue, 6 Jun 2023 22:36:25 +0530 (IST)
Date:   Tue, 06 Jun 2023 22:36:25 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Cc:     "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Andrzej Hajda" <andrzej.hajda@intel.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Robert Foss" <rfoss@kernel.org>,
        "Jonas Karlman" <jonas@kwiboo.se>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Suraj Upadhyay" <usuraj35@gmail.com>
Message-ID: <18891ac9112.109b85f8126467.5521217359687209203@siddh.me>
In-Reply-To: <20230606144452.GE5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <247297c1171bc0ddbde0e90d33961fd5636caf0f.1686047727.git.code@siddh.me> <20230606144452.GE5197@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 5/8] drm: Remove usage of deprecated DRM_ERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 20:14:52 +0530, Laurent Pinchart wrote:
> Hi Siddh,
> 
> Thank you for the patch.

Anytime :)

> >       if (!crtcs || !modes || !enabled || !offsets) {
> > -             DRM_ERROR("Memory allocation failed\n");
> > +             drm_err(client->dev, "Memory allocation failed\n");
> 
> We could probably drop this message as memory allocation functions are
> already vocal on failure, but that's a separate fix.

Okay. Should I send a patch at the end of the series removing the
superfluous messages you pointed out in drm core?

> >       if (!drm_core_init_complete) {
> > -             DRM_ERROR("DRM core is not initialized\n");
> > +             drm_err(NULL, "DRM core is not initialized\n");
> 
> Could this use dev ?

No, the drm_device's dev pointer is assigned later. See line 621.

> >       if (!vma_offset_manager) {
> > -             DRM_ERROR("out of memory\n");
> > +             drm_err(dev, "out of memory\n");
> 
> Same here, I think the message could be dropped.

Okay.

> >       if (!ht->table) {
> > -             DRM_ERROR("Out of memory for hash table\n");
> > +             drm_err(NULL, "Out of memory for hash table\n");
> 
> Same.

Okay.
 
> With the commit message fixed as mentioned in the review of an earlier
> patch in this series, and the issue in drm_dev_init() addressed if
> needed,
> 
> Reviewed-by: Laurent Pinchart laurent.pinchart+renesas@ideasonboard.com>

Thanks,
Siddh
