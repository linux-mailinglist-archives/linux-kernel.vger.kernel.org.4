Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12AE648749
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLIRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLIRHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:07:34 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1401C6E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:06:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id s11so6250986ybe.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7v0Z5SII5lc88SchWlGOU2fHuY/bVMdgG+8xYXDaM4=;
        b=tEWPBuWaeaRHXKVLQf119O3ROzEzV0m0qCU63eeky+tEo5IBLDxDS/wUyD206U4tTe
         dd/CIyzh8kyfWI0AM42MKxiJvHcTAFJmWZ4pneTy8J1hEaGg5LgBUusYPSxEb9L6RadW
         JiX2SzDkItJYEP753ClmfmlXmNXQFnbdylwJIy1qjretyuofSHzjp1eQLbq2maepHf0r
         pJSsAKvXwBiIE54GFeXtZ5PRNjHINCPMqrjAfQQtcYloRR/Fz7jXi4vQRLr7AT28e9IC
         YeJ94a2T37qITRiKlWUFwlPQ6R6wlnPELx+QeCRT8QkqqY2LnTvwS9s9aUa5HJBgVBcn
         W0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7v0Z5SII5lc88SchWlGOU2fHuY/bVMdgG+8xYXDaM4=;
        b=kEhm++GiNCGt28CODGzDT89b89nixQgEwVSgV4kJAgd4KEkuNj0LvfHVPIL4TuEiQ1
         49YxoYy5K7bMra7ME+6MEuViPgqKln9r+JCQlGd43fy22yUmbxdCzrsi8uDADMFW99Un
         tZY01+Xkbs/kItYO4B+V81n0Vh0gxhySds3u54OVdikMRuknsCVx2kFJ9PkpNq832PBZ
         +ap/uXJipFJg5ol9nbGFU/zQN8fdkSNKpQILc0dg3WzoG3FtKhUAaNIN1wzufi4vidCP
         4/R3BlNZSI35QPch2XHUzw5gzEzFS3z1ILeNGfdaBgMXT13qX3QS9yadNCYdYg4ZEUkr
         oRZg==
X-Gm-Message-State: ANoB5pna+bpod4vQG994LNLKft010Nzkb3iGL0jnI8dtcBK+vy1Xccyr
        trcQkyWyhrLvO55KOlwsVxKHjwyoZ8ViJtj3ps0wYha9yQE8qoVwqn0=
X-Google-Smtp-Source: AA0mqf5T5MUF/zloobEh7ghw97shyQNQuYyAKTvXIS+ST8HKOfx+pYSxCC4f3/aht2O5lJ5Icoy5jntmn49DjBzF7ng=
X-Received: by 2002:a25:d313:0:b0:716:9baa:18cf with SMTP id
 e19-20020a25d313000000b007169baa18cfmr1009394ybf.453.1670605609116; Fri, 09
 Dec 2022 09:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20221209150503.11875-1-ajye_huang@compal.corp-partner.google.com> <eca17001-93ff-d379-1ab2-2927f1831e78@linux.intel.com>
In-Reply-To: <eca17001-93ff-d379-1ab2-2927f1831e78@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 10 Dec 2022 01:06:38 +0800
Message-ID: <CALprXBayJtWRe9J+q7EahgpXrRy_B-tMAf0KXbDtWa+=4RKyHA@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: sof_nau8825: add support for nau8825 with
 amp nau8318
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
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

On Fri, Dec 9, 2022 at 11:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:

> This looks inconsistent with the commit message. There are separate
> Kconfigs for different codecs.
>
> SND_SOC_NAU8315
> SND_SOC_NAU8825
>
> Which is it?
>

Sorry about confusing you, I think it is better to change the title as
ASoC: Intel: sof_nau8825: add combination of nau8825 headset codec
with nau8318 Amp.

And add some information about Nuvoton chips in the comment message.
***
The nau8315 and nau8318 are both Nuvoton Amp chips. They use the same
Amp driver nau8315.c. The acpi_device_id for nau8315 is "NVTN2010",
for nau8318 is "NVTN2012".
The nau8825 is one of Nuvoton headset codec, and its acpi_device_id is
"10508825".
***

>
> Deep sigh...
>
> This ACPI HID is already used to match with the 8815, so this is not
> going to work if we confuse two independent drivers...
>
> sound/soc/codecs/nau8315.c:
>
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id nau8315_acpi_match[] = {
>         { "NVTN2010", 0 },
>         { "NVTN2012", 0},
>         {},
> };
> MODULE_DEVICE_TABLE(acpi, nau8315_acpi_match);
> #endif
>
> How does this identify a NAU8825?
>

The NAU8825 Is headset codec, we added a new combination of nau8825
headset codec + nau8318 amp in the machine driver.


>
> > +             .dai_name = "nau8315-hifi",
>
> and again this makes a reference to 8815.
>

Because the Amp driver is the same file nau8315.c , so nau8318 use the
same dai_name "nau8315-hifi"


> I will stop the review here.
>
> NAK for this v1. Please clarify which codec you are using and make sure
> all references are consistent.
>
>

I apologize for the unclear comment message, please give me any
suggestions if needed, and I will send v2 for review.
thanks.
