Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1281772C297
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjFLLM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbjFLLMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:12:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B63C35
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:01:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bcef239a9fbso248000276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686567650; x=1689159650;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oEitCfAriDWfmoA4bhrw4hqcpbGa6CV2D5Xj8kSFQwo=;
        b=s10DMNQqFJ/QQAl7ra+WJ13OkqdglOIDLUyx8p8mwzosA6ENOI0+YGwUQBweLr0KjL
         QLbu4bGJEHYuvzGf3r8tqluWTreXMU3I7WlaEC408/Sq2DZ4kgVGd6hyuoLNRxkxgmOF
         xXCzskn9iSzFJwPyi7yeVS8DH9+cqpvMtYTym39LOp29+nGsBXNwz2lT8SMa8j+UgyaA
         HpearsgJcxOO2SnoD7hPWAwM/OcSHx6+3wMEd0yM7eUm/Q8P6mRnHKgQ7RNelPlj0iY3
         H+STAA2L31hUyB7TJkVfPfEE/zPl2Ichbaaj76BQe3cl2cMNquXOt01Si44+Q41Zk0/s
         4Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567650; x=1689159650;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEitCfAriDWfmoA4bhrw4hqcpbGa6CV2D5Xj8kSFQwo=;
        b=VlehQCMagLkfK5UL0ma1UCo4bPpFh63FLmi0fF791RBkW4k1ysbZ0gll9sgoM1pN5S
         3SFi8YRWoQ8z0mTymclZWiU3mB3a5e36S0ziblkchjH4jH+yRYWxGzOREwBufgvOWgit
         YeYXhO4dF2GH23Mu96ZGrFoVqh9SL/ygXGQk1wZTC6Kzz7LHNmInFs7FsOUgSxiZMFy5
         Y1136nmY3/g6vInaEi5g1qrbEqQy5BwuRGOLrD4q4I8GGwh8mIxYURMHZw+JUj7RQrwz
         DzebdtkJtNo2ujmdN1/Emt2zfhmPSCOaVylMafCcikjz4NI5I+ZfW+CN+O0KCpn4qWuF
         jiyQ==
X-Gm-Message-State: AC+VfDyByjVEtXIrL68Jz/lrI2o4t4zeXbii7zNm3iKCHd2oRBn5PpGE
        gfbr+/kKR0mQ1n51D0SXnVhO0fVvIitYJTZnyPQY7JH4d7pkApaFlYDhmhuvr8OsaCHAmcT5fwq
        6iQQUGLxUIkHT/dNVTz81n6kipCXcpFGKQY7MFEOcg6rrFNioIojhdlN0cxGn9JBln8KG5W33ld
        et39zt
X-Google-Smtp-Source: ACHHUZ5dPz5h3l8VBbwWhZdX2wJmXF3Tj8FRNLAt8kRVui3jGo+jXgioAL7jqgHXyKf/nfqaDW4EUqncKU0P06YG
X-Received: from jordy-spec.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f2f])
 (user=jordyzomer job=sendgmr) by 2002:a05:6902:38a:b0:ba8:381b:f764 with SMTP
 id f10-20020a056902038a00b00ba8381bf764mr4910110ybs.3.1686567649858; Mon, 12
 Jun 2023 04:00:49 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:00:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230612110040.849318-1-jordyzomer@google.com>
Subject: [PATCH v2 0/1] cdrom: Fix spectre-v1 gadget
From:   Jordy Zomer <jordyzomer@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     phil@philpotter.co.uk, Jordy Zomer <jordyzomer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spectre-v1 gadget in cdrom.
The gadget could be triggered by,
speculatviely bypassing the cdi->capacity check.

Jordy Zomer (1):
  cdrom: Fix spectre-v1 gadget

 drivers/cdrom/cdrom.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.41.0.162.gfafddb0af9-goog

