Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF615B9213
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIOBTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiIOBTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:19:22 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D37278C003
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:19:20 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 681891E80D58;
        Thu, 15 Sep 2022 09:16:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qazQv2pUsL9s; Thu, 15 Sep 2022 09:16:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D953B1E80D1C;
        Thu, 15 Sep 2022 09:16:55 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     xupengfei@nfschina.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH 1/1] mm/hugetlb: Remove unnecessary 'NULL' values from Pointer
Date:   Thu, 15 Sep 2022 09:19:11 +0800
Message-Id: <20220915011912.5807-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220914012113.6271-1-xupengfei@nfschina.com>
References: <20220914012113.6271-1-xupengfei@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Andrew Morton:
    Thank you for including this patch.

This patch  shortly appears at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-remove-unnecessary-null-values-from-pointer.patch

This patch  later appears in the mm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

