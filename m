Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC06AC756
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCFQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCFQFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:05:14 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4819E3645B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:02:11 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id f23so9548618vsa.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678118520;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=SWhnE8FaFVPLeb7IPkKUDiIi5PMeiv+b2oRX4rJizM9VOkISx/JWcDtMUtUApjuZKC
         io8yQgsnVgY0v4YARh4WlfMw2k7fYomtzv67BVDkjiY2qfRB7QY0n5eFadNc1eZhzbjL
         5Is8zFKYqp/Rgrz6aYuYD63yjJIJSmkjd4HKF5k2HlagfrmbgQOCv63KG9cLm7SUJj6v
         m0AkC15X+vSS/ltesx/wzZ3TR0Z6fxPeOfpmj9zhn6OLr0Ssb1HRoCZXxHnxgDGoku5A
         SiXlQnz/aXBBtKnJf6ffzREBj9k0xj6xVpqaDSAl+2efJ+J2sGVeTI94waqj2ay6S9iG
         7icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118520;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=KuTliyMjXB+obJtXAnI0BYgtEeXllxroQsXbD/cQVRG00cNF86gvhXzk3zYGpNUe2s
         SS6k10Rwcl4dSvI6f+tpweobm6E9cboqFa+IghyJXNzxTI8nZhfCerDEhukh3zzvCvZ0
         VoOPf0KfJaUPGQpEzryxgUpW6/4Eav9cEZjo7/E54yw0szHu7nsYwBw2OE1Nfs+9NJmU
         NFstF3K+MJC5opvDpVbf/Neu+fYJXFcVCv+VrVTa27CUEizcTzxGSvdt7CND7LP+ydE9
         oYxPhIBB6+jNj9o3qFrFLGv7xA+bOberYlE039GidAXfQ+xen14vj7GjVk/bBJz6SjNE
         YHnA==
X-Gm-Message-State: AO0yUKXR+EprThdK7/n+zhPG3fRVPzyw7BWL8CEhaOvbVoyYpTLE+K1c
        OlfGTTjL0sxNQ01yDYKDpvkjLPWspv5PFTbX/bs=
X-Google-Smtp-Source: AK7set+STsnZvVJXoidPJJgfYreHp7mLp85PL5ednVM9/xYCthC4q3lkvdbXuLdkXppd89rkwxK1XdOtPnH++QT7Fbs=
X-Received: by 2002:a67:fb19:0:b0:402:99ce:1d9c with SMTP id
 d25-20020a67fb19000000b0040299ce1d9cmr7759378vsr.1.1678118520338; Mon, 06 Mar
 2023 08:02:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:323:0:0:0:0 with HTTP; Mon, 6 Mar 2023 08:01:58
 -0800 (PST)
Reply-To: musamariam413@gmail.com
From:   "Miss. Mariam Musa" <leefredrick725@gmail.com>
Date:   Mon, 6 Mar 2023 08:01:58 -0800
Message-ID: <CABdVAWBbnNoSfK6cCDEL3gPXpJMeHo4CNi4WGywZEbu7RBc4JQ@mail.gmail.com>
Subject: Can i write you here
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5143]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [leefredrick725[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [leefredrick725[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [musamariam413[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

Good day,

Can I write you here? I have urgent information for you here, With
utmost good faith?, as you know that my country have been in deep
crisis due to the war,

Miss. Mariam Musa.
