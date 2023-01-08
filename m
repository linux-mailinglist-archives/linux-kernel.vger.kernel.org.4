Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5666167C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjAHQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:24:42 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B1DE84;
        Sun,  8 Jan 2023 08:24:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vm8so14571487ejc.2;
        Sun, 08 Jan 2023 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVFg+Ng1v8j3qOBuucZ+rBUFUSDnSrx9eVTTzj34UQo=;
        b=ZsJyNGtZM1a0eXmOW3vKUegwmO3cllehdhDtl+Pa3h7zRL4/+ZBXdBWcjiPMbsvBNv
         mBunpEuv6VK6W5UYb54+6LF6jZkN9rRVfD21aJgyHsc3OZWOYU6GyU1IbysPE96Brc5K
         ZRhtV3BW0da8P35LRznkfr1wdypD4d/nVQYQYBqTQDN90q4cxp/A4qDMgmMgkgEUr6Dm
         m6nqWFc08tG9BzBP2zZs0lCGs60SF7/ZOquvH+/qbxEM/Qmj7y7yUYAbG6DNK38w1/kv
         2ahDRBGK49RbSJR+EfAKeefjwYw5pGTSqU7ra5exe2AeP26NVrIv2NHDJQz6A4QRfK6g
         oCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVFg+Ng1v8j3qOBuucZ+rBUFUSDnSrx9eVTTzj34UQo=;
        b=GCiJ9mFoGIw5h+GoQsBTDdbzw8vw5pLov/Ln0jN+j3wChiZDh4lB9/zotXHDsssrG7
         yolCaFKspr9VUbbDoBc7Vjnw88qFTE7ytp62W25f4n7qtbMd25QuHaOmnVY7qAZZxm/0
         4K0aStdgDdbU9EFxL8LgCssHuXeIpeamhp54WESBOa7+6HjAms1zVf6ep9eyOPvb6qqG
         QPIp8PAbc9Vx/VDxivcuMv7YgOpzlMdySrMqR+0+tmsCCqX2OBaZ4kr2qZt5/8V28/kS
         Z+Bej31/d3y+G2Z+K7azixfCuPqsQvOFmgcJaiZf+VjVroANny+mr3q5U1ShrujX3ELw
         OXDg==
X-Gm-Message-State: AFqh2kqd2+ZzEXoEl/mVbkckLzcJBpdgx1tmaI6rKUP6B0RJp6se+sKh
        H7kMAGVdJylcfUKL/r2pVWZWJfN6SlI=
X-Google-Smtp-Source: AMrXdXsmAgYbJ2OwSO6PtOi5ARrI7IMJ+ArQNWk4u7Fz/e4LkDyR2oWT+dp5npWqYj+FxRUrTAt4VA==
X-Received: by 2002:a17:906:369b:b0:7e2:c573:d2e9 with SMTP id a27-20020a170906369b00b007e2c573d2e9mr48532942ejc.48.1673195064614;
        Sun, 08 Jan 2023 08:24:24 -0800 (PST)
Received: from homer.fritz.box ([185.191.216.48])
        by smtp.googlemail.com with ESMTPSA id se17-20020a170907a39100b007c491f53497sm2686885ejc.170.2023.01.08.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 08:24:24 -0800 (PST)
Message-ID: <67559215bb6a2f4d6f40f42192938ae48459db08.camel@gmail.com>
Subject: Re: brcmfmac regression - cfg80211_set_channel: set chanspec 0x????
 fail, reason -52 spew
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Sun, 08 Jan 2023 17:24:23 +0100
In-Reply-To: <509b8748971fd988c5dd623adc6db97617a50fb5.camel@gmx.de>
References: <509b8748971fd988c5dd623adc6db97617a50fb5.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grr, gmx.de rejected (550) by patch author's provider.

On Sun, 2023-01-08 at 17:18 +0100, Mike Galbraith wrote:
> Greetings,
> 
> 6c04deae1438 "brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection"
> 
> This commit seems to inspire my little raspberrypi 4b to moan
> endlessly, though it seems to work.  Brute force revert silenced it.
> 
> [    7.917448] brcmfmac: F1 signature read @0x18000000=0x15264345
> [    7.974270] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    8.326846] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
> [   10.799571] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save enabled
> [   15.078022] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, reason -52
> [   15.078347] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, reason -52
> [   15.185674] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, reason -52
> [   15.289609] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, reason -52
> [   15.393796] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, reason -52
> [   17.066478] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, reason -52
> [   17.066923] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, reason -52
> [   17.070632] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, reason -52
> [   17.071080] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, reason -52
> [   17.071653] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, reason -52
> [   17.072197] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a5 fail, reason -52
> 

