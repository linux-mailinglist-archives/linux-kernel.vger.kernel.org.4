Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07762667B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiKLCdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiKLCdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:33:49 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED7391E8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:33:49 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so3769928otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPQVaKRFdMsCfoyzRXnle/rJ0HMbMVb+ESr80LlYIUU=;
        b=oK7gvHwkOZ6n5+mIYnFFOy7u0HKky0zld/7KO909pNnUFrV3RHSU2ApMRTs/pAzqtW
         4cqR0lYxRwg0NybX0K3QWvrYPrEstdzHXtXzg0ZcubP+7VrxQgfKU4/51ozrNOQZoUPL
         lq9el/lH8n5nxfr3j0zuD6vZ31krmVTNo5qjIyLg4R6L2AsthCphJdp3VrTpJjL4O1fH
         Nu/F0JIXERoB8d9O0dE3TF3vMXz2734Yjp8UFCtiE+g4xA9Gmt+RaPXhbYn/6tDT7yLD
         WGqbqeePmfV57+u9mzuIQOocplpOYpFjlXAT6lLiqCVSCT/QhgGkTDv+CtF5moMSarVu
         QnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPQVaKRFdMsCfoyzRXnle/rJ0HMbMVb+ESr80LlYIUU=;
        b=n+gU62g2MkJDJE7pmC2Bp8wGBhv5FzEGzLVYHkkalvTbXbiQ4XQbTA/IIZCy2UmZ3r
         g1dPH9e7YtyTPtLYcuWgEP6+5mj5BYo2S6dbWthfwBrGdry1y/+ceXXA5wmAvKLEvEMZ
         5K7mBbYERS9yrF/sw0/wlSKXLKLo6UfplfyU7tw/mneSNiDLNjxYLWO44BpZ2it75EZy
         fUKbst+Ot225JQZUJdjfMA0XMcIKgczWBVViGM0BrS5gLK68/RbU6HSeB3SG2FmlGlc4
         h5SPOMiYyoVbco9Hk/vpjri82p8T0qR8xaTLYCYM3GrkUlJd1E/0XRuxZsaHnOaGFrdh
         HmiQ==
X-Gm-Message-State: ANoB5pkIpB6IbhqmeoFEsun0p5fVbNRlsDoWHNcpLbrKjr1bqAVsY5is
        6CS5cn+D7McLVZfwCBzn+yJ2IGjrfTb4xhG/Z0A=
X-Google-Smtp-Source: AA0mqf74MQs5nuou8Rogw6TYMZ8VY5OjX71AMxXPynP7MQgDo3WFP+pAZ74dsrtIF99UbZNAHaXGF28ub9Jw/7X6U9c=
X-Received: by 2002:a05:6830:278b:b0:66c:3ca7:1e4f with SMTP id
 x11-20020a056830278b00b0066c3ca71e4fmr2613189otu.322.1668220428232; Fri, 11
 Nov 2022 18:33:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6841:90:b0:f5d:7618:2a7d with HTTP; Fri, 11 Nov 2022
 18:33:47 -0800 (PST)
From:   carol penny <carolpenny522@gmail.com>
Date:   Sat, 12 Nov 2022 02:33:47 +0000
Message-ID: <CAAPPb8R6F3qYARkZ-7gVTrY=kXXx3nT8v1vqEwOfWwXPJXkAJA@mail.gmail.com>
Subject: lexxihubbell@yahoo.com, leyvaconstructioncopany@gmail.com,
 lfairliejq@bizjournals.com, lfarnorth9r@flavors.me, lfasey9q@desdev.cn,
 lfcgermantown@yahoo.com, lfekede@yahoo.com, lfinlan9m@sfgate.com,
 lfitzgerald7@msn.com, lfkorea@hanmail.net, lflamarique@unav.es,
 lforsardi1@mit.edu, lfosmoen@uca.org, lfuson85@yahoo.com, lgforestry98@gmail.com,
 lghioneke@sciencedaily.com, lgmontessori@gmail.com, lgolubeva@nfil.net,
 lgoodricke6l@earthlink.net, lgtexaspride@yahoo.com, lgw012@naver.com,
 lgy5494@gmail.com, lhaestier6x@list-manage.com, lhallum_hse@yahoo.com,
 lharris@dot.nv.gov, lharrisstudio@gmail.com, lhaugendq@hubpages.com,
 lhearon@oeswd.com, lhertz2@schools.nyc.gov, lhk147@hanmail.net,
 lhogan66@gmail.com, lhr@skyventures.co.kr, lhs99601841@hanmail.net,
 lhyca4u@hotmail.com, lhyfasecretary@outlook.com, li815@naver.com,
 li_qing_0905@163.com, libbyslavin@hotmail.com, liberatedhomescholars@gmail.com,
 libertyslight2@gmail.com, librarian@fultonlibrary.org, libraryrich@yahoo.com, librarysquare201@
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:342 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [carolpenny522[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [carolpenny522[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20


--=20
--=20
--
My name is Mrs Lovelyn Raya  from Indonesia
,
I know that this message might come to you as a surprise because we
don't know each other nor have we ever met before but accept it with
an open and positive mind. I have a Very important request that made
me to contact you; I was diagnosed with ovarian cancer disease which
doctors have confirmed and announced to me that i have just few days
to leave, Now that I=E2=80=99m ending the race like this, without any famil=
y
members and no child, I just came across your email contact from my
personal search.

I=E2=80=99m a business woman from Indonesia dealing with gold exportation h=
ere
in the Republic of Burkina Faso. I have decided to hand over the sum
of ($10.5 Million Dollar) in my account to you for the help of
orphanage homes/the needy once in your location to fulfill my wish on
earth. But before handing over my data=E2=80=99s to you, kindly assure me t=
hat
you will take only 50% of the money and share the rest to orphanage
homes/the needy once in your country, Return to enable me forward to
you the bank contact details now that I have access to Internet in the
hospital to enable you contact the bank, always check your email
always remember me for doing good.

Your early response will be appreciated.

Yours Faithfully,
Mrs Lovelyn Raya
