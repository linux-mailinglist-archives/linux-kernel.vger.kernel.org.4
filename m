Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881B69F64E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjBVOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBVOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:18:05 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B02846AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:18:02 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 84F9DC800A7;
        Wed, 22 Feb 2023 15:18:00 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1677075480; x=1678889881; bh=ujp8UtH/HkS7PA/cnHZUF8LF
        g6XQmk9qH7vri3P5DdQ=; b=fHH/Yxcvf63Bcaq6ys0nw4zUtAqBHpYn6uB541qX
        nGalq1BNBLlvNU5mtpuSdqwYdHfuPcsT27B22JjVwCituLLBHO5VWsMnmfNYM6uF
        fQtO9hXG8IP9dP3+5//M5XAMSR+n+GxV42Cpv2CKIm+7XohWiEhHyByi4HCpknqe
        h3o=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id YHOPEZUT_uB0; Wed, 22 Feb 2023 15:18:00 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 164F1C800A2;
        Wed, 22 Feb 2023 15:17:59 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, jose.souza@intel.com,
        jouni.hogander@intel.com, mika.kahola@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        Diego.SantaCruz@spinetix.com, wse@tuxedocomputers.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add quirk to disable PSR 2 on Tongfang PHxTxX1 and PHxTQx1
Date:   Wed, 22 Feb 2023 15:17:53 +0100
Message-Id: <20230222141755.1060162-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On these Barebones PSR 2 is recognized as supported but is very buggy:
- Upper third of screen does sometimes not updated, resulting in
disappearing cursors or ghosts of already closed Windows saying behind.
- Approximately 40 px from the bottom edge a 3 pixel wide strip of randomly
colored pixels is flickering.

PSR 1 is working fine however.

This patchset introduces a new quirk to disable PSR 2 specifically on known
buggy devices and applies it to the Tongfang PHxTxX1 and PHxTQx1 barebones.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>


