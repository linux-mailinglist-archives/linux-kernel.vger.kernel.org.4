Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387A743484
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjF3Fnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjF3FnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:43:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76A73C38
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:42:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so12421125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688103764; x=1690695764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H3Wh/u4h8U2hzhBkBZKlb9dLwPhiKplGCFao13VLdY=;
        b=ShY6QgMY+8oJf4I7rAttvpNGVQ1KvQO/4cKxqAcCdPX3+c5ECpQdewFuLRgXapjvu8
         khi9gPU2b6GQ9lg2FxW7pZxFaXzO62pXVGV541qdVr5jZ6kraRVWjEWNWXHAnxoXzQuE
         L10OL4rxncrXQV+MzzZz/NTA4XFLPq+YbEUzF7ZppyhlwnM2vyTxjzbVFIrEyPkcJh4i
         ja+KoAhJZ0vxv/ExTeb845+K9nmBAjJJ3+F7q37dNFdAEApf9IQELKQXJf7XupzAALUG
         UHirCJ8jbV4CAFd6eTJi0pHjTitwx88z0yC+/JhDVkE6r+pFZjijQ8sUgawvXl4zcJdg
         ZRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103764; x=1690695764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6H3Wh/u4h8U2hzhBkBZKlb9dLwPhiKplGCFao13VLdY=;
        b=WbkkubdpnECvemYJPPjrjffB1AxWbhkZRy2BlHloOvuteVAdKozsQtHPkfJQ9nceYf
         DR9VdnkTF+BNoE9GN619ZWpP+mV3il00aslpmk4CFNY/Mb1sDCDGou+nob32mS9DyQx/
         M++ywtTjwmebuDutVlPLfJn64zAMYriIuy2J2QjSiTeLUleBb+UEn+29POSBv9sxGZ2+
         HUpPIfCfiGPKaKdNnnvcb2LF+K/D+9qA6nob/YCf32RBh3aMlwfnPTBKu2I5k2OyoPlq
         mfaEn/jDd/DQwWmqOs6GBHbPXlIMLaMpxXhApi8scqYvB+VFQbTZU4LHU7tp9jc0VzSN
         K+GA==
X-Gm-Message-State: AC+VfDxlDWXXPnqHSG2yIrn0MvwVkmGws0TsGMRU6bJyqzRuyPyEMh8M
        jjD5JlXm5PGyH77iEB1aPHKjWQ==
X-Google-Smtp-Source: ACHHUZ75GbpqF6qcI9T1fiIIeKEFp0E/418uzdIfmYjFysVRcoVBsW9k2qMDWpjsSwcEN4eu8hG26g==
X-Received: by 2002:a7b:c7cf:0:b0:3fa:9741:5b73 with SMTP id z15-20020a7bc7cf000000b003fa97415b73mr1581327wmk.10.1688103764148;
        Thu, 29 Jun 2023 22:42:44 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z2-20020a5d6542000000b00313eee8c080sm13821824wrv.98.2023.06.29.22.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 22:42:43 -0700 (PDT)
Message-ID: <5fe3cbfe-645a-185b-9c88-5da56cfd7114@linaro.org>
Date:   Fri, 30 Jun 2023 06:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
 <77b348f7-0475-5e16-95e1-0e5831408d2b@linaro.org>
 <8c3be94e-56c0-4820-853d-669e90969c24@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <8c3be94e-56c0-4820-853d-669e90969c24@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/2023 18:42, Mark Brown wrote:
> On Thu, Jun 29, 2023 at 06:33:09PM +0100, Srinivas Kandagatla wrote:
>> On 29/06/2023 16:43, Mark Brown wrote:
>>> On Wed, Jun 28, 2023 at 10:24:04AM +0100, Srinivas Kandagatla wrote:
> 
>>>> For some reason we ended up with a setup without this flag.
>>>> This resulted in inconsistent sound card devices numbers which
>>>>    are also not starting as expected at dai_link->id.
>>>>    (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)
> 
>>> Why is this a problem?
> 
>> In existing Qualcomm setup the backend pcm are added first, which results in
>> frontend pcms getting pcm numbers after this.
> 
>> For example: with 3 backend dailinks in DT we have frontend pcm start at 3.
>> Now if we add new backend dai-link in DT we now have frontend pcm start at
>> 4.
> 
>> This is a bug in qualcomm driver.
> 
> Why is this an actual problem rather than just being a bit ugly?  What
> is the negative consequence of having a PCM with this number?

Yes, it is ugly but also breaks the existing UCM as the pcm device 
numbers keep changing.
Which is why I refereed it as bug in the driver.

--srini
