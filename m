Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB25BECB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiITSVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITSVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:21:15 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD1D543E3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:21:14 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h1so4038199vsr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=9oUhhe9WhBbu4JoH4Pz+I0OHBn3Qr9dI0a7PR0a2whk=;
        b=Oc7TfFyr2nPo5lFNzOv98WCMtlW+2dL6/Q2dsACEDb5rN2x5CZV0D+3OcTiHzOoIXH
         AyXQ6tPmxP058L37lDLdgJTFdBLfoeOs4BtBgD4dgRuMWeBcCzX1ols1+RWnx+UjsRC/
         Zb308DqSFDTc+C9y22cVDeVaZlYkLO55pRD4hkSBm8x6grDsJOtLnoMgbQ9JTRL+3hn5
         k8BMDJ9jcS/HBDgRbZtg3xV6CkFaUCXatQqG9D92QFnWPjQcWVvbjL8XWZLaFOvpuKnI
         qPE4sNsWIaGgDRkvNcK6rRgpsOXYEEFnAaLeHfZ6PHQC8aSH9MCnKHpanFChqetzw4pI
         mFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9oUhhe9WhBbu4JoH4Pz+I0OHBn3Qr9dI0a7PR0a2whk=;
        b=5qImWA7f4L9xnw/ntbtK4lwv/zufuxW4aTL3m1mgQeuGUu1DjLbjcoURHaE4c73NTL
         8rbBhpmBrBZOPkzwZQ3h0zVClimcDU36wTo7YDR1mieoxwoCfzBRTiAOaE8X5/OKpg2r
         tysxyZa80vQXigI49nLrtANi7DhlHukP0Go0MfEWvnwGDgJDX0NOruSc8K2dSNyNvOvR
         yUrfQpC9b6Bx59AKQDDRIW6az4hcakywQXi1i5nS5QKLL3UYa2NMkpPG4L4L4gtz7JVP
         r+nbOl+HO0rKyEe4TNJ9HEsFZ6qU8LbnNXdC7Jl4I7QJ8kHmmdmBU5CRIwruMCoF6+VY
         BZcw==
X-Gm-Message-State: ACrzQf3hkkF30DaPmuOi78n9AUmmaEauu7AM/30zvGFr3SWpZzSsxiKD
        gRxNsVe88K617O2zKYuEVXcPpm3iCj4kSpiTQ/k=
X-Google-Smtp-Source: AMsMyM5VcheMc18NSkxOHYU7qFb3j39K4cMgvJ4KQWkYKIvbjAlAfBI93rxUj2MwpKz1cKsvMwDjLKgoGBGZ6yY8yWM=
X-Received: by 2002:a67:c81b:0:b0:397:fef7:c372 with SMTP id
 u27-20020a67c81b000000b00397fef7c372mr8915719vsk.15.1663698073601; Tue, 20
 Sep 2022 11:21:13 -0700 (PDT)
MIME-Version: 1.0
Sender: koffikambi@gmail.com
Received: by 2002:a59:c30c:0:b0:2ee:ec21:c411 with HTTP; Tue, 20 Sep 2022
 11:21:13 -0700 (PDT)
From:   Miss Reacheal <Reacheal4u@gmail.com>
Date:   Tue, 20 Sep 2022 18:21:13 +0000
X-Google-Sender-Auth: bIu8bCdRDmK67-GNj367sNBXTrI
Message-ID: <CAG-Nn3CdUEXTcJ5p+-t9AVacJB=t0yLGTLU2bH1cXAabXhv50Q@mail.gmail.com>
Subject: RE:HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You received my previous message? I contacted you before but the
message failed back, so i decided to write again. Please confirm if
you receive this so that i can proceed,

waiting  for your response.

Regards,
Miss Reacheal
