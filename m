Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893C5F076F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiI3JUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiI3JUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:20:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77A4DB3A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:20:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu25so5976084lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JUsD5OyMxzTqjJC2MueYgQBSzr/7dS7Jwt69lfzIL4M=;
        b=AZQiM/rFdvvMZHz8CLmCW8QSQW2kURL/RUSJ1xj6rxN/LqgaEMnHvsYxPLuUGOz49A
         rwPZJPAsf0vOTeHiS/MKyEiPeP4t2r0S+o0jjEcGO+fBnka+KjV4yjuu6irOIaAr3L/Q
         f8pMf4YDUVzPq9ti8S/T02uLXC6sH0R/M9iAJpVpKGl72d4Cta0HtouQx6YAwZdC7pFo
         oz4ZT9GZPP1Tljc59oXOjcX14ozmXnX0LPjh5s385LR+siRQWRlc0wY7NXNy2bZ1/bHv
         jhQ3mz0dpl6GLGIG6lvZt+HBaX0tXQEpx3Z29A+jEEcgKaoB6C6p2q/jJD/3a9Xk2h45
         oeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JUsD5OyMxzTqjJC2MueYgQBSzr/7dS7Jwt69lfzIL4M=;
        b=4mbsVJprLOr2sM7YZnTHjziFtfCd/rS8WIu6TGmCFu4MigrZF2EV4efcejmBPETgGh
         YBqOZ3PVBky4zZoftRRR1FuK52IVcu2LNIWBnJrA5X43hUnpWeV50FqJxHkr0oCd0o+b
         4fdbdLE96+UoynQMdyYEOkRZgz0GBUOPisO9c1xqt9ktWHhCQyZFok/5wWQwBb89PXp5
         h90/N727MsY7hwTNrDjF1dMR87o3gxvNepwf62bpMHskeV5uNrcykHyCcmP/ASboeikh
         kWmJiiLU31ywDLFv6dUXQKnNjnvlSSbGiRFSPFtiWp1jZsJ3hy2v0XOTRsKoSASaqnV+
         5DDw==
X-Gm-Message-State: ACrzQf1Ox24nBjTU4xb0UYUPZyUltt4K0Exczh7xYvSkaoW1EhcOcmAV
        XIUVRrdpQW9WqH7tGTKE5iqzpw==
X-Google-Smtp-Source: AMsMyM7MmADAWQBvaYBjBOds2otRjU2INo8y9+KsdLttZq9CCty5vGMNFq1nb8eMuG8ekVRHWuDXzQ==
X-Received: by 2002:a05:6512:3185:b0:49c:3310:6910 with SMTP id i5-20020a056512318500b0049c33106910mr3408122lfe.352.1664529608805;
        Fri, 30 Sep 2022 02:20:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea226000000b0026aba858fbfsm103461ljm.137.2022.09.30.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:20:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] slimbus: stream: handle unsupported bitrates for presence rate
Date:   Fri, 30 Sep 2022 11:20:05 +0200
Message-Id: <20220930092006.85982-1-krzysztof.kozlowski@linaro.org>
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
---
 drivers/slimbus/stream.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index f8eade1e0132..28fbecb3907d 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -204,7 +204,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 {
 	struct slim_controller *ctrl = rt->dev->ctrl;
 	struct slim_port *port;
-	int num_ports, i, port_id;
+	int num_ports, i, port_id, prrate;
 
 	pr_err("%s:%d AAAA\n", __func__, __LINE__);
 	if (rt->ports) {
@@ -222,6 +222,13 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
 	rt->bps = cfg->bps;
 	rt->direction = cfg->direction;
 
+	prrate = slim_get_prate_code(cfg->rate);
+	if (prrate < 0) {
+		dev_err(&rt->dev->dev, "Cannot get presence rate for rate %d Hz\n",
+			cfg->rate);
+		return -EINVAL;
+	}
+
 	if (cfg->rate % ctrl->a_framer->superfreq) {
 		/*
 		 * data rate not exactly multiple of super frame,
@@ -242,7 +249,7 @@ int slim_stream_prepare(struct slim_stream_runtime *rt,
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

