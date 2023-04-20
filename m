Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282466E9C74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjDTT2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDTT2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:28:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F5E40CD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:28:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so88316366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682018887; x=1684610887;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FQzF34rdBW8w+FN0s1ouVT/A/E8MA1y0Ug/Ly6m9JE=;
        b=Sc5QxArL2XI4vTVR9p1fZwZATjb6xYPRN1IS7AddjyoIyHYEuP8u6HpWCRYLrkXZfM
         03A3nrAQOdbXhB+PzhHA5VliZlTIGNh/oNjRiVv4MY/8kRGColu96JBYiKEAaZytXS+Z
         nFR3un6am9RrnMgImOqiCRawwvJC6moPwV3D/bsJiovkN1ZjO9fi4nsSbDkmQ/EmlyGU
         A6N82XL++RYMn2KL/ZP8EtIwVeGqPFd9C69H1WGYxP4EFx3Ux53NyjHj2q61gjZjPrfn
         ZVX5aqT0AFFJhHeoZ02qF0rrDu/2XRimUf2rU288FgoaqmwdN3WKd2ybszfCX7FnHM2q
         fqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682018887; x=1684610887;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FQzF34rdBW8w+FN0s1ouVT/A/E8MA1y0Ug/Ly6m9JE=;
        b=JD6XK9qeZv3knZ31V+VHm1BffvvDfe+wDAj8fFV3Ym5GYUuxGgZDRmTugZ7ovTkzXz
         /Coxt9XFi5P12ytqz1aVRPpMhzNP24mBaBfQlp6hJSsHXoCChZG21pWUH01/1f1+MUJM
         cBaaOPw320QxNaOA89E8rHg4++98wqrj2wNLkDPnNvtX7IUEiK5gODnp3l0U7Wn+53tg
         ozkCNyAGUBATeKANvxwGGA0zV43BUU0RUju1kKi5A3sM4dD/e0z/WGezDFhSpK3mUMNs
         kULWS1NlJbwJyTiLV/Oj0K3KugvdvX6e/wv+leKiF8oY+J6k3u41josEZgX3ibVfhscr
         JifQ==
X-Gm-Message-State: AAQBX9cPnc8af8ijdmL6G+6V8ElM2plzblICo2NH40Eobkl9JYWZBIKU
        DNldZdf2LiPDqbr2C0vBnw1nZgAzG07TDHzBShM=
X-Google-Smtp-Source: AKy350aGrXICLa5kEPVzStVqUS8w8fDuC4P5LQPX64p+WPSXwgQB14dlOm4K8nRNe9pkx0lAmx0v9bfvW5xpDny7vzM=
X-Received: by 2002:a17:906:2bc4:b0:92d:878e:8566 with SMTP id
 n4-20020a1709062bc400b0092d878e8566mr19720ejg.10.1682018887309; Thu, 20 Apr
 2023 12:28:07 -0700 (PDT)
MIME-Version: 1.0
Sender: sgsgh707@gmail.com
Received: by 2002:ab4:8f87:0:b0:200:fe72:1ee9 with HTTP; Thu, 20 Apr 2023
 12:28:06 -0700 (PDT)
From:   neemakimjohn <neemakimjohn@gmail.com>
Date:   Thu, 20 Apr 2023 19:28:06 +0000
X-Google-Sender-Auth: dXN2Xhfe4VDVK2-_1smP5Lx-IX4
Message-ID: <CABZMO48oVn+q_8Pooiefw08v=zG+nCZQHE2WRvC2UquhBMDQSQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

  CHARITY DONATION Please read carefully, I know it is true that this
letter may come to you as a surprise. i came across your e-mail
contact through a private search while in need of your assistance. am
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through internet because it still remains the
fastest medium of communication, I sent this mail praying it will
found you in a good condition of health, since I myself are in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day,

I'M Mrs.Neema John Carlsen, wife of late Mr John Carlsen, a widow
suffering from long time illness. I have some funds I inherited from
my late husband, the sum of ($11.000.000,eleven million dollars) my
Doctor told me recently that I have serious sickness which is cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way Am going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained,

I do not want a situation where this money will be used in an ungodly
manners. That's why Am taking this decision. Am not afraid of death so
I know where Am going. I accept this decision because I do not have
any child who will inherit this money after I die. Please I want your
sincerely and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. Am waiting for your reply,

Best Regards,
Mrs.Neema John Carlsen,
