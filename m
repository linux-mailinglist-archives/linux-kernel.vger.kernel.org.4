Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A495BC608
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiISKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiISKGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:06:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695251147F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:06:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so6518606pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=SdY7eS2gudaCi6HurWv3eem+oJar6G0+HOwoGQXhZ5k=;
        b=R5Y/okYG35euyJlGIaNq3o3L7ny8YlGOaUzx2aL67UwwEiuL6hkL0HEAbgfpTuWeQV
         U2OsiO11ClFF/vkvslSPNdvAPqpu0Tl7S1FKeU1jK/wj6lQWtXofgK9sDAfhKo01I6/E
         IbZ9A35Fk6tHm0QyKsk/OP41amWDEXauvRnAsNfJ0Gsy5KdZXxX4mX6cPQHUCIeqs0X0
         MoRwGBylUVtIXdb2VW1O15FP+jXgs2SpdbuwtX2bGGn1vo1+hfl2tEgj9P76Pf/EGCOk
         zOwnje2Eo/2W6qxM4uAHLKbveBFVGjauaJsRCGxNPKQr/UnrPcAWp+tZd4NCFpb2TuEB
         R4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SdY7eS2gudaCi6HurWv3eem+oJar6G0+HOwoGQXhZ5k=;
        b=o4NdnuaEH7dF4NvmsbFIvvazQhCy0ucpvBYECsmQvZWii//iICK2hf9tXvx8kBCmFv
         zaUXnBppZEY4M+zWrDfGToS0Wvd5AGZ8jt4zX8VrJifIPAYIewzIfLvq/SvExfdVhg4X
         BeXWDAOCCBwIa2XkPatn9Flc0X4/I0FT7VOVCJ/yW6WUJqwd5Z7BkrQUW+uz0rLndm3r
         be3ARpUdRT7fuijgOKfQdHpVXe8IujC9npCI55aO0WmtBekxunMrPYTJc3bD6nC3KlOb
         rkR8NBTR9Hk8gwC9eykqbOE4NJfOIhu8YknOKZ1+RWVBpMVXCUgc2ad/PSTEgZqWHxKx
         VmCg==
X-Gm-Message-State: ACrzQf0cpzYmmEsqA6qoZTXm3M+gYLfFn5apaXvA9B4slNPTvX+PqyP4
        proWo8RBGYQ3Vv7E7i8o808Evzwb4VjYqpWzUOQ=
X-Google-Smtp-Source: AMsMyM7qJSVJhECqtNf/G0Zdx1H/qeDmjaD2NN+36aye8kcvKAJST+/UWOXbaq2lAgPaHF80R1XBaobZUuA3iUNhgv8=
X-Received: by 2002:a17:90b:4d82:b0:202:9030:e482 with SMTP id
 oj2-20020a17090b4d8200b002029030e482mr30624560pjb.110.1663581989578; Mon, 19
 Sep 2022 03:06:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: ibrahimbello749@gmail.com
Received: by 2002:a05:6a10:d108:b0:2f4:7f46:628c with HTTP; Mon, 19 Sep 2022
 03:06:28 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 19 Sep 2022 03:06:28 -0700
X-Google-Sender-Auth: F4ThsM-6Hv99GOMBh9mdsATJmow
Message-ID: <CA+nFk_rZfWeD9VWiBMiBVJe=a0L_ctL5cELTO09sJ+C1i-Evag@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5082]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimbello749[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ibrahimbello749[at]gmail.com]
        *  2.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health.

Sum of $15.5m, (Fifteen Million Five Hundred Thousand Dollars Only)
when the account holder suddenly passed on, he left no beneficiary who
would be entitled to the receipt of this fund. For this reason, I have
found it expedient to transfer this fund to a trustworthy individual
with capacity to act as foreign business partner.

You will take 45% 10% will be shared to Charity in both countries and
45% will be for me.


Mr.Sal Kavar.
