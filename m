Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14AD64EE53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLPP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiLPP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:57:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5510C9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:57:14 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3b56782b3f6so38188117b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1DGsGWjQ0lY/lk24i4F5eJ6jE9F8/BmfTUTGv89WjOU=;
        b=eYlfeoDL1t77ii7tGk4s1m6jM3NBiZzn4Y5SBnG53bj48asOTxITgykqMQ/xZvB3r3
         4CBeyy8duebT6/vX+PIbqh1elpnC6H7IHzG/r5QzZYY55Tz48fd9GLLyDOt0UCOa8jj/
         7uwUdIQKk77jI8eTGYmGFDjzwd+910cdcxBzH5q2f3dVb5LSB9RyMqZQ5ot4c9ICBbba
         xwlFPs9npFsoTpalFmwj770pXORzpe3Dd7dlaosTl3eW+4ZADgB5cJE3CHONb6rK0EWV
         LaM4HZ+fkmDllfBQ1TEx1zQMkBtItezLUdjxksjLJiIZHBJPsaygZharnDmDGxaSwMJr
         7yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DGsGWjQ0lY/lk24i4F5eJ6jE9F8/BmfTUTGv89WjOU=;
        b=brhETNBk7OgwW51EVc8zS9UgN9XJnsb4qv+qC8yOc7tZB5B32iDQdk2wLMfxbSsRwp
         CZI+O2sjYAUg6vbdNI5iPYsx5+/v6G27LqarWw7gNoqeYSNJrvzO+QSZhudmkfBskMjH
         ZZzHsQFQahWEtOJoInEvj9uJidzWI8zCLMFv9x+i4OWV1w6H8aA8rJCKdAdlWZ5a6wcP
         j30nlusuyTdEOUy5rGfHSGvxejYLaY7ytyF2GTpkTeOb82VCjCxie/OxiWjIu7WxxBl/
         63vFDphYzJ/N3zj3ljc9Q7aBzmhg8O6oewDM7LoT6xqCVfKNbabCXZt3thdb+kEeCiV/
         XC9A==
X-Gm-Message-State: ANoB5pmOpGA8EPoYiZcodhyD5jz7JtxHRCc+dZVxi+pt5QBMUvLqsqS9
        uZsIXjYuIH4LIW9EEbU1FvKByD4YqZLt/AxND79Jii1nX9gghYafLUA=
X-Google-Smtp-Source: AA0mqf7zGwo31RP+2Xxyawt8Dub0IXytMy+goLFzNzvCDBBqB0ZbozYOJp3bY07v0+jktvVL5wk2C+QblJ4aQYv4xOE=
X-Received: by 2002:a81:9a95:0:b0:3f2:6ea8:f435 with SMTP id
 r143-20020a819a95000000b003f26ea8f435mr17498515ywg.277.1671206233242; Fri, 16
 Dec 2022 07:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Fri, 16 Dec 2022 23:57:02 +0800
Message-ID: <CALprXBYwNaHCe+EO9G_SvWg2HNVAz62KzaaxGCb1PssJshXUzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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

On Fri, Dec 16, 2022 at 11:49 PM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:

Based on the suggestions you provided in v1,
> Suggested edit:
>
> ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
>
> That should be added in the commit message please.
>

The v2 includes:
changes from v1->v2:
* Modify title and add explanations in commit messages .
* Use new topology file "sof-adl-nau8318-nau8825.tplg" instead of
sof-adl-max98360a-nau8825.tplg.

Thanks for your suggestions.
