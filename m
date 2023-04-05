Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4016D8939
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjDEVHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDEVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:07:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C866A40
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:06:41 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bs13so12345749qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680728800;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+ZUuxUTAoz+nMDIAxIHUE5qjUM6hZWQNbOQhvaBX2U=;
        b=AMc5NfOv9v82VkAhSjELS62GmJAkVTv0TZzmy5ESKhhkUZDNV1UObOVZUMf2s6dcCF
         CkOH9uNo43qUywbMIC10XNHgnEoAlcNf7hftTx/hIMD6DMvfNlZkDsv2U2et6aK9lLEM
         2Fp/1xI217OUM+aRkwMoo+A1y0bbryzVvp+OnZkmU3uQm5Lsb13zpsrR3v8YV4sjnBxX
         17Hko7f2OdYzpV1dGyq7MddKtrmNYLkytndMB2qsMzIo3QKxyrXl8z+3jmwvlaV7feRU
         EhoK1F7BwmeEK/UptkPosCpIA/G0/BMpPnb/9UKcn8vuRXv13kXstOBvNBrUbli2LzEE
         pn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680728800;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+ZUuxUTAoz+nMDIAxIHUE5qjUM6hZWQNbOQhvaBX2U=;
        b=ktnXXtrJyCIe3+7nBmobLZiI7iKarJV7cSkU/n5NKMKH7G7sIwR6dHLOHlHDSNwXfs
         H4/JhIWZwgCFzH16VVq/4xNpkwLi4GyavSZ/pQoe8YG6xqRq/PfqTzoHpoP0om9ZJ6Me
         mFtBeS8Ervk7GijmXr4CFy+Ro20rtqH1Nm1aCgfJX+N5DD1ssfdJCa263UxqHoQ8ZIqQ
         61d80l66fvuphtGOUWKTvdNM2iIX3g1B2J9XDcRCmzzkls86umb8VdwUhmd1DhJSoGZY
         g41Eul6YDwO4bn7GfIoDsvS3YoZmKG9y0sZ5ySYQyHo6oDZqwA8ddXa/PiNyjvXtRzB0
         f/sA==
X-Gm-Message-State: AAQBX9cK9X/2eaMYMn/TqNMptuKmvpvznkORQXaQEi+JyTVnsCGVhSwP
        q8A+XRfHs9IxIwA41Gm0ndSuLOdn8bUi1fS0YwU=
X-Google-Smtp-Source: AKy350Y+FJ8UP/LVHQH/0pr9Bcjrh8XGWHRoqAmTPH/LnVb9kyTDUN/ERSJ610ZLCQu48gz8SKO6IeMLHYOrITBTq3o=
X-Received: by 2002:a05:620a:460c:b0:743:6092:91b4 with SMTP id
 br12-20020a05620a460c00b00743609291b4mr1724480qkb.14.1680728800570; Wed, 05
 Apr 2023 14:06:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:90f:b0:4e1:8b89:5a19 with HTTP; Wed, 5 Apr 2023
 14:06:40 -0700 (PDT)
Reply-To: ch4781.r@proton.me
From:   Bill Chantal <256345894h@gmail.com>
Date:   Wed, 5 Apr 2023 21:06:40 +0000
Message-ID: <CA+wecYtK3DwtavO9XY7ow+fh5nVh0-U0+26j-Z9XijGt2u+1Mw@mail.gmail.com>
Subject: SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
        HK_SCAM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:734 listed in]
        [list.dnswl.org]
        *  0.6 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [256345894h[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.8 UPPERCASE_50_75 message body is 50-75% uppercase
        *  2.0 HK_SCAM No description available.
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.

Your compensation fund of 6 million dollars is ready for payment
contact me for more details.

Thanks
