Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D265645E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLZRrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 12:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLZRrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 12:47:23 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D24FEA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 09:47:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672076792; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=bAlhL7aP3fsjeUrpqp1Pn13A7PMswn4rjjDEuTx8nP41bqM1a4ho9fuAP3Rmk6LkKzHn+OOYEwcV1ZIgzJ3I4PHInsBgRMb+5WBrp1t+oz0aOIUJHPzu8FypiMpfZqxyN/fV3XdXmrkVgbM1f4XyLs5Mkj2kOS5UzBzD2+tXMyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672076792; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dwtLWmXNxflBjaV4qEHidkeaPv4mAwUVJoiUFTomIn4=; 
        b=HBAgciBeGMlOgQvChEQOqwJKEhnKN/hlyf2xFDM78t672dAqr28UV28TaOzh5v6XkyorLAJd3yibnVlAL/dFrCDozJvNE7oAudTGybuByq8zNvHkxPbILzrcYLfbxOBAbVM/A9QyZs1M0+byIV7HcvQPABEDvNmK+BDKmYA58F4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672076792;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=dwtLWmXNxflBjaV4qEHidkeaPv4mAwUVJoiUFTomIn4=;
        b=WdSQ/xrqe/WrDZDhLH/6/sZFDczmij3zCcnuSLBprXO408u9iHVvxPNxj0kErfFc
        dtROgvDBXvtBhgvSEsQwRLxJXt6gU916ShlcOzk8UOgd2KV29Bqswtmh356lHEb7Bng
        PEdn8NBwWPH3Ssx+KBAsWDuhJYFAFH3+AvWK2yWI=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1672076781143688.1686966549753; Mon, 26 Dec 2022 23:16:21 +0530 (IST)
Date:   Mon, 26 Dec 2022 23:16:21 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Simon Ser" <contact@emersion.fr>
Cc:     "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1854f8ae643.39d1e908319811.6354420860669945497@siddh.me>
In-Reply-To: <cover.1671723195.git.code@siddh.me>
References: <cover.1671723195.git.code@siddh.me>
Subject: Re: [PATCH v2 0/9] drm: Remove usage of deprecated DRM_* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 21:10:34 +0530, Siddh Raman Pant wrote:
> Changes in v2:
> - Removed conversions to pr_*() in DRM_INFO, DRM_NOTE, and DRM_ERROR changes.
> - Due to above, DRM_NOTE usage cannot be removed and the patch is dropped.
> - DRY: NULL support is now achieved by way of a separate function.

I just noticed I forgot to change commit message mentioning pr_*()
after squashing. Apologies for this.

I will send a v3, rebased to drm-misc-next, and also fixing the docs message
pointed out by robot, as well as supporting NULL so pr_* stuff can be moved
to drm_*(NULL, ...).

Thanks,
Siddh
