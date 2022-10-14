Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8205FF42E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJNTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJNTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:43:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F582FC0A;
        Fri, 14 Oct 2022 12:43:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a18so3194369qko.0;
        Fri, 14 Oct 2022 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ntqa7zGUvdkoaNKtpLHO8d7zkjCXynPr2O1UReD4IS4=;
        b=hWM2nuldlpT1GwMRadltQROOJ1UcxNz93fNBUQqz1H1K167JFumRhZEeiTQWkjVXfg
         Q6dfF69dv0Ub4IbGPuT/aEC6safmfQ7+wewR1eHedHFcdBGVWJJZdsIIXYTH+n9f9MaM
         tkdNcAIkEUIs9mp+WRtSgbKZWXBPOEdFQpSGiYb4gYMsnZ+KkskKQYTX/qAEyVcnSefc
         LnxeNe+0odSobij0QTyJJaLHMxCHp8glAyf8tEmQ3761srW6hBm4AICPWoguNKQCp6qq
         bhv/68xmcuRtu2GDxIOARd+hOTv94EvWT9mMlzfKEYujG6HrqAgFc6riJN+4tptJZH+B
         xj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntqa7zGUvdkoaNKtpLHO8d7zkjCXynPr2O1UReD4IS4=;
        b=UZNfnAiRpvgiAAVy7foZXG7QdHE241oMKU0kJC9IMWhVxfN+v75dN794GztVuyRF5j
         ySGO98fk5YBGy3BvvxYZYYFfJxPgzUWfOeRF5a+z/8HtSIzXN5vcsJCNaz2YTlvMYtRO
         MFrRKDJIqIQo0NlDlvB1m4KHY9zd0VpIeYAkyeWEvXZxAE1u5qV+/I4WJXGVZivePFtw
         KVlFSr+4PnI/I+/NgP/kbVALT1/nG/VU+Yg+syAb/rBkb+fCDZbg3HGcIu7+/ST33uXq
         xjzKugkErZHrHRGWF9j4E1hh7tYqXvFz2LbEO68Z998Ifcdnxa363ELZmqieobQvlosz
         WKOg==
X-Gm-Message-State: ACrzQf3/BjWlBNjF7DKqHjjRBz8IJuXs86XyXjjp3SjRlQIHpTwaF629
        XVdyojdkXg78LfCKaE6GYmU=
X-Google-Smtp-Source: AMsMyM7RS0AmiKiMA7R11UCVLvA+bZi0iN1SPGMBs4/6FU7fKMs+/k0fGUYgFvupdcxmXvvGXN6hAw==
X-Received: by 2002:ae9:f707:0:b0:6e7:2317:8318 with SMTP id s7-20020ae9f707000000b006e723178318mr4897896qkg.571.1665776625680;
        Fri, 14 Oct 2022 12:43:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9-20020ac85349000000b00343057845f7sm2540309qto.20.2022.10.14.12.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 12:43:45 -0700 (PDT)
Message-ID: <890f6ab1-f6aa-76c8-01e8-f7233143d7ec@gmail.com>
Date:   Fri, 14 Oct 2022 12:43:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/7] firmware: raspberrypi: Introduce
 rpi_firmware_find_node()
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Emma Anholt <emma@anholt.net>, Stephen Boyd <sboyd@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20220815-rpi-fix-4k-60-v3-0-fc56729d11fe@cerno.tech>
 <20220815-rpi-fix-4k-60-v3-1-fc56729d11fe@cerno.tech>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220815-rpi-fix-4k-60-v3-1-fc56729d11fe@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 02:13, Maxime Ripard wrote:
> A significant number of RaspberryPi drivers using the firmware don't
> have a phandle to it, so end up scanning the device tree to find a node
> with the firmware compatible.
> 
> That code is duplicated everywhere, so let's introduce a helper instead.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>   drivers/firmware/raspberrypi.c             | 7 +++++++
>   include/soc/bcm2835/raspberrypi-firmware.h | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index 4b8978b254f9..b916e1e171f8 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -311,6 +311,13 @@ static int rpi_firmware_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct of_device_id rpi_firmware_of_match[];

This shadows the same variable that is used later for matching the 
firmware driver and probe it as a platform_driver, what am I missing here?
-- 
Florian
