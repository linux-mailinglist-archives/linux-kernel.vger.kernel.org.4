Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A7672F321
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbjFNDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjFNDir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:38:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C21122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:38:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgrkB2lhbzBL4jY
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:38:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686713922; x=1689305923; bh=tAq+14JkWgMdQYu0lVo/F3Z0UD2
        hHBzkPi2N69SZUcI=; b=IyAoRONB7rl5/O1oNq/UfSyKeRs/VeTVF3+3TnPom/1
        7mASp7IB67ZGTbiVYeV+3JKujhB0ct/I/TGlXS49loGSHLs703Hbni++YIry7RIV
        XXOsgJxobxKSWOht0Xne5/sDSWfTF77zzpnbKHuj2aaRe2scjPkFg1TuTECPDowp
        jxy2dLXkSVX4HTKCjYuPd/yTj9kct1231BcGBsNZYI/y75qg4Bz5n04FUlXWKxXQ
        q7OwQh3dozwg+BJySWDfkzKvNiMczW5elUAyuFxUi1arXY17FHA6BLfg04iHJoo0
        k+6TALA1BFpegJd1uctq0KI9+Mb9owxbn18smzq2WSg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8z1ufjrNj_lD for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 11:38:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgrk9262zzBJ9pH;
        Wed, 14 Jun 2023 11:38:41 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 11:38:41 +0800
From:   baomingtong001@208suo.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench: remove unneeded variable
In-Reply-To: <20230614033437.48549-1-luojianhong@cdjrlc.com>
References: <20230614033437.48549-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <475df60d9dd518e20ae9df396c60b69b@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following coccicheck warning:

tools/perf/bench/find-bit-bench.c:127:5-8: Unneeded variable: "err". 
Return "0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/perf/bench/find-bit-bench.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c 
b/tools/perf/bench/find-bit-bench.c
index 7e25b0e413f6..70619bc73841 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -124,7 +124,7 @@ static int do_for_each_set_bit(unsigned int 
num_bits)

  int bench_mem_find_bit(int argc, const char **argv)
  {
-    int err = 0, i;
+    int i;

      argc = parse_options(argc, argv, options, bench_usage, 0);
      if (argc) {
@@ -135,5 +135,5 @@ int bench_mem_find_bit(int argc, const char **argv)
      for (i = 1; i <= 2048; i <<= 1)
          do_for_each_set_bit(i);

-    return err;
+    return 0;
  }
