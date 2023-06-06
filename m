Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB8724B12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjFFSTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbjFFSTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:19:08 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE1A171D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686075501; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=a3zzGU4AUePU6Z+r1xA8rSonmH/wrgblgWTY+4R3F2pKzSezF6+rtgXSB+97ziYeaBL1LRzzvKjjYzLDoLs7uBrkrzWn8CgYXUq4DYMyePqIBm3B1RBOYBMUd4aOW6nuA8BfYDcy1Fsp0AcuxKChDWKO2Ip7/Vbi81pvuDrw9hM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686075501; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=RjUGwLLClgouRbL86uwY1TLqSDBa8rqBZ+WH4dlvYhI=; 
        b=O18pC2SS76gPzfdzk5MOkdq7pL6movvd/9UOtCearhQnLA2F3EkbJTt7PGeHmTrSOHJdFrxQBdQaqrO0nRCqFRX1mF4ytXAQqY99PoSVrrFVyi7JAeewkZIYsS12vHjRt+M0M7oF0tby/Jq2EZh+3t4TGYHWUVZ8jEi7y+qzl4U=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686075501;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=RjUGwLLClgouRbL86uwY1TLqSDBa8rqBZ+WH4dlvYhI=;
        b=Rcu1ZTigMmuf5GfDOlGQAr/bRxFM8fTZuM6SSpB73xPn9e4TtbaoyqflsRWKkjl0
        ImV5EHhV0CwBEAXKnSt+sOO15GP63f2/c/Uvu41lndQBDfYJ8Z4IXsqjyEWQEUU2y+I
        PzTFoD3j7bL6B1jC9KlOa8mioyFOqnts18BZFQzg=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686075470109128.45647873619112; Tue, 6 Jun 2023 23:47:50 +0530 (IST)
Date:   Tue, 06 Jun 2023 23:47:50 +0530
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
Message-ID: <18891edf10b.42f0ffa4128414.8582548531031990480@siddh.me>
In-Reply-To: <20230606174928.GB14101@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <20230606150545.GJ5197@pendragon.ideasonboard.com>
 <18891c17458.393a54b1127185.1502341592143085000@siddh.me> <20230606174928.GB14101@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 0/8] drm: Remove usage of deprecated DRM_* macros
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

On Tue, 06 Jun 2023 23:19:28 +0530, Laurent Pinchart wrote:
> The idea would be to include the drm_print_deprecated.h header in
> drivers that still use the deprecated macros.

Yeah, what I meant was in a "first pass" kind of sense.

> > Not every file can be seen at a case-by-case basis or by coccinelle
> > as far as I understand its usage. Consider the following:
> > 
> > DRM_INFO is used on line 210 of amd/amdgpu/amdgpu_acpi.c, but the
> > file does not even include drm_print.h directly. It includes the
> > amdgpu.h header, which includes the amdgpu_ring.h header, which
> > finally has the "#include " line.
> > 
> > If a simple find and replace has to be done, then that can be added
> > at the end of the series.
> 
> Maybe a simple grep for the deprecated macros would be enough to
> identify all the files that still use them ?

Hmm, so the drm_print_deprecated.h should be included individually on
all the files, regardless of whether they include drm_print.h directly
or not?

Actually that makes sense, so further inclusion of top-level header
would not automatically include the deprecated macros.

Since this needs some thought, I will be sending v10 without this.
This change can be sent later separately, as it will anyways be a
huge patch, and 10 is already a big enough revision number.

Thanks,
Siddh
