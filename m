Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A0713A02
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjE1OVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1OVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:21:21 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D9BE
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:21:20 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-565c3aa9e82so23912447b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283679; x=1687875679;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpvrPlmy26/nCGxjupHwuea6qY0IMkD2Kk2kNdMMxS4=;
        b=lJvT0hP9xWTNAUDrX6cCe6wm9GSruixtz501j5iIc0zuAbSFI6MLWDF7bgjpZWxzxF
         t1t/9fk9VjIaEFiC6k5avWKkn9G0pr4LGnvNQikBzqQLoMofRzWGz7Aj9i2zOGcgcQrK
         em9NrSiakd7Gecdh+tMkvXE3nmd/80HwcpCAow4zUe2vmsOxs32XYkeBIUONZ2gWIWCN
         tMPdzZnWjm96CfAolwgw2beJdkeThEkKvqPLG69tJGstJbeCoZRhbFlJSh5t/oKkuQ2w
         eTkm83EVd/TDIlZNX22UvgLlCLFiU3p/DHyk933w//8XBc3oIJLycfGXIF6nb9D436HZ
         6c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283679; x=1687875679;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpvrPlmy26/nCGxjupHwuea6qY0IMkD2Kk2kNdMMxS4=;
        b=VQ+VJDIj3gBwh1DBoVYec8deCTL8xQeayM4fgfoH/1TUn6TxncLUgQ3CJC3Vk9u1Uo
         8TSyyaMGEi2O1r10mlziKA5pbGPgC4A69Lo+7DesbImOtxf/+pszi9+L4FBEKYydHqgp
         ONOxc0ieLKYc3g9cI/N3+2/eyjz4wixbGhIngcnPODzaw/0pNV7yPdsh0LvxoHHhv7Of
         /1s9T3yKTJflAMG3jiJnSLqhyNgjrCFVDhFKOOJbtG4yxIK5gMP/v3NkO6cFyWfYmapu
         jpg0dg7Wv7ZAeOdJYiYcfjZYyvjmXfWT845XrAiY9iJGgFml9/o3jYNL2TiB+KD0D0zJ
         OZoQ==
X-Gm-Message-State: AC+VfDy7gv4rb6jEqPC5pm9URw3xPXqB7jEQQk3w0rkstpCGOrfk8Qvr
        chQVgcD+0TTw87dLqMr06Y6fFqSsaSBYsFbIENU=
X-Google-Smtp-Source: ACHHUZ6RVrYqlSyM8scgXBNWPQGw/EWqpuxFkADqM6P4Asfjryp8umxdQLjzNOXfVKP7Gxicuq/Zij0UKCxuBSbDKYk=
X-Received: by 2002:a81:b40c:0:b0:544:9180:3104 with SMTP id
 h12-20020a81b40c000000b0054491803104mr9767896ywi.34.1685283678945; Sun, 28
 May 2023 07:21:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: hewahsanli63@gmail.com
Sender: mrs.joriahnatasha33@gmail.com
Received: by 2002:a05:6918:a423:b0:17f:fc7a:1a6f with HTTP; Sun, 28 May 2023
 07:21:18 -0700 (PDT)
From:   Mr Hewah Sanli <hewahsanli63@gmail.com>
Date:   Sun, 28 May 2023 14:21:18 +0000
X-Google-Sender-Auth: ix7ocYJz050eaBZiIbKqVHhjvgE
Message-ID: <CABZwHwNyS4tY0-NTv9YQvEbnvvfmf-PmU1A0T71d=BH7MxEmdA@mail.gmail.com>
Subject: I NEED YOUR URGENT RESPOND
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_FORM,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,HK_SCAM,RCVD_IN_DNSWL_NONE,
        RISK_FREE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_LOAN,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,T_SHARE_50_50,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.joriahnatasha33[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.joriahnatasha33[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hewahsanli63[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_SHARE_50_50 Share the money 50/50
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 HK_SCAM No description available.
        *  0.0 RISK_FREE No risk!
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  1.0 ADVANCE_FEE_5_NEW_FORM Advance Fee fraud and a form
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Dearest Friend:

With due respect, i have decided to contact you on a business
transaction that will be beneficial to both of us. at the bank last
account and auditing evaluation, my staffs came across an old account
which was being maintained by a foreign client who we learn was among
the deceased passengers of motor accident on November.2003, the
deceased was unable to run this account since his death. The account
has remained dormant without the knowledge of his family since it was
put in a safe deposit account in the bank for future investment by the
client.

Since his demise, even the members of his family haven't applied for
claims over this fund and it has been in the safe deposit account
until i discovered that it cannot be claimed since our client is a
foreign national and we are sure that he has no next of kin here to
ile claims over the money. As the director of the department, this
discovery was brought to my office so as to decide what is to be done.
i decided to seek ways through which to transfer this money out of the
bank and out of the country too.

The total amount in the account is (18.6 million) with my positions as
staffs of the bank, i am handicapped because i cannot operate foreign
accounts and cannot lay benefice claim over this money. the client was
a foreign national and you will only be asked to act as his next of
kin and i will supply you with all the necessary information and bank
data to assist you in being able to transfer this money to any bank of
your choice where this money could be transferred into. The total sum
will be shared as follows: 50% for me, 50% for you, and expenses
incidental occur during the transfer will be incur by both of us. The
transfer is risk free on both sides hence you are going to follow my
instruction till the fund transfer to your account. Since i work in
this bank that is why you should be confident in the success of this
transaction because you will be updated with information as at when
desired.

I will wish you to keep this transaction secret and confidential as I
am hoping to retire with my share of this money at the end of
transaction which will be when this money is safety in your account. I
will then come over to your country for sharing according to the
previously agreed percentages. You might even have to advise me on
possibilities of investment in your country or elsewhere of our
choice. May God help you to help me to a restive retirement?

(1) Your full name..............
(2) Your age:................
(3) Sex:.....................
(4) Your telephone number:.................
(5) Your occupation:.....................
(6) Your country:.....................

Yours sincerely,
Mr Hewah Sanli
