Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82826418EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiLCUZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiLCUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CEA1EEFD;
        Sat,  3 Dec 2022 12:23:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so12942291wrh.7;
        Sat, 03 Dec 2022 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfxFDsDMRR0bmUVkg4LqERDTx68Ld9Ejem5oiH1HbCc=;
        b=gP/lbfipe/zGjLVki9PFXssjNeA1Y5WhSzCNkcP9QHW1t5umaaHoF90+Gafql4F7T6
         /+uw2PoOUgaW3Xp8G+pdiWazK1hYeTKN8X5UhFM7Go41I6cTzX1LRpjNdBwoDtraBAg5
         9NKdquPzIYP2IOvUNy4z+A+XA0wje9pE2x1yGwXVfOJVPsR87i1q64zo+dl79WqeUuTu
         fUhtoymat6OylzZk9our/TxA/dKr3hilfocqZWmMMiEwigWof0Imwmk1rlWhKFJnWzAB
         D42wvecDpErAU7vXBLybwLF8gQTrkUR8LJ7tuJqImCMYNUg69XbvdjI1UUGceqXWJhL5
         MT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfxFDsDMRR0bmUVkg4LqERDTx68Ld9Ejem5oiH1HbCc=;
        b=2MWiRptjSk32bCnSmn85gIc+OOxAHbxDNpU1IReGD1kqptK+VVREvxNc6EqWjS6ZaM
         AEjwT0elkWZJ5PvZLSgViAjI84Sj2ck1coTXZlruZHNFyLsmLf+dfttpnguKvSuk0atz
         hDFNZEQZJnYPEcfbFdhhULrwJ9yKKfjqtDFv7QPcKTcMwFucOQJhAAIyOY64W57Lmzgn
         g0A7aR9ddY3pevOiXbEUGIFPJk8Gzn/+Dzps34lJqm650mMwTkF1Xw2ISJhZAUCBNeCp
         z4on7Fbe4ihzqegZuyW3Q70IqupyElqox3fGNUF8FuiI5qFe6nJtIgLKlY0ImVchtPDk
         bVsQ==
X-Gm-Message-State: ANoB5plGdv90kD+qVThVSlurvtMWSU/IrfmdbAHpE191H6Yz0aG9GZuv
        eYfAG8k9yN5PK4LducKJg8iyq0Fk52g=
X-Google-Smtp-Source: AA0mqf7O3XfmUDSOJUy6RC5mytFqC7T/F+9516eSv8JaqqPhhbSXvkQd+TV8Te0TIoyggaum6fi8JQ==
X-Received: by 2002:a5d:5187:0:b0:242:5ef:ce32 with SMTP id k7-20020a5d5187000000b0024205efce32mr25360754wrv.260.1670099021003;
        Sat, 03 Dec 2022 12:23:41 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:40 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/41] sigaction.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:05 +0100
Message-Id: <20221203202317.252789-30-alx@kernel.org>
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
 man2/sigaction.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/sigaction.2 b/man2/sigaction.2
index d43f9b0d0..b6ad9d63f 100644
--- a/man2/sigaction.2
+++ b/man2/sigaction.2
@@ -35,8 +35,9 @@ .SH SYNOPSIS
 .nf
 .B #include <signal.h>
 .PP
-.BI "int sigaction(int " signum ", const struct sigaction *restrict " act ,
-.BI "              struct sigaction *restrict " oldact );
+.BI "int sigaction(int " signum ,
+.BI "              const struct sigaction *_Nullable restrict " act ,
+.BI "              struct sigaction *_Nullable restrict " oldact );
 .fi
 .PP
 .RS -4
-- 
2.38.1

