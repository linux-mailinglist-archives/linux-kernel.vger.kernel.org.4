Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF065C8C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjACVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjACVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:15:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7B1401C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 13:15:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so10131039wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 13:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geSj+DXEUmOxdOeeDJZ/nQ54Og0nckMFbHdAOqXcfBs=;
        b=NK7NswDIpYAb+3I91f6REGYNrzXRXjaYUVihLgnWCLhd7xlBBlWi1yO8GNoW3Q1f30
         gH3yjAF0SgkFV8sCrehpcLG7ejJqObFL96M0Mai919/MeJEFSIgFGjxcv2EKbiCeM0EH
         Cz2f1Mlw6PDuBxiZhYiW7QnwH6C9498tVd6PCgVZ5UL9SbfVbUyYFJ79D0e6vRYCjw1x
         kau5TPxSu9TIAHtOwK0l2KlMAxt28dyOU71p2IZfbwvkyYNPjccydaKtR+ZxXuUEqSfe
         e6WRgWJEmltqaoDMq52Mb9O4hsS+mnCYilrqHzCeXqiS7nYsQ2mwv0UG3/u0n1gpHmAX
         4HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geSj+DXEUmOxdOeeDJZ/nQ54Og0nckMFbHdAOqXcfBs=;
        b=L/EqlSZxUwWCBPN1EmtpeLGeFenZZM2JFi1+EQ1ii3Zqft+fWl21nx3nsXumaDwHl+
         R0T5jaeckrKgSW3s+fmh9SDuhfjW6ZIbE4OwesXmVOIwR6IWUlk3x6Ibm036/P1lqngb
         5RZFnOIMFBLvTxERX0nrCFLDca4vJ8/GmKlhFcLQbQvf3eIAV3ZYiJJIWY82y4M/T0H/
         HoI84u171rOsuNE76c4C93u9vcpdNx20vRLMuZMRC3wTEjXhPgHekhlSICa6WsXetm8D
         oByfwG3Gm4Wns1HrD+JzHwCm27GQSpWvQ9199NjGrcMFV/pB0blPwiEFAon6DZc9L67f
         uEHA==
X-Gm-Message-State: AFqh2krbPCvUMuylp/pymCwfBTmlAf+Bk4+CLFHy2YIk0kYd4gHrZf+4
        HBh9cJQOkU2qI1M2J5LvdVFA/g==
X-Google-Smtp-Source: AMrXdXs4LAvgJkPYzg/o25RIqBUx4HRsevGt8UERo+VmDuRbJP8VQRFUFM72sq6SWnTqbG3XwOUDug==
X-Received: by 2002:a05:600c:250:b0:3d2:2830:b8bb with SMTP id 16-20020a05600c025000b003d22830b8bbmr35663176wmj.34.1672780515007;
        Tue, 03 Jan 2023 13:15:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm71148273wms.2.2023.01.03.13.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 13:15:14 -0800 (PST)
Message-ID: <7f6b2a9a-1ffc-424f-2287-5934cf653bde@linaro.org>
Date:   Tue, 3 Jan 2023 21:15:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup
 issues
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Hector Martin <marcan@marcan.st>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,


On 03/01/2023 16:58, Russell King (Oracle) wrote:
> Hi,
> 
> This series fixes a whole host of nvmem registration/error cleanup
> issues that have been identified by both Hector and myself. It is a
> substantial rework of my original patch fixing the first problem.
> 
> The first most obvious problem is the race between nvmem registration
> and use, which leads to sporadic failures of drivers to probe at boot
> time.
> 
> While fixing this, it has been noticed that a recent fix to check the
> return value of dev_set_name() introduced a new bug where wp_gpio was
> not being put in that newly introduced error path.
> 
> Then there's a fix for a previous fix which itself purports to fix
> another bug, but results in the allocated ID being leaked. Fix for a
> fix for a fix is not good!
> 
> Then there's an error in the docbook documentation for wp_gpio (it's
> listed as wp-gpio instead) but as nothing seems to set wp_gpio, we
> might as well get rid of it - which also solves the issue that we
> call gpiod_put() on this whether we own it or not.
> 
> Lastly, there's a fix for yet another spurious white-space in this
> code, one of what seems to be a long history of past white-space
> fixes.
> 
> These patches have been individually build-tested in the order of
> posting, but not run-time tested except for the entire series.


thanks for fixing these issues, I have applied these after fixing the 
subject on all the patches, as it ended up with email ids in subject.


thanks,
Srini
> 
>   drivers/nvmem/core.c           | 51 ++++++++++++++++++------------------------
>   include/linux/nvmem-provider.h |  2 --
>   2 files changed, 22 insertions(+), 31 deletions(-)
> 
