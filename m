Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0FE6F47D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjEBP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjEBP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:57:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA63172B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:57:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso4825959e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683043069; x=1685635069;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIZuQ3lut4F883OH3UXUtitmDLI76P6X0KTNMffGI6s=;
        b=DzfprTe8pSKkbKsJpmjoM23RMz/EA37+J7jHRmitiJnz9FyBE/XA7P+d3y9jQi2m7D
         xX6hBRYvJ2U/OxWgEudbzT/BtMlt9Kt1w7q8NwLhpnnkG44cJSgaV2XBNTgKOxN4jILT
         1kg9zv/6OZvtjC+myAVn+sOSyeIEY8SJHN6AFcpShWe0/fM4tZyPuolOTsl5JM9glgWK
         2kr2TI/ZSNi+URPuU703YVBRORGw1CMObe7px3Xh81HjdGhFBP8kolxR41TljFc5JNUR
         HSfucWHXGrAQi7bMb4aeMl0rOYXHnXQuum7FI/XRIo/WJIAB0YDO6fZ1F8o4D6Ty1Fon
         PYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683043069; x=1685635069;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIZuQ3lut4F883OH3UXUtitmDLI76P6X0KTNMffGI6s=;
        b=bV02Ol3dAQ9ntiMBhnfi7Jf8YA2tE8YZiLi/EA2R8mN5JvNZQudUpuqlU61vbyoF0U
         ikY0aMN5O41mOOYSaXnS5umMIVFV+6IFRxBTxLuXVE/tiPzFYEkeQJRm9cGmeP9w4vpH
         gt3hwSmKeWXz0CeT2/rdX/Eh51+YOdBS/6H/5ersha3y/QRn2L680muPgTkIHS3o3q6T
         ZRmIIk0RM+iejHZ8U8+o/S2zXjX+NwNzImIRUuDIrukcZp74khPp/Li88e5nbsCBesdd
         sKuoKk8m7I1LA7KzRh4xqW1shiNnVTf9UDAmtA18fnuOLEIUFu7w8U99mzBWqzwO9EDT
         NWpQ==
X-Gm-Message-State: AC+VfDxpz3yhC/7pWX3jhmXydcvNqCgMwZdTtFgOiEn2G3xlKMuGaFj9
        q3x8e6MuL3lN9QusNpFXtiTgTEaFYpZWgxtPF8c=
X-Google-Smtp-Source: ACHHUZ72tg3n8gW3cElviKZD4qHPtXdsAyuPlpsH1OFme7j5mDYCzqxS0UTLSB2lU1DbwH1pVG2KRtwAK9RSiupjxdk=
X-Received: by 2002:a05:6512:983:b0:4eb:30f9:eed7 with SMTP id
 w3-20020a056512098300b004eb30f9eed7mr132389lft.22.1683043069081; Tue, 02 May
 2023 08:57:49 -0700 (PDT)
MIME-Version: 1.0
Sender: aishaqadffi52@gmail.com
Received: by 2002:a05:6022:7427:b0:3c:722b:26a9 with HTTP; Tue, 2 May 2023
 08:57:48 -0700 (PDT)
From:   Aisha Al-Qaddafi <aishaqadafi77@gmail.com>
Date:   Tue, 2 May 2023 08:57:48 -0700
X-Google-Sender-Auth: mqVZdkrh067x3nRV1tVmzxuokvk
Message-ID: <CAAMpE7yajfvjHYrHpRzGkQKG4XgKRtBiUbUfEcNxwz1ej7j3JQ@mail.gmail.com>
Subject: I need your help to invest in your country
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishaqadafi77[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aishaqadffi52[at]gmail.com]
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re: Hello;

Greetings to you.
My Dear. How are you doing Today, This is my second Message to you but
No respond, Why?

Please reply back urgently so that i will know if we can proceed with
the transfer, the total fund is $27.5 Million United State Dollars.

I am expecting to hear from you
Yours faithfully,
Mrs. Aisha Gaddafi
