Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B56BB3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjCOMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjCOMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:52:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D88C536
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:52:36 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x8so1296291qvr.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678884755;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLFRsJOsX2F5yOtRt6kLMkQ8BWCMUvEvwx1aLA2wN+k=;
        b=Yl19KL1JyiKv1FYtXuyMf5QOmtFAkm/oVbflUHFhB/HO3D5/kr5vf2vr5HPPzXHhDl
         X4DgzmYShsdCV2uE9X4FW381cReiZCoZTfCNuzUBNELf0mWOlSbiP/yq6jAkHd9wt1we
         zIpOq70eeIfjLORJO370ZQwVVg3svAhRd3KvpDpPJLGX8X/uSlkBGg3DlIWnQeJXTtp7
         NMkA3LWJF4uLwQ+Vsp+8oz2NDUXWqHu3ZoY4b0+EPkhPJoocFo+i298nNOVMvdL6/A+I
         7gjOYTGWRCBe9unp9Y8/XRXOpOEGZ+sdgaudWhmCuzgjOSvRwI33HoZ5Artiwe83e+J4
         mTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884755;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLFRsJOsX2F5yOtRt6kLMkQ8BWCMUvEvwx1aLA2wN+k=;
        b=iC307U4M6lGSAYGWykt88RcRMN9fFCGfZSDyYMJaZ9j58r8Gxkz0uPjfkE8ElhoJyO
         5TwzhhpqQn7K9OMLmc5QewxdqjAGpyFuviiNP/dLV/ZETVb/8/3sa4h2BJJPkoG9xxnk
         iQzV91f+bSZajBqMKfkQj5R0lY5LDzVS5+WxQyxvz19mqR4VmCXqs+l+x+5RjXwwtJkw
         jfXM95bbZURm8coN5vhsCa/EgYwGz9UDMApX/uaYLsiBOMSTB2GNBG7opytrZ5ZLy4ws
         PXRq3sCRuaH6phao0iodI6gh9OtUioxcEx+9wKYsaEF4+6OSfM0we9S0WG4dBPAMRAP4
         rowQ==
X-Gm-Message-State: AO0yUKXTMYVz7OyviTP60FCg4Jix+SMwSDz3u9J9F6NTiEWZ5UT+91lU
        CGCJEcCJ5P5mdpNPXXWHa9MyQfJI6HRJRI+yKPY=
X-Google-Smtp-Source: AK7set+2q0Vdy60Z3FMxrL5u94t1E4JKUteaAhBEbCyppbfKte0GjdYJ7JKgLaGNCuJfl3keUSg6/rxpzyTqlrA/K44=
X-Received: by 2002:ac8:1e8d:0:b0:3d5:3d76:df74 with SMTP id
 c13-20020ac81e8d000000b003d53d76df74mr510179qtm.0.1678884755473; Wed, 15 Mar
 2023 05:52:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:cacd:0:b0:4ce:79b9:d02b with HTTP; Wed, 15 Mar 2023
 05:52:34 -0700 (PDT)
Reply-To: zongokari01@yahoo.com
From:   "Mrs, Zongo Kari" <abdoulkarimsemde72@gmail.com>
Date:   Wed, 15 Mar 2023 05:52:34 -0700
Message-ID: <CAFf6P72GrSqJ-DrCNRwD8NMnjxCVyZUK5BpNyMoNG5YXWJz=tA@mail.gmail.com>
Subject: May the good God bless you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f31 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9981]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abdoulkarimsemde72[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abdoulkarimsemde72[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [zongokari01[at]yahoo.com]
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
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a dying woman here in the hospital, I was diagnosed as a Cancer
patient over 2 Years ago. I am a business woman
dealing with Gold Exportation. I Am from Us California
I have a charitable and unfulfillment

project that am about to handover to you, if you are interested please
Reply, hope to hear from you.

Please Reply Me with my private Email for Faster Communication

 zongokari01@yahoo.com

From Zongo Kari
