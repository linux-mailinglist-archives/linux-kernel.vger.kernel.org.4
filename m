Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049260F466
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiJ0KES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiJ0KEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:04:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C772626
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:04:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g62so977070pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCJsXsDD/iNK9yC84Ot8gXJYydwvdgJYruOO+RMKvrI=;
        b=IyrVMz92jip4PMonTr52b+smIxDZtyC+jl2Fxgs8KxTmvLF935GCCZHcEWj17QiC1e
         1u3wAxdnyABTQJqHkX5IDmompZX3ztHW3cb4XZfdmZ0JfrJSW3W35dueMvN81RMM6kSD
         iZ1tiGkfBGaeqJ3DbBav55YnPmQCFw9n9MEbsyuVUeA1Q3+Di58bGKFdMBt1nG4d4F6s
         06bGZFd+E+GsMLv3KvFiVmsIe6oqjyjNkjy3nfxrLZ9ciqhsYw9juzgqaZ+PvaGu5a1E
         BOCVfEr2kCoakF3DTZ7fVhJf7P4hWsvIvGQrcDrTkbZ6Wp+NhjkfP4AgbqmNPsIKF6kX
         QySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCJsXsDD/iNK9yC84Ot8gXJYydwvdgJYruOO+RMKvrI=;
        b=Rv3Kq6RH3OFWrtq6HYYdwGTg1jey8kO7kQ9TsFg8/93f4MYcR3mwJBaKxpy2vE9AWz
         OOrfkNHgLLptxnBxM9d1LD7qUow63ZnXHQstCet43/awQAOf6YmUMaQ0vA3PGjEGDs2r
         x9OqkI1NSK5+pisPNw88cNM0cyQ7fSMtWz+zTdpHvjhXKZ726GLQIYzYShNy+tfPRwNf
         lOacf8RtPSi5BiOmZ9/hWIbI5LhgBdF8K9q8Ivzx+DBt0P7nx31sIcn9mUZSqv+s6yzQ
         4UYlMx+LlDiYaxMSe4mqDpqt7UTn6nuP4bTG/ZPaelsbJjFnTTuOxc/FlgyPj2+2rtHE
         xmoA==
X-Gm-Message-State: ACrzQf0JJ8soBoR7SNH4G/yl6byUfJERmkI0JpARQ/WwBc0RB6VLtB/W
        XNAzrbDI18Yw1P/Ukru/YYTw5AyKELNOgXuAxfguJxgbFHxj
X-Google-Smtp-Source: AMsMyM64H/VWxHBzlL2Ih/305yNWlkiHOvkczG7qgPWw5+O4njkq1tzsdztKx8BaUh9xx78kAMjvLsu/tTxbLfIo3Wk=
X-Received: by 2002:a65:40c8:0:b0:434:dfee:8dc1 with SMTP id
 u8-20020a6540c8000000b00434dfee8dc1mr42628432pgp.156.1666864670118; Thu, 27
 Oct 2022 02:57:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:e17:b0:46:176b:fc65 with HTTP; Thu, 27 Oct 2022
 02:57:49 -0700 (PDT)
Reply-To: abdwabbom447@gmail.com
From:   Maddah Hussain <maddahabdwabbo4@gmail.com>
Date:   Thu, 27 Oct 2022 10:57:49 +0100
Message-ID: <CALPsib6DUEX6GgoVyKQgN5BLB87jmCnMW7J=7RY+UwmrdPNeUQ@mail.gmail.com>
Subject: Get Back to me (URGENT)
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

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.

Maddah Hussain
