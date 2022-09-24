Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5065E8CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIXNCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIXNCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 09:02:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16C9E2E8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 06:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C5DFB80EA9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 13:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B9C433C1;
        Sat, 24 Sep 2022 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664024557;
        bh=f9TI+zLW1k/oFp4jM/JMZaUsym4/RFdsc3oPkp8gl1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vITOSzQTGC/YMameL61MhoY34yQPY9hA/15BiGXn3DaQb0P/4ieDqrLxOzgFJD/EC
         OaJ5R8dLDwURtAdRo2n3a07T27JXSXU6D94vXm+uPBGbELv+Mk6Qeh0ckggaTKWgi3
         NCAIw6POslOurSMVto1kITZtI4YmGXRMz+l4pFeQ=
Date:   Sat, 24 Sep 2022 15:02:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH v7 0/9] dyndbg: drm.debug adaptation
Message-ID: <Yy7/6oTBW2lqVSK1@kroah.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912052852.1123868-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 11:28:43PM -0600, Jim Cromie wrote:
> hi Greg, Dan, Jason, DRM-folk,
> 
> heres follow-up to V6:
>   rebased on driver-core/driver-core-next for -v6 applied bits (thanks)
>   rework drm_debug_enabled{_raw,_instrumented,} per Dan.
> 
> It excludes:
>   nouveau parts (immature)
>   tracefs parts (I missed --to=Steve on v6)
>   split _ddebug_site and de-duplicate experiment (way unready)
> 
> IOW, its the remaining commits of V6 on which Dan gave his Reviewed-by.
> 
> If these are good to apply, I'll rebase and repost the rest separately.

All now queued up, thanks.

greg k-h
