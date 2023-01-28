Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6774E67FA14
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjA1Rsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjA1Rsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:48:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364492685C;
        Sat, 28 Jan 2023 09:48:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so7579402pjb.2;
        Sat, 28 Jan 2023 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1a0nON81Vqi2t30WHic39B+aumBPspp0d/jfvNL9dc=;
        b=MGBqkepfVKOtAlZtIokn9KSI0NGw08OeO+5UxM8+KBwiovyVuRBY/k9KOH3cyA8m/B
         2yl6Au0l/ROzQdzOv5y9MLx65O5rK1sXgdxoMJdVphTnDqe4VOcIUkq2Ht81oki8HZeO
         spy2YpigeKEil3qygmUccvPdh44xoVBHEbjZxSpNbIpOdvf1E6EQ6UxzGAUBlEIlS3go
         SkZ3eudKQFmhmrGNGUOwpxs2JOsBbsD6vZw03Rs4KQttl+3pooheMJuTRMGg/khKfS3R
         kjBV0cD8ToB1uLIaPIoLcAf99NH2iKyM9zzDHKcsycEkINYWsZA+NLtzlC5FlEOzRM0p
         pGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1a0nON81Vqi2t30WHic39B+aumBPspp0d/jfvNL9dc=;
        b=MLrqu8d+5InyLLJCgGRUvvEe7behxN+Zgp/gjW5/MDy6iHrfKlWT6v4PE0+UHxrqKJ
         DsPvBln8lkACWtf/ayK1M1rqBcyrO/NrFB+x/xIz6+B5T/B2UNE+QcA3o2EbaVg5HAEC
         CyRh7DuKtjt7gUVHTtelNuNZ245r7OndcqNpns0x1lgTNKbeibRXeHLAenmHc0uBN5Do
         zAd9y4yazI0Z8sigjL2uV4UkO2eDrbjpzIJMV4fIhRHfI5MBJ1jKR0gd3gvO8t4m4iBg
         pksUTjuye9dVGMRJTArgiD+k1RixmsrAHx9qZkcPkUV66ahUsM7H57qtnok4m/bnC+Vj
         S5eQ==
X-Gm-Message-State: AO0yUKV8mbnkNYb3fVVlwInnJl3aldsejhGZOSR8/2ZTwUnDjd80NPQe
        ejjM+BkV/9dWJZSOZfDVlVU=
X-Google-Smtp-Source: AK7set9pbXN/gSvxI1jitERaEWEHF9Q+7R3Ax5jOF81xVOFRXNa8vjo7CsVNsyKHxCiZFjzOJNXzQw==
X-Received: by 2002:a17:90b:4a4a:b0:22c:7ea2:8a36 with SMTP id lb10-20020a17090b4a4a00b0022c7ea28a36mr1064003pjb.44.1674928104461;
        Sat, 28 Jan 2023 09:48:24 -0800 (PST)
Received: from yoga ([2400:1f00:13:5a92:26fc:538b:9071:69e8])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a498e00b00229ff1fd7e0sm6933895pjh.14.2023.01.28.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 09:48:24 -0800 (PST)
Date:   Sat, 28 Jan 2023 23:18:17 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        anupnewsmail@gmail.com
Subject: [PATCH] iio: adc: Fix indentation error by adding extra spaces
Message-ID: <Y9Vf4Tp8JKvy+y0u@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added extra spaces before statements to fix
following indentation warnings reported by checkpatch.pl.

WARNING: Statements should start on a tabstop
+           return 0;

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/iio/adc/ad7291.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index e9129dac762f..fa5807ebe6d2 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -179,7 +179,7 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
 		offset = AD7291_VOLTAGE_OFFSET;
 		break;
 	default:
-	    return 0;
+		return 0;
 	}
 
 	switch (info) {
-- 
2.34.1

