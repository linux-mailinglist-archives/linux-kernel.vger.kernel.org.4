Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCB63D52E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiK3MDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiK3MCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:02:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F3E03B;
        Wed, 30 Nov 2022 04:02:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b21so16438093plc.9;
        Wed, 30 Nov 2022 04:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbQRhZcHBRg8tClZtaUUdbvW3akOb111t9pzRQ1r3hU=;
        b=V/qriuqxsXdTt/Oaw/rtWUNvDPHpIhlZdO0L2ZNl+0fhUl+NEvzHMrkIOYiUFUNTyR
         ubJIFTgeeK6tCD4zQCfd1C9G2oMYmDWbtW4RtSJatL9tXADkri7YI+9ECwKyOzYrYnTV
         Gaxu+4yVloQk+jzgx87g9A01o5tues8YSHUWNMOe/yM6pTMgD1gCTITYWSbdKYvMf+4E
         nGIe6CHq0+39bex4f3zsKzfzf/XXNwfyyWNxHyMTZrhLw9gpIkv1HK+cVQu4yi2yCbAa
         eqDV1ff7scmPqKkZWpmv9NE3+a2h364NArbbG/gekVCYx41MXRHjRcxj0wC9baqKGacZ
         8zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbQRhZcHBRg8tClZtaUUdbvW3akOb111t9pzRQ1r3hU=;
        b=iFbelqhqTqNrhJxLejCWUqF1jA3wAGcOV9vjK6vq7vQhr5Fhh15jmFsIj1gax039IM
         aTYxcrrX0fYT16i+rwCkI2+/x93XPSJwn1NFfkWk3mm/xGiKKc5otyHtFc6yevLK5SOE
         Tz+pD51D/gMma6DYEk55XKyZCdn9+pUvdyxTGXbfN5JsWNPXjZZToity2p3WIsDQHE+R
         rnD4pq33p/xo0G5MUlmCcCtX3WmDe9SmEpBPUNqtYro4bVd6+TMJcFi+6AV+AwLsUVz2
         WDZ4wBtfiDf4LMJE9BxgKZsVQw70cRVW+5lW5Ax+WBIqoP9Kzi7QdkEw8mzdAOPNtrNH
         vzQw==
X-Gm-Message-State: ANoB5plkM99tzg00dKD21qIUtzQSviV3hBOaflCLuqnMqHnNDYY1eMxh
        pQzvKIc+72qeEKkursLdN9E=
X-Google-Smtp-Source: AA0mqf7Su5yFdra3lIOU7plhbQJyW4GfT6Ov7dFcLnau6Pq6M5eEOcz1HIhRATUEz75vjfiithooAg==
X-Received: by 2002:a17:90b:2811:b0:213:971d:51b4 with SMTP id qb17-20020a17090b281100b00213971d51b4mr67210155pjb.180.1669809763585;
        Wed, 30 Nov 2022 04:02:43 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b00186acb14c4asm1301016plf.67.2022.11.30.04.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 04:02:43 -0800 (PST)
