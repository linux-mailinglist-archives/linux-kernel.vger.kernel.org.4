Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04E6F3379
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjEAQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjEAQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:19:06 -0400
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE8E61
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682957939; bh=mXp6SRcjWPRCwi6nlesU+F55lVnmPqOB5ATTOwT5NWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DBCIDQTKb1NSQ+gn4QF6NCTPVAMO2feE0q4HALY9pFqRDJIAE7DGGf+Zjo/XpqTbd
         IvzRmrdP4BLylmwVpUGiDgliJkVPXa3s2a2wZr8EVF8swkSGBgn9xUJ5w5qwEsj3kx
         SAL1zig+AruKzY8TrdBi8ZpNI8Bn2iFJU3TiDlWo=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 4A78EECC; Tue, 02 May 2023 00:18:39 +0800
X-QQ-mid: xmsmtpt1682957927t9od3563r
Message-ID: <tencent_3B8290DDC66D3E624132ED39C7465CDC9807@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyzdhmgeaTiGdwAayVVBNizcyU1Jfob9MZjrC9CFbTPRnmCQIVCA
         baJDKCSZw/z8pNn+tVF9I/qytqEgyqxcUySgaCif5lWD9BXTtrUtbRSkGtzOmer++Av4Oihic5Of
         Ln0U2ZLwijgWnvk0pheO9ZJ1/doXtLUyYcUg9TQAgxvQEw12tU4caKmi6UADJByOohcBMMjQ55jz
         Qcw5j2EQH99Y1xlIkZp3fxQyL+qhLjLQDf5bj8S13TZEcYt17D1Pn25cFfRsvZT/DgAhmoaX/Jul
         1idHVhKOYEqy/p3f4ZpPqsqHCi7F2F83rzS4ulr4rld8hnFwcHMmYcPD5zlYarAyWlYfBnlOWUNo
         ycTS2YTFY9mJP6lVvTCkZ8ul7CKqPHVHZ2Z0b6c1FYVOfTU6P694SLz3flyh+iPUmCnAuU4u1UAV
         elPMahYdm2b/GL+GL/5m1Cw275YpfYlLweieY1EZjo6vwTFSIhXZlBcF5XIZ6S94KqtDEIlnDVBK
         Lm6kBxK2XDbCiBP8yldxjJ4rs5FF9jPVsWQ1zOdSs6YWKmIw97WWqp4GmWwKol4wLjpmSGgDYIS9
         TztSJrrbF4r+Kx4/jVUMSRK7WPMtvQxefMlDjiZYhzh699D7YKIq3sj/iO+oRnu0AYa735/9CJ3v
         ihuuRzES/+oIf4tzdMHQ3a/LcAyuhopvfd0AwXjvk5O/POfW/qR9xrVh2CdfORNfVTf+pxBIn8UM
         KNQ+oBQUlES1cVNX0UpzrTwYGZzwiqa3CYMqISzt71kz8SSBfkWYKwgc/JlPBdPdXNTcHUix318k
         H3pjaXZFwtmRgYT6jC2mlDN9i4srDTNe8ujw2CkuW5KOIGR30O9cGFDK2ijGgQxRBR7YjNlI4svX
         Os+QEanAavVhcIfd89w10DbFidhCmZvXMRxKAbbUmvMh6RHYL2ca68xdi+yQul0ZMig19Zz7C7Ms
         qZ+fdzZkuACVCScXunC8ArPOkAFsTGymvdlNi3HN5CqcUyajj/l4WJ6Obj5VGDHPNEIDS7LxA=
From:   Yangyu Chen <cyy@cyyself.name>
To:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>, Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v3 2/2] dt-bindings: riscv: drop invalid comment about riscv,isa lower-case reasoning
Date:   Tue,  2 May 2023 00:17:39 +0800
X-OQ-MSGID: <20230501161739.152403-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
References: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

"Ease of parsing" may have been the initial argument for keeping this
string in lower-case, but parsers may have been written that expect
lower-case only.
For example, the one in released kernels currently does not behave
correctly for multi-letter extensions that begin with a capital letter.
Allowing upper-case here brings about no benefit but would break
compatibility between new devicetrees and older kernels.

Drop the comment to avoid confusing people.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 25d6e8dbffb8..7dd792e7bb45 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -88,7 +88,7 @@ properties:
 
       While the isa strings in ISA specification are case
       insensitive, letters in the riscv,isa string must be all
-      lowercase to simplify parsing.
+      lowercase.
     $ref: "/schemas/types.yaml#/definitions/string"
     pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
-- 
2.40.1

