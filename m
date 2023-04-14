Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625506E21BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDNLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDNLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:08:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90680468D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q191so16410151pgq.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470484; x=1684062484;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2wfI2E+jV194FHBMWMS+0xMan6iTsY8bMkxOTpZtNA=;
        b=g6S2XrRuOAQuvDLYj/jHkWIxHdfodiZTRVRBnc+5DuliHaNeMzA8P6BW1aQZd8d94q
         WNwtSaXqp/l7TQakpRKL/bok+IaAwZtae9jW/6DXhhg6ZSA+RTk0LpDruS7X2J20w1sw
         s3lzKZ7XikjRLQRW8p/3pHmAXgUsf0ExZrhy0v5ZASZXXAUxbG/1L0GlrD4oi8wCStCC
         BBJrrhiywCgI0qCLtnHWNOzMFsgdQiCgFZhYeonJ0Y917zbMW7uvIPQ8m7xLHuPU8LyV
         +C4PRVqvFTBenEtBCdN/ug1vyTyWTAuEecI7tjxH/XoTKJZWJjyBJPN6qhwYWcy+osWj
         tDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470484; x=1684062484;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2wfI2E+jV194FHBMWMS+0xMan6iTsY8bMkxOTpZtNA=;
        b=dAxiNyyTGsj7ileOc0EFRoDIL5l6nxe2R0l4NdHHh2t7GRr7XbNKoXyq5iUN5VYKhd
         cderP4740w+DN+Ky/Oq4ZS0m61TEQmn/luwI7lAk5D6p8FyqQhrvmXfDQ07Mf2af7b3x
         R5Ec0xoj/TufoaI3bz/BGk9e4yO/kfjLRgZbltlJaxU6coGb7zcEN8VaY711mlvC4FTD
         8HNO0lxM2J+ynuSc/N+WVqMHtxusWdnEAT9RnFJNSl5yTfKAHv/zMEgpPLaLdyNNi6CP
         C3hnFvm4VGBkk+PciB8FdjmLvXBWnDdt/jZnA9ALAhUiwN6YkKn22yeQL524WbEHuDC1
         kOZA==
X-Gm-Message-State: AAQBX9fVcWUR6XOFSGLyg9SVYXSNsSJLFHwb8oB4rDN/JzWe63PKxwKu
        2VrGgucp8Vn06WVhveOtj15jL/D64DHJX0Nf+Mo=
X-Google-Smtp-Source: AKy350YojJaKJVwtbpcRMAlKVum5WUazSwYMJa+RRMWNR8fG/nVYb5GI+29ERxijEGScAALkMwZ5JZdNHj+AxpeJXjc=
X-Received: by 2002:a65:6a51:0:b0:503:4a2c:5f0 with SMTP id
 o17-20020a656a51000000b005034a2c05f0mr632062pgu.9.1681470484033; Fri, 14 Apr
 2023 04:08:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e252:b0:48d:5e44:76f3 with HTTP; Fri, 14 Apr 2023
 04:08:03 -0700 (PDT)
From:   Charlene Brown <41baillet@gmail.com>
Date:   Fri, 14 Apr 2023 11:08:03 +0000
Message-ID: <CAL9MPfE46y2jOemBt69LhZSTGLcCuBFFdLH=8fgcxi71eH6Q-w@mail.gmail.com>
Subject: urgent
To:     41baillet <41baillet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know this message may come to you as a surprise. Nevertheless I
humbly ask you to give me your attention and hear me as
I have chosen to reach you through the internet because it still
remains the fastest medium of communication  after going
through your profile in search of an honest and responsible person.
My name is Charlene Brown an aging widow suffering from a long time
illness and I am currently bedbound  and admitted in a private
hospital here.I have some funds I inherited from my late loving
husband in  the sum of US$ 14,530,000 which i  deposited in the bank.
I am looking for a honest and God fearing person that can use these
funds for Charity work, and a percentage of this funds will be
allocated  for your compensation for handling this  project

Please let me know if you are able to do this work so that I will give
you more detail how the project could be done

Sincerely,

Charlene
