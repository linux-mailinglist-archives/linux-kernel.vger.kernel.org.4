Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C973A2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjFVONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFVONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:13:02 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4010F0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:13:01 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-78caeb69125so2908128241.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687443181; x=1690035181;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znGg349Xo9TtHurkn031UR2KOdzyHK5vxKXGkG+tGZ0=;
        b=kRWQfEeMXIg4iGoBcuXEPHaISfj5KEHhtIJDhV2uZkF4eHcvpXekCut5EEXlplg2fM
         lfTgF3whFKJmR5uJBq5g9Y/o3i/I7o+lIGjZUsj9bnxVHIsfIvwaJ6dFcu1csQVhknBF
         GtGc2AMe0XjdaUhrEAWELhWh3JeDVAxNC/ihFXm0boLk8XumAVfJdFgfqrv1N8H/lolH
         QZI36BMS2GE6mpEu9jckabKwvr9vlNSr3+2BQa0gcLw/lfTSEWxyKiCw3sruYmTkRYpv
         sYue3JICfMhVWcr/Kn9FTFaAkZFPrPMEgnjIYOzb1JhJ7QP6fzGUfaetLp1DZwHTUMoL
         5ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443181; x=1690035181;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znGg349Xo9TtHurkn031UR2KOdzyHK5vxKXGkG+tGZ0=;
        b=Iywe/i9hcXALnys/faWx4hy7V/GVKIin0RPybtbjcvBOMkCpNhxODDrABOZc0nX6Q7
         9iHkN6QG/4LNbEhJtxmQKpm16L0yY7zLAk0dFwpC3jZpyA+d/fm/b+syvgnWo8+UZLK5
         XcxAvCXi7zpdzHA2BRTMwtTPk2o94DBNRg3lgV+Omy13NWJuHtK3bAvZQddX/Jk0Y7Sf
         D+USpSQFtF4DiM2j4+8yD+ai45wM+x8P3+2SVSAK2PvWdC4NZCT9xABAB37gFQ2FD6/s
         ZaFH83WAuvz4LztvODLulgN0tR6BR1WI3nA813Efg0AlK9zVGnxZGFTHsh9d6Fcl1mb8
         8UEw==
X-Gm-Message-State: AC+VfDzfhwigbiQm+aZDNabl+lnwbQ1IQWPKuJFitjaxGSSaMuv/UOdY
        kcdufTukj4sisRd5GXomuNRWycLEPu21IhJQido=
X-Google-Smtp-Source: ACHHUZ5BHoKOTeiPAPe6J2DZlGR5OAGHzRNIWDjYkffqxFVXSl9qdjW6dvleIuJBjYueZmbww+Lw9N90yJido6b7bJ4=
X-Received: by 2002:a67:ea8f:0:b0:440:cd2b:4787 with SMTP id
 f15-20020a67ea8f000000b00440cd2b4787mr4526216vso.35.1687443180684; Thu, 22
 Jun 2023 07:13:00 -0700 (PDT)
MIME-Version: 1.0
Sender: moonleepark07@gmail.com
Received: by 2002:a59:b3a2:0:b0:3da:4546:c65c with HTTP; Thu, 22 Jun 2023
 07:13:00 -0700 (PDT)
From:   Aisha Algaddafi <algaddafiaisha247@gmail.com>
Date:   Thu, 22 Jun 2023 15:13:00 +0100
X-Google-Sender-Auth: EKgiq0zkKZIsispvQcO06XnOqv8
Message-ID: <CAMgr=-pX4qt9Zt-nGD+o6YsRd9UZXUTO8ZV=WB2nDc8v2FuX6g@mail.gmail.com>
Subject: GREETINGS MY BELOVED ONE.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FORM_SHORT,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:932 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5880]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [moonleepark07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [moonleepark07[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Permits me to use this medium to open a mutual conversations  with you
seeking for your acceptance towards investing in your country under your
management as my partner,

My name is Aisha  Gaddaf and currently living in Omani, i am a Widow and
single Mother with three Children, the only biological Daughter of late
Libyan President (Late Colonel Muammar Gaddafi) and presently i am under
political asylum protection by the Omani Government.

I have funds worth " [ $7.500.000.00 US Dollars ] which I want to entrust
to you for investment projects in your country.
If you are willing to handle this project on my behalf, kindly
reply urgent to enable me provide you more details to start the transfer
process, I shall appreciate your urgent response through my private email
address below:

algaddafiaisha247@gmail.com

Thanks
Yours Truly
Aisha Gaddafi
