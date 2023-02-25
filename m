Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9096A2C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBYWpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:45:49 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4F136D6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 14:45:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d7so3100023qtr.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 14:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JAVwDMiPPI2gKlcA65I5GvhErU38X1iQZUj5l1lc5l0=;
        b=C2m0zNdZJYB/GqAJvG38UoNMg8oBsPrSFONMf7bRiox7cs1UNE0DZA+f7/7VAxDojQ
         mZq6hMZzYq/IrFr4tikkq2PiqcbWZEANgaNwREYnGptFVJM5kYntwlsKbcY6n6cGgHHx
         AQsaoe3rx1oPvxVSqZFOQoD4PuvOI8VHoybNhpCEQ6gIGW3bjsPRTAe+B1KjRS+9KMaM
         6QU2ReX6dZmgV5s8aeQuFVwbam7WFOP7Ag+3dgh5PsnqbW74+JXAsinve+jlb3NQ9NV1
         F0RZjm+FXxu/4gfAgncDm+iK1EsijnqihOHwTZzC1MQ0LrDYQcE7TnLPptn8Ynpyfyxn
         Y/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAVwDMiPPI2gKlcA65I5GvhErU38X1iQZUj5l1lc5l0=;
        b=XgRs2OpwNaJY744Mo80Pq6Kg2muCuSsOGmr5Sq5sSlPkyuk7Kq/avkrsq+lnPqtDgG
         DKFc5sB6IL8bRoqEqWDb28BxFramh12CsX6nYuSjPH4VvOOHXP2N2/E1pYiAM1/kKbco
         r7PlWsN1FnHu+/XuT0q72DDsxT5VHT6BI1Z0nFG2BrTMWs6WbPvU8Ah+9ytFV03OaGW8
         LIR+Eb6hNCr/eGLmhCRteY6cRZi/pnD9ELLm5WsFX28ss+t5FWfIhuFfCopetmMeXFQG
         43NWD/860vLKGrI+9fCad24Bn1c9V+SxwTljELth4Y44yMo781vnvgHN8s4+wtcvFiKu
         DB+w==
X-Gm-Message-State: AO0yUKV0m0Cb9TOpxu88ORfNUMIwu1mVMd3FFa778OGrnVVAJR585B5j
        JJlR6PVstNbCs5A+rDgJDKOGXz4g0N0oQV9a5H4=
X-Google-Smtp-Source: AK7set8OjVCAlmjnGk40RJzblC/sQvVy8l1Jlbeg4tviT8WC49PX+la/yNaQvxo1bL1zfxEkzD1NyKX41RVFtn6DgYM=
X-Received: by 2002:aed:27d9:0:b0:3b7:fda5:25d6 with SMTP id
 m25-20020aed27d9000000b003b7fda525d6mr3576939qtg.7.1677365147240; Sat, 25 Feb
 2023 14:45:47 -0800 (PST)
MIME-Version: 1.0
Sender: mrsamuelkafand@gmail.com
Received: by 2002:a0c:fb44:0:b0:571:ea34:16c0 with HTTP; Sat, 25 Feb 2023
 14:45:46 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Sat, 25 Feb 2023 22:45:46 +0000
X-Google-Sender-Auth: 7S93PI9LQ02xN14TuGaM3LsnODY
Message-ID: <CACB00AgdTiXC39kZ2_Pm9bdrYVx+WKha6EXe6mkdBZm+4-Fnqw@mail.gmail.com>
Subject: Am Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FRAUD_3,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:829 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsamuelkafand[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.1 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.8 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Goodday Friend,I am Mr.Daniel kafando. and I work with UNITED BANK OF
AFRICA. Can you use ATM  Visa card to withdraw money at ATM cash
machine in your country?  I want to transfer money to you from my
country;it=E2=80=99s part of money taken by some old politician that was
forced out of power.

I will change the account details to yours, and apply for a visa card
with your details in our bank, they will send the visa card to you and
you will be withdrawing money with it and always send my own
percentage of the money, and the money we are talking about is
$4.2Million us dollars. Whatever amount you withdraw daily, you will
send 50% to me and you will take 50%, the visa card and the bank
account will be on your name,I expect your response. promptly so that
I will give you further details.
Mr.Daniel kafando.
