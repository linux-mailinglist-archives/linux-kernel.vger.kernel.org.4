Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC267CA06
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjAZLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjAZLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:34:32 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6635A80A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:34:30 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id lp10so1251388pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBh5t0y71nJcUSs92Uh6oBnoeSzlfaLeUxXU3JwGQNQ=;
        b=b9jabVi8mtM/LqwzV82zy61YMKfr7zkBDsuY0b63mnruwGQuqDtKAk85nd/i0649j+
         tGwXtV8iRX5EMMNomPzWMQpgGZDRRd7JMkDoyGep+2m6nNW3kS/7kDGczHqq90ORBZ7L
         5b29LevLHkV8jNJWl2lOp27BcG1XpdwH/TAe5ol44VWlRJAlqJ41/ARv2LS374lHxgiy
         J0NAV+GyYBiFbah+1Yvxl/wJkpQFmMQpfBSlnBzwm3nLfi1Wbu7WUBVHNdvtIH1dfPoK
         vxVArOSeXPVWY2/CRLjl3aSENuAaCR9aQhUpN5FCL7XORWoQa1MwhOnvfHX/2tATYDa0
         McCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBh5t0y71nJcUSs92Uh6oBnoeSzlfaLeUxXU3JwGQNQ=;
        b=StZBxOtKiyRi6nZRH/Z396VDSg3fN+ryhh5dlCu3NoVrXbtTPz3/u8HTg/Hjvxsx5X
         QevCWypKjSKkfTkxMWkX2PYFM3HwclfKxQte9DHppp6nrSciB0fGAdu18DBVTaeq0Lti
         UfA1J4B54kJ3SYEuWezCvWAW3DEaWOLDlgpZeASZs+JJAYvIHLhSByfRnBzPD4ZRQIAW
         Bz31o9s4cctGBcsRGko46sr2s4woOWa7thwb6bHWJkrDs0CGtbmNXvv3XloI8eRCvI4t
         Jc5+j/qM+augPtyJMlTIC9KfRtzIZ05eOTC4WHKNm8yp+u/ozyO2DWrg1EFJAK1Coply
         OteQ==
X-Gm-Message-State: AO0yUKVxMMWtyZBvMAIVQFgN+6JrYYGeGFcnMquci0V+ihnO4ZS8EEzf
        FTTG8tESgPEz0fZLZjJuE32vLK3RFtahUWyRmgg=
X-Google-Smtp-Source: AK7set/duFloqAII/UN7OhMsFAX2GQb0GPZFV06dprTjmC8s3DWpi2U8IssKocRC+S0mATOyGWo0BQPa2ueq3b4YXws=
X-Received: by 2002:a17:90a:f2c9:b0:22c:3185:ebce with SMTP id
 gt9-20020a17090af2c900b0022c3185ebcemr105964pjb.140.1674732869836; Thu, 26
 Jan 2023 03:34:29 -0800 (PST)
MIME-Version: 1.0
Sender: patriciajohnvan@gmail.com
Received: by 2002:a05:7300:6482:b0:96:13ba:269b with HTTP; Thu, 26 Jan 2023
 03:34:29 -0800 (PST)
From:   Dina Mckenna <dinamckenna9@gmail.com>
Date:   Thu, 26 Jan 2023 11:34:29 +0000
X-Google-Sender-Auth: uOIQZChBREAV8fmDhfRb2dFDjMY
Message-ID: <CAHqodhQMi+nBd1iXjr=hYS1uCN0-Jbdg=59xJvv4bxM93rRN5A@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5724]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [patriciajohnvan[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear,

 I am sending the same message to you. My names are Mrs. Dina Mckenna
Howley, a widow diagnosed with brain tumor disease which has gotten to
a very bad stage, Please I want you to understand the most important
reason why I am contacting you through this medium is because I need
your sincerity and ability to carry out this transaction and fulfill
my final wish in implementing the charitable investment project in
your country as it requires absolute trust and devotion without any
failure, which i believe that you will not expose this to anyone or
betray this trust and confident that I am about to entrust on you for
the mutual benefit of the orphans and the less privilege. I have some
funds I inherited from my late husband, the sum of ($ 11,000,000.00)
deposited with the Bank. Having known my present health condition, I
decided to entrust this fund to you believing that you will utilize it
the way i am going to instruct herein.

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35% percent of the total money for your effort in
handling the transaction, 5% percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country.
Therefore I am waiting for your prompt respond, if only you are
interested in this humanitarian project for further details of the
transaction and execution of this charitable project for the glory and
honor of God the merciful compassionate. Your urgent reply will be
appreciated.

God bless you.
Sincerely Sister in Christ
Mrs. Dina Mckenna Howley.
