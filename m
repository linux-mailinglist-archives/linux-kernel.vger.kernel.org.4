Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477C606A41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJTV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJTV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:27:18 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3991843F2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666301212; bh=C4WHuXkx1/hKHEmHE7E8g7Yt1qxpd0UvCFzbBZyxH2U=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=mb9/iWOtPwdpNYmGxpHJ3XV4HmSqxtkw8oWm9Aj7D+vQJUiEPrX3N7P8WX3wYRVc+
         NDRX6Q1S5xIivZgPSa6NuBYvWoF/EKxO/aAFayyVgMD1VjLOBqp3wH5hfN1GVgF7zn
         RXoHou1GXlv93x8JIq+IghRmvPFD77g1mQKMxego=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 23:26:52 +0200 (CEST)
X-EA-Auth: GzFpk7xfnmCpFAz9d7FB9xDYtPT/cfzELrX9DmLulOPZw+plv/ZVsZEs5h5JLxOYjj5XlNLpz6vN3SgwaSu9nmy7JQJfb2BU
Date:   Fri, 21 Oct 2022 02:56:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v4 01/11] staging: r8188eu: use Linux kernel variable naming
 convention
Message-ID: <a107c527e9032c22a62e93ff12d5fae625e70212.1666299151.git.drv@mailo.com>
References: <cover.1666299151.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the Linux Kernel coding style variable naming convention instead
of using camelCase style. Issue reported by checkpatch script for
these variables:
        tagLen, tagType, networkAddr, ipAddr, macAddr

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v4:
   1. Implement "use short variable name" feedback from David.Laight@ACULAB.COM

Changes in v3:
   -- None

Changes in v1 [actually v2]:
   1. Improve patch description per feedback from julia.lawall@inria.fr


 drivers/staging/r8188eu/core/rtw_br_ext.c | 112 +++++++++++-----------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 4c5f30792a46..e509b8454e25 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -50,17 +50,17 @@
 static unsigned char *__nat25_find_pppoe_tag(struct pppoe_hdr *ph, unsigned short type)
 {
 	unsigned char *cur_ptr, *start_ptr;
-	unsigned short tagLen, tagType;
+	unsigned short tag_len, tag_type;

 	start_ptr = (unsigned char *)ph->tag;
 	cur_ptr = (unsigned char *)ph->tag;
 	while ((cur_ptr - start_ptr) < ntohs(ph->length)) {
 		/*  prevent un-alignment access */
-		tagType = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
-		tagLen  = (unsigned short)((cur_ptr[2] << 8) + cur_ptr[3]);
-		if (tagType == type)
+		tag_type = (unsigned short)((cur_ptr[0] << 8) + cur_ptr[1]);
+		tag_len  = (unsigned short)((cur_ptr[2] << 8) + cur_ptr[3]);
+		if (tag_type == type)
 			return cur_ptr;
-		cur_ptr = cur_ptr + TAG_HDR_LEN + tagLen;
+		cur_ptr = cur_ptr + TAG_HDR_LEN + tag_len;
 	}
 	return NULL;
 }
@@ -111,32 +111,32 @@ static int  __nat25_has_expired(struct nat25_network_db_entry *fdb)
 	return 0;
 }

-static void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr,
-				unsigned int *ipAddr)
+static void __nat25_generate_ipv4_network_addr(unsigned char *addr,
+				unsigned int *ip_addr)
 {
-	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
+	memset(addr, 0, MAX_NETWORK_ADDR_LEN);

-	networkAddr[0] = NAT25_IPV4;
-	memcpy(networkAddr + 7, (unsigned char *)ipAddr, 4);
+	addr[0] = NAT25_IPV4;
+	memcpy(addr + 7, (unsigned char *)ip_addr, 4);
 }

-static void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
+static void __nat25_generate_pppoe_network_addr(unsigned char *addr,
 				unsigned char *ac_mac, __be16 *sid)
 {
-	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
+	memset(addr, 0, MAX_NETWORK_ADDR_LEN);

-	networkAddr[0] = NAT25_PPPOE;
-	memcpy(networkAddr + 1, (unsigned char *)sid, 2);
-	memcpy(networkAddr + 3, (unsigned char *)ac_mac, 6);
+	addr[0] = NAT25_PPPOE;
+	memcpy(addr + 1, (unsigned char *)sid, 2);
+	memcpy(addr + 3, (unsigned char *)ac_mac, 6);
 }

