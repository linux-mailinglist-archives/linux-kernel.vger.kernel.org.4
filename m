Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1F729B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbjFINOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbjFINOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:14:40 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BB30D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:14:33 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so8684605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686316472; x=1688908472;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mNgVkgD/S0YfbNK1A+pza4LIh3+khsAsND0FnpVsy50=;
        b=GRhGzExebVhAequQivPpLdeW13IBzLDmbPv+1HCBsKAUYUn80ZTPHn77er93IDvk7B
         a3yO9BY6kQAUstT6gU07wB9dECY+0sW+Q+GNOF7uh7FEsU4TlWU0I8lTG1Rus647E42m
         hG3gAcaQoM7/JUcyYn2U8Ltdq7ZZSVYdtB0bqQi049a3zYvixbX0WFIm0HrfPAeA4bqt
         soMRIANmDvgQWuFdixDWXz7WbolAkL+R8voNZf16rmdMYtuMSEAPl39f5/KGZjw4Mv1U
         B9UT0f8i9BKWWslKyJZ9h4USOOl4fDIenrkgP5hbpKDaOeBppZlVHviXOt/7RGm1dJTy
         JZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686316472; x=1688908472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNgVkgD/S0YfbNK1A+pza4LIh3+khsAsND0FnpVsy50=;
        b=XfnxACZE/ll0w84F4a8IdiK8ITgyG5Al3OUWZ2WDOcbNiZ3iBeJHQXiCrlq2VHBs2L
         PhZaJ/t69z8RJGec6jn7YeuSOhd8En24lLGcX4wwK2bJqyRaIggdYJ3W9p/IzDtuvUoK
         RQy62s6N2dzO64DMJ4TaFSh0ZfkI0l4qWm5SxzQ/uoRil0Mkwd5FoNMxkWZsef9pTYQC
         Al5ykfhwTsaU0IDZGvUiQ+As+qXl9d+nsSzJyX6TZkZb4L+q2PTOog5lZIQ8k02sQVFL
         CbpF6WgkwC4WxcRHLvzzyEWdsArDXwrqsT4Sumht30DwiX6g111OE1KUg7V/NQxExgFo
         lguQ==
X-Gm-Message-State: AC+VfDwEWgozr4Mj8GAnYp3qWs16zSfbZkz8ibWRXYRpp8Ct1xVeTJTN
        FLo36x/n2iDqvqeV3W5ADz6A+qxLQszkUrqUvUjg5J3jcweZUe9Ef0Fa7CvR5/Mii92ZExgMzna
        9Yi92Eu2KQIC7cjbLFv8z7MS8O9a7ChNWevRvuRnCexoCJLqCeSG3hCkvDHi6P/14jvbOxeClyY
        PIjG7d
X-Google-Smtp-Source: ACHHUZ5PO+ud2qYLht2UbHAn/+RX35RQmyPwudAqxkwVy9EqcDrERh9k5noqN8UrwAOJYcYnZNQxMfvpkYIYzLW4
X-Received: from jordy-spec.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f2f])
 (user=jordyzomer job=sendgmr) by 2002:a05:600c:218:b0:3f6:1b7:11fc with SMTP
 id 24-20020a05600c021800b003f601b711fcmr423383wmi.2.1686316472263; Fri, 09
 Jun 2023 06:14:32 -0700 (PDT)
Date:   Fri,  9 Jun 2023 13:13:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609131355.71130-1-jordyzomer@google.com>
Subject: [PATCH 0/1] cdrom: Fix spectre-v1 gadget
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

 drivers/cdrom/cdrom.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.41.0.162.gfafddb0af9-goog

