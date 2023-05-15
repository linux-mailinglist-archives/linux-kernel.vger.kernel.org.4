Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F47021A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjEOCYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbjEOCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:24:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B61BE3;
        Sun, 14 May 2023 19:23:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so11189252a12.0;
        Sun, 14 May 2023 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684117315; x=1686709315;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niU+K5V3bpGotdNKpKxWKa4Y6tYufU19KgTr2VkMAOs=;
        b=TzK1q0I0oFDYjnlEeRsc/RoZzCBtJzngsvHVhHS26gVUo+WtNoR51Fq2J0eVQ7V9JY
         XX0str2BASSFHiaTZa1p20RDKWbCbOTBcVuekLzpi+JmZ4hAQLVVVB90JscQ/O6LCq1m
         33xxZQotsk6xDNqaz6r/SXYBOFjKiK34BEgRgIf3SE8nx/vpkktc1z5RUd4lzSW7sJB2
         P3RGZxJ3dl0sty4J4Jtsg1bY3TLj3M9bGjC0VJ+RR/8NDFZFpuj/779GgmLIhRQ1UThQ
         qCYHhUs9gdv2JpOwsO6mZQe93pMNthS3PcHmjjjp2VFKGesJhteE0NfOKhrUYUfNqBgH
         +zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684117315; x=1686709315;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niU+K5V3bpGotdNKpKxWKa4Y6tYufU19KgTr2VkMAOs=;
        b=ZAdH1+YoAz9QQwVYthSx29MvakU3YSlXFmniNN5AzAtYvQN6W2SumJJtUgVY43x3wt
         UojbrrnGfWcU0WxX1N8wApzZiZyc02BQYeJiI0mkaIcSJw+//eYvLT62i48kCm3bquJR
         6uEjfIXE03HB10wNCoAo8yEJz2dyW0Z4jv/Q7TwFBNcdPBWMIq9ZebTAFXLIXNm48jjv
         8r76ILE0o04y0p9HzjfJ24qLa3L+8djeVT8TAzV7POveTr1J2oZ+KnYS3CSnE8g+drY9
         +dlFg29bstcIZrJEz+dlpIvS1mqJrsqClK5VEa+NsjJwsZXbODtwYf8ld+O1Fj/x0dOb
         OWNg==
X-Gm-Message-State: AC+VfDzFNXel8zdKgCYFAwBlpyfWkURMI61DeAfUY5yN/XsGWPkPJBjd
        zbgnbb+CG6/Sd+OhQqvuWGqSqEPxB5A=
X-Google-Smtp-Source: ACHHUZ6b0O29/SbNOOB1m/nfqjkm8TsYEwR4PWrH+ndWxFONqfoISHkRpOfAkfaFUYT1OsPN24E65Q==
X-Received: by 2002:a17:902:f7c9:b0:1ad:eb62:f617 with SMTP id h9-20020a170902f7c900b001adeb62f617mr9893964plw.45.1684117314765;
        Sun, 14 May 2023 19:21:54 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001a95aef9728sm4568073plo.19.2023.05.14.19.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 19:21:54 -0700 (PDT)
Message-ID: <018f62d0-ee1d-9198-9c38-e45b10921e2e@gmail.com>
Date:   Mon, 15 May 2023 09:21:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Broadcom 80211 Devices <brcm80211-dev-list.pdl@broadcom.com>,
        SHA cyfmac Subsystem <SHA-cyfmac-dev-list@infineon.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, julien.falque@gmail.com
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Freeze after resuming from hibernation (culprit is brcmfmac
 change?)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on bugzilla [1]. Quoting from it:

>  julien.falque@gmail.com 2023-05-14 09:55:38 UTC
> 
> Since a Kernel update a few weeks ago, my laptop freezes when resuming from hibernation. It seems to handle the resume process normally but at the moment I should see Gnome login screen, I either get a black screen with just a white underscore instead, or nothing displayed at all (no backlight). I can't do anything at that point and I have to hard reboot.
> 
> Steps to reproduce:
> - hibernate
> - resume
> - wait until the resuming process should finish: black screen instead of e.g. Gnome's login screen
> 
> journalctl gives nothing between the beginning of the resume and the crash, as if it never happened.
> 
> I have a Dell XPS 15 (9550) with Arch Linux. The issue happens on linux (since v6.2.0 I think) but linux-lts (currently v6.1.28) is fine.
> 
> A bisect on linux-git gave commit da6d9c8ecd00 as the cause of the problem.

See bugzilla for the full thread.

Julien: I asked you to also provide dmesg log as I don't know
what exactly happened, but you mentioned the culprit was
da6d9c8ecd00e2 ("wifi: brcmfmac: add firmware vendor info in driver info"),
which implies that the crash involves your wifi device. From my experience
though, GDM crashes are usually caused by xwayland.

Anyway, I'm adding this to regzbot:

#regzbot introduced: da6d9c8ecd00e2 https://bugzilla.kernel.org/show_bug.cgi?id=217442
#regzbot title: brcmfmac firmware vendor info addition triggers GDM crash on resuming from hibernation

Thanks. 

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217442

-- 
An old man doll... just what I always wanted! - Clara
