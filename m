Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4597F5B3765
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIIMQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiIIMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:16:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2ED1485B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:13:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d189so2325877ybh.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=SbqGZ41/heDOlkBsUBLVx+zaVQBFoaHFYxB4cUuv1cC39cHBgtFasnqwwJeIrPEhMH
         vBIxJwqJbzlgQgFRZVZOR0ogjZpTev1oaCZzVFJlcjdXkLRpraE1B5bbVa0turumx7F2
         9SiTTWhup9bB0KovlFBIG1kxszwTks49ONlSsGmcxuk/ZZNTiMP4dO1gg8XKKWeB+KOw
         dL+zT6cjWmxpzYKNWCHeUsYlzFRj5iKFxPlLYOd4Frkk+kMjagTZVFTBsYK51vbaIUoR
         GES5bYkNeF7+ErClCK4Q9QKeSxf3cICaHw/8DOLBN/jd2Rx6+Uu+7mkEBgFpDkwKAfIt
         RBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=msd65pUeU3+Bc5TjMUyrhaOB5uT6fMmSOpfkg8bKQPdlrvy9ziER7dSCewLFN+5ub0
         Ozb1zy4GkQDJO9mBtufssrD2/fWZogc/9Xs0+XJ4xAR8xyPEj8iBP7t5CSLvVnbNp9Jl
         8SWySPFYHNaitR1PUdDNYX7w/gk6FGxRIeVUhbFa2G16ljhKp6Vq41jgsVQyNILOMtPh
         2ytzVqYiFxY+TO8a9tsK/iKhVzk7FUxCoq5Am4wEI8qN8Y+lh9HwdYxpDcI2HEiClXzy
         QftyM6Mtr9GSMRkf/TPbH1Ub5GVxZnAnktb4buzu+HYeS8ByfVx34vQTr8izmcMqq3bl
         ai3Q==
X-Gm-Message-State: ACgBeo3Pumg6zhPnEU+YLAFmeI2D0UalUZq9KOH57jgNrlUTmz9knKmH
        rOreuXwTxcdP3AYORTK80tqyFBbjgEn3bXZXeG8=
X-Google-Smtp-Source: AA6agR6nE9ZGAOzZpZOiDWZwapswitbjiPgDD0+c2qgRRJRbEmYpQA5ruBL4Gym+6OXe6eLZx7EwEwQTgbtHo4QsdY4=
X-Received: by 2002:a25:e68c:0:b0:6a8:f979:60f3 with SMTP id
 d134-20020a25e68c000000b006a8f97960f3mr11239973ybh.28.1662725571503; Fri, 09
 Sep 2022 05:12:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:554e:0:0:0:0 with HTTP; Fri, 9 Sep 2022 05:12:51
 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   Dodo Blez <dodoblez0@gmail.com>
Date:   Fri, 9 Sep 2022 12:12:51 +0000
Message-ID: <CANMXh-wTng_CKvS2VAtb12cAVxvKmYTvtb0t9+T3TfQ26a0PXA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2b listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6211]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dodoblez0[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dodoblez0[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
