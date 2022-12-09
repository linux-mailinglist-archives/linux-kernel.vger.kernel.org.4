Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44BE6487F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLIRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLIRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:51:23 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713C7A192
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:51:22 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v71so6376522ybv.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fB/VNCYffmzHZxGdo7js0W5KTDDb84plw+kdg5svHiI=;
        b=Dvxrl5ZOSl8QHV19bowOaitVtpvtOZG3MCaawkrqS6zON7VEX2ibTONalB1BaXJDs7
         IOkOt/d1o+1vvxqrF/Is9DyNixKtprb3PVn6zFfdwkiAb75Sxx+sbDFeA3Yw2ad4518S
         7GX+eXTUIhi4LEQPDLBpr0b8AG09KQglK3hQHUmMtcMqDXE3pv3Z9sKkkYH5O+dqGQrW
         x97n73QVDO3VI89KR2fKQ9BIYtlzf/RIs6ziUTYWS0eT5KX45Wj4CKWXjXs7SbyWWUDg
         SxeUuXL4QZGWs5PKKdjB4AC/7ccpXRs5Iq8BcQx5Z5o0pxKXpeWkDYaH0KgL1HfzDs+d
         aNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB/VNCYffmzHZxGdo7js0W5KTDDb84plw+kdg5svHiI=;
        b=PTo6Tbqo491x0Q9GQ06I6lDvW5VWV+ImwTXH3v3T3mjzACHPx76Vxd10z9z1Xm+2TD
         GXiMg9nL/u42c/oO7Gwn4I2aKcFVPQE+naitGFG3B9HO2Vor7oppkLs0WlFk0YXrse2v
         sHeG7r3Gas9E0vsNvtZ4RLoHBkHgsX3wWZfBX56y4PSq/7Foio3rMKIJNSEv7GzmWKuw
         9bUltv5ZP0Xja2HIe84GOR95oav6m4g46Sj5jvjGl/ov4pqJ4C0tRWkgQN50cQ2CsT43
         jLUFHH6ioFnuNecVbPgqzAWWZ7BZdZEIANyYThYPuUqP4JkqmiERI3Blu2DAbkyd15+d
         E/5g==
X-Gm-Message-State: ANoB5pl1z4XpCebuP4Pt5ef2GzpXfr2LXrNccMf0d2cBZ45SW/C7Jdcj
        cKyWv9FwHF0q0FfUb70HSQ3KerIUThba59R8AvbIAQ==
X-Google-Smtp-Source: AA0mqf5GiGSEzfbvXCkKj2ph10ZyVtLGYlWo2eaF6hnhYo7Gi6YWnfbQ4IDbJRw9BDaw6i3LiBQQXUTtRjhvNVqkYDE=
X-Received: by 2002:a25:d4d5:0:b0:70d:f50c:29ad with SMTP id
 m204-20020a25d4d5000000b0070df50c29admr2866471ybf.265.1670608281652; Fri, 09
 Dec 2022 09:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20221209150503.11875-1-ajye_huang@compal.corp-partner.google.com>
 <eca17001-93ff-d379-1ab2-2927f1831e78@linux.intel.com> <CALprXBayJtWRe9J+q7EahgpXrRy_B-tMAf0KXbDtWa+=4RKyHA@mail.gmail.com>
 <22043956-e18c-9ed6-5091-188ae40f3cd9@linux.intel.com>
In-Reply-To: <22043956-e18c-9ed6-5091-188ae40f3cd9@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 10 Dec 2022 01:51:10 +0800
Message-ID: <CALprXBbxb_m_ieAi9VohZE+yUpyJ51rGE2VuskJpgNabB-gRCQ@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: sof_nau8825: add support for nau8825 with
 amp nau8318
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

HI Pierre,

On Sat, Dec 10, 2022 at 1:31 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:

> Suggested edit:
>
> ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
>

> That should be added in the commit message please.
>

Thank you for the suggestion title and I will add those explanations
in the comment message.

> Ok, makes sense now. Please do include the explanations on 8315/8318
> variants, I couldn't figure out what chips were used.
>
> I would also not use the same topology name as a different platform with
> another amplifier. I appreciate you trying to reuse when possible, but
> it's just better to create a new topology file. That way if you want any
> update down the road you can do so, it's more maintainable and risk-free.

OK, The v2 patch will be sent after the new topology file is created. Thank you.
