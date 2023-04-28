Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237976F1A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjD1OQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjD1OQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:16:17 -0400
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D95210C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682691374; bh=UISpvrWcf8XGHw2gIn9GQp2Gz016hHdtzc/xDluQqIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dBq84jf1X2DACXxYNGfUMRBqYj2e6uzE9ls+p1/N2+BZyVVVIDqzuAcOMp044tXXy
         88JigZzhMjAJn0prAcBIUwylPUgI4o7ryC7HZZycgp7Zf/PEfrSZ9Kyaz1+Ed4948e
         +zOrnmrI4kV7vD1ZdLpINwzhsTH094kFynktp+/g=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 4029CE99; Fri, 28 Apr 2023 22:16:02 +0800
X-QQ-mid: xmsmtpt1682691370t4nljvwy2
Message-ID: <tencent_85F69423082E524C478844E31D5F8920A506@qq.com>
X-QQ-XMAILINFO: OOWntbL6xj161VqpJyPFXPlj7lVhXLHqtUlwNC8Wpct+zWuCZOPfZLGmFG4W86
         TifaEo4I4giiKn7Qn6LrA7Q6eNu0+vhilhVtxwG4t5O1PEG0ZXy5DKIdDegDmkG7wp2w+EzUxpD8
         Me1WxHRRtikxQ3qUMkvU3ZpMvUHIPwsJKvAwWxFpVp0+SUmIj95bQcxC40FGYInRe8i4vdbccgbN
         FmwOCEl5jTgmuQxJ6804jQYKIUppa5r7Fv5h7SeBA+D57AIELnuOZLUP8QoX19TxHgM9tOC/Ps2k
         YFHUcAvCf1Izj19rTyWHs+Wpb4I4xYwTGam3m3xFn2dQRyCtAOIfAURrq52ROHmoNFugnBXfkgFU
         N1bVo8+Dsbea3Cqqq3MfXNK2un1rsM+uhRWf3QYMoCcFEfvtDXQrj6vXQtv/O25jf2/a9CeHhgXu
         KFdAehCAdL5kvLKGAvqrZ3ZMYrJKCyW5GCWFsRaACWDvq+vesmw3rr//p7F7EpUbIx36sLQ2nVTI
         l3x+DvR3QEsHqEWMX354e6Oo72uuy1JIH81S3OqyBNurtXe8YjYVI6XYlN8a/f5KuljPNe7TMmPA
         I8FcPuemMOljOIZUkQj5oCIv3jBGoarKU8uAJ12PHAS7iiaftNtsWniF8VY/3hNixPp6Hn+YueyZ
         ISQPEa5sJ1l0YqLmKpNpEw+NFfM+LALrwHh2Q6cfMWTaYNhTLeuBO+kKsnL0mquqsLcK1KYgb5Zr
         LvdT+XI6jGpd+CP+SG5/KVb3v5xdvKY6CQ58KpjlcOTmqf+s58W/AWE6tmWe/DxT6eqSSLh3Jebg
         q5ypUhQg0BjWuFRyCVIJg7RvaDKz+4mKuH3aZz6jZuTRlx1xlJ12vUkmd6js5jK5h0HkSzHdclee
         fY7ZeU5lxzU/CLi0O+wN84oIy+Ux1g+HjF6UwMaOeBCNZ0ROA96Gwh48J0NM50HEJVWrrBBrm78J
         pD7l+VoFLGD4TzHe08mItOjKSM4VdoCnOvPelpvImIaIGXq8kwVA==
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
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/2] dt-bindings: riscv: drop invalid comment about riscv,isa lower-case reasoning
Date:   Fri, 28 Apr 2023 22:16:01 +0800
X-OQ-MSGID: <20230428141601.678489-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428141601.678489-1-cyy@cyyself.name>
References: <20230428141601.678489-1-cyy@cyyself.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 001931d526ec..1ee97621d0c7 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -81,7 +81,7 @@ properties:
 
       While the isa strings in ISA specification are case
       insensitive, letters in the riscv,isa string must be all
-      lowercase to simplify parsing.
+      lowercase.
     $ref: "/schemas/types.yaml#/definitions/string"
     pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
 
-- 
2.40.0

