Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D836625C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjAIMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAIMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:41:59 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D213F0E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:41:59 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 186so3139228vsz.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 04:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOyDVK6Y7nyxp6zPEe0HgSwCH5j/46CiHNgA4ZI9nFM=;
        b=CPN41RmFvv+bk+tCAy/RAU3OA6RQGbC8R8e1WP9umGfk+P8zLs/TUOa6kJX+KSCmct
         UJaRdphyNoCR0xzYgvYyFsGrWzmwFP+u25MSGs7Z9G0hm9rmreOm37QdGYTyPazxg/4K
         DwnUuP/tS1h/pMbhsOOFQSJfsc02NvhmKT44QZxqDNTh6yf7CCr3jmjf5G/GFtmcmn+T
         pM3DQQgY/nPWVDqDM3Xgo/lWWuUN2dIY6wWwfqbVl7trdVgIt8ixHu6cHDtjyyXg7Vpg
         0qevUurwbc+Yqh//qys5Hj+XkRj3964tyCMwasgSOngX+eEyQzwvC95jEvBJpD9dViJ0
         54YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOyDVK6Y7nyxp6zPEe0HgSwCH5j/46CiHNgA4ZI9nFM=;
        b=2RF89p6jZtRZRxvK+LEj/7436vIqolGvtYOkwW+UYI/nBOyTveZpX3TR098Nlhp13g
         wvwIAV48oCF7jjkm0WxKLUrrcAU8IlrcY6wd5imv7hIz2ndObdNKk7XrOb50aeFS+SRj
         eVp2o61KFZEQ57PB8sw0Simk0QS4jMVM/m8gjHLqBUuX96N6rvRR9Xh0198Td86Bv6mB
         lz/BEwtOtEXUaa+PLaXagD9yFwYPLuzTMZFTibCsY+hg/WsJOxCgEV4ypr2CSmhkxFty
         1nzT7qVOxqKMJidOlQ/3Cg8kVML+roryS7B6ucr8t6X1wAOrV5NlIEEZTmt5PkAqFsiq
         LGkQ==
X-Gm-Message-State: AFqh2kqPvGtNPOkmyhQv2F2eLE3+qfnMtXPdnJ/9t20S8Pe1vXQVn+mz
        kJ3Xp9n/RVe+P2PpymdCTjQPKfPsSO2G7OFdJbg=
X-Google-Smtp-Source: AMrXdXv6NOMrUmqCMR3l0UJip0KhVi+c+tdR2TX6ncDSyau/JjlG8xdnOD9C+9IviesJEscclx9DsYYrIp1fM7XPgWw=
X-Received: by 2002:a05:6102:45b:b0:3cb:ebf:ba6e with SMTP id
 e27-20020a056102045b00b003cb0ebfba6emr5749643vsq.54.1673268118047; Mon, 09
 Jan 2023 04:41:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:5706:0:b0:32c:9be0:1129 with HTTP; Mon, 9 Jan 2023
 04:41:57 -0800 (PST)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <barthelemycomlan@gmail.com>
Date:   Mon, 9 Jan 2023 13:41:57 +0100
Message-ID: <CACfYTnVGp-XZLJWWmF1j1gDki9z8i103tn1LOBf4oXbD=AZZtg@mail.gmail.com>
Subject: Rowland
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I called to know if you received my previous email, reply to me
asap.
Barr. Rowland
