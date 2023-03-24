Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117096C7C41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjCXKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCXKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:11:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03726C2F;
        Fri, 24 Mar 2023 03:11:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so5821824edc.3;
        Fri, 24 Mar 2023 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679652660;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evdlK2TGBDUZwBoMd27PncFntPqf8dN29Q/MhkQ6Vbw=;
        b=dznHZO7lkSFUK+s8WndyI4DcgrTjLCpfT275eZ9bhSwMycl8lbNnKvNh9mLJk9Yk/c
         cUdP6wFYQJzpe9lFAWcn7NpZD9VUsF5AAWkkX9CpeTk9qQ8Jb+ujNW9Y5XeR18PGbJdI
         wogjwWk8T7mSjyiFZXuS3iP8i/3d74PAFRbUhxt5oBG8Qy5xMfd2e7N4RX12NvYhb4Wx
         q0gqGXBKo8JyInrtcryQ/yt2sCgb8qepY+8OSX6R3BQlTi7hSE0yu1u+c558mj4gBfDR
         I6lK8LeiT38pLnzTemwlcqzrQ6uziBwV9DnnwuJ2rloSB94rW6iX/9F7do4fDeCFvqoV
         xkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652660;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evdlK2TGBDUZwBoMd27PncFntPqf8dN29Q/MhkQ6Vbw=;
        b=L8yQFQtkNP7JK3jeR3zSWkNRiLajpz92n57uzgb3lDm0/7KgK61Bc29xIt1LplanyQ
         YXjhKTpUP/DFF23NNtM/oAZu9ud7VZpSzzwJgpcZcePdtpnXsOfPJHHjpBQEJei8QAGL
         lUmXXoUmIJPN3vlHLajc+MtxK5XSCaHPmR9BEAfiKXmr/Ap5EMr+k4CIsWwOT5joUz+Q
         rhWaLZ4tPqepRAV+tFbJbVemsZiu+71IL+HBcvXHeXN/IvOfvegztPn/Z1eahAEh+i0D
         U7vcC6jQytPaVUvLmcs+u30w4pUrHCc8rJ1gYp7aCtexj4bf0DA6vR1R9qSFyYxy3R3t
         PbrQ==
X-Gm-Message-State: AAQBX9e4NnqmaM8iWt2Mtf5SFSsWN9o6/uQky/nS6TLZXRJZDnMG7zUh
        wJJX5S/+e/Uuo9Wnz56+Sn4=
X-Google-Smtp-Source: AKy350bSSu9MVW+4h7wFp+T2skX/v4XOI6/R0Pczs/23rI98NSiFTL7j4g1U1znI9HPwZfhgyOK5GA==
X-Received: by 2002:aa7:d7d3:0:b0:501:d542:4d0c with SMTP id e19-20020aa7d7d3000000b00501d5424d0cmr2432392eds.22.1679652660688;
        Fri, 24 Mar 2023 03:11:00 -0700 (PDT)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id u20-20020a50c054000000b004aeeb476c5bsm10351126edd.24.2023.03.24.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:11:00 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mips: Remove obsolete configs IRQ_MSP_CIC and IRQ_MSP_SLP
Date:   Fri, 24 Mar 2023 11:08:48 +0100
Message-Id: <20230324100848.13127-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1b00767fd8e1 ("MIPS: Remove PMC MSP71xx platform") removes all uses
of the config IRQ_MSP_CIC and IRQ_MSP_SLP.

Remove these two obsolete configs IRQ_MSP_CIC and IRQ_MSP_SLP.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f1dfc2fe2acb..26d254d125b6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1179,12 +1179,6 @@ config SYS_SUPPORTS_LITTLE_ENDIAN
 config MIPS_HUGE_TLB_SUPPORT
 	def_bool HUGETLB_PAGE || TRANSPARENT_HUGEPAGE
 
-config IRQ_MSP_SLP
-	bool
-
-config IRQ_MSP_CIC
-	bool
-
 config IRQ_TXX9
 	bool
 
-- 
2.17.1

