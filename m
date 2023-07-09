Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1074C44B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGINRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGINRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:17:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135BCE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:17:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzSNM6m4bzBJBgF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:17:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688908643; x=1691500644; bh=bKpoJT/x7DcDz5XcdrZhGxjcAb1
        5Ro/oW6evMBC3vg4=; b=LIbrsSzeATHX4H5qmwTYhZH9t+D22G6c4RrAy7aqPd0
        hY/xhMqJNvQ0709h8wm2m0Cv4xUY/KYOxLetsQzfZwMNis69hwouu+vROi8og6bV
        xHaqIJ1VEx2QKmoVhV90LCmSBZ/NcU9ifK+4SvS08bzcLfnAwWfy25FQLR3t3T2B
        OGOMrfKalGezFNiqfDZKRFg8Ry1JrG/lMz+QqcW+NOR3Nav31whXfeb+iAxrqPce
        4LgcvhJGtDoBAisoW5r1289GVpuSM0GbuHUGl5F+XhWj2HsEHH9n745eFVJ7pFdx
        C032C/dDrS87a7aTpuu23A80Kk2DY/tVg5B3kjF2JEw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rwf7JZGBLf5P for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 21:17:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzSNM4Dd5zBHXkb;
        Sun,  9 Jul 2023 21:17:23 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 21:17:23 +0800
From:   xuanzhenggang001@208suo.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: MCPM: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <20230709131439.14552-1-denghuilong@cdjrlc.com>
References: <20230709131439.14552-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <cd587f2f5422658255327d28d56e2b7b@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by checkpatch:

arch/arm/common/mcpm_entry.c:143: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/arm/common/mcpm_entry.c:143: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/arm/common/mcpm_entry.c:152: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/arm/common/mcpm_entry.c:152: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/arm/common/mcpm_entry.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 8a9aeeb504dd..97f8e7947807 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -140,7 +140,7 @@ static int __mcpm_cluster_state(unsigned int 
cluster)

  extern unsigned long 
mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];

-void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
+void mcpm_set_entry_vector(unsigned int cpu, unsigned int cluster, void 
*ptr)
  {
      unsigned long val = ptr ? __pa_symbol(ptr) : 0;
      mcpm_entry_vectors[cluster][cpu] = val;
@@ -149,7 +149,7 @@ void mcpm_set_entry_vector(unsigned cpu, unsigned 
cluster, void *ptr)

  extern unsigned long 
mcpm_entry_early_pokes[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER][2];

-void mcpm_set_early_poke(unsigned cpu, unsigned cluster,
+void mcpm_set_early_poke(unsigned int cpu, unsigned int cluster,
               unsigned long poke_phys_addr, unsigned long poke_val)
  {
      unsigned long *poke = &mcpm_entry_early_pokes[cluster][cpu][0];
