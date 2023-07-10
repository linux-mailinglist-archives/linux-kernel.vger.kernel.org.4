Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769474D962
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjGJO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjGJO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:58:44 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821C135
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:58:43 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so59058905e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001121; x=1691593121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lULb/OxCs7WRovdfM5gs71pASVZufLIwl5IvyAut4js=;
        b=PWk4/zlvkn3+PKobmHeVH/cTVqRY2jto6VYoH2Xosd5RggXwyoctBa6wEE7BSjJ5fH
         3aXm2u7TxxCc2IuQ63evbSUcwW/dwsuj8r5YZd0TW3Pr53cCNd/4ujkPKawMBrkwLsnc
         KYi6qNtTvERFWHvTA37ATQz8ttaNZxZwn+CBqjndw5u4jDyV7aW930VyFZSyiHqV6WgZ
         930Arm+O2+zDTgOfcYpfU2KluFgaQsXzLJzKC3KlUSqNHtvSR+YZiIEacLmhS8T2x09X
         Nr2Paem2P9Vq0t4l5WkxphiaV6T5e5sAlSx5pxj8QZ0tzbM+ildyKX2Jiqb5vsIKaTHG
         5GTA==
X-Gm-Message-State: ABy/qLZbT1+3izb5hNrCNaeXh7/IrJmxCn8BRtQq6IRh/Y7zSdcyGH23
        /B8Kp+ObNO9nh9yghRr9PJc=
X-Google-Smtp-Source: APBJJlHBo2q1EGLN6LU+A405wDwVmov46TiGhKcyV7yXBN4i4zveZ3XElXld33SPGlyyvAlxk5tSOg==
X-Received: by 2002:a1c:7505:0:b0:3fa:8519:d323 with SMTP id o5-20020a1c7505000000b003fa8519d323mr16070975wmc.5.1689001120975;
        Mon, 10 Jul 2023 07:58:40 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-175.dynamic.mnet-online.de. [62.216.205.175])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600c364600b003fc16ee2864sm47920wmq.48.2023.07.10.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:58:40 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/1] mcb patchses for v6.6
Date:   Mon, 10 Jul 2023 16:57:51 +0200
Message-Id: <20230710145752.14285-1-jth@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is one patch for drivers/mcb/ from Jose that I've collected.
It fixes a crash on module removal of the mcb bus itself.

Thanks,
	Johannes

Rodríguez Barbarin, José Javier (1):
  mcb: Do not add the mcb_bus_type to the mcb_bus itself

 drivers/mcb/mcb-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.40.1

