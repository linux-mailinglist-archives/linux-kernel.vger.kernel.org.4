Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9365EEADC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiI2BYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2BYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:24:47 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4B6B2DE0;
        Wed, 28 Sep 2022 18:24:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id ECC151E80D78;
        Thu, 29 Sep 2022 09:20:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7jtsExiC7Qo; Thu, 29 Sep 2022 09:20:07 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DA14E1E80C7C;
        Thu, 29 Sep 2022 09:20:06 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        zhoujie@nfschina.com
Subject: Re: + init-remove-unnecessary-void-conversions.patch added to mm-nonmm-unstable branch
Date:   Thu, 29 Sep 2022 09:24:19 +0800
Message-Id: <20220929012420.11360-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220928150102.5DD8FC433D6@smtp.kernel.org>
References: <20220928150102.5DD8FC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been entered by mm tree:

This patch shortly appear at
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/init-remove-unnecessary-void-conversions.patch

This patch later appear in the mm-nonmm-unstable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

