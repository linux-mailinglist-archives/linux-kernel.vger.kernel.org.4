Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948E651122
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiLSRSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiLSRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:18:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524B5F46
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 09:18:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B430B80E53
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E6C433EF;
        Mon, 19 Dec 2022 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671470293;
        bh=LUvRYJV1lwHcR1CKoJ33hzSQNl//JskrDWF7Xk0nZ9U=;
        h=From:To:Cc:Subject:Date:From;
        b=L9Ti8hzq/ohKuEJ3Nxnn551n8x8Igir27yxd37kcnu3VHM/HGhiaPbM8TlQPhu/TF
         ytcXF1JOK3I/fCqvFbPws0G9tPNJN3ysVxlOcVMDXtymKTxCbavOqQxKxnh6b+I5Oc
         bMbTYOlBnqJICSlLIGqR9TQD6LRhdVT60rkNsaMBzVxP6bz6Y0wXeVCPaLMfHPg8+j
         V3bYeVMNOhCujRKdabMI77MGGX84nK2CHEYGkJMLlJCQs5WUdJGtYd++rHFrNKfPcE
         awOz5jY7BhBGog+SDUr+4lBndmkSArA9AZjLJpuJ6sQA8pcZGb9MpZrFyWatyCYhBB
         sDHAWNqj0idpQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 0/2] two fixups for DAMON sysfs' scheme filters support
Date:   Mon, 19 Dec 2022 17:18:05 +0000
Message-Id: <20221219171807.55708-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains two fixups of DAMON sysfs' scheme filters
support, which is in mm-unstable.

SeongJae Park (2):
  mm/damon/sysfs-schemes: Fix leaking a filter for wrong cgroup path
  mm/damon/sysfs-schemes: Return an error for filter memcg path id
    lookup failure

 mm/damon/sysfs-schemes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1

