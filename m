Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31463FAD8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiLAWs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiLAWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:48:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DA9C617
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:48:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d6so4759603lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
        b=bJT+6Pf3gru2G2faqNC14AW+QMpsR+xneNE6bi+nKD/YnzuiEQuBNxCfistgza0ycf
         GZRQfPHJd9PCQKfct4zOcD7tinF1//EGcbuVyO10QoRxbK6RX4VVtG4WIOUQIjLz4W8p
         FEx2qQ8d+p6PoKZHfzWYpZ3ZmZJ0Gs4l/CJpFvhnADgyC2mXMgddYYf5QbhGcnFdMVnX
         mm5cR1pz0OaE7b3Bs5WsY4NqHcUlxxUUWb20dWgMz9APsKjDt4sV0dlCzyxrxIl/yYt9
         Ce3tvHvPymkAbXbt/nE9ZXEXmjAdVEsW14oNY7PsOdsWnZR1AmaobLwlBzfrN+ekHykV
         zQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
        b=SloVfUbdAL6HUwugkysyT5l5bLIHdBRW4oKhL9le6VCnV4Bs36ueElHFd+z/41CZwi
         45lN4Xh4CvO5XnsutVx0nYbShTSThExyUu3lyQjY1U0w6ATTRJtNnLPznrz4t2yDD4P+
         omKdEnICqGOIT5K4rfh19TEfLvBZ+0B1RHN0qMmJkEC+VWDRQeAsVkhIrVndAzwA/guY
         wVuNt6XD4WRY8lhk3SvDM1mwE//uI/QxhA6xp0Dpz4L2uXhiQZxWfD0SYxR2fTf+Qv1Q
         E12IVx9Euv3DuOq4LTYjllc2q6oSrW2Bb1b3O/ydaiDxzMi3ZPDgyEQiUCU4XkpGF4uu
         7ABQ==
X-Gm-Message-State: ANoB5pl8pUP0hJqMTn2ZGuYDTXpsBETiVUon1tnRl9aVyIW5R6ht4/03
        dAg2oNGUFlPf5JjAprg/EF4JVg==
X-Google-Smtp-Source: AA0mqf51S5q3EqKANfIuARmbkNeUOH//5Qb1QqfZRiiA7+e6V4Q7Wdii+gb3R41/Q/ugVOJ/EGgoTw==
X-Received: by 2002:ac2:5f6c:0:b0:4a2:bca5:76bc with SMTP id c12-20020ac25f6c000000b004a2bca576bcmr16343840lfc.123.1669934929672;
        Thu, 01 Dec 2022 14:48:49 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:48:49 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     devel@daynix.com
Subject: [PATCH v4 1/6] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date:   Fri,  2 Dec 2022 00:33:27 +0200
Message-Id: <20221201223332.249441-1-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow UDP_L4 for robust packets.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 net/ipv4/udp_offload.c | 3 ++-
 net/ipv6/udp_offload.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6d1a4bec2614..f65b1a7a0c26 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -387,7 +387,8 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 7720d04ed396..057293293e30 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -42,7 +42,8 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 			return __udp_gso_segment(skb, features, true);
 
 		mss = skb_shinfo(skb)->gso_size;
-- 
2.38.1

