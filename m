Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6120F60BFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJYAo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJYAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:44:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81213CBC2;
        Mon, 24 Oct 2022 16:17:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so10646811wmr.2;
        Mon, 24 Oct 2022 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=YjuOzmttWb0ZHzslbkylBfXvXPUFq+qvy1vIDkbRbIs=;
        b=AhItJiJettksiQTOHFgseTFR6DqFe/e7wb0/Uo96LIVwtwKXo5K5/fE62sCVPmEZpS
         T/pPdLPGS+Fo/xdYbfJZ7GREbBXngiazcLSBEnVbB0TcLPfyDsun/5lvIGwZEW1CwE+C
         qpgsbYBGHuXqLJHEJoGDQ8r3eSutZpAqd8JRp3xBIKVT33rshMDX7sxM+U918g5DrEFq
         TKNzvDq0kkwrBm74FVZ28BUy8Ke9oXOcst+1EfjkmS3MX2xEM2S1YwZgSBuUrxuUIpfd
         PPOMhOE+fm5whqD2iXiTp+u7ih+OO4vYs+uag2KuURwed7Z7jsCxRkyO+DVITWs86dX4
         nSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjuOzmttWb0ZHzslbkylBfXvXPUFq+qvy1vIDkbRbIs=;
        b=YzL/x7wF67XrBSZ49cbRMdkbSj78650N4dyBPkxwl5ifnAPXx8qA/9FR+sv8TATYY8
         FYnm1jqsegj+nmzmJexIquq5JxR6iCiPy8zjIfbD6ayNqKS4I0hlg5U447VlYW8nU6Qj
         WTbg6zfWRetUTb5nTfVMeNNlJtWXExxHnCyfr13O1NWYFT2ZBFQxxNHq1G5+0TFWEPwR
         ASlYszg7nLZ2tWdJeeIIamivMDj52FtsV6naoy87//fDpikI5crgZCTCQRbFaLVySkTm
         GWpR8mN6t7wa+Um5ynmX/kgcHZcDgNS2Ki3H80AHt9Hz0TBhtnA2A2jaGHWsUvS1arYI
         Qymw==
X-Gm-Message-State: ACrzQf1+ugT/JeHjRQ4fKrDNVifaTlvRPbFVn8fMq+oaOdZuuMJetaQ4
        G++ckdbKHHUsR8PPNihccTVMkY1LY/0DwQ==
X-Google-Smtp-Source: AMsMyM53AgmwLyYunIQBEg2gGCQmAocCp13pfXXXYPFcoghYXPQXxXsg2wMoDiPu87pMc/o7slafXQ==
X-Received: by 2002:a05:600c:4618:b0:3c6:bf28:ae64 with SMTP id m24-20020a05600c461800b003c6bf28ae64mr45996137wmo.51.1666653446401;
        Mon, 24 Oct 2022 16:17:26 -0700 (PDT)
Received: from localhost (94.197.2.59.threembb.co.uk. [94.197.2.59])
        by smtp.gmail.com with ESMTPSA id bl40-20020adfe268000000b002365cd93d05sm768366wrb.102.2022.10.24.16.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 16:17:25 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <Y1Z74/vKHbnaCLrX@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
In-reply-to: <Y1Z74/vKHbnaCLrX@sirena.org.uk>
Date:   Tue, 25 Oct 2022 00:17:25 +0100
Message-ID: <XaoRSEMyUlabAR8wEJITmm2lGCjwfPZg@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Sat, Oct 22, 2022 at 05:27:41PM +0100, Aidan MacDonald wrote:
>
>> Some DAIs have multiple system clock sources, which can be chosen
>> using the "clk_id" argument to snd_soc_dai_set_sysclk(). Currently
>> this is hardcoded to 0 when using simple cards, but that choice is
>> not always suitable.
>
> We already have clock bindings, if we need to configure clocks we should
> be using those to configure there.

The existing clock bindings are only useful for setting rates, and
.set_sysclk() does more than that. See my reply to Krzysztof if you
want an explanation, check nau8821 or tas2552 codecs for an example
of the kind of thing I'm talking about.

I picked those codecs at random, but they are fairly representative:
often a codec will allow the system clock to be derived from another
I2S clock (eg. BCLK), or provided directly, or maybe generated from an
internal PLL. In cases like that you need to configure the codec with
.set_sysclk() to select the right input. Many card drivers need to do
this, it's just as important as .set_fmt() or .hw_params().

Normal DT clocks don't seem capable of doing the job of .set_sysclk()
even in principle.

Regards,
Aidan
