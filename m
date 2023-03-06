Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750A6ABCD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCFKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCFKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:32:03 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E01274B4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:31:34 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id cf14so9889764qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678098687;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29acQNA8Cumm02CGyUpVCLdeAEc2jQcZ1RkMPZNG+yw=;
        b=OtzSotIbgwF27Ly55D5IlpQyamY5n7VSWYn8FI/uwEYjqX37m5TOY00nMvkeZ9Hkzm
         GPqp43IHXs8fmbwp6uWMq2fnTQSpvYKNqaufflcanixMJ9gFNgXoD3eQ10uxg4TBRFmH
         tyMKm1UbJUxlQxMWastr1K+0p8XVf9cShSpQC7QbkbhDlsG8II/MGfL4si+QGAakCoJD
         Ureh4IlMKAt2Bg7qHvfnEAf4hfZ9XcTJlG+VekHbQc4g9m+G25SfO5PkY5nLBjXKdsox
         FNAF7Onmy+u4ftnB04akwkSQBx7LVQH6dk+eFGy94ToyTrRSk9y9A2miol4pWyVa6NCT
         YP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098687;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29acQNA8Cumm02CGyUpVCLdeAEc2jQcZ1RkMPZNG+yw=;
        b=JE3KeHKta1MPln13fAmMx+d3agO4TeXGuZ3zf9el2Ktu8eyEIFj4mGCwBfoIIEl+8r
         zeLMOyT0ByKHPjvyXw6D5oXSZp5TVt4fsR1FrmAA5mPz6K7RQNEvrAhmB6Xc29HmeDaA
         nI7evQfMunEbA4fML4NlVFJ5v/2BsstfsVlFr7IAo/j+x3mCTkrLAxxkX+ChYBNkCJFV
         g9sA4g+wqJvlGuHWDvI+U7ZzZN0YoDVWSY82nU34lYewQcod8+gKkPvDWSLojrRBPJzY
         fZ2bYYq5zrm6GULtintL9z4sE2vtyjd7eDuHCcFSDYBr8BQ6cNionEXUrzht+KBh82+s
         hyoA==
X-Gm-Message-State: AO0yUKW5OtSjB42E2bRup9XEood13EpjFdjGvckTmoUO+3kXhaCfe96X
        wzhiQzORmV9JnyfNiFOyIQmgR0hH0aXmPbtcZr4=
X-Google-Smtp-Source: AK7set9hHT2rtR1/yZbTkPosMF5U6019wPNgDpbETBcxMEUUxauZc4jKEC0QbBcsH1/89PBmXaebnZ1gk12O2zCE8kY=
X-Received: by 2002:ac8:4052:0:b0:3bf:bfd9:a4a0 with SMTP id
 j18-20020ac84052000000b003bfbfd9a4a0mr2656232qtl.12.1678098687552; Mon, 06
 Mar 2023 02:31:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:2b8c:b0:58a:ce3a:3de4 with HTTP; Mon, 6 Mar 2023
 02:31:26 -0800 (PST)
Reply-To: avamedicinemed1@gmail.com
From:   Dr Ava Smith <georgemiller1722@gmail.com>
Date:   Mon, 6 Mar 2023 02:31:26 -0800
Message-ID: <CAHoiKLGZYKZkWQithrTY_dmMDudWLzagyA8KYO+9d=RckUgfPg@mail.gmail.com>
Subject: HI DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:829 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [georgemiller1722[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [georgemiller1722[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Reply me through my official email (avamedicinemed1@gmail.com)
Thanks
Ava
