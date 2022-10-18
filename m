Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9ED603102
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJRQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJRQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:49:00 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4ABE2F2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666111725; bh=0nkY6iUtCYAqr1+5gKwwRvENJAxhVYsXIvjIOOFBhVU=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=kwuhANf7FnY70QxDpT7pgRhOkl5H3a9Nu0yPkQ6Yr3rtl28JoYIUWil71vtFLQaXp
         KkjgRh6JpfcyW6Qrg/fNfTzBdJBBjeVFzi7tcpik2tv69vvyNHUkNHukwDCLbXDkTj
         3LTpa9yRxPrL/ucsc/bvNPm4nP2MVOKYB2UHuvhM=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Tue, 18 Oct 2022 18:48:45 +0200 (CEST)
X-EA-Auth: nf9Iwl0dHb4P2mE+fmoOko6/96gLJHnKjXcqx7+EGwcVhzbC6ksZe2aqvPZnykZdaIAwb69JYnx6n9ldyhTqKW861jmn/pb5
Date:   Tue, 18 Oct 2022 22:18:40 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: most: dim2: remove unnecessary function call
 and variable usage
Message-ID: <cover.1666105876.git.drv@mailo.com>
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


Patch set simplifies service_done_flag function by eliminating call to
dim_get_channel_state. Also corrects the misleading dim_ch_state_t variable
name.


Deepak R Varma (2):
  staging: most: dim2: read done_buffers count locally from HDM channel
  staging: most: dim2: correct misleading variable name

 drivers/staging/most/dim2/dim2.c | 5 ++---
 drivers/staging/most/dim2/hal.c  | 4 ++--
 drivers/staging/most/dim2/hal.h  | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

--
2.30.2



