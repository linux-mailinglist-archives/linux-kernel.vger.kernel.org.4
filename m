Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28974CB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGJEwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:52:32 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46CBC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688964698; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=fgwd97yxrPrgATJIdwxjt/d0Q0XZyVoN8Ax1Rrb8mNSHOXnYHgWSHG078neBMnXN3gqZLLq+oRAhmT6SgjuA4UMF/Ht3tP/ZwzNFXeuBBzq9QV9Lzg0CeCKANDJr0QiFm+cW08aXV3DKZ1afQp+rDN7u5eKW50lJXxQEjd5EMUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1688964698; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=A1sOx1vRN495Y3gjlbsvpWyzTeXNKgYfdMBZ5lw2c1Y=; 
        b=AuTknfaiK976tJqWst3Y5Fy1xKOLq2iwWiKhtMLJJCfAcdiLBOCVNvqUSN2FzdCt0RB9EqTtxIe5ZdNg25T1cgUwDLDYyu6eDD2rJorLvbup9yFTEplPxPz7O0TdtC/kiid1bWx3nO0qe0HsN9EE34Jzk/328K7VU3mNby2HnjI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688964698;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=A1sOx1vRN495Y3gjlbsvpWyzTeXNKgYfdMBZ5lw2c1Y=;
        b=rJtRQAth5mkon1U3m528MxKIzIx++TuQXlkt0PIxv+PEKG5lLIcaC5qtoefoPGw8
        IKN8Kds0VMJ3Phr6XnAcwEnN55oO7rPvJ1j5x1gNnSGIEjJUtvwexJPUTgALRESlHg3
        ak7wWSuJxsdE/nl9fVoSZglcMCO87toFwjV0hjEQ=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1688964667784444.66076465051344; Mon, 10 Jul 2023 10:21:07 +0530 (IST)
Date:   Mon, 10 Jul 2023 10:21:07 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Andrzej Hajda" <andrzej.hajda@intel.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Robert Foss" <rfoss@kernel.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        "Jonas Karlman" <jonas@kwiboo.se>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>
Cc:     "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Suraj Upadhyay" <usuraj35@gmail.com>
Message-ID: <1893e23997e.5fd81485262265.4190071169823460284@siddh.me>
In-Reply-To: <cover.1686075579.git.code@siddh.me>
References: <cover.1686075579.git.code@siddh.me>
Subject: Re: [PATCH v10 0/9] drm: Remove usage of deprecated DRM_* macros in
 DRM core
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023 00:00:01 +0530, Siddh Raman Pant wrote:
> This patchset aims to remove usages of deprecated DRM_* macros from the
> DRM core (i.e. drivers/gpu/drm/*.c).
> 
> [...]
> 
> Siddh Raman Pant (9):
>   Revert "drm: mipi-dsi: Convert logging to drm_* functions."
>   drm/print: Fix and add support for NULL as first argument in drm_*
>     macros
>   drm: Remove usage of deprecated DRM_INFO in DRM core
>   drm: Remove usage of deprecated DRM_NOTE in DRM core
>   drm: Remove usage of deprecated DRM_ERROR in DRM core
>   drm: Remove usage of deprecated DRM_DEBUG in DRM core
>   drm: Remove usage of deprecated DRM_DEBUG_DRIVER in DRM core
>   drm: Remove usage of deprecated DRM_DEBUG_KMS in DRM core
>   drm: Remove superfluous print statements in DRM core
> 
> [...]
>  41 files changed, 463 insertions(+), 434 deletions(-)

Hello,

Please take a look at these patches I sent a while ago, and let me know
if any further changes are needed. I feel they should be good to merge
now.

All patches are reviewed once, except the last one.

Link: https://lore.kernel.org/lkml/cover.1686075579.git.code@siddh.me/

Thanks,
Siddh

