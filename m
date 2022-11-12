Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C60626947
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiKLLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:46:43 -0500
X-Greylist: delayed 3487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 03:46:41 PST
Received: from mail-01-2.mymagenta.at (mail-01-2.mymagenta.at [80.109.253.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E1619026
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:46:41 -0800 (PST)
Received: from [192.168.232.135] (helo=ren-mail-psmtp-mg01.)
        by mail-01.mymagenta.at with esmtp (Exim 4.93)
        (envelope-from <thomas.zeitlhofer+lkml@ze-it.at>)
        id 1oto3q-003ArI-Qb
        for linux-kernel@vger.kernel.org; Sat, 12 Nov 2022 11:48:30 +0100
Received: from mr2 ([80.108.14.110])
        by ren-mail-psmtp-mg01. with ESMTP
        id to3poEhQDOG5Zto3podtXj; Sat, 12 Nov 2022 11:48:30 +0100
X-Env-Mailfrom: thomas.zeitlhofer+lkml@ze-it.at
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 80.108.14.110
X-CNFS-Analysis: v=2.4 cv=KJo5sHJo c=1 sm=1 tr=0 ts=636f79fe
 a=tVdsoMYQxO1CUTS6b4mKlQ==:117 a=tVdsoMYQxO1CUTS6b4mKlQ==:17
 a=kj9zAlcOel0A:10 a=VG87k5yWxwQ-MwjZPvcA:9 a=CjuIK1q_8ugA:10
Date:   Sat, 12 Nov 2022 11:48:27 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        "Denis V. Lunev" <den@openvz.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: neigh: decrement the family specific qlen
Message-ID: <Y295+9+JDjqRWbwU@x1.ze-it.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4xfFVWgsp8IYBGTwQJ6kSook4nMZDwx0h6hGZImeDR02IB3tnm9k1hkM6XugViv1f6IsJjWGoLVbNO6mRDcxd/p6KQNSlRHESZW0yN+nerryB5E/mlXJ6K
 kf3ktCAFNF8Xr1SLDgLEoI9rdRb+g5MIowjvFXEglk75M/m3DggEvpDJrih9etJbWVVh+6hmPoRkMB79WoL7HDzjFkFvRoue6DW9xzBmmt3Bs0pURIBPzoz+
 EdOJwcF+qHu0pdE8WsCPu/vV4W3XyBKQooOFXWdDdcrVbLmB5W9kgHjOghezG5Zlzj3x6xS47uCxmwRh1K/n8AcN5zM+LkzB3ERYOGkGNHv/eUnycF2lfIrx
 il4Zec/jcxmNM2Cq9AnYsV+/R0dbvk7vnIDy7ac6aRmXFi82A8P2i1AUG9dly94RberQ04ZbQTmWgKEGWjBsz/N8W7PLaXqa4iT8Lv0F7BPBwAiccdVN7Pfs
 YAS3++IAxvAhX1GSmWUYYhurR2LkH9gUOQVl9FgN8hKe5VAcFFexCfGL5XBHI+CGCRU9GEgWPaf63q7oMm6qZ0zHheKeO7X8FzBhhrA5QBHJrCoSdUOZfsml
 b2D464HdZj7c886C4WgaQPYrqU/UGj+Eb+ysYHQW/hvTSA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0ff4eb3d5ebb ("neighbour: make proxy_queue.qlen limit
per-device") introduced the length counter qlen in struct neigh_parms.
There are separate neigh_parms instances for IPv4/ARP and IPv6/ND, and
while the family specific qlen is incremented in pneigh_enqueue(), the
mentioned commit decrements always the IPv4/ARP specific qlen,
regardless of the currently processed family, in pneigh_queue_purge()
and neigh_proxy_process().

As a result, with IPv6/ND, the family specific qlen is only incremented
(and never decremented) until it exceeds PROXY_QLEN, and then, according
to the check in pneigh_enqueue(), neighbor solicitations are not
answered anymore. As an example, this is noted when using the
subnet-router anycast address to access a Linux router. After a certain
amount of time (in the observed case, qlen exceeded PROXY_QLEN after two
days), the Linux router stops answering neighbor solicitations for its
subnet-router anycast address and effectively becomes unreachable.

Another result with IPv6/ND is that the IPv4/ARP specific qlen is
decremented more often than incremented. This leads to negative qlen
values, as a signed integer has been used for the length counter qlen,
and potentially to an integer overflow.

Fix this by introducing the helper function neigh_parms_qlen_dec(),
which decrements the family specific qlen. Thereby, make use of the
existing helper function neigh_get_dev_parms_rcu(), whose definition
therefore needs to be placed earlier in neighbour.c. Take the family
member from struct neigh_table to determine the currently processed
family and appropriately call neigh_parms_qlen_dec() from
pneigh_queue_purge() and neigh_proxy_process().

Additionally, use an unsigned integer for the length counter qlen.

Fixes: 0ff4eb3d5ebb ("neighbour: make proxy_queue.qlen limit per-device")
Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
---
 include/net/neighbour.h |  2 +-
 net/core/neighbour.c    | 58 +++++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 20745cf7ae1a..cc0b65b7c829 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -83,7 +83,7 @@ struct neigh_parms {
 	struct rcu_head rcu_head;
 
 	int	reachable_time;
-	int	qlen;
+	__u32	qlen;
 	int	data[NEIGH_VAR_DATA_MAX];
 	DECLARE_BITMAP(data_state, NEIGH_VAR_DATA_MAX);
 };
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a77a85e357e0..952a54763358 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -307,7 +307,31 @@ static int neigh_del_timer(struct neighbour *n)
 	return 0;
 }
 
-static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net)
+static struct neigh_parms *neigh_get_dev_parms_rcu(struct net_device *dev,
+						   int family)
+{
+	switch (family) {
+	case AF_INET:
+		return __in_dev_arp_parms_get_rcu(dev);
+	case AF_INET6:
+		return __in6_dev_nd_parms_get_rcu(dev);
+	}
+	return NULL;
+}
+
+static void neigh_parms_qlen_dec(struct net_device *dev, int family)
+{
+	struct neigh_parms *p;
+
+	rcu_read_lock();
+	p = neigh_get_dev_parms_rcu(dev, family);
+	if (p)
+		p->qlen--;
+	rcu_read_unlock();
+}
+
+static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
+			       int family)
 {
 	struct sk_buff_head tmp;
 	unsigned long flags;
@@ -321,13 +345,7 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net)
 		struct net_device *dev = skb->dev;
 
 		if (net == NULL || net_eq(dev_net(dev), net)) {
-			struct in_device *in_dev;
-
-			rcu_read_lock();
-			in_dev = __in_dev_get_rcu(dev);
-			if (in_dev)
-				in_dev->arp_parms->qlen--;
-			rcu_read_unlock();
+			neigh_parms_qlen_dec(dev, family);
 			__skb_unlink(skb, list);
 			__skb_queue_tail(&tmp, skb);
 		}
