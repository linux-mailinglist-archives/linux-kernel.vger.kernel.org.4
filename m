Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892F5614294
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKABEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKABEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:04:49 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF011140
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:04:48 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-36a4b86a0abso123659707b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Co31BusoGSY0MXuFeKA0QlCszA6tiMpIiw8hHEzMy28=;
        b=fFKYIUFXKtITwrPLqasMLB1EHzFCV1ahYkQ3s3TQmt2L/uccTfNAITexpynI2emGWQ
         L0efnOz06fdQ8AYkBw3yutXLfnrZD9pX+EAy71QXcnxzg7zwGB+ot793T+iJLK35xwJx
         3W+An4ChtjB6RS4TU/6nHfnIFyL+gUS3fqyy2Zzk/i4gUr40thWNi6GOryi4XGk0Rf7b
         29bnWmE+gT7Juq6qz4fkfjRrKCp/vVqxloUhoUJP73sHMYVQzYtCBWfS2hcW5sx+Qu+m
         55rOvBGn27AKXrhd7SPCjeIbnYet7rzcBRdHPq0gknY9a6e2XiYOx3jqaiZMLzJcQq3W
         0VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Co31BusoGSY0MXuFeKA0QlCszA6tiMpIiw8hHEzMy28=;
        b=BHagG5flvs042LbihvMjnh/9Bk5jwlbzkwG4enjjNkTNemI66qati14/Wm5Vbe+xBH
         ozkeVhxR6RKOOL4WVAQc8zoCBV96byw5K/6zhxko5fYrHQJiMwv0X4lovQOiXW7zGYnr
         pCutOj4f/tlgwgCX0z5xycIRuZQGlxjBwoDN7D+IbQkraSFwMACJIypkEk27RW1AYGQg
         N8+BfOiWrDwiAEzgQrlGsLly0K3XGcjyMEA10FFnF4R7cLhA5c5LTmqqEmj1fTWAU1Zb
         Muc0cGxq0vC6+sch3EpvAG48PndmHWm4UGa/PhxTRoJbdHtC1MxpZ0cTb8+QgxnmY+lo
         ngdg==
X-Gm-Message-State: ACrzQf3EkVJnn3G1ocUzKxTdymMrz78l7gZMuaj3V8d3ZEujKYZ0Y7ec
        KZp7u8QOLvumwUClNxae+7bNU2YTOpITi9jgVscjBw==
X-Google-Smtp-Source: AMsMyM5AqSG/s/7RS5sYTrot30XqWHEK/nyNuZSJdwa4sk5v4Ezc4sUV0G3a3sCElW41Ozxyxt5F67HvM8x9vV+w5A8=
X-Received: by 2002:a81:ab4f:0:b0:36f:d141:f9af with SMTP id
 d15-20020a81ab4f000000b0036fd141f9afmr15526798ywk.311.1667264687461; Mon, 31
 Oct 2022 18:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
 <Y1vDYNOwZNOco1hq@sirena.org.uk> <20221031184343.GA3235956-robh@kernel.org> <Y2A0fdwnHTqw/NDw@sirena.org.uk>
In-Reply-To: <Y2A0fdwnHTqw/NDw@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Tue, 1 Nov 2022 09:04:37 +0800
Message-ID: <CALprXBYEsB5z-iioBeyeBAwPFkOnkQn8CBbj9Di9CpdqvFFnOg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Document dmic_sel-gpios
 optional prop for two DMICs case
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Rob

To avoid confusion, I had submitted another one for process
