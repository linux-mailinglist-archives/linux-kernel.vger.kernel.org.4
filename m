Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB565C6C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbjACSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjACSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:54:30 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8E12777
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:54:29 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 186so34111004ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+xzLeZ8S7t67SE3NkibuPNQqDQccJbyj3xdCRJVnBQ=;
        b=SRHdk+FFXl0fK9h0YkVj8GpayRN9BoW23pnChlHAjeNM0RXFkCQjP8iJq0Fbh5BQzr
         Ksynjt7rpyQ4KeGO/2iHQMnmLBVOptLCH9Yb10G1xu+8iJNCKMG3hNrybyC+tPDLNm0P
         aMtx5o8hvxK6IDOg1Zge97OLoEEh71Gu35nXhoh+rG2ZN/ecuD8MAnmgrlFHioO/Coum
         epNyG6CVIGpZCk8UczOIUfmXG7JA9JlGY0FHuubt4VMw+odmGGkLnS5cH50Xj2mSqjsS
         sGk1QC4lv/Zgv853Hu1i8FriJwGRLsHW14S0hCKGPsPngUffkxvISRG62AEj2w5EoEWd
         CdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+xzLeZ8S7t67SE3NkibuPNQqDQccJbyj3xdCRJVnBQ=;
        b=FO2Tn8yJxF+3VvcNJgu16tdigSCuaEHRb65lXsFgzmvN6M9shg0TwhJZIB/h7mMp0n
         635+s4w6UvSHlzh7qJhLGDORec8yX9Nt0JFzJokOoMSA8KD6cU2hy8VA1IDMSNcLlGIW
         SgRfMsCZi/3wjJlsT6M+Kyli6yR+m//aTOUx+RGq7GLCz/rNORgWn9lDhklu9z5X8eEV
         Ilh/JB9jcTvitVVMlCzQ2qEeWmEjXRBTkEvFANwzXROtYhAtRMW+SngoLYY00nTT31WY
         ST1OvEaJ7yBmr0Ye6ViB3OqTPoGOkzwe1OpVGnkvskPjj2Zk1x+oROEiWEn2hjuZ97wi
         J64Q==
X-Gm-Message-State: AFqh2krLk/dnvgz5Z3clGDguVbiaXVuZup4be59UqLVTiQOMqxkMF+PU
        HIoLNO07t7fzdSD030xpJfiXDgud9FTiUsx3wKY=
X-Google-Smtp-Source: AMrXdXtrWPb1rRvaJbJxuD4Y4B0rj/EjZLuf2IkF6g8Pq0CDMGaZweOGSAXDnH1iN0MNfw6LY3aAbBXF5jegsivQrGI=
X-Received: by 2002:a25:c842:0:b0:72d:1f36:4114 with SMTP id
 y63-20020a25c842000000b0072d1f364114mr4962673ybf.451.1672772068926; Tue, 03
 Jan 2023 10:54:28 -0800 (PST)
MIME-Version: 1.0
Sender: pourpouritv@gmail.com
Received: by 2002:a05:7110:4b14:b0:1a2:994a:cb5d with HTTP; Tue, 3 Jan 2023
 10:54:28 -0800 (PST)
From:   Ahmed Hanifi <yunnanmrsyuging@gmail.com>
Date:   Tue, 3 Jan 2023 10:54:28 -0800
X-Google-Sender-Auth: tMWPfyc86-JJNq6VKlWihQc9sYw
Message-ID: <CAPVv7-1t1JtzW+m3jwCQgP6YXwGAF42TdPQxqVxM13ti8m7XFA@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_99,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2d listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9954]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yunnanmrsyuging[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Dear Friend,

    I'm pleased to have a business relation with you' I got your
contact address while am searching for foreign partner to assist me in
business transaction that is present in our favor, My name is Mr.
Ahmed Hanifi, I am the Bill and Exchange (assistant) Manager (BOA)
BANK OF AFRICA. I'm proposing to transfer out in your name (US$18.3
Million Dollars) that belong to our later customer, MR. GORPUN
VLADIMIR From Russia who died in Siber airline that crashed into sea
at Israel on 4th October 2001.

I want to present you to my bank here as the beneficiary to this fund,
I'm waiting for your response for more details, as you are willing to
execute this business opportunity with me.

Yours Sincerely,

Mr. Ahmed Hanifi,
