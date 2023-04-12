Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817296DFCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjDLRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDLRYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6051726
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADD356111D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF47FC433EF;
        Wed, 12 Apr 2023 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320254;
        bh=CX6YilH/8zhE+Vf2j+TcQaxBuh4IeLrz7u3P6BNYfYk=;
        h=From:To:Cc:Subject:Date:From;
        b=Qc50VmGZ/7VDTYwBHSrLm7/8uBLi1WqEnaFsx3TbGt1ZXMiu0zsxjaiDz8oJ9dz8+
         cV0XzDTt2gmhNV8nVbkxIm8+s6fokkdogYkU+pyeFog43sg5mkxSdMoKh+K6B1Yfja
         ydGau+Nn2G2dc5yJwUXXYF/tM7rE07Eace5PZ303vgwj6heR/wcpSVxp5vAAhbvh9U
         Ms378hdJ3+r0kdTF4odtqYhjSh2RadTz6RyPFylCySx1U/NkquWh3w+oPj+RT6Fhg1
         IuIssaUDvgPQcdc2jmue6Ip78Wauu6FSS3nEXFaJZSJ1KpeTsCfAIbzRHh/cE97M9c
         rZV1dpj8YJaCA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, frederic@kernel.org,
        paulmck@kernel.org, keescook@chromium.org
Subject: [PATCH 0/3] noinstr fixes
Date:   Wed, 12 Apr 2023 10:24:05 -0700
Message-Id: <cover.1681320026.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few noinstr violations reported by objtool.

Josh Poimboeuf (3):
  context_tracking: Fix KCSAN noinstr violation
  sched: Fix KCSAN noinstr violation
  lkdtm/stackleak: Fix noinstr violation

 drivers/misc/lkdtm/stackleak.c   | 6 ++++++
 include/linux/context_tracking.h | 2 +-
 include/linux/sched/task_stack.h | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.39.2

