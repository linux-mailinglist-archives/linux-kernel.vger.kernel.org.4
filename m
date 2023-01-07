Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229D661198
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjAGU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjAGU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:29:46 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A7E34D62
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673123377; bh=Vg0zzi0E4maI0sKskX31d41VWY8Rj+KdJklhQyGkCH8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=T2u91W+pNODLeh5YPl5ZS4JT+J7wGG9uDsaMu6/A6WU1SuHlOz6e9XkRUvL+C+8Wf
         FkJv42HLUJfAVtNIg8Sr1fIK8QV8gJyoMeiKNk+2IuQ1s2THyGGhbvj+222srLzIKd
         ir1nZlVXP1cnHlcYUhw1lnhR4l1EYMJb+SwMk22I=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:29:37 +0100 (CET)
X-EA-Auth: OzqmESPCaOU6ngWC3y6TpSCEfwulT5b4cksaLF7iCWZtq0pZYGLMADrUbXuJKrnxWltvMrYDQAjp4SM7nrIKEOCgddREdgr4
Date:   Sun, 8 Jan 2023 01:59:28 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/amd/display: No need for Null pointer check before
 kfree
Message-ID: <Y7nWKNyggmf/HXj2@ubun2204.myguest.virtualbox.org>
References: <Y6s7989gmBZldV/S@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6s7989gmBZldV/S@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:09:51AM +0530, Deepak R Varma wrote:
> kfree() & vfree() internally performs NULL check on the pointer handed
> to it and take no action if it indeed is NULL. Hence there is no need
> for a pre-check of the memory pointer before handing it to
> kfree()/vfree().
>
> Issue reported by ifnullfree.cocci Coccinelle semantic patch script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
Requesting a review and feedback on this patch proposal.

Thank you,
./drv



