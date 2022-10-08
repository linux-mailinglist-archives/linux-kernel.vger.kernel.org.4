Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0925F846D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJHIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:53:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527852444
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:53:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n73so425403iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fq/FMo3N2YZ5gAL5l22vJq0j+A2OZhZuCvLwNurrkgc=;
        b=aaTfdR2A1aElUlREfwUs/lIpawZOqbq2bmCM9q3LdcayzLq8yAkB2c1cG34xphe0Cs
         0Ag5b0YcbWUYkI/UBaL02al3Duy9MUwY2pDktxMWnWsDz5zDX11wQkzcKUKPt9WqLlCy
         JWUJUS7lOY8SrXqPDPlkTLO8EHEyGOws7TsYYIYhj3aaY5HHl4jB4msCZ9a5XM59vkgK
         bLbdiVO/dfaR5PqVBR2EjCZ6NrEjzPHHf0C2zScQF8Z819WqS/UoikH0jDFEhZDG6oJx
         HwL2yD4ZKkvoz96bUGt482OsPxOlxW5BhEhWjELUldqd9SWy+aiWV/N+ONIoA7mLJaVk
         kD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq/FMo3N2YZ5gAL5l22vJq0j+A2OZhZuCvLwNurrkgc=;
        b=I1gWSBmSdYHUi1r/8Q1mVCUWolUybwNU17VVpuNYjQq/9G2GoVCJsUwnlm8Pa5AUdu
         8Rae5ZwbWl49obh9hpUP3JtkW7Ukl6HztbJ2ygrPk5jpL3ZdB0bixQYV84vMqOL8MMae
         1A5YjWcboP6Iuk+deMajXrKCRNCuKYfEEqtypP/vxbXCO+Gh0owPx+fD7hi/6FtRfj/I
         dpzXIv/Fw3xL9KbDISHB5NmZo73RWQWMxSRtDv9rBu1RaTvPH2RgERb2fxT98cGjXxwF
         hs8krbST/4IQVlyxzwxRdWS0G5p0RHxyrYekPUL49ddro61kLp2Y2U1Tl0UjvAMB0R4s
         nb2g==
X-Gm-Message-State: ACrzQf34ZbcImYcvedk59lW8l6HP1vnu05VVWlj4fdiO02B+gC3O1/v2
        ck+OLU+PMwuWQ7gnbP4WM9iEXykP3KCzORsMk9A=
X-Google-Smtp-Source: AMsMyM556YALLSoPOAYf9n97JeOaCCTSnYFoq/N64HCBWoeTR6HEk1uJSTQJFEuirNFTC2BuXtx8CTg3NwG1VqDYXKo=
X-Received: by 2002:a05:6638:22ce:b0:363:5f6a:b736 with SMTP id
 j14-20020a05663822ce00b003635f6ab736mr4827121jat.278.1665219205231; Sat, 08
 Oct 2022 01:53:25 -0700 (PDT)
MIME-Version: 1.0
Sender: sandarmohamed@gmail.com
Received: by 2002:a05:6622:340f:0:0:0:0 with HTTP; Sat, 8 Oct 2022 01:53:24
 -0700 (PDT)
From:   "Mrs.Yu  Ging" <yuging9567@gmail.com>
Date:   Sat, 8 Oct 2022 08:53:24 +0000
X-Google-Sender-Auth: vFmBDiYgDFc72Ya8reXxXO-qhJg
Message-ID: <CAAzhOZS1jcR9Nmbmu5zbWQfg=JE+8TKv6_gLtP_TDNi_jm_vtg@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
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
