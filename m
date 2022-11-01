Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94A614C01
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiKANrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKANrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:47:51 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85165DF9A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667310454; bh=7jTJtPDuvOB4UjP4GvxdQueh87xLMlDPi/Mqzt+n5G0=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=lB6xDl1sDGjv3GtGZQBgw60sAB+cuWMDNzmltKRksha1WAHF093y9HHlC3NztsyI8
         U1Sbzo3ifHEbQFbYKKXghpysTsT4IueFFvZnenmfmzAzLNhFbiMyBkFOnmsR9rQRts
         P/KhuZQZs46rIqZh8r1CF8Mm0T3FEhinXa8U3ryo=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 14:47:34 +0100 (CET)
X-EA-Auth: DfQ3DHXejnins+N2KjtND5TsIgSXGYhJ7du0CuWJRoHUgib7V4P3WtP15n7USff9UsVtKlni9XmdVpw0oYMVDJ+tGLC47Zf+
Date:   Tue, 1 Nov 2022 19:17:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] wlan-ng: Unused code clean-up patch set
Message-ID: <cover.1667308828.git.drv@mailo.com>
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

The patch set proposes to clean unused code from the wlan-ng driver. The patches
are compile tested on my x86 machine.

Change in v2:
   1. Review and include additional code clean-up opportunities as
      suggested by dan.carpenter@oracle.com and paskripkin@gmail.com
   2. Combine changes for different impact areas into a path sea.
      Suggested by dan.carpenter@oracle.com

Deepak R Varma (7):
  staging: wlan-ng: Remove unused struct wlan_ie_ssid references
  staging: wlan-ng: Remove unused struct wlan_ie_supp_rates references
  staging: wlan-ng: Remove unused struct wlan_ie_tim references
  staging: wlan-ng: Remove unused struct wlan_ie_ibss_parms references
  staging: wlan-ng: Remove unused struct p80211macarray definition
  staging: wlan-ng: Remove unused function declarations
  staging: wlan-ng: Remove unused structure definitions

 drivers/staging/wlan-ng/p80211mgmt.h  | 301 --------------------------
 drivers/staging/wlan-ng/p80211types.h |   6 -
 2 files changed, 307 deletions(-)

--
2.34.1



