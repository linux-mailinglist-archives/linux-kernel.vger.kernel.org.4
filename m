Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75A6608391
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 04:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJVCYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 22:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJVCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 22:23:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157943ACD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 19:23:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id q19so12207607edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=hfZsdL2vP7Xu28lF47aeWVe/vgamwWaZCe/1uqgqy3H0EGek8pFNBfHdO5DA7nbIya
         W+v7QmEyTHt3yPZo/4+L74qLWgtM6AnBRdToh8x4C4X7rZIDDFxcBxqXbN97hsib9Yth
         KWH5hvh4lvI041i/nEoSj2RIDsZt5815BAN0RBr4ZUlv1m2cDIqUNVg/SNpXkaJfJiUn
         1MdYFoC6kKutiwoBWwMLeNWZO1NQQA820aG28GowaYKzgE2fcIw2eFMai3+CdkO216hZ
         YSCBrFRSeOzcubFOvcTIUT4Dkakj7jVYgRk451IhwIDWqkC0INTz8z6A0bG3xzKcB85i
         UBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=mVzfMEB0mAA4J2jluRgCzuUTsjI6qr+5iudi2rOuv6HNwLhlnTIn8mcqpD/rkHjoB1
         3LNwAppoR1AuDFXyIlaok4GLnZBMvxf+NjW4scxANkJao122ftvM18GXgzm3mUctI0W6
         9PFTvz6FMBxJwgeTrjuzs9XYwxyo6gVofM3vqVNp3TCXQialKlKa4kpjdNRcXxcT4OeO
         01WUDY2jQROqWTSO2SBrJ8bYO4+QYcf5fU7qQhS+cw2jQQVUaT0Nr14WZne28xzXyNH5
         r9MV9nABeVkz2xF/J+9InPSfPQAXoCuHOkDnSUIH3s5VQOPlri4xoxDmAPuSgamqNuN5
         Hldw==
X-Gm-Message-State: ACrzQf2IMSTaJ79t8lw3F99SEBmbjiOx68WD5PdkgDbtU1TmP4RAHHCQ
        85ZucNh2asYjkeO58v1TUYAfTpbmcVV0aYxAAh0=
X-Google-Smtp-Source: AMsMyM4IhFegn+zlO9nuB0odx4tuw2hQpOJIL9iiBnQ0yxZpQhNhNxawMyALsmBN/BYm4SyRlfIWaPosVurt3ItGRDM=
X-Received: by 2002:a17:907:7635:b0:78d:c5e9:3e57 with SMTP id
 jy21-20020a170907763500b0078dc5e93e57mr18414731ejc.204.1666405436035; Fri, 21
 Oct 2022 19:23:56 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsabibatuhafiza1@gmail.com
Received: by 2002:a17:906:4d4b:b0:78d:5018:c64a with HTTP; Fri, 21 Oct 2022
 19:23:55 -0700 (PDT)
From:   Hassan Abdul <mimihassan972@gmail.com>
Date:   Sat, 22 Oct 2022 03:23:55 +0100
X-Google-Sender-Auth: ny6iaeVciGcWxt2sGQ_M7iyZAeQ
Message-ID: <CABzhNW3sEF+Nu_YzuEzAB1CoNfWHLR6GeG2HPu1rmPC9DdDs8g@mail.gmail.com>
Subject: GOOD TO HEAR FROM YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad, and i was diagnosed with  cancer
about 2 years ago,before i go for my surgery i  have to do this by helping the
Less-privileged, with this fund so If you are interested to use the
sum of US17.3Million that is in  a Finance house) in  OUAGADOUGOU
BURKINA FASO to help them, kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
