Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1018A60D1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiJYQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiJYQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:51:22 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1AE83F21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:51:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 63so15361632ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=QS6Fd3UMs/Hb5i4wuG3+/X9rZrLl5SZZJSzhyq2LZ3xKmuLF5LBHInBdizX9fMIatp
         wqz6Cw9LjS4kWjcDwFArkGSZ6pg8mKWCL+8ViAW9hr+AvVEj0cRxuyRWPa7EYUMpXrwS
         FcyWtNQ5jexsaj3izhi2Yv+J0AmSiGtkN/6PkAsDf9Q2BWh9D6JsmfObfsv+SMdkcU+y
         huByOrSKVOoRbr8t1bwoSNpja+eL8ZOg/lzIz5AV0WghEFSFXsm6el38GkmQbjbAi+N2
         Oa2pJO+n6NtYpgLAtz+t7uIKm1LBaaFrik2JgeajIbqYj0uSO5oVwBqOL50qj6J+NNkV
         Hk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=uOdY3vArm6AgRcjdGLyg+7jQCpIaz6qT8/f8YpP9z19UKGQ0eKak4bIKC4NaSaDBy+
         25640apP7ed1q9M2pTFU3y2K7Cpx60xWgM0RMeuHPa7zugNqk7Rsvg3bYIORxu7QK6fF
         pk6MbuPeLAgDjfwMKHghPkANuSHzziomgPUVWunoZn+dr4IUNSdcGcJ8Qe5vGEuPRd0K
         ed5dDUe9FwGjII4ygrnH8kjB0k1mNYo8srVqV6T02MjAe8b+EJvXpGwpqTQV6lyQDfFJ
         RDWSTsdCeA+bo5jp2cUrdUOlyuuWHLIteSSV6PR6PJ3w0W1My3pow+K2yCr5v/KFLB5T
         Fy6g==
X-Gm-Message-State: ACrzQf20hat3B8UlEI9QPwRhUoFS11ZxgqHCfjnd2uSEEKBnHWllKcko
        G8GFVsGsNJwq9xpWACnq+Qd8VJRvawQBvFoGUE8=
X-Google-Smtp-Source: AMsMyM6M6SI7cft1FHRYWQ2Pr0J6Bz9jxUHqWXiytQvudlAKnPbgy6V/tB0roQHsiCwhj5mQailXcngFZStZzyzZsu0=
X-Received: by 2002:a25:2806:0:b0:6c3:b5e9:e0d6 with SMTP id
 o6-20020a252806000000b006c3b5e9e0d6mr35222369ybo.12.1666716681295; Tue, 25
 Oct 2022 09:51:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3484:b0:30e:e592:7b08 with HTTP; Tue, 25 Oct 2022
 09:51:20 -0700 (PDT)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <je078822@gmail.com>
Date:   Tue, 25 Oct 2022 09:51:20 -0700
Message-ID: <CAPmfv7VZxGqDug_tewtm08vnM8ffPrTdp346pXOXzq8eZ+8QNQ@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [je078822[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [subik7633[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [je078822[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
