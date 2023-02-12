Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D796936FC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBLLV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:21:55 -0500
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED266E393
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:21:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C4063FB03;
        Sun, 12 Feb 2023 12:21:50 +0100 (CET)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CFLzvt03jpiR; Sun, 12 Feb 2023 12:21:49 +0100 (CET)
Date:   Sun, 12 Feb 2023 12:21:48 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] drm/panel: st7703: Fix initialization failures on
 Xingbangda XBD599
Message-ID: <Y+jLzCUyno4A+SiD@qwark.sigxcpu.org>
References: <20230211171748.36692-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230211171748.36692-1-frank@oltmanns.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Thanks for giving this another spin!

On Sat, Feb 11, 2023 at 06:17:47PM +0100, Frank Oltmanns wrote:
> This patch fixes intermittent panel initialization failures and screen
> corruption during resume from sleep on panel xingbangda,xbd599 (e.g.
> used in PinePhone).
> 
> It was originally submitted by Ondrej Jirman in July 2020:
> https://lore.kernel.org/all/20200716123753.3552425-1-megous@megous.com/
> 
> The original patchset contained two patches. One of them broke the panel
> on the Purism Librem 5.

Just for completeness: It's the Librem 5 Devkit, the Librem 5 uses the
mantix,mlaf057we51-x panel.

> This is the concluding message from Guido Günther in that thread:
> https://lore.kernel.org/all/20200801110409.GA6351@bogon.m.sigxcpu.org/#t
> 
> Guido wanted changes to the commit message. I updated it to adress his
> requests.
> 
> I send this patch in Ondřej's name with his consent.
> 
> The patch is based on drm-next.
> 
> Please let me know what you think.

I'll retest this on the devkit on the next days, might be a moment until
I get to that.

Cheers,
 -- Guido
