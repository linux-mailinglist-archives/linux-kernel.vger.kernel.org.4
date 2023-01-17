Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94D66DD55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjAQMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbjAQMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:17:01 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094752BED5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:17:01 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o66so25705763oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2OyI4w7UpgY/XGVdXX5OWf3es+Ka/xuixpduvyMVMuU=;
        b=dLYBpmgghk3e7chV5GDshpTKr3iMYlA48pxyK1bhnQb9DlrynezMHdHMIDZmNczYMh
         VGlOuesaeNjOdm1lS2gdCXAKO5JAJSpZAFNJPAXyTfq0Ln++O02zT4o7IP1W2QwyP2M4
         439mrPZKXnfwPt0MrjkGF1Td0vjrZDh0TEanrLm2v5KvP4CEO8HBbSQnOeHh/h5mCKe1
         iFM0i8EjE/OUBgJ/U1Z8C6M30Xo5AFrvhMktfZANHcIr4OPBQzFd5P5dQ1/oSYPs8S6A
         QDFyhFhExWwIdkQqVF85MxvoWKV5cJhDSOGFY7f16hOGlEe6qIXxvzliZHcTtlvawa3l
         yfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OyI4w7UpgY/XGVdXX5OWf3es+Ka/xuixpduvyMVMuU=;
        b=JO5R4KQUHsrJx6PmvQr48sfNfyJpB+il7WwTep7dKQ57mCFQArgzW+vz8OXxyC0s2T
         NKCTKuYrWEl7XHvDXQIz2IOok5PeqDqri7gDjRysYaw3x4Ov77623hKE+UpxzoGqaWzG
         WVYUaAnLoLSAExg7OLymaa2VCpKyiNBACNzl/wt+RaWeT7y7tL/n9eSNEnD0FSRDjUSV
         d9gQZgGUoz06GEtlCiUlz4H+FHIBasi2d80qyy7sAtXhwPt4ckhhHkhNgknQB/zCqAax
         qgrTEGhrUoeKapALV+qaQ0xEMtsOW42fjQ7W1Zrzv/9iUsKVvKDkswmFtZ9I5CYXKckP
         O2ug==
X-Gm-Message-State: AFqh2kpMduSVwprwBhQn/W8uaX89iKsbiVCUY9OxOvvx3eD3DmCEzSAP
        FtELPKhvkhH+cRckJefehKXjtWH3AxzcFcZCx18=
X-Google-Smtp-Source: AMrXdXtAga8MudF2EnQjssv0TFHdYRoGFGH2jxhMGoiTm+wtcjEY01nrhX/MOKjPAufnrgoFP1xkMddMp64S4K5NOR0=
X-Received: by 2002:a54:4496:0:b0:359:cb71:328b with SMTP id
 v22-20020a544496000000b00359cb71328bmr184512oiv.282.1673957820334; Tue, 17
 Jan 2023 04:17:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:5f01:0:b0:49a:f191:b01e with HTTP; Tue, 17 Jan 2023
 04:16:59 -0800 (PST)
From:   ududonka ahmed <ududonka.ahmed15@gmail.com>
Date:   Tue, 17 Jan 2023 12:16:59 +0000
Message-ID: <CAP2SLg3LoxGkGzm4_PtZ4QjkjCZtGYmAj5OHvjoa3ypbGWuQfg@mail.gmail.com>
Subject: Thanks you very much
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,HK_SCAM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:234 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5422]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ududonka.ahmed15[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ududonka.ahmed15[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.0 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  1.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_3_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear

My good friend, how are you today i hope you are doing fine? i know
you don't believe me from the begging but i am very happy to inform
you about my success in getting that fund transferred,now i want you
to contact Mrss.Sumon on the information below.Tell her is
from me

NAME; Mrss Celine Sumon.
EMAIL ( mrsceline.sumon002@hotmail.com )

Ask her to send you the envelope i kept for you contains  ATM VISA
CARD inside which i kept for you, the total sum of ($350.000) U.S
dollars for your compensation. Once again contact her on this email:
( mrsceline.sumon002@hotmail.com ) i give you this fund from my heart thanks for
your effort.

I will no longer be able to email you again.

Bye and best regards,

Mr Ududonka Ahmed.
