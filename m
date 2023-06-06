Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCDE724642
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbjFFOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjFFOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:36:07 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED1E6C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686062111; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=FoV90p8s7KGaX/AFXXGRhVbKUQdUKO2sbtjs5ppLjap3oUZw8CqU+N13Wg3aTYAqRPSZAi52hCdPoxdrkrOwiYQ5AzBPtnP7KBKbv8QXVhczksabmfWjJpcZdJ8NRP3SNi67eOCUejoRpbRx4e8Wxb/kgExij9EA8zBwObstuKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686062111; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nhq6ObVRtO0F/91ipiCPjsG/qJ9zJ64B4gXqedyDihU=; 
        b=PjoWZh7AMGFCsBVZgB5ttbmU3/UHrqT7dv0aiYmOX0OhmemYaEErbOG3EjlW8rgKrHDQ/7zW/LztC/9GbkVrbn6V3JbMaX2TiwYXAHUn7+68S8Su7m+ClVcaPRysuB8hRgrn1/BV39vdyNbfVRBuAJHoaziuXXAb3MrZoluFTSg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686062111;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=nhq6ObVRtO0F/91ipiCPjsG/qJ9zJ64B4gXqedyDihU=;
        b=ea4aSFICrqljBDAllkvvJUzxGaPmplAPZ2LzUC+BO7tT/ohYqTLT90xsiK+dbii2
        G+X3unpnzvNEFHfaUCzqdTkb2dSbphflmz6Gdhhk12QxbnLMaT8QSH3X1Jw+yqwY3Nt
        45IOMsAysJn4VEi895FZ3m3qQ2P5s7v40DmzhDXU=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 168606207938986.73514266463042; Tue, 6 Jun 2023 20:04:39 +0530 (IST)
Date:   Tue, 06 Jun 2023 20:04:39 +0530
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
Message-ID: <18891219d8e.6a7d8f15119986.32609419593331086@siddh.me>
In-Reply-To: <20230606140512.GA5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <ae42791195a788bb77b3f9c2b87bca5d4e78cf83.1686047727.git.code@siddh.me> <20230606140512.GA5197@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 2/8] drm/print: Fix and add support for NULL as first
 argument in drm_* macros
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

On Tue, 06 Jun 2023 19:35:12 +0530, Laurent Pinchart wrote:
> Hi Siddh,
> 
> Thank you for the patch.

Anytime :)

> On Tue, Jun 06, 2023 at 04:15:16PM +0530, Siddh Raman Pant wrote:
> > Comments say macros DRM_DEBUG_* are deprecated in favor of
> > drm_dbg_*(NULL, ...), but they have broken support for it,
> > as the macro will result in `(NULL) ? (NULL)->dev : NULL`.
> 
> What's the problem there ?

(NULL)->dev is invalid C. It's a macro, so preprocessor substitutes
that text directly, there is no evaluation. GCC will throw an error
regarding dereferencing a void* pointer.

> >  /* Helper for struct drm_device based logging. */
> >  #define __drm_printk(drm, level, type, fmt, ...)                     \
> > -     dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
> > +({                                                                   \
> > +     struct device *__dev_ = __drm_dev_ptr(drm);                     \
> > +     if (__dev_)                                                     \
> > +             dev_##level##type(__dev_, "[drm] " fmt, ##__VA_ARGS__); \
> > +     else                                                            \
> > +             pr_##level##type("[drm] " fmt, ##__VA_ARGS__);          \
> 
> If I recall correctly, dev_*() handle a NULL dev pointer just fine. Do
> we need to manually fall back to pr_*() ?

I took drm_dev_printk (on line 261 of drm_print.c) as the reference,
wherein it uses a conditional for determining whether dev_printk or
printk should be called.

I suppose it is to avoid printing "(NULL device *)", which dev_printk
does if it gets a NULL device pointer (refer the definition on line
4831 of drivers/base/core.c). Though if I'm wrong, kindly let me know.

Thanks,
Siddh
