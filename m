Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B337390BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFUUZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:25:26 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046BF199B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ernyWPu0+7nqHYc1tAZva92JTMqybFI/9IABV1zvZqA=; b=RcqQB3N8ZCD34LbBIlrRS2Eaky
        kHmzJ/gJ3O14Nk1tl7iSYY4wywTYnMwL64xQRbOJwoPR9AN96p/FaMWOT5jrLwxdx99RammWMI4n4
        RKoSULDeTaHqAw5lp5YqMylV4jnCAA+Cz3DK4ggUMlnCVzmHvtxCoR2MU4USOVDTcfG1jf8rkOf22
        txN6qp2B6aTOhoHdnvlMxM7H8/4mn9rFUv4XJ0wl2FzfiIlIAsQ1x1tazb0J4CCGmYgs+FZETke+J
        Xky3kyUpIotjobK7o9QxrU8mtpWCq20VgAJnW/+uySxv0hEdG2cEzzcgJgkMgkY4HwHfX7puiAisz
        q+DYaUCQ==;
Received: from [179.113.218.86] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qC4OG-001TKu-7J; Wed, 21 Jun 2023 22:25:20 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        michel.daenzer@mailbox.org, Simon Ser <contact@emersion.fr>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/1] amd/display: only accept async flips for fast updates
Date:   Wed, 21 Jun 2023 17:24:58 -0300
Message-ID: <20230621202459.979661-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fix was developed with the "Add support for atomic async page-flips"
patchset, it's not dependent on the new feature but it wasn't applied by
the time so I'm resending it now.

Extracted from: https://lore.kernel.org/dri-devel/20220929184307.258331-3-contact@emersion.fr/

Simon Ser (1):
  amd/display: only accept async flips for fast updates

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  8 ++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

-- 
2.41.0

