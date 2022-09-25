Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6E5E92A6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIYLR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIYLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:17:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEA2A25A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:17:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id bu25so4898707lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=fq/FMo3N2YZ5gAL5l22vJq0j+A2OZhZuCvLwNurrkgc=;
        b=EiKYXspRtzMRb/yf/34S9ktVe/ty7oRy9TfSzi9sfUjQ6tpgfukhh2ci7NnfgPOQK3
         mJlUB/jTeBdkp/qdPqr+5zEVTdei6B+ySo/Cl0scObTqvbrSe+WW6/WjKtU9wQ4iVloD
         BPOO6M+fDwJJ+AW/UiUDTkdU5UdJ5O8LoRjnqEEnjYNNaYV2Ek/M9UdbuiM9yZx4AZIo
         BrDVduxD+UoiToNQxQ9EOPFn2CetFCf/SoefqBa+caMIE27Q8CZ6YcKtR2jMpMUo3d0g
         letcYd9RpJK877Gz403zDDpys1a7az49UN/5I9bxoym+6lQUczl23uH/kn/rWRQ6e3/U
         EATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fq/FMo3N2YZ5gAL5l22vJq0j+A2OZhZuCvLwNurrkgc=;
        b=1nVwguC0lSwEGQK+6+z4WO7wbl17qPTzgnFx4AxyP/S2kagWdI8oQbQFiFixq5liUR
         FDWod9VQv34uqI/Qxh0VmT8DUnlOaTCemwVaSgahtkjlauGWJLwW1hzv77LPnMTfTDe5
         1zP0DRI99iSMNrLfeECrMlG5i3aHvO6foSqNbg1SL7QAw6zsuF9dCWQ2nVig4dBO/6Gg
         VB3khzVCC07MkeGFxrb3HS9FjSbtEwXGoYBFSAcTP9MIHyGw0g2iUk/c5sr2lbUMB+s3
         Aj5srouaO3/+onLcxPJnuMtmW/BlN/tkzNJwxrL6HkLtrZR8z1ZmxP2koPOS56klF7wl
         Xrgg==
X-Gm-Message-State: ACrzQf3BwB2neP9VGYT1Hvnwhyj1dJnt63NlPJKGR0KzX25GJxc9TLfI
        4wnQMIk+MDT9TTz6Rn8vCKJfKUOSvQV9lSr2utY=
X-Google-Smtp-Source: AMsMyM77dE+Te0Oy1y2hDW+dvzRM2a9HUGfoYTqp3+9KsS8+0X9MAQmfUAdBV57suNiqSZrh2HUi2K/uGoGfxnLEWWQ=
X-Received: by 2002:a05:6512:31d1:b0:499:fa38:3d7b with SMTP id
 j17-20020a05651231d100b00499fa383d7bmr6565504lfe.544.1664104672674; Sun, 25
 Sep 2022 04:17:52 -0700 (PDT)
MIME-Version: 1.0
Sender: nadeemammar1@gmail.com
Received: by 2002:ab2:5187:0:b0:163:d1c9:3565 with HTTP; Sun, 25 Sep 2022
 04:17:51 -0700 (PDT)
From:   "Mrs.Yu  Ging" <yuging9567@gmail.com>
Date:   Sun, 25 Sep 2022 11:17:51 +0000
X-Google-Sender-Auth: W0VaAaKzy2WaCT7st7xHkkIZrJg
Message-ID: <CAMDb21-OX6O1WFsPeSotpZj2+PeB4cps7JqO+MXkVeiuHwim3w@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China

woman but I base here in France because am married here and I have no
child for my late husband and now am a widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of

kin to and I want you to stand as the beneficiary for the claim now
that am about to end my race according to my doctor.

I will want you to use the fund to build an orphanage home in my name
there in your country, please kindly reply to this message urgently if
willing to handle this project.

Mrs Yu. Ging Yunnan.
