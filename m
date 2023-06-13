Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BAC72E1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjFMLfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbjFMLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:35:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEDD1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:35:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bc4114d44a8so3477698276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686656104; x=1689248104;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNTOOcYs6QiwIcGuff8C5MjpY4DoNyMZWdXvOobg4H4=;
        b=ES+OwLddxR6XkSiPaC1trd/qqwD7olYVtrJN3YAdCQVgC9fuvOhEh91ZSNkwRqoM8M
         9msrW4kjdPs98pcZqX5YAU7kruhsCRL0b+Ifm1mz6nnq1aigtFNIM0wEgXSY5gC9yvaF
         NrM9qeHXM2arORy1aAZJ/RoJYq6td6glmR+DCv18qJyMJegBQt1+GCHlac/NvafoR6iB
         7muVAr9LjzH44oYlvEGe+D7DMoes5VkT3QvV+VW7jGUle9LhG7Gw3iTWft7GsaFRakgO
         Y94/VPPaLAsMY6TEzuH+3iA8veaqb6SFpj4N6uvCAS6dcGljOn0ALnD15qYcfj9c/6jA
         8q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686656104; x=1689248104;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNTOOcYs6QiwIcGuff8C5MjpY4DoNyMZWdXvOobg4H4=;
        b=ibWzP7vcSI/MWrqZKlNDrFY4urWhvHWv5YPYvTSFTavGF4Trt9u3wccIsX5HazL7mX
         a59glbYBMsC9aIhAxVoYWKdiEWWJM/OKgjiDicdbgipADEWxZ2dDc+L1nRPa7r+ybsMz
         sDJ/lQLiefIJ8QwPAK4MiwHIKKBvh8JxRnY7TtLijcwTGrPVp5UdzUwJK+Cq6X6jOCCb
         lAl8nVN/mDZUtiDt5dZIz453SAtbih3YVouS9W+qaowcmVTrZyWSjFIsPmhIE0ksBmdt
         mWDrkFLvvX1kHH5pAyWqgaV+iS7vrCOFSyibdMpeT0stMRRS7a2561fr34ZUss4aIZ70
         fV6A==
X-Gm-Message-State: AC+VfDzgIr0rTeL3aym/744L3E1f5k/3muGu3D4Ah+JzAPuVLxRY+6uP
        /eyXp++iiA1BsWHqeb57DDTuTRBmNlWCqN/F9co=
X-Google-Smtp-Source: ACHHUZ69SunP7+DbYEAl/PXmBFQR/SDgxOmgmZu7f2QUUF4MMU99tN/nL17n8hnLKzrrnJIrj2LBStUpT3EgJmMsWlI=
X-Received: by 2002:a25:23d7:0:b0:ba7:ff37:45ff with SMTP id
 j206-20020a2523d7000000b00ba7ff3745ffmr1143531ybj.39.1686656103798; Tue, 13
 Jun 2023 04:35:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:1e9d:b0:4d3:d013:c32e with HTTP; Tue, 13 Jun 2023
 04:35:03 -0700 (PDT)
Reply-To: ailmusa8886@gmail.com
From:   musa gold <henry14241541m@gmail.com>
Date:   Tue, 13 Jun 2023 11:35:03 +0000
Message-ID: <CAD__WERoKLpW6ZLC=_uF-JTM5FKZOQ5yFMQGRk_Bon401kkHRA@mail.gmail.com>
Subject: Business proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [henry14241541m[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ailmusa8886[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 good day    from ail musa

I am the secretaire commercial of local community miners association
located in west Africa Burkina Faso,we control 87 local community mining under
37 local government area in different part of the state,we mine
between 10 -50KG of gold nuggets mothly.The gold nuggets are smelted
into gold bars of 1kg specification each at $38000/KG

Our gold is usually 22.39+ Carats, PURITY 97.999% which is refined


into 24 Carats,99.99% PURITY in buyers refinery and also we work with
(Refinery Bamako) Commission $3000 per every Kilo the buyer will buy
from seller side to agent

Red Mercury is  $8750 for1 gram
Sliver Mercury is  $4840 for 1 gram


Kindly contact me privately if yiu are interested or have interested

buyers for long term relationship contact us on Email(ailmusa8886@gmail.com)

 thanks from ail musa


Cordialy
