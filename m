Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164716C3DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCUWiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCUWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:37:59 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDC2D7F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:37:58 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c1so11997644vsk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679438277;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n46NWXqE/DHCpPFKbULbQWqCUMDw5M0Cu5SsAcT5pL8=;
        b=q4KZRs7hZBrYUxr1YMVJ6LGZLSOO+kZq8UdC42yI51VLVulWBWzYTfBd6GkqDACHWc
         WJz/NJZaxgYcYdPLZPuTTVMxNRD+LjbQwhArMWWaKrn1gYxRKXvEYV3QRmWXdbe4rWdq
         38sP1X/rRo901A4QD6OkXoI79AQvttoF/MshUWs3PHkBInUksFsBlyzijhtKC73yeiiH
         8wZ7Uexcf0JqPt0ECDt69XxoXlSHCRIzGbap1hifzv0VGC68USRRcrrGJxI/0R82Y9dC
         REkd3YWr+cEI0L2I4CJsU0+CV8rfEXl0W/PD45EpaMX7xl1fOvrGY7MF7+XwVM50l4L2
         MSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438277;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n46NWXqE/DHCpPFKbULbQWqCUMDw5M0Cu5SsAcT5pL8=;
        b=Rg+rjVLa2ioohUeKOoPwa+wT1d0zjBkeCXOK11lxVo8bFF+sTZTZYjaughEuCsTDo9
         6hiDHmfzU/KzYQyyqdeON5jkFFVd4AWmfgczpflEYMr8ANVscl9uQ38/GRTKv72mPdai
         79xPmK/EO2kLSR0R/9bG1fvG420LIV0JCETrgtAo7UvAsAP5ryOypdGb+68+iAs2HcYB
         dIvkGL1MtRPodEyXNNAWfIrdIogi2L67la0/ERhUkQFyJ/0Ojr/Xkqzwoj69U5NMxheI
         XXnjVo1eVFI/rWZSn3ZrVk0rYjgXPhDK0HjHK5JoOTvqxf+2ENpieNrVNnyF6KN9u82T
         FgKg==
X-Gm-Message-State: AO0yUKWnZTCgB7+Oq9c71YQE5uO5peUliYrnAr2yniyxrtAQIT44HzJT
        RRQuJBp0vBVHqCkbkGQtfxxZVWO0ks4V+FNZeiU=
X-Google-Smtp-Source: AK7set9GOlx8TeQfPKVTkcnlTYgQqoGt6zv7TYZTFFLKafhI9KzMzMEoaORUvVF6VNERk/jyzIlGiTYDYObwwTJRpuk=
X-Received: by 2002:a67:e153:0:b0:425:8e57:7bfd with SMTP id
 o19-20020a67e153000000b004258e577bfdmr2432922vsl.3.1679438277007; Tue, 21 Mar
 2023 15:37:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:a4d2:0:b0:3aa:f1f8:c0ad with HTTP; Tue, 21 Mar 2023
 15:37:56 -0700 (PDT)
Reply-To: williamsdrtracy@gmail.com
From:   Dr trancywilliam <adamaourdraogo1@gmail.com>
Date:   Tue, 21 Mar 2023 15:37:56 -0700
Message-ID: <CACdvt6MJoXwsd2Rb6Y9r_s+0ViOnwmmGi-JDT1-sZe0me_s6rw@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you today? I hope you are doing great.
It is my great pleasure to contact you,I want to make a new and
special friend, I hope you don't mind.

My name is Tracy Williams from the United States,
Am of French and English nationality. I will give you pictures and
more details about my self as soon as i hear from you

Thanks
Tracy
