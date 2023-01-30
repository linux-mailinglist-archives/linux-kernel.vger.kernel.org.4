Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5563A680987
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjA3Jap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjA3Ja0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:30:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC015CBC;
        Mon, 30 Jan 2023 01:28:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so7670708wmq.0;
        Mon, 30 Jan 2023 01:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuLcOVPfJKWmXcPSkUYt5otjql3lzwckGBRlOexX5eg=;
        b=ZXn2zd0063FyAix6NrN7VGDXhGb6b+O25Xp8PW/V2t53nvsxiQvM+0m3oLYK60pCiA
         I8P2TXZ4hc84wqBQySsHQ5Sict8RkPmhCS7XPCHyIYfPFl8sCRbFYM7HWBFG2O3Ber4c
         UxxpyWagXaVlhl8rCzljfAGoM6qopIdjVi+utn/zEiz+K9bqQtjWUwrPdJ96NW59xLNZ
         2nT05mw+FaH5q2V33bbX4E2YZM8kyb7O1KrNGoVXZl2uDNuqiKTtf0YbFJ1xmHNLMHI6
         P225XCTGdhGVcxqGK3OJLEtSGcH9w+J830OUj4KuGRjOCua0KKjzD7pxN3mg2wzvp17D
         qYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuLcOVPfJKWmXcPSkUYt5otjql3lzwckGBRlOexX5eg=;
        b=AuyeFaRPb7QO+0/EpzyKL8/Q1qjExaWM5XHyz+9eOQp+1H7sSJ3aU57f6Km8gup3Bc
         xwsKNO69dEoCCTkf0ASUbKimDEdSI6JWU82R2TpeerEuLQU45TUVgox+YCUEEyzNCSWf
         SKaQq4d1/DP2KLXoTdWrOZwo2xjxR56D0xwL4S8dZMQ0TaCog6q7FoZ9eypXh3SKTHzM
         yajupErCnT+/wLR+TKoAD/dCitm3jSxkFmllDISARuiTx/3dly4FnzdW7iMNa/Q8zybx
         8btPWLWELXUmNt2FWxXmRVw+YxguJbVyqpuzQJ1f++VrvNeNEQq8dfzIMaFf4NKZ6jaP
         605A==
X-Gm-Message-State: AFqh2krbdeVRfQAODQaEHM/jztISfg2QJI0UEOXhtRLRF6XyAmQA3Da9
        IEG1IyChJSuiwB3T4ukvKAI=
X-Google-Smtp-Source: AMrXdXubdJG4wn5XI09lBCNxLEtCZCPj/+tc/g+IZBKThni+yvDUga2N9vHiBJEIUAGiHHUrV0CFZg==
X-Received: by 2002:a05:600c:4f42:b0:3db:30c3:ed83 with SMTP id m2-20020a05600c4f4200b003db30c3ed83mr36215678wmq.28.1675070805951;
        Mon, 30 Jan 2023 01:26:45 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003db06493ee7sm17628908wmb.47.2023.01.30.01.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:26:45 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] vdpa: Fix a couple of spelling mistakes in some messages
Date:   Mon, 30 Jan 2023 09:26:44 +0000
Message-Id: <20230130092644.37002-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spelling mistakes in some literal strings. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/vdpa/vdpa.c                  | 2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 6821b2850bbb..a1bb5b92212d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1016,7 +1016,7 @@ static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
 	switch (device_id) {
 	case VIRTIO_ID_NET:
 		if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
-			NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
+			NL_SET_ERR_MSG_MOD(info->extack, "queue index exceeds max value");
 			err = -ERANGE;
 			break;
 		}
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index e827708adcca..862f405362de 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -324,7 +324,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
 				      rx_errors, VDPA_ATTR_PAD))
 			break;
 		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
-				  "rx overrunss"))
+				  "rx overruns"))
 			break;
 		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
 				      rx_overruns, VDPA_ATTR_PAD))
-- 
2.30.2

