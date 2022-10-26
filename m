Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4660DEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJZKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:35:29 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0876549
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666780518; bh=CkgEmYMxD29PBWn79CaVb5kHVMygiKiP3es92Nhi7G4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=IUMJ9OPXIxcVfEhq0wlj3/GG/3fLt5rQglxV/+hYIjDRNyLSykbeagy6SoueDJFJR
         q8vq9OBDerG2nIB00mZhmhsXrKSyvEfrauxwRE9zEvSVqOyFMSOKydEXiLL6V9HJSv
         QK/TdFovR3WgQNP79nqoCAfYRqGvkoJT2kVJ3yeU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Wed, 26 Oct 2022 12:35:18 +0200 (CEST)
X-EA-Auth: mHdDbY5qqCmgEzKCFIMRuZDAPpX5m4qL514Kcl9/eEshuHcNJYNG/6XRE55NbdQbMTUezGV/ge/YfFB8u8Bc2rkvBGvwUTxp
Date:   Wed, 26 Oct 2022 08:56:41 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192u: unused code cleanup
Message-ID: <cover.1666754500.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code that is unnecessary or unused.

Deepak R Varma (2):
  staging: rtl8192u: remove unnecessary function implementation
  staging: rtl8192u: remove unused macro definition

 drivers/staging/rtl8192u/ieee80211/ieee80211.h            | 5 -----
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 6 ------
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c     | 3 ---
 3 files changed, 14 deletions(-)

--
2.30.2



