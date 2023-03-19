Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA76C0025
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCSIqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCSIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:46:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EEF35A7;
        Sun, 19 Mar 2023 01:46:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id fd25so5320682pfb.1;
        Sun, 19 Mar 2023 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679215571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5o6ymqe954+ceahx9omRlmLXZU+j0iSO1O5txu/jm1w=;
        b=UiTt3XPbVNE9dtJ2kIShcbgPRkcifVYqGGhxGzxMSpBwa4wgxtdu0TBGlDXUtcXUDW
         0cqfK+3fTiuuuCgcZqpudV5lBGZDkQlHpKrjCGyA2kxFKm+oNaozT9X1cdqSLWaIiHhy
         cwqMFSIcLiWR7R9l15EPL5M6ig3zh3f6I1exd37FLlBEln5/7R2802V7e72dVB74wdOC
         /PDe8bSnDnOiQtdWi2CCZv5PNnoGVuJcu2LFSmFmRsQ6Pq9E+/k6ezOaJRFV7HmX1Ch9
         9CrM5absCJ4zCZ6Gxh9wjyWbdbaEcvvloRbq/03Bg4nWHMYWBS7SeEU0lAw2NRh66n73
         W8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679215571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5o6ymqe954+ceahx9omRlmLXZU+j0iSO1O5txu/jm1w=;
        b=AqzeS9DNdSR8H5u/mebofxqAALwy88GRfTnlj92x00ENk5rCwssl3SRzGEGA1SU9b2
         KVuC0IyIWpWz19l6KzUTAI4fDcvgckgfzapRPaWpYZCXW6Z40lAEyFmfXLpxNd3vXYxR
         XITQpVPc03yWmu1swy0TDpaLLIqvHrZaq+phgGFfwZk+UhQFLPr/XZvo1dtiRaob8M3c
         DH/cpjiiIXYPSPDbxRhcYIu642OXQ8bMh/AZR4mU1nE9yNHsnaS6sPvu3qMpccm3O3Ij
         G6PyXZDlUalFULsJEKiJWZHyAUAtuMLhxxJN7myaE00Iu+fhQ8VPkRjxnqKM9s/Wd3wy
         w3KQ==
X-Gm-Message-State: AO0yUKVBTr+q+mvbiCkJznOuWN5F7Hrl+blGYSLyqO0kABBma8OSiklZ
        UIV1etq+fo0pgjuyOb4W+SY=
X-Google-Smtp-Source: AK7set/cVmDfhFl8yui+LNoY/s7ZNk9VbFPRmk0FRG0zWDtT7ivNm03773bU8tdRYJtnKuAH4TjfAg==
X-Received: by 2002:aa7:9804:0:b0:627:e42f:b76d with SMTP id e4-20020aa79804000000b00627e42fb76dmr3654543pfl.12.1679215571202;
        Sun, 19 Mar 2023 01:46:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00627f2f23624sm512643pfi.159.2023.03.19.01.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 01:46:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 62DB6106574; Sun, 19 Mar 2023 15:46:07 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux LEDs <linux-leds@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] MAINTAINERS: Add entry for LED devices documentation
Date:   Sun, 19 Mar 2023 15:46:04 +0700
Message-Id: <20230319084604.19749-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=bagasdotme@gmail.com; h=from:subject; bh=TSOdQAypRtKbV1Yt9eZY3fOYgd810K9XXcusnAgBdUg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDClip48fit4hq6F8eZGbRv3y8s0Lf8jzTvqxT2rvhp321 z988p95p6OUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQATSZjK8N+t+J+019Q21u07 Nl25cX998gaBDpaoi8UyalcVD+a/nWHHyPAkKTorvmjr7OZ3N860OC1S2zLrkKzuFabfyt8VC1Q O/GYHAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When given patches that only touch documentation directory for LED
devices (Documentation/leds/), get_maintainer doesn't list mailing list
for LED subsystem. However, the patch should be seen on that list in order
to be applied.

Add the entry for Documentation/leds/.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f3053b..8cc35a2e24e515 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11648,6 +11648,7 @@ L:	linux-leds@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
 F:	Documentation/devicetree/bindings/leds/
+F:	Documentation/leds/
 F:	drivers/leds/
 F:	include/dt-bindings/leds/
 F:	include/linux/leds.h

base-commit: 4ba9df04b7ac66d2d000ed7ae2d8136302d99a57
-- 
An old man doll... just what I always wanted! - Clara

