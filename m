Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FF6164FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiKBOWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiKBOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:21:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B3CE39
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:21:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y4so16738094plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv0O8gGygG1cBg83m0a3ZlrLdLId5rS4r7Y8GfdODRk=;
        b=VO79yoByjD2Q5e2iSgycnz3i3HpEaRSS6ix4F4bKxqfLGvqBMmDvtIwMx5FBEDkPCN
         oopTAhVrUA/W50LH9tABBj9KYCbzwkB5rlNIJDRz31AlCHni5JlFIdwx7oj/BJsYKxMu
         tGtqxH+kxnsdWRIrxFOWQMQE2mukPOl+MEyLhV8l3Wegd8+naVz9cLEyvn2z6E/3X5wo
         221a3ShTSaNcdKeh8w1VgwO3iMAItlvztTAozbWWaw4GS8bQQZpcGnUMohyGsBSXDnvR
         8xkHeF7KX20K9N4nrV3NYcwctnPqIgtWFTnaFKqm59tx+9e2To1kYXns6hNTOOu4xyxt
         y2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv0O8gGygG1cBg83m0a3ZlrLdLId5rS4r7Y8GfdODRk=;
        b=BIryEOBKWH/+PRYgKwzKM7QB9JtNmbK73rB3q1ZALTHmUpLuVVgPpU0ET7B2yXOLNT
         STf7J+7pxR0ikUb+pLG3AXmuHznOF1qVHN6LIi3mgFDVSa+n4pu6ZinptC3rkY8NAUYG
         narCNI1JyXe9zBxYNB4O/50Deod4dzM9vI9pkkmYRRhEAqUOwXFw2356XJV3+zg78Rn0
         OATLkRLGsMUvSpcg+eabRQIrGk0WBRnTecj3qClCDGojhBHcjleVLPn0vNxxpbUQ/8C1
         vC8iEjNXNRWfYN1p/2ZVA18Cl99MVUH85B3POGQA7Q70u+skc9zy+1IBcufHpjTVQSuF
         +Sng==
X-Gm-Message-State: ACrzQf1fUSBAoPUhWodc4F2lHtNQbT0NLsGXL0opFVQ0QqG4VLi+05ot
        vFnj4fdcIQbPWv5Tw/8ostAfxQ==
X-Google-Smtp-Source: AMsMyM4Et9Gwo+ZRf0lg2usVxIirtPv5Ba3yDqOT3Bbkxqbk8/jvKfYbKce69kcLxzji6TR5QW3lCw==
X-Received: by 2002:a17:903:244a:b0:187:10f1:9f91 with SMTP id l10-20020a170903244a00b0018710f19f91mr21657289pls.37.1667398902819;
        Wed, 02 Nov 2022 07:21:42 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm8817773pfp.19.2022.11.02.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:21:42 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/4] Manage domain power state for hibernate
Date:   Wed,  2 Nov 2022 22:21:00 +0800
Message-Id: <20221102142104.2006554-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series tries to fix a hardware lockup issue caused by missing domain
power state management from hibernate .freeze[thaw]_noirq hooks.  The
detailed description of the issue can be found in commit log of patch #4.

Changes for v3:
- Add one patch to drop genpd status manipulation for hibernate restore
- Add Ulf's Reviewed-by tag (Thanks Ulf!)

Changes for v2:
- Fix kernel doc of genpd_finish_resume() to use the new function name

Shawn Guo (4):
  PM: domains: Drop genpd status manipulation for hibernate restore
  PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
  PM: domains: Consolidate genpd_restore_noirq() and
    genpd_resume_noirq()
  PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq
    hook

 drivers/base/power/domain.c | 114 ++++++++++++------------------------
 1 file changed, 36 insertions(+), 78 deletions(-)

-- 
2.25.1

