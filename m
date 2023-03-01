Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3FC6A7235
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCARiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCARiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:38:22 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124212F32;
        Wed,  1 Mar 2023 09:38:20 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so4109639otp.6;
        Wed, 01 Mar 2023 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3kGa29UVZEEOfyHL+UXyRsndHDnYo7M/4/jqQbGaLg=;
        b=Q7gRimMO/lJKvnnIvI+yJ7bOQ7WuxrnnenTIyvcd3k1OWpIiI58BvOC24IkP2QuLTu
         lE6DBCmoa3kjMEKEoVZthCmPRGOPYLrvfL/kaN9HeDWyyN2sfRgwMLXNrLfSmlfVogI/
         BkLzSfZsGjrXjZBtpmfPHr2LcTFOT3HtA0GOQHm8DxfzFjS40dvfUz1a3SUEZ4uUXIpH
         1FcyZf+RRYyUBiFkwYI/V2oLTAaLkKHNlKBbA7p3s6nePiYUYzwzKaUm8Yv/F2X41DVP
         Ti4WTMnCtnNKnESvt+nvW+GJNuFaPRLx+hiXBEflX5fvSlkHuIpXqpZL650aneoUOAyk
         BSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3kGa29UVZEEOfyHL+UXyRsndHDnYo7M/4/jqQbGaLg=;
        b=RCMIl5yPDZxkVrOvVcaA1I/nlJ8cRjThowr3h4q3DwaQHbgWE3kYDOiGHHpJlz96B1
         6RX2T7JqY5Fbvl02i2G9NblgPWoHCeT475V8rw/lYAGGsHWpi+Kc33FpVpe9/f1GsHfn
         0/RP+L2s6Pakyu2Yh0RJxlsjPUMYCLUo8aT2ZExy8BsRMu2nXO4CzmpFfIgi6mefOgv7
         UDA8nYRVnKWnSceiezu73c+jllZe/IgSuvMFPA0jj6d1JHHMHyuK19eWW/LwsH96guoh
         zrZdnaEyBymIsK3CvTs5aC6KjrzoVOBefhmdQ7VO10OOahNl0Wg03gf1g0Di1ZUznBHX
         AQ/w==
X-Gm-Message-State: AO0yUKWKI00cqfzzje0C9/juCScSu1YonV1BQ/+Yzwk815g+CrD6ipZE
        vKaVt2hmtboi+Pbc+4tcXokFT7ruY4A=
X-Google-Smtp-Source: AK7set9KiZDsuUx5JZj9N+UbM8WhiMdHzbjfUwz7PbDTXu6m8YN/zE9GqCRG3qXONgAWufINz+BMew==
X-Received: by 2002:a05:6830:909:b0:686:40e1:2bf3 with SMTP id v9-20020a056830090900b0068640e12bf3mr4233562ott.0.1677692299874;
        Wed, 01 Mar 2023 09:38:19 -0800 (PST)
Received: from [172.31.250.1] (192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id d1-20020a056830004100b0068d01839027sm5076083otp.30.2023.03.01.09.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 09:38:19 -0800 (PST)
Message-ID: <a7ff3338-3d5e-4402-aaba-16e740f4ed5b@gmail.com>
Date:   Wed, 1 Mar 2023 11:38:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 0/2] Introduce block device LED trigger
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kabel@kernel.org
References: <20221227225226.546489-1-arequipeno@gmail.com>
 <Y/9gvmPwcTaY3pRA@google.com>
From:   Ian Pilcher <arequipeno@gmail.com>
In-Reply-To: <Y/9gvmPwcTaY3pRA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 08:27, Lee Jones wrote:
> Pavel,
> 
> I see that you are active now - could you please prioritise this one.
> 

Lee -

Just FYI, Pavel did respond.  Unfortunately, he doesn't feel that this
can go in with its current sysfs interface, and making the change that
he wants would require changes to the block subsystem (adding an in-
kernel API to look up a block device by its kernel name, rather than its
major & minor numbers or a special file path).

Similar changes have been rejected in the past by the block subsystem
maintainers.  The position I have seen is that major & minor numbers,
or device special files from which they can be determined, is *the*
interface to block devices.

I've also had some pretty negative experiences when interacting with the
block subsystem community - unnecessary profanity, etc.

Given that history, I don't see much prospect that I (an unknown newb)
would succeed in convincing the block subsystem maintainers to add the
API required to implement the interface that Pavel wants.  So I'm pretty
much done trying to push this thing unless something changes that leads
me to think that there's actually a decent chance of success.

Hopefully that makes sense.

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================

