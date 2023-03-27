Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF16CB04E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjC0VDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0VDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFEB1FC7;
        Mon, 27 Mar 2023 14:03:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e65so12437821ybh.10;
        Mon, 27 Mar 2023 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CRqBQiFx9cqbs43Z+3goCj+Xo+gx/Z2Y6ZITCbmIAXM=;
        b=Pux1RMbo5L5WbyEIlGqDS4hdk6a3qWczTW6MClII8F52gU/+lhk3P3kfdqHzbj84v7
         l3jKOslwLHvP29JTDxdj0DqWDnD6anyv2KKDPTCfgao2VOU1bRylEbhBylfNZIAyHMCc
         mXsznNjWpu40qpwvdVMxtsXBFkIRMg6cUsknvTOubXM3vjg5IbBfU9LdBeUeDczOF2Qf
         wvdkFsKl7A9nlBjqWWOnN89xXTfnO7/geg9zlGv9LJrKLBIcRKaM0/i34Jqbyxc3DndT
         gccKo/CMlZjLoxA9N1YprmzimU84N+1vGnK4oAccBO7fBDd1SCGPtHXYcuLoHFa7ZyvW
         a9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRqBQiFx9cqbs43Z+3goCj+Xo+gx/Z2Y6ZITCbmIAXM=;
        b=m/sAuIGHFcu5ZuPERQXe/UzYFcqTP8YoG7MAcawbV4nS/9uGapTDuRebN0geJYFwIk
         mjZeOdaiqkKZI/NGkq9toEahUHw6Df+d5Z2NZoS+h+1Z+F0uY6g+VnlI+izq5tHkUNzs
         jSTxtW4E5YMNcMl/Y+ivOQJw1cGEzb5vIpJ4TyYLaZPN2FS9pnqK/AmvNaPB+IudaGxm
         B6UEbSFsSXwpGN/TIPuKcfAr7QAJ88uEjyB9RsExrL/Mzmz1LOgU2jLl0CxGMjNfHvKA
         lNDc1XeXQRBIhGd16b9+GQJ57RqLgdw/cKhig9GxpCDLbMuF54qBIjK4J/ebJKsqzDHw
         iFOA==
X-Gm-Message-State: AAQBX9eP0QtT63VlgTUNz6UKrUlXnvjRdFOc03n2B2iTS6n4veQRO8LJ
        lla582CkRi/qcXwG6CJHNkNWDbGECEc=
X-Google-Smtp-Source: AKy350aBtK9Y6MHzwPrrSd5WOoRnbs0SG6DtbBTbG2Y/0LsmYQzfRF/mMmcatBRyBuBnzND3REPy7g==
X-Received: by 2002:a25:485:0:b0:b27:4e8a:5cf4 with SMTP id 127-20020a250485000000b00b274e8a5cf4mr17677871ybe.22.1679950982893;
        Mon, 27 Mar 2023 14:03:02 -0700 (PDT)
Received: from localhost ([2607:fea8:529d:4d00::9f37])
        by smtp.gmail.com with ESMTPSA id 64-20020a250643000000b00b7767ca749esm2484657ybg.59.2023.03.27.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:03:02 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 0/2] misc: fastrpc: Fixes for issues in userspace
Date:   Mon, 27 Mar 2023 17:02:16 -0400
Message-Id: <20230327210217.60948-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 (20230130222716.7016-1-mailingradian@gmail.com):
 - use /* */ for comments (2/2)
 - exclude demonstration from final commit message (2/2)
 - accumulate review tags (1-2/2)

Hi everyone,

I've been playing around a bit with the FastRPC ioctl interface on the
Pixel 3a with some device tree patches. I was testing on a device tree
that caused the ADSP to crash every 10 seconds, and the inconvenience
caused by related bugs encouraged me to write a few fixes. A
demonstration is provided in patch 2.

Please enjoy and review these patches for better userspace while remote
processors crash.

Richard Acayan (2):
  misc: fastrpc: return -EPIPE to invocations on device removal
  misc: fastrpc: reject new invocations during device removal

 drivers/misc/fastrpc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.40.0

