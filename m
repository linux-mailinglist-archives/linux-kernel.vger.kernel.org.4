Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53647717C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjEaJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjEaJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:40:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4140C5;
        Wed, 31 May 2023 02:40:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d24136685so563375b3a.1;
        Wed, 31 May 2023 02:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685526007; x=1688118007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0wQqpVqSADYWZhZOHWRUdPhrtQeHJWnavRCiV7c8EhM=;
        b=AEAGl7RqHoaakBTxItnW4neRY0247fXV6XxN/TqsgEo5vOzLRj4slugR9kpkOs91vT
         h36+hsB5E8wjphdfZ/YZZlzagrVxgf46epsPbGx6c9nTxL+ZGmWmQXCZW1DiXMBQ1lcR
         IP/sMhl3JwJn1gZK7VTlpJDtUYgl4DWK654ef/EfvgmoeDMclqtDWM3XXSuyrtOClIUD
         Opxy1cHXwypRGJ/oko9q4E1nrxxqiegmcqlV7SUOwU96I8eAaSQ3t5vAPc6S4D/DACmT
         nwPh+yye7TXlIl2/OuP6fuYhSwPgKAjnJGBMA1GVCot5LxlDm9n5wvNCBEQFasSy1qq5
         JHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526007; x=1688118007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wQqpVqSADYWZhZOHWRUdPhrtQeHJWnavRCiV7c8EhM=;
        b=aHwEb9+z3Rmp8Mph2AKfVa/KHn79aWyqvxWQoM2ZkpmxlbsXCJP3Xud2ncfkRGTBTr
         8pxLweU/ijLCgc+93ag5dkhiQfjCyY2RC+ur1KP9bcDq34iMP/LxqAp8COZtm9ESG5hn
         9RrXStxdS81M5D6/ZyqN7nuE2S3R+TIFK1AgwcUu9N93ddQX1TAisQzxtBpqnRwhEf3y
         9ZuowFDbhBzXk9L/FQMZ9p4CCE8YJ3cgzL2/B8fi4LKPxTzAKI1iGFQdh4RcR1hWPsc7
         ZVHWsrlRWTQqubJ6Es5fzePkzTL6P6etJmxs/hwKQDgNN8YPGh1pCyIxGfE7zOQ/aaoP
         j7XQ==
X-Gm-Message-State: AC+VfDzicmDRWjT1HpgzDEwzGXuyNLWu/xcu5VOoAD8YjcsKquR6T9Yh
        vgu0Z3BAkn+Sj5kDyOpMans=
X-Google-Smtp-Source: ACHHUZ4ewL6qA9g6t0MbgN8fHUzH7bPB4KBA1K5lLXyl4p5j2OmLW0xQC8mR1Y8Sgp5hXBycuK6oPA==
X-Received: by 2002:a05:6a00:2d26:b0:63b:54e4:871b with SMTP id fa38-20020a056a002d2600b0063b54e4871bmr5218052pfb.8.1685526006968;
        Wed, 31 May 2023 02:40:06 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id h26-20020aa786da000000b0063b675f01a5sm3082621pfo.11.2023.05.31.02.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:40:06 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Sven Van Asbroeck <thesven73@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v1] doc-guide: kernel-doc: specify that W=n does not check header files
Date:   Wed, 31 May 2023 18:39:51 +0900
Message-Id: <20230531093951.358769-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation states that:

  make W=n

can be used to verify the documentation format. This is true for .c
files but not for headers [1].

Modify the documentation to specify that headers files are not covered
by make W=n and that these need to be checked separately with
scripts/kernel-doc.

[1] commit 3a025e1d1c2e ("Add optional check for bad kernel-doc comments")
Link: https://git.kernel.org/torvalds/c/3a025e1d1c2e

Fixes: 8fcce5803afd ("doc-guide: kernel-doc: add comment about formatting verification")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
CC: Matthew Wilcox <mawilcox@microsoft.com>
CC: Jonathan Corbet <corbet@lwn.net>

The best would obviously be to modify scripts/Makefile.build to also
check headers, but this is easier said than done. Updating the
documentation is the best I can offer.
---
 Documentation/doc-guide/kernel-doc.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 1dcbd7332476..c7785ee40e47 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -56,11 +56,14 @@ documentation comments. For example::
 
 	scripts/kernel-doc -v -none drivers/foo/bar.c
 
-The documentation format is verified by the kernel build when it is
-requested to perform extra gcc checks::
+The documentation format of ``.c`` files is also verified by the kernel build
+when it is requested to perform extra gcc checks::
 
 	make W=n
 
+However, the above command does not verify header files. These should be checked
+separately using ``kernel-doc``.
+
 Function documentation
 ----------------------
 
-- 
2.25.1

