Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885F3724A04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbjFFRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbjFFRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:18:47 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A88121
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686071885; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=fat7aSr4hP7KZUIDjnmaT5q10X8sLQ87y3yxhCyaO4Cy1OjSCktPm4rH7BH6N89E+PHbIdEz5b6SAsDjdQ2jcjGtlvXjy3wt4Uj89Tf6WDXGUc0+kv89ZXFYBt3meCwvZLYogSdDZHW1JrJzgOjaE/3ncIhV4bRqquaTGpb/D84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686071885; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VOaURRjH+j7FHRo0DEicjaVzmUpKTc9dyQo++kOw5nI=; 
        b=EI1AQzRPA1IysWg5SJklywj2qmICt/Hd+E22I51qVSrsZiPhToscXAAfg0d9Xj2qkRo/w5Zf3vSyLZPKG9vEXgZEVxO6MdbR5d6uv0fAb+NKA4cMeEh6P3unYDHZn7ysU46fUEvvbEsA152YHKFe3hzSBDdR14N3z0mQmKko3W4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686071885;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=VOaURRjH+j7FHRo0DEicjaVzmUpKTc9dyQo++kOw5nI=;
        b=n6vmOER6lo3pzoJdfV8wVRZFtukttrChH9NKMaNShkLglV2crsPtDAXDGgCQdk/h
        8XJ/zIB1ezfvfbpr3OBVpOjJiXpiBWUy0F9QIv+E7Xy/Zqk1v5AHIzk0EGsYluOVmNP
        xkwQWU1vbupb87A+RCjuegfc9MM3jZkyGEgzak7Y=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686071852876938.8904790603814; Tue, 6 Jun 2023 22:47:32 +0530 (IST)
Date:   Tue, 06 Jun 2023 22:47:32 +0530
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
Message-ID: <18891b6bf3c.4ebd5fab126863.7291537060970485946@siddh.me>
In-Reply-To: <20230606150419.GI5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <35bd95856a69f141640c27ea2b5e4073275032f7.1686047727.git.code@siddh.me> <20230606150419.GI5197@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 8/8] drm: Remove usage of deprecated DRM_DEBUG_KMS
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

On Tue, 06 Jun 2023 20:34:19 +0530, Laurent Pinchart wrote:
> Hi Siddh,
> 
> Thank you for the patch.

Anytime :)

> > -   DRM_DEBUG_KMS("\n");
> > +     drm_dbg_kms(dev, "\n");
> 
> This message is pretty useless, it could be dropped on top of this
> series.

Okay.

> > -   DRM_DEBUG_KMS("\n");
> > +     drm_dbg_kms(NULL, "\n");
> 
> Same.

Okay.

> > -   DRM_DEBUG_KMS("\n");
> > +     drm_dbg_kms(&dbidev->drm, "\n");
> 
> Same.

Okay.

> With the commit subject fixed,
> 
> Reviewed-by: Laurent Pinchart laurent.pinchart+renesas@ideasonboard.com>

Thanks,
Siddh
