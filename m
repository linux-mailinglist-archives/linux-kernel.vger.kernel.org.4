Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E26D3341
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjDAS4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:56:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FBFB763
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:56:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so28818798pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375373;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXcG1+c5Jl39ysxbFzlW+WnXY9ydxR0wHedPIyhRzvU=;
        b=LNRHqxuyfJhbXQ/b/4tDU3gMwfoWxDWpVS+ANxapv/yTjv2rnql7u2KM28buwg+GT5
         Qf1L1j2qwR0fYo1qe8JjqAGDJFcwZogHT6yBsvg0UI+ni4rSZVWPHdK7Vtff5Ja7/HHl
         OzjjICYQ02FuXjADppqURMoYkGVcwN3JiZhwg6hdEZPyw9wIiUDpKAY5HZE/bPTX8Pc/
         q7xeoox0NIlRDvP33Vco+hH1JQrj7+Yit/5rZnd3rs8OR6t1rNH8Mm9de20A4Kx2dI+V
         h7VOXSUnhpgwuJCubK50HvwUDHKzDX5z0XXxsz3d7bimULbClhcvOqsFliVToeuukSIv
         1ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375373;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXcG1+c5Jl39ysxbFzlW+WnXY9ydxR0wHedPIyhRzvU=;
        b=D+wPaIjXiaSk3JZ+9L7W2LBwmm6NTNs/VI5rQmPINKJ6gu/beLenWTxBZEuAqPTTFl
         JpKMMBapAQrcsgP006BZBpyeOX7dBLgLs2xIwOdL5IbfOOFs17I78VLPsVxm9+Qo0W8K
         /IzOw8lp5GVtxnUL7dxBvKAE9j6co8+0lo2TVrz0dCFFlxdl1VMGSwnj2RiBRpwde9sa
         qAGuJnJhbQruSEx50K6lqOerlZ2CDUpNEG3HvNS/bP9MiBR80/Ft9m41Yl7kfRsVa7zb
         0RkHbvoEFOwgBqsH+Wo31BmbLHLW1SrK8TgGqD8hQ9hYAO1HTYDzu69DoLxKkj0F0sEH
         2pvQ==
X-Gm-Message-State: AAQBX9eZL27faSpStlFQe2xbP/c713oidxBJhARqJeeZB+LxsGGBdgcy
        93OCA0VT3fBM6Z58SJpym7ndX6MUecPyfaZTAIs=
X-Google-Smtp-Source: AKy350Zj9jMGv7x+aGg83kutUm7pRaSj6gAH3IZdrFyjnOv/Ib01HNQ7bbPu7XFqsohz2UeEShrSe2ldrftFZJyWG6M=
X-Received: by 2002:a17:90a:d684:b0:23b:517d:beca with SMTP id
 x4-20020a17090ad68400b0023b517dbecamr9708225pju.0.1680375373221; Sat, 01 Apr
 2023 11:56:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:320c:b0:99:61ed:ff08 with HTTP; Sat, 1 Apr 2023
 11:56:12 -0700 (PDT)
Reply-To: Mrs.billchantallawrence9@gmail.com
From:   "Mrs. Bill Chantal" <larbanamountougou@gmail.com>
Date:   Sat, 1 Apr 2023 11:56:12 -0700
Message-ID: <CALhVCXqbydbyVV_Ks=BTaJ4XaNxTwMrCHYF2XMThhqEF0TMSEA@mail.gmail.com>
Subject: HELLO...
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_ATM_CARD,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102f listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [larbanamountougou[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.billchantallawrence9[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_ATM_CARD Lots of money on an ATM card
        *  1.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You have been compensated with the sum of 5.9 million euro by the
United Nations,The payment will be Issue in the form of an ATM Visa
Card and send to you through the bank, To receive the ATM CARD We need
your Address, Passport and your Whatsapp Number please reply with the
requested information.

Thanks
Mrs. Bill Chantal Lawrence.
