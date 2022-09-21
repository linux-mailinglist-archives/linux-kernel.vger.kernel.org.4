Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44945E5352
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIUSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIUSrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:47:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B384A2868
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:46:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id iv17so571110wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i9nU2qhEVkaH0qsXajGvw+bqIsCyy4CpxvTYAsdncBw=;
        b=wKgfh/x6w1hy61X74ZCRReBG7aVh/GYV0ah/rfS6Ev2L+fcOv5OZ+IlcPuOL7iIQIs
         c8hGpbrqM5aTbNdkNRtKRR5u2AVClZponhe/tTBosiGm9G4cjOK2snZXsfKN2nD5TSGH
         2RXAEmd3vaKpgZpJ4h7QWeipohASSFSW+O7kIa7Te07exRDZkXYT/5SK8opLTFmQdkoV
         OE9SCyTBoRV6KkNDZFgbP2ZAIj3OkijXDEBFuH/CJL19ope+ObUVECfqcaDKd3PczK5c
         hwGdnblTGtSU1UuiHuLFaOasv5e2NxIaZHWsGoi0Yq1QtTrqYD6pbFybMV63xB/DQxbp
         zH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i9nU2qhEVkaH0qsXajGvw+bqIsCyy4CpxvTYAsdncBw=;
        b=LQzr5WeFx5KQhhyQiTN6sozgSjB0C35TpKNo4nWOPYxFr1ODiCrwJFWJnfaDNzKW8t
         GnqLHkfNrbLblgsUHUYIEuwheS80oQoFslZckpxlfGpF9YLFG5Q3FGaOY+oNIVbioc1k
         d/zasyDiX3eEo2wMHQxLMCM5J/tP1Ze+2jq23Ox0+saVyGGfTNuUMMCx18kIzP6a3Qhi
         ZLisL6mjMOG6Wi5DjZsSJrfOqq7a/vOH8GDEXQCL6St4uuCdAPqoJ/I0+a+sy4UlFZbT
         4qy0lYppCk+cv2V2JQy3OUczHpf5i8/1Lp8SIQIZrwjkof4WgvG6ImlqBNyFSyh1xCnS
         King==
X-Gm-Message-State: ACrzQf2vWZoJv00CbzrsXkHxlNVDnWCAc5eKMoJybIqKG0RBEwCa0Ypq
        ojKF4eOMoEl0GU4bEoV3hKVohApdtQ2PKnIz7BBj7A==
X-Google-Smtp-Source: AMsMyM69MX8NQNgSTouZLoWMk5jLkqAJWAyDqxBLyjSG7wrk4Qhr8rvK+rscCvSZHH8RV9wWifVNX6kb/JFzeZ8ungQ=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr6600919wmq.17.1663786017787; Wed, 21
 Sep 2022 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220919122033.86126-1-ulf.hansson@linaro.org> <20220921155634.owr5lncydsfpo7ua@bogus>
In-Reply-To: <20220921155634.owr5lncydsfpo7ua@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 20:46:21 +0200
Message-ID: <CAPDyKFpgHDzc5Rv+0Tn4zegDTrc_wuymez02XLEdVUaEOornNw@mail.gmail.com>
Subject: Re: [PATCH] Revert "firmware: arm_scmi: Add clock management to the
 SCMI power domain"
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dien Pham <dien.pham.ry@renesas.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sept 2022 at 17:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Dien, Gaku,
>
> On Mon, Sep 19, 2022 at 02:20:33PM +0200, Ulf Hansson wrote:
> > This reverts commit a3b884cef873 ("firmware: arm_scmi: Add clock management
> > to the SCMI power domain").
> >
> > Using the GENPD_FLAG_PM_CLK tells genpd to gate/ungate the consumer
> > device's clock(s) during runtime suspend/resume through the PM clock API.
> > More precisely, in genpd_runtime_resume() the clock(s) for the consumer
> > device would become ungated prior to the driver-level ->runtime_resume()
> > callbacks gets invoked.
> >
> > This behaviour isn't a good fit for all platforms/drivers. For example, a
> > driver may need to make some preparations of its device in its
> > ->runtime_resume() callback, like calling clk_set_rate() before the
> > clock(s) should be ungated. In these cases, it's easier to let the clock(s)
> > to be managed solely by the driver, rather than at the PM domain level.
> >
> > For these reasons, let's drop the use GENPD_FLAG_PM_CLK for the SCMI PM
> > domain, as to enable it to be more easily adopted across ARM platforms.
> >
> > Fixes: a3b884cef873 ("firmware: arm_scmi: Add clock management to the SCMI power domain")
> > Cc: Nicolas Pitre <npitre@baylibre.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > To get some more background to $subject patch, please have a look at the
> > lore-link below.
> >
> > https://lore.kernel.org/all/DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com/
> >
>
> If you have any objections, this is your last chance to speak up before
> the original change gets reverted in the mainline with this patch.
>
> Hi Ulf,
>
> I don't have any other SCMI changes for v6.0 fixes or v6.1
> I am fine if you are happy to take this via your tree or I can send it
> to SoC team. Let me know. I will give final one or 2 days for Renesas
> to get back if they really care much.

I have a slew of fixes for mmc that I intend to send next week, I can
funnel them through that pull request.

Assuming, Renesas folkz are okay, I consider that as an ack from you, right?

Kind regards
Uffe
