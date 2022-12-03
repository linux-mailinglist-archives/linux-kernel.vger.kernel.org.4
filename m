Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFABE641902
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiLCU0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLCUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:25:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE61F9F3;
        Sat,  3 Dec 2022 12:24:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h10so3415627wrx.3;
        Sat, 03 Dec 2022 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIgERnEvCy9JwrWGDS5dOuRf8wPtw2MM2uE+HA0XUBE=;
        b=KiwK2v9rrWu2FgR/0B3lCeqiGRUE50HXxvLfmCrYXVKMwlPg/+fI8usCWPoeJBaMFC
         OGheJkAkb0bwTwCJrhk1M8FpX2M3JoTwooHW33FiY/laicv6hzNIpccVuPng113BUfc9
         oR6d6Ax+7srIQ8XotJdhd3BYiJEqaHpQXeYPYTTsFzmJN9aBXoj/JtEFjQmXElE6XdKE
         NhWec5TbFJUV3C3FtGWNkFtEZIiT0iG9ywkBqrTeA2D86qMpX3fr50qUSNZabymYStus
         t5qisfSDohsEma4sdx9PRPeqkewOJYt/o1sISykzKUdToYp21X9qInOeeVxnAVdSOnqr
         pBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIgERnEvCy9JwrWGDS5dOuRf8wPtw2MM2uE+HA0XUBE=;
        b=aVUyhvV9dD/Ssh5sQq8Fkh9yMN31qtK8hucsNOgnSZyyX4+orJldKD83O5CkImALwE
         ipmOlgZBD1L6SlejvYG0a73Q5NSV/EwrXEsIfcme7G8byyEATGSTA8iH18jyu7YlTqzu
         CdPgY9PYEOdCMIj30EYIchGkOvw6uDWLyuF73z7S7LVyE3fqsy/BlnsqBq1wJZXIDsWJ
         t2xUM5kIGiHRFPrnbk8sbHfnD0g1v40gSpqQsE8+ixXyMh71mfBe2KL9KSaL16GUeDfE
         moEe4paq7cxPYxSBy7Xx2WDcTnexgUK4FiDAYABwrg+Jt+x6qnMcGPQmCGoxuGLeOmLR
         rubQ==
X-Gm-Message-State: ANoB5pnYwZNblL1Nyvf+N7waNn1p4oijMa//oAx7N54Wue2sEirKYAPe
        nmESXRN7u88ngXINrQYpy9LZoPff9oI=
X-Google-Smtp-Source: AA0mqf6tB4VMpWcW9u9EJ6Uto6zit0T+LPsIeGEd9rrRvupTe3aIH8zT4V11qEG7cvv46EqKrC3NGA==
X-Received: by 2002:a5d:684f:0:b0:242:7a2:a014 with SMTP id o15-20020a5d684f000000b0024207a2a014mr23990218wrw.228.1670099026748;
        Sat, 03 Dec 2022 12:23:46 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:46 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 37/41] timerfd_create.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:13 +0100
Message-Id: <20221203202317.252789-38-alx@kernel.org>
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
 man2/timerfd_create.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/timerfd_create.2 b/man2/timerfd_create.2
index 078a2d4b9..1b2fb3ff9 100644
--- a/man2/timerfd_create.2
+++ b/man2/timerfd_create.2
@@ -17,7 +17,7 @@ .SH SYNOPSIS
 .PP
 .BI "int timerfd_settime(int " fd ", int " flags ,
 .BI "                    const struct itimerspec *" new_value ,
-.BI "                    struct itimerspec *" old_value );
+.BI "                    struct itimerspec *_Nullable " old_value );
 .BI "int timerfd_gettime(int " fd ", struct itimerspec *" curr_value );
 .fi
 .SH DESCRIPTION
-- 
2.38.1

