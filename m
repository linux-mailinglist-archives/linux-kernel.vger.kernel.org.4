Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9A612343
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ2NR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJ2NRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:17:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E96D553;
        Sat, 29 Oct 2022 06:17:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p21so3253016plr.7;
        Sat, 29 Oct 2022 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa2vaDs0sctiUqzfxVGectMJZGVrT1qw4Z5WdhU1TTI=;
        b=dmhCUyhr1AXbtT9VNPWTRZLWpYj4iVvRw8BldQdFZ0lDzRh5RPCL8KBkdkSIMHKR5o
         jBFV5wABHqgAkb7BoxFaj6SoBubbncTcPrjnI+LCnYpWEvm+XAJZUv9vbAooq73AWVzj
         bDmNK4TDjvla3CU0CqWjVm8OsvbAhNw5Xv9yJv5h5p3QgP9WAqxrn4LUXqRDltCuVsFu
         eZugXntF+UU1SJwV58rr9MbNwNKkk1pO2U6DHO4Gs1rdQv2zOuleUY6O8en6wG4Z5r0z
         TOZ23IwqtKe8tNSvPFGSkQ78gLS9AsUHVwFTlHu+E7Nymi8yhalt5/v9tdxzgLspyCLL
         M+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa2vaDs0sctiUqzfxVGectMJZGVrT1qw4Z5WdhU1TTI=;
        b=VwCp+nGMmvZavcy8LMyBIDA2p76Hsl9yBTPeOdkX3H6xhbjJjY2L4MPQEy3e0NBkfo
         fOAKskS25jlpkMzm+bgD5iP4rk1vKjr1cgo55UTouyh1Wj2xqVhnbbb0Idl+d3PA9jCj
         SukgfyG6yko1/oumGO7VlFjAUaN748v7dkeXlhXDJA6vkzHXZqobkZ9G+chp3F5hAuA4
         Dch/hbPp+4dsYCqCc8oHMc99MzwNQmCxvdyyVwG2GCIRoDnp/HD4NIQmQJ4+5whWKsfX
         4T78ENlI98bB4jnrC8cGdO4/W6ErSyJ03D+yA/q20+6EJFbqbAiJIqpsjrhzXEwB2QdO
         Ei8w==
X-Gm-Message-State: ACrzQf3w1HWXCeddOBBVpub3oo3ZrWkBdk2IWFo+9SUXKNKoVC4dRZi9
        lGS9G3HHkr5hXpnqL8GntxcnhHFcR98zpg2J
X-Google-Smtp-Source: AMsMyM6wFC3IuSWfU6wMwP5768g8JCiQN6JkJwu2yEaaBq6jylaDJz18zHL8DohsFx0+cubrvtB0hA==
X-Received: by 2002:a17:902:a584:b0:186:6040:87f9 with SMTP id az4-20020a170902a58400b00186604087f9mr4436051plb.36.1667049467295;
        Sat, 29 Oct 2022 06:17:47 -0700 (PDT)
Received: from debian.. (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b005622f99579esm1187439pfh.160.2022.10.29.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 06:17:47 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Laura Abbott <laura@labbott.name>
Subject: [PATCH 2/2] MAINTAINERS: drop Liam Mark and Laura Abbott
Date:   Sat, 29 Oct 2022 20:17:34 +0700
Message-Id: <20221029131734.616829-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221029131734.616829-1-bagasdotme@gmail.com>
References: <20221029131734.616829-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=bagasdotme@gmail.com; h=from:subject; bh=3YA4rB9qga7V3JgGk+EtiHhHSnGeaiPpwThJXG+h3vU=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmx6u8kdpda/WjyszjOZibtFPCGR7w+eHvmX8sr614ruOif FMnoKGVhEONgkBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwERETzD8M31wTsfH4c2tq4ybT8r92P Zi8tUlJteiur+J9m6XTLaOD2Vk+Pw95cs1V7vAIPO7AQw3HtTuLlWyCbPfvkPc/+WngkeXuAE=
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

Emails sent to their respective addresses listed bounces (550 error).
Their last post on LKML was two years ago ([1] and [2]). Remove them.

Link: https://lore.kernel.org/lkml/alpine.DEB.2.10.2002201508320.1846@lmark-linux.qualcomm.com/ ([1])
Link: https://lore.kernel.org/lkml/b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com/ ([2])
Cc: Laura Abbott <laura@labbott.name>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Actually Laura's last post was a year ago from her personal address,
 where she announced 2021 LF TAB results [3], so Cc that address.

 [3]: https://lore.kernel.org/lkml/6e307861-3149-a984-cc79-088559caeab2@labbott.name/
 
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63a84d3218a7b4..564c3c66077e0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6221,8 +6221,6 @@ F:	tools/testing/selftests/dma/
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-R:	Liam Mark <lmark@codeaurora.org>
-R:	Laura Abbott <labbott@redhat.com>
 R:	Brian Starkey <Brian.Starkey@arm.com>
 R:	John Stultz <jstultz@google.com>
 L:	linux-media@vger.kernel.org
-- 
An old man doll... just what I always wanted! - Clara

