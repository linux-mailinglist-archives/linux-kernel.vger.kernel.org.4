Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BCF702A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbjEOKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjEOKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:16:12 -0400
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 03:15:35 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02BC2106;
        Mon, 15 May 2023 03:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684145544; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qDTIIAzqDyNFmO0GjIMWdlTAsPfxoi9c54XrSPnPIBCD+/Ac0NqjPIo6RX6ZXYFA/v
    XfSRhLCFFqaZY+hM+ieOq8rjSYgktwQ/tfFSeaZAmb+l7MHOBSN4ag8OibJxs/nNzGuJ
    yqHI9U60zAdGQoDotldrbSoLHJ3sxR3Qfu9o4COGYCqhsQq6l6N9z7Kw7UQS2+hRBwIR
    ftSNtfx19eFQlt3El2cFRuG67B9/TXphBjO+Sjj2KW4jf6hH/KJ9cnxjcR4SGfqgcLPZ
    RArsEHlfPp6fstmF4Zj5Agy2rxlSMF7RV1jvuhngOzoXFykStQDrUs8J8MweXQjExpqD
    ybsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=olVuiJZGfA/LHV3YVLMLjpbt55lnzWTZbOuO9FJhuMI=;
    b=V6mauyZYvxwo5w3sMUAKskAbdeyyXVMqzWDRWwTuyaCbU9/14gd3OZUCy4fSob6NBl
    +pP2fjAi05cVDIRS9WVjjmdDh4HOuGTqMstUiaOGL+XIs9QGySlmIgEiCO4M1q/1iGSu
    MWPKD5uWoPvJ8KS524PAe+iZXzdMYRXYiM20K4LDW40/PHJ2AMGETzRzF5TxMXQxXVGa
    u3uIVWYGvYN4z1wyYRYEN69RSAS6OQjxcWqlhYXj9so/o/hJH0q/I11WFB7yU5AJ5Ta0
    q9xTCt4ceGjb82ozounPElMKglNLribywWcnBbr5wYmG7TgOygKjw0qkUhK+O4y4CM4Z
    xfyg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=olVuiJZGfA/LHV3YVLMLjpbt55lnzWTZbOuO9FJhuMI=;
    b=CY+o6P9VjlLTzgmoC0ukNBftxBPWTp+7p5Sf63HXc0kUdrbe51QDEhkdp9Wtei8gCx
    36mkGqS1MxlBxUd2aUZm8VSzzNvMDQ+iEyrYqhhDomIXlgCGy0lYIQlTuJVh/7vTZXjH
    LZk02fO22jf3tEZDtUtM/hEzd/CoSxwcSfng63j1v3SMB17uUs5bzuub7PAMNgvhSk5h
    fVs9gKoT23x5tolvWfYrBeCcMwEdRGVXI+f17rwhgYErxVvZpiA+WYm8KF5vlZFlNfSK
    JKBYgV4xLhWiG84cXENjPysczqq8CwbFkGjrxDqLv8EBWXhxPuxZ28E+Od8VshjfWQ3m
    NQpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684145544;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=olVuiJZGfA/LHV3YVLMLjpbt55lnzWTZbOuO9FJhuMI=;
    b=NpzOsiBC7Df5KrzmYokWRVug7C5LvTnshPFSpfjZg+SXou+lgjK2J8KTa7xrsVuGtr
    lptCIGHXxBH9BsowsSBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4FACO1JG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 May 2023 12:12:24 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 15 May 2023 12:12:16 +0200
Subject: [PATCH 1/5] dt-bindings: reserved-memory: Add
 alloc-{bottom-up,top-down}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v1-1-3bf68873dbed@gerhold.net>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
In-Reply-To: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the allocation behavior for dynamic reserved memory is
implementation-defined. On Linux it is dependent on the architecture.
This is usually fine if the address is completely arbitrary.

However, when using "alloc-ranges" it is helpful to allow controlling
this. That way you can make sure that the reservations are placed next
to other (static) allocations to keep the free memory contiguous if
possible.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/reserved-memory/reserved-memory.yaml  | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
index c680e397cfd2..56f4bc6137e7 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
@@ -52,6 +52,18 @@ properties:
       Address and Length pairs. Specifies regions of memory that are
       acceptable to allocate from.
 
+  alloc-bottom-up:
+    type: boolean
+    description: >
+      Specifies that the memory region should be preferably allocated
+      at the lowest available address within the "alloc-ranges" region.
+
+  alloc-top-down:
+    type: boolean
+    description: >
+      Specifies that the memory region should be preferably allocated
+      at the highest available address within the "alloc-ranges" region.
+
   iommu-addresses:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: >
@@ -93,6 +105,10 @@ properties:
       system can use that region to store volatile or cached data that
       can be otherwise regenerated or migrated elsewhere.
 
+dependencies:
+  alloc-bottom-up: [alloc-ranges]
+  alloc-top-down: [alloc-ranges]
+
 allOf:
   - if:
       required:
@@ -178,4 +194,27 @@ examples:
         };
       };
     };
+
+  - |
+    / {
+      compatible = "foo";
+      model = "foo";
+
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        adsp_mem: adsp {
+          size = <0x0 0x600000>;
+          alignment = <0x0 0x100000>;
+          alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
+          alloc-bottom-up;
+          no-map;
+        };
+      };
+    };
 ...

-- 
2.40.1

