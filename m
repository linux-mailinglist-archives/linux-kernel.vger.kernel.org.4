Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663A47216CC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFDMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDMQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:16:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA92C4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:16:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565ba53f434so41522107b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685881000; x=1688473000;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69qYVcOgpdEYJVTzLtwWj8d8T2NR6kepXdK/z6duacw=;
        b=fO/vs34UPn5tiLVtLC9aLurcIwjTl0TdRP665w8MhitO/3wCkD/36Uk0J3lTf3w5bj
         UaLTEopuWVofhoImuBgWdik5eRkeHxgs1ln7BBX6RoMP2P0MZqvlzOynM5NKO7NPoc6P
         B20R5IC0kaT83Vl+ywBdggbqcX+4fv6TCPG8GE1n5kBWj4BySppUV4exrUkBsrtuo655
         ZbNcmDOIwmjAYM1Q3kk1TAjeXyp+QkGdtlx2yAP9kjt9kCTEm4QTH1G7/gOWlPHUwt58
         uDOmfP+hayAbm5YzZkmb33hY2dTp/9Nwe+aorADdC4GKBLY2QjVVXVxqBJHzwLAc5NPc
         vSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685881000; x=1688473000;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69qYVcOgpdEYJVTzLtwWj8d8T2NR6kepXdK/z6duacw=;
        b=KrW/lVumH7uyNioH0z5dHViLkycIspXqNQD+fZQVNEifNL9K2EC4VNjLqxbfnNHVxt
         B6iuaMoW0xQWUdePtH0ZxfN1pSHQPa5WMWOy5ByDqYp3GEu2Fx2Vo73JNLlACqAEoGXu
         rpKfgEpz3z/Z4+LuKtU3ygxTkFHCw1S9C1lSeGQwgKXBFWS5N5jU3iCxT4E1mUsDguV5
         2waCN9fmZFcZqUCUgYN7AtdrMwZUHjmBNv+vTcbf84fr/iYvitX4Qufoto/NIXX4Gjsr
         G2WFy/2vp+64jaF5Cq4JicWcgd6SKySLVYkggEAT7fq9BouV4ZZNnQgSJD5b5eloYI3Y
         LRXA==
X-Gm-Message-State: AC+VfDzHWGDBuPeKg2m0in0LPGPXlEiergd4rP9b0decflp2gQxFexZO
        jFy62s75XdyCsOaYoJ9FnVpZhov3RYGACSm+UMI=
X-Google-Smtp-Source: ACHHUZ4iwcPk9qVktEgt3TmbmVmb8eIbHD+yubANDgJ+RRXvpUJT4TbnI7KtErCpOPPMr2SrKuIB3viC4V+PBkZ7N4E=
X-Received: by 2002:a81:a0ce:0:b0:561:abb8:3b38 with SMTP id
 x197-20020a81a0ce000000b00561abb83b38mr7120374ywg.17.1685880999925; Sun, 04
 Jun 2023 05:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:6911:b0:30f:c292:e9f8 with HTTP; Sun, 4 Jun 2023
 05:16:39 -0700 (PDT)
Reply-To: jonescook558@gmail.com
From:   jamartin473 <jamartin473@gmail.com>
Date:   Sun, 4 Jun 2023 13:16:39 +0100
Message-ID: <CAAhTPbfJNOq5BYpWJ-r_nypZMi=pC1HmvUN=H+p2PQZxz++LnQ@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jamartin473[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jonescook558[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jamartin473[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

I would like to bring to your notice to supply my company a material
used in production of veterinary vaccines and feed supplements.
This product we request may fall out of your scope of work, hence we
would like you to source the product and supply it to my company on a
monthly basis.

Please note this is an urgent business proposal to you for our mutual
benefit, therefore I require these components at your earliest
convenience.

Kindly reply to my private email (jonescook558@gmail.com )
if you are interested so that I will share in details with you
regarding this offer.

I now await your urgent response.

Thank you

Regard
