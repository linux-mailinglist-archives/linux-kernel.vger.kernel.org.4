Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811174FCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGLBpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGLBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:45:16 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BAB1724;
        Tue, 11 Jul 2023 18:45:13 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56597d949b1so4035233eaf.1;
        Tue, 11 Jul 2023 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689126313; x=1691718313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7D41W2Q0GJm1VQKqBCaJREjdexNzug56sAlarpFeut0=;
        b=kmW7ru/1QATZ7m0U0iuL3W3Qr5b7T6M1Es8t7EyibZo7tNNM3tFtQXGjG7YkbTAgF5
         RUM2JGU6+ypDogyoVEnH7dd1ny7tG7LCwhv4/nz24/ZHFqbDKv0NnE4aUtb3DevC4uvI
         hUcjH402qQOxvZ7Gc/fZSjBjuHG+eHSh5U2hxTinHqcCfjroyxWurm7d1xrjE9HFK+C6
         BMFGX/MUts+0sXYMnxT6+41husC+WbFgGTSUlV0p0gd00qNrtZ+oyoSIoo2C8CXspCxN
         N5GUQ85kpdrB66HZ/Nbk2jBj+abC0GFzrrhIM30DLK8F4jSC7lE6HBb0f9VQfuM8Mw8w
         qMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689126313; x=1691718313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D41W2Q0GJm1VQKqBCaJREjdexNzug56sAlarpFeut0=;
        b=HIxMiwmye57zIPgKPXLvsF8E/6agwvlovjswcGghRInkXkpPDIWeR7Yh6Ssq+rEKjo
         jpd78LSNXmM3lvj71BpRvjDIusIEKiRaS3ERoMUQbZ0pt2f9HVdCsCa0ZMMTvadAqmoz
         e11pVYue9IfG6vgcG25k8acuEUhl4ii4TNjJ+qAJNvD+fbIWaWIQlVBatT3+zV9ior1W
         DHpkdb7HphxOXnKlBh9kDh7qFsWLmoVnqVqnouDXO20rw035wDtgoifGHbGdkO9LLORk
         fc2uQNSnhuIvkXIl9lBviDt7gU461fViDoFSQ8viR0fuRBfNw/2PnnFvRmvLgvqB5RNi
         D7rA==
X-Gm-Message-State: ABy/qLajPYh8AUfns4FBA0JIhA2dA4mI5mPcfUVeDaoeYmlMdK9B2Ssi
        9NAutIMiqxknTYrqQSRNCqGfVZyKrD+CBJs6
X-Google-Smtp-Source: APBJJlHGboNCTov91yigP1NhCE9HbOq+WQJ4sw2/ZZ3JZ5UWQK0bpH/KE6ko6JrTotEzDmf58yE+0w==
X-Received: by 2002:a05:6358:6f0c:b0:12f:22c1:66aa with SMTP id r12-20020a0563586f0c00b0012f22c166aamr14989922rwn.3.1689126313060;
        Tue, 11 Jul 2023 18:45:13 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b001b9f032bb3dsm2255857plb.3.2023.07.11.18.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 18:45:12 -0700 (PDT)
Message-ID: <90830c22-0437-591e-cee0-67b16214bc55@gmail.com>
Date:   Wed, 12 Jul 2023 09:45:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711200905.6464-1-aarongt.shen@gmail.com>
 <20230711203017.cdfe2nrjx7lt25tm@pengutronix.de>
Content-Language: en-US
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <20230711203017.cdfe2nrjx7lt25tm@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:30:17AM GMT+8, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Jul 12, 2023 at 04:09:05AM +0800, Guiting Shen wrote:
>> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
>> +{
>> +	unsigned int i;
>> +	int err;
>> +	u32 sr;
>> +
>> +	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
>> +	if (!sr)
>> +		return 0;
>> +
>> +	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
>> +		if (!(sr & (1 << i)))
>> +			continue;
>> +
>> +		err = clk_enable(atmel_pwm->clk);
>> +		if (err) {
>> +			dev_err(atmel_pwm->chip.dev,
>> +				"failed to enable clock: %pe\n", ERR_PTR(err));
> 
> Here you leak possibly a few enables. While it's not likely that the
> (say) third enable goes wrong, it's also not that hard to handle?!

The driver used the enable_count member of struct clk_core to count the
PWM channels(4 channels). It will enable hardware clock only when one of
the PWM channels becomed on from all PWM channels off which maybe return
error. And in second/third/fourth times to clk_enable(), it just
increased the enable_count of struct clk_core which would never return
error.

It maybe confused at first time to view the code.
Do it need to add something like that: ?

for (i = 0; i < atmel_pwm->chip.npwm; i++) {
	if (!(sr & (1 << i)))
		continue;

	err = clk_enable(atmel_pwm->clk);
	if (err) {
		dev_err(atmel_pwm->chip.dev,
			"failed to enable clock: %pe\n", ERR_PTR(err));

		for (i = 0; i < cnt; i++)
			clk_disable(atmel_pwm->clk);
		return err;
	}
	cnt++;
}

-- 
Regards,
Guiting Shen

