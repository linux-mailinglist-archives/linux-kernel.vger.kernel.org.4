Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE16C5BBA78
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIQUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 16:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIQUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 16:52:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7292BB09
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:52:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h3so21274915lja.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=yHYbw2bx/nsQBLFF3gJlg+vRlUz37DtKoW4ftjnCRHI=;
        b=F9Yl9Rb1sN2NoY043+dcFsES0wSGA8iInyx5uWXE8N51DOd8Swq6RiXoADjjN/Wdzb
         0bPXitifZ381T4FCePqy6DtXjn4Fu653xP7gVVveg4AYS2o1Qiuqvr6iL6+wXjbm0UqF
         OPHO5mohjgp6vbW+upREeDYszsC2Qsor/PGBVPXGmz1ZnPE0mPoVSuxUzGfZFFnW/05f
         6neW1s6mDyCPojbIsQAUhGP7JwTkM8rHR8axyyTNwFcVd80WBB1U5bL2tKXzDaIEDve7
         J4zVxHrP9hiFnrHD+bMqbZYZEnO8O6Trp+7tOQaaHX70Xb29NQC3g0qbIKpSJ6eW1S/C
         U9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yHYbw2bx/nsQBLFF3gJlg+vRlUz37DtKoW4ftjnCRHI=;
        b=lVhtS8s3rmodPEABTBoWs09wWC6g8czQgTtfA96EvNueDEX7/HPe/lVbgKH8Kg1uYS
         ynkQLS0MtEZtcpyYnZteXpBtgmLe7Bh3jcATgF6tfR80ytCkllAybYEJ++M3ypkLRqK2
         PnT7/BCbztfALXyq7nDuqOMIXAITCNuk6eP6YZoiRBpTDslOeiPFkC8KI6PKBlQBBh5V
         Ha6aj7UmT/IUwOJG3SIQI0g5BWZYspYqwS1QmOZ6BgJhK8WAn958qGmDFNdGOfCvRkSq
         1N10QNfcGnBmDN8ZubIQeiUgmucSMKMYnKeIwaRgMkvnGYOqpE9EZF7dj1AdtAG7PUUz
         WhVw==
X-Gm-Message-State: ACrzQf36inAa/VsgWtm70nlM0x0szL9hzWIQRZJ0RcSUdx9BdBvGBapx
        OOTdZcAn63+5lMRI6IrHyFDkcAylU513h+lk1KU=
X-Google-Smtp-Source: AMsMyM620DHynBQKh1j5HEAnp8rqTiSOGMBB7FMNdJk+U2O9rBXELmmw6BEVwOGvkkfJ2ixbUg66TONId979x5XXtW0=
X-Received: by 2002:a2e:944c:0:b0:263:fe39:4a91 with SMTP id
 o12-20020a2e944c000000b00263fe394a91mr3212216ljh.311.1663447968480; Sat, 17
 Sep 2022 13:52:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:280e:0:0:0:0 with HTTP; Sat, 17 Sep 2022 13:52:47
 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracymedicinemed04@gmail.com>
Date:   Sat, 17 Sep 2022 20:52:47 +0000
Message-ID: <CACpKaVQHxJDYdyToWNyXm4r=GdTn77goRFAGFo+CNpYds1-EOQ@mail.gmail.com>
Subject: From Ava Smith From United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:236 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5026]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracymedicinemed04[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracymedicinemed04[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today
My name is Dr Ava Smith,Am English and French
I will share pictures and more details about me as soon as i hear from you
Thanks
Ava
