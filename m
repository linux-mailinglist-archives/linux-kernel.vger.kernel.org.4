Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF42696D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBNTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBNTNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:13:11 -0500
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7E25E1D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:13:10 -0800 (PST)
Received: by mail-oo1-f97.google.com with SMTP id r192-20020a4a37c9000000b00517677496d0so1631915oor.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:subject:from:reply-to
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHNedO5KuH+p/e/vc8sOVGTErzEaxPyT/hyhGtc45Ag=;
        b=46ei4svl2rUKlYdsz5KRk8SuVC8seyElIgsfMn2ks/w4qShnb6FBHuuFKEWTsk24Fb
         FqyEikP6+rnFEjRctFq0m9efzHqgufWe59h0HeNXLcLyEB+faeuQ/fgX2X+CmlihV3kM
         nrzipg7/YCGbTJy2y/fe+NC+UwhN5QeD7jOwiJoUhK47SdwIYtFJvx0/XpKYPW07lMsw
         HmG6+3+ikcjDHRjiCMCaZxLkQuOzRKUKhGgvHlXQxSlYV5npdT9orU0Iw2jL6DSTDaTa
         slM6PSH9ybTyz19pEZ6OckIGYU3PWjYrnKfgRLKvrKcKl6c1Lm2mt0E+QuQwOQEzy1du
         uW2w==
X-Gm-Message-State: AO0yUKVv8SNZAva3gY3Sca/gK+dckR6yPt3i7BaC164zzBf6OXYRX2kb
        REuJePQXkKA3aTea8F907Bo0k1KqZwb4X4p6Qtc7fOHerI3SpA==
X-Google-Smtp-Source: AK7set+Fb99Lr7Fa54KN5SQ43v/eWXuXd1diayAn8QX74X/ZDVCLbI3CMndEAIik7RpuhSIsc/JvNxELOdDF
X-Received: by 2002:a4a:bb8f:0:b0:502:a732:f8f5 with SMTP id h15-20020a4abb8f000000b00502a732f8f5mr1388765oop.5.1676401989440;
        Tue, 14 Feb 2023 11:13:09 -0800 (PST)
Received: from gcsdo.greenville.k12.sc.us (gcsdo.greenville.k12.sc.us. [204.116.209.127])
        by smtp-relay.gmail.com with ESMTPS id p6-20020a4aac06000000b004f95ada6cbfsm979591oon.27.2023.02.14.11.13.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2023 11:13:09 -0800 (PST)
X-Relaying-Domain: greenville.k12.sc.us
Received: from User (57.11.84.34.bc.googleusercontent.com [34.84.11.57])
        by gcsdo.greenville.k12.sc.us with ESMTP
        ; Tue, 14 Feb 2023 14:13:07 -0500
Message-ID: <BE8A78EC-86BA-48FE-A53D-B709CB5DD4E7@gcsdo.greenville.k12.sc.us>
Reply-To: <nationalbureau@kakao.com>
From:   "Mrs. Reem E. Al-Hashimi" <yuji.nakagawa@ap-bioresearch.com>
Subject: REQUEST
Date:   Tue, 14 Feb 2023 19:13:06 -0000
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Spam-Status: Yes, score=6.6 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        BAYES_50,FORGED_MUA_OUTLOOK,FSL_NEW_HELO_USER,
        HEADER_FROM_DIFFERENT_DOMAINS,MISSING_HEADERS,MSM_PRIO_REPTO,
        NSL_RCVD_FROM_USER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [209.85.161.97 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
        *      [209.85.161.97 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  0.0 T_HK_NAME_MR_MRS No description available.
        *  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.0 MSM_PRIO_REPTO MSMail priority header + Reply-to + short
        *      subject
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sir/Ma,

My name is Mrs. Reem E. Al-Hashimi, The Emirates Minister of State  United Arab Emirates.I have a great business proposal to discuss with you, if you are interested in Foreign Investment/Partnership please reply with your line of interest.


PLEASE REPLY ME : rrrhashimi2022@kakao.com

Reem

