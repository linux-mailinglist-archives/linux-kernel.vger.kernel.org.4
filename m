Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25064037D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiLBJjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiLBJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:39:02 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C63B0DD6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:38:58 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 6so3946251pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 01:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XimIfodoUxeMcHO1cFf85ifhj2aOJKMkGvtzlN91Clk=;
        b=LxmdY8InSRJ5Uom6Xevlez/5U24dBBdc+YUKG/33mdfiUXFmZsPfBGuoxGKVny9mUx
         Pmgj/+FQkRcceK/pM/EMmke95z4ampmV6l5O7EMs0bCsTxiPwMfEzPadEyB6nIG5xSSI
         xNDzjj8wMnEhNPsutT/yHqH9adb12QwD1KVoa4E0c7Y7S53aNYT4PMrD9vXd5E/UZO8z
         ymGGheXScCHUIp6PuOCGSzlgsupwRQSEGcah7cqv318W/qLVLo45cn3kfmcAT/fCB7Rw
         FsvMn1eDfERMUrV6CMUZNiWNLJwbCYUiZm6f87Q3GqFpRD+/32vybUe/Yzogw8ZbFcfi
         vGdw==
X-Gm-Message-State: ANoB5pkGxXgj1TtMjcPfzzLO7thrO0GJucadhvxQQHRzgIzI3JfKV56p
        r7Y5wx2l/OyXATEqDqhV1Bqm+CcglWE=
X-Google-Smtp-Source: AA0mqf6jj/fOfjoRwCkHmn4viB1sBBFddq6gT/9KX8gOHJqJIx+KteXJDDz7yvNol+iDYojjUItz3w==
X-Received: by 2002:a05:6a00:e09:b0:575:3e68:ffa0 with SMTP id bq9-20020a056a000e0900b005753e68ffa0mr22402314pfb.12.1669973938228;
        Fri, 02 Dec 2022 01:38:58 -0800 (PST)
Received: from redsun91.ssa.fujisawa.hgst.com ([129.253.182.55])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a564f00b001ef8ab65052sm4370881pji.11.2022.12.02.01.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 01:38:57 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] drivers: mcb: collected patches for 6.2
Date:   Fri,  2 Dec 2022 01:38:48 -0800
Message-Id: <cover.1669624063.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Hi Greg, 

Here are the patches I've collected for drivers mcb for v6.2.
Both fix problems in the error paths.

I'm sorry I know I'm ultra late with this.

Thanks,
	Johannes

Yang Yingliang (1):
  mcb: mcb-parse: fix error handing in chameleon_parse_gdd()

Zhengchao Shao (1):
  drivers: mcb: fix resource leak in mcb_probe()

 drivers/mcb/mcb-core.c  | 4 +++-
 drivers/mcb/mcb-parse.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.3

