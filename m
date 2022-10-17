Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62394601080
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJQNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJQNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:50:50 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E66192B7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666014631; bh=MzgpgvOPXYYJ9uSTLDb04aRoEwgOCBfg49mTGRCTv8I=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Pt1dXwphxmDDCZUJDL11IORUQydSiKczFZMAmmwDYJK5ZG3H57MWTF1fidnCOyacH
         Qk2GM0ehYBcdBe6fwUEbIVQf4inuuEeaA9tIPVxmaMftDyYhmi/IUta/aulitvA8+/
         hXPOZ+/k8ser+cYeZ9YblRNveHTZB934/r3ujnrM=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 15:50:31 +0200 (CEST)
X-EA-Auth: HE7Tpv6JQEWvZeHv9+YdRxBEHahqvDhatAHw+8AH9EVhBZQho4m/Ar1QBYKSPJRb36xFdr31nAHmMFKHNLCYGxJ6+4CCscH8
Date:   Mon, 17 Oct 2022 18:50:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH 0/4] staging: r8188eu: trivial code cleanup patches
Message-ID: <cover.1666011479.git.drv@mailo.com>
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


Deepak R Varma (4):
  staging: r8188eu: use Linux kernel variable naming convention
  staging: r8188eu: reformat long computation lines
  staging: r8188eu: remove {} for single statement blocks
  staging: r8188eu: use htons macro instead of __constant_htons

 drivers/staging/r8188eu/core/rtw_br_ext.c | 125 +++++++++++-----------
 1 file changed, 65 insertions(+), 60 deletions(-)

--
2.30.2



