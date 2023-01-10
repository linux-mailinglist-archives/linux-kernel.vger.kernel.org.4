Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1563366411C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjAJNCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjAJNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:02:45 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521DB5370A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:02:45 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4c131bede4bso152711117b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FoRX2f/YZd1ew3w9a7uXRMrccel34cHi9ReaKIRWJg=;
        b=ln6PR+yGe6pNxxE0brMnBfQ2YDyThfWDqmxR3la9cJiCQ2auc1WITSvS68FuwNEPw6
         fAzKCb3YJ5lNfQoV/JBAIJyxenUcUb/JuVwRJst1tj8SuPH4k4SpKgpKz11cyu+8Or2A
         +Q+rc0wcp7NKZyiBmcTiMpanZk7rXOO0XaUOEoLOrJPXlI8Qs5ERfz27sFRm55XsARJ4
         ncU932PvH6sfvw4Y8BQwzbWdpQFUUb5DhUmtT6ZQw03lxynm1gzkWmjDAquYYVU/lW3X
         tZvcsVRazBj9EYchgs6DjCP+a7E0CE/stzAm7yhwlZMhhRDylX2wLdwWGNl4eL/HaNQk
         V4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FoRX2f/YZd1ew3w9a7uXRMrccel34cHi9ReaKIRWJg=;
        b=y4sNA6hEg1vrCPcntOIJPZeIP9dT/cpZZmD49wQTYze81JusSGzgoYktR12ZE2RM0p
         h6va3P2BWHUSHmSrZZANdB9SnoRLP88dM33k0hqi8LlkMAXq232CPnSPc/ZKa4e3VsQh
         KSi7UmYbm2T2zbnP753Z5u3TYk+n/Zl/5y12d53tO4bm/ftfwgPuMvJMZuUORKeDVF58
         hUSUZR8kv5WcBU2vskD5aCGcX+avOeldvPWzW7EMcPK6VgNLkrVRNu++aSGlM2+Z8wYT
         N5e37vq5BUAM9VMFWme2R1cPDb5MD2zbVImJcThVvOHpmjxqJUnTs41Pu3cNNHgeh9n9
         xobQ==
X-Gm-Message-State: AFqh2kqa3z3Q5vX16hWZjBUye+zQOa3wLqK5/gq9hrc47E0nPjpkdj9O
        +pTm9kHzCnNthn3P2WYfCUuXqSkkJZerxuHsJaM=
X-Google-Smtp-Source: AMrXdXs6oxzpnoxsBeqKHNrGCLp1jEU5Yz31Pw2+PB2uJ/Q1JQKH4Sm8jO7/fRA06U7IyUVDP7iyYc1t75KZW52bt+w=
X-Received: by 2002:a81:6f57:0:b0:475:9f2c:899 with SMTP id
 k84-20020a816f57000000b004759f2c0899mr842408ywc.290.1673355764537; Tue, 10
 Jan 2023 05:02:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:c810:b0:3de:4254:e85e with HTTP; Tue, 10 Jan 2023
 05:02:44 -0800 (PST)
Reply-To: ab8111977@gmail.com
From:   MS NADAGE LASSOU <ibrahimdanzabilyaminu@gmail.com>
Date:   Tue, 10 Jan 2023 14:02:44 +0100
Message-ID: <CAKG2jqhDsquG8dFNZummg=yxtueZeGvMR14sTq-FPgfOap8MTQ@mail.gmail.com>
Subject: REPLY FOR DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ab8111977[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimdanzabilyaminu[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I am Ms Nadage lassou,I have a business for our benefit.
Thanks, i will send you the details once i hear from you.
Regards.
Ms Nadage Lassou
