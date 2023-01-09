Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A6663168
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjAIUYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjAIUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:24:28 -0500
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 12:24:24 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE6E3A;
        Mon,  9 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673295862; bh=OQa6MVATnom40EiZAoiknanw3c0hK9XWFEEbAcwYCZ4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=c6a3JbeL5mFoQSEMGZmxQii7p+K/dfXytNZJg0uSuvfOrjSBu+Oaj1SaVUNYot+5+
         A89ZCYdBlADM7WzF2TBziP+7NAFFjbLVeWXelZD8L4eAfXkboMvM06J+TZU0VoGyRA
         oxCpLrKraBnZFFLHAL0V2aG/R/djcTOT5Yua9ZjX6UeLLem1diadA3inUC3mywujOE
         7Pnza0mNHvMy4OGz2mvkr0tySmvIqnwVFc8VAPaqGR+E95k6aAB2fwwt6Dyvc9ASSa
         J3Id2udIvWYbPX4Z80/QAWTzmJmRw4y4/8IYQCeQ4vHvvtWffX9AD0NOLbtPPTwANL
         kv76yGbrssr9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from artix.fritz.box ([88.72.104.165]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1pFWZh16Wo-000qjM; Mon, 09
 Jan 2023 21:19:11 +0100
From:   Lizzy Fleckenstein <eliasfleckenstein@web.de>
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, ndesaulniers@google.com,
        masahiroy@kernel.org
Cc:     Lizzy Fleckenstein <eliasfleckenstein@web.de>
Subject: [PATCH] kconfig: fix typo (usafe -> unsafe)
Date:   Mon,  9 Jan 2023 21:18:37 +0100
Message-Id: <20230109201837.23873-1-eliasfleckenstein@web.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aF+26sjVlVUZ8XhiCRy+CXUFd65Itd5PmHE7l1v0s6WIAghh2vl
 H4vppew4ZPG1Bz3Pt3ZUGgCsfgcxvHcBR/kJEIO5J5Z1kjRsw9+CawSdG7qGTOdRGOhMOzr
 xKhQ0F0KahjQLotDGuyd9x1MmrrCdzAzuWqaNPQn53rRnVYhDi61OcFN1NXD7QANZkXiZsC
 uj9SsBW6Y4tppatc8kKmw==
UI-OutboundReport: notjunk:1;M01:P0:RPCqNCnWrrU=;y58UeZdA7KxozXY1hSgDt4Lcu9w
 wAeZ7pZC2kUPsAGb6qljCgJlWrdPCW/Gn/Ic6djBwe8rOcL4o6zaHiDJrILmFQ8fYNogFGdFo
 V8F4lShdlobbkfY83hBkOvPrl4Ykg17oL4FVXh+teqE1jbi+serHW3MkBA+K5xCfuOtejzjRn
 qlj5BNRtnm+tLnVuULKc2oNOlz7WVA1fU5E0Q95HHnAh1U9KmTW0Z0K6waffQnlo7iOv/iJDU
 AStWb5Hc38R3Z3D9wrWIGJcmDVy0ZRAyZ77XkLWr67hu0EbH5HI0gYCr0AYixxrYPfxq7qh3t
 4yBcabrXTvX+4FnrvzvSTHirZ/BPS0/xOGFNz4zFc4KJCyz2murFLS2liIhwz193uVyMqtRFt
 HwNkVCzrcubRACQFe+FMzUVskvdtgOYGXTKD7u5gq2WK6aCyXoV9seba+wHqy6RyXqCgF5lyt
 ZQnybW3nbmWbfGD2DWBGtReDVyIwDeF+2s/U/P/GwoKqBtKve4RSi2y8pY8Oxel6IC1ovJtr4
 uzwOXipcq9G6sbW8GhW5O3UrRVVCwkfDk87vuV9RVzTI2xP29HA2qPaM5jrnIe79pw0vgwuVj
 p46TIqSKV0nzAyBE5u7RJzASTA5eNulO66UNICBahoJ5kqgdv/jTJoRtK261LQdy2GwoL8aB3
 IzgQpG7qCb9OZQn+XTZ53C705uW4nW18fTeiZMb8yX2MAwhaHbbGNMJz6qF46XJXJ7fr7gW2v
 2w+JNVZlpjmZLJxBYRYA+S3Qq0UxWTQe7xMB5wetCVCDdWgUjxGEse+zMIWPBwQGo0+g2kj08
 lBi7h409Gi3N+DYCV5Np+Cv3x6VX4amw+14TmNwE+i93yWk2JkdZtW0aqnRr7a3rmXCdzWVTa
 JYD7OLFJJ3J9hlsdWk1+ttQwf1VfuX7UBWc0vO3APyBbnnXuuEkqxgsbBRHkCU4Pfc+1EXzx+
 xwYhbgEHhqae5G+Uv8twMKv43NE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the help text for the PRINTK_SAFE_LOG_BUF_SHIFT setting.

Signed-off-by: Lizzy Fleckenstein <eliasfleckenstein@web.de>
=2D--
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 7e5c3ddc341d..57c8d224ea4c 100644
=2D-- a/init/Kconfig
+++ b/init/Kconfig
@@ -776,7 +776,7 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
 	depends on PRINTK
 	help
 	  Select the size of an alternate printk per-CPU buffer where messages
-	  printed from usafe contexts are temporary stored. One example would
+	  printed from unsafe contexts are temporary stored. One example would
 	  be NMI messages, another one - printk recursion. The messages are
 	  copied to the main log buffer in a safe context to avoid a deadlock.
 	  The value defines the size as a power of 2.
=2D-
2.39.0

