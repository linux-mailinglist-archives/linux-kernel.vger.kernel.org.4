Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4876C72CB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjFLQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjFLQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:19:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A601AD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:19:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so32402575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586765; x=1689178765;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txGjIaM3LfmxDV9bWB1cnjV5M3E57yF3rztzp8u5Chw=;
        b=HEEoTfReGiVK6BF47EhzuB1yvvS8yOsyEbM4QrnJaObZiD7TBOJC6X2zkbCR3Nembk
         TdvsQ/os7w4Y25roJ9SA2ZmqKKMHIPan8zxY5n3AHab1IeTA+Rk+xd6APBil87+H/Dms
         LYEcuIusseAWww/xd0frHLG5Cezj29LzHkQu83cjsRvaTgA9vhxlNl92XOUylmGMjZ3i
         Zx2CsInZ7tu23ccjBEealwcDYg4zLIKb8gCJfAUKolVnBhIDP4XdZGbdpF2/SkWxhjL2
         wK0IhrL6gswKbdXl6r03BOUok/uLSs2S7t7dY1kGvqxj3m5XkFgnoUwGd93kHl1iYTd8
         O18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586765; x=1689178765;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txGjIaM3LfmxDV9bWB1cnjV5M3E57yF3rztzp8u5Chw=;
        b=K2sKVYW42681BDA7YcSlPJsvJ4OHVU4aSSi+eTldZJjA0ynS1M+khDFzs/fS597Qdj
         j3IbdS8nXM/rEGfKLeypPXHQOt5Yh4fizTLpxUfYpXvijzaH7L8aPwQilEJVKI4QN0JU
         aKQwmKjpvVrclWR4AOrITNulYqqDpuIuMPPO3gop7c9fDj8W7OLgez5FgSq3v+ARwfbi
         NeANVtUqx/6pSLk0gav+lWIkTj7rkuLnpgRLtNmHmcDinn0NomO7Q0ug3VfvpDrzWG3B
         ZFoulH75cAoMQiRfPz5u1kmEl2ECV5sGMabjwPd7zNf3/9vPG3KIkVlmSynX7seSJDyh
         AanA==
X-Gm-Message-State: AC+VfDz5VdqTPaC+2+ZY7CsjIGAJf1N+xvNv1tbFKQ2M4G5Fp3wKtpgh
        XZipTKJX9HdFprr1CQ+L3hfgODO5ToPzrc0dOkI=
X-Google-Smtp-Source: ACHHUZ6fMmwNGUiJoCjxY37FuXN+7gtjCnGL+OnbprzW7fsw8djl9DnzfyDsqITJ7qWd7qXyEUqsprxPxXovP2j8DD0=
X-Received: by 2002:a05:600c:aca:b0:3f6:787:4a84 with SMTP id
 c10-20020a05600c0aca00b003f607874a84mr5942508wmr.7.1686586764490; Mon, 12 Jun
 2023 09:19:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:161:b0:289:eff1:b7eb with HTTP; Mon, 12 Jun 2023
 09:19:23 -0700 (PDT)
Reply-To: werinammawussi@gmail.com
From:   Werinam Mawussi <christopher.mulei12@gmail.com>
Date:   Mon, 12 Jun 2023 18:19:23 +0200
Message-ID: <CADQsUqhixnY_f=00BrJBxDfxMeQwZ_oONOfuyQj0jMtad545nw@mail.gmail.com>
Subject: Important Notification
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [christopher.mulei12[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [christopher.mulei12[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am bringing this notice to your attention in respect of the death of
a client of mine that has the same surname as you and his fund valued
at $19.9M to be paid to you.contact me at werinammawussi@gmail.com for
more details.

Yours Sincerely,
Werinam Mawussi,
Attorney At Law.
