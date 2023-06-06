Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED31724153
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjFFLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjFFLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:51:59 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D189CE4B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:51:56 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-5556e2bddf9so2862348eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686052316; x=1688644316;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egwO5+jRcHqhSVFUfUGWVJVk/4clvS0mJ+iA2ckPsK0=;
        b=MpHepUD6suDRUNvVw3b4M2V9D+M0MvSMQ8Er/OaSwVuUGftITVcK8teZyW5q9xlu0x
         f3sNZoh8/2Zwxl4qxbp2iRzBAaTl9GbZAi1ZI+n7FCZe9w47UVS0sab6s69G9xTIFnO1
         J0BAYEwRIgdGfjxY60eADdPPXq7mog640SpBfdd370HTFGmVflOhFKGSReC0uSYICCPz
         +1aMOJ5USK++LcOJJLouaTMpOyXo6uhVKagw267UfqmvXbZqQxnquzV+eI/RRD4Divre
         n64QcbWIC28KYGwju7PCMHIHeeD5+taVw0mGBPLcL8iU0MpSDLYgKUFOOKNNdtut1Mba
         y/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052316; x=1688644316;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egwO5+jRcHqhSVFUfUGWVJVk/4clvS0mJ+iA2ckPsK0=;
        b=Y1VxuIaDorIfzoLvvfyCy8R/yDXpkJIIV7lE1i+Qn5vpjZzwmaasQZ8iDs5BuVr3Z+
         EreZR4R5cvWf8PZ4MWpAWlznamA89PinlW0TP3DpQimjkTvtKe4gF8lNIlIAEq8E6iWS
         lGdAoHbQqJgMsZXKC9BsGLdqivMGVDk0H5Y4bz+SdLk8kxT9SWTqsGQDY1djUpkHNj1J
         MJA8PEVlNqRxwYTxcAwqQeSGEeXirab1Sa/xWMKMUlNztkXpJaQ7yYbyDg6bamgDZQs5
         elrgPeGRtJ5ROqLQbnpIaZeK66xclI0VVN91Mo3Jevja2rWAkx454Js4dFavKPjZCx51
         j88A==
X-Gm-Message-State: AC+VfDzpk/8Zo0fGbShUfIgWfmmAu3VTZR3rGahfrm0nAPp38jm/BmJe
        KHiPl/38N/RTChxa3GSOCrt53kjPOIDp55N29cU=
X-Google-Smtp-Source: ACHHUZ4l97X7QMhnWb7JVZt8xE00n1oZPWBUqdZ+KGSubNIpPs6UC4693mDCSYZUlXqQ+RWhZ0BLb4490oLnQlvIlI8=
X-Received: by 2002:a05:6808:6388:b0:39b:dfe3:20b5 with SMTP id
 ec8-20020a056808638800b0039bdfe320b5mr827499oib.26.1686052315582; Tue, 06 Jun
 2023 04:51:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: abebeaemro99@gmail.com
Sender: mohammadrezan866@gmail.com
Received: by 2002:a05:6638:1683:b0:411:9b00:322e with HTTP; Tue, 6 Jun 2023
 04:51:55 -0700 (PDT)
From:   Abebe Aemro Selassie <abebeaemro99@gmail.com>
Date:   Tue, 6 Jun 2023 04:51:55 -0700
X-Google-Sender-Auth: c_MJbOLon9ZMqzbl7MxTW6fP2Oc
Message-ID: <CAFM=SVjO9GEY=iT_h64_2MaxLSV5OAKTUzETawxzCWM6gcTJ-A@mail.gmail.com>
Subject: Greetings From Mr. Abebe Aemro Selassie
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_3,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings From Mr. Abebe Aemro Selassie

I have a Mutual/Beneficial Business Project that would be beneficial
to you. I only have two questions to ask of you, if you are
interested.

The reason why I contacted you is because am the account officer of
Mr.Jin Wei-Liang,here in our bank,who died in covid19 pandemic with
his family,since that time until now,no one has come for the money,the
meeting we hosted last week with the central bank president,bank
management agreed to take the money as government property,that is the
reason why I contacted you so that you can apply to our bank as a
cousin to Mr.Jin Wei-Liang,because I have all the documents concerning
the disease customer in my office,I will be here as asider and be
giving you informations,anything bank asked from you,I will give it to
you because in this life opportunity comes but once,I have been
working for this bank for good 13 years now and am based on monthly
salary and never achieved a tangible thing and if I don't do the
business with you,bank will still take the money so this is the reason
why I contacted you so that we can do the business together,the
disease money is (18.6 million dollars),50 percent for you,50 percent
for me,if you are interested respond my email but if you are not
interested do well to inform me so that I will look for another
partner and please don't expose me,delete my message because if bank
finds out,I will be in big trouble..These are the two questions I
would like you to answer:

1. Can you handle this project?
2. Can I give you this trust?

Please note that the deal requires high level of maturity, honesty and
secrecy. This will involve moving some money from my office, on trust
to your hands or bank account. Also note that i will do everything to
make sure that the money is moved as a purely legitimate fund, so you
will not be exposed to any risk.

I request for your full co-operation. I will give you details and
procedure when I receive your reply, to commence this transaction, I
require you to immediately indicate your interest by a return reply. I
will be waiting for your response in a timely manner.

Best Regard,
Mr. Abebe Aemro Selassie
