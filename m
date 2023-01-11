Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDC6665AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjAKMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjAKMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:04:12 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DBBF5A;
        Wed, 11 Jan 2023 04:02:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so2488204wml.0;
        Wed, 11 Jan 2023 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVfpR4qnnt4VaJlKgg5uKC+n6RBtytfGonDbBkqbvhU=;
        b=l8JdqoiRlZCHy0/sUK/ggzfLKv6dZ0hkwSA6WypM6VOYQO3LtTJhIS3yyuzQ7m3Mu/
         O2LvkATVrursa5rHARQ2UklGPDi4UXjzN9nufnP5x/TaFB8EnL7j4/Z06n7ZxeXAe79j
         Op60SZrTCplGrfi6kIgOSzAD0iYem8eT8fxiMMQ8RUgHGZdAGPYl6or+XUEwDTupr0tU
         MeCVH2Smrj4ktUzDWUp7RfasWibCO2tkBtfoSDbU3PsWGSjuhQFmjr/ahKga5DrrXC6H
         ibP8Qpl8rTeDOPe5cdKbhZeYRV/uY9Baps18lOz7h7R+xe4+YbrDyyjFvip8MvwRo3W8
         6xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVfpR4qnnt4VaJlKgg5uKC+n6RBtytfGonDbBkqbvhU=;
        b=jyMxbFKnIgJrVcSskrYz1PSoyiCb2XXmAAgXY+Af7eLb12vrDtvUTafc30pnjEyUJp
         eSXFtCch83Yb56g5ZFQDMhKS1C3GPiQfmnVanoONSeDhi4zpj6APWHTgo+rUnm2/YJ2q
         nfGDDH/VWL2z9Q1u++xgvtCd5RMh+zEJDCPnjd5T5BCvXo4GO75vkWQI32rsmQp74ELF
         19PZA+S6BcHHz6zmRKC4kQUECxlrv4kN0rnxlSc0Z+jXNKYNwsMiXkHjr7jH8Jh4Cwfs
         IvrPN4rmMnIoFcWB0UkXFQkpSEjVb7FWRNBOZYymqdASPn9vLvQjFHr+K1dl3LCo9Nol
         rxhQ==
X-Gm-Message-State: AFqh2kqJZMDMeplqQteLsseE1EHiqs82jd+mBkg6yHTXerUTTCTm7y+k
        AqNk0ml3EOvunfAx035mzT4=
X-Google-Smtp-Source: AMrXdXvecYCTkT70+jkiHCyw3UwZkXQsDEwpM6AgWar6XUAmcHX662YjzEzqEikkiMz+hxo4OMZ0Eg==
X-Received: by 2002:a05:600c:5014:b0:3d3:446a:b46a with SMTP id n20-20020a05600c501400b003d3446ab46amr55108709wmr.38.1673438522610;
        Wed, 11 Jan 2023 04:02:02 -0800 (PST)
Received: from [192.168.2.202] (pd9ea33ef.dip0.t-ipconnect.de. [217.234.51.239])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003d1e1f421bfsm1530104wmo.10.2023.01.11.04.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:02:02 -0800 (PST)
Message-ID: <d66843b0-5420-7237-c8e1-73bc402bff70@gmail.com>
Date:   Wed, 11 Jan 2023 13:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 03/16] platform/surface: aggregator: move
 to_ssam_device() to use container_of_const()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-4-gregkh@linuxfoundation.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230111113018.459199-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 12:30, Greg Kroah-Hartman wrote:
> The driver core is changing to pass some pointers as const, so move
> to_ssam_device() to use container_of_const() to handle this change.
> to_ssam_device() now properly keeps the const-ness of the pointer passed
> into it, while as before it could be lost.
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   include/linux/surface_aggregator/device.h | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 46c45d1b6368..24151a0e2c96 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -229,10 +229,7 @@ static inline bool is_ssam_device(struct device *d)
>    * Return: Returns a pointer to the &struct ssam_device wrapping the given
>    * device @d.
>    */
> -static inline struct ssam_device *to_ssam_device(struct device *d)
> -{
> -	return container_of(d, struct ssam_device, dev);
> -}
> +#define to_ssam_device(d)	container_of_const(d, struct ssam_device, dev)
>   
>   /**
>    * to_ssam_device_driver() - Casts the given device driver to a SSAM client

A small note in addition to the comment by Hans: I think it might be a
good idea to convert the to_ssam_device_driver() function as well. I
could also send this in as a follow-up patch.

Regards,
Max
