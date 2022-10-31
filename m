Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA118613931
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiJaOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJaOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:44:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C55CE10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:44:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d25so19161979lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lKadDZkcrZY+mBoo+J3JnRJGkskmKs9cjQkiel3sGM=;
        b=mBBMvP91Xmkn6K5qBGVyEILzaAn5KIkGShixlUXwALpTb3uX9+NYN1upHeZtb4NZdg
         1YHQWtIq6Jj2UWRPty/Ce06X1EyKjIpdWBVPnuhxxKFoCVMBU/IrqqM339Mg6xYzra8e
         cgNGZuLyL6uMdPZubO4lgUh3y80/yrJB53mWON4wstGfQ5zzg5AVuwH+TIF3ZUu9Dec8
         gob3Ust2j/2GL+GoeZheZdFVmFrHsGYIBMr9GGK+w9Oq6lIDdXD4qKMqedAD95Kd6BXl
         +RQ92+FCp731L64K9y1a1J7hGRg8i0g2YRxgov9LlUxtnvb3N2Kj+gKD/6/8bFMqVl1k
         q7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lKadDZkcrZY+mBoo+J3JnRJGkskmKs9cjQkiel3sGM=;
        b=U1fPGgwFuTvtMU+g2a/PwjyUhsKMM7xBwPJJ0fXUnD5u+8KfclT1VRTZO+ay3SXWAk
         iwJLmG1r8PylYWi1rjTZ2UJGG/nnKkm0+UDXGyh3xh14VeYN3RLTEw5xFCbxvr7YtCQh
         /h3izET1I6LNuz3NtmkZSJUMH6JDVZJ0WW1G/YfOUKYcBwlBxFyKwSz3l7dtHrVCBwNj
         07g1Hc6R1PNlTwvGUMiDNIYik0jD132PIAVcQqNzewpzdDdkYuynS3jRoMaYdcU6dYjk
         plcA9Y7hURKwEBLid/08YQ5jPJ5GaEJ3J1gubW0DSPmXg9KOhpAjb84JnTNCdEqV5kyU
         T+iQ==
X-Gm-Message-State: ACrzQf1qJd0rGjXG5PwFujB46OjQ8zWooo688l962p+49JL6IP9PMZBR
        MylJ848Pqx86rrJPSyPwuJg=
X-Google-Smtp-Source: AMsMyM6qQ9vzT88EZhBSFHbtnUIKUFmgv4qNmKjKYLynpGSqlr9JNStxjgy11rhMPt60rEuY7ntW0Q==
X-Received: by 2002:a05:6512:2983:b0:4a0:5745:f7ca with SMTP id du3-20020a056512298300b004a05745f7camr6196994lfb.116.1667227439363;
        Mon, 31 Oct 2022 07:43:59 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25f07000000b004a050ddc4ecsm1303457lfq.125.2022.10.31.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:43:59 -0700 (PDT)
Date:   Mon, 31 Oct 2022 14:43:58 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] staging: vt6655: change variable name wTimeStampOff
Message-ID: <Y1/fLjJmma28LudO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux coding style does not allow CamelCase variable naming.

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1e5036121665..9bdcf2337235 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -54,7 +54,7 @@
  */
 #define CRITICAL_PACKET_LEN      256
 
-static const unsigned short wTimeStampOff[2][MAX_RATE] = {
+static const unsigned short time_stamp_off[2][MAX_RATE] = {
 	{384, 288, 226, 209, 54, 43, 37, 31, 28, 25, 24, 23}, /* Long Preamble */
 	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23}, /* Short Preamble */
 };
@@ -130,7 +130,7 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 
 static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 {
-	return cpu_to_le16(wTimeStampOff[priv->preamble_type % 2]
+	return cpu_to_le16(time_stamp_off[priv->preamble_type % 2]
 							[rate % MAX_RATE]);
 }
 
-- 
2.34.1

