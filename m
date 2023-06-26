Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA873E2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFZPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFZPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:09:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936410D8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:09:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f90b8ace97so48481665e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687792155; x=1690384155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72bcXZ+J6bNWWGqskqAX/uK8x0vlcNvpBj1vGVpBWRk=;
        b=be4XVtzYf2A1sN1F/s8dUL8tiCabRGrnbrCe/IuDdNCjf6fxciARWire0VDt4RNpIP
         RS9ZIyqDsdcNRwqZKUnEh2cN/Ulbpa22Z5UzxZxkY6bwdzH1rw6nxim+q1Io04wDoQtW
         dUMSNeZGO7G4zWTcWtP8SudhAWylNU83ijO4aXjVAU48BJgKECGm34nhSlQiWYanbZ4Z
         UCUGr0rZCg2T9IgsGZp+ujoZkSlJaltDcPzZdR49KyPTCLHsu+F8b46NHRAAj64uuKa5
         THPCEoVQxSSqnPTL/EQFnJ3Y5Rf7ziFklzO1I2EfNXHdsAErtw0G/TJHRfTt+0jN48RG
         u3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792155; x=1690384155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72bcXZ+J6bNWWGqskqAX/uK8x0vlcNvpBj1vGVpBWRk=;
        b=QEGKfdnrrHQbAXmxggL4Mm4Rc93NotWUWwBiG+5asLmnuxjOcTfv5wA3fiPwCB0IDa
         iXLwidF2lTQQ1iDakHTQ7yuKEQBAxdmel+55fWMN70VykxSELxb7dt2cq1fwXXLKV0uA
         u5hflK5EPIiHRiSYlVlQ942VvPqr6POBTTIb0sjb+QiNubeP9mkXlZimGKY7Ufmyc8CZ
         ivSEqieZliIgBYQGx0pX65g6wDh/rvqAz+hfnR31NFVSMTYf5CZQvAeMkAYlshS7E6tg
         I+VcSYoZNR1H9UNQIqSZBCTbA7O/h0htbkGcIWlerRbhMp8XqjWya22apQRNS+biWQVk
         T8bQ==
X-Gm-Message-State: AC+VfDy9ygjAMQPZzQ6G3UGk6QxzDoHmV12P96aj8uU8+TB94096hx49
        PVoLdHzkN5BXH+3XGrifVKy0dQ==
X-Google-Smtp-Source: ACHHUZ5b4EmrXT88MOGMrhxoFxujV63CClmWd0z736ZrcTwaNFTnqWyh3zkcMars5E63J05+i7zmVw==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b17a:cb61 with SMTP id 6-20020a05600c22c600b003f9b17acb61mr18927028wmg.13.1687792155453;
        Mon, 26 Jun 2023 08:09:15 -0700 (PDT)
Received: from [192.168.1.193] (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id v1-20020adfe281000000b00311299df211sm7668710wri.77.2023.06.26.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:15 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Mon, 26 Jun 2023 16:09:00 +0100
Subject: [PATCH bpf-next v3 3/7] net: document inet[6]_lookup_reuseport
 sk_state requirements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-so-reuseport-v3-3-907b4cbb7b99@isovalent.com>
References: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v3-0-907b4cbb7b99@isovalent.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation was extracted from inet[6]_lhash2_lookup
in commit 80b373f74f9e ("inet: Extract helper for selecting socket
from reuseport group") and commit 5df6531292b5 ("inet6: Extract helper
for selecting socket from reuseport group"). In the original context,
sk is always in TCP_LISTEN state and so did not have a separate check.

Add documentation that specifies which sk_state are valid to pass to
the function.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/inet_hashtables.c  | 14 ++++++++++++++
 net/ipv6/inet6_hashtables.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 920131e4a65d..91f9210d4e83 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -332,6 +332,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+/**
+ * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
+ * @net: network namespace.
+ * @sk: AF_INET socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
+ * @skb: context for a potential SK_REUSEPORT program.
+ * @doff: header offset.
+ * @saddr: source address.
+ * @sport: source port.
+ * @daddr: destination address.
+ * @hnum: destination port in host byte order.
+ *
+ * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
+ *         the selected sock or an error.
+ */
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b7c56867314e..208998694ae3 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -111,6 +111,20 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
+/**
+ * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
+ * @net: network namespace.
+ * @sk: AF_INET6 socket, must be in TCP_LISTEN state for TCP or TCP_CLOSE for UDP.
+ * @skb: context for a potential SK_REUSEPORT program.
+ * @doff: header offset.
+ * @saddr: source address.
+ * @sport: source port.
+ * @daddr: destination address.
+ * @hnum: destination port in host byte order.
+ *
+ * Return: NULL if sk doesn't have SO_REUSEPORT set, otherwise a pointer to
+ *         the selected sock or an error.
+ */
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,

-- 
2.40.1

