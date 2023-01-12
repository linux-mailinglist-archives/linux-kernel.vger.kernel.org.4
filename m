Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA68E666C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbjALIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbjALIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:39:06 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2F97662
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:37:48 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g9so1301624qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zjBijuB7ZOhWwjhJWxgbGGESszwfz+F+tVx05ZpewrA=;
        b=XLXtTRcOTN6mOxnlkgkj1oDpPYQEBGxRcbqEkddUBBbkdB8GpEhv3nKQz1WIe+YHvz
         OpybhGVsdHHcL6J+uLpyfTIat7ZS2HStwTAsedXc3z5IdxRwDX1q6T2P2WHJZUFmcf4c
         5KwQDcjde0CtFbkXrJVU4eYXA31CyvnvQHi2Me8njvUqDiEBjYUt6RPFz95/mKRWkfuV
         gpqoFgyEkByoCciLm8K4wLFDE9zuSx2Nxx5nMRqQjakIc5WabQovXYw0lOhnbxNLndAH
         r/X7T2HOWpR1rOppBi27egGpodmr8yMJp5TgFokol5mLfCZHpmsyLrpGFoQ0BiRbXQ2t
         DCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjBijuB7ZOhWwjhJWxgbGGESszwfz+F+tVx05ZpewrA=;
        b=vYTzHir08njh6aj5hptL+hFVfAPpBDt+jsSU99+xgXQVK+tzyEPofWUi9h8cxK3IB+
         M2akHUjA4/YiY05gbk/esfG+fBbOhN6RnIGj0nHvAm3bkNvfK5GYF2d5Vd2Uux4I04NJ
         mXwNToNG43kwkQOcmN0uU/ZD/TT66CgPJkdBA+VzlSWIGiv+7eeaRdIWuCvMTFRkRRj5
         mt7k2S8+Z4YLo0o8iX63LSxQT6m5oVC1kxV8llTFiVC1Swq7stbANr046Z5Pj2byR5gq
         UlK7RRbN7qQWLpFeTxN2a7yusVz8sW5uLtIwW0u4z+A1nNHcUlGd99GGXw6lkSW92Fwq
         KoCw==
X-Gm-Message-State: AFqh2koxZ8QCWJmET2MNDPuvp4zamjT8Sre/rHq77js7EE7i6x1fuIEc
        ivMy3nJFoyYU7oha57lU5TopSrBjQbvQlsbfNA==
X-Google-Smtp-Source: AMrXdXtq7Ei0mutVplzn4x7RmbbJpE5XgtQf6UtAW4b1IpWXkFv76ILaEiRkkvW1AKos7qckU5vuBKC0Ir6SxRzP5I8=
X-Received: by 2002:ac8:66cf:0:b0:3a8:2adc:46b0 with SMTP id
 m15-20020ac866cf000000b003a82adc46b0mr3626448qtp.120.1673512667474; Thu, 12
 Jan 2023 00:37:47 -0800 (PST)
MIME-Version: 1.0
Sender: lw716547@gmail.com
Received: by 2002:a05:6214:4b99:b0:4c7:6264:66a7 with HTTP; Thu, 12 Jan 2023
 00:37:46 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Thu, 12 Jan 2023 08:37:46 +0000
X-Google-Sender-Auth: FraJU2m-y0uGRYj00Rj5VrQE8v0
Message-ID: <CAM4b7K=8HKahZ_eNWqTfF7z1BnHya92WhA5fW-u6V3Ti7=KKWg@mail.gmail.com>
Subject: Am Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:844 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [daniekafando001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lw716547[at]gmail.com]
        *  0.0 NA_DOLLARS BODY: Talks about a million North American dollars
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend Goodday,I'm deeply sorry to berg into your privacy as we
haven't met before I am Mr.Daniel kafando.and I work with UNITED BANK
OF AFRICA.Can you use ATM Visa card to withdraw money at ATM cash
machine in your country? I want to transfer money to you from my
country; it=E2=80=99s part of money taken by some old politician that was
forced out of power.

I will change the account details to yours, and apply for a visa card
with your details in our bank, they will send the visa card to you and
you will be withdrawing money with it and always send my own
percentage of the money, and the money we are talking about is
$4.2Million us dollars.

Whatever amount you withdraw daily, you will send 50% to me and you
will take 50%, the visa card and the bank account will be on your
name,I expect your response. promptly so that I will give you further
details.  Best Regards, Mr.Daniel kafando.
