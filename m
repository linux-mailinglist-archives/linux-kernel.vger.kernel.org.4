Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0366298A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKOMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiKOMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:19:29 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0422BE9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:19:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h12so17256959ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6XTTZ+NrUCRZqrFnnPtlsztZjbXNjQi+1S8muccdxA=;
        b=dZhagDSfjbPmfQilKfD4dI8IMyzMmrhBfkWxxsKO4Vfi6vbw2XGePj3TtQrUv/hulg
         okW6bok3xjw0yRXrB1ga5OL6kXGLpMyBWOArUaiR4z4Hg7m4Gx0qlTnn5n0dpWH6Hrcf
         wahfXrDr0LKBRzmF4TpfMHvTVBKhpD5+TVvMBwzSx841Q4QfC5AL5NafXYQG2t44Vepr
         crbr2ir0KGPgCAhxLLK532Ee7seYu3ah3bF6OF0E5lIDHBazwtFS4t1e03wo2IrSfgyE
         8BIMxu0crQz+3uheOnHsb31zYGxkW+cBxpOGUV3wtPeSJ5HarkQ/9L7jjmTlxWb/EqnI
         Z/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6XTTZ+NrUCRZqrFnnPtlsztZjbXNjQi+1S8muccdxA=;
        b=RgE2oPtM3PFpUV33Qc2XqqlWHfWAponU25reA3XhfQKpiQ8kwpDMey5SoWSnxAAneM
         DNANl2RLXKZ5oU4E5CFrfbIHlKDC6MXB8d5mu8qNgSE4UJyckiepmHgGKuCD1o7sPdVb
         /uCebAWWUg5dOV6xRI7gEknNAI78Rv4ME3HmLft9/NpS2Yy1+Yt0KYDr3CEFSYDaQzd2
         p9jB+fhhYKR+kyCC3SBUrgXY4KP2usnTvXn/LqdNhSSmTuR4tb9SRHdLUIdeXem49FCz
         NUAfAhpmwHt4xsMqn8jLDLeExRNn9D9N+GUAqMXlQAFyBOrF+aGjLKUDn6qXAGgdiZkX
         sOzw==
X-Gm-Message-State: ANoB5pn1JqvKkqir49NqmzqaDDVHEpbBKjlX0MXQLzehmvOEg1PFGrWa
        wgqdM0gG+1II8mJP7johujSaAElB7L5V0qP1XTw=
X-Google-Smtp-Source: AA0mqf7gqyzqAEN0hipA+dn6K0PjIQq1Ogi5u+C0c7EJbIQIq16F6ZVH/qT7PQQpH9bRXEkdxW07jasEVTDR+WkTkSY=
X-Received: by 2002:a2e:9055:0:b0:277:791:5ea3 with SMTP id
 n21-20020a2e9055000000b0027707915ea3mr6264137ljg.209.1668514766479; Tue, 15
 Nov 2022 04:19:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:6012:b0:200:52ff:d90f with HTTP; Tue, 15 Nov 2022
 04:19:25 -0800 (PST)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <sarahtage24@gmail.com>
Date:   Tue, 15 Nov 2022 12:19:25 +0000
Message-ID: <CAK7Gz5y1yHTPjV9HL+WCLn_9vEB4hW=0ofG4Y_7z3XpAonOc4Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sarahtage24[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sarahtage24[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, bitte Ihre dringende Antwort. Ich muss Ihnen etwas mitteilen
Vielen Dank
Michelle
