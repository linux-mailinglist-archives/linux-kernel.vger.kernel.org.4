Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FDE5F0978
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiI3LGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiI3LGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:06:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD33C1EBC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:43:08 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf6By1KWWzWh39;
        Fri, 30 Sep 2022 18:38:18 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:42:27 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:42:26 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <jayakumar.alsa@gmail.com>,
        <chenzhongjin@huawei.com>, <wangjianli@cdjrlc.com>
Subject: [PATCH 0/4] ALSA: Minor cleanup for unused variables
Date:   Fri, 30 Sep 2022 18:38:32 +0800
Message-ID: <20220930103836.104113-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains some cleanups that removes unused variables.
Reported by Clang [-Wunused-but-set-variable]

Some of them are forgotten to deleted and some are never used since the
beginning.

Chen Zhongjin (4):
  ALSA: rawmidi: Remove unused variable 'dest_frames'
  ALSA: cs5535audio: Remove unused variable 'loop'
  ALSA: cs5535audio: Remove unused variable 'loop_count'
  ALSA: cs5535audio: Remove unused variable 'desc_addr'

 sound/core/rawmidi.c                    | 2 --
 sound/pci/asihpi/asihpi.c               | 2 --
 sound/pci/asihpi/hpi6000.c              | 2 --
 sound/pci/cs5535audio/cs5535audio_pcm.c | 4 +---
 4 files changed, 1 insertion(+), 9 deletions(-)

-- 
2.17.1

