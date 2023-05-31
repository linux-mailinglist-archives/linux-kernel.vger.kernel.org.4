Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32FF718D76
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjEaVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaVsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:48:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39BCA0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:48:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b0df81142so1380185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685569691; x=1688161691;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj/Ta9h3LbMEXE9/izhrXN7oaXSHc9Ihi+jFO4AkwA8=;
        b=dm4r5KUcv/tNvXJ64j8Jc+FO9PMKDCVCZKbiVSmq5/VkjQfTK2mJ5F3FGWnCvCKaR/
         mOrMQ8FynMGdz/QBZJA3mbScqYOsgt7nifRb++NbdnEyp3Frp5TnjW2IEwd7i/t+gJrz
         +JohC9673EglNQJ5Zy4LLBkgsgrWw7dh3YSEznlqjE8m6NQacoN1rKlw2y+JxAOHWvvZ
         w201NdlR3lLImG1hnXSPBq3RTBHCgZ4MQ04RhELsoJHaAFcWLwBWZQkpvER7NwJQl4Ue
         cSy2r5aF7wwVtq7kqSLYuLE288tw0hRVct3q2iK30ICujsZ1odtSKF8tKxdLpvWAXzr4
         DsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685569691; x=1688161691;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj/Ta9h3LbMEXE9/izhrXN7oaXSHc9Ihi+jFO4AkwA8=;
        b=C9SymJNGDosF1f/WxD9TJeeNkUMHRsQFKrFPrEWiMvz+/qcN13qa0L0p7NbRAF+H6q
         Gs+hSO+nYoDJ3YdTZlCHHfyzTyk6h/UqIm0awewE0r/F/R/quUdEZpRcosYJ5JHl6j5x
         b4WsTlA3gpb2hNM9FkxwNUQNu/nGDIRV7izTfIXEunOB1A7t49Grd2emiSgO0tCJ8ZvL
         YxfF/njBgvxd4OJs2ApMyDRbM6ZE1s/Y1j/L/th3/xW0eeNZ4nA+gd6gbMvVe4SlThh4
         ERWkKY/i+jlTdalLVSg/fftEYVBlR+FvD1YQWD2Qa7Rkg8Cec/FpK0uw8w38sMDv/370
         nt8A==
X-Gm-Message-State: AC+VfDz8RsP4vpVSMBUmGGRRbhzpwDXkR8t3l7zMbVigeQXrJVuSjZf7
        YXJPCHgi/adHnakbbevyEJZri606GT2s7pZf8knOJa+yueyCWQ==
X-Google-Smtp-Source: ACHHUZ4JXI2hfV33+Dp9HioUf1ME061m88N+UiCB5TIcynpkt1MpU5kcjKVM9n3a4n3l5PRx9AsSTDxNk5dBh/jhOyo=
X-Received: by 2002:a05:622a:1743:b0:3f4:ed2c:10a3 with SMTP id
 l3-20020a05622a174300b003f4ed2c10a3mr7964709qtk.38.1685569370570; Wed, 31 May
 2023 14:42:50 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsester2008bf@gmail.com
Received: by 2002:a05:6358:33a6:b0:122:db4b:7f96 with HTTP; Wed, 31 May 2023
 14:42:50 -0700 (PDT)
From:   Gabriel Esther <gebrielesther2021@gmail.com>
Date:   Wed, 31 May 2023 14:42:50 -0700
X-Google-Sender-Auth: xsu2Lw83ZHD-8UUoRveMW0c3vis
Message-ID: <CAAq1dN-ZvoTLQUuUcrLO85x79iLaYDrXABDFGuhdfTRmtrEm5w@mail.gmail.com>
Subject: From Gabriel Esther
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:730 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gebrielesther2021[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 HK_SCAM No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting to you my Dearest,

Please I need your help and Assistance. Permit me to inform you of my
desire of going into business relationship with you. I am Miss.Esther
Gabriel, the only Daughter of late Mr. and Mrs. Gabriel Kadjo. My
father was a very wealthy cocoa merchant in Abidjan; the economic
capital of Ivory Coast, my father was poisoned to death by his
business associates on one of their outings on a business trip.

My mother died when I was a baby and since then my father took me so
special. Before the death of my father in a private hospital here in
Abidjan he secretly called me on his bed side and told me that he has
the sum of TWENTY FIVE Million United State Dollars (USD. $25.000,000)
deposited in one of the largest security company here in Abidjan, that
he used my name as his only Daughter for the next of Kin in depositing
of the fund to the security company.

He also explained to me that it was because of this wealth that he was
poisoned by his business associates. That I should seek for a look
foreign partner in a country of my choice who will assist me for
investment purpose. And the money is in six 6 trunk boxes there in the
security company now.

I am deeply here seeking your assistance in the following ways:

(1) To stand as my late father's foreign partner before the security
company for them to deliver the 6 six trunk boxes that contain the
found to you in your country.

(2) To serve as a guardian of this fund in the trunk box and invest
them into a good business investments that can benefit you and me
since I am only 24 years old girl, I do not have any idea of any
business investment!

(3) To make arrangement for me to come over to your country to further
my education/study and to secure a resident permit and my travelling
Visa to come over and stay in your country.

Moreover, I am willing to offer you 20% percent of the total sum as
compensation for your effort/input after the successful delivering of
the trunk boxes from the security company While 80% percent will be
for me and my Education in your country.

Furthermore, please indicate your interest off helping me out for I
believe that this transaction would be concluded within fourteen (14)
days from the day you signify your interest to assist me.

Anticipating to hearing from you soon,

Thanks.
Best regards,
Miss.Esther.
