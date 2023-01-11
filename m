Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C6665F24
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAKPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbjAKPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:30:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779CF2700
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:30:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d30so19179657lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qbu6KqoFVUP3hpnWPUahg6+pfccNp1XMgcyJhxL3sHQ=;
        b=piJ6AR/7mwIv5ssf0bPeGI/y1HfticwRpnHpKDxpJJOmyFI9+Fcte6qtWkH0I2fOxf
         xTYmiVIlFySN2KbqHCXqxzBIxc6/2nlxu2+ixkY3fDhe2OFDyngzekiuLGrNcgW/Xsu1
         xqJdTvSzEIrHX7Hx9YvafGHvvBa4vY2qsZ3b1McEzW5tmaA8Nw9+yNGHiBd8I4QF/H0L
         PLkaIsFKD8tt7+XUYZ4Z0Jp/RHCbQ3m0OkeG8mkPs1ENMKkoMw8SGGYL4Yuyp+dMY28h
         Jcy4hVLz8OdUGwq9wRNwLttaNd4at+MPk+3V1lPBjbBePveIBaxuDRkGijEMOSgYcWva
         gHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qbu6KqoFVUP3hpnWPUahg6+pfccNp1XMgcyJhxL3sHQ=;
        b=bihgOOO4KLfYNmuj71/Y4BvuuwPR3+klQlzMuMbPWFwCfQmjCF9teiywrgZYtlgwL1
         RwDjWug1c+kZD0cK2RyNGqks+XebEoSg+FpzMDIs2c1/gOa9HEOUolgejlUMVR+awuXC
         s7CEgnQpUowPNsX2o4S3uu/u6IubwH8wuY1nAWyIwkqG9lOHqvqCzSmbu8l4+3obn1tC
         OX1f2mQk07K9g6paQ+lOTJ/maQQZIwYrGsEr2qih5yNyT6EFMZj+XLDni0H0Wx+47poD
         10OGHKAvUx1+4Ng9JnVZIM2LVz6BIBNzFTcXU6K9VUvx6XcI3PqN1m6eumXBnKkQXaW8
         jczQ==
X-Gm-Message-State: AFqh2kpa3gG9jg7l/csB7KNvGp9X19+iSpFL56Q30gV0MbMFM8FvhKGV
        wd00hetkDlpYHuVzyRhnH0ZH2A==
X-Google-Smtp-Source: AMrXdXsJsrNv/JojgqdyGM2htDPuCMqWkk3bmrHNobr84SP2C7Wa10a79dDgSHhARO48zeWm2i9u1A==
X-Received: by 2002:ac2:495b:0:b0:4b5:6755:4226 with SMTP id o27-20020ac2495b000000b004b567554226mr19619019lfi.55.1673451054761;
        Wed, 11 Jan 2023 07:30:54 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v23-20020ac258f7000000b004cb00bf6724sm2779947lfo.143.2023.01.11.07.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:30:54 -0800 (PST)
Message-ID: <88faa612-e7a0-24b8-aba8-4a42919402ec@linaro.org>
Date:   Wed, 11 Jan 2023 17:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 01/16] of: device: make of_device_uevent_modalias()
 take a const device *
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Liang He <windhl@126.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Douglas Anderson <dianders@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Zou Wei <zou_wei@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-2-gregkh@linuxfoundation.org>
 <CAL_JsqJ4QsLym-bQGGjUpzT14MYuTE1n8BQkGn6Ey9NiFF7u7w@mail.gmail.com>
 <Y77VDGvHGu8gDIga@kroah.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y77VDGvHGu8gDIga@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 17:26, Greg Kroah-Hartman wrote:
> On Wed, Jan 11, 2023 at 08:54:04AM -0600, Rob Herring wrote:
>> On Wed, Jan 11, 2023 at 5:30 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> of_device_uevent_modalias() does not modify the device pointer passed to
>>> it, so mark it constant.  In order to properly do this, a number of
>>> busses need to have a modalias function added as they were attempting to
>>> just point to of_device_uevent_modalias instead of their bus-specific
>>> modalias function.  This is fine except if the prototype for a bus and
>>> device type modalias function diverges and then problems could happen.  To
>>> prevent all of that, just wrap the call to of_device_uevent_modalias()
>>> directly for each bus and device type individually.
>>
>> Why not just put the wrapper function in the DT code instead of making
>> 4 copies of it?
> 
> I could, if you think that it would be better there instead of in each
> individual bus (like all of the other bus callbacks).  This way each bus
> "owns" their implementation :)



I'd vote for the generic wrapper instead of 4 similar wrapper. In the 
end, if of_device_uevent_modalias (or the bus callback) interface 
changes again for whatever reasons, there will be just a single place to 
fix rather than fixing 4 (or more) bus drivers.
-- 
With best wishes
Dmitry

