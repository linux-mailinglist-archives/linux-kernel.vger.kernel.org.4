Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3960135B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJQQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:26:21 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664795C34D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666023964; bh=gN5i2sGJZj5sJFuVLzEXCL0ZJfDL6JX/M9xJCw1nEGE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=VvQIlZkAhWnmuwQrbqeMT6e7x55Po5XvdLT89Ciw784OCKEOPXCqea+HwgKyKzvHX
         KhG6Fxagrzd71j90x1GKQ8WgNy1fZ6l5Rft0OQ2Rar3+nc0olEUcPhFzxPGIwW2UQi
         eJJfDNbwCEnsKucVhpkMXXoXwHL5zOCso6KpsFc8=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 18:26:04 +0200 (CEST)
X-EA-Auth: tswpQjuyWHg7rI3hSM4IVZEo0CKZooe9r502EDQ8OJMxxqrPGxW+ndbUc1qiWEaq7an9jE5bsy5gnBnafNAw6k0wLiLdizfM
Date:   Mon, 17 Oct 2022 21:26:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH v1 0/4] staging: r8188eu: trivial code cleanup patches
Message-ID: <cover.1666021212.git.drv@mailo.com>
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

Address different kinds of checkpatch complains for the staging/r8188eu module.
The patches are required to be applied in sequence.

Changes in v1:
   1. Improve language / grammar for the patch descriptions
   2. Further improve code reformatting

Deepak R Varma (4):
  staging: r8188eu: use Linux kernel variable naming convention
  staging: r8188eu: reformat long computation lines
  staging: r8188eu: remove {} for single statement blocks
  staging: r8188eu: use htons macro instead of __constant_htons

 drivers/staging/r8188eu/core/rtw_br_ext.c | 122 +++++++++++-----------
 1 file changed, 62 insertions(+), 60 deletions(-)

--
2.30.2



