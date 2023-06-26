Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3700673EEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFZXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFZXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:02:27 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC810DB;
        Mon, 26 Jun 2023 16:02:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D1DB75C0064;
        Mon, 26 Jun 2023 19:02:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jun 2023 19:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1687820545; x=
        1687906945; bh=fumgg/v3msTCwAU1PpJaH0UyuDxgI4vRhDREddSfnvY=; b=K
        1o9yLE1vMQ/yES3xb/eg5kwHneMEghoEspxjKHVXcAyBq2YaRNLK84pagE2H1KAc
        QuSZ1bevKIQZW2uCHC/4aXU18v+MohuSxvKSNFF4ujokvYhSF3e/fSRyKDn2mUTu
        T1g63avDkAAruz/4R0qgHSZyVlsokpu8J2VCne7gsyi26hER9Wy9HADgc+nRV+Sh
        6qJPpJi4lMOePqBJGMDeRg5XEJxBvpsVeGyXTSfJ5Ws5sfu7WPaWWelSB9i3I9xd
        fGFSF/+VkFhVmypIuvLFhTdIDyti5hV1Q07/1WDsSqGwPdggsvWlaA7doZaNJxY2
        j2EWTX3YBjYAnJh/Ld4rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687820545; x=
        1687906945; bh=fumgg/v3msTCwAU1PpJaH0UyuDxgI4vRhDREddSfnvY=; b=B
        3rMd6pXubnBB3zPpbHRA09t0f6kPTj5kbSXUKy68bGjV29/7hf9OMIzCpXVBC94y
        IkZoYzOUuAisvSIRLLBsIkAJNaIHTsucJWre8Q4F4IwI3pI5hKtKCuUcqW2RP5PW
        Jjv1B9ZKhMmgg/0ALgBXtiZ00GIE+4bzSwOqsLjai0p3iDTdkcBOSiYXAwcDWSyI
        jpfky/43XzJh8Tkr6ZZkw1SSh2Z8U+Cu263yb3Vy8O8XQEApvayanyrUashmOmOj
        k3IVRHZkWfDYUU3/098rqW3CUan2guStAxtuo90kl6y0S0LYn8YInLsxU7aDBihj
        9vLfZz7imvfqOgo3IA88Q==
X-ME-Sender: <xms:ARmaZOTEl0F-lZMQBORjLJWXGKrqXZPxZMBWVQnMJrhYCtajRaudXg>
    <xme:ARmaZDzJqcrQpEiA15B28jfr2ujgbO1s9aF7AhAICDZ75n2arLjaLZQuxLYHi43cc
    eE2H0eB7911D89B_w>
X-ME-Received: <xmr:ARmaZL3uxlcZSV6IfK3UUhTckv2TkbFfoakXdn_ZofTHmb_bcASqZGiNVhRX5nXcT8w4jUbGA3mO3LPG2GwrihVGWXAB_6c_Dy3iQ7CcZbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:ARmaZKDgUFs9Lu049uoHxAYz-b1JxldKgUM08y7bZtBWOJVU3VFVXA>
    <xmx:ARmaZHgoA5tjeNlFalm_I8WAWIU-HWOkhhV1YCnh4AuFtHYgEhp0Kw>
    <xmx:ARmaZGqnOrZH5xsRwZYKnhMGBKSzU_S_b2aZ6BTxeGM6tXDv1JdrbA>
    <xmx:ARmaZAbQtFIwfUuds7vN2GbJZlImKCd1uq51NBuypHEg2gqczUPDjw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:24 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     edumazet@google.com, dsahern@kernel.org, kuba@kernel.org,
        fw@strlen.de, pabeni@redhat.com, pablo@netfilter.org,
        davem@davemloft.net, kadlec@netfilter.org, daniel@iogearbox.net
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/7] netfilter: defrag: Add glue hooks for enabling/disabling defrag
Date:   Mon, 26 Jun 2023 17:02:10 -0600
Message-Id: <66d1eaeb17721b1274eb4c1991a3725e47c912c5.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to enable/disable IP packet defrag from core
bpf/netfilter code. In other words, execute code from core that could
possibly be built as a module.

