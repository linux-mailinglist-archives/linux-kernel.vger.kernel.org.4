Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89D61A00F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiKDSer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiKDSeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:34:37 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AAE134
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667586868; bh=dqPxmpk2lRrqTMyE4Y1XgiMtSrvGZVXTYRp/XNXZUG0=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=oG/RqRCV3KKtN4i75U9DPhfdwOoR0qlsaUH9scAXWwHQ7bWi5bvvX/inOaYlBqxwy
         l6R38LzMkwat/KpwQY8WnwTVnO2mJh1dRM6iIyBskpih8jrSk3JTFaVPgmnkq37fGN
         84mrU/XwXGzyb94mNyKrQnYAGPWbUTw9nvf3BcJg=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 19:34:28 +0100 (CET)
X-EA-Auth: 2wA6SyJoq1nkGP94UxiPhis28hdVp2Hp23h1JfhbWQPAQ6lMNIJEx5oJzJnZI6IdwKXzQmpmhhBQfrUy2VPYHb3ku+BqvG5Q
Date:   Sat, 5 Nov 2022 00:04:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8723bs: struct iqk_matrix_regs_setting
 cleanup
Message-ID: <cover.1667586648.git.drv@mailo.com>
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

The patch set proposes code cleanup and simplification changes for struct
iqk_matrix_regs_setting member variables. Resultant code is simpler and easier
to maintain.


Deepak R Varma (2):
  staging: rtl8723bs: Simplify underutilized 2D array to 1D array
  staging: rtl8723bs: Remove unused member variable

 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 18 +++++++++---------
 drivers/staging/rtl8723bs/hal/odm.h            |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

--
2.34.1



