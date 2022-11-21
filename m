Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8319563310F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiKUX5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiKUX4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:56:45 -0500
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36E6A75B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
        Content-Description; bh=fbXGUFSXYza3y/lPkuKmgh/RBaDaBeod3XSq0CnLBAc=; b=OveqC
        ZjPdyWA9YK2IrGld4O/RfodxUMX0RWG1zazPtEMLdidzxy8aGZI3zxy3qZ2/DhNOphzkW6tp8+X+p
        OMSizAYasbHDxqKt4vfRxr17mMzJI2J5pZS4r+lcIShgXUSLj56lpLRHqYCLpRc1KMUAZ7Q2Z2lZg
        Q4RVkC921Ly0jL+M6yXGq3ar1bkcgSFRnqKc/DQ9E0cczVzXGdnFQijtwtj9XvUYMmljXVmJtiz3Y
        6VQqk0APkuxwB7s1xbwUe8PMkq4zZ2Ra6wcgIXi4vzqJ1AIGD0NmDsXNpO+EkPaX9NzsuDgMq+nGW
        by4hz0Xo7yrI35oO7JvRTtqc8fMyQ==;
Message-Id: <cover.1669072186.git.linux_oss@crudebyte.com>
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 22 Nov 2022 00:09:46 +0100
Subject: [PATCH 0/2] net/9p: fix response size check in p9_check_errors()
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow-up fix for:
https://lore.kernel.org/linux-kernel/Y3hADWgV9JeajmfF@codewreck.org/

Stefano, I am optimistic that this also works with Xen, but I have not
tested it.

Christian Schoenebeck (2):
  net/9p: distinguish zero-copy requests
  net/9p: fix response size check in p9_check_errors()

 include/net/9p/9p.h |  2 ++
 net/9p/client.c     | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.30.2

