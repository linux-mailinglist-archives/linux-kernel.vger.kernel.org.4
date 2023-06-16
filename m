Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF71733253
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFPNh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjFPNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:37:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C443598
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:37:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso728704276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686922672; x=1689514672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lw1zQIcz0JNIUX7z0/PcXnshxG7g8+17h7yC1MHLIEE=;
        b=ZoqFsiQnFldqjFgGRUz2qZHbmAva3S6IZSqCLi5Nq+pUyr+or46QNtxtVvIG7NV7mm
         P3Vs30gDKWIJBdJcJtlh+/+HWtBB4tgh3b1ixpkLnK6t4nwxeHn4VFIp2Wnk9hppM+qE
         Bn53COpD7RVRfiILBJ46y+6sMGit46xMS9c/fANn+aYScZ6yscfBKuImMgk/zoPABd/4
         xsqVo9Vs5ViZjeR+YimJrVtQiCML3iQV2PEmBkhI+T+eJU0HPsgFZzsNXIPGxZyCbvF1
         JnjC1QaygPbztKJ6YJY3FfSRnqp03hJo7cJUpkLgiELpwIWFo480ildEKfDJS4caFHR7
         VJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686922672; x=1689514672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lw1zQIcz0JNIUX7z0/PcXnshxG7g8+17h7yC1MHLIEE=;
        b=Gtfa9phmfTqp8PPc+SeaUBYr9gl44Jbhk7TKRVFzKnqLrDz+0gmvZRtUtUw5mvaWiG
         Tcs1s25MaAK0eHz2hUK5adBsKqNPDnPqN0cUzsgpiLnwIv7SsYhmCxzkacccZZ9dUVOd
         UqDHNMYeiE0Y12/zocUz35szcUR2xoCVK2MtH+Q6Ja3+HPSTGf8NDLkEZu+9Cg+QATN4
         0/3B2ikgrz8NqQLTU/voZBv19k1HDyyGYzHFj3N6uJrsykwUdYnJmXIsCgkML4XJbLO9
         9Bwb+NXBkreOd6y82h361zzYHG80jqmseEhiXEE1076TnfHGN4bPmZTXYlGktbBSp8JJ
         nbSA==
X-Gm-Message-State: AC+VfDwz04knka/nqohZon7zrln6xB5xAJtkxZ/5rp71vLa2pz58HIzE
        i7uk6TTgk5tJKbJpyUT8/hJNr3e5gcBaip4YeNiqmiiVZ/xnatzSkT4eRwI1uOJioLItX4xfKJN
        8fbu9xs8HFUdngRzAhqxQ5YX5wkHpFzBocMNM5VzcfdKIQq7Irm30TiBRlY2F2Q0h0UTlyecKc3
        xW0fbV
X-Google-Smtp-Source: ACHHUZ6zUDedJvnykpOSium+c8sjYgMQT2w9qY0RdF28ZIL4n/1/W20jNbFrTpxEW8aC2B6X43Q/V9YCihz8DdR7
X-Received: from jordy-spec.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f2f])
 (user=jordyzomer job=sendgmr) by 2002:a25:da15:0:b0:be6:2b34:6bf0 with SMTP
 id n21-20020a25da15000000b00be62b346bf0mr33733ybf.10.1686922671926; Fri, 16
 Jun 2023 06:37:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 13:37:35 +0000
In-Reply-To: <20230616133735.351479-1-jordyzomer@google.com>
Mime-Version: 1.0
References: <20230616133735.351479-1-jordyzomer@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230616133735.351479-2-jordyzomer@google.com>
Subject: [PATCH 1/1] nospec: Add documentation for array_index_nospec
From:   Jordy Zomer <jordyzomer@google.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, jordyzomer@google.com, dave.hansen@linux.intel.com,
        daniel@iogearbox.net, tglx@linutronix.de, rdunlap@infradead.org,
        pawan.kumar.gupta@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

array_index_nospec() should only be used if the upper boundary is a built
time constant. Otherwise the boundary could be speculated on as well.
While it might be more difficult to control two loads, it doesn't rule
out the problem. Adding this to the documentation so people won't mis-use
it instead of barrier_nospec().

Signed-off-by: Jordy Zomer <jordyzomer@google.com>
---
 Documentation/staging/speculation.rst | 5 +++++
 include/linux/nospec.h                | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/staging/speculation.rst b/Documentation/staging/speculation.rst
index 8045d99bcf12..efc0ab32263b 100644
--- a/Documentation/staging/speculation.rst
+++ b/Documentation/staging/speculation.rst
@@ -79,6 +79,11 @@ A call to array_index_nospec(index, size) returns a sanitized index
 value that is bounded to [0, size) even under cpu speculation
 conditions.
 
+Please note that this function should only be used if the upper
+boundary is a built-time constant, otherwise this could be
+speculated on as well. If this is not the case please refer to
+barrier_nospec().
+
 This can be used to protect the earlier load_array() example::
 
 	int load_array(int *array, unsigned int index)
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 9f0af4f116d9..1d72c40595f4 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -51,6 +51,11 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
  * ...if the CPU speculates past the bounds check then
  * array_index_nospec() will clamp the index within the range of [0,
  * size).
+ *
+ * Please note that this function should only be used if the upper
+ * boundary is a built-time constant, otherwise this could be
+ * speculated on as well. If this is not the case please refer to
+ * barrier_nospec().
  */
 #define array_index_nospec(index, size)					\
 ({									\
-- 
2.41.0.162.gfafddb0af9-goog

