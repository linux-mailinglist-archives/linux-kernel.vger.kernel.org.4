Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79866C4FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCVP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCVP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:59:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6350F93
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:59:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q102so4433079pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500755;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+CmkYdvGxyUhY0rK3Jem+kTK7+hnU4dkdUNT4PASXg=;
        b=FRsKuxpMpA6Xm8s2o9eocqyA4Jy4eE9EA2l0XYM4hNZffYfHbhmpZBkUZ0thgQNO2T
         0pdroY3XA5WLzvo1Rw8PtVexKP4HWtqVewkcepyEilxpOxG+f8WwtsqMe95z7A48OxwW
         xuUYIeHl6CJAHFTnXreDDviiQvQP8v6i9nfCeHoh40nDDWWCGsgLuyuyg0CgbTTT9hWW
         rSsEOzWBDYWGVjd8kATK+ueR17UjqyI3QU8o6kuGeV5CyZSe3ktX6Las+qf9u1VwNduW
         hGMPDk+R7OEZUdL1GI+3ww5YHvLQTg/9VYAT5JFX88n4NOiodRMu9IGfztkX/+/2lx3R
         8sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500755;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+CmkYdvGxyUhY0rK3Jem+kTK7+hnU4dkdUNT4PASXg=;
        b=e8KNEmbAf0t2zeZGUstU4/0ysvN6qqm4RP148oXV9//MDSneLK/aO7S75JRTrKvyJH
         RO6zl+kW5Z3Gs24IOOofPumZuURzEqrLD6TkbIogajZSQZczqa9wWxiS1Ssr2x6uumnW
         NGTrbZ3+dNPIeIwuZT0eOWL0ZsIkrDYMl5R0xUxhpk28GE0SDyce29minWWaxwRCLZq7
         EoO7yJu/p/3OkcRW/G+NoVJ0TptjsEOU62529bLYlZYfrnnBymU3pzum0NIW5EmPEeKh
         ZbyxkqK0o3A6QjGjd192Mz/CVM9dUrXfHmyv5edQiEUHmdfQyeG8ivpEomjJi0W0O2l7
         W6dQ==
X-Gm-Message-State: AO0yUKVIs7kX7XmRUpZYkIapWzY7vymxqSr+bePqkVujidHJcBfiuxMM
        3nTbHR/XVNLogmF3Ryd3tSf8WSICux61rogvMvk=
X-Google-Smtp-Source: AK7set+90iu3T6F1bL5hBHoAPmc/HjPRfj96CTGG1eFsvYi1WfOxUYdawvF2UZrpWPOTnJ/Pkxe46MAmaLdIkgc420A=
X-Received: by 2002:a17:90a:dac5:b0:23d:50c2:939a with SMTP id
 g5-20020a17090adac500b0023d50c2939amr1354457pjx.1.1679500755347; Wed, 22 Mar
 2023 08:59:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:3b90:b0:5df:90b1:ed0c with HTTP; Wed, 22 Mar 2023
 08:59:14 -0700 (PDT)
From:   Aisha Gaddafi <aishagaddafi165@gmail.com>
Date:   Wed, 22 Mar 2023 15:59:14 +0000
Message-ID: <CAJmSxgr91K1CpDMBij_PQmh+Yuy6uToJDg3cW0RxOrwNwjBcDQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Please confirm if this email address is active? I sent you a message
earlier, did you receive my first message that I sent to you? I am
waiting for your urgent feedback.

Best regards
Aisha
