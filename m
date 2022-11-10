Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F96623CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiKJHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiKJHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:39:06 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A0615F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:39:04 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f201so193179yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 23:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DhL+VLu79k3EFZrVSBU99oMX6SkQsiup8xFsDiO/bfQ=;
        b=jJ2T4euYfKdIRDXiLlLcimm75yBcAyNUsax/C9qP1JxbkWJZsOI9VCf0UZh0hQaReZ
         XZe60Y9m4WdStcK83YNd4YttTTjHJZfq3ufrlznvsHSRmw8s76vn85fPOtPpm275BjiJ
         sSrJQAOdkITHd4QxlzZZc9jwCvBFR8SntKJtgXeyq+Zr0MjbuyKVvpiu9YD04oqgaO5a
         jjHtHDXpH7A0SAWyQEvFmSwK4Jfa78lm3APkepqSDayoYwxjC4XKcyVxw2z8I5NdjJXa
         N0oUgBxIF5yf5LPYVYJE1DaN6tnRsrwjaRDchIk7gdI8Qkgh+hv5zPcu7v1LJcWFNsCc
         8vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhL+VLu79k3EFZrVSBU99oMX6SkQsiup8xFsDiO/bfQ=;
        b=0MjxVNulrSPrL9BRZqLzfQch6jNxJLT2xx4lJmw2E8t0jQKETcwZe676IWh2fvwEGi
         HuOge748BIghchOlpj87xLEmEzQN6wGC8/zAgPwnePoTrhTVR7mtvMj6G+ZeQl+d0xKk
         wjSYxIAqZgvSlbW9REMUNQZQDOpk+sbp3RfxzIUw02X7L0xJtrzYfA/kGlZxQy7ONRy4
         1twNCnHBLuN27eRRQOxX86I5S6LZS+upqMXBAnubGg3Ifft/0A62E/GVRZXHAYNjgwfs
         CWzxXDUvLysp9+PlSCAna+9wbvtFQ1OQH5DppfQ7aFC+2eoqyWGaeFk0zae8sMr/dag+
         nH2g==
X-Gm-Message-State: ACrzQf1mGgnSnqL+SgRBNpqODZr0loEeXwArLI43wsrgqhfht2S9jAxS
        i2h48AT+xsD/H3/YtFQFkz7SM9zjzWj0x4vdeyRmFZhr
X-Google-Smtp-Source: AMsMyM4/s8JJUmBKtioxRatZCAV5MyAzxHHKnMbuR4sFyyq3AWD/Juv4p86GIMfZIvYMPjTYWK/YYP187LbX7lpWX6w=
X-Received: by 2002:a5b:ec4:0:b0:6cf:c1db:b90e with SMTP id
 a4-20020a5b0ec4000000b006cfc1dbb90emr44384772ybs.449.1668065944044; Wed, 09
 Nov 2022 23:39:04 -0800 (PST)
MIME-Version: 1.0
References: <CAEq81z03GOTiME=q83B9L-fg3bG6Mu_0_Em67Y1DqTp_oj_fZg@mail.gmail.com>
 <68d969b7-1a86-3be6-86f2-a78e92af46a4@infradead.org>
In-Reply-To: <68d969b7-1a86-3be6-86f2-a78e92af46a4@infradead.org>
From:   A <amit.general.misc@gmail.com>
Date:   Thu, 10 Nov 2022 13:08:54 +0530
Message-ID: <CAEq81z2KLHOQoRaJybSF26iPoExfi_X6DGH=TVEHhmOSmzY-9A@mail.gmail.com>
Subject: Re: Submitting patches without using git.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is learning git necessary to submit patches to linux kernel?
>
> No.
> Simple patches or small patch series don't need to use git.
> As patches become more complex, git could be more of an advantage.
>
> > Can I do it without git?
>
> Sure. For me it's easiest to use 'git send-email', which doesn't require git,
> but I have also done it just using an email client (Thunderbird in my case).
>
> (git send-mail may require a separate software installation depending on your
> distro and its packaging.)

Thanks Randy.

Amit
