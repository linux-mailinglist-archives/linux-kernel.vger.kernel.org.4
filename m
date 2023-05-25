Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B421710213
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjEYAqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEYAql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:46:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636AD3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:46:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso1234716b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684975600; x=1687567600;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RomvB4DA9ojeYiKa8NyqSxbnHiS1nQrYLO/v9EOcUE=;
        b=DoBOGQ+m2clOgR685J/bD4OBoNNP8RRxcyCdrcnX07MqvSNTXoT9c/QipttkT2tL2U
         oMrWjMZzqzWzFDnfDYnEob/i0/EDWa9UvNX8V+CDG4bT3/berfnMMoJ3T8H8asQYkZrz
         zjDXEMYSXFQRi911epIIzymL3A5DTwgP9DprgjP4084++HuDnJxLBXMe0HZ0RLRpJjLh
         gPl/K5D2ZGKOOHV/qO4s0VU+jHNMLYbTQMt2oVmCp4QC7/uNTllRiaFOHXRWCT2Ex5so
         gRGsBQRDVu95Ceh8p3p24K++HTsNpTCDzflT34UeUfgHbJ2ytYlN4Gc5SyXVnwFdzxba
         XCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684975600; x=1687567600;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RomvB4DA9ojeYiKa8NyqSxbnHiS1nQrYLO/v9EOcUE=;
        b=fFQ4eOonDWVVMbhEQRPY6E1X5pC0xvOBwSgHzOfjzOSq7444ifeP8uAU/g03Du2pxI
         n9FWCphtbmLA68dAUiBfORFTDPYGY+cKRLGY2zDhXsH5CA5bvknQT0qchcD/h1OpzneZ
         t//KOLl2jtm7RzyJf+jbNKp3utrg4emQQf059uQ+OJ+z3X6Tbzg+NA2Ad96ufylEWbwQ
         6DXwvV02DuNA3dMj9OHPZz78aPNCoXbUrB5V+0cRiKsxtWCH8K8oaAvt4BPfI7FKfJwK
         TDZpZiJxuUAA29ojacaZr81cm+lc+xvxcZeVT1AVr5ytYygwf5XCGeOnSyhfRWv9eAV0
         BqrQ==
X-Gm-Message-State: AC+VfDyEcf6b9BdsfV6P4G57UIsvH2nA0c/YhbYrw3qUNxh9nJD7e91R
        OJHyLNEC6Wpth4X0pOnLhVI=
X-Google-Smtp-Source: ACHHUZ7Jk8m0u/sCue3c9rNgAMYF2sIXb2Nu8/W340oQ/6nb3GFgnMnAp8gh/SWNGvJJ+IZ/ktkYTg==
X-Received: by 2002:a05:6a00:1881:b0:646:1f13:7fce with SMTP id x1-20020a056a00188100b006461f137fcemr6569792pfh.2.1684975599960;
        Wed, 24 May 2023 17:46:39 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-12.three.co.id. [116.206.28.12])
        by smtp.gmail.com with ESMTPSA id 26-20020aa7921a000000b0063b89300347sm43308pfo.142.2023.05.24.17.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 17:46:39 -0700 (PDT)
Message-ID: <1d497dd0-958b-6385-b7fb-ae852e3e733d@gmail.com>
Date:   Thu, 25 May 2023 07:46:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux ALSA Subsystem Development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Karthik Bala <Karthik_Ramani@hotmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: =?UTF-8?Q?Fwd=3a_XPS_17_-_Intel=c2=ae_Smart_Sound_Technology_for_MI?=
 =?UTF-8?Q?PI_SoundWire=c2=ae_Audio_=28device_not_recognized=29?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. As many developers don't keep
an eye on it, I decide to forward it by email. Quoting from it:

> Ubuntu (Lobster) 23.04 not recognizing Intel® Smart Sound Technology for MIPI SoundWire® Audio.
> 
> gnome-control-center showing dummy-output. 
> 
> I tried with the latest mainline kernel 6.4.00-RC2, still sound not working.

See bugzilla for the full thread.

The reporter said that he had problem only with integrated sound card on
his laptop, and he also attached dmesg and working audio capture from Windows.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217461

-- 
An old man doll... just what I always wanted! - Clara
