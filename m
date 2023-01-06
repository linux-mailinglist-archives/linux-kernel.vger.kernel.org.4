Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E866064B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjAFSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjAFSUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:20:25 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCFF4567B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:20:24 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-4a2f8ad29d5so33035477b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baxoHBp4nwp+eSIfz7bow0djtitpVsI8N+RYIADhEnk=;
        b=h+LUIyg8B5SAwVY+SIsSEnUHHDjYlLaRQKe2s22dWZpFkd7t5XqDmS7X9OhKq/H/Jc
         CGEAc74zJDgk4ELkM/AC6s3pKde50fc/kOdUU6MSo91ZPB4z476eCVkIr2Ti7MgSH7SH
         5bjUhbkAr2wEadyFuketroajOfmXjfF3Fu7HuplP+0aJPT3QAa5vgHbBa8qBXDA260q+
         4mYweoUnwd+pKd+8DkFqadGoTq84MbkLbQeYZDb/yCSdKQEilH/jF3HnrssYPv8giIRR
         BifvNvWOxEdqzak1fJdHnOKJZw9TVyDl4mexbHFpC2Kuc5hvgrhnitJtyFNlSiIhbaaP
         B9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baxoHBp4nwp+eSIfz7bow0djtitpVsI8N+RYIADhEnk=;
        b=h28cOGijydhFqpdZzTAAa9xHCOzaDaNcHRXz7AIhlln8NtsFfvHPZrdXSM4x0Y6qap
         we4O47tQF17JcceMFvaP0b7w3SFLT5J0v/mIDZVjRzlpn5hpaPO/3WDm3/ah1cPSzMk7
         hrP9hFl5AXbfmAyiJoMMti/nGRmbMMdKFdPEc+/R1Spes+unDQgT5KRffxBlewaBjQBt
         qz+nVR2WJPgYESnGfc53TslsBv2lkIW/xEju7AHIojA3jBmzXzMBS+c54bjBJHMOun+6
         KexvfkWDwhdz7l682UzHYqjyKrhBPHiHef96CQkR8D4Uxvjq/UVRLk4qbTumnBE5RHHS
         fC5w==
X-Gm-Message-State: AFqh2kr6QgkoNDJaNo4tM00JmR6o89nkO48CgdnckCou4Q24hkblv0D/
        Kdq0UnKFLbcIX83H3OTW8Lc0O7v9TP9gyNThw/Q=
X-Google-Smtp-Source: AMrXdXu7D4rK8juTrHpzNkWlOCTqvNjAln78B5Zlj+wXStpRsajJZdRiIjVBd4N3GSoAZ38rPxgVfoj28fAqATAxn5Y=
X-Received: by 2002:a81:7c0b:0:b0:3af:e986:5752 with SMTP id
 x11-20020a817c0b000000b003afe9865752mr6515521ywc.155.1673029223493; Fri, 06
 Jan 2023 10:20:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:b7ca:b0:3de:29a7:6628 with HTTP; Fri, 6 Jan 2023
 10:20:22 -0800 (PST)
Reply-To: mrslorencegonzalez@gmail.com
From:   "Mrs.lorence gonzalez" <fernandezjameswilliams@gmail.com>
Date:   Fri, 6 Jan 2023 10:20:22 -0800
Message-ID: <CAKpfx1SCRaWACCew26_CJkPZZR+juScU+3oQiRpqXPw8EThMhw@mail.gmail.com>
Subject: God Bless You As You Read This Message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how dealing with Gold
Exportation. I Am from Us California
I have a charitable and unfulfilled project that am about to handover
to you, if you are interested please reply

Hope to hear from you.
Regard

mrslorencegonzalez@gmail.com

Mrs.lorence Gonzalez
