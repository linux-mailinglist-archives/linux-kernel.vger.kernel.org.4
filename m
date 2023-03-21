Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0D6C29FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCUFp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUFp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:45:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD55E1589F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:45:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z42so14358039ljq.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679377554;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HBDOzpKH5imfC4osZ7C5dgTOV9Q7fw2SPiikWGL4lc=;
        b=Y+Qc6kHfnFZVD/Btd+XH2aI5kVriqVu91X2973a9xpyltMZaZvQXr0HxHKeUmC+n/Y
         acM6Jm8QTjOblpusfM4S5F5EhZuvyB0Q91EU43GgucInnSGRiDn8APjYVYNseLp/J7AL
         yjYy9DfjwUzSDgxlWjLZG9vNtIldcAfE+yJgWCVvV1InvOH62f78OenMIFA1k84ejC1Q
         iW30yIA10QNgHWVxsug2HyhJnjuI/oBpPMmoM1mP2HFQDx2Mt0eWij4b4edC2YNeHql2
         EnrYjadoKye+6UMU/mSouMECLFfJVJKVNwnNh5hxrCjZqErsMUadk3bx6Nr0PdFtnT43
         UXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679377554;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HBDOzpKH5imfC4osZ7C5dgTOV9Q7fw2SPiikWGL4lc=;
        b=2EqyajClJGXybQQn+NiFBW+8fxgCgSjA7Y+M/NTV2mfqmkiujWnFFmfqpAAeeF1jmT
         6CrY7ih57qPC/ev20PJeZXzB2Eo0u/irxlhwfDVewUVfVsmu4shg/9zKy604Q0lK9ofe
         NZcHvLIcs1/X5W5vUg86zJ17fORWoWqn6U40HLP1P5RLlGdlHhAKYznv+79S7WNCltLm
         xXxM523dufSpae6D4uCBGqFMhm++7zwV694icQ5tq9ERklQq9oADxy2H5N2uuLuaYolg
         OFxVgz8ekHsWLW+idl+G1xAqzBU9lnHH+aVKSHkOOG9WbmNOvOxUk6MYeP2RHneiBcjM
         93Uw==
X-Gm-Message-State: AO0yUKX3NxmBsIlc6R91NqMAm7zuFUlCZtb49qZ29mZ9ZxRtkZ7g+vsV
        jNxj7PG0h4NSLXF71qjgyh4=
X-Google-Smtp-Source: AK7set8dSP5W4abkNf6oYLDISmKZHVAMC46issOrfH5biXxz6mfFYkUxhEOz9loABb8Mc2QaBVCEmw==
X-Received: by 2002:a2e:3c05:0:b0:29b:d530:b175 with SMTP id j5-20020a2e3c05000000b0029bd530b175mr419576lja.17.1679377553772;
        Mon, 20 Mar 2023 22:45:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p5-20020a2e8045000000b0029f7d27b78bsm56751ljg.110.2023.03.20.22.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 22:45:53 -0700 (PDT)
Message-ID: <d13cd7bf-0b1e-e9e1-266a-00db40e51de7@gmail.com>
Date:   Tue, 21 Mar 2023 07:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <cover.1679062529.git.mazziesaccount@gmail.com>
 <1abd47784b08939ff08ff03d3d4f60449e87625f.1679062529.git.mazziesaccount@gmail.com>
 <20230317150916.a3xrh25ywe5k77yp@houat>
 <e8f50fe8-bad3-e59e-4d80-e2f7db9c9933@gmail.com>
 <5ace543cae7a54db399750a1b330c3ae.sboyd@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 2/8] kunit: drm/tests: move generic helpers
In-Reply-To: <5ace543cae7a54db399750a1b330c3ae.sboyd@kernel.org>
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

Morning Stephen,

On 3/20/23 21:23, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2023-03-18 23:36:20)
>>>
>>> I think you would have an easier time if you just copied and renamed
>>> them into the kunit folder as an preparation series.
>>
>> Yes. That would simplify the syncing between the trees. It slightly bugs
>> me to add dublicate code in kernel-but the clean-up series for DRM users
>> could be prepared at the same time. It would be even possible to just
>> change the drm-helper to be a wrapper for the generic one - and leave
>> the callers intact - although it leaves some seemingly unnecessary
>> "onion code" there.
>>
>>> That way, you wouldn't have to coordinate DRM, CCF and IIO, you'd just
>>> create new helpers that can be reused/converted to by everyone eventually
>>
>> Yes. Thanks - I think I may go with this approach for the v5 :)
> 
> Which kunit directory?

I was thinking of adding the platform_device.h (I liked your suggestion) 
in the include/kunit/

> I imagine if there are conflicts they will be
> trivial so it probably doesn't matter.

Probably so. Still, I am not the one who needs to deal with the 
conflicts. Hence I like at least asking if people see good way to avoid 
them in the first place.

Besides, I was not sure if you were planning to add similar helper or 
just wrappers to individual functions. Wanted to ping you just in case 
this has some impact to what you do.

> Have you Cced kunit folks and the
> list on the kunit patches? They may have some opinion.

This patch was should have contained the 
include/kunit/platform_device.h. That file was pulling the Kunit people 
in recipients but I messed up things with last minute changes so both 
the header and people were dropped. I'll fix this for v5.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

