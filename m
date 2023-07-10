Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8974CB29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGJEWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGJEWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:22:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CDE7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:22:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c5c8d00ced3so4875748276.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 21:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688962932; x=1691554932;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX5uNyAHwrZNhhlwsfu1AecRzPZOVLKJKqRNQzXpFZ8=;
        b=OyYQt7AaGMRLQql0HG/GXtmpGjKSNbGmTFyR1gN1j3SX8wH1pHj4NP7kFM47PcZpft
         jcW9PQG4ffD2pEm75AhvmLdKFpbPI/vZOH4izfcI1zMdjvp9vLCcKrBcO4Zcn6o3eLJA
         HckpsfRS2aIUEPhWRqQQMxatScG1L47jqQ67VTf7PcQms3h9uW/0wZZrKOEeQNQgXTD1
         FwZVn5GKI8w2kMsE/WmauFUVlL0x4u9asY1g4h6xEXa4lE76Da2wNKT81FkAlM2tfR8P
         IxwBPaqYna+mia3ELjxuVtijHsXmpEuu9jkJACdzA5Pevg5zWqC4nvL7D5jABlT/GNg8
         HF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688962932; x=1691554932;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX5uNyAHwrZNhhlwsfu1AecRzPZOVLKJKqRNQzXpFZ8=;
        b=B0+hVRurCK2DWcX+deQQMK3/8rYL9UXLwH6OboM2NISrg1HIcftRgbl26cIXs++nqM
         F2vIpYSRyMMo2NQVomuAGgeFBp20rx7nA6HV7kC5pFdqrngg5hpXvDN6KLy5i8df22tz
         iftOjLHUEGGFkTFt47dYcyYi8giLnq2TGmM/nGacgCQbltPZV7XueRPSeo3KKltdPFtD
         2Dwj6ohWYPNcHJt/kGz074yS2sbMVP5qFWpBbfxlDauWU1Crh2Z64Hi6qEj3u3z4VjBC
         S2xMXU9awrTHvlG788i+qtDUhAsETjY8qImRhz+eesCuviLq208HzdLW8pRPrWNyydGj
         TiTQ==
X-Gm-Message-State: ABy/qLbvNNjNYKACqS0Jfm6VdavuAoPnX/l53WkCRhrixWqz/TRqVeXs
        a1TnoKMpbtvaTkp7cUiyOMkKjFE2931KuM/RvyU=
X-Google-Smtp-Source: APBJJlHVwtmIa4CzAuS42iJ4ZdwHoMPTxeOg0oM39O+97DPDu+cxRg+8Zy99WinNzjb7fba0OETkh/stJwQG8s9N4Ls=
X-Received: by 2002:a5b:1cc:0:b0:c12:d2b:5428 with SMTP id f12-20020a5b01cc000000b00c120d2b5428mr9148598ybp.29.1688962932496;
 Sun, 09 Jul 2023 21:22:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:98a7:b0:348:9338:4fbf with HTTP; Sun, 9 Jul 2023
 21:22:12 -0700 (PDT)
Reply-To: alex.tomnn@gmail.com
From:   Dr Alex Thomann <mykellema@gmail.com>
Date:   Mon, 10 Jul 2023 05:22:12 +0100
Message-ID: <CAAsfaiHNb8ROPyxo0LO=65N32cAqjxv-6fu12VsQdJYZD-hg+Q@mail.gmail.com>
Subject: Attention Please
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I Have a profitable business proposal to share with you,
Reply Urgent For more details With Regards.
Alex Thomann CEO.
