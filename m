Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCC74B557
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjGGQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGGQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:51:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD5D213F;
        Fri,  7 Jul 2023 09:51:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 10E5E3200938;
        Fri,  7 Jul 2023 12:51:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Jul 2023 12:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688748671; x=
        1688835071; bh=FoKm3yKhKCBi4WaMIZuBtdvEh2SuGoVcGT/CE3PLqoA=; b=C
        pxGoRIpbUCuQHC1kMtptwC/nXVPgw0FdIcUX373heYLLSE+iGY3QDgw8Qog8iUwQ
        FuOb63921KrskCllt6uThhF8DgKihR0Dgr1/N9/KywDhfNELwfbB8vD/oLNRHstt
        srYuTzk1cJYOOQ+yMUNlsE+i8028Pg7OUPSiuXw0t+RLVHTTS6idix1IWtuXYGtZ
        u0WWDg085T8oFNsOsBs5Rrr+L/Rm5NUO42EWxD03GqX4+8fmGC4uxu/yvWmjfJK2
        CwrXRhRSuqc4QCcqGIsBTPPnwsI3Xzotc3iJEgZ27F7TEpCAvIa4cUctYaqFWDNo
        VWzPEZL5WeT+JbGIoN0/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688748671; x=
        1688835071; bh=FoKm3yKhKCBi4WaMIZuBtdvEh2SuGoVcGT/CE3PLqoA=; b=Q
        DfYGk3xUcWSyYfR+RC0Us6MfKvC4LXJ1CAQ689aBL9chjm3Tr8sVAL5nva/k11im
        7qAHuv+ZdnDBsO03LPe/ScxLuir6zTE9B3hmJII1cDHaHbGkedNjm4bfm2edWuqC
        U39FP9vizPXpWmkEl8QnCJ18mlanbZ+COxb/+1DlRfFQmFxtkpboE9jaGUddznvg
        fcrvbpxOqBdR83kdwNLPQH8Oi1BsBXBG7NvsYWs/W7vNwVH/suB/R/MwE49bOwB1
        8hQxz+5zVlwXo64aCWwV6K6Vykx4niTWnDgRWf+zll6UM5lhbEVSFqqGwnrttI9S
        /HpO5Qx6skqTKnZtYGzJQ==
X-ME-Sender: <xms:f0KoZLdSiLU_MrpZKNp8HhNLe1w5TV749V5X-FmFuPGYexblamkSgA>
    <xme:f0KoZBO-BQAB_nv7CjnTqDx0BDwMZqVfLVO7WDh5j2DGxipzHD-SGpFQcy7ZreimY
    UhHlL7YB5AqZ2lMag>
X-ME-Received: <xmr:f0KoZEhYG9bspBzXINCX4smns-xtkK7EqjcdzW51Lyig7ph3sc9sykRQcxKnnJMR7Eb95jFaFsvOSr-rYmUVBVGoZ790Pt0EqgNMtCkzljU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:f0KoZM-yONI7pt_XjeVlwaGRoWBWWal2nT-ExAHvDQW7oEHZ8cStHg>
    <xmx:f0KoZHvg4QfdGuCTqiLwzjZMN7Fmpg0KAovd-l_J7kIgIyPKhGyaJQ>
    <xmx:f0KoZLGyJWdctpcpaKVSEqJmo2oE6ZnVsEhLuU1FSqOs7rxeYEvIBQ>
    <xmx:f0KoZAGsrq4lIiKE7lyEcGrlGMc_EY-RXmI-jrLEuz7gV6AI333GYg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 12:51:10 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     pablo@netfilter.org, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, kadlec@netfilter.org, pabeni@redhat.com,
        dsahern@kernel.org, fw@strlen.de, daniel@iogearbox.net
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] netfilter: bpf: Prevent defrag module unload while link active
Date:   Fri,  7 Jul 2023 10:50:18 -0600
Message-ID: <7549d65daa702ba89aa3e43d5a1bbd562d569a99.1688748455.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688748455.git.dxu@dxuuu.xyz>
References: <cover.1688748455.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in practice we could handle the module being unloaded while a
netfilter link (that requested defrag) was active, it's a better user
experience to prevent the defrag module from going away. It would
violate user expectations if fragmented packets started showing up if
some other part of the system tried to unload defrag module.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netfilter.h                 |  3 +++
 net/ipv4/netfilter/nf_defrag_ipv4.c       |  1 +
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c |  1 +
 net/netfilter/nf_bpf_link.c               | 25 +++++++++++++++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 77a637b681f2..a160dc1e23bf 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/static_key.h>
+#include <linux/module.h>
 #include <linux/netfilter_defs.h>
 #include <linux/netdevice.h>
 #include <linux/sockptr.h>
@@ -482,12 +483,14 @@ struct nfnl_ct_hook {
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
 struct nf_defrag_v4_hook {
+	struct module *owner;
 	int (*enable)(struct net *net);
 	void (*disable)(struct net *net);
 };
 extern const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook;
 
 struct nf_defrag_v6_hook {
+	struct module *owner;
 	int (*enable)(struct net *net);
 	void (*disable)(struct net *net);
 };
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index 1f3e0e893b7a..fb133bf3131d 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -115,6 +115,7 @@ static void __net_exit defrag4_net_exit(struct net *net)
 }
 
 static const struct nf_defrag_v4_hook defrag_hook = {
+	.owner = THIS_MODULE,
 	.enable = nf_defrag_ipv4_enable,
 	.disable = nf_defrag_ipv4_disable,
 };
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index f7c7ee31c472..29d31721c9c0 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -98,6 +98,7 @@ static void __net_exit defrag6_net_exit(struct net *net)
 }
 
 static const struct nf_defrag_v6_hook defrag_hook = {
+	.owner = THIS_MODULE,
 	.enable = nf_defrag_ipv6_enable,
 	.disable = nf_defrag_ipv6_disable,
 };
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 5b72aa246577..77ffbf26ba3d 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/kmod.h>
+#include <linux/module.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -53,7 +54,15 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 			}
 		}
 
+		/* Prevent defrag module from going away while in use */
+		if (!try_module_get(v4_hook->owner)) {
+			err = -ENOENT;
+			goto out_v4;
+		}
+
 		err = v4_hook->enable(link->net);
+		if (err)
+			module_put(v4_hook->owner);
 out_v4:
 		rcu_read_unlock();
 		return err;
@@ -77,7 +86,15 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 			}
 		}
 
+		/* Prevent defrag module from going away while in use */
+		if (!try_module_get(v6_hook->owner)) {
+			err = -ENOENT;
+			goto out_v6;
+		}
+
 		err = v6_hook->enable(link->net);
+		if (err)
+			module_put(v6_hook->owner);
 out_v6:
 		rcu_read_unlock();
 		return err;
@@ -97,8 +114,10 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
 	case NFPROTO_IPV4:
 		rcu_read_lock();
 		v4_hook = rcu_dereference(nf_defrag_v4_hook);
-		if (v4_hook)
+		if (v4_hook) {
 			v4_hook->disable(link->net);
+			module_put(v4_hook->owner);
+		}
 		rcu_read_unlock();
 
 		break;
@@ -107,8 +126,10 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
 	case NFPROTO_IPV6:
 		rcu_read_lock();
 		v6_hook = rcu_dereference(nf_defrag_v6_hook);
-		if (v6_hook)
+		if (v6_hook) {
 			v6_hook->disable(link->net);
+			module_put(v6_hook->owner);
+		}
 		rcu_read_unlock();
 
 		break;
-- 
2.41.0

