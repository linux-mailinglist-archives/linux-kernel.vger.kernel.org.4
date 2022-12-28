Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8E657B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiL1PSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiL1PSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:18:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14F13F77
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:18:07 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q68so3240975pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C7yuYmjSdAo5W2EzOhPWT+j720zeYFg2XyfNLd1KOg=;
        b=lHLcSFAk+G1BQqruF2HEMkJE8jBJL0bAOCeZeTV886flyAdUQ6u1bfFVMzGNH+eVS1
         fUwYwHvFvly1FFiS71KECB1WsAPRSV5I7q5IPJWfoKr+uZH5Jn6pfrNJiaO2UG6TL6f8
         L9ljuauPC4914tT95uY/CK0U4xWc8tTlJCPc5884ssSNyTjSYKGVluk6J5ePxmXK0k5c
         gGn4EPXFwLH4X68SYD4ikLmbdiChMoNkukStUvUJs1GH/N3tCHOpUMMIBLZ0jLcYVuQa
         hBOlaU7zlsUpORiiIEeu8axRQxGnRFZumsC+ZInwb+/+VhU2fSVQcMBWHUpwHplMjAxm
         zljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8C7yuYmjSdAo5W2EzOhPWT+j720zeYFg2XyfNLd1KOg=;
        b=wTLyAdnpDt7AbLG3N5C6u8PInOh62jcMGV3z6pyD0pMu0Mj7RJYo/mggqB2mSNaaKZ
         bFjxmIUDEp944HkTp4NNsml3WCUfFuWWrWNoBSjFU+DXpiEYBv8ke9Pm/rfj/LMK5+Ti
         /DGLy91bsxK9psv5lvhxuaLv41NOp/nGGwMhasAZUmcCk9UHWNkcOzB4qjDVMfApEgrJ
         3Z7uWeFEYlwGS0VMQaKsAlrYOIB+eqemDLnfXnA/vY+FRfBIemjdUttrJvNnJfZKtYsa
         Q/Tsbenm+CWV9GM5esRZwKqezO+4Jjr+6qaqivL5p3WnI1uKJUJ17vrBPpt48d+i9aCp
         EqGA==
X-Gm-Message-State: AFqh2kpqAVjRP23AAfPlimgzpe+YXV24tpgaMw97NDga4P1N8P5OHSge
        VlD97aYTYNU1kVTB+oGpGoRxnYR2jl1XnULj7LU=
X-Google-Smtp-Source: AMrXdXsq/s1ujv42tPpQzDqCgR5TlnTQGpzcwYfrUhM3Q9YvsPhmz/774Xcs5ZKzuEVesZWVQiyroPsQEMpWy7LB89w=
X-Received: by 2002:a62:3245:0:b0:554:7525:7acf with SMTP id
 y66-20020a623245000000b0055475257acfmr1621444pfy.44.1672240684057; Wed, 28
 Dec 2022 07:18:04 -0800 (PST)
MIME-Version: 1.0
Sender: bbchitex8@gmail.com
Received: by 2002:a05:7022:2508:b0:4b:c6ec:5836 with HTTP; Wed, 28 Dec 2022
 07:18:03 -0800 (PST)
From:   "Mr.Patrick Joseph" <mrpatrickj95@gmail.com>
Date:   Wed, 28 Dec 2022 07:18:03 -0800
X-Google-Sender-Auth: 5h-5rIdeTZJo8lpIYPYCB3tXYlw
Message-ID: <CABNUN+KSZ846E7F1G4kBtpmN0mUrfxyi79W_ywtVXTEOryrZww@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I sent you an email last few days. And I have been expecting your good
response because is a business deal will benefit both of us. I need
your urgent assistance in transferring the sum of $27.5 million
dollars and it will bring us together in no distance time i will like
to share it with you,if you're interested please reply to me
immediately so I will let you know the next steps to follow.

Thanks.
Mr.Patrick Joseph.
