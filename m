Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82CD67BC28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjAYUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjAYUIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:08:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0B38B75
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso2131760wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJOtoqsm0tyufNeV1ShS+S171FTUAh48RMkH3ha17v4=;
        b=SlNm0NOnOU3D9X7z4QlCCYEGLZVjttOaDxsOR0rE9rAuzcuPmGHO1lMw4L1J25ih9r
         1SY/55ujkNf/ZIpReEVsZ+Iegy+BPL0G9YVQbSJEEgHQAH0Zb/c5L9B5z1SjhHSgV+IG
         lyTn9EkKYEL9hVLVw8PCm295Zh826wfd32QhWk1AXh8Laxvw64h+hd576gKGUpiKiDKW
         cvk6iwPp3n6d3FriulPmVeD0a6UbAeiIuV88XhWpvuSv25qHyXBJuAo3hMjnXMM4/YtT
         +JTvWszlvlfA5TV8gpi6MDPRy+HjmUexMmpbW2urkfq81AeHbnvb48GyaUL6AB6Tn89c
         h4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJOtoqsm0tyufNeV1ShS+S171FTUAh48RMkH3ha17v4=;
        b=plXfl40nZisJ1U5Y5Zl7cMIx+9qdRVz/HoZjNLdJM+Zh9C52hbJgtn3pVzMBEF1C3L
         g/fOdgRuaPS+gHU5rhgGoHStcndfHe3150CNOdPtCeI1EIiTeKOCyYwaKGYzXGtAQ24Z
         wt7GIbudSBD0msGsZxlvRqXoxclhc+v1h8ZRPLlfyJazg0Uc+D5SgqN2Wdtsb1uPFEfi
         4GekFP0jC9H7XSQPxesBYVznf1iDlAO3Gbte7mtSNRCv+4ha2PwYPTpk7317Q8MvjF6o
         2C4czmUMckHkZaOtKH8HM2dVv3hHMQ/p9a7uNzLc0K0jfENWKiH2CtVxzQZ7E3Guf0jM
         ITHA==
X-Gm-Message-State: AFqh2kqPXwhM8Ru7I2W4Lyhc4jWdj5Yq6lLBW7Pf77w8PVRfXXnw7i5r
        61O8L2Aw4047Ifr8bYJUU98sI/bMN/Y=
X-Google-Smtp-Source: AMrXdXu0zZ33udh4WCWz0/jbl/UuD7jVjv9OZ1MwRXfkslyQvqHZnrnVhbnC0zchxd5xQUc59E2UBQ==
X-Received: by 2002:a05:600c:3b8c:b0:3c6:c5d9:dad3 with SMTP id n12-20020a05600c3b8c00b003c6c5d9dad3mr8933429wms.0.1674677298048;
        Wed, 25 Jan 2023 12:08:18 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b002882600e8a0sm5493698wrr.12.2023.01.25.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:17 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:08:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] staging: rtl8192e: Remove unused variables from
 struct rt_stats
Message-ID: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables from struct rt_stats.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e
---
V1-V2: Removed further unused variable preamble_guardinterval from
       "Remove unused variables numpacket.. and received_pre.."
       Removed further unused variables prxsc and rxsc_sgien_exflg
       from "Remove unused variables num_proc.., recei.. and rxov.."

Philipp Hortmann (11):
  staging: rtl8192e: Remove unused variables rxrdu and rxok
  staging: rtl8192e: Remove unused variables rxdatacrcerr and
    rxmgmtcrcerr
  staging: rtl8192e: Remove unused variables rxcrcerrmin and friends
  staging: rtl8192e: Remove unused variables numpacket.. and
    received_pre..
  staging: rtl8192e: Remove unused variables numqry_..
  staging: rtl8192e: Remove unused variables num_proc.., recei.. and
    rxov..
  staging: rtl8192e: Remove unused variables rxint, ints and shints
  staging: rtl8192e: Remove unused variables txov.., txbeokint and
    txbkokint
  staging: rtl8192e: Remove unused variables txviok.., txvook.. and
    txbea..
  staging: rtl8192e: Remove unused variables txbeac.., txman.. and
    txcmdp..
  staging: rtl8192e: Remove unused variables txbytes.., txbyt.. and
    signa..

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 39 +---------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 44 ++-----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  | 31 -------------
 3 files changed, 5 insertions(+), 109 deletions(-)

-- 
2.39.1

