Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D26211F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiKHNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiKHNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:05:13 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5306EB86B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:05:11 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id n186so15431785oih.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=D1TmwerPuu6xMrsvpSYxOrQuzatAs0NZ5R+JGL280YN+H7WL6jQP6KUbS8/30aJfq1
         rlF4DE+xefe2BJ8FZRZZnS3IwpsGbm7XY5WAps+bNGwDP6j6dXtMi8aZgDGsAUYv6+Xk
         Kj6PKwOhD9ORyOGqTbZ5h5EOmCxlM2C4fMLHAP7yllKpNrdHkVdiKQorNeSwDHNa3erc
         n5rMCiYQjpi7IF8mKMV2mUm/7Rz9D0GG2yJ1bUyPfkQy0ZrTfgdYQy9eBt6n8gvyQzOl
         RqY8xbnkQmrS8STHamFVmTeQLRqJ0mylVOJBPJl9i9dfGVsYpqfiyETUOL9jBY+cMNfi
         U1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=Xz/z5U03dC6SDbI8BzQ2NPW3oBg11qRIFAoIcEm2PiCCYXXhl9Wqdy6dfekt7c38nN
         HD7grrWKlDaE+4rhqyhBuS7gvtYdmoysKheef0nuMis15G2rRiJ8Ky+I44HwuJjM4MHt
         4mOj/37Z9JGc2LPqBloiC5WXEYxG7BLot5d65GEf9BBJIQZJQuZy6KL7JQL9WrvUdSsu
         qaCKEgcnHS8hJhiXJMc56XJzYKlrbR9PjStJ8VHym2zfH5soy6NDmbUjaM5VawvfnPkV
         YrgWs/3w8rYkId5Vb4WFGdhgMMJQnNacpJOmUlu0dXBSdNFM6Sv3mSm6MyQ77cpN+fHI
         dFlQ==
X-Gm-Message-State: ANoB5pmYuNQ0PB6DR5zA/Xq+FS4quw7cEKQhswT2yORbZgxbRsQvruQl
        awbHbr7FruEJN3++1HJ4Sc0OnipoWZUPwnE1XV4=
X-Google-Smtp-Source: AA0mqf7VxufJFINgThIW2uvWVeQUHKgMdTaClOSW66ImIlLwWTjBARMxCO83WLidDHzdDVJgiDa945xk8dRmeGmTgSc=
X-Received: by 2002:a05:6808:10cb:b0:35a:7ec9:e972 with SMTP id
 s11-20020a05680810cb00b0035a7ec9e972mr6978540ois.200.1667912710493; Tue, 08
 Nov 2022 05:05:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6840:5eaa:b0:f64:bedc:f7d1 with HTTP; Tue, 8 Nov 2022
 05:05:10 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidkekeli001@gmail.com>
Date:   Tue, 8 Nov 2022 13:05:10 +0000
Message-ID: <CAD7994c-cVTcEv8DBZwTC0RkhDP+=6zO551npFpbCuL_jGTctg@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:244 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4915]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidkekeli001[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidkekeli001[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
