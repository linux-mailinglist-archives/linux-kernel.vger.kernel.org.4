Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB35F89FB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJIHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJIHSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:18:21 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 117832ED7F;
        Sun,  9 Oct 2022 00:18:21 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3E89C1E80D53;
        Sun,  9 Oct 2022 15:12:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id spOezc4gzGbx; Sun,  9 Oct 2022 15:12:09 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A1FEC1E80CE4;
        Sun,  9 Oct 2022 15:12:04 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     lkp@intel.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kbuild-all@lists.01.org, kpsingh@kernel.org,
        kunyu@nfschina.com, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org, yhs@fb.com
Subject: 
Date:   Sun,  9 Oct 2022 15:17:34 +0800
Message-Id: <20221009071735.557255-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <202210082050.nPzAbV1v-lkp@intel.com>
References: <202210082050.nPzAbV1v-lkp@intel.com>
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


Hello, I use the main line code（ https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ）The compilation can be successful according to the compilation instructions you provided (at present, it is unclear why the bpf repository compiles warnings and compilation fails). Later, I will deploy a new repository and try to compile again.


After writing the reply message, press 'e' to edit the message, and the result is sent to the patch file.....

