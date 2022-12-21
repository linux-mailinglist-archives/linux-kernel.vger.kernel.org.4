Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C446539D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLUXao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLUXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:30:41 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C21BE85
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 15:30:35 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-45c11d1bfc8so6248717b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 15:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hbc04cspKKUlq2xtt1rWNQAlNz5kGk6IPOX/yNft/AQ=;
        b=V4dAPKt/20f1/6R3bTH5oYl+4FuzQgvbjYDe0cXrjWnsYdsEPJyXJa6W1YM0OMXDA4
         NrAGlCgqPwDN9qVSDM4vphAcpbnVOdY8ipYvuPTRuwGzYuHgzzYBX8675DMYRapmwxqr
         f43LLTzoibaRKtUVkXCnvblD3j+IO0Km4GfBgtxHqQyYLIB5zPgHi+9B7nd/95doL3bJ
         CcrOr7sJkrrjSKD/uGJ0KOwhmq1tyGFvnxLxbd0t0xDg2BoQHOL+jXZkOd3SopUANXqF
         vJI7HbLQUhrrlh8XAAaR7hKes8ueemmMmzzsqslTQ0YdTU6o+ZwK/0Zaeo8iGpl7QYDI
         j/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hbc04cspKKUlq2xtt1rWNQAlNz5kGk6IPOX/yNft/AQ=;
        b=nQCND5ywj/dZoXJMdihAdl00bHHR2PZZMxUKcvlbny+H1I69EtTWh7MSm40y0WfNzs
         Z4HUboCNBNjWEJBnDplKFuYLPFiz+c1qupJAHbbEwqvY+OCKfm4eWJsoXFu4F2aVMjWE
         iXOWXv/D4aYgVLqmvnyNaC8HvjzUDPbA/lsWJs5ZPSoz+noNp53DNBw8DjFvJSyyNLYQ
         A7/26c4xkZYY+cUsMe5nlPmZS58ejqG5HpHXXWvCDOgJf4Nu+GssdtFyuMRQmDf9fvcV
         OhuPyscvOITOBxnORXhYPUuptkfFZd4VqsIDaeHrQvNA+ga7m7DK1+XOvLdXr2YQmjgD
         AY6Q==
X-Gm-Message-State: AFqh2kpprkdPp5k4n7nBLHaSVsAPB/aXBeI0x2IP780Vmn9E6vkl8MB2
        g9+/JYc0aSNVgZvhhdZy1/NGoCTAjHpCaik2sd5X/A==
X-Google-Smtp-Source: AMrXdXuvXVL02e5WE/59sAq11eayzxXSCUHaxb3H5iKshi4jzDDAn67x0CYU+QFbx7el2rNRbxssKT3vKa5SWTlcLqg=
X-Received: by 2002:a81:1149:0:b0:433:f1c0:3f1c with SMTP id
 70-20020a811149000000b00433f1c03f1cmr385286ywr.438.1671665434961; Wed, 21 Dec
 2022 15:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com> <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
 <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com>
In-Reply-To: <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Thu, 22 Dec 2022 07:30:23 +0800
Message-ID: <CALprXBZkhWitJBeenKHxzyQvkf=Q2FDAHKD511oCWC8-SJBK+A@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Libin Yang <libin.yang@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre

On Sat, Dec 17, 2022 at 1:37 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:

>
> Ok, thanks for the explanations.
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Yesterday, I saw Arnd Bergmann sent this patch "ASoC: Intel:
sof-nau8825: fix module alias overflow " for reducing the string to
prevent over length,https://patchwork.kernel.org/project/alsa-devel/patch/20221221132515.2363276-1-arnd@kernel.org/.

so, I need to check with you, should my string need to change the
format style with his, even the my string does not over length , from
.drv_name = "adl_nau8318_nau8825" to .drv_name = "adl_nau8318_8825",
align with his format style?

thanks
