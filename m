Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00936521FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLTOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLTOGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:06:22 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A56449
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:06:21 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-459f080c3afso18038087b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVRXp9HWSut0MqMLMIW4lN1+1yLdsL4S9FACC69XIO4=;
        b=CCoYhv92Vl2muPxLcXtYX6rodjS1ytyNvv9t0mMUu2eVCrcwH9JHGxIApstv50fHtj
         itYJR/PyIPe9jsLox4jXqbZrBJV6alw1JZ1o9TJudDuhht/VGIy4rAMyDAc2zh8kFlPB
         XVIBflim1ou1oDUvdHHUU8LplKKkbCjb/0nqwMgD+QFmR0j0syeu2bSjzvjz+3MilYKn
         8emu8yi5+u1yxMY9qS4tSHyoTFbTrhG9dojyUV4EpAJ0xzCxVfnY6B0pOPoWzsHkxE9d
         r+EKM/Ji1RT0u7npJpYPQ7KbZU6U6gBg/1ShiMcwwbKEzwFWx3XdrlpmQTkG5BB99xmk
         CwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVRXp9HWSut0MqMLMIW4lN1+1yLdsL4S9FACC69XIO4=;
        b=ejO6CIDi9cHNXiDEswC7rJ5kLqF3DMGEojJcMROZ32mOAxzaQmsAz3CeDlHIYMDJtI
         jA07nVlJ4JptcefQmCGGu89p3GG2GRMPBKutRPWBPGTa2j4xFFc5AAa/JpLmCEs+ABcg
         +bq+nUl6zejwEwBFuXr0XBKHv1sskjGnJ1AT4FjJdwgFr4V8AXEWHYQRHCBBNJ0p48jN
         bRg3TwtRWEv+19/6O4NyryCGR3yx9wHYnQcM9deUwfZPUwUZZ7TrLFiNgIH85BZLPgu/
         MZQbgyubeAPv7sKGx/90Orgqlmzlf5KBN7Cek2q1sF5p60ljXUQ0iHZ2HJuzMCAlV8y9
         JoYw==
X-Gm-Message-State: ANoB5plWuYsvQF3bjW4ucuv3/h2G8J107JTBBucI5j3b/KPclzmOpYpc
        2nlRg0gYLbZ0bWC/GMYONHUgStNYlYvwgdlfevxdbw==
X-Google-Smtp-Source: AA0mqf4oJ8+ioIHfs77wMEDfrixzL/lH7cThEPZQcNaJKW4kU+NH4sDF4PekNHZfJ13KSEeOcZJpiG+thGcnlc5sKpg=
X-Received: by 2002:a81:d543:0:b0:3ba:29f1:1ddc with SMTP id
 l3-20020a81d543000000b003ba29f11ddcmr4496842ywj.311.1671545180928; Tue, 20
 Dec 2022 06:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
 <b0612bbd-2eba-36cf-9c29-7542cf32adfd@linux.intel.com> <CALprXBYy9_ax8-xfh0paB59Pn=TB7yVLwtY8vnT_-y5vWd867w@mail.gmail.com>
 <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com>
In-Reply-To: <9aa4bffd-bc7e-0e40-3063-5ce80b5fbe9a@linux.intel.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Tue, 20 Dec 2022 22:06:10 +0800
Message-ID: <CALprXBaw7biz6V5j0YGtbR7CJF6ZWZf3ZO_t4hZBOHx_5zLS8g@mail.gmail.com>
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

Dear Mark,

On Sat, Dec 17, 2022 at 1:37 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

First of all, I apologize for this letter of inquiry.
I got "Acked-by" from Pierre .
Please kindly check this when you are free, thank you so much.