-static  void __nat25_generate_ipv6_network_addr(unsigned char *networkAddr,
-				unsigned int *ipAddr)
+static  void __nat25_generate_ipv6_network_addr(unsigned char *addr,
+				unsigned int *ip_addr)
 {
-	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
+	memset(addr, 0, MAX_NETWORK_ADDR_LEN);

-	networkAddr[0] = NAT25_IPV6;
-	memcpy(networkAddr + 1, (unsigned char *)ipAddr, 16);
+	addr[0] = NAT25_IPV6;
+	memcpy(addr + 1, (unsigned char *)ip_addr, 16);
 }

 static unsigned char *scan_tlv(unsigned char *data, int len, unsigned char tag, unsigned char len8b)
@@ -200,40 +200,40 @@ static int update_nd_link_layer_addr(unsigned char *data, int len, unsigned char
 	return 0;
 }

-static int __nat25_network_hash(unsigned char *networkAddr)
+static int __nat25_network_hash(unsigned char *addr)
 {
-	if (networkAddr[0] == NAT25_IPV4) {
+	if (addr[0] == NAT25_IPV4) {
 		unsigned long x;

-		x = networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10];
+		x = addr[7] ^ addr[8] ^ addr[9] ^ addr[10];

 		return x & (NAT25_HASH_SIZE - 1);
-	} else if (networkAddr[0] == NAT25_IPX) {
+	} else if (addr[0] == NAT25_IPX) {
 		unsigned long x;

-		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^
-			networkAddr[6] ^ networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10];
+		x = addr[1] ^ addr[2] ^ addr[3] ^ addr[4] ^ addr[5] ^
+			addr[6] ^ addr[7] ^ addr[8] ^ addr[9] ^ addr[10];

 		return x & (NAT25_HASH_SIZE - 1);
-	} else if (networkAddr[0] == NAT25_APPLE) {
+	} else if (addr[0] == NAT25_APPLE) {
 		unsigned long x;

-		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3];
+		x = addr[1] ^ addr[2] ^ addr[3];

 		return x & (NAT25_HASH_SIZE - 1);
-	} else if (networkAddr[0] == NAT25_PPPOE) {
+	} else if (addr[0] == NAT25_PPPOE) {
 		unsigned long x;

-		x = networkAddr[0] ^ networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^ networkAddr[6] ^ networkAddr[7] ^ networkAddr[8];
+		x = addr[0] ^ addr[1] ^ addr[2] ^ addr[3] ^ addr[4] ^ addr[5] ^ addr[6] ^ addr[7] ^ addr[8];

 		return x & (NAT25_HASH_SIZE - 1);
-	} else if (networkAddr[0] == NAT25_IPV6) {
+	} else if (addr[0] == NAT25_IPV6) {
 		unsigned long x;

-		x = networkAddr[1] ^ networkAddr[2] ^ networkAddr[3] ^ networkAddr[4] ^ networkAddr[5] ^
-			networkAddr[6] ^ networkAddr[7] ^ networkAddr[8] ^ networkAddr[9] ^ networkAddr[10] ^
-			networkAddr[11] ^ networkAddr[12] ^ networkAddr[13] ^ networkAddr[14] ^ networkAddr[15] ^
-			networkAddr[16];
+		x = addr[1] ^ addr[2] ^ addr[3] ^ addr[4] ^ addr[5] ^
+			addr[6] ^ addr[7] ^ addr[8] ^ addr[9] ^ addr[10] ^
+			addr[11] ^ addr[12] ^ addr[13] ^ addr[14] ^ addr[15] ^
+			addr[16];

 		return x & (NAT25_HASH_SIZE - 1);
 	} else {
@@ -241,7 +241,7 @@ static int __nat25_network_hash(unsigned char *networkAddr)
 		int i;

 		for (i = 0; i < MAX_NETWORK_ADDR_LEN; i++)
-			x ^= networkAddr[i];
+			x ^= addr[i];

 		return x & (NAT25_HASH_SIZE - 1);
 	}
