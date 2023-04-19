Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C76E76B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDSJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDSJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:49:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B714C15;
        Wed, 19 Apr 2023 02:49:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a686260adcso31896505ad.0;
        Wed, 19 Apr 2023 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681897773; x=1684489773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RaefLVX9DcDHKamXvN6qTKAhJWPXQiGVdb1gX1FLg4=;
        b=Di0Lm1H6XGJyPzYXXL3w3VIi9KGKw7JnjGTe0Q8P5OwFZbX1nx+J6Ng/ZopCvTavEo
         ta0dcgYVeCMx6zEONboWRw05vZ25qF13kbaXF+m35DYLN1MLB2p/SUea2Q64QZBNz4rh
         OTWmZV1HuyoF/Qp4vt4QcKY0QR3wKBD1uKTY11fOs84tLulxByWkX89i0TMD2RQw7PPv
         QlaNVlWGdu+9EHurIngddXcLQBRh93LosG963VsQnKWMIkE+xvEKHIIkw53x7aejLV6y
         tSZ8yX7usJ4RgjTQBBmE7wG1KG2lwZbUjeaQoOvIxdyfcFTBq+eqnLMKiB1yZ7wA5MtY
         wrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897773; x=1684489773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RaefLVX9DcDHKamXvN6qTKAhJWPXQiGVdb1gX1FLg4=;
        b=RbnjVyLwVPrRip99zGxG6aJ1Z5+PZAMvwi7CiWRhK8nqMEDwNmCcLIWwlS59HfgJJi
         bCpWpa6a9DDY70UTPpcSux9TQ96u8OBRkLuQpPlUZIuZ9h6bc9qrgaTIGsgG04FFFta1
         8OJeyQlvBF0Z/6KBTbCQWb+o9H9l0ddPE10h8lTIbJl+wIk4u2hUlibApBo8CUBCvL1e
         LCZxfyj7eOAMyCCskkvaY2iMyfACEuoV9nWEYvpfiZ58RsVmDXpYKd6Iu+6WtwuBu2sk
         eZ6bekqvvyPxtzGaZsXqUZ9ttf+mY9LA2KpKzuKSBUzVdcrjr3nPWWGFpaFOT6TnXTYH
         4Mdw==
X-Gm-Message-State: AAQBX9elzuxCZyeoYRigAADnurCIkbz8jCqG7/AFASIYo2Fzl3hnGKcj
        nbl18aEIpHjnY2rVHirRYfs=
X-Google-Smtp-Source: AKy350bodp6uDTTSsZJlX1SgWrBHI3LJAieac9ltbMQf2PBrwO88Lfagsy6IjzttJ398PEbvHeG7Fg==
X-Received: by 2002:a17:903:24f:b0:1a1:c8b3:3fe1 with SMTP id j15-20020a170903024f00b001a1c8b33fe1mr5747097plh.31.1681897772950;
        Wed, 19 Apr 2023 02:49:32 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001a6dc4f4a8csm5244855plb.73.2023.04.19.02.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 02:49:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 312BF106894; Wed, 19 Apr 2023 16:49:30 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux XFS Development <linux-xfs@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: xfs: Extend table marker on deprecated mount options table
Date:   Wed, 19 Apr 2023 16:49:21 +0700
Message-Id: <20230419094921.27279-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=bagasdotme@gmail.com; h=from:subject; bh=dV8YIb7nbrySnv92KDySGI4qjdvV1R97MlSmF4/4G4w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCn2OxUtbN+1P19qIse1/2fIc1lGm4OuF8+Zae+9evcNa 6DTWd8PHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIdxjDf4fkOGaPxqLUH2qV q9sFd3aFC18OWenR7jg7eEffyddpUQz/k90Nv/6+6PjWts9UyL6Fv3Ff1fSl1rMK1Df3FU4SWtr ICgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reports htmldocs warning on deprecated mount options table:

/home/bagas/repo/linux-kernel/Documentation/admin-guide/xfs.rst:243: WARNING: Malformed table.
Text in column margin in table line 5.

===========================     ================
  Name                          Removal Schedule
===========================     ================
Mounting with V4 filesystem     September 2030
Mounting ascii-ci filesystem    September 2030
ikeep/noikeep                   September 2025
attr2/noattr2                   September 2025
===========================     ================

Extend the table markers to take account of the second name entry
("Mounting ascii-ci filesystem"), which is now the widest and
to fix the above warning.

Fixes: 7ba83850ca2691 ("xfs: deprecate the ascii-ci feature")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is targeted for next merge window (6.4-rc1).

 Documentation/admin-guide/xfs.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index e85a9404d5c082..3a9c041d7f6c31 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -236,14 +236,14 @@ the dates listed above.
 Deprecated Mount Options
 ========================
 
-===========================     ================
+============================    ================
   Name				Removal Schedule
-===========================     ================
+============================    ================
 Mounting with V4 filesystem     September 2030
 Mounting ascii-ci filesystem    September 2030
 ikeep/noikeep			September 2025
 attr2/noattr2			September 2025
-===========================     ================
+============================    ================
 
 
 Removed Mount Options

base-commit: 798352cb25d2c27affbb5c733ed28430057228ca
-- 
An old man doll... just what I always wanted! - Clara

