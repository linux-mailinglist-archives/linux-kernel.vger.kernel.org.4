Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4A64CE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiLNQkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiLNQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:40:07 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8586554
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:40:04 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id v2so3686341ioe.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKOOiUPKftict/8DhQFtuAp51sa4ovrd2kJ1MyabHJw=;
        b=O3GKHlfCENCpCId9rzfgQyNazbXImgRjhe1IswoXuSD+obIOxQMzCJvjjn4DSO8TfB
         pnhJIYsu7L+bfp85STMCZNRGPLJsWYDIbGEnTiTNqiQ6QQMWtnc1xXP3s/hb29i0HQx8
         xLGWppNpMlvdaaE09ISsLcVZ+umUpgvV1+VKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKOOiUPKftict/8DhQFtuAp51sa4ovrd2kJ1MyabHJw=;
        b=t+siGAKc0sL931k8jeFMtF3tckepu+FVCQCblWua5msCITSbqd7RygcG56iu3leRwY
         z8XwXthS9bnJki+LEDX5O2QJ04seg3n6af2RxP/xZfObgVeGrkMZ+Ejop7o6+e4fxIGC
         QOpUcIB0yZFvfAmOEu4Gf4+UXzgwgEJpu/Lujlr838sYUswODkeuMiQwUsr/fXbiO2eW
         ow/qpCeRnUMF3z0rQFXwcO1XOSwVh8ltdXC499bFTavTPesFaAk+u1nIay2Spn0GtdWr
         Nwf0mUs+Fq+jKq70cTk5P/HJwrUCpU6Cn5V2hsW/iKy0ywkQh1HDvOpeP+ODWEE7kiYX
         E3gQ==
X-Gm-Message-State: ANoB5pmmriDHD6XvyHadLjVJBFFAt4nSlLafPGA1J3+s1urla0KP6I4u
        BIeiBbc0pybGn/28CD630wEQMQ==
X-Google-Smtp-Source: AA0mqf4uk2vQ/34IoSVvV22g4d7cg9twWjLWq2DpSCNefcinONz0Gv+PJabIJlO243XLGuqdLtAuPg==
X-Received: by 2002:a6b:500e:0:b0:6e2:d3f7:3b60 with SMTP id e14-20020a6b500e000000b006e2d3f73b60mr2416935iob.2.1671036003942;
        Wed, 14 Dec 2022 08:40:03 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c17-20020a023311000000b0038a0182e0casm1939716jae.11.2022.12.14.08.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:40:03 -0800 (PST)
Message-ID: <808f35bf-2800-c34b-cae9-4d8eaa11294d@linuxfoundation.org>
Date:   Wed, 14 Dec 2022 09:40:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] kselftest/alsa: Increase kselftest timeout
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221214130353.1989075-1-nfraprado@collabora.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221214130353.1989075-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 06:03, Nícolas F. R. A. Prado wrote:
> The default timeout for kselftests is 45 seconds, but that isn't enough
> time to run pcm-test when there are many PCMs on the device, nor for
> mixer-test when slower control buses and fancier CODECs are present.
> 
> As data points, running pcm-test on mt8192-asurada-spherion takes about
> 1m15s, and mixer-test on rk3399-gru-kevin takes about 2m.
> 
> Set the timeout to 4 minutes to allow both pcm-test and mixer-test to
> run to completion with some slack.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Reduced timeout from 10 to 4 minutes
> - Tweaked commit message to also mention mixer-test and run time for
>    mixer-test on rk3399-gru-kevin
> 

What I have in mind is that the default run can be limited scope.
Run it on a few controllers and in the report mention that a full
test can be run as needed.

There are a couple of examples of default vs. full test runs - cpu
and memory hot-lug tests.

thanks,
-- Shuah
