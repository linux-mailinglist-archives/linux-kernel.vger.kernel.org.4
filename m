Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683466AF99
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 08:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjAOHQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 02:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjAOHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 02:16:10 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95994ED3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 23:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673766960; bh=k5POMcfBwYa5wr18jkQ33y/uNrey1LaJ5KoUUlzdv6A=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=LopZqf+yn1hhl0YuM6zkt2JTOg5AETKGr2sYtd1YDkX3LFcc0/mpG+HA27CTeandU
         C1XwxHwcbLUiL4I9ZHdOABKVLiT7lTn8cV8arwrwZG8YSEgUdOHx4oD+Fi6qYec/uZ
         zq1uKOAPSDBqEoe+qOuT7cZSKA8JFgKO7RAOrxbk=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 15 Jan 2023 08:15:59 +0100 (CET)
X-EA-Auth: pNsW6gMqAA4UK+pay/T5Ic7nnC99FGL29jntdCvEEt0A2pa31p9Ixh21ivPxrrsr4A2rD8nmlS2jy69Y6D2ZZDT3/yrs+LLn
Date:   Sun, 15 Jan 2023 12:45:54 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH 0/3] drm/amd/pm/powerplay: use bitwise or for bitmasks
 addition
Message-ID: <cover.1673766696.git.drv@mailo.com>
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

The patch series proposes usage of bitwise or "|" operator for addition of
bitmasks instead of using numerial additions. The former is quicker and cleaner.

The proposed change is compile tested.

Deepak R Varma (3):
  drm/amd/pm/powerplay/smumgr: use bitwise or for addition
  drm/amd/pm/powerplay/hwmgr: use bitwise or for bitmasks addition
  drm/amd/pm/powerplay/smumgr/ci: use bitwise or for bitmasks addition

 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c      | 8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c      | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1



