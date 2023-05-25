Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C77110C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjEYQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjEYQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:19:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC2189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:19:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso6091805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685031583; x=1687623583;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nNOadc/C0uHOJOm2Z/hhCLJEKXawL9GUwI52HHEok7I=;
        b=vgK+kROty/psh/wEhOCBSNd39NqRg02kwjcLCvqFVcUE3+iV2aCg5BV4uUh+nGIUMw
         2jIibMCfgxpad6UoKMP76Etmgg0QTOW+8GDzE4xNI2I8eR3KSutGR2t+jfKoI91ZiFOB
         Ugzyzdo8ct7DeiAlFUZ7gFl/AiLFCLuwELvL//jTQ6VoimEE5WfL/uTOSfQ5dlmaXZqs
         iemviwhOimC+pKe+KTcyKWEMaZz09Sw4LcQvdislOJuizqkvzAnyhlj5ZhJzhGIrLDyo
         nryub0wJEjm+oEyhM///OIkXWNzUro4oB0VUkITkDxA+wPeYJewRP42veCmRglUMGHqm
         lqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031583; x=1687623583;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNOadc/C0uHOJOm2Z/hhCLJEKXawL9GUwI52HHEok7I=;
        b=XyLI1Wu+7Rwk0YJeArp7d5O0EXxTMdy8qc0O1IdD5AuSnW5ieHcjmibfIdJsoRZkZW
         0QP4uhoHWxGdWCIAwZuuoroH+92nOIzFuS2/P4Wz07JXdnps4L7MOlS3QWW2HSQKCp6j
         FefbeQ4las/L4vp46pZUTNihiaDSYHxtz79Xx8FcPOeMYM4UxJikdft2Zv6tGW3BifKm
         FGYjzcqgEjQ1VlC2/YN/6pFfxptt+9WGXktwRoeVA70SRuiQvH7VItxko/r/uEbBZXw6
         F5Jf2RkNyyJJXTrmoMExI9o2MvenPALduQCeLDmcMuMux9FNFoBynuDcirtMPpWylSWc
         VBYQ==
X-Gm-Message-State: AC+VfDyqqL4uewVAtc3C1RtXt+BzMDm042qAFYxltM9SN774h8BVclHW
        8heby8gc2HfB+5oBNdn0pCnd0Q==
X-Google-Smtp-Source: ACHHUZ5wOsnpNtsgygenNWj4kMaoQdK3PEiKH06K1ikPFkkb/eqYGFuwkKpFGvmlKXndcHzGCojozg==
X-Received: by 2002:a7b:ce94:0:b0:3f4:2492:a91f with SMTP id q20-20020a7bce94000000b003f42492a91fmr2924353wmj.27.1685031583123;
        Thu, 25 May 2023 09:19:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5cdb:105b:7481:b0e6? ([2a01:e0a:982:cbb0:5cdb:105b:7481:b0e6])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d58d0000000b002ffbf2213d4sm2283269wrf.75.2023.05.25.09.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:19:42 -0700 (PDT)
Message-ID: <bef20993-b831-b692-237e-b1e89ac4f34b@linaro.org>
Date:   Thu, 25 May 2023 18:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable
 clocking
Content-Language: en-US
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        dri-devel@lists.freedesktop.org, Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
References: <20230518230626.404068-1-aford173@gmail.com>
 <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
 <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
 <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
 <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com>
 <8c65c5c3-0415-78c0-4585-df94a532a04e@linaro.org>
 <CAHCN7xJBf+8KyXbqxVSUUXbKqomX+i-13Ed23QFeF0SM8nQpzw@mail.gmail.com>
 <8f50dc2c-4d74-6c0f-87bc-b96bbf1373a9@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <8f50dc2c-4d74-6c0f-87bc-b96bbf1373a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 18:15, neil.armstrong@linaro.org wrote:
> On 25/05/2023 17:57, Adam Ford wrote:
>> On Thu, May 25, 2023 at 10:39 AM Neil Armstrong
>> <neil.armstrong@linaro.org> wrote:
>>>
>>> On 24/05/2023 14:49, Adam Ford wrote:
>>>> On Wed, May 24, 2023 at 7:45 AM Fabio Estevam <festevam@gmail.com> wrote:
>>>>>
>>>>> Hi Adam,
>>>>>
>>>>> On Tue, May 23, 2023 at 8:49 PM Adam Ford <aford173@gmail.com> wrote:
>>>>>
>>>>>> Inki,
>>>>>>
>>>>>> I haven't heard back from you on whether or not you want the bindings
>>>>>> patch to be included with me resending the series as V7 or if you're
>>>>>> OK with a single, stand-alone patch.
>>>>>> Will you let me know?  I have the patch standing by waiting for
>>>>>> instructions.  If you're not the right person to ask, please let me
>>>>>> know who the right person is.
>>>>>
>>>>> Neil has also been collecting samsung-dsim patches. Maybe he can clarify.
>>>>
>>>> If it matters, my preference all along was to do the bindings as a
>>>> separate thing once the driver updates were merged into the tree.
>>>> Since the bindings can be done in different ways, I was hoping to have
>>>> a separate discussion on the right way to do the bindings. If they
>>>> need to be part of the series, I can do that.
>>>
>>> If you don't introduce compatibles, no need to send bindings, it can
>>> be send separately.
>>
>> This series doesn't change any compatibility.
>>
>>>
>>> Can I apply this serie and 20230503163313.2640898-2-frieder@fris.de ? seems all has been reviewed.
>>
>> Looking at the driver, it looks like linux-next has some newer
>> features added into the driver since I started, so this series might
>> need a re-base.  If that's the case, let me know, and I'll do the
>> re-base.
> 
> Ok I'll pull the other bits and let you know if this one needs a rebase.

Indeed, starting at patch 3 it fails to apply, a rebase on drm-misc-next is welcome!

Neil

> 
> Neil
> 
>>
>> adam
>>
>>>
>>> Neil
>>>
>>>>
>>>> adam
>>>
> 

