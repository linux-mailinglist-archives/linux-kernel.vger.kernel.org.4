Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748E698658
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBOUtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjBOUsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:48:16 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467743929;
        Wed, 15 Feb 2023 12:47:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x29so23694605ljq.0;
        Wed, 15 Feb 2023 12:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fp4fLreF7ITwXXOPi5xA0kqnX6pNOTDWraqHnC1V3xo=;
        b=KzV4SwiPMYfwBelyx6bUnRqDzDfStab1mcJs6qgR8XiYgon8Q9rGkxyx60kd7Wx0C3
         wNTMP33cQUgPUw+djS3LEWdg45YiiDEUD37hzCduR9QcXnNQiTJDy2xO2RB66dUNSmfq
         /C+LVrVdHBcxYkjqWfoRDpWQbIJfTworyBl1dR18dQFEPxPK/f4ztue70L3LIJsGzOLB
         uqljJQiWMEgq/Rk8dVcwf3eeV//l7bgcmkIyQ2rLq8ugzLuKqKVFtUwEpfi4eqsW2Xwb
         0M7b2/CvXAc9kUSYj+6Np70/yc3OpQQr07wu/qIypM5H0dV46qh7ZH2vC8dqHgl9VjL4
         Z2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fp4fLreF7ITwXXOPi5xA0kqnX6pNOTDWraqHnC1V3xo=;
        b=XfV5O6zY11FyWL0SOBUThfo4i0DEDhh5Jhxq9kO94tE+yZHJb/wrpLbcsRLzeneyFz
         1Vwy9Q1DDbNQLg/+5MsmSoKWq6Nq3ZAKik997+cfz2C4II12VSUMCJjW1uCsZhhcSWBc
         DzJQhwb/4VHEOsU9cuEYK2n8Ull3eCgZbV2y9INC6XheXRGJtizKQmhEQvyCFvGLHVQr
         HbPv+lQZB/zSNvaCa7NAOpM94PFjq65Eivf2l5oLfNw5SVG0BaICUZ94PsbdYJEI7GMO
         OQz9nhXIxnwDBJ6yKTw+lQGzWk9wMCJiONOBvfj2A4RtMaqF+LlfbH1xTl1AnQ6G6wq2
         gNFA==
X-Gm-Message-State: AO0yUKXju4t/TTVXNtWWizm6J+FPBoBSCKGS8W0LA7S5AuARL5RUUxs1
        vJMiGTUG+LyIfm91ULOFBzbQKq4P406KHcw0SBbXk7B1chndLQ==
X-Google-Smtp-Source: AK7set8mkKSki9sQyOJFvn7DER1t09q2yJ1TKXl1BUFyXhVNz31tkPKveFOoLnTlM85jD46oXIiwuwn9Xh2cteWva7s=
X-Received: by 2002:a2e:8e21:0:b0:290:6f84:541 with SMTP id
 r1-20020a2e8e21000000b002906f840541mr976789ljk.8.1676494025511; Wed, 15 Feb
 2023 12:47:05 -0800 (PST)
MIME-Version: 1.0
From:   Edward Matijevic <motolav@gmail.com>
Date:   Wed, 15 Feb 2023 14:46:54 -0600
Message-ID: <CAByNJ6rNs5ifSOE=ti7EwfNUCkOorMBVk-hbnosf=Mbj1GDL9A@mail.gmail.com>
Subject: Re: [PATCH] Add rumble support to latest xbox controllers
To:     svv@google.com
Cc:     android-framework-input@google.com, benjamin.tissoires@redhat.com,
        hadess@hadess.net, jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using _BLE instead of _FIRMWARE_2021 would be more descriptive for why
there needs to be a secondary ID for the same device.
"_FIRMWARE_2021" is a bit ambiguous as the firmware version with the
change is 5.13 and later firmwares.
