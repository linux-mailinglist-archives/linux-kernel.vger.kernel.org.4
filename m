Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDF6EF537
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbjDZNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbjDZNMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:12:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6E8469D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:12:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so6644960a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682514736; x=1685106736;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2q37tYLkwIeAQ7ZXXOiSKsROl/9/KjRGrNy3chsxgg=;
        b=d46VlHFpSUz068jybDOuyfIc55XKqQd/fy3rZ+c3wD3gowLW1/n9RVcd1sXUHMUWQg
         PM45yKNtgxqLxKoQS5SUylNoa3+zC4IMzmoKnCU9yToOT21v3ZtVaXyiMa9cgGZOxj/G
         B1k7y4QyQt9eIXgLd8f1jcB3TVtC2bXV98Aghl21VYWn02unNCAvk7aVO+/hLXW69GID
         Yw3q82T59gGnaDHIA+lXEdZcKGm4L31Q24VAs6/BW8nPhpV0KcO/WPu0+kDeA/pTqxy7
         O6DQek6wHxi6HYQ9kqQGukAlutpgLcZPksswZcn3ENRTEB1AheeIuJILOuljWJ7X/bHO
         n76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514736; x=1685106736;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2q37tYLkwIeAQ7ZXXOiSKsROl/9/KjRGrNy3chsxgg=;
        b=EZKpLANBl18mJljGCvC7SqeoJf3DANlp/33cNyeqnw4CgkTZdiBMz7+cpg1285Z4h6
         EC4Z0DrEG7o4GtkPOEIuBBJO/L14qmmyO7fuxYfl+th7bskDLpjQqHOuCQZjX1asDMFR
         VvQcgaHoHjk+N+jK5Yyz2xLWCDk2Mwx+N/mJde9umXt7GUGZsr9MfE6++tDBADSroEjs
         mCvzsGFEUDzfLaR6cXMghLdAOv75EtHk2cKma2UNa4mUWLhSNLDF1gIDS24MypXHgAQR
         xSI8n2/2NS+dBc4BMi9VbpBlKzfP+UJ3d8AEaQ5FKkwa07sAFuY9ZZVSwlOj5nwvmVcd
         Dlbw==
X-Gm-Message-State: AAQBX9dsPdRz1hBrfyyI7rLqO6V04ISgXwTfNo4Z05ALMoRweqLD/nZB
        MKImyUGh+UOkICHpStYFiVPEepKUCmUzdaxoeEs=
X-Google-Smtp-Source: AKy350bPmcFK2/ml74A5pcMwgA+mtDaX6YAFDvpEXRYgFttZA6MCbfOMN5uJaTITEQ4gSkfSqi9ulj4m+ZesQJDbiuc=
X-Received: by 2002:a17:90b:e09:b0:247:a3ed:63b3 with SMTP id
 ge9-20020a17090b0e0900b00247a3ed63b3mr21147041pjb.31.1682514735909; Wed, 26
 Apr 2023 06:12:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:389:b0:474:f989:3ff5 with HTTP; Wed, 26 Apr 2023
 06:12:15 -0700 (PDT)
Reply-To: a.alessio1976@gmail.com
From:   Alexander <info.fasttrackds@gmail.com>
Date:   Wed, 26 Apr 2023 20:12:15 +0700
Message-ID: <CAASfO-1A=Z3Q6ebD=j_aYOzTNm9wR3TSN6Cb26d4evEq6oG2gQ@mail.gmail.com>
Subject: I hope you are doing great
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_LOAN,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [info.fasttrackds[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [a.alessio1976[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Receipt No: 910235

Hello,

I hope you are doing great. My name is Dr. Alexander Alessio. I'm the
auditor and head of the computing department of The International
Development (IDA) Association. Based on our audit report, I verified
that you have not claimed your (PSP) intervention fund from our
office.

The (PSP) payment is a support fund situated as a Pandemic Support
Payment to help support =E2=80=AFviable and ongoing businesses or
organizations as a result of the Economic crises ravaging the world.
The IDA is aware that Businesses and individuals suffered revenue
setbacks. However, the IDA awarded support funds to beneficiaries
through nominations based on an active account that was submitted by
email services providers and through which your email account emerged
as a beneficiary. The World Bank under the IDA rescue scheme, approved
special intervention funds for disbursement to entrepreneurs, small
and large business owners to help individuals build back their economy
prior to the pandemic challenges which affected lives & businesses.

Be informed that your Email address was recommended for this
empowerment support funding by your Email service providers for active
usage of your email account and business directories.

The IDA is an international financial institution that offers free
financial assistance to entrepreneurs, business owners, and
developers, Its aim is to ensure global development and finance
projects that will develop infrastructure and improve healthy living.

This is free & Legal (NO REFUND).

To receive your IDA payment, Kindly reconfirm your details to enable
our office in your location to contact you for payment.

Full Name:____
Age:_______
Sex:________
Occupation:___
Mobile:______

Congratulations once again!

I believe you have read  and understood  the framework which aims at
expanding the scale of financing sustainable development to enable you
to support your business/projects.

(IDA) Policies And Procedures Framework:- IS FREE. IDA funding is for
Development/Empowerment.

Thanks In service,

Dr. Alexander Alessio
(H.O.D-International Development Association)
