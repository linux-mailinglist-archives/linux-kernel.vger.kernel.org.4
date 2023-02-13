Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF4694378
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBMKvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:51:20 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656A94224
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:51:19 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id j5so5855849qvi.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676285478;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbmEomTaEbL/xC6kHsB9GRdSNVZ6oy/K3P7XpBsOsQw=;
        b=Qfe34OpPJdqTxxheZAVWzG8hWYbDS7zTDrM618tSIUis2UcJnDYkkChsVhZvEIZzuW
         qKY/x4i+Z92+RZAWyfefxOppIk7v8myMg1XmGgtRXVsxjyXKSGg1yN0+2KUmhbfAzfFU
         O1iBAkH+LAfEpI6qa0XJbG2j6/gx5RZmn3BQazHSV29XjAFQHh7uah8TzWi1vF5lCBzi
         3Svf4GePsL9xDFrix2gTpfdZ4KlO35MumO2xQC6ExNr1l0lPiLmBP1alVKXJR6/737hd
         cbSgfAWx40buLC+Q1zIWwhKQ8A3uy99gzKJ8fSURqs2sFj2wj/4oWc5NU0Y+0vTEg6AW
         j/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676285478;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbmEomTaEbL/xC6kHsB9GRdSNVZ6oy/K3P7XpBsOsQw=;
        b=Rnq+QA5cllIoo8MAteLxSkydBrXqtWAhWLT1FEctUORax6KM6kTSoxA8NtgVrDY46+
         sdIfNzGbTlVA5MIf9TdRHpm7gIMZSuvCsQpWs38HHX1jWmVkBNdpFBdk450H3LYLg3BM
         j2Pc1V8QIDF7npHvL8Dd8MIZuMDg1BWEOuFaoXGZcOL7+EgXtQtXkwnK1qNPTs/T0PaV
         0MzXs7Dv+V7oy+haVdrN3bDJLxwm400/778tc5PuayHQzKt56RFeHKPSja02oRhd0h6J
         lx1dp87Ow1VEGW4Rpl6UjrePSDDWnQlOIJ+XbpTN6/nTAXz+EQBgAzbpJZEEfdBq1xIA
         MjKw==
X-Gm-Message-State: AO0yUKUZpxTYwuexGlmt5fCKM2S92u78eor5QRZPMIzDUaLb6/znzQRb
        I5xsPOejqxhxrtIhQngV1BXD4c0PYO8Nv6SVqHk=
X-Google-Smtp-Source: AK7set9SReYJqmMdKTDQFgJEcWjeR1sx/YfgC5s6Ww86yAmuCIS58tUOaZABW7mWYblo8kSArbUvZZav8S6TxWH2xzs=
X-Received: by 2002:a0c:cb8f:0:b0:56e:a7f9:2e2a with SMTP id
 p15-20020a0ccb8f000000b0056ea7f92e2amr270269qvk.80.1676285478540; Mon, 13 Feb
 2023 02:51:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:e6ea:0:b0:56c:2207:1ed4 with HTTP; Mon, 13 Feb 2023
 02:51:17 -0800 (PST)
Reply-To: ahesterann@gmail.com
From:   Ann Hester <viktormyasn54@gmail.com>
Date:   Mon, 13 Feb 2023 02:51:17 -0800
Message-ID: <CAH5q5bsC=etNj-ZsUQcF7ZHs3LLXX+qMyRmDnBRzh8m5nkxzzg@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello ,

I am Ann Hester from Germany but working with a non governmental
organization here in Lome Togo which am one of the founders.

Please i have a proposal I would  like  to offer you that will benefit
u hugely, if you are interested, kindly get back to me for more
extensive conversation.

 Thanks for your cooperation as I await a response from you.
