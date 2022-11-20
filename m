Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EEB631255
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 04:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKTDD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 22:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTDD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 22:03:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD77B4071;
        Sat, 19 Nov 2022 19:03:24 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id k4so6060783qkj.8;
        Sat, 19 Nov 2022 19:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EG9D3pxDmJLoOR8yalJ60QE3TbGrEZ0wgZT4+n8USKM=;
        b=hIAoXrh0Z9cVxnmESVmWHy9DKLvtXdnVEJJMo7tBT/a4NDSDJDQO7i8vtPwmgtcW/q
         LdO6zIWL77K8R0Bwfh/6B9x9vEK+b4zXIFPRPV7RiCHbGpdHqiJpmoUBU3K+KLjdAW5w
         tLqfijykdwUpGvLevqjXnBS6OTuEtefjPnzE+ishlkRcITX6xCJte6upWt35YiYqp5dI
         Z49zEDqARfHJ5XH9jlD7OnqFP7uvxBo53lS958bHP+jzpAlKnPcKsgdtNtERgffpalJL
         i6Li8AvjbtSpYsKiR5xXhYVjhkKcCDuMT+kBBmbQNdv6e9nNdezh8fJGJbHC/M8UA7RR
         RXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG9D3pxDmJLoOR8yalJ60QE3TbGrEZ0wgZT4+n8USKM=;
        b=HOAdScQnVDtlR0OzUe0ciJpbyW5zWH7Q5rNIEYRsb435kg4T9IiXoWn5VxchDw8yg0
         A64dJxTeOl0eYdC/gCPBvXPe/exUMhRchQ/bIwa8clkqwz8BCTuigkTuxJA6lQTC7zRA
         OmUihL8Ku7hpts0NwWa6/ubKUaQrYe6HmAb5UrKBqAD8XmRU7RAFvtshDOuAken5kd30
         Y6C+Nd4dXp8zTUbjSB8oIhnnLmOIIM5XSbldCq+kgZ2wZJijK1r8E1WG4DhdfrCcxrfZ
         VyEziu+ly24J+o/FaSDZq+LJobmd+tXSPlqGzT9Q79TCWVmbGE3a0lgtlAXo4dNyFpuf
         iRkA==
X-Gm-Message-State: ANoB5plKia+LeeMLWdgbWIwyT3gAksiEJFe0VBRLcn9wMDZEsQFnJHa/
        pgX3BUWEPUZmhrrvFUmZ5paG9GaozLo=
X-Google-Smtp-Source: AA0mqf6FP7MK4ebsXbROTS11+UVHegky1ANr8ONBO/Y4n08sv4npoUKxvqPKW/3lUuwxWsOzVCHqjA==
X-Received: by 2002:a37:acd:0:b0:6fa:2d5c:110a with SMTP id 196-20020a370acd000000b006fa2d5c110amr11545235qkk.628.1668913403779;
        Sat, 19 Nov 2022 19:03:23 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm4522423qtg.77.2022.11.19.19.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:03:23 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] clk: lmk04832: fix minor warnings and syntax issues
Date:   Sat, 19 Nov 2022 22:02:53 -0500
Message-Id: <20221120030257.531153-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
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

This series addresses a few automated reports I missed since adding
initial support for the lmk04832.

There are no functional changes here.

Liam Beguin (4):
  clk: lmk04832: declare variables as const when possible
  clk: lmk04832: drop unnecessary semicolons
  clk: lmk04832: drop superfluous #include
  clk: lmk04832: fix kernel-doc warnings

 drivers/clk/clk-lmk04832.c | 41 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)


base-commit: 77c51ba552a1c4f73228766e43ae37c4101b3758
-- 
2.37.1.223.g6a475b71f8c4

