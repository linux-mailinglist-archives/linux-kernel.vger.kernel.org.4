Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142CB631D07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKUJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKUJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:41:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AD92B45
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:41:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g5so1453605pjp.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBmVpxWlFwz71LnJc5cnHgJ90wlsg+VB/8BW+pshAAQ=;
        b=WYZMKxVd3zy9KIZ5y7QKsE3uZWM/MBJlzwhyRuKczyyggckB+9stzIpBloyceL6div
         CmB/N4imuF/AaV8oJEPGA1iMEGfWxgVaHVtXL/ibE/IROiHxrwjzX8rYUkHxkYbUkK1y
         a3Plf6lJLD49kOlPnZTXz7pl/zSU1ATNf5t747SyeWAwQlTPdusIJlxIFQRrvGh9xIwu
         61C+KfY4pMkCXfFf4EnIuGBb8c7ZckHLfTjJ/Tr62t8pEjrIwJ+C+SasoS9U6toK+qe6
         29mjxV5ewwxPE+1BEjs4pRutVE2SYde52WPt4BryPRD+rNvNdORjnq0Rhgc59i3IE2ax
         3WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBmVpxWlFwz71LnJc5cnHgJ90wlsg+VB/8BW+pshAAQ=;
        b=nqzAOezEmRXGnQ5JtQgLbil9YwDo5mvkC1uHFw+sJSTIQ7nSxY6jrbZhflJtAzssZy
         Pwn2NaGjhLTnmJ7O2iLPXoLhqGJDXj3sEsUr2Xtt86TIljPSCSe8GWYNb81z3fKcNgcb
         1+xidFoqx2KkoXS8YuAUAOVETH4dtD2cNsBwGSIyXyUHWf1A+G9CJx8VgnErv3UHmCHK
         M6iJ+gvU7LPI+9oLlvqJ09WrfpT3BVos4z3+ZDqD/kMyvmycR64iGQ7Gzp4rOwQaAuc4
         K+m0ZwqxAajkfkXQKnzpDNx1S8Ksmf3NhEMMRwXytLK4gu1kBwFf2FUh7F61bJlrvapl
         41oA==
X-Gm-Message-State: ANoB5pmppDjP6Yq+mGiDVVdzfFw9D3cB5YN/FuHXExkzrIFCgKdLP9vE
        QC0ppe0wbkI2pRrBLcscquHe/BqI80F4OqX1aN8=
X-Google-Smtp-Source: AA0mqf6Jsa1q3CgbiW2pFvROdLHLGKRKGCohX+6V6jDAfK398xzIQ5QEML2QVNcw/NIR2eoZt2ty16WNSQm1ZCBk7Yg=
X-Received: by 2002:a17:902:7683:b0:186:9fc8:6672 with SMTP id
 m3-20020a170902768300b001869fc86672mr1402450pll.65.1669023692141; Mon, 21 Nov
 2022 01:41:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:323:b0:46:da2f:f579 with HTTP; Mon, 21 Nov 2022
 01:41:31 -0800 (PST)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <gnidignonvalentin7@gmail.com>
Date:   Mon, 21 Nov 2022 09:41:31 +0000
Message-ID: <CAOcq9doJZdaj9YOWy5QjGeaiMHF322+926YXJ_sRS1=T4h1_jQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo schat, heb je mijn vorige bericht ontvangen, dank je.
