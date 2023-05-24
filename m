Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988AE710120
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjEXWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjEXWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:47:53 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21D90
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:47:52 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-783ec566cb9so105242241.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684968471; x=1687560471;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMa20DRTZSpdgpwCs9juShVIUPKIhPaDT7vhd/uJb7g=;
        b=exh14s8BBdfkEwj/1SPJCpqCYjoAAq2ZgSFr76VUtxwetk5je/gwmnuZ2uHLwovMog
         xtHxdXBGOywImqq63zVbv6Cx+bk3MfKFFXmNNT8qZNpSSMLfbaCnQFk7gVEAXv8vsDgq
         XOgEbUgfnj/Qm9wbJCLAIeB5lMA87agSsY99U1JrW58amvmjVO/RFV/eGwDogSLG8bDm
         IPor4ASG4fTb5jtyAqKJPUUe3tLZ2BhxzTQA9jSXC50pmx4pj4qKZuk8Q28h0+9M70b1
         mugn40bqiW+kZe4biPgFCfEUEgDprI9ar+XfyqZ4dE9ZiLqlGXn+Ye/1a1cjM+tVT9Ht
         lWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968471; x=1687560471;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMa20DRTZSpdgpwCs9juShVIUPKIhPaDT7vhd/uJb7g=;
        b=TwQ+fEOzmycDG46uVHbv2NOjnw0alwD8z8QYFQUskMCZzQ9/P3N0tANgrOPqWD90Pb
         97VSMdyT4Spk6l/XizixOfDxl2gQSC3iHH5iAGlYkYa9mBQrufMHYrZbaJzYYewgFhKr
         jjColWNf5xH3SyzZcYK0FPmC2rPzGCtkp1/mHlr20dHO6/QRcNVJrydbtISpnrs9H3cA
         xs4r78YA5myYVZi9voq+5n1iN/M3vAlJIwJWfnNh6B6W9X/N5c1i3IoYWVBVbbhTS5d2
         KtqrxSDC67n6Kykso3UNsZZngYBrxyz5ooU38sCey37Pz2jQ2glXYzsZFhf4iMnO2I40
         c/0g==
X-Gm-Message-State: AC+VfDwsuFRgrOEzfbSs8OGbH80Rv1ahHMV+4dcXsaHLbNuxjwtt0RXc
        kYHz11BlycPSIq676+LPLeuVb3GYnXO9J2aJaac=
X-Google-Smtp-Source: ACHHUZ5yiGWhFrrfU7rg36Dm0//eBNi5wTI1mVnxPPgd603ZokKxAPeIbf3uwxR8Xan3GBFQBU2ebBQQy7BaeqX1X5o=
X-Received: by 2002:a67:db8f:0:b0:439:3b69:3960 with SMTP id
 f15-20020a67db8f000000b004393b693960mr4962691vsk.26.1684968471505; Wed, 24
 May 2023 15:47:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:9e44:0:b0:3d9:c273:7f18 with HTTP; Wed, 24 May 2023
 15:47:50 -0700 (PDT)
Reply-To: peacemaurice47@gmail.com
From:   Peace Maurice <barristermedludwig@gmail.com>
Date:   Wed, 24 May 2023 22:47:50 +0000
Message-ID: <CAGcFVo5vP4QK9-_R8xGqxQtTAAHp1p03G6eXa1nks1iTaJ5iCA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

I wrote to you before, but you didn't respond to me.

Regards
Peace Maurice
