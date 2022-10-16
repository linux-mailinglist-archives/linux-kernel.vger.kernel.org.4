Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4D6002E7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJPScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJPScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:32:16 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7DE17E17
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1665945132; bh=4G56bSlLOLrcaLn4Uq48hpApQ6wrSOLBN5mQr4hpOAo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ehU+rMtb+XMbyMl6yKBF770Edk3NJna9Po5VWYmyYmnuVdodz0p9FKXhjjJVODxs1
         xZE+0bea7423RhVPKxqqynjmw4UvIQWp+9o3Kg026XfedjNE9pgQEGM2Mu/+ilw+Wu
         Vg53QwvPP6AtCPboxKeZQVtnArhe9ueXywqdsdq0=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Sun, 16 Oct 2022 20:32:12 +0200 (CEST)
X-EA-Auth: RbEaKFyxBuDMr3JtziJUqqWdNO/EGUTB6u/gb48BydESCQyZelGYzoJ60zmUJP9gWHrCpuiusI8q0PP69kCUZ6h7j1oeXv5M
Date:   Sun, 16 Oct 2022 14:32:08 -0400
From:   Deepak R Varma <drv@mailo.com>
To:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: query on fixing checkpatch BUG() variants warning
Message-ID: <Y0xOKFkL84jqTSj8@debian-BULLSEYE-live-builder-AMD64>
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

Hello,
I am participating in Outreachy program for Dec 2022. Could you please suggest
if I should explore resolving following checkpatch warning reported by
driver/stagning/most/*/*.c files?

Do not crash the kernel unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants


Thank you,
./drv


