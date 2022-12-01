Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999963E960
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLAFi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAFi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:38:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18945AE3C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jl24so621829plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oregonstate-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WVt3V8FfzgzDnwBUBeRhDNHIa04Em5O1M/U9tgg5G8=;
        b=UZbwdtUWMNFeUxioVu4QDNsPbO8DSdnMoVXOsgd0iHeEuEuFV8fpDxJWYUUTYW3Cum
         mQ/C1mwhZ1gVlBfO+p9rvuwsJvv0RK/xhgyFvdYftENEDpHchxWLcXvcvt8y/3eCD0f9
         ifjVcRL5+rtGcYF/mj2B5DQ9ehVPbUA+FZL1cieacsV4rTL5udChLTPbY/RAbb2vqtbt
         uEAYKnnAI/iJ95RcF9XgdN0iNq+w5eJxda5MFY77HC9S1b1d7e0cVUiynKUA0CIvJtzV
         TXyaK557tzrDhaDNY80InxkqYmixwqaWPDaH4/5WY+qB20/33Ymo5zjqeHEx4uZthRlJ
         +Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WVt3V8FfzgzDnwBUBeRhDNHIa04Em5O1M/U9tgg5G8=;
        b=tkxFfKkRFlw7OkX9p1sqjPj0LBQwmP9XcO3Om16vZ/BCeVLajDucx7wjhvvEovnTOO
         gpbp872xOg9HqIY3ZS9BhfznFxbjht48zXtZoIUG8RR1CE3D31BySc3iyq68kxDdfE/Z
         q8sZ66pJb7PKg0l3FEKQm3j7aJk/z7aVe1lkz20IEfKYfmngrVlOyCIIF5cIKQrQ01z3
         YrewWojjd+2LYIRNTFBeXb6PFRqTRSRsW7We1WnSG/GcuvnYmsHJXk8OQoj8+u0/jNPf
         9GNbLnOTSMH/O847fAmyzGGCvSMH1xEar1JKM5/ktgOqnmhHwi9jkls8sPUEQmE5bLQ1
         LtnA==
X-Gm-Message-State: ANoB5pkciOOJOQKv+npoDNCfmlJ33P3gVAZg7wmC/92VGrMMvwgElYmB
        R362Z3soxIXGrsWVjRz31ZTa8X1ZKgFCyd2mXTY=
X-Google-Smtp-Source: AA0mqf6EfHKL1F+S6GRgY8Ae0oeN5XfbYeVhUMkna1iH4YadKpdm3eH+pjdUkSrigvzfsFumjoaD9Q==
X-Received: by 2002:a17:902:f7cb:b0:189:3e8f:fa49 with SMTP id h11-20020a170902f7cb00b001893e8ffa49mr41209551plw.142.1669873135441;
        Wed, 30 Nov 2022 21:38:55 -0800 (PST)
Received: from ubu ([76.27.231.73])
        by smtp.gmail.com with ESMTPSA id t197-20020a635fce000000b00476e84c3530sm1754319pgb.60.2022.11.30.21.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 21:38:55 -0800 (PST)
From:   Jack Schofield <schofija@oregonstate.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Jack Schofield <schofija@oregonstate.edu>
Subject: [PATCH 0/3] staging: greybus: Cleanups in loopback_test
Date:   Wed, 30 Nov 2022 21:38:49 -0800
Message-Id: <cover.1669872193.git.schofija@oregonstate.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct issues found by checkpatch.

Jack Schofield (3):
  staging: greybus: loopback_test: Add blank line after declaration.
  staging: greybus: loopback_test: Remove void function return statement
  staging: greybus: loopback_test: Remove extra blank lines

 drivers/staging/greybus/tools/loopback_test.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)


base-commit: 9dadff066244543780e5d9ee406b3ec7af19e22c
-- 
2.25.1

