Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3581E5F0825
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiI3KAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiI3KA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:00:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC312B27C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:00:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l12so4247982ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eflBW1/omcz649gzqa80EdxHOHLRvARzQtLAthFPzJI=;
        b=OWK5LGKWP0pdp3UPFCNUfXZUKNnZoBJUrmaauwMpZ82/O4KMFbn4fiY5fm0U5Ydqld
         OsiAVf+z608fk9ECGQhxGFQzomsxoLyemejEjZHZ+DGWAr++8OYtnDf+pJDBIZToR878
         gfptsC3sbcKHx7ZTNpJok8J2N+TQOp66L1Jg3EP2AfGAUTEosVpw43u8rqeSqUs8LVWF
         ZFHFjy0CJaDfUa5B61twfyKo88jykM86qFHIoWncHvxv4n0TxHNOLDsrUHWnrwPGelj/
         V/fISMnD0XD5ynehEItyMZ4az5V3iZWBJJGca2njI6DzP7lvejVWnowY1lM2Wln3FJyu
         mxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eflBW1/omcz649gzqa80EdxHOHLRvARzQtLAthFPzJI=;
        b=7HjxhuKDG5spdTNVhTW9jBqF1Pm1PXONns97+DJlb6BWmYPIQF1FllxgVyIGZXbhSW
         R+8tDJJQutjuQOWy61xiWT/I7qqRfFIIRn2GwMyJa6yaqDzxBc+h/pIN+619It339wVW
         Ld80+qNCQkkDx2BxaCovY8zs5NywsoWZBBd1n9HkZFqGsQ6K3eW7AUYo8bXqBJfvBQqQ
         Afv4xFP5UnAoqUmaOuHj43eMlkYsQprAQHLdqTyWAY4288kjTtKNtuOycgItF2TYwDGM
         P3DnQKYrWIHrfBPlWqAvILFwrBMml2fTau15Dpi7856Ga8QCpkvwQC7DiJkmr2ipe5Sf
         DdIQ==
X-Gm-Message-State: ACrzQf192Vwda3PwfKCqnOLA9ot484krhJvP9iUT6fwaifGmBd6/kq3O
        bqZuzQzkqjkhDmJe1V6nHNVYPg==
X-Google-Smtp-Source: AMsMyM6B4uYou33xi63CeYgaZwCwUV++xi/7sDtaqK1haWq9kFsQCN9YPhgm/HPc4sDoaDjGduqapQ==
X-Received: by 2002:a2e:a54b:0:b0:26c:72ed:b758 with SMTP id e11-20020a2ea54b000000b0026c72edb758mr2692885ljn.245.1664532017099;
        Fri, 30 Sep 2022 03:00:17 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q65-20020a2e2a44000000b0026c3e350682sm113521ljq.14.2022.09.30.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:00:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] slimbus: stream: handle unsupported bitrates for presence rate
Date:   Fri, 30 Sep 2022 12:00:14 +0200
Message-Id: <20220930100015.259106-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle errors of getting presence rate for unsupported stream bitrate,
instead of sending -EINVAL in change content message.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v1:
1. Rebase (drop development pieces in the context).
2. Return prrate (which has errno) instead of -EINVAL.
3. Add Rb tag.
---
 drivers/slimbus/stream.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index d5ce974e880b..f631d5ed9809 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 {
 	struct slim_controller *ctrl = rt->dev->ctrl;
 	struct slim_port *port;
-	int num_ports, i, port_id;
+	int num_ports, i, port_id, prrate;
 
 	if (rt->ports) {
 		dev_err(&rt->dev->dev, "Stream already Prepared\n");
@@ -221,6 +221,13 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 	rt->bps = cfg->bps;
 	rt->direction = cfg->direction;
 
+	prrate = slim_get_prate_code(cfg->rate);
+	if (prrate < 0) {
+		dev_err(&rt->dev->dev, "Cannot get presence rate for rate %d Hz\n",
+			cfg->rate);
+		return prrate;
+	}
+
 	if (cfg->rate % ctrl->a_framer->superfreq) {
 		/*
 		 * data rate not exactly multiple of super frame,
@@ -241,7 +248,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 		port = &rt->ports[i];
 		port->state = SLIM_PORT_DISCONNECTED;
 		port->id = port_id;
-		port->ch.prrate = slim_get_prate_code(cfg->rate);
+		port->ch.prrate = prrate;
 		port->ch.id = cfg->chs[i];
 		port->ch.data_fmt = SLIM_CH_DATA_FMT_NOT_DEFINED;
 		port->ch.aux_fmt = SLIM_CH_AUX_FMT_NOT_APPLICABLE;
-- 
2.34.1

