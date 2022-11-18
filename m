Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195D62FB89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiKRRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiKRRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:24:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260413CF6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:24:12 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e68so6420188ybh.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=N9HSX8G8lke3Q6T5cADQRq9znkKBXBw+IRBm6vGEkQN44gqNtxxX3XAQV5y/Tsv5zm
         hDZj3Yowsn6nDsoNBeSb7QiC3Xq8i8VaWRh7GhhbEph7LvmOnk6LbGohA+T5TzId5fY+
         hD1ZMKca+gXfnD4OlbnxN7NFDbTDrv9voJl7sxcJvyHbytKphYk/+qYJwFduNefOVOaA
         nY+XdHUt3yjnjxy5ftgrZ/SjID1sNR0ZwZ4gPwM8FBwaVkbI/HZ99O4AoX4ykCSh8/x1
         KHQtDxY8thUTsEnoShArYCfO1t3RQpkxf3Ymmy4tpqI0npZwnObQ2TC6+BhOebYuKDgX
         lv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=riituR6FdWVfdhnf1DCYJpPss5yXK6cHHBKvQz9Y+GeuiACW5mpQ0FimMa2SMhJsQd
         4AbQXLDvJT6T6KGPGXt4TU8Myt6uQpwOEOdXec0zrlCMQwq3ylh1r32YcU26ltPLnR4c
         12STDIzPHVCad+vXg85dxmSK9B9r0DKfXSEaZJzTFHcTdJ1ENjHfHA228jQ0z/uhHUJj
         c5Oe8EdETDNlYYzSJNO9y5FPr1V6mAyawZRupKwpoy9w/gHKNneuXyGRJMHOcIEpR67k
         +Mra1T9LqJi1wd2U99wVQbVD/6wRcaU50fGgh43rMY/mwvWqgVyR+4cG67oFUZU9qJNP
         UyAA==
X-Gm-Message-State: ANoB5pmVe/o4DGvsEodKMBqePt0uQDT6eWDkGU33whJ/SzWRpkVxzPoP
        QXx5CwyGl5DKb8FTuhL5W1UtiFQlK1jmHYGaWVg=
X-Google-Smtp-Source: AA0mqf7cfYunf39LGGzmq7q5REUKZqdg9Jq0SUfOxFpOV3BUc4We4eO2pJM8Da5XrpAIzWcviplUSmKpmkDwKFanWfM=
X-Received: by 2002:a25:af87:0:b0:6dd:3711:1359 with SMTP id
 g7-20020a25af87000000b006dd37111359mr7282674ybh.341.1668792251759; Fri, 18
 Nov 2022 09:24:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:67e3:b0:3dd:b061:4379 with HTTP; Fri, 18 Nov 2022
 09:24:11 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <nassodjokombate@gmail.com>
Date:   Fri, 18 Nov 2022 17:24:11 +0000
Message-ID: <CAPu99ZR1w=w1h2cktqLaZ7BbBamnHZd3xMf1AfEtxmoQ3GrQZQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message for you.

Sincerely,

Mr thaj xoa
Deputy Financial State Securities Commission (SSC)
Hanoi-Vietnam
