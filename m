Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A0726122
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbjFGNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbjFGNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:21:11 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6D41BD3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:21:00 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6260e771419so2926046d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144059; x=1688736059;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsTzCKh8bvjj+7fsJLeOfrhDNQ0r+NadzbD6gaCLLhc=;
        b=kTCFPjMtJCYuc3Xyn+idFTjzmqCrIbyLSHl43occoExeNvdtHn0uxJFqQH0MVUdvXL
         q2sgzGgWdz36/9mJlIYH2PYcy3kFYqdHdOARKrmcGJ2lff5ZRzVCy6jL7rqF22VgktyB
         JTma4OfPCwQG15Qgbr/LseFdk0PDgYNvFkt960fNL+MRv07V8No6T54fue7BtAEv6RMW
         iBKrBPB59l08l8Urw0Q2WGNqiMbBKlg7Rzf0wdsxX74C74uCcNeIcbARTkkuz6kx4GDm
         F4ptQFnF73uemhio4xOzqR2jw7+xCnTyOzW0vR32f/LJfOoCU7nNoEvdMLJbGX7EJskF
         JPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144059; x=1688736059;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsTzCKh8bvjj+7fsJLeOfrhDNQ0r+NadzbD6gaCLLhc=;
        b=Uc5serhnjcqEODzy8xJKfgH4fTEcqqT5eIfkVkJFZNew/VNkReMWSd8erYUORury1k
         Uw1m8f2Tq1/szGGZRl6LNBNsUDypMab/HWK0qtYRadc71m+4jL6jHGwo/bnOt/2vUk/V
         GBecGQbdN1KUEPjb4D7jyMcTiBjMfN9gRP7vgPKYtT7pgfJj1YU5sIKqO2q0pv9hVj3m
         wKLKNINUyMigPRCGyjRX2Dy/KE9kn7O9sWkLqOZjAB0R1WslOkhsg/x9L+YVbo8l9qk/
         oUz+OrgPpT7/0V1cTuBuxGpyIjfKu2S9s4E+cwRsvwfTfteiSgf7PrYubrs574k9Ugt3
         m1rg==
X-Gm-Message-State: AC+VfDya1Vle8SsscONGihzH3w4WcoJfTF4o8hmzNDuPUIvpmkflNrWX
        uQdnwAvoFr44xcl/AYsEkUhJrFwJaCvt0v6DQ7M=
X-Google-Smtp-Source: ACHHUZ5+oZoaNWjvjpzb/8PE91QEVDfSlSLrzUUEnkjZwjY/CEckPPiSRMi9ChDLBSbKe0cudjqnvKU9A0mir+ZGuAg=
X-Received: by 2002:a05:6214:cc3:b0:5ef:5be2:f6d0 with SMTP id
 3-20020a0562140cc300b005ef5be2f6d0mr3933626qvx.6.1686144059375; Wed, 07 Jun
 2023 06:20:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:aba7:0:b0:3d6:c925:2155 with HTTP; Wed, 7 Jun 2023
 06:20:56 -0700 (PDT)
Reply-To: borismayor1967@gmail.com
From:   Boris Esq <mrborismayor57@gmail.com>
Date:   Wed, 7 Jun 2023 13:20:56 +0000
Message-ID: <CAOOr8dV7sBQqJNb-bE8hT9Ch+1qChnDVetkYwCR44Q5aNXHH9A@mail.gmail.com>
Subject: From Boris Ayiete Esq
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrborismayor57[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrborismayor57[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [borismayor1967[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My name is Mr Boris Ayiete. I will be waiting for your reply to pass
you the information about a relative of yours in our country who died
in Turkey some months ago kindly reply urgently.

Have a good day
Boris Ayiete Esq
