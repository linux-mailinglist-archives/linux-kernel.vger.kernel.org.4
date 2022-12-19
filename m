Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2563D650A61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiLSKvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:51:38 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5103238
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:51:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so12598958pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnLmLvgShV/W7N/W9hqKZyUTfySzDbfoixNFDwE9tBg=;
        b=H+VZI7nHrnZPHAA2YNIvM1iOrGdQejmumT6YJFuO/CKtqRflAnXTFG/vDYDstyGX5I
         Ve/30O3xqpZCJufjS9LbKq3Fc6tWgUQBpBBwp32FZlvCB00vqAe7WfKtgvpkRxXtW+26
         v9Kv4wGhTiwWvsQtME1saKk5Nm/qf5sYu4qXzGRjJWAQ57UiaWkFtS34vKcnxYr0cJJz
         AFUFWwDqaaMfyshGCaUMdGXi85GeBxva6LxOYU1RHVR5ZWukw0+lq4/TD8ZKffFyO/G/
         M6JoS9eyrh04dCG4kHssR8ix51xUoaLK6/Ioxts/dHybye2Xpk+IACbFXGubRGxYG+Tj
         f+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnLmLvgShV/W7N/W9hqKZyUTfySzDbfoixNFDwE9tBg=;
        b=Vi6uuBewvylqlviV1mOzcQKYpdStxvjr6pWVAREFoDvzJU0/AVUQKax2t2PT9sN17m
         9t46qUj8gwODaudqj6XLQuC+5g8WQoHAKm3ZxdLwHpuQRZiIwTtJ2sMV6ykb+ieelA1O
         kW9Bw8VIe7VIUpfL2P8Ds69NiyEj3sVRi0lRuWi5m7133FFYgs4b5fZ7XBhsrs50ZEph
         AMoa/OV5pOpTd0se59VfzeJBtTXWwkFDs8fVSAlLJc39BBNCpBb3uG2xo1NkBUTCuW54
         8it+cc/AqqiVpYM7DSTr/I/+X1vcpD8GvB44ergM/uzioYxakes60tvPcvmST+xcSmmy
         3XEA==
X-Gm-Message-State: ANoB5pl/ngVEaNBmLVfriwW+wPwCNxxiAw0ScGnYiEIz7XJXvA3qAG1e
        cla0OX9zkyigX+ze0jtjLYtL3A==
X-Google-Smtp-Source: AA0mqf63I/ACW9cbaVenxHMtExnfHoGyJyZsTE50QE/RQSGuCF1qLcj7w2Q7pU6AYuAsRhAX8ReSXw==
X-Received: by 2002:a17:902:82c3:b0:189:89a4:3954 with SMTP id u3-20020a17090282c300b0018989a43954mr38296221plz.41.1671447097335;
        Mon, 19 Dec 2022 02:51:37 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id s24-20020a63f058000000b00473c36ea150sm6016407pgj.92.2022.12.19.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:51:37 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2 0/1]  drivers: base: cacheinfo: fix shared_cpu_map
Date:   Mon, 19 Dec 2022 10:51:31 +0000
Message-Id: <20221219105132.27690-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changelog:
--- v2 ---
Rebase to the latest Linux codebase

Yong-Xuan Wang (1):
  drivers: base: cacheinfo: fix shared_cpu_map

 drivers/base/cacheinfo.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.17.1

