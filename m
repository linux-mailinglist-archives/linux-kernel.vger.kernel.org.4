Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A45B4C72
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIKHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIKHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 03:12:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F915739
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:12:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so9902749lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=pBOo2rmv6aDzYpCnD04lJQIWjwidr/slc5gncwNFUgM=;
        b=NeQbzVIqbJyFLz4+VLJTFN3uo/nnNLHceVe+YqTTgk/x4JfyJKsgK2VZgcUIp6f23J
         4mdexbe2mAqBpK6bT9jEgB/EkX6bq5eBohxLDU2Xn5InaJiKWGNyGNRFxUcSJwEoIPVs
         Ha+jK51dYhbx2J6E4Iepp9g6eQyfqAwllXLE9Vn+8WsQvfGlxFSkNmVvVaOLHbGOHAuI
         1YTtH4MgMxi9FCbSIWebVILKbGq+g7vqtlSSgiY9EywQYEphETq5nDSEyk80bPYMTRyG
         gVNn4Hol1TF3QSIDu9Px4E0Vw5GltrIgwVOGwHIKPd9E+PjmpeONET0193QpJ2XYScIW
         2XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pBOo2rmv6aDzYpCnD04lJQIWjwidr/slc5gncwNFUgM=;
        b=rJvvYu84fFrzb1PploM9QMqDIBC0uCUGTgooqsZYr1DhIAkx3KbCkKfipzHTh4T55r
         ERVNm8dZTa4nDQYNpC1OJ/OmEaBNAcH9cxALwi46AI8fcwJ2atkRVPc4HCVFtWkHL9kP
         HyfKbceNRXSEPbHhopYp5gXOWtHqHAnbtm7C2irqaQIofbLe7pA+IapLkrbAXJxzx6iO
         iDNNbVIQ7dEa6Zti1tyhmRMgwpGrhZoh9bwI9jVzb4NNZkxDu3BgxBtjL3fh90mzsekt
         igpRoeH9baoP8dt4hTyOFWyheFWWzDrWD1098vAkvhG2BkZ5XtJKpFK+c7FwVdSwVJg5
         2lqA==
X-Gm-Message-State: ACgBeo2qKYH+ceeSzNcYqDIAYEbNLroy6IKhdNv7QMUyMcoC0c2q0+f/
        zuBpczGwpEJ8sdBHWTX/C8RCtzygYmKHyNYsGxfvVVq4WADgGM5D
X-Google-Smtp-Source: AA6agR4qKFMqe3u/AGuOmuPPnhufIDrmwRMizBg1TX9e2I9v56bb9HHt80uz4QcvbOifL3RvJT2ss2eaoWWl/AmejnY=
X-Received: by 2002:a05:6402:34cb:b0:451:61c9:a316 with SMTP id
 w11-20020a05640234cb00b0045161c9a316mr4217022edc.268.1662879997974; Sun, 11
 Sep 2022 00:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:aaa2:0:0:0:0:0 with HTTP; Sun, 11 Sep 2022 00:06:37
 -0700 (PDT)
Reply-To: abdwabbom447@gmail.com
From:   Maddah Hussain <abdwabbomaddahm@gmail.com>
Date:   Sun, 11 Sep 2022 00:06:37 -0700
Message-ID: <CAHqwJXLwdvZuSio3-YZK-9HYo9GC49m4tUTgLZ4HwyQo0VqOrg@mail.gmail.com>
Subject: Get Back to me (URGENT)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,

I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.

Maddah Hussain
