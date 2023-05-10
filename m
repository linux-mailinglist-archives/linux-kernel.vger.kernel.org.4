Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55D6FDA84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjEJJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:18:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCB30C7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:18:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so1798688a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683710282; x=1686302282;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jevaS7XjYmubGxCabqB2SEiMi0tGSHztXxg0wz/p34=;
        b=aGm4T2ImeDl3HjLxeWJMDW3qjdYp5oX4KjuQT3omAd9HqwymdXoVAOkA/zlJqo2y9r
         a+g/FhkDKXE/hrqKlThAQjXEnj79UA3u4n683UNYF2ARpjRlNeteot0WZJj1d1xM1NnU
         e+8Gf/afKFiLPxcsyi4hOwFx0S6xU800dzIeUAqAajU8TKHcgh9IBXtbJS+1liinjO74
         qQ7Cz2z8BNIKGXe1Zjnxmk2GIkXCx79JrJDhv20qtDvHL99Nzk3hqhoEocTodcLYnkTb
         hdVa7ciWOLHHHOBQXWHW04532l2RiFsHLh5+QGmrBsOta3BpFm8p1/i/eZpimV2Ha3m5
         BkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683710282; x=1686302282;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jevaS7XjYmubGxCabqB2SEiMi0tGSHztXxg0wz/p34=;
        b=b3/V19A3BRu8LrvbZWdOAPjnOmAZjwJqTJ1Ws/e58NOtEBqPsdKVSVGESa8JEiqF6W
         qNAlM2WCFoKMEhpM0pQ7qykvjj8dlqCr6mvjJjwf+tghDz+adaqoH4BA+AU0m2xN3CTL
         u1p1DhjCBp2VoiO2mmfYZB6qiTxKD7vfYfFKfQjbtawhj4o3RI+KgALqEZKxIEqcRmOb
         pJZCDpzMpRGK4eEhuoupXpHK+P7CVwf151bmwQPH8E8OIdrW40PJMXFarFBpBmwCiVJW
         vX7NMYomiY/LFc+r5yBf6fZSHSQbDOvZ1yephDFWGNXrLAcbyL/rY1QF/udj7Yn04hsm
         r6Cg==
X-Gm-Message-State: AC+VfDyk1DFI9u1sjThmgbgapy8krbhvS+cP/MFMGMavh9QkB1Vg1tpM
        JOzHUDappKXAVaDf10MF4Fc=
X-Google-Smtp-Source: ACHHUZ6kfTMCVyOH550c2jp3dI6n6OyH0zYXAmIdy28wl6JY97gMQHsMTiRNxw/4pjrcSq6Coyc+fg==
X-Received: by 2002:a05:6402:3482:b0:506:97f2:1a44 with SMTP id v2-20020a056402348200b0050697f21a44mr15235342edc.3.1683710282395;
        Wed, 10 May 2023 02:18:02 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7db8f000000b0050bc863d32asm1669580edt.27.2023.05.10.02.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 02:18:02 -0700 (PDT)
Message-ID: <414e52c8-d1b8-e445-c896-0f19effc6708@gmail.com>
Date:   Wed, 10 May 2023 13:17:59 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        axboe@kernel.dk, 42.hyeyoo@gmail.com, surenb@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
 <2023051052-recoil-headache-1594@gregkh>
 <f1a912ea-884b-fdcd-1c05-87089f1e97b7@gmail.com>
 <87a5yc626f.wl-tiwai@suse.de> <ZFtT9J0DQI9uSd1x@ugly>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <ZFtT9J0DQI9uSd1x@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.2023 12:21, Oswald Buddenhagen wrote:
> On Wed, May 10, 2023 at 10:06:16AM +0200, Takashi Iwai wrote:
>> Also, if it's only about white space fix or some indent level issues,
>> that could be rather more noise and disturbs the git change history,
>> e.g. it makes difficult to find out the real code changes via git
>> blame, especially it touches a huge amount of lines like this.
>>
>> That said, I'm not going to take such "coding style cleanup" patch
>> blindly.  If it's associated with other real fix or enhancement, I'll
>> happily take it.  Otherwise, I'd rather leave it.
>>
> a maybe less confusing way to put it would be "do whitespace cleanups 
> only on the lines that contain "real" changes, and maybe in their 
> immediate proximity for consistency". that means that whitespace-only 
> patches are by definition not acceptable.
> 
> regards

Oswald, Takashi, thank you for the explanation! I got it. The acceptance 
of codestyle cleanup patches vary from one Kernel area to another. I'm 
curious about the sound subsystem, and decided to fix some obvious 
things before going to more significant enhancements I probably would 
able to make.

Kind regards,
Ivan Orlov.
