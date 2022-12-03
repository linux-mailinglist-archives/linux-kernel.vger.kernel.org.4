Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842426418E0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiLCUY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLCUYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDCA1EC68;
        Sat,  3 Dec 2022 12:23:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w15so12943287wrl.9;
        Sat, 03 Dec 2022 12:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzrnUQqvOayAs4N+M1MQbV+LBcDmG9rPh5cucDDDLJA=;
        b=agR1heyukmxnds6ACeqBYtBUJiYPHxR/fkhH05xSETYFd3RMZ/5Aa2ZtF+LdB5rU0r
         F1Ez3grG4r/6Sr9f4aWLMTip6s9SeTaqQaDwsoYFOWwXhcYaUE5rZK32BoGDypb0ABD0
         T8MNy1gExbusO2x+2WziOef8BmR5fZ70NNRSpdxhbT+Omtw/AS9kLh1NuL1UYkUNXBWV
         gBk0Q2FaFEgB3OqJ7ClmdwmBUPBmVj54fkGCSZUHyrfDeDZ20UaWmhKIfXjgVGA/vgUF
         AcJ/rDPZIadZseBF0OkVdqbifstP5grhCga4Fl61K2AZ9dONg4I1l872pd2GtiKR8RPp
         CS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzrnUQqvOayAs4N+M1MQbV+LBcDmG9rPh5cucDDDLJA=;
        b=pejeyfG3WdmLZRF8xKM79mZBYjtkq7GfXgF47jRrCXoOpiAHXma+8tfurWZu2tcLs+
         ayhVhw+hZNMtMcPjhs+1HtVCy1YC0Gcu1LR1o340RxGkMprNsDfo7F8/T3vgKTHgvjsl
         4L+Fo70hJajdm7ojUScrA/s2C79VDHFMbTepb+k359WBc+SERyDJrllBVtggy4mx8ydC
         M3kiVw7eNfjtlKxFDTBY/L+FN0sHvqYhbYYAHVm4RYXVKe49YOfNUnuwGF9YeVxe4DOE
         wwAlzlII7bXdo+LPwJnAId91ccrbseIVWfoY8BqjwC/Z7Q5kxKhOS068u/KorCrk6ad1
         Wf1w==
X-Gm-Message-State: ANoB5pnRr/j8soCwhGiNajQJUTnLUXBpHaDhkA1KG4DNSx4nPoGNspWK
        M6DW+LJWNx4kFkEkOVhoUip5JZ/0Pe0=
X-Google-Smtp-Source: AA0mqf6YhorUNpiYrw/fNmi1saGxCAfxOPAAIbBF+229q4+TsiILqRRdOlyjVqnyvMPDys0ADWGtQg==
X-Received: by 2002:a05:6000:1084:b0:241:f866:6bc8 with SMTP id y4-20020a056000108400b00241f8666bc8mr28179702wrw.501.1670099016702;
        Sat, 03 Dec 2022 12:23:36 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:36 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/41] recv.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:59 +0100
Message-Id: <20221203202317.252789-24-alx@kernel.org>
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
 man2/recv.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/recv.2 b/man2/recv.2
index d492976c4..5298a2745 100644
--- a/man2/recv.2
+++ b/man2/recv.2
@@ -24,8 +24,8 @@ .SH SYNOPSIS
 .BI "                 int " flags );
 .BI "ssize_t recvfrom(int " sockfd ", void " buf "[restrict ." len "], size_t " len ,
 .BI "                 int " flags ,
-.BI "                 struct sockaddr *restrict " src_addr ,
-.BI "                 socklen_t *restrict " addrlen );
+.BI "                 struct sockaddr *_Nullable restrict " src_addr ,
+.BI "                 socklen_t *_Nullable restrict " addrlen );
 .BI "ssize_t recvmsg(int " sockfd ", struct msghdr *" msg ", int " flags );
 .fi
 .SH DESCRIPTION
-- 
2.38.1

