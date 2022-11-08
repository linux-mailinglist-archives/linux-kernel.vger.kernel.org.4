Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14895620AED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiKHIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiKHIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:06:53 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387116155
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:06:53 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id y20so4563694uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7klf8Pt9pGDm9RAISbYc6ZqKfxF9aWkFYgjwxb2BK8=;
        b=Ge791icZ2wdqUIMbKuD2LwC9Q8XxQoCwotOx8J2KI/WKInMF3vBKT6iVj6KZ+zQOFR
         ftvzJLejM0H9XOJPoLs6fXOvF5QcZ0uf4oxPkpvnhM3jAWDBfDZ7K5AMh6o8wxEA/o0a
         xJrvtNMn6hX3obQ7nmmjB90clXNA+VlK/UfbghES/eLizsCOzbHL7u/QlBZxjlRJswoc
         Hzdtz/P7OCdt3QlZvDWdY3Rte8jyGPwZ9UvgB6OT0pnrBRAw8hU2xi8+P73crEeWGnKF
         IJrZwLrCHa4OIsJM5B5/p8MFvJ0epMsYRwLBq9bhKSGlZsuoIlHp1mErZZrAR5orGGgD
         9KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7klf8Pt9pGDm9RAISbYc6ZqKfxF9aWkFYgjwxb2BK8=;
        b=P5yqkKFHzX+sSwDtSbOaFVDIIE/sm/vCLFJojaFbiF2c6NmOR6G4cnSD6CZHio/0/G
         xRd4cwqWJYTq58XII2wFeicN4KNCCfkVFxTypNbM+ND9BwXI1BqYtGDTYvBoM32siyCO
         pUVB47CQLoDOqoJTD3IKWsXszIT4vUZC5ZTQaJKAblP1+c0x+DrSdz5exETZYntoEbDN
         w+Z2LkXvxdbKaEVK05L/95OmElYqwvA689zPhz1SO+JeZZJsRDOF3lheszfRvRsiSK5j
         PobK8A9/WS/TyY3PXL2E4CJL67DgwR1YQGXBI27yyx4GD0KlyhDdOLhfCYHxGIIv3WQ5
         Zb9w==
X-Gm-Message-State: ACrzQf2p6+/xMTn8zXmUOWi1eV2CNy/3lJInD81LAWzcNBaRZqI2Iwg0
        S6p5+EAgPX9fKnx5ca8UFsQWED7rKFcScts2SrU=
X-Google-Smtp-Source: AMsMyM4P4zel0EyhVRXMnDZTawdiDwndX0LjGwTUoaixwe7ggQTP5Be98A695P3WA605k0AKfTU8Wf0suMr+Wq0C8VI=
X-Received: by 2002:ab0:132d:0:b0:3de:4c7d:2b08 with SMTP id
 g42-20020ab0132d000000b003de4c7d2b08mr15946787uae.32.1667894812160; Tue, 08
 Nov 2022 00:06:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9f:3043:0:0:0:0:0 with HTTP; Tue, 8 Nov 2022 00:06:51 -0800 (PST)
Reply-To: m.elson90@yahoo.com
From:   "Mrs. Karen Elson" <ibrahimagcisse563@gmail.com>
Date:   Tue, 8 Nov 2022 09:06:51 +0100
Message-ID: <CAG9Aq9bq=v4e7Y-ciOdVHK-yOQfjrjaWkau3R2_wTcVsJ83tMA@mail.gmail.com>
Subject: My dear beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:936 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5271]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimagcisse563[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ibrahimagcisse563[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [m.elson90[at]yahoo.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear greetings,

Have you received my previous message?

I hope to read your

response soon.

Best regards,

Mrs. Karen Elson
