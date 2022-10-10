Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AB5FA101
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJJPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJJPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:16:37 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF76C12F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:16:36 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id 63so11561300vse.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gixYlXXeGIaF334dRye1m0Z433fh8kxpeDMk8/39luc=;
        b=aROlY8KnlcE3y1QbojvBEENrPj9NMwKdZrbCNZIxttxaVZmSPZAjROejKTCfeF0+UZ
         391+2Ca+4AaCphJQKf1ei7CYoez4StuhN/uYIEJUVQjvlWItWXLF0tYFxp+Lag9hc9WO
         +lNjx/VbK5N/gWqDlq+5hpJViDVXa6bTVj+216g9H548tQ/hkS63xlfyM8jNxGUREeyC
         hBdxtT9WtfvIylyMJJDhEkQKnVcOzX401xIMDtYeuC+fV1INCT9TVS3+URUanL/LY+ZU
         0mne2UKUXumxRDH/JiG2E2EwlS6Cm3Z8RGkVp1/Lv4wig9f1uduDTtuEU75zXoi96jF7
         FvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gixYlXXeGIaF334dRye1m0Z433fh8kxpeDMk8/39luc=;
        b=GtZTMifx4ddY84J7Mjzey4F41D6SQe86doLmTaGKwNBmxuHjUaxYO9ZKnm4gEo3NSq
         dpN9dBZFyNpbfwMJ7eEr0DR4nBV3WGLiEZ01I5V2pblHzj5o1N9ZR0+2iitRWdBVNX5h
         OiLuCcv1zaLvinXB7o7scIJJLYoCzZDOk7oixZ4ZEZ8ZulQhSMX3UjbL+3NxDon8SKHb
         2Nec1iBAt+tOPnmh1hx3oeRvrtxb6RTfp9vYc1j3qdvUKG7ia3O7gJEhb3qAd74nqFMK
         Apmm8ai1DWzGC39QSKKMNfD1gi1QuTdQocEK4g5TGEeu+LPJPrGJKKbn0YMPuxryTyYI
         xMCw==
X-Gm-Message-State: ACrzQf2d5GgTAP1btIAW7ATTWG5p7FnLXyCmCb/uN8X3Cm5OIlJd6XRa
        P4xk8MEBO0s796mYdZnABGw5xqdzfH7MV/4TSQTLTwhNNTA=
X-Google-Smtp-Source: AMsMyM51N0wJ6zcDz4uVTuaWLVHXakB6Zmn9vso4jKlsvO3jZPdf2OLJle3yugadCeksjEPWUu1mchcUCXnap/sKYjI=
X-Received: by 2002:a17:902:ea03:b0:180:b53f:6da with SMTP id
 s3-20020a170902ea0300b00180b53f06damr13793062plg.69.1665414984602; Mon, 10
 Oct 2022 08:16:24 -0700 (PDT)
MIME-Version: 1.0
Sender: ukabore83@gmail.com
Received: by 2002:a05:7300:4349:b0:80:2ab4:c0ea with HTTP; Mon, 10 Oct 2022
 08:16:24 -0700 (PDT)
From:   "Mr. Musa Ahmed" <ma3352506@gmail.com>
Date:   Mon, 10 Oct 2022 15:16:24 +0000
X-Google-Sender-Auth: ldJXryd44hRuUejakT1GIDVr3RY
Message-ID: <CALpcmOUwExD9KXNWRDzk6Ht-3pphTOFXitUjpka=oo07Vf0Mcw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e29 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9728]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ukabore83[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ukabore83[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am Mr. Musa Ahmed, a banker by profession from Burkina Faso. I have
a very confidential business proposition involving transfer of $
18,500,000.00 United State Dollars that will be of great benefit to
both of us. Contact me via my private email below for more details.

Email: ma3352506@gmail.com

Best Regards
Musa Ahmed.
