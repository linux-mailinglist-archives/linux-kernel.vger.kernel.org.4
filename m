Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50C974BC80
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGHHIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:08:12 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89861FF6;
        Sat,  8 Jul 2023 00:08:09 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56344354e2cso2061889eaf.1;
        Sat, 08 Jul 2023 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688800089; x=1691392089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhOQaj6DH8O9iDDeN5q+g6pr6FJO1sQN66ELsNlx9aY=;
        b=Yqc5GlcJ5tBitAQkFanwJm/qSvFbEbVc4nz9BQ4HjQJLgKKLBpObSL3DKgK/T8Ep7d
         UaRD8UohHW+SLqKWWrhZ0DeqCwPrTa4ya8uIk3UGQDCYIRp+yB0ByR1uyXOfXicMAXub
         NxNrSVzJ56gWvBiPJWSPs62l2VVcIOgL7iby1LhmAzAyjOPb2sXCbtmXVACQwf/V8+1I
         5JqP+k/j2c4+Oh5CItVfIERbGIBMth4+Z2LtsK4BdvxDIcobj0YB8fooPTJmFnpiX6n7
         tTdn/8/CMQv2nm6tjBNWzYnrlHU/8GnNjO/f0AMr62kfYHNCIbI2f+sH4lMdjOvuwmFV
         FZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688800089; x=1691392089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhOQaj6DH8O9iDDeN5q+g6pr6FJO1sQN66ELsNlx9aY=;
        b=DeyAl+fVLSp4mSaKho1RIxY9QC0fponPgUYsgrfoS0aIn6AkKCHVVW1NmiGTFKmSyu
         Uym5J6l4v9C7LJZei99cgd3VQ7W1YpHJTxggeyXeVHD/NrMeN1L0VFkepRqZTupLd4/C
         MrG6XbnmtuvzER6uj7fwpIlrx6slgDya95wdePx0OfcM8h23MVbXOsqr+OUw9fbPWtii
         YcNneHeLqURyca8VsvcK3QOGPm9uSNYf+p9NaUjzXEF6HUzQVWPG0FYxLWpMcQlpLCOw
         JK+kJw5oswWWK6CxsLw0M8rnmjy7hV/a4AUcyiJrSKbIOEEYJcjm/xRmzJ17k5MwzxHG
         U6Ww==
X-Gm-Message-State: ABy/qLZigFI/T2EV6oBwvzFoq1xJyCL5+TT/ksQhqHNiDTaBJpZDsZt6
        WB7tS62ZCO0NzSNpWR0izxI=
X-Google-Smtp-Source: APBJJlGNBQZBwxLer5NcCiWnab4doxze9cZqlQlvd0mA4RpMCv/7iE//0NNRjSfDOqZJWpie9st4iw==
X-Received: by 2002:a05:6808:138c:b0:3a3:9463:ccbf with SMTP id c12-20020a056808138c00b003a39463ccbfmr9939334oiw.15.1688800089035;
        Sat, 08 Jul 2023 00:08:09 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b00678159eacecsm3819078pff.121.2023.07.08.00.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 00:08:08 -0700 (PDT)
From:   pinkperfect <pinkperfect2021@gmail.com>
To:     amitkarwar@gmail.com, kvalo@kernel.org, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pinkperfect <pinkperfect2021@gmail.com>
Subject: [PATCH v2] wifi: mwifiex: Fix OOB and integer underflow in mwifiex_process_mgmt_packet
Date:   Sat,  8 Jul 2023 07:07:49 +0000
Message-Id: <20230708070749.2382045-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In outside functions have checked upper limit of rx_pkt_length,
in mwifiex_process_mgmt_packet should make sure rx_pkt_length not underflow
and make sure skb->len big enough to avoid OOB access.

Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 94c2d219835d..31e1a82883e4 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 
 	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
 
+	if (pkt_len < sizeof(struct ieee80211_hdr) || skb->len < pkt_len) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
+
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
 		if (mwifiex_parse_mgmt_packet(priv, (u8 *)ieee_hdr,
-- 
2.25.1