@@ -409,7 +427,8 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
 	pneigh_ifdown_and_unlock(tbl, dev);
-	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL);
+	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
+			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
 		del_timer_sync(&tbl->proxy_timer);
 	return 0;
@@ -1621,13 +1640,8 @@ static void neigh_proxy_process(struct timer_list *t)
 
 		if (tdif <= 0) {
 			struct net_device *dev = skb->dev;
-			struct in_device *in_dev;
 
-			rcu_read_lock();
-			in_dev = __in_dev_get_rcu(dev);
-			if (in_dev)
-				in_dev->arp_parms->qlen--;
-			rcu_read_unlock();
+			neigh_parms_qlen_dec(dev, tbl->family);
 			__skb_unlink(skb, &tbl->proxy_queue);
 
 			if (tbl->proxy_redo && netif_running(dev)) {
@@ -1821,7 +1835,7 @@ int neigh_table_clear(int index, struct neigh_table *tbl)
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
 	del_timer_sync(&tbl->proxy_timer);
-	pneigh_queue_purge(&tbl->proxy_queue, NULL);
+	pneigh_queue_purge(&tbl->proxy_queue, NULL, tbl->family);
 	neigh_ifdown(tbl, NULL);
 	if (atomic_read(&tbl->entries))
 		pr_crit("neighbour leakage\n");
@@ -3539,18 +3553,6 @@ static int proc_unres_qlen(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static struct neigh_parms *neigh_get_dev_parms_rcu(struct net_device *dev,
-						   int family)
-{
-	switch (family) {
-	case AF_INET:
-		return __in_dev_arp_parms_get_rcu(dev);
-	case AF_INET6:
-		return __in6_dev_nd_parms_get_rcu(dev);
-	}
-	return NULL;
-}
-
 static void neigh_copy_dflt_parms(struct net *net, struct neigh_parms *p,
 				  int index)
 {
-- 
2.30.2

