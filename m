Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46A5BD9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiITBzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiITBzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:40 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4E4B3E772
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:55:38 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4E8391E80D1C;
        Tue, 20 Sep 2022 09:52:32 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nXpiQl_R2nRo; Tue, 20 Sep 2022 09:52:29 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A56131E80D17;
        Tue, 20 Sep 2022 09:52:29 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     zeming@nfschina.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, nicolas@fjasle.eu
Subject: Re: [PATCH] usr: Remove unnecessary -1 values from int file
Date:   Tue, 20 Sep 2022 09:55:31 +0800
Message-Id: <20220920015532.24147-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220919014406.3242-1-zeming@nfschina.com>
References: <20220919014406.3242-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you so much for including this patch, Mr. Andrew Morton.

This patch had shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/usr-remove-unnecessary-1-values-from-int-file.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

