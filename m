Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3485FE462
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJMVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJMVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20A16F40D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h13so3136224pfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=/ti7X8S/hEwtsnoygBrgb78QVJUyVa/mQySXfqFhhvk=;
        b=ohXoxiTeLtrgX3lqZFRgkoJ3qO6DutaAXMOW98Z9wi+uzTu/LypBAnrvjilsBqDDGp
         64T2rn3Gyc4B19uU9Geq1mkItyzJq2WYu7LcXeGzF8pP5x+EydXmZjk4PL02jkjgl8zp
         QR0gdtS9j4b3X1fFXk52Cec214DNQSDuFFRt+1u/i9mtcl50/rH7XVmyUVrsw1YWkyjJ
         1ygZKatvdgKz6405zF6oGtKcR59fC7aXBcrTVHofTTTVt1sL45n6jNJ0l5Ii6PvTVJOm
         acQG0nN6yIuMDDEgIWh5CZuIth7+8CtMWhczEEVf/8kXzMVkVTqnS8GJLpN3E3Hp8p5X
         NxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ti7X8S/hEwtsnoygBrgb78QVJUyVa/mQySXfqFhhvk=;
        b=ShdiP7/DWZ4lyKTLZBmBOBwgTGU7/FR/9AcBQcwcHaeYRfnbCNnSrtlu4rkEynGbHZ
         gSjUsUnHD9rxUS38XJoVO7vMk7mtKhQ2rx32ENdtCd4r764e3RiHkNQ65v445D16Od/A
         tiwaSLyTLzuctrJcYlwjf6gECX4AN6es9EpNl14oTECgpLGapoG1V4VvGh3FzeEWejN0
         2Pgs1QZa1X9lkT0LjYvyCxVtHCOlJDTjLV/qsWwOkU1/xv7JhN8/ShpzN+hA2DE+98Qm
         4Hxdmt0ANNkFyHmbbB/1Mi1MxnCNkRF7lSje5ulHEnPosYOnBnnjX3dY5oPYr5zTgkiv
         LKtg==
X-Gm-Message-State: ACrzQf09iincZ62rvrvqMuK/zmPBMflK4saF/o0mNGvjsl4Bbph3+02b
        nWAnM8iXnBMKdsCNtiY8mpyQu5LPskJl4MaB
X-Google-Smtp-Source: AMsMyM5YF1mZxagvecX/KJyg+tVijgfzZ1Km4v2WGLaX2nQ1a5U5SyuJLlo1DD8kNBHddX4hZvc/yA==
X-Received: by 2002:a05:6a00:13a1:b0:563:4c5:c3dd with SMTP id t33-20020a056a0013a100b0056304c5c3ddmr1801947pfg.5.1665697739091;
        Thu, 13 Oct 2022 14:48:59 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c123-20020a624e81000000b005624e2e0508sm150008pfb.207.2022.10.13.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:48:58 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for srcres258
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30761-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     src.res@email.cn, linux-doc-tw-discuss@lists.sourceforge.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c71b452a84d..4f5e5c152d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20639,7 +20639,7 @@ M:	Hu Haowen <src.res@email.cn>
 L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/srcres258/linux-doc
-T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
+T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
 TTY LAYER
-- 
2.38.0

