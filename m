Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E33729B33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbjFINNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbjFINNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:13:35 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584191A4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686316355; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cuRz/wB0oHBkLui5lqe56bz2MX6+c13PeXX1nM6bbq7OfD1AtjgwZwlCekXjUAeFg9mzwhp3dT4k7Mp5vySvQOPL3C9vuW8sz9mvP6Zll701qUWNgTR0EfCElGNjPc1KCiDHNBvsbZo2e/WEy6bCILejYYuEN6mI5TbScW7sebU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686316355; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0wR1QW2HWcPSLyYbi6wbjalDMT14PCeAcN2byXJtA9M=; 
        b=KCu+ts5342GaIIvf415bG6PbySc0j8+Of6KyO7FRKs+DT0BP4WjZlrPSHyhhGWjgPnzOMZWMtzMF0WvntGnlAXX+AMCKQG5z0+FjIU9Qgx7BXT+Ped/fnxF3sAbvVBYv8F0YF2g8OqozRV3ArkZy+jhKLV4aO1/LvwR46IlX368=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686316355;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=0wR1QW2HWcPSLyYbi6wbjalDMT14PCeAcN2byXJtA9M=;
        b=mmGoD3PrOVO9TbHl20Tsc8fbhRqaA/RUAvVt/fzgfg6Ks0wgJsjFUPiDEuqu0FHN
        c0xrXyzAeYZVzYQAfnkcPLtVhSEQAMGSQMNObLCKDHb+gTlMQUL9r1cDWvqgj7RnuAO
        syZf4JEioxMGGe9i1t+1EwCSkR/MpbCRxT76l4yk=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 168631632304450.447001692476306; Fri, 9 Jun 2023 18:42:03 +0530 (IST)
Date:   Fri, 09 Jun 2023 18:42:03 +0530
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
Message-ID: <188a04910ce.618ad5d6114734.6174984142831512776@siddh.me>
In-Reply-To: <35def11d3722b361bc394c3d297adea922db5fd9.1686075579.git.code@siddh.me>
References: <cover.1686075579.git.code@siddh.me> <35def11d3722b361bc394c3d297adea922db5fd9.1686075579.git.code@siddh.me>
Subject: Re: [PATCH v10 9/9] drm: Remove superfluous print statements in DRM
 core
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

On Wed, 07 Jun 2023 00:00:10 +0530, Siddh Raman Pant wrote:
> There are a couple of superfluous print statements using the drm_*
> macros, which do stuff like printing newlines, print OOM messages
> (OOM while allocating memory is already supposed to be noisy), and
> printing strings like "Initialised" with no extra info whatsoever.
> 
> Thus, remove a couple of these superfluous strings.
> 
> Suggested-by: Laurent Pinchart laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Siddh Raman Pant code@siddh.me>

This patch is the only one introducing these changes additionally,
no other patch content has been changed from v9 and sent for merge.
I should have clarified this in the cover.

This patch may or may not be dropped, courtesy follow-up discussion on
v9 regarding it: https://lore.kernel.org/lkml/87jzwfu1wf.fsf@intel.com/

Thanks,
Siddh
