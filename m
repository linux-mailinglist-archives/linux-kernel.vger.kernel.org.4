Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9162D372
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiKQG3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiKQG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:29:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4476B23A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6171620AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F55C433D6;
        Thu, 17 Nov 2022 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668666554;
        bh=k7mSpJJ0WM6ewes40AUp3GUJji+8y5DOYEMIWFBBoEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJ8QBLnMiZ4mKv7YRncrXPoLUYkMOvxv0AEKeJ4mEiAuKHxVrB0jkpuaS0lOdZiS1
         XA6SHPwNyF3LP/PUz9Mrobo6+cO8IozvOnVijp3bf6sBgb1MIIxTBWol7n5CnhOl/2
         IFsAYnPcafc3vKUzAL/IaT97mSlVQg2fjBJZ+rnw=
Date:   Thu, 17 Nov 2022 07:29:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH 0/7] DYNAMIC_DEBUG fixups for rc
Message-ID: <Y3XUtx2JUIuQLNmU@kroah.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20221111221715.563020-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111221715.563020-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:17:08PM -0700, Jim Cromie wrote:
> hi Jason, Greg, DRM-folk,
> 
> drm.debug-on-dyndbg has a regression due to a chicken-&-egg problem;
> drm.debug is applied to enable dyndbg callsites before the dependent
> modules' callsites are available to be enabled.
> 
> My "fixes" are unready, so lets just mark it BROKEN for now.
> 
> Meanwhile, heres some other fixes, a comment tweak, a proof of
> non-bug, an internal simplification, and a cleanup/improvement to the
> main macro (API):
> 
> Split DECLARE_DYNDBG_CLASSMAP in 1/2; REFERENCE_DYNDBG_CLASSMAP now
> refers to a classmap DECLARE'd just once.  I think this gives a path
> away from the coordination-by-identical-classmaps "feature" that Jani
> and others thought was "weird" (my term).
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
