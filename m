Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4846EE186
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjDYMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjDYMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:01:07 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCD11F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682424054; bh=OeX6bTfHS7YjQJvgjacvyKTm+MYbGdePsyXS8b55GiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W/uMToHjoWTq+S8KWLpcDVmXxpUx8OZPGjoa2bM74Pr+wC2wluvOQYxt8jEJNHhrL
         N3oNgYvQjEK3iUlshYeApl1+tLJQsRITGNGDLI3Mo4+mpPYBRu3cQfNcRER+UcSfId
         f8PfHXwkvp7SAKgnQLWOHffHLGV36RMBTC0ZV4gc=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 1235043; Tue, 25 Apr 2023 20:00:18 +0800
X-QQ-mid: xmsmtpt1682424051t5lzrfxv1
Message-ID: <tencent_221A82C2DAF38E66B85B313221958DDD7C08@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UEZnYL96Eax0p2AeaZ3/jEZXdfEMMeE5rXdCWf6VQn3cYPuSB6ss
         X0lh3+ZWgYoAaOmfq6z35ehtSg1AcI06qR/UdFtYoM2yM3fupgPW2DuFVF56tsVCdaBIN8g3oSb9
         bY7FfIiht2N4/eTzf3ekprzp4iz87Va9l/jcKOsTpJAvbNK8gcw0n+3wVZLYxbLoYHOBpoCwQUc3
         MT8j3BWTCSYINrjcbgSxQjEfD1rb8mhS8986pRzfCAOCakgKtYxJSxaSIwYGjrxNS7MpV5jbvEID
         bUWU1EIcwEQPApOH2eUmFdMIl7ywAcrUuQqfcTT9XdRx3DgEzhtM9sDLSjhAHIRw2sJkloSJlh8U
         d/5V0nz5DsUnuAhpmC6aiKTD1xitYR6sqJD3Y/dABeIhO3t2BNgc+wBN0huOcbp7zZEG0m/Lwc/4
         oXriEDT583dCdUuo9pGjlr/5XB8aQSRAbhs1KR632H2ncLrYniMU1LTierxSPERUsS6FkUepru1V
         vczAoJTpPzJma+jpR24SVrX1vkdOyyBZ4ugkEKRO3o2XSg6ex3/hQW37bs3brFf17YaVA/5SnauL
         wWYJZdLkRTfi5olnHFN/RoAM17od7FjiXSwdmp8sFASBls2zEXCWBUkYkPVx3MgwJGSW20wQU2+y
         lVWKuG7PcaYF+3S+zl2G7mKZ4+9kjuungsTHx3y3MohtYI+WmzOY0ZcCuoNZgf2E0To+Jnhzjn6Y
         3mWhcI8nqy2+YwoJeKr7Yz1OyNhhHjMOr6vLXXbEoDPSC+ojhfiYXqe/j6k8yqt991ZuqAqhzVPQ
         fI63xH5+yDJ/MGGNa/sce4LmPxxrcRaAe3G4HBIF72qR1sXlSDsRczFvDYe7F6zj7GtjnkEsuFIb
         vkpxEytNWn8MwTrxAh1eGbcATcZHBK+E/idnXb43USYKszCgfZEhRD/PztDvoIRIJ8zWM2ynlpCS
         TznHsw40zXoDs76u2W4nlRMUG12C2xEZCsobqKtaIXnyRisWa2ou0/uQsgh6LWMw800RjBRKrjda
         V89zuGy3Wer0h+/jY2JEJv+zKv+vJVheO+/NnSf3sjNThlW4iUJI28JYjKtRqKg7g9ZrIcmg==
From:   Yangyu Chen <cyy@cyyself.name>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>, Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 2/2] docs: dt: allow case-insensitive RISC-V ISA string
Date:   Tue, 25 Apr 2023 20:00:16 +0800
X-OQ-MSGID: <20230425120016.187010-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425120016.187010-1-cyy@cyyself.name>
References: <20230425120016.187010-1-cyy@cyyself.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After allowing case-insensitive ISA string parsing in the kernel code,
the docs should be updated.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 001931d526ec..70afd1e8638b 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -79,11 +79,10 @@ properties:
       User-Level ISA document, available from
       https://riscv.org/specifications/
 
-      While the isa strings in ISA specification are case
-      insensitive, letters in the riscv,isa string must be all
-      lowercase to simplify parsing.
+      According to RISC-V ISA specification, the isa strings are
+      case insensitive.
     $ref: "/schemas/types.yaml#/definitions/string"
-    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
+    pattern: (?i)^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.40.0

