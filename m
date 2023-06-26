Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73FC73E941
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFZSeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjFZSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:34:01 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC7CC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hcEG/EDV/jBYrfWeHJXPYu8t7rz0vK43YGRhzJYLXqU=; b=JXWyM354SH54g4cNBKh2UBKOJL
        bxkzvOkbwxGcd0uxU71v0BFjl9fBLwS+jyrqDHOLbviRZFMTBl88Wga5ePaIPASYTYbePo/lc/yMJ
        Iw/68HE/Es4xIKDnGnz9lR+/Hnb2w+0axYfIT34YV5hksAt51LJBowkabzPfolQBctp2tiaXYL99t
        eDQGD5Yx+OWEestabkwv4WCLvRn8m7kPsW3or9OFVgAP6xXqCqFJCsCm/PDWjqdOC2LFgfMoT3YX9
        UMtXwnoHQZ4V0ehzM+Mt5ss1vPc114IFnG7jl6mVBKSbctSaJsAK3IHMt0TLPH40prc7UlL2guiUZ
        OuYLA78w==;
Received: from [179.113.218.86] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qDr2A-0047zl-6M; Mon, 26 Jun 2023 20:33:54 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/1] drm/doc: Document DRM device reset expectations
Date:   Mon, 26 Jun 2023 15:33:46 -0300
Message-ID: <20230626183347.55118-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v4 removes the common DRM ioctl, and adds just the documentation for now,
giving the lack of a common "DRM context" infrascture make it hard to implement.

v3: https://lore.kernel.org/lkml/20230621005719.836857-1-andrealmeid@igalia.com/

Changes: 
 - Drop the ioctl
 - Addresed comments com Pekka, as making the documentation more clear and
 consistent.

André Almeida (1):
  drm/doc: Document DRM device reset expectations

 Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
2.41.0

