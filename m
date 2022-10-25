Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3213F60D237
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJYRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJYRGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:06:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EABB7FFAB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso12420137pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dikvD5+bFGXRs81xXMLBNykCJfKHBwW8mLASTTcU7RI=;
        b=CP3R2VhtIikUhX0CQe63EEcuRzJ05+zBsyTaRfWVdRBk7wtsCdIuihqashVO2NtBz/
         N3a0L8frBYFIVcNbhdAEaQQOQwMJGJREBXiGzBijaWfti6fgC+l/nIbknU4I6PAyio/f
         95uR6K0cVqO4SgDrwkG83t8D8YFRI8qhfr1LuwB7M6RdlR7tWee1Y1OTn2aWEEmZNZ30
         ArIdMgygY7iCcK8h8eecjlO1UgUFTS3C5yA9G8mVzGgw0nFVJQ36qzvXPQ8yKaBKq8yC
         eotE1K4MTp2NIC58s+dhNagJz/I3aQ0nrUCStYVMTqmbug33r7NS9JU6MZCLVI6TWpqB
         HMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dikvD5+bFGXRs81xXMLBNykCJfKHBwW8mLASTTcU7RI=;
        b=e5gXsbbhr94DNcZn6cmbquObGVxGioHTkiw9xDyddCxJccBqchSwWu8GmhdIYnR6uc
         1skqHdIQwhwOanS42D76aadKNQNsKJRRt5p1AuOgwS7Y94Qa1BWvmxr7LhQJBCnAnSoH
         rQf35bpa1xsZSDpQVOmgvPekyZVVEpSmiOX66a7CBmbW7X0T0gS3lmoqR6qKngww9FKP
         mZDfFPbIUpsGU1TSLMLwAlCw5Di4mcHUBnfuTPjFMqA/xjs9lGGCGFQMfgNKl5McPWbp
         nED9X6eRb0VUPcqcCOxIadsEUpZda6aDTjdX1pOhhxO9fIVDG11A01sKA4BagwHYaR24
         X8jA==
X-Gm-Message-State: ACrzQf2cukMwQaFRt4oMTd60ab6+TJvh5/EfBJrCzGFU3g0nSPw6pJuF
        RcFrXhkB2FkohDFgisKo1HM=
X-Google-Smtp-Source: AMsMyM7azrtevbNSyQZJ1HE83lAAulbHxkECoTgmm2tQi0dVtAB36ixfYvUpgrenOok+o1TEJaCusQ==
X-Received: by 2002:a17:902:7296:b0:180:1330:b3c0 with SMTP id d22-20020a170902729600b001801330b3c0mr38689617pll.170.1666717592599;
        Tue, 25 Oct 2022 10:06:32 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b0056bcf0dd175sm1592373pfl.215.2022.10.25.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:06:32 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v3 1/4] staging: r8188eu: remove unnecessary variable in ioctl_linux
Date:   Wed, 26 Oct 2022 02:06:18 +0900
Message-Id: <20221025170621.271903-2-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025170621.271903-1-tegongkang@gmail.com>
References: <20221025170621.271903-1-tegongkang@gmail.com>
MIME-Version: 1.0
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

Returning value 0 directly instead of storing it in variable ret.
This commit can prevent cocci warning as follows:

  Unneeded variable: "ret". Return "0" on line 3030

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 2de2e1e32738..5e1ad7733127 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2979,8 +2979,6 @@ static int rtw_p2p_set(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3027,7 +3025,7 @@ static int rtw_p2p_set(struct net_device *dev,
 		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get2(struct net_device *dev,
-- 
2.34.1

