Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2762B199
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiKPC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKPC46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:56:58 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB74F25D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:56:57 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-368edbc2c18so155081707b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ew2//99NB9UvkhCPB1N+bY3qId3b/eLWsTimEeJxDA=;
        b=JRYrEo6lXdGs/v03hJixrujqnktmfudPNZmSklp2IkyuPr2udfW0bnqCHA0zH3Vsnh
         VIsNJaWo1L+eB3OX1LRwhXyL/LUP9N5veYTVjaoG75NyC2eZK5N8c1sHoknneiVo+4y7
         RgGvTyaV5nsEUEQ5Onjm6C2BMkEPN2DHFfTPAsaHHHl9Wf3CJqHtOlE4S2q9uco0RZem
         8CXJI4aC+A0dYjXQ8abPmih0jK5nR1O6aOa0+BGN11Ma+XJOuoy1z6/EatVHlU0iZXFP
         tBaxCLPANGlYiJRNMCcymEbm/GN+Hyvsm+RoCHa8HZuHInx4De+t6KYy0indqRr7WYSG
         bA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ew2//99NB9UvkhCPB1N+bY3qId3b/eLWsTimEeJxDA=;
        b=vGxofJoI8/3r/J59RGHKN2STZTaRSwBAFA7DB5L4J/3BTgz+XKM8XlIPw424yuD9rn
         oxpjfCOxe6oTDbGHvg1ulmSUNTRYW5MivC/oymbNWRNHpimUsxZa/cP5ebKODd70aSwe
         63gSJ+U2f4mp+K4tJmyuKIr4u0IVeSKzpFQZPA0S7uyhs2QkkfA58cv5JM0lBxWwm69K
         FVX5KhviRoDqxEA1OPOLt6AAJBJhNwXx06jzCwa0cN5fCMngakUj9QdF+xytp3LeTYSb
         K/WIQ0EpLPrdwFVQsWsujI9krICr/9GRIQ3Ne9QQHyBO9Qx+wvsyVX5cxmPobVP3kI4Y
         nctQ==
X-Gm-Message-State: ANoB5pkviWzypdyMARNJjmoFQmscBOAzxZvughB3bHingZ4KhAMcPFNN
        RArWNKqgL2HdhvwMBz4MjTLldBnZccv/aH/jDpU4iA==
X-Google-Smtp-Source: AA0mqf7UowKnr3ZpVmpHeJUlD8a+sWF4HxNtgbNICT7qFVic/bvEZqjsVgUi/EbtzlZJOOFQbpTGFuKIjadEpPAPicI=
X-Received: by 2002:a81:5702:0:b0:368:ba4f:dd9f with SMTP id
 l2-20020a815702000000b00368ba4fdd9fmr20616166ywb.155.1668567416909; Tue, 15
 Nov 2022 18:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
 <20221108042716.2930255-2-ajye_huang@compal.corp-partner.google.com> <PH0PR11MB58329B470ABC721F95EAC6EA84059@PH0PR11MB5832.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58329B470ABC721F95EAC6EA84059@PH0PR11MB5832.namprd11.prod.outlook.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Wed, 16 Nov 2022 10:56:45 +0800
Message-ID: <CALprXBa1NETwy-4v3j8rR0w7Oi-8A28CLH2HF8U-5TAqE4P58g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: Intel: sof_rt5682: add support for
 ALC5682I-VD with amp rt1019p
To:     "Chiang, Mac" <mac.chiang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Lu, Brent" <brent.lu@intel.com>, "Zhi, Yong" <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Reddy, Muralidhar" <muralidhar.reddy@intel.com>,
        "Yang, Libin" <libin.yang@intel.com>,
        "Lin, Chien-Ta" <ctlin0@nuvoton.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

On Mon, Nov 14, 2022 at 3:37 PM Chiang, Mac <mac.chiang@intel.com> wrote:
>
> As per discussed with Ajye, the board co-layouts 5682VS and 5682VD and verified.
> Hi Pierre, could we have your reviews?
>

First of all, I apologize for this letter of inquiry.

I got "Acked-by" from Pierre for the series patches, (
https://patchwork.kernel.org/project/alsa-devel/cover/20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com/)
Please you have a look when you are in free, thanks
