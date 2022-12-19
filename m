Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5885650CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiLSNjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLSNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:39:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1E6148
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:39:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o15so6409426wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1eJTlOqCtrihk3Gg21V8dQYsdgDl4F1H5eYjhzPujE0=;
        b=Y9z1WBza5r8pWfzE69ImVTNVurRd5EpiAbtCPsQ6/9Aq2O7B6zeihUsmgGyYotEExw
         +rtg0r1cPNdwWhimrV1yNa0ux0uZwxGIG/3YRdtkW06wymC4a90klvh0cOD3Q0i/lS9D
         eQrWs6P21d4u9942As4n0ZHo5gVS5Jpp71xmAEqDTQzcfZpV2Ox44JwdCehgQEqtwGcL
         TT3Jj8Z9dX6tjpl1AsYiA+j4oFsq4as/83L+eXJpculiE9sPj0+yAKmi4OnPtUhNbayE
         YuRmHij0QN+QgawTWlo66S19/FJ29079Y/7nFOqUhPNrwBZhNVKIx1IWQHBLizp8a4ch
         qeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eJTlOqCtrihk3Gg21V8dQYsdgDl4F1H5eYjhzPujE0=;
        b=nqQTBNschRMrZQF5oivx/OztDKtE6Vs0XL2a7k2dd2h2C9whpNkByojPK3UIdIMfYA
         4aO1MS//gidH4KJj8i7UiC00bw1jhwfyJvK96c0RFSxupQ+33IMYyEsOUIPqpQFlfuzs
         QY89HXERC+yiokgpSBWIu6zH9YR+gvIC+vIE4noxa9efgqsASHci4nASKgC6gcBakIlI
         VIliQ+bHZwMbvgOMnLPYriF/B9MEKejMB0KRomziOpraCe6IOUPHwXONlVETWEze+yVa
         iGMcJsaeqeai9U2Hk0ebu6Jwz8rADvSqZmZMU8HfnORp9Zgp3D9XHpKoTSasO9emU2Nb
         O5Sw==
X-Gm-Message-State: ANoB5pk1HcfubkaR63GJrhuiKFuL5kro9cs/BffOszcjoy90Ol3Mf738
        9YQUNSiHItitxR4VDfxM95+dkg==
X-Google-Smtp-Source: AA0mqf4a6fqcvrgJrGfU4fb1b0iuWJiHP1eO5lcDmkcFZt/wjj8YvE5SrpFx8GQb9AfR9AlP5t/MnA==
X-Received: by 2002:a05:600c:4891:b0:3d1:fbf9:3bd4 with SMTP id j17-20020a05600c489100b003d1fbf93bd4mr31975057wmp.10.1671457166878;
        Mon, 19 Dec 2022 05:39:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:976a:eb00:7b11:28de? ([2a01:e0a:982:cbb0:976a:eb00:7b11:28de])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003d01b84e9b2sm12598022wms.27.2022.12.19.05.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 05:39:26 -0800 (PST)
Message-ID: <cf327e3e-13d9-6637-5189-70c65ccbcdb5@linaro.org>
Date:   Mon, 19 Dec 2022 14:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/meson: Reduce the FIFO lines held when AFBC is not
 used
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <ccaione@baylibre.com>
Cc:     David Airlie <airlied@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221216-afbc_s905x-v1-0-033bebf780d9@baylibre.com>
 <CAFBinCAfF-=776E3k=NnhaG+rMCp3b=WbjkN=RKGG8vM3Cn-3Q@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCAfF-=776E3k=NnhaG+rMCp3b=WbjkN=RKGG8vM3Cn-3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 12:00, Martin Blumenstingl wrote:
> Hi Carlo,
> 
> On Mon, Dec 19, 2022 at 9:43 AM Carlo Caione <ccaione@baylibre.com> wrote:
>>
>> Having a bigger number of FIFO lines held after vsync is only useful to
>> SoCs using AFBC to give time to the AFBC decoder to be reset, configured
>> and enabled again.
>>
>> For SoCs not using AFBC this, on the contrary, is causing on some
>> displays issues and a few pixels vertical offset in the displayed image.
> On the 32-bit SoCs (for which VPU support is not upstream yet) it has
> caused screen tearing instead of shifting the image.
> 
>> Conditionally increase the number of lines held after vsync only for
>> SoCs using AFBC, leaving the default value for all the others.
> That was also my approach (for a not-yet-upstream patch).
> Since it's affecting already supported SoCs I suggest adding
> "Fixed-by: 24e0d4058eff ..." (maybe Neil can do so when he agrees and
> is applying the patch).
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Yep I'll add the Fixes tag when applying

Thank Carlo !

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

