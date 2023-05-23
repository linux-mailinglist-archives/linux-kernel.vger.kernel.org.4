Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D570D973
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjEWJrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEWJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:47:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96213102
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso4827472b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684835229; x=1687427229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0vblhd6IJw79HeVVMpkwMplqOLqhUzNFQF55pVvmMc=;
        b=EBO6mYRbZ/ljKDwrRfa2fuU4Is4gjuY3rvhZHm57LGC7y2CTtaCvtOXjI7vJhOKicU
         GD/nS2yZl6zPWPC7RHwiYDo2FK7G0cxYhZXIiHjjSty+D3f1wF+wlS5iF6ZKuUexhQG9
         U+zlwQT2whekiGXnZBinly3JmsO6rxYh2IViUmFZR/fiyOnLBaxu5o2IeSUFnH1fPkjA
         Kgk2CY+ZsDklUzgwEV8MERlija5qqcxw++WUv5btNOPJ0FPokC+HAj6BxT/AIcJO1xzS
         ieZZIX9xhJWljcMYC6nDfchKh006QeBESWuLHe8nP0qXN57ZqwAkzND+5eFwL7aDXC4W
         +xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835229; x=1687427229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0vblhd6IJw79HeVVMpkwMplqOLqhUzNFQF55pVvmMc=;
        b=VjDNGeXXPoHb+ca38byVeWsWGxNibf19qF2Bi/h2UFKNFZBL+p2N6x9gKJh/XUeat0
         4on7b5aGPflgx1+Z2TBxmYuyNhO7sasv2wlRqH5QJQ9PrtqIPxw0iN/sVt4nqxRJsFjG
         54el6JAZfHdY6PEkhGNl4dFKsDqTOwzzBfjtwYMQbBuXHmxZ+zoPdOxnyv+AjLqW8V2q
         FFJVKlOrmMZtZwBWEDAyi0JMr8UA3T7+dbDfqWYU83I3VxtYGexiv075ktaCwfdMHqx5
         Fy2AFmtH1sZbWanps4637Pb2OV9z1HLl1oF+elc8ifYduNT9SOFgZFxzRIhaMJ01mqtH
         +Jcw==
X-Gm-Message-State: AC+VfDwI3PhKuk6ZE+y9MHQbEqSK+15HzydXp2TDL4+2elQ8uqrUoQPa
        dxnAgXqDzNm+f64mESsGEiFngw==
X-Google-Smtp-Source: ACHHUZ4KNOYgrxNt8HGukktdZB0yyjlPK6yqHBOk+HR+ilXP1L0PBbEvzbbclK/daKybh8epwWckWg==
X-Received: by 2002:a05:6a00:c88:b0:639:a518:3842 with SMTP id a8-20020a056a000c8800b00639a5183842mr20937561pfv.7.1684835229019;
        Tue, 23 May 2023 02:47:09 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0063b898b3502sm5457216pfh.153.2023.05.23.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:47:08 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v3 0/5] sock: Improve condition on sockmem pressure
Date:   Tue, 23 May 2023 17:46:47 +0800
Message-Id: <20230523094652.49411-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the memcg's status is also accounted into the socket's
memory pressure to alleviate the memcg's memstall. But there are
still cases that can be improved. Please check the patches for
detailed info.

v3:
  - Fixed some coding style issues pointed out by Simon
  - Fold dependency into memcg pressure func to improve readability

v2:
  - Splited into several patches and modified commit log for
    better readability.
  - Make memcg's pressure consideration function-wide in
    __sk_mem_raise_allocated().

v1: https://lore.kernel.org/lkml/20230506085903.96133-1-wuyun.abel@bytedance.com/
v2: https://lore.kernel.org/lkml/20230522070122.6727-1-wuyun.abel@bytedance.com/

Abel Wu (5):
  net-memcg: Fold dependency into memcg pressure cond
  sock: Always take memcg pressure into consideration
  sock: Fix misuse of sk_under_memory_pressure()
  sock: Consider memcg pressure when raising sockmem
  sock: Remove redundant cond of memcg pressure

 include/linux/memcontrol.h |  2 ++
 include/net/sock.h         | 14 ++++++++------
 include/net/tcp.h          |  3 +--
 net/core/sock.c            | 33 ++++++++++++++++++++++++---------
 4 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.37.3

