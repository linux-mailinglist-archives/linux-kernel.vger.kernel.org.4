Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B122E64EFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiLPQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiLPQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:57:45 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84E1DDC7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:57:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v126so3042350ybv.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XtYFkDhReWBsCeUioaJC13GshaZLOuRIue5LEWshyfY=;
        b=HYg9RW0JMDQl3jsWznNXJ4PBNDDc8yajCgxG7D2P8HoCCU9IJSHyCYoe441jXf4b4b
         o8xQGMwsbRm0iocLcHGeP8ccR8ovbmJOWteC7WRZRYzLrW3WWVxkJlhG670C9fowh/Vn
         qN6mIsqNbHxuQEhNyyoAqo3XSla0wS9xNxKyxPL+IW45WQ5bTMUquaWaeuY2k5HIDsWv
         0X8R+Zr4W8soDrV+YOnoPDT1JBdbyPhtNNmFNneluIWGFNGsQxOrPL3f7WhnlU2D9Mwe
         dfMGwfxyiSj9TV0GQpZJLLnCFZ2oY1+P+fgr263viELuzdorUuAAXahzjcLmjPxAZweV
         07zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtYFkDhReWBsCeUioaJC13GshaZLOuRIue5LEWshyfY=;
        b=wa8wJf5AKWQ0sIE+VdfqSGwOJMCN26wh7MEnpSJ6xdHqVQp1GXKc0ui4p4K8dOwMAI
         Q2d/cfSN98/25DFKwFd6sZhX/LmFKF6cnrS7dzwC2DjScVPOV1qZ4M92g+twcYLFzYeU
         2xtqiXNN+AQvdoPXLyVQ/rSgbG7JI1oxzN+TD0Jigs27yLmOxwlc8j9S/knXvGrDdTp6
         JV6JkykJcD92J81t3P8rz8jdhPQOCGuTvsbMp8PjMZ2SD10ffZIomzGrx0WP2XClS77f
         LHB2wlBENSl62Iwu9yvkPufRBoETCl8ul8xmBhklRPM3Z5XxgYM8IlNfRbgFjiv9Fz9S
         5NDA==
X-Gm-Message-State: ANoB5plb0QINhBoveRtfl0Iz90DaqkQRrXqYHOQGr7u0QiQKHCvwMXC2
        z1qcAZ3gaeMPyKWseLmE3O+mHZyYzASx5x2ALUrUgA==
X-Google-Smtp-Source: AA0mqf5Rrhd258RsDsUxljUaF/shuM6d9GJaesELzHST8ajJvjwROAa03gy2ef94K/ZvQcw+VVOY8FfulNKfcOHav8c=
X-Received: by 2002:a25:d4d5:0:b0:70d:f50c:29ad with SMTP id
 m204-20020a25d4d5000000b0070df50c29admr5212530ybf.265.1671209862956; Fri, 16
 Dec 2022 08:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <CALprXBYwNaHCe+EO9G_SvWg2HNVAz62KzaaxGCb1PssJshXUzQ@mail.gmail.com> <f479858c-b7dd-5af6-c0f1-c119737a7cc0@linux.intel.com>
In-Reply-To: <f479858c-b7dd-5af6-c0f1-c119737a7cc0@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 17 Dec 2022 00:57:31 +0800
Message-ID: <CALprXBbjb8DRuKu9RFxmKJHgc57++wrWXmj_g4wdZ+YCna78eQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Libin Yang <libin.yang@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
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

HI Pierre-Louis,

On Sat, Dec 17, 2022 at 12:06 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:

> You can add those directly in the patch, below the --- marker, e.g.
>
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>
> changes from v1->v2:
> * Modify title and add explanations in commit messages .
> * Use new topology file "sof-adl-nau8318-nau8825.tplg" instead of
> sof-adl-max98360a-nau8825.tplg.
>
>  sound/soc/intel/boards/Kconfig                |  1 +
>  sound/soc/intel/boards/sof_nau8825.c          | 23 +++++++++++++++++++
>  .../intel/common/soc-acpi-intel-adl-match.c   | 12 ++++++++++
>  3 files changed, 36 insertions(+)

Yes, it is really better, thanks for letting me know.
