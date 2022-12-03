Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763F86418F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLCUZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLCUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5E41F2D0;
        Sat,  3 Dec 2022 12:23:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h11so12907378wrw.13;
        Sat, 03 Dec 2022 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSgA+YcjHbarOH7uf/Ng/AMUR6/R2zmb1Djg4Ji2eoc=;
        b=SXre+XTrfgpDE8chbxFcXjpHOH82Nnvu8y9vubLWQqKYsntKHtjyOtYvQJ+OW9mk5p
         gcKBa9oBHRI8uaRA2K1N/x/U6blC0H5Bq/BYmcXmGstY4Q2zFflp1dfx4a2VThORwVZw
         gyPAu9RqiK8/qX2/d1MYcppq/A5i0/zCclEw3KPJGy3ZLOIalSEPWgoDtYDPibBw6EbF
         fFsxKP2b3mgO+pyqqZBKG/7ussDlPq3tlw8H2bA9dm49o4Fg9N6q+u6byaWglDIchSwV
         9OHTv95ZKPIBYDXZJ+HFro2DYS3GX/Ab7gHpXoic1+0zQbGsN4OYSHnEAk7/6dtHajxP
         heOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSgA+YcjHbarOH7uf/Ng/AMUR6/R2zmb1Djg4Ji2eoc=;
        b=lCXjUAoiZttzF21lT/lqWzyUIy5EbPoIaSK19RMt+MJuqdU9xMT2g6CJKVYrHpECRb
         ipVfyMdCeVkvhEZmUzg2Rapjq1T/hqosNod3LeKxbhPGJE69EZJtbXl6xFLvWpAweZ42
         xfnl0iPj/W+EVY89G8v5TxHaYEtWk5Y2ju5vE15E4ebZtlTXcgD8UpkAXA1N3AifCB88
         wIh642erVc33/Cgh0SbQXaTU6TIuiz4esoaPFV/OFZoIqkAseL0a5MeV+LyI2q2DwCL3
         lmWDoPXtKqfMe/0wb8aUCK0gSaKe/ggoEkVOFcwE5Odysj5271q/g3Dx1RdmhweKbCOn
         8Dsw==
X-Gm-Message-State: ANoB5pn138oWPMAYl+kOyO5HVaxbm3+cwwdFsGoT5XXZFT/3FVU+CZQg
        Ks8x8qy9L3l/vi0MgXs5QCsVNL5ML7Q=
X-Google-Smtp-Source: AA0mqf6krNEMfp+f1ByeYc6QZdXiLlHryC95wIsBACsXizxX5cA4lWhJTaQaOckYJuLvlIX7H4vbRw==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr45464183wrf.546.1670099028408;
        Sat, 03 Dec 2022 12:23:48 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:47 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 39/41] utimensat.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:15 +0100
Message-Id: <20221203202317.252789-40-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/utimensat.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/utimensat.2 b/man2/utimensat.2
index df33a1f7e..0a8774156 100644
--- a/man2/utimensat.2
+++ b/man2/utimensat.2
@@ -15,8 +15,8 @@ .SH SYNOPSIS
 .B #include <sys/stat.h>
 .PP
 .BI "int utimensat(int " dirfd ", const char *" pathname ,
-.BI "              const struct timespec " times "[2], int " flags );
-.BI "int futimens(int " fd ", const struct timespec " times [2]);
+.BI "              const struct timespec " times "[_Nullable 2], int " flags );
+.BI "int futimens(int " fd ", const struct timespec " times "[_Nullable 2]);"
 .fi
 .PP
 .RS -4
-- 
2.38.1

