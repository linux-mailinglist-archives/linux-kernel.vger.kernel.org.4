Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D76A6E3023
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDOJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDOJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:36:39 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628E9F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:36:38 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id o2so13813198uao.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681551397; x=1684143397;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BiujCrEYMVc01sjyYR/IK2lUGjS0rXrsM+QXLbiX+Y=;
        b=E1PXSBd7/ijb2/xcaBQPLscLXx9WhZDThTstF06oy1Cs8VM7W12oYn2AEBixkoc54v
         BGXCEXfgOr2ifYDsGwDD54ehbXxmdMN1o577Tf2shDo5i2jDM7g/Hs6wEnhgLKnQkM4V
         dax1Yp05F7naojnKl6aVRKXNR2KKxmxKZQ6q/z9fnNDlkyO8FlZkqurZrr5QqVL5CbiO
         S5Y13obqNtRnIp62geSiVKzFbD5LiGkmqZ01m7t4gIE76vJfoczA2yY0ddJim6Xu1gJm
         nvHAcKgXPDEggXiAZImZymTFpaCJWVqKL0vZdM7tm3ySBreVFkMRPS4fH/qC/xU/Yvyg
         GUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681551397; x=1684143397;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BiujCrEYMVc01sjyYR/IK2lUGjS0rXrsM+QXLbiX+Y=;
        b=NQp2txJeAkRI0sgFt4pnnILySFbGabukLIMf+sCx+c7g7ESmovYvKaPjJOr8tsEj6v
         +qlb/+OnfEr+8W++JKgdcOnv6Vb7XHsLi9M3A5GgLxZBWFsA8gXZCR6aIeAvbdj6/46X
         0hhn+UvIVyotBI18jZtlVgBgSiFTSfOy1sqEbUfvmtSGO4qn7LMHaK9sl4Xe9jet2YV/
         IQmagCK7jRA9i4/bGKnArSdFSH5+6InJwgXR0/DeaU8f4QVBizkj0Fzf6I4Kmo5HmNdA
         tTeJLNpwxg556sEAyVK6oP3eoJXeEKodK4/er7YzGSXM966vmRh6ZSAzrqznWq6s4z1W
         03bw==
X-Gm-Message-State: AAQBX9d8OGE+MH3Y97BXqa3jeXjlkfYmBY8RVjfL6f/rukXXvaFSYD1U
        gi9+VDqczhjxUdiobg39gTeVrKeA02txSfCjgO0=
X-Google-Smtp-Source: AKy350a9kxhtQ1JfDYYZ5gtiZ9aylLLuJTfiMLnO1MxpVmTW2/vd7MQ5pwxsmTZxwH4BqdXqQeN0hprB4Md3cmnk9os=
X-Received: by 2002:a1f:1ec9:0:b0:440:892d:cfe4 with SMTP id
 e192-20020a1f1ec9000000b00440892dcfe4mr2184485vke.2.1681551397359; Sat, 15
 Apr 2023 02:36:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2505:0:b0:771:e87d:ef0d with HTTP; Sat, 15 Apr 2023
 02:36:36 -0700 (PDT)
Reply-To: paulsonjessca399@gmail.com
From:   Jessica Paulson <desmonderic.johnson@gmail.com>
Date:   Sat, 15 Apr 2023 09:36:36 +0000
Message-ID: <CANnXifv7t2ePbhs=H8u-ngLL4h2xVfz4LW4P06Dm5Lad6gaG6w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm Jessica, from the United States, I went to share ideas.
