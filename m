Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA1614748
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKAJzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:55:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2713F79
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:55:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b8so20183435ljf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zpGDf3BIPVG3Rl6WILp7Vb55DMORDglMgQCuvktOS0=;
        b=nWR/ZwN3abb0naQDgrTsC+vN7RTPjNOzHE7eCCW9DdKrxp75h49anfuAkdfWABY5yM
         G9DaADKc+AB2O9H8SwgVhssz496jFhlWMxc2o4/1R3C+TIPL4uOwNyUIEpCfPQSrRqVO
         HmJzVjR7W5sfw2nuRk160BKqJLzOzW1Dm/5Asw7owWSvRox+wlYB51GGBYCqcODTUYpy
         xLic1jrmz0qc+ew8wGRqnY6MR+0YSzrbdVxtFSUsYyqZekdRjzDVdTbboEFhZFdXLBSh
         4L9bOqOX0hH2Cgb5QnQIU/d9n+rOPBwar9BnkCMQspXhwXQDCJorJLwoHUzIM/sFJODD
         9k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zpGDf3BIPVG3Rl6WILp7Vb55DMORDglMgQCuvktOS0=;
        b=M3dy+WLnh77tIX4p04oLKr6Qjypnf+lxT0WYuL4y8maaBZIaXGkkhHulFx/C9N4VIH
         p38gVkVHfp4sCAFTRFmJ/TBi573blHCOE2dNDoUZcy7VDl2ZbfpvStXfUHO9Ex5ONbJo
         CWrvrHNpL/MPZ1jlFJXXOCwyyWJiOo1yhypatjm1DumbIhnchqWW79aCUoqQGzWcdFi1
         yA/meXj9gCFuceHzcwO92Pr0+G/o3cpWLOsYjV8FBT5GrS2nilqQb2A1qM0ZTVfCTWFf
         vETlPUWzbEs4Rq5x/l51EoEeIMdjn6+D9DU8wk+Py3Sm8EKRlERlmnDI5XF/0fAX/vtB
         koXA==
X-Gm-Message-State: ACrzQf0wIjPQUL/6IgGhf7qI4XBz7/+ceZt1b8fvFOGJ0Ofev6stm/mx
        NfJPe2K6RYLzvb9fM3HbAOFfwNOCBrRDkQ==
X-Google-Smtp-Source: AMsMyM5VSDHV/jZFK4Rr+lLcsW3eV5esqktXlgZ4+yc2YMjV+ZJjF+dUDOGzg+bZeFZoxyfI4PscNg==
X-Received: by 2002:a05:651c:b9f:b0:276:762b:3499 with SMTP id bg31-20020a05651c0b9f00b00276762b3499mr616139ljb.444.1667296535904;
        Tue, 01 Nov 2022 02:55:35 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b004a03d5c2140sm1619630lfr.136.2022.11.01.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 02:55:35 -0700 (PDT)
Date:   Tue, 1 Nov 2022 09:55:33 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [RESEND PATCH v3] staging: vt6655: change variable name wTimeStampOff
Message-ID: <Y2DtFRdhCiyNF2kF@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

Remove the use of Hungarian notation, which is not used in the Linux
kernel.

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
v3: changed confusing patch changelog

v2: modified confusing patch changelog

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

