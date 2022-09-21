Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E75BFE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIUMzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIUMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:55:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9C5D0EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:55:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s6so9049582lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=EXA4F3p30nEaqGYROy3yOPrseSGy+qOozb7BeUALkVM=;
        b=omC4XcT29feYNjcxfz27EcryKYY2z/cDfe+sNcKmKUZYqFhuMgd7Ne+es9pQyV+ZhK
         MsKiVg6WBe+fm0DPGMOZOyDbHXMSirUc6XJ/yYgulUpSVdv7STKoLvG4xl7o1/vFBflu
         VEOJgXcLjxz6JtDzKSXlgtQkKNWm4/AWP5NupWFPfYqmLMn3brfZAA2kUKcSj5xgGuXf
         LIObSAgSu8fI+TSuVozxtEQpZeKBofNjYBX97iNhxE42Ss2+oTVry4HUENhIfFWGeT4T
         KcKB/brYjAgP6xfR7AoCvMNLbG8QWdGwnjYclowND3RR1QeAsMQhQuks6KdJP0e5TseH
         OBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EXA4F3p30nEaqGYROy3yOPrseSGy+qOozb7BeUALkVM=;
        b=dGf3w3Ikx9YYLN2fIsNHdR2qKHv1AIAZEqhI8DXrV7Jx9Aczv7v5wXgXqE4Gnf4fls
         qij2anQUp8ZHuZ+pQbjX2IGzqzPADX4tBISlJRM9cK/m+3nZ1fWC4zXtohrvVQIYzr/u
         hTkwx90Hp3y+oinjdy/3zkUJkL4Ndk7EVgmvwY9yZf+7XiR/wyUOQrURM1blnOGpNQrG
         YnzoRW01gSWVyX2u1+nqxvwSTjgMM3WV5umbLn74PsZ7g1lpv12erlxkOnUx9Ie/tdwR
         gf5KSuUuA6A6wwdCj4tpUUdLG9QdbNLHh7uUYPTlKt40SUd4UbGhHnQ/rN1sw4IS/HMA
         r3/A==
X-Gm-Message-State: ACrzQf0zr+RkQRnCJzzq8NLoDSdmH/sRFtDNeDyt7viUVCHbAmuX3j1F
        HORtjw67AJTTFIp41N+4+gHnyYTIgRvugvQTryc=
X-Google-Smtp-Source: AMsMyM6tlDFjGksgKumkFNPMe7nhfI1D61Znnoz91A3AcUBaV6BlNMfV8Yqe6IYadYnFQPlXB6iBHXXtOPD+kaA77OY=
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id
 i3-20020a056512318300b00498fa2935femr9888260lfe.523.1663764917331; Wed, 21
 Sep 2022 05:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:da48:0:b0:21e:5fac:d54a with HTTP; Wed, 21 Sep 2022
 05:55:16 -0700 (PDT)
Reply-To: mglt777779@gmail.com
From:   Maria Gilbert <eikon715@gmail.com>
Date:   Wed, 21 Sep 2022 14:55:16 +0200
Message-ID: <CAJBcqof+f2ynRgAGtY1RWgDauYiBqUJxeHKRx7+XXFAUhq_-7g@mail.gmail.com>
Subject: cher
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [eikon715[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mglt777779[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [eikon715[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

7Lmc7JWg7ZWY64qUIOyduOyCrCwNCuyggOuKlCDsmIHqta3snZggTWFyeSBHaWxiZXJ0IOu2gOyd
uOyeheuLiOuLpC4g7KCA64qUIDYw7IS47J6F64uI64ukLiDrgpjripQg64u57Iug6rO8IOqzteyc
oO2VmOqzoCDsi7bsnYAg6rOE7JW97J2EIOychO2VtCDri7nsi6Dsl5Dqsowg7Jew65297ZWp64uI
64ukLg0K6rOg66eZ7Iq164uI64ukDQrrqZTrpqwg6ri467KE7Yq4IOu2gOyduA0K