Message-ID: <d9ba832c-4851-f826-247f-b29b26369a74@gmail.com>
Date:   Wed, 30 Nov 2022 21:02:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Robert Schlabbach <robert_s@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Akira Yokosawa <akiyks@gmail.com>, linux-media@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] media: Add ignore patterns to frontend.h.rst.exceptions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6508a50fe84f ("media: dvb: add DVB-C2 and DVB-S2X parameter
values") failed to add ignore patterns to frontend.h.rst.exceptions.
This results in new warning msgs from "make htmldocs" as reported
by Stephen [1].

Fix the issue by adding needed patterns.

While at it, fix typos of "QAM-1024" and "QAM-4096" in frontend.h.

Fixes: 6508a50fe84f ("media: dvb: add DVB-C2 and DVB-S2X parameter values")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: [1] https://lore.kernel.org/r/20221128151900.5eb94a01@canb.auug.org.au/
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Robert Schlabbach <robert_s@gmx.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 .../media/frontend.h.rst.exceptions           | 28 +++++++++++++++++++
 include/uapi/linux/dvb/frontend.h             |  4 +--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/frontend.h.rst.exceptions b/Documentation/userspace-api/media/frontend.h.rst.exceptions
index 6283702c08c8..6f03c704d6ac 100644
--- a/Documentation/userspace-api/media/frontend.h.rst.exceptions
+++ b/Documentation/userspace-api/media/frontend.h.rst.exceptions
@@ -86,6 +86,13 @@ ignore symbol APSK_16
 ignore symbol APSK_32
 ignore symbol DQPSK
 ignore symbol QAM_4_NR
+ignore symbol QAM_1024
+ignore symbol QAM_4096
+ignore symbol APSK_8_L
+ignore symbol APSK_16_L
+ignore symbol APSK_32_L
+ignore symbol APSK_64
+ignore symbol APSK_64_L
 
 ignore symbol SEC_VOLTAGE_13
 ignore symbol SEC_VOLTAGE_18
@@ -119,6 +126,22 @@ ignore symbol FEC_AUTO
 ignore symbol FEC_3_5
 ignore symbol FEC_9_10
 ignore symbol FEC_2_5
+ignore symbol FEC_1_3
+ignore symbol FEC_1_4
+ignore symbol FEC_5_9
+ignore symbol FEC_7_9
+ignore symbol FEC_8_15
+ignore symbol FEC_11_15
+ignore symbol FEC_13_18
+ignore symbol FEC_9_20
+ignore symbol FEC_11_20
+ignore symbol FEC_23_36
+ignore symbol FEC_25_36
+ignore symbol FEC_13_45
+ignore symbol FEC_26_45
+ignore symbol FEC_28_45
+ignore symbol FEC_32_45
+ignore symbol FEC_77_90
 
 ignore symbol TRANSMISSION_MODE_AUTO
 ignore symbol TRANSMISSION_MODE_1K
@@ -143,6 +166,7 @@ ignore symbol GUARD_INTERVAL_19_256
 ignore symbol GUARD_INTERVAL_PN420
 ignore symbol GUARD_INTERVAL_PN595
 ignore symbol GUARD_INTERVAL_PN945
+ignore symbol GUARD_INTERVAL_1_64
 
 ignore symbol HIERARCHY_NONE
 ignore symbol HIERARCHY_AUTO
@@ -163,6 +187,9 @@ ignore symbol ROLLOFF_35
 ignore symbol ROLLOFF_20
 ignore symbol ROLLOFF_25
 ignore symbol ROLLOFF_AUTO
+ignore symbol ROLLOFF_15
+ignore symbol ROLLOFF_10
+ignore symbol ROLLOFF_5
 
 ignore symbol INVERSION_ON
 ignore symbol INVERSION_OFF
@@ -172,6 +199,7 @@ ignore symbol SYS_UNDEFINED
 ignore symbol SYS_DVBC_ANNEX_A
 ignore symbol SYS_DVBC_ANNEX_B
 ignore symbol SYS_DVBC_ANNEX_C
+ignore symbol SYS_DVBC2
 ignore symbol SYS_ISDBC
 ignore symbol SYS_DVBT
 ignore symbol SYS_DVBT2
diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
index 4fed9e316147..ab215d1c15d2 100644
--- a/include/uapi/linux/dvb/frontend.h
+++ b/include/uapi/linux/dvb/frontend.h
@@ -363,8 +363,8 @@ enum fe_code_rate {
  * @APSK_32:	32-APSK modulation
  * @DQPSK:	DQPSK modulation
  * @QAM_4_NR:	4-QAM-NR modulation
- * @QAM-1024:	1024-QAM modulation
- * @QAM-4096:	4096-QAM modulation
+ * @QAM_1024:	1024-QAM modulation
+ * @QAM_4096:	4096-QAM modulation
  * @APSK_8_L:	8APSK-L modulation
  * @APSK_16_L:	16APSK-L modulation
  * @APSK_32_L:	32APSK-L modulation

base-commit: 6a5a4514854a637d01c50f5ea17b28f78b31ddb8
-- 
2.25.1

