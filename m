Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B656D84F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDERdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDERd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:33:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E0C6;
        Wed,  5 Apr 2023 10:33:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n14so19232128plc.8;
        Wed, 05 Apr 2023 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680716005; x=1683308005;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfIxSAgBnjoBsJTsm7apfl83bnVQsBjbMBbd20jd8Yo=;
        b=BVf6VqQ84/eKA/OKP0d392ZFkWvfA0Havc7uTLgejYFMbKIZOroTgT7FBFH6wCXKR0
         P4syjSTVOsTJaFW+gMDyQMwRDIqhOzc9CE5ie6oNwEdBfg6axPYAJkS4x3+9KsKhxXaJ
         3LDk7MEuwCN18Yhqtul9GzIrOvKFQypQBv5USw3QnSvPjDhSUrU7px+THEfuUFEvQFiw
         CvXxqvgsAJqgJelxJwebbjZ38kwZQuvdn6X3Q7g1/B896+LzaYRg3REofOMfqLNYKQIA
         ijyJeuxngNS1qSwCMGwFI/NUK6mmxZ7mkgNLeCILwoTtQBY9S4CrbqOX7pSwAsOR+3/D
         LpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716005; x=1683308005;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfIxSAgBnjoBsJTsm7apfl83bnVQsBjbMBbd20jd8Yo=;
        b=Qouo/KdkeX0HPbIwGaki8xKNpLQdK/hdng/gh3LW0EJkJP9iNkOGZkPpYs+zxlND4y
         +enTWdYfBFUHnt8vWEscLjMrDYnfFBa//0wM/KuCTD4/TDNy3CfERKrqJytaqhev9RNK
         BQLd8eqKtGRs2usaIGNw0D6rgT1lPzEY9rFggOy4f2rQwaK417hYtFpa9ACLLg6xylRk
         hkNR3R+npq7gbF0/EYmUdVLC9hLkZ+1a1YJbylxvnbWLlzi29dwv0W+kWn0AzX3xAupa
         o9ssqtp5XKpbjF/hSxpLKTVSsPnbiPd3hxWXK+xg2+sgf+nwaBMYSl82Vgt6Q4SHnuhv
         34gQ==
X-Gm-Message-State: AAQBX9dkKwyNpgsqcaqbzjxeGJzVot6GYEACzWydewyJVTrs6f5ZI3O4
        zdn3gRlnyhjbKwROKBwQbAZPVXi5SxA6S/IPtWBUB+nBeqO9Wg==
X-Google-Smtp-Source: AKy350bDm99Rv+LuGpHQe773/4/0M8pyMVzIe2nOEMsW2ByGSDXab5KTd3RQx85MZpH+bfrQlgOm+ma8ibTz30cHp5g=
X-Received: by 2002:a17:903:443:b0:1a2:ab1b:b62c with SMTP id
 iw3-20020a170903044300b001a2ab1bb62cmr2876155plb.4.1680716005362; Wed, 05 Apr
 2023 10:33:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2d49:b0:3bc:b7f6:a3f2 with HTTP; Wed, 5 Apr 2023
 10:33:25 -0700 (PDT)
Reply-To: yapcoylillia52@gmail.com
From:   Lillia Yapcoy <lilliayapcoy@gmail.com>
Date:   Wed, 5 Apr 2023 19:33:25 +0200
Message-ID: <CAHZfu_mb4Oa1JFx4NGpXr9yQ+Tkife=CnpZJh8-BoJiVQA=K2g@mail.gmail.com>
Subject: Succession Opportunity
To:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:631 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lilliayapcoy[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [yapcoylillia52[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beloved in Christ.



I know this news will surprise you as we have not met in person or
worked on any type of business transaction in the past. In fact, I
found your contact address in my search on google for a godly
man/woman. Despite this, I have contacted you in good faith and I hope
that I can believe that you have this opportunity, which is explained
below.


I am Mrs. Lillia Yapcoy from Cape Town, South Africa. I was married to
the late Mr. Henry Yapcoy who worked in a construction company in
Houston, Texas, USA for over 18 years before he passed away in 2019.
We were married with no children. He died after a short illness that
lasted only four days. Until his death we were all born again
Christians. Since his death I have chosen not to remarry or have
children outside of my marriage, which is against the Bible.


When my late husband was alive, he deposited a sum of ($2.5 million)
in a bank in Houston, Texas. Currently the money is still in the bank
and recently my doctor told me that I will not last another 3 months
due to my cancer. While it was my stroke that bothered me the most,
once I knew my condition, I decided to donate the money to the church,
or better yet, to a Christian person who will follow the instructions
I outline here as the money can be used.


I want a church or godly people to use it to fund churches, orphanages
and widows to spread the word of God and ensure the house of God is
upheld. The Bible teaches us that blessed hands are those that give. I
made this decision because I have no children to inherit the money and
my husband's relatives are not Christians and I do not want my
husband's hard-earned money to be misused by non-believers.


I don't want this money to be misused. Hence the reason for this bold
decision. I'm not afraid of death, so I know where I'm going. I know I
want to be in the arms of the Lord. Exodus 14 VS 14 says the Lord will
defend me and I will be silent. Please, I don't need calls due to
health reasons and my husband's relatives are always by my side. I
don't want them to know about this development. With God all things
are possible.


As soon as I hear from you I will provide you with the bank details
that you will use to contact them. I will also issue you with a Power
of Attorney authorizing you as the original beneficiary of the fund. I
hope you and the church will always pray for me because the Lord is my
shepherd. I am fortunate to have lived a worthy Christian life.
Whoever wants to serve the Lord must serve him in spirit and truth.

Please keep praying all your life, any delay in your response would
give me room to search for churches or individual Christians for the
same purpose. Please assure me that you will act as I explain here.
Hope to hear from you.


Remain blessed in the name of the Lord.


Yours in Christ.

Mrs Lillia Yapcoy.