@@ -269,17 +269,17 @@ static void __network_hash_unlink(struct nat25_network_db_entry *ent)
 }

 static void __nat25_db_network_insert(struct adapter *priv,
-				unsigned char *macAddr, unsigned char *networkAddr)
+				unsigned char *mac_addr, unsigned char *addr)
 {
 	struct nat25_network_db_entry *db;
 	int hash;

 	spin_lock_bh(&priv->br_ext_lock);
-	hash = __nat25_network_hash(networkAddr);
+	hash = __nat25_network_hash(addr);
 	db = priv->nethash[hash];
 	while (db) {
-		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
-			memcpy(db->macAddr, macAddr, ETH_ALEN);
+		if (!memcmp(db->networkAddr, addr, MAX_NETWORK_ADDR_LEN)) {
+			memcpy(db->macAddr, mac_addr, ETH_ALEN);
 			db->ageing_timer = jiffies;
 			spin_unlock_bh(&priv->br_ext_lock);
 			return;
@@ -291,8 +291,8 @@ static void __nat25_db_network_insert(struct adapter *priv,
 		spin_unlock_bh(&priv->br_ext_lock);
 		return;
 	}
-	memcpy(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN);
-	memcpy(db->macAddr, macAddr, ETH_ALEN);
+	memcpy(db->networkAddr, addr, MAX_NETWORK_ADDR_LEN);
+	memcpy(db->macAddr, mac_addr, ETH_ALEN);
 	atomic_set(&db->use_count, 1);
 	db->ageing_timer = jiffies;

@@ -366,7 +366,7 @@ void nat25_db_expire(struct adapter *priv)
 int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 {
 	unsigned short protocol;
-	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
+	unsigned char addr[MAX_NETWORK_ADDR_LEN];
 	unsigned int tmp;

 	if (!skb)
@@ -395,9 +395,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			if (iph->saddr == 0)
 				return 0;
 			tmp = be32_to_cpu(iph->saddr);
-			__nat25_generate_ipv4_network_addr(networkAddr, &tmp);
+			__nat25_generate_ipv4_network_addr(addr, &tmp);
 			/* record source IP address and , source mac address into db */
-			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
+			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, addr);
 			return 0;
 		default:
 			return -1;
@@ -421,8 +421,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			memcpy(arp_ptr, GET_MY_HWADDR(priv), ETH_ALEN);
 			arp_ptr += arp->ar_hln;
 			sender = (unsigned int *)arp_ptr;
-			__nat25_generate_ipv4_network_addr(networkAddr, sender);
-			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
+			__nat25_generate_ipv4_network_addr(addr, sender);
+			__nat25_db_network_insert(priv, skb->data + ETH_ALEN, addr);
 			return 0;
 		default:
 			return -1;
@@ -495,9 +495,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					return -1;
 				}
 			} else {	/*  session phase */
-				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
+				__nat25_generate_pppoe_network_addr(addr, skb->data, &ph->sid);

-				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
+				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, addr);

 				if (!priv->ethBrExtInfo.addPPPoETag &&
 				    priv->pppoe_connection_in_progress &&
@@ -548,8 +548,8 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			return -1;
 		case NAT25_INSERT:
 			if (memcmp(&iph->saddr, "\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0\x0", 16)) {
-				__nat25_generate_ipv6_network_addr(networkAddr, (unsigned int *)&iph->saddr);
-				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, networkAddr);
+				__nat25_generate_ipv6_network_addr(addr, (unsigned int *)&iph->saddr);
+				__nat25_db_network_insert(priv, skb->data + ETH_ALEN, addr);

 				if (iph->nexthdr == IPPROTO_ICMPV6 &&
 						skb->len > (ETH_HLEN +  sizeof(*iph) + 4)) {
@@ -639,17 +639,17 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 	}
 }

-void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr)
+void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
 {
-	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
+	unsigned char addr[MAX_NETWORK_ADDR_LEN];
 	struct nat25_network_db_entry *db;
 	int hash;

-	__nat25_generate_ipv4_network_addr(networkAddr, (unsigned int *)ipAddr);
-	hash = __nat25_network_hash(networkAddr);
+	__nat25_generate_ipv4_network_addr(addr, (unsigned int *)ip_addr);
+	hash = __nat25_network_hash(addr);
 	db = priv->nethash[hash];
 	while (db) {
-		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
+		if (!memcmp(db->networkAddr, addr, MAX_NETWORK_ADDR_LEN)) {
 			return (void *)db;
 		}

--
2.30.2



