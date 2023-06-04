Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA15721643
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjFDLGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:06:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190B5CF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 04:06:38 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so7928797a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685876796; x=1688468796;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLmAPaKPTIsWpZacEK868wP6gS+UBFwlLQ/Dm8ei63A=;
        b=JwzeDQschIu218wiqvNOfDuAq76M7pg5gmsP8/RUITW7iJoBjFCF8D7pqMxVHyISq2
         CFSMHQmpqPT+V6vTaHE56figKErOg9sNbHSo3EKppaKZIQnMZTxfbAi2+OOMTLzV27nl
         kxdTqEIqgQR91WxWh++TzeSfK79/Yy8Z6vCqzB8d+3LJ2Pkm4SmMwdt9JpHD1xzl32H1
         /yi7BlCBaex9diwjMu/9y55mEUU/slM0H9TiISYzzDM1bcwLV9e4O/XiZhvpWRvTau/2
         hxA5DzvS9+eOOsWXpodEApIpeMcVGwG4hAtvCvsL+9P2vq02Tza0oNkmW0Kf7cmIPy/A
         s4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685876796; x=1688468796;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLmAPaKPTIsWpZacEK868wP6gS+UBFwlLQ/Dm8ei63A=;
        b=jkrOKU8BLWUP88N8Umd+qbrxF1aVGxDRSkIzUfPiX+TfHb1k99UB9J62G51dqbWqiL
         CG42/aBKPnetMV641HjE+EHKNZeBT8gIho15u0m3az0eVcS1KYi0fISNIQoidohgRcxr
         DUqmXhNY0h6xxwCREdSUcRf25z3y5946UxfL8XooZr6TtvywJma09MyDf3o5/CEli5Rl
         n8aSlHm1JEib5bv9SP/SZtXTeWPnecwHkxd1/UgBxXhQw+YNgMTfxYyrpVXE2aDt4z7s
         AqvIzamMADPwQ+J43/mJdA6JjJyq3bw5Gh7hYB+fnH+P/vfyGFsFgyh4O8YDBYTUqrh+
         zqow==
X-Gm-Message-State: AC+VfDx014G56sdVwuusHF7eDo/YXKzhjst5PwkVKvoxLMNrw0kch/rK
        /gexQC3Kmf4K8RpaDnWQ+dYvoAj0LyaJo26QchQ=
X-Google-Smtp-Source: ACHHUZ4mkYQHZCEbhWqE8xQb6h6QMSbTN3VB5nEZN8xZjk54+uvGUzGiflAs3riqn+IP0AP7ojiNs0fLFd9+GnE2ujQ=
X-Received: by 2002:a05:6402:4406:b0:514:8fdb:6354 with SMTP id
 y6-20020a056402440600b005148fdb6354mr7261956eda.18.1685876795974; Sun, 04 Jun
 2023 04:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:20d5:b0:6b:66be:add5 with HTTP; Sun, 4 Jun 2023
 04:06:35 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <claudiakhaledyahya02@gmail.com>
Date:   Sun, 4 Jun 2023 12:06:35 +0100
Message-ID: <CANcjk_Dsy34O1+d7PRXpZEzutw53sRqi7=FiAN7cmJnM4bEbiQ@mail.gmail.com>
Subject: FOR INVESTMENT PROPOSAL ONLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5101]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [claudiakhaledyahya02[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [claudiakhaledyahya02[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening Sir, I want to know if you can handle it.
investment
projects in
your country because of me
Looking for a serious business partner with a good background, please reply.
me to discuss the details immediately I will appreciate you contacting me.
in the same email?

Thank you and waiting for your quick reply.

Wormer,
