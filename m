Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DF5F3ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJDAwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJDAwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:52:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A33206A;
        Mon,  3 Oct 2022 17:52:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d14so6145788ilf.2;
        Mon, 03 Oct 2022 17:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yt4TBXUg1OvJmtHIvFVJEEci1sokCjqZ+KhLcjUq2pc=;
        b=XqO1x8/yyn31O22/IBO3zSbxch6ZO6i4Jt0od3C2H9rmymsekTbJCMaOTkGau6q6li
         YZWVkkSfbWszjCkz02Hs7T9Gypkm+Q6H6TlYzWYcN6WA8OonjXIlQmGTvkmIs1LMvHS7
         YNh4RHbhzcXjhP05E3jwPP9AC6hawXhPMj4hPBhxDKaoreH/poNn8QQQXHjuXfIMBQrR
         CxNFslCuss4V5oBh6droCKR+JWd/K5G9EQO2SRYOS8XW4BVgfGwCg6yNk1k9nyIOajJa
         iZPuY8NQvrsmnAXG+v1Lyvwcr30OZUwkdbAbCMveUHaBjjWMuELGgTc0BgyMTHi2u2SM
         O+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yt4TBXUg1OvJmtHIvFVJEEci1sokCjqZ+KhLcjUq2pc=;
        b=pEssNpZtFOKmejPQRmHQQ20547cvuymHtM1OVjiEXhefYK8RKaOG/0wuuooyAZwoK6
         Q/2W7FjaBCLLqSZTVmLNEGc15sJM+6MxRw4FhGB2aS0yP9J4uD2rgjRs3YicoaO6g5b7
         dTJ8IqY878vf8kjOEy92Cq0ya4eyWt+wK6F6FBYvyZINdzMQAUKTMtUMqKlBrxQ2+EC4
         AqAsUpE4BegBeIPwx3t68gYNTHe/Hx6ITMX0KFcsvOxbH/441DBHVZJ4Y4d7BQEEPJgQ
         PXVZD6I73yoie9DgDDn/y0tKK6KJvnCiT3aON80rlTJ+zks+xOFvCyE17PzFP4ff2ROs
         2utQ==
X-Gm-Message-State: ACrzQf0J8KNDNXGPWb6Bx0k1Yvgu/TDYjFSyuiD5tHB/O4GNyGdB/jDy
        AMb06lR3J3eYY0pjRX7cO/ABKxE729r3xA==
X-Google-Smtp-Source: AMsMyM4ZEOAN/9e6WoF3SfSN3/fqzouvXJZrTKGVgoKqxHAV1CW56wh91E8WTNKuBppsyeC0wC3hHA==
X-Received: by 2002:a92:cb86:0:b0:2f9:4024:51bc with SMTP id z6-20020a92cb86000000b002f9402451bcmr9258903ilo.123.1664844759695;
        Mon, 03 Oct 2022 17:52:39 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id t26-20020a02ab9a000000b00362bea5e4c6sm2472357jan.169.2022.10.03.17.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:52:39 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/3] pinctrl: qcom: add support for complementary reserved gpios
Date:   Mon,  3 Oct 2022 20:52:33 -0400
Message-Id: <20221004005233.34123-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004001748.qohdzdkmdofo35wc@baldur>
References: <20221001210725.60967-1-mailingradian@gmail.com> <20221001210725.60967-3-mailingradian@gmail.com> <20221004001748.qohdzdkmdofo35wc@baldur>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 01, 2022 at 05:07:24PM -0400, Richard Acayan wrote:
> > The driver-provided list of reserved gpios normally overrides any valid
> > ranges provided by the firmware (device tree and ACPI). When the driver
> > defines dummy pingroups by itself, it should mark these as invalid but
> > should not prevent the firmware from specifying more reserved gpios. Let
> > pinctrl drivers indicate that the reserved gpios list complements instead
> > of overrides other lists from firmware.
> > 
> > Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 5 +++--
> >  drivers/pinctrl/qcom/pinctrl-msm.h | 4 ++++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index a2abfe987ab1..cea1d2af8c88 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -687,9 +687,10 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
> >  	const int *reserved = pctrl->soc->reserved_gpios;
> >  	u16 *tmp;
> >  
> > -	/* Driver provided reserved list overrides DT and ACPI */
> > +	/* Driver provided reserved list overrides DT and ACPI by default */
> >  	if (reserved) {
> > -		bitmap_fill(valid_mask, ngpios);
> > +		if (!pctrl->soc->complement_fw_gpio_ranges)
> 
> reserved_gpios is only defined for ACPI drivers and afaict there's
> nothing in the ACPI path that would modify the valid_mask after the
> bitmap is being filled in gpiochip_allocate_mask().
> 
> If that's the case it seems reasonable that we can just drop the
> bitmap_fill() here. But perhaps I'm missing something?

This was me trying to be as uninvasive to existing drivers as I could.
I just assumed that it was important because it was there already and
the comment suggested that it was what the original developer wanted.

When looking at it a bit closer, the bitmap_fill() call in
gpiochip_alloc_valid_mask() wasn't present at the original commit that
added this line. I'm guessing this means it's safe to remove, but just
in case (for the next version):

Cc: Lee Jones <lee@kernel.org>

> 
> Regards,
> Bjorn
> 
> > +			bitmap_fill(valid_mask, ngpios);
> >  		for (i = 0; reserved[i] >= 0; i++) {
> >  			if (i >= ngpios || reserved[i] >= ngpios) {
> >  				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> > index dd0d949f7a9e..734fe7b2a472 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> > @@ -128,6 +128,9 @@ struct msm_gpio_wakeirq_map {
> >   *              function number for eGPIO and any time we see that function
> >   *              number used we'll treat it as a request to mux away from
> >   *              our TLMM towards another owner.
> > + * @complement_fw_gpio_ranges: If true, the reserved gpios list from the
> > + *                             driver will not override the reserved gpios
> > + *                             list from the firmware.
> >   */
> >  struct msm_pinctrl_soc_data {
> >  	const struct pinctrl_pin_desc *pins;
> > @@ -146,6 +149,7 @@ struct msm_pinctrl_soc_data {
> >  	bool wakeirq_dual_edge_errata;
> >  	unsigned int gpio_func;
> >  	unsigned int egpio_func;
> > +	bool complement_fw_gpio_ranges;
> >  };
> >  
> >  extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> > -- 
> > 2.37.3
> > 
