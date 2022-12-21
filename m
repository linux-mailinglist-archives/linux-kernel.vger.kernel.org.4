Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F831652B63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 03:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLUCJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 21:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLUCIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:08:49 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECC95BD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:08:48 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 186so14989065ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 18:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3J2CGbQX4q+YsoLQrSOy9tiqJqmA9W+9l2T9zjpYzfo=;
        b=oWXg6yukI8AQM4hKT42z9MDC60HAN6qkxGwspr6cfzE7yfkNVQdJqaJ0fljHNo9jDM
         aehZcpz60AezXX/DsYaWKuZmcrgIn5iwAhHQD4w/bmfT6NRpJbS5kiOAs/WTUh6d5C8O
         i2TPTn+byP1AJVyILX+T1CrtgcuXswH3UJhY8IEeHorf6oPqr19nsC3yGFnbTN0Uuf5J
         Wrj9R3zXAmPtUSz17R5u9m6mM2OVu09HMWw9Y0AEix1my/n6WrDWob6fXWTKHJwGzSII
         YZVPlQeS9spgKq3vglVwxMVDyVgcUm5E9YIN/mPXonxHs97wNLQXibnApvA29gZH3qYj
         x2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3J2CGbQX4q+YsoLQrSOy9tiqJqmA9W+9l2T9zjpYzfo=;
        b=G28N0stECgjQ3PUv+j5WW5OSBnjJSE0/cSO2PoCFDtkzvLyq0i7/Mek8Vmo8bHqRir
         f+3rOSeL4I2yt03x+nslp2iqBSqHdzPjQ9TIb88Ol9iNV7QYB1Owev4LPl5kp8p13Bfh
         4q5Abucsw8u5YdnF7Gj6iLsnDcjWNnLcve6fwyX1+dsIDUxDCS7f1SWUb5jUIsSJUvgB
         uXCKkQNoGS/9Vq/zMLGLh4NGKgpZuN4l5gqfjzTeNPvTP+Ck8/E4ErAo2Y+RKekR1N6f
         6WhgBt1bQ5yat5k/bM+s9BrZt7HWasqqheQ/QiTtYpUiiRDLxxjbGsDA/PtGM0QScsot
         EhEA==
X-Gm-Message-State: AFqh2kpFugWo1A2bFeylwHdfpaspxDJns/L71MNHgI5dYasiIWS8F3J4
        ucaQXvhkz+1QYxr57xbr3GauA6M3TB4hD33448U=
X-Google-Smtp-Source: AMrXdXt7EK48t1I9dSGT04qZNSlPxDUc1blrgswankhQK3MDZ3wZJPClkq1l+6HQRTvM6zNUOJyU+eme24aOlACZDVs=
X-Received: by 2002:a25:7345:0:b0:746:1d3:4657 with SMTP id
 o66-20020a257345000000b0074601d34657mr14222ybc.174.1671588527201; Tue, 20 Dec
 2022 18:08:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:2b98:b0:3b8:2614:8853 with HTTP; Tue, 20 Dec 2022
 18:08:46 -0800 (PST)
From:   "La Post Agent ;JOE AMAVIM" <togoapostoffice@gmail.com>
Date:   Wed, 21 Dec 2022 03:08:46 +0100
Message-ID: <CAC36GzCDCx1QdDVKLAPfWRS5EToMORxYVb0AZjahEXqWsyu2_w@mail.gmail.com>
Subject: Ecowas Courier Diplomatic Agency Lome-Togo,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_4_NEW_FORM,
        BAYES_50,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FILL_THIS_FORM,FILL_THIS_FORM_LONG,FORM_FRAUD_5,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [togoapostoffice[at]gmail.com]
        *  1.5 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.0 ADVANCE_FEE_4_NEW_FORM Advance Fee fraud and a form
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ecowas Courier Diplomatic Agency Lome-Togo,
First-class Official Agent Mr.JOE AMAVIM
Official Email (togoapostoffice@gmail.com)
T=C3=A9l=C3=A9phone/Whtsapp+22897881529
DEPOSIT CERTIFICATE CODE SCTC/BUN/xxiv/2022-3 /850/01

Attention; Beneficiary, EMAIL ACCOUNT OWNER;

Greetings to you from Ecowas Courier Company Lome-Togo, as I have been
waiting for you to contact me with the yellow immunity tag fee of 195$
for non-inspection of any homeland security upon your approved visa
card delivery movement into your country.

Again it is important to note that your Fund/Payment was released with
the following particulars attached to it by UNITED NATIONS
COMPENSATION AWARD PROGRAM.

(1) File Number: F1267-2009, (2) Ref. Code: KP23/857/MCL5 /CO,(3)
Grant Number: MICC / 97846563459/206,(4) Personal Identification
Number (PIN):0866750

So, go ahead and make the payment under our cashier name Mrs.Okosi
Onuoha for me to obtain the immunity yellow tag and placed it upon
your delivery duty parcel and start coming into your country.

Use the data's below for urgent payment of $195;
Names; Mrs.Onuoha Okosi
Address; 17C BE-KPOTA ROAD LOME-TOGO REPUBLIC
Question; Yes/ Answer; Yes
Amount; 195$ Only

Finally, I will carry on the delivery upon my receiving of this tag
fee to avoid any intervention of any kind of homeland security along
the line. And please don=E2=80=99t fail to reconfirm to us once again these
data's;

 Your Full Names;........,Your home/office Address;........,Your
direct contact number;........

Thanks as we never stop working on your behalf based on the coverage
bond certificate will be done upon my reconfirmation of my final
terminal before I will contact the National Assurance agency for the
bond collection on your name together with Intent Letter of claim
certificate.

Yours in Charge
Mr.JOE AMAVIM
(Ecowas Courier Diplomatic Agent)
Email :( togoapostoffice@gmail.com)Telephone;+22897881529
