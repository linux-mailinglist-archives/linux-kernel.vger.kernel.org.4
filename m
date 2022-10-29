Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79772612345
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJ2NRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJ2NRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:17:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82EE6D540;
        Sat, 29 Oct 2022 06:17:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j7so3225138pjn.5;
        Sat, 29 Oct 2022 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckPB35sVjBMDrzWuFBh75nHBRSgfYvA4i4irOYENsAM=;
        b=fva0Bo/VRBO8ULSBc8xV/73f3qNQ5jWX7brGy3h0mHzYfuiP1hui8CnAUcEad4YMZT
         3/nhUa1eZ3LknKtbrenWU7/uFYG4kdNDa5CWH/+gKyFZ082JtYrpZtaZEdhrtOx29Iv2
         Rjozbi+r2hK95+sED6lFLbwVvfwmrxbDB7D9nmej5+posns0StcID200ZcrJe2PZK70f
         eUjWu93aBe09ZLFSghEDNSftWwBNyhceIburFzEZFKxKh3LUGSHqdOMYdG8rmiTiYx4r
         y6RZbU24RyPenj7UfB4BvuMoDNChCT/N8qpylY4xc845X4mmFmle1uEpBvb+MIcgOv2K
         Y3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckPB35sVjBMDrzWuFBh75nHBRSgfYvA4i4irOYENsAM=;
        b=O2USNZji4i1RDdrOjtzBpYp8Su7lASF+jLVtYPwne1J7McU3NkHgESRsPJry8wnmxW
         k6kdL8YQ604oVF0dr3SqvAz7umc6fkYMA+mI/gPp05f8t6Ur0vN4Cker2J+cYFLqfK5r
         ajKTjrGhPqu2xu00jeVCF38unKxhVHyI5gIyu5xSiHgYvSJK4tt+ENkPv4nyxxe9fZca
         yAtxU3+WCF6pZIm7Dygthm/5e+pkaXBXUJaWz0sNizAtHP4o7sF9qN/IDeHdSjGVrTNB
         xshyBkrABC2ZdTmMFp+98PJvDV5DC45V/fOLS6Bq2tOAbO+oPHsopLQ7fvxuoO2diPfO
         eVEg==
X-Gm-Message-State: ACrzQf01JqVTtdio1m3pQYYa5X1/YqVfsJgalkHsoiqipEJtZXYBcfl9
        ZQXT057xDPUGtaokF/BheEVoiEpaggtTRxuM
X-Google-Smtp-Source: AMsMyM5m0/tznL6QcpgZ1rJ9QYrvF5gjUSXU8+R3TdjCYGL4yPJ2kYX6WtqsDrQgGqVn6Q/HNYm6eA==
X-Received: by 2002:a17:90a:1690:b0:212:f865:4f0e with SMTP id o16-20020a17090a169000b00212f8654f0emr22362712pja.197.1667049465056;
        Sat, 29 Oct 2022 06:17:45 -0700 (PDT)
Received: from debian.. (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b005622f99579esm1187439pfh.160.2022.10.29.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 06:17:44 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: remove Thomas Sailer
Date:   Sat, 29 Oct 2022 20:17:33 +0700
Message-Id: <20221029131734.616829-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221029131734.616829-1-bagasdotme@gmail.com>
References: <20221029131734.616829-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=bagasdotme@gmail.com; h=from:subject; bh=lCAzbgb3aELI+YHQP6YBxPRDtkV84IvZ2WocqEA7ZA4=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmx6u96vggyeX/lz3qhJvNy4VruHNOFf+I5xXnUE9bGn+Te fWJ7RykLgxgHg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZyVY3hr2QKU6qQXq4qn7RqyC1LiS zjJ2ZNn2LtC/KO9Um+23/LipFhv+/PkKiy+R3Xfk0/ofXElaG0sW+JrqTvIYGYdVtMmPbwAAA=
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

Emails to him at <t.sailer@alumni.ethz.ch> bounce (550 error). However,
he was already listed on CREDITS. Remove him from MAINTAINERS entry.

Also, mark BAYCOM/HDLCDRV DRIVERS FOR AX.25 as orphan (no maintainers
for the subsystem as of now).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b655c704b5b813..63a84d3218a7b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3589,9 +3589,8 @@ F:	include/uapi/linux/batman_adv.h
 F:	net/batman-adv/
 
 BAYCOM/HDLCDRV DRIVERS FOR AX.25
-M:	Thomas Sailer <t.sailer@alumni.ethz.ch>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.baycom.org/~tom/ham/ham.html
 F:	drivers/net/hamradio/baycom*
 
-- 
An old man doll... just what I always wanted! - Clara

