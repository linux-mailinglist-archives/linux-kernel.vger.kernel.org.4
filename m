Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1EA652149
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiLTNMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiLTNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:12:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F1D192BC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:12:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d14so17349876edj.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4EnR1Q2u0KKc+AisGhIqSegw9gJYBOb4g7u1uoRDKQ=;
        b=qmvRNGGfv5Q9RsUhDR3YCEjut9VKcvoxCb2plew0zftB4wQ8tjg807fW2FKQm+1pKH
         EEQSA0ArV/KMpzFq7hAjCnubq84xon/6NTjdw8Wqh6lmI716+A4tAc+dltkK/C/4upFG
         X8BOnx37ut/P/VRj+frZWrFfo23RUwWAT9jtviN66lYYP1OlHQG5xKXwlHpNmEkqy/0j
         ZCvjfSoqcgndd7+TsgtOM4Oo3NC1NUKZ8btlLAJ9ANu9h16bEuPi/gn8WU485VIJYpHH
         A9+Ch8k/OBtl7Jiofz+9C2h267cAuBLUcdeSidbIOWbplcpyf6qELDIl804wJkQ4BULl
         BB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4EnR1Q2u0KKc+AisGhIqSegw9gJYBOb4g7u1uoRDKQ=;
        b=xgYU5wL+1OV3CRRu1A4mWc5oRZSlaJY/F846tRTVUo9Nn+EhbNpE25cOCuKiovQJyG
         Aqdy6gL/SXg5CRgBuOrZA8o9YO3hxpUHkNDdDisiFmOKMqWY25xly4xuued8JiFOzG4f
         pIF52ldbHW33lCDLuzaRvzIWH+lmOai6XC5L0DTeeqCAuBtBRiYtyDuLWxrOC5uW9832
         3d2ydGQFUuSM5Vrz4CjAlrnVAeX5Qimo3Zw32JvYeITOzY50Q29ZUp1+fChsDxYEVLmK
         cS+m/4TFfz22/GeSal6bt1qavbqxvl/dHHiErwY+W5xt4AINI1OSzZuPXuIlE4TGdaIs
         FiDQ==
X-Gm-Message-State: ANoB5pk8qhW7Oz8n5G3NWavy8e+jwz8yfOCkM3NVysDObk+fJSfgMbsD
        xnZQsLHD6gmniYDfrsR983drAw==
X-Google-Smtp-Source: AA0mqf5K8Jho4KqtiH8YiRCiYCCCv+pz5OVPHPtuUaFRmec4xRyybJhBjw+mLc2l4m9CTzoYLs7nrg==
X-Received: by 2002:aa7:db43:0:b0:46c:2c94:d30b with SMTP id n3-20020aa7db43000000b0046c2c94d30bmr54636028edt.33.1671541930207;
        Tue, 20 Dec 2022 05:12:10 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id h31-20020a0564020e9f00b0046ba536ce52sm5533691eda.95.2022.12.20.05.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:12:09 -0800 (PST)
Message-ID: <82b18028-7246-9af9-c992-528a0e77f6ba@linaro.org>
Date:   Tue, 20 Dec 2022 15:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, willemb@google.com,
        syzkaller@googlegroups.com, liuhangbin@gmail.com
Cc:     linux-kernel@vger.kernel.org, joneslee@google.com
Subject: kernel BUG in __skb_gso_segment
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's a bug [1] reported by syzkaller in linux-5.15.y that I'd like
to squash. The commit in stable that introduces the bug is:
b99c71f90978 net: skip virtio_net_hdr_set_proto if protocol already set
The upstream commit for this is:
1ed1d592113959f00cc552c3b9f47ca2d157768f

I discovered that in mainline this bug was squashed by the following
commits:
e9d3f80935b6 ("net/af_packet: make sure to pull mac header")
dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")

I'm seeking for some guidance on how to fix linux-5.15.y. From what I
understand, the bug in stable is triggered because we end up with a
header offset of 18, that eventually triggers the GSO crash in
__skb_pull. If I revert the commit in culprit from linux-5.15.y, we'll
end up with a header offset of 14, the bug is not hit and the packet is 
dropped at validate_xmit_skb() time. I'm wondering if reverting it is
the right thing to do, as the commit is marked as a fix. Backporting the
2 commits from mainline is not an option as they introduce new support.
Would such a patch be better than reverting the offending commit?

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a960de68ac69..188b6f05e5bd 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -25,7 +25,7 @@ static inline bool virtio_net_hdr_match_proto(__be16 
protocol, __u8 gso_type)
  static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
                                            const struct virtio_net_hdr 
*hdr)
  {
-       if (skb->protocol)
+       if (skb->protocol && skb->protocol != htons(ETH_P_ALL))
                 return 0;

         switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {


Thanks!
ta

[1] 
https://syzkaller.appspot.com/bug?id=ce5575575f074c33ff80d104f5baee26f22e95f5
