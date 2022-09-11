Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27665B4CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIKI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIKI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:57:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBD2CE11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:57:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so5499803pjf.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=U0/z9cTCBldJsBFfOHIA0QsiOi8bEAfPOgF/weATjNo=;
        b=lGw6NKawDBGpFn45ZQCfL12zOM+Bm2Yh7sWieZmaRob3PmSiNlTy8SQ2IjdvH6PsKA
         Rqm3EAxH7h7WpZlHLlujZR9SVesuvWrqddmfcu7EmEoNUBfbFSZJaMdbLCTU4ZOYmBAM
         lTlew9fVpz7KiW3KoR2eukTGwRlVc67j4pxdmsHSvvXuCAlnjRiInCKlD/kC3PrgVVrU
         AC+OLiROL+xXq1h/GQy0vMYA2IEcGgrmf5VA6ExjNZWiTgEoz+3ome46yp5kDK2+OpaA
         F+wdmZO1aJE2HYR5hrUn09KgDPGE5WpvrYxMS5te7oynJOWlVM6xnLgyFvZ7WzxOllbP
         Xsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=U0/z9cTCBldJsBFfOHIA0QsiOi8bEAfPOgF/weATjNo=;
        b=gEor/A84uMFLsYnJIowjiEZ59hyt2noBLWIELKdhLmv9j1N4XZ+OTIeHSicx0DB7xc
         s5JdvkRkmasYzPOYXonB3W+5FW+h5rZMEXnx7yUOwcwNx0Ypt0ietxH7k0Xk1+2fuu0M
         hHgy41PMUzhr/hwAdVj4DIEkvOB37t+2MYQlzxAw77EM7/DQx0ru2pyF7AcnAIWZ8CKV
         saiIMyTld0Esvxa8+gc/XdXqf+oeQMOtfk8cN40gIS5IPaoFEaFvYmikf82BdGERwGgH
         N/Nbh8gMhjmqDzWqikS3b1/H9echQcLPd87bNbJQDzPkc570hZGpDLTMOsU7ilmebZD+
         cB9w==
X-Gm-Message-State: ACgBeo3SPxMQbiU5x2YPOCrxHKHN9Nl/Kne/ZMGA3TLzi3z5djLzb7aD
        3f5gHf69M2Wd/+iFYJ2wI8s=
X-Google-Smtp-Source: AA6agR5sOvU3fVxVPAfpqgZNbbw9dmGENKuzGykU5rT59rsetNh5fVOQ1K7FGbWOAm9ItOhxQReZAA==
X-Received: by 2002:a17:902:e750:b0:176:b0fb:9683 with SMTP id p16-20020a170902e75000b00176b0fb9683mr21875110plf.71.1662886670291;
        Sun, 11 Sep 2022 01:57:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c09a0ef87sm3247229plg.255.2022.09.11.01.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 01:57:48 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     nicolas.dichtel@6wind.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: [PATCH] ipv4: add documentation of sysctls of error_cost and error_burst
Date:   Sun, 11 Sep 2022 08:57:37 +0000
Message-Id: <20220911085737.14230-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The descriptions of error_cost and error_burst sysctls are missing.
So add the descriptions of them in the documentation ip-sysctl.rst.

Signed-off-by: xu xin (CGEL ZTE) <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang (CGEL ZTE) <zhang.yunkai@zte.com.cn>
---
 Documentation/networking/ip-sysctl.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index a759872a2883..14aaa4cd76c1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -156,6 +156,23 @@ route/max_size - INTEGER
 	From linux kernel 3.6 onwards, this is deprecated for ipv4
 	as route cache is no longer used.
 
+route/error_cost - INTEGER
+	The minimum time interval between two consecutive ICMP-DEST-
+	UNREACHABLE packets allowed sent to the same peer in the stable
+	period. Basically, The higher its value is, the lower the general
+	frequency of sending ICMP DEST-UNREACHABLE packets.
+
+	Default: HZ (one second)
+
+route/error_burst - INTEGER
+	Together with error_cost, it controls the max number of burstly
+	sent ICMP DEST-UNREACHABLE packets after a long calm time (no
+	sending ICMP DEST-UNREACHABLE). Basically, the higher the rate
+	of error_burst over error_cost is, the more allowed burstly sent
+	ICMP DEST-UNREACHABLE packets after a long calm time.
+
+	Default: 5 * HZ
+
 neigh/default/gc_thresh1 - INTEGER
 	Minimum number of entries to keep.  Garbage collector will not
 	purge entries if there are fewer than this number.
-- 
2.25.1

