Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9186771A0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjAVSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjAVSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:46:07 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1C1F484
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674413155; bh=J41ioDWqknlOzdipOF5sD31nhNZl3NF7T0hUSNvNhsI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=f2vIwTa7gBjC8QW6zWihuU2CxvUGZIQ4lWSAAJlEknZHH1gQPn/chKhj0P2B3ADr3
         6ljtIFr4O7T2RQiDTIMJkNU+erNDHvRrCizCJoNWofiZJE97w1pYFTWD6mQuSCJVY7
         e3+tYz4LnDkCixQalsK1OwmPlwBwutWHkDA8qCwM=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 19:45:55 +0100 (CET)
X-EA-Auth: LxLdcSa5DAPkBdm3lAE5Zi4Ztr6lojNLOTcMK4tmNwTIrMEaL45b16ba2tEHLBsIZr6K+6GtA76prZjHrpgzJvjUV0jW4QZq
Date:   Mon, 23 Jan 2023 00:15:50 +0530
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
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH 0/4] drm/amd/display: Use min()/max() helper macros
Message-ID: <Y82EXrIgJyJTVAFk@ubun2204.myguest.virtualbox.org>
References: <cover.1673730293.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673730293.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 02:48:45AM +0530, Deepak R Varma wrote:
> This patch series proposes using standard min() / max() helper macros instead of
> direct variable comparison using the ternary operator or if/else evaluations. I
> have tested the change using a dummy module and similar simulations on my x86
> machine.

Hello,
May I request a review feedback and comments on this patch set please?

Thank you,
./drv

> 
> Deepak R Varma (4):
>   drm/amd/display: Use min()/max() macros in dcn_calc_math
>   drm/amd/display: dcn20: Use min()/max() helper macros
>   drm/amd/display: dcn21: Use min()/max() helper macros
>   drm/amd/display: dcn32: Use min()/max() helper macros
> 
>  .../gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c   | 10 +++++-----
>  .../drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c |  5 +----
>  .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c   |  5 +----
>  .../drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c |  5 +----
>  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  4 ++--
>  5 files changed, 10 insertions(+), 19 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
> 


