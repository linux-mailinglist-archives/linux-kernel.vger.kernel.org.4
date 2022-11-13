Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1F8626D1E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 01:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiKMAxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 19:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMAxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 19:53:17 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9571912D06
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:53:16 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id p4so8353748vsa.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxYPr2jVW3bvT3wsD5LBdKG0AjkqDLwBFdmR5KSDtKs=;
        b=dk4m9gYp2+itdSTm+UUcNaP17ltSbc0VtvVke/i6Jz8v6wANtR5EZb8Lmj0Pm8VhPL
         apTDiqV1vKMIkw/sAjKFM3ig174kKffNvJavB41nX+PVKkW+uk3kejl6IkWDrpVWOdOo
         6zpMnR6Q/KVUxxzLVA/bmqcVbBaYxLhLgKPpumdRoH59yKjgHHcotXMho7O1hDbI9tkO
         +w1GggGyN8wS7O1P1PY2Ni5jIqqLv+jQDNXszRZREUWrYES2rlXeBFPrHwKEvRjlewBm
         MMzDb/hmJxjpc7OQYvgsdPcMggfPlXb6j50O4oTCXvFZqtwbmWpbTmnoVm0PcpR1nA+c
         LCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxYPr2jVW3bvT3wsD5LBdKG0AjkqDLwBFdmR5KSDtKs=;
        b=kwuiHxl7dD2Xfv51Jdofam47Pr1LOnlkGwOH4S2xJh5EMKESQAr0n3aQApvUgWN8JE
         MutCfhTOBoYaKPTTuVnlqVzxYfcfvnxmgLSulP9fbyfi/XW4fC2B/Hkzso4obaWbaq+G
         0hlfCiyVkkSlRBMIOyGOvtDcm6eUgRmz8NgcL+uvWBGSPvwq3ugpyP1viiZzZwKnw+au
         T5S5tnU+W3xFMRQbhpUL5JfYFShrbf/JRt4TumUHdI97IMozJQucwp07U30L6fkyXpEx
         VVE0r1t7na/yY3uQU63s6guTYvHbCiMX1VtPIiHSoBtBKGRF9RYXK51J7K7XgGveNanP
         yAWA==
X-Gm-Message-State: ANoB5pnqGcGxyFnBNqnPQQiQcsFi5setTa9QNA8PmwICrhmwk66ftTzx
        kWXTXNSfkhTRPxaRBp7HMNUtDdtxZ1AVmTYHjRA=
X-Google-Smtp-Source: AA0mqf7t0ysKBZ3O0C4ApA0FzZpZ6HnpNvDjEukM+L2KuKhYQixiFw46r7jymnpA0LIdiq067QqaMeCAzLGthcDQ9IM=
X-Received: by 2002:a67:2445:0:b0:3aa:eef:4109 with SMTP id
 k66-20020a672445000000b003aa0eef4109mr3566437vsk.50.1668300795149; Sat, 12
 Nov 2022 16:53:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:c18:0:0:0:0:0 with HTTP; Sat, 12 Nov 2022 16:53:14 -0800 (PST)
From:   Megan Rain <meganrain236@gmail.com>
Date:   Sun, 13 Nov 2022 00:53:14 +0000
Message-ID: <CABe9k1rfm5j44bd4QQpjPVHnX3KmaxHJDhgRBP8V9FQH=gtxYA@mail.gmail.com>
Subject: My name is Mrs Lovelyn Raya from Indonesia
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6081]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [meganrain236[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [meganrain236[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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
