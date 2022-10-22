Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E420608F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 22:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJVUlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:41:45 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DFDCADF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:41:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 1so4493588vsx.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=mMXnHE2jkEoKwZPGDdmZJDfFAGQtJnF4ttjQru9IV9yoRrQP0CoheGJXMgk/+cUT6U
         W8q2mczs07PLGk+V+04geYp2/bPcXqUcavJTvT+Zsky6VL0RQjGeTvniz9RcvIq8YDTQ
         QnK7Vfe296qwOImib8bAPCN02PU8oJQS3fd84UcpquY+77e4ejx5IJZjfNmL9e6w7k6e
         NPqYuJ5Y9fc2OyDoO6NUGFtDO/5DJg2XjMDwbBWS0p4rRpfHA8r1kG6C5hnb3hTbv5nl
         Yg3oeToRn8y0+Awxa3jEgYhVjCmkDHJJXmGQOxUj1CrnuEJzF7OPLSVjLf+i1vSMumtC
         p1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=gSycCJ2B+ssn+RHRPNP3ptn4wrvhWkiTvnNb4Xc+yadYVaNHRUU645jOLbkqCdFvp2
         wiB+KKv1PHXpgPHO04vCeloujsePKr7LQ6uOqX+qqOv3ldXe6x4Wb+0lRDady+EggqUg
         Q96iUq4awpj1Pax4q5sE/X2/vWS5Sw9HDREgt52b7iBr5tyRe/BQncpwfFPH38k1XG4K
         4f1bAzur6aCXt8wTHofMbTAnWfCmSBV1LT5YF2biGwa1t9hDyy2KMr6wsVmZoDAEn4Ru
         jt+guMRVJhJI1a1YE6ut/Yeyg3DUd6QQm7fhGLTeN9CRpN2am9G0cZEVQLZ3nAhTh1Jr
         L7lQ==
X-Gm-Message-State: ACrzQf3fac146KwWpSEt1mCnfjYLal4kh99DlRkcCiWe0dlYRwJqKTYm
        7HnMKWpOMqGOiQJvWeNT33PK/lyZlipqI/cKOvE=
X-Google-Smtp-Source: AMsMyM7wqn/TWgRi37Of0kHT3Q53wXsnl+FZFnwiThrekfEnRgXqi83MGMxTqgWJOLBXr3BmpOOdg4UyUNGey8aVAm0=
X-Received: by 2002:a05:6102:15ac:b0:3a6:3e41:b163 with SMTP id
 g44-20020a05610215ac00b003a63e41b163mr16250105vsv.81.1666471303924; Sat, 22
 Oct 2022 13:41:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:2106:b0:2d5:1bad:2def with HTTP; Sat, 22 Oct 2022
 13:41:43 -0700 (PDT)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <matlgxl@gmail.com>
Date:   Sat, 22 Oct 2022 13:41:43 -0700
Message-ID: <CAKXX3NGAEc925EVXcTzp+jZeXnVSPc5_Ee1bYoSWw7E=HEVFsw@mail.gmail.com>
Subject: Reply and let me know if you received this email.!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5008]
        *  0.8 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [matlgxl[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mmrstephen16[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear, How are you today and your family? Want to believe you are
all doing great.

Please reply to me as fast as possible. I have important information for you.

Kind Regards,
Mr. Stephen Melvin.
