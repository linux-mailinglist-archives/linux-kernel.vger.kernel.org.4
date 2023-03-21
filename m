Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AA6C2E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCUKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:07:59 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5566A269
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:07:58 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-177b78067ffso15705405fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679393273;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJZSh2E9pSf9T5lgH43uOEogMK4YhEYDaY4XuVS4aqE=;
        b=HvHOjEosOSLEarWqaSwHxWD2nHvdFNdV+XUPyOcVh10ybry4fu3ETRggrpelavs9yW
         mWxK2nEGipeDz3wqoOCRwaeyzEOnEuvMd3V0Gm6wQ/XTWB47X7KCjZjxapbpxf70sTlR
         d7V1FTKDbkOpJspMOS+zACt+AySBwsMRVUye22fDuRv58QQi5fQOU6R5/kq7g8uErzI2
         VyIEJt3UfWl6IlWCMbb8YBO9nnYhOrfTQkx9o7TtYMH887G+nViyDEpVrGnM69NOMuyN
         wHbfCNDYSpL11Yn4cks2fTCs3si88MtVnwNqeAYDeSIvhCzm8yKtK/whW9Zrp5S/zzdK
         dhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393273;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJZSh2E9pSf9T5lgH43uOEogMK4YhEYDaY4XuVS4aqE=;
        b=BipMfHUyOhPd0TtVujbm+V+O7KlSMAWPgCyNdctmoGEKZgJZwcOnOS4SOZxxy4tS3F
         LSWM7r81Szc+Alghlp0RIpdv3tbri+pRP6JB2Q0oHgW8cxc7q2HCPoYJuCPS0hkk8oEY
         lswHNwqYD+3/3QzptPgLzJVPl9m4W6EueYLgh9qNOKaNbmEEDryyMpKFEh8pHcIK2Cbg
         nqVnz1SBeJBJb91Q4TDQTCXNxVNQzgqvo6i7kCI9LYbfoJm2jxrLtm4bsA6LqnvMh246
         CayXjLzxFfXkT4K7Za1UqATfEoF0jAhPEtv2TIFGpEuDRa+I5gewq0oNboMebdkL/rKK
         2oXA==
X-Gm-Message-State: AO0yUKUI5yxu3wcs/83BUCuuVUHqPRQZy+c1LYG85KhiodgS+LziZFN6
        UNnqToeqAzKiONB8995ChdpBtxqAsh8WD6xFzlE=
X-Google-Smtp-Source: AK7set/5jUoMNrJwt/reRzydHa6HyEztfKNqARKPTDb87apJFC2O4nmmTZovTPMb0bqSLdg9prU2HUz90z1SxOdeBSE=
X-Received: by 2002:a05:6870:13d4:b0:177:adf6:4fa3 with SMTP id
 20-20020a05687013d400b00177adf64fa3mr459789oat.2.1679393272748; Tue, 21 Mar
 2023 03:07:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7511:b0:f6:92bf:aa7a with HTTP; Tue, 21 Mar 2023
 03:07:51 -0700 (PDT)
Reply-To: intlcoris@gmail.com
From:   coris international <oluwakemiifeoluwa01@gmail.com>
Date:   Tue, 21 Mar 2023 03:07:51 -0700
Message-ID: <CANmZ2MZ_nPF03JbygaBxFrpT4QTQj6zjR3BF3nM0ZSb16C6JxA@mail.gmail.com>
Subject: Att, Client,are you online?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2b listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [oluwakemiifeoluwa01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [oluwakemiifeoluwa01[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Att, Client,
This is to notify you that you have a message from Mrs Edes Banneth
which She asked us to deliver to you, are you online? Respond to us.

Confirm to us that you receive this update.

We look forward to serving you better
Your Financial Comfort Is A Priority
Thank you for choosing Corisbank International.

Sincerely,

----

Mr Diakarya Ouattara
Managing Director
Bank Coris
Burkina Faso
+226 556 16 37
infoinf@accountant.com
bf_info_coris@yahoo.com
