Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAEB683251
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAaQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAaQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:13:42 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D3534C22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:13:41 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-4b718cab0e4so209749427b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBehqiOlMw+UrzBXojniOFVntISnvzfXcFfUgXLZu3c=;
        b=KD5D9F4OtuT5hIbAoQtpOyYgpiA4TXzGJ/895WjSPh3dsmZfVaeZRiGnCR7DtQrPVm
         frhvd5IEBHp7QE2Eg/y48/CGILHJ3pmjBgTacd3rT7rCtyyGZhGOsfquHVv0gpgC4M3s
         Tat+pnTlhCk6kEAFYH+lCuPTir9TqKqZVBcR3/KCcwYO4Rn/0igN7Zal/qqI/QuEZJyH
         wVsvXGNUvmuuOWqoapoGyIBPh/FshDgkj9mBCFFWORUB/9dcVW1LQPJkfbBG0ro6R6qo
         HJrGp9EeTkotK/kYx9SzCIXwvGMzAAZikiSSAEDGPBTlnIedYqcVFjrJ0ksHIjR9qO8I
         rxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBehqiOlMw+UrzBXojniOFVntISnvzfXcFfUgXLZu3c=;
        b=eHwvAtUp7+AMWjUj8xhBe0XVM2HGwKhrVl3QMnmHUhXl0Hv96kvsaoZ+8BEioLQzEG
         Q5qJ4ul5uKZQ9AtCti1yDl2g3OILELduOWqa4GftaGU1TE0LKZ4eusOrsGUxLE4fB2cb
         D0wuvlZ5rB/9x5eiiPOoQ8LAy2t0FZaJWnqFrdxWJ0FvzmmbILFayf/6ijm1BZaceaSB
         e7AVqhJtMXOfi4qKtJoNmUqPEkokYZe2/ZCv1zFnO26yvV8d9ZXQ520w19teDCqAg7nI
         vjGYZRZxy6i4IRWNDQSIoIiFz4OXKG9lg1gCJGMmz/pY43yhX5/Y2JefkK3icGygnzxT
         +tOw==
X-Gm-Message-State: AO0yUKUV/hMR+LkylKSWBy9BqNCJ3fpLpyq6mOP/YMw6IAyL+4dfBmGu
        ZoWUbCotk1eE8Wtt6bnlmKgZ6slKkZptNw0JEuo=
X-Google-Smtp-Source: AK7set9YbfktrWv8qsSbECZK1uH+d7TzzbPyRLHwCtglBjRQA2fpsTuFaRwJKH+G7sIg3g1MblD0HsvRk6pcE2WcKa4=
X-Received: by 2002:a81:a185:0:b0:506:3758:890d with SMTP id
 y127-20020a81a185000000b005063758890dmr2605677ywg.10.1675181620283; Tue, 31
 Jan 2023 08:13:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:2986:b0:328:6c2b:31d0 with HTTP; Tue, 31 Jan 2023
 08:13:39 -0800 (PST)
Reply-To: telet@op.pl
From:   Mrs Biya Ahmed <ppro45908@gmail.com>
Date:   Tue, 31 Jan 2023 05:13:39 -1100
Message-ID: <CAJrADdAp_KVWaxKvh3G8uJPPj4n+o-BbkEiXP69R3g0P7dRMYQ@mail.gmail.com>
Subject: Not Spam !
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Concerning the Bit-coins promotion program held at Rood Woko by
foreign investors.
This e-mails : tiipar023@gmail.com,  won ( 55 Bit-Coins Prize) but the
owner is not aware, as I was sending notification letters to the
winners, i discovered this email has been disabled and no means to
reach the owner whereas BTC paying director agreed to pay the owner
the sum of US$970,000.00 cheque is already signed see attached file.

I just want you to play the rule of the owner of this email, so that
my bank will transfer attached cheque to your account,once you
receive, you will transfer $500,000.00 to my account, and keep
remaining $470.000.00 for your job well-done.

Once i receive your replay, I will give you the prize claim Agent
(contact) for you to inform him that you are the owner of the disabled
email,he will collect a payment ( Clearance Certificate ) in your name
and submit to our bank together with your receiving account for
instant payment.

Is true i don't know you in person, but i hope you will not make me
regret after the money comes into your account this is my fear.

Reply once after reading claims has deadline.

Best Regard
Mrs Biya Ahmed.
Commercial Bank Of Burkina Faso.
Reply Email: BTCS@secretary.net
