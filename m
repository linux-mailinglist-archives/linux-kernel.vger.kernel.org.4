Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A27249FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbjFFRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjFFRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:17:36 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747610CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686071812; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ATrlHIcqcLpy1PBiRvhF7ACfyIJDrqdLx7VuzKLtLADdGOPy2KtrBQmZpkVvmFrCp+xhPpTnSLWxeJJbmfUJMjS7hFvOJ2V1bRhtLnl3nfDtRO2PPqnV/Sl9DVpgpIRO8JFsSjq3rPOCsdexYF/of3gPyw3kmEmeclooFO2benI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686071812; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LTxuxhAkDUTr7cvt9W2R40ESQVovz8E2KvQjnCTzwmk=; 
        b=d9jAGnc7PtqUmZhZZRmrtXcVp/0zdeiopoa1q1ktD6WxUVgD19w1lFWPbQRBwKIy5HzaKX+b04S50A+zRL5AZ+KubPNXihhtIP51FUfi8bYEWcd3nQtPKAV7Dzp+OhLJKXTig0ZeOSUm+FnGdBP1tHOmSMY1qLicdKyWajKF120=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686071812;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=LTxuxhAkDUTr7cvt9W2R40ESQVovz8E2KvQjnCTzwmk=;
        b=t5SOgODmJS0mdusxjbfc+2BsRCB66NPFEZuH/oG7AY0QbnXJ2/h/fxzA5qRwwBwr
        ExzAcXtHTkz5O5xI2ZjLunbCzmi23ZMSKQQ1KwQk6S4tdC/yKAVCAIaEE/KJ0ya2hcl
        vxGIULlPy5o8LQaJ65f7Yk7PaD/67TchBMtAWyog=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686071671472920.9108657396287; Tue, 6 Jun 2023 22:44:31 +0530 (IST)
Date:   Tue, 06 Jun 2023 22:44:31 +0530
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
Message-ID: <18891b3faa3.57976e1f126744.7700241596970251743@siddh.me>
In-Reply-To: <20230606145706.GE7234@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <3b880e4a20b7952b257b896900256fcfff14b153.1686047727.git.code@siddh.me> <20230606145706.GE7234@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 6/8] drm: Remove usage of deprecated DRM_DEBUG
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

On Tue, 06 Jun 2023 20:27:06 +0530, Laurent Pinchart wrote:
> Hi Siddh,
> 
> Thank you for the patch.

Anytime :)

> >       if (!ctx_entry) {
> > -             DRM_DEBUG("out of memory\n");
> > +             drm_dbg_core(dev, "out of memory\n");
> 
> This message could also be dropped.

Okay.

> > -     DRM_DEBUG("\n");
> > +     drm_dbg_core(dev, "\n");
> 
> This message seems of dubious value :-) Maybe you could drop it in a
> patch on top of this series ?

Okay.

> > -     DRM_DEBUG("\n");
> > +     drm_dbg_core(NULL, "\n");
> 
> This is even worse :-) The next two messages are also fairly useless,
> they should be expanded, or dropped.

Okay.

> > -     DRM_DEBUG("\n");
> > +   drm_dbg_core(dev, "\n");
> 
> Ditto.

Okay.

> > +   drm_dbg_core(dev, "\n");
> > +
> 
> Same, and the two messages below too.

Okay.

> > -   DRM_DEBUG("\n");
> > +     drm_dbg_core(dev, "\n");
> 
> Here too.

Okay.

> With the commit subject fixed,
> 
> Reviewed-by: Laurent Pinchart laurent.pinchart+renesas@ideasonboard.com>

Thanks,
Siddh
