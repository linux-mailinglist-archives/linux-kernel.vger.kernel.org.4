Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5796DED34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDLIFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDLIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:05:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EA2D7F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:05:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q23so17175307ejz.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681286706; x=1683878706;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJLlk5da4L8Ltn8jDx/W/MCW09bm52RtkanOa7KHQUw=;
        b=DfTgWotzSDN79aPLF0yJwQxlU6YpisvmmkU8dxUWBBD9+wbXgTUbZ8tNuPqV2l1yDK
         JjLXvegVVsmqyeJ3ThZp1XsJM6RxIEWAq6uo7WcLO4Vq3ixvt5Avy41FFaLYxRKPs4oD
         jG8cfa8Yys/9IzZqoa9VpN5N+MEoRhA6y3uC4hv88qtFGObL6dikA6dXC6bgDxBlBK/q
         T8LCzF1Ujmosxl+MBImt4uGL2V13csyyuOpRJWFVTZuzCQcleB3vzSn2rWQ6ivU6XtK2
         zfDTyVcDDF6AVXRbIeXR/qLVQmhimsGRjEMOQxQtngCeLJAJQTuKvVVBYghUJa/2oa1e
         70xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681286706; x=1683878706;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJLlk5da4L8Ltn8jDx/W/MCW09bm52RtkanOa7KHQUw=;
        b=NWQgQHZLip2G4Z9F97e/hCnHnOJ7Qy4qJsEvIwvEcxj/J6tvhm+qOaD8am1AdriVUh
         x38UDisuFKmjQRCQ1S52SsUgcvz3VHEQU/z7ZuSTiFUa2FXcvxBWNoCu2UNolUDOR0Dd
         gdqQJohrPds68GK5+fOid7ulpjBGQEUGUDaR8JFQ0+pk5C0D+vMDU6ztl77D7wv0rBeA
         RsX7N7usWWxznzXh9r6L4IcT9J4XQHXXP++fI/fbfIHXzhR4kEOLiA3BWlWoDlcYGgtL
         Y3EU8ONk3BkNQb6NFiO/7HHkGdb2oioQ+1qu2o5tY+l9o9WMffwSEBnBqUK1XR/gitgf
         TM9g==
X-Gm-Message-State: AAQBX9c9xxX44KJP4IN/1eQldadWhcAmGUQlpTnuM+d5mHcp5sEiO+qx
        4qiaaCdV1j+SBo+0KJB+CUuO6fwgVSiqTYB6HbM=
X-Google-Smtp-Source: AKy350ZsMEeYXqWc3YO6suPENHKbLe0ksL4tyDBKIRCTaRurMQH2nROSOZ7A0PPIxWB0GmYSRTevN07zGbCVWFUtB9s=
X-Received: by 2002:a17:907:d603:b0:8f1:4cc5:f14c with SMTP id
 wd3-20020a170907d60300b008f14cc5f14cmr2714921ejc.0.1681286705360; Wed, 12 Apr
 2023 01:05:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:708a:b0:65:ee9e:4d5f with HTTP; Wed, 12 Apr 2023
 01:05:04 -0700 (PDT)
Reply-To: avamedicinemed1@gmail.com
From:   Dr Ava Smith <avamedicinemed10@gmail.com>
Date:   Wed, 12 Apr 2023 01:05:04 -0700
Message-ID: <CAARwTG+23BFXGvtPE-vRebTNFOdM3BdvAfTg=1JC6pC+0kYT8g@mail.gmail.com>
Subject: HI DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [avamedicinemed10[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [avamedicinemed10[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,
how are you today?hope you are fine.
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Reply me through my official email (avamedicinemed1@gmail.com)
Thanks
Ava