To help avoid symbol resolution errors, use glue hooks that the modules
will register callbacks with during module init.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netfilter.h                 | 12 ++++++++++++
 net/ipv4/netfilter/nf_defrag_ipv4.c       |  8 ++++++++
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c | 10 ++++++++++
 net/netfilter/core.c                      |  6 ++++++
 4 files changed, 36 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 0762444e3767..1d68499de03e 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -481,6 +481,18 @@ struct nfnl_ct_hook {
 };
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
+struct nf_defrag_v4_hook {
+	int (*enable)(struct net *net);
+	void (*disable)(struct net *net);
+};
+extern const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook;
+
+struct nf_defrag_v6_hook {
+	int (*enable)(struct net *net);
+	void (*disable)(struct net *net);
+};
+extern const struct nf_defrag_v6_hook __rcu *nf_defrag_v6_hook;
+
 /**
  * nf_skb_duplicated - TEE target has sent a packet
  *
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index e61ea428ea18..436e629b0969 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -7,6 +7,7 @@
 #include <linux/ip.h>
 #include <linux/netfilter.h>
 #include <linux/module.h>
+#include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <net/netns/generic.h>
 #include <net/route.h>
@@ -113,17 +114,24 @@ static void __net_exit defrag4_net_exit(struct net *net)
 	}
 }
 
+static struct nf_defrag_v4_hook defrag_hook = {
+	.enable = nf_defrag_ipv4_enable,
+	.disable = nf_defrag_ipv4_disable,
+};
+
 static struct pernet_operations defrag4_net_ops = {
 	.exit = defrag4_net_exit,
 };
 
 static int __init nf_defrag_init(void)
 {
+	rcu_assign_pointer(nf_defrag_v4_hook, &defrag_hook);
 	return register_pernet_subsys(&defrag4_net_ops);
 }
 
 static void __exit nf_defrag_fini(void)
 {
+	rcu_assign_pointer(nf_defrag_v4_hook, NULL);
 	unregister_pernet_subsys(&defrag4_net_ops);
 }
 
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index cb4eb1d2c620..205fb692f524 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/icmp.h>
+#include <linux/rcupdate.h>
 #include <linux/sysctl.h>
 #include <net/ipv6_frag.h>
 
@@ -96,6 +97,11 @@ static void __net_exit defrag6_net_exit(struct net *net)
 	}
 }
 
+static struct nf_defrag_v6_hook defrag_hook = {
+	.enable = nf_defrag_ipv6_enable,
+	.disable = nf_defrag_ipv6_disable,
+};
+
 static struct pernet_operations defrag6_net_ops = {
 	.exit = defrag6_net_exit,
 };
@@ -114,6 +120,9 @@ static int __init nf_defrag_init(void)
 		pr_err("nf_defrag_ipv6: can't register pernet ops\n");
 		goto cleanup_frag6;
 	}
+
+	rcu_assign_pointer(nf_defrag_v6_hook, &defrag_hook);
+
 	return ret;
 
 cleanup_frag6:
@@ -124,6 +133,7 @@ static int __init nf_defrag_init(void)
 
 static void __exit nf_defrag_fini(void)
 {
+	rcu_assign_pointer(nf_defrag_v6_hook, NULL);
 	unregister_pernet_subsys(&defrag6_net_ops);
 	nf_ct_frag6_cleanup();
 }
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5f76ae86a656..34845155bb85 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -680,6 +680,12 @@ EXPORT_SYMBOL_GPL(nfnl_ct_hook);
 const struct nf_ct_hook __rcu *nf_ct_hook __read_mostly;
 EXPORT_SYMBOL_GPL(nf_ct_hook);
 
+const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_defrag_v4_hook);
+
+const struct nf_defrag_v6_hook __rcu *nf_defrag_v6_hook __read_mostly;
+EXPORT_SYMBOL_GPL(nf_defrag_v6_hook);
+
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 u8 nf_ctnetlink_has_listener;
 EXPORT_SYMBOL_GPL(nf_ctnetlink_has_listener);
-- 
2.40.1

