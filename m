Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EBA66AE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjANVTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjANVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:19:01 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268589EC4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673731129; bh=3TmlAYNT5GDcotyrQzGG/ieTPPZo+e5QhheiYHUPMHY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=AvFRc7+n8i2Nw7E7jr053MWfQ3L+4QV74ebbNGgh02HmrJS7l7Ud4DhvINXL/0abD
         pfbHyHPNKw3yfeQF7xMqkoAxrEXgf1UW5/Ppm5I9Tlo8QvjFoTFObGTT4k/DRHt8+o
         V1ULwSMTT30mchpwgC2/Sju75f070DoziBcPsp74=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 14 Jan 2023 22:18:49 +0100 (CET)
X-EA-Auth: uVnKFoCMuV/obeMLZg8OScqnQxIJEr+NAWTtfpnll7R0imO4Icz5jqfWj1Y0SEym1IVEkawUgpbFlxBdodPz4zy952dcvsaR
Date:   Sun, 15 Jan 2023 02:48:45 +0530
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
Subject: [PATCH 0/4] drm/amd/display: Use min()/max() helper macros
Message-ID: <cover.1673730293.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series proposes using standard min() / max() helper macros instead of
direct variable comparison using the ternary operator or if/else evaluations. I
have tested the change using a dummy module and similar simulations on my x86
machine.

Deepak R Varma (4):
  drm/amd/display: Use min()/max() macros in dcn_calc_math
  drm/amd/display: dcn20: Use min()/max() helper macros
  drm/amd/display: dcn21: Use min()/max() helper macros
  drm/amd/display: dcn32: Use min()/max() helper macros

 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c   | 10 +++++-----
 .../drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c |  5 +----
 .../amd/display/dc/dml/dcn20/display_mode_vba_20v2.c   |  5 +----
 .../drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c |  5 +----
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  4 ++--
 5 files changed, 10 insertions(+), 19 deletions(-)

-- 
2.34.1



