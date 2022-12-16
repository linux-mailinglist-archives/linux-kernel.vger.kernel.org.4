Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E2B64E5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLPCWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLPCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:22:44 -0500
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD1C48744;
        Thu, 15 Dec 2022 18:22:41 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7875B1E80D72;
        Fri, 16 Dec 2022 10:17:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hmw8fghFrMWY; Fri, 16 Dec 2022 10:17:51 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C4DB91E80D58;
        Fri, 16 Dec 2022 10:17:51 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     zeming@nfschina.com
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com,
        ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, mattst88@gmail.com,
        richard.henderson@linaro.org
Subject: [PATCH] kernel: process: Remove unnecessary (void*) conversions
Date:   Fri, 16 Dec 2022 10:22:32 +0800
Message-Id: <20221216022233.2827-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20221213073633.3586-1-zeming@nfschina.com>
References: <20221213073633.3586-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/kernel-process-remove-unnecessary-void-conversions.patch

This patch later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

