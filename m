Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91F7246BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjFFOsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjFFOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:47:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3583210A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:46:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8340283;
        Tue,  6 Jun 2023 16:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686062763;
        bh=pw45dOR/x1K4kscKK9p3R+j5WFm9Dixeih/5F+y5akk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdSbk7awKDLtnNr/g4kU7IPzYXD9no+P/5N6x5tZ9gpNxQMR3H+7AZlOUvLuk0o/b
         KBkMOjTXLca7j5q28EfL8UFiYgC4VntqgNOhm2OfVTJUuJYLMDY1ViqxFTofJ0kHJy
         lm/0dee3uG0i4cddQi5qoKDjh8xw47owA/IhERfc=
Date:   Tue, 6 Jun 2023 17:46:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 3/8] drm: Remove usage of deprecated DRM_INFO
Message-ID: <20230606144625.GF5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <52c8eb0f241a9d67ce5b7e6fc64dc397e735ccd8.1686047727.git.code@siddh.me>
 <20230606142322.GB5197@pendragon.ideasonboard.com>
 <1889125187d.5d36766d120183.6659725053490512400@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1889125187d.5d36766d120183.6659725053490512400@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:08:27PM +0530, Siddh Raman Pant wrote:
> On Tue, 06 Jun 2023 19:53:22 +0530, Laurent Pinchart wrote:
> > Hi Siddh,
> > 
> > Thank you for the patch.
> 
> Anytime :)
> 
> > Any plan to remove it from drivers as well ? If not you should mention
> > in the commit message (probably in the subject line itself) that you're
> > only addressing the DRM core.
> > 
> > Same comment for further patches in this series.
> 
> Yeah, this patch set aims to replace just in drm core (as mentioned in
> the cover).
> 
> I thought "drm" would suffice since I did not specify a specific driver
> like i915. So the subject line should say "drm core: ..."?

I would write

drm: Remove usage of deprecated DRM_INFO in DRM core

The "drm: " prefix doesn't imply you're touching the core only, you
could do a tree-wide change that also touches all drivers.

-- 
Regards,

Laurent Pinchart
