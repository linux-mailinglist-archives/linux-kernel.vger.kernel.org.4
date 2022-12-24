Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A31655AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiLXQdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:33:09 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7CB1EE;
        Sat, 24 Dec 2022 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671899578; bh=K/4hiOY7BCAUKajIhqlHSoKC/VJgy4tl+xgmPVyY+k4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=FRAGCzUFPmCK5IdKOA34GaiVzVxDA4FdvhtF21/qqctny0Z9yFRwh8Cqs6KLa1LQC
         ZHdPSnov8mN3XXYZ2DRn0JFa/QNLkLunEF+oYbF1OuCfX11rTOqzsz1lVK3KLczJKG
         75fU+tXZaWedxXLqdiPwgBvxPcoWNCx2zPuONow0=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 24 Dec 2022 17:32:57 +0100 (CET)
X-EA-Auth: m+O+37z/zobbcd/q9gfrbRXii/EjTueFXCMX9nloDIxpkGLpkBPGCJ7oDFEwAvnEQhKne+25H6Rm8hSOmgarMboUtcjP7TJl
Date:   Sat, 24 Dec 2022 22:02:50 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 0/2] tty: serial: dz: convert atomic_* to refcount_*
Message-ID: <cover.1671898144.git.drv@mailo.com>
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

The patch series proposes to transition the driver from using atomic_t APIs to
refcount_t APIs for reference count management.

Note: patch 2/2 depends on patch 1/2. Hence please apply path 1/2 first.

Changes in v3:
   1. Patch series introduced rather than individual patches.
   2. Update patch subject line to indicate the atomic_t variable being changed

Changes in v2:
   1. Separate the change to patch per variable rather than combining multiple
      atomic variable changes into a single patch.

Please note:
   The patches are compile tested using dec_station.defconfig for MIPS architecture.

Deepak R Varma (2):
  tty: serial: dz: convert atomic_* to refcount_* APIs for map_guard
  tty: serial: dz: convert atomic_* to refcount_* APIs for irq_guard

 drivers/tty/serial/dz.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

--
2.34.1



