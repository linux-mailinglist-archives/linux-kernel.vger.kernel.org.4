Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A56D558A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjDDA2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjDDA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:28:31 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D49224200
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ANyDg
        UlFZw2AcrRV0IxQJ2iSMTL1341z+Q8L+rwAzTE=; b=bnFrPf4g/1eGQ5GM+txOl
        L9v3oao7JSDyNHhLfO9muKJKnaZOpyGlLXZrwXDSOqj5fWD90oOXEgoFGOKoYcgf
        C/mDvGe8NL/2xOGRSt9faROU+oenyWvM68q2mdAIBASosAEN+IwlyLB/ZfToePIe
        F1Xml34YNvIlQ0JEsItgnk=
Received: from yuq-Aspire-4738G.lan (unknown [116.225.76.16])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wBHK4Tkbitk8woAAg--.8076S2;
        Tue, 04 Apr 2023 08:27:24 +0800 (CST)
From:   yq882255@163.com
To:     dri-devel@lists.freedesktop.org
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 0/3] Revert lima fdinfo patchset
Date:   Tue,  4 Apr 2023 08:25:58 +0800
Message-Id: <20230404002601.24136-1-yq882255@163.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHK4Tkbitk8woAAg--.8076S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1xJrW5GF43Gw4xury5XFb_yoWfGFX_Ga
        y7JFy7WF1UAF1qyw17XwsrWryYka42vFZ5Jw1Uta9akry3Zr1DZr1DGrW5XryUXF42yF1k
        Ja10vF1fXanagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8lApUUUUUU==
X-Originating-IP: [116.225.76.16]
X-CM-SenderInfo: d1tymjqsvvqiywtou0bp/1tbiVg1HGlqzxIGuIAAAsk
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiang Yu <yuq825@gmail.com>

Upstream has reverted the dependant commit
df622729ddbf ("drm/scheduler: track GPU active time per entity""),
but this patchset has been pushed to drm-misc-next which still
has that commit. To avoid other branch build fail after merge
drm-misc-next, just revert the lima patchset on drm-misc-next too.

Qiang Yu (3):
  Revert "drm/lima: add show_fdinfo for drm usage stats"
  Revert "drm/lima: allocate unique id per drm_file"
  Revert "drm/lima: add usage counting method to ctx_mgr"

 drivers/gpu/drm/lima/lima_ctx.c    | 30 +--------------------
 drivers/gpu/drm/lima/lima_ctx.h    |  3 ---
 drivers/gpu/drm/lima/lima_device.h |  3 ---
 drivers/gpu/drm/lima/lima_drv.c    | 43 +-----------------------------
 drivers/gpu/drm/lima/lima_drv.h    |  1 -
 5 files changed, 2 insertions(+), 78 deletions(-)

-- 
2.25.1

