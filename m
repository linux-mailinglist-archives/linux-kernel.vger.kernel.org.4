Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FDC725B1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjFGJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjFGJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:56:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8B6101
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:56:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5169f920a9dso567896a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686131778; x=1688723778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKkGexFGpQmVCwwg8im28eJbpseNCLW3GXq5+ips1TY=;
        b=KzwF1w2CYLTceYhK9vABATZI8CPzx4B2xas4KT85KDV9PxFTLHPmUOIWDaJNf2/LoL
         KoL0fdBRoq4F09hgA4ss1qnuDcsWCOn+EjHeEfJc8WuicnPWhc8vER3xNllllckX8Pw4
         ESTiKXN+kXvnDoA8jUV1LZ6HB8fAMywQgjGOdOin2jQcumb9DaqM8Z7bg/OC2qJwQUhQ
         G+bJ5Hpc0O3XPB3JXeQrN3l3czYMOwuWFSspjU64VI8MlyDKwk4Wy66Jeu237mbGFBkD
         rt0bDjp+41tKwC9qd2mZewQqVnhAWmnr2H3DSHmXjElU1jIkKwDhUdxlDYM7j4Bex/nh
         cyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131778; x=1688723778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKkGexFGpQmVCwwg8im28eJbpseNCLW3GXq5+ips1TY=;
        b=diHKszlO1iPVqhGJJjnxE60YIzvAdJN2P4FAngzL13hkMDf9gBHtPAXkyz/KGA1MXx
         nRQ3Z0slKXtwvoNv9cw/yOts2jvu4rN2Slu/XDLZya2OWKM88oNxRu/Pd2ViQZ1TtD2l
         C0/6QCSHjBljdMu+ZIWpAFc3I8JmUi/kDUeXBpSHQMjyHWHof+3kjxfZuOT7YEraApl2
         Xhb3Y7CR+CTSg8JBQO8nHToUjPa3mXxEzSj4CvBAsHEZ7gAmatQyhqohEjJGPCeyV65S
         xDLCRaCsflAlp1mCQw2Ns/kJWTQqL7i3CjOKuXXqS7QbtTStgj1f7v/MmiGbQfJ81F0k
         wYjQ==
X-Gm-Message-State: AC+VfDyQbJf+rQy2xk5B552FRIolaSBjLon60nvkAhvQX++DjNKMcVhw
        PXmPvlIH1tn7OEB/HgB1X7y542sCTxzhevx2uOM=
X-Google-Smtp-Source: ACHHUZ7XSrMQFYkhZEeeJtvnlLxFq2QdTjFeouEQqKbyi/ai3Lj+X3ZkmdTcG2SSjXnIaNwL3H6cTg==
X-Received: by 2002:a05:6402:5204:b0:4fc:97d9:18ec with SMTP id s4-20020a056402520400b004fc97d918ecmr14186697edd.21.1686131778385;
        Wed, 07 Jun 2023 02:56:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7c409000000b0050dfd7de30dsm5979095edq.94.2023.06.07.02.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:56:17 -0700 (PDT)
Message-ID: <4b26898c-0751-14c4-1fdf-2c4e59d4f224@linaro.org>
Date:   Wed, 7 Jun 2023 11:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: add fannal,c3004
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230606140757.818705-1-pavacic.p@gmail.com>
 <20230606140757.818705-3-pavacic.p@gmail.com>
 <cac57af0-aa0f-0a60-3376-234e1da7f4eb@linaro.org>
 <CAO9szn3+u_yuWb5y_aQGWA8RhW2=qPVcxcZvGWz8MbHH_DamNg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAO9szn3+u_yuWb5y_aQGWA8RhW2=qPVcxcZvGWz8MbHH_DamNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 11:29, Paulo Pavacic wrote:
> Hello Krzysztof,
> 
> uto, 6. lip 2023. u 16:43 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> napisao je:
>>
>> On 06/06/2023 16:07, Paulo Pavacic wrote:
>>> Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
>>> Fannal C3004 is a 480x800 MIPI DSI Panel which requires
>>> DCS initialization sequences with certain delays between certain
>>> commands.
>>>
>>> Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
>>> ---
>>> v4 changelog:
>>>   - add spaces between properties
>>
>> ???
> 
> Added empty lines between properties in yml file
> 
>>
>> I pointed out last incorrect versioning. This is v3, not v4. Or is it v4?
> 
> It is v4 of the patch but v3 of the patchset. I wasn't sure whether
> somebody would complain if I were to name [patch 2/3] in a patch set
> with different version. I will try to edit changelog to match patchset
> version.

Please maintain consistent versioning. There is only one version -
that's the version you are sending.

> 
>>
>> What about my tag?
>>
> 
> I have changed in MAINTAINERS file from "+C:
> matrix:r/mipi-dsi-bringup:matrix.org" to " +C:
> matrix:r/linux-drm:matrix.org". So I wasn't sure whether to add it.
> I will add it in future version of the patch.

Keep the tags you received.

> 
>> What about my comment?
>>
> 
> I thought you wanted me to have more generalized MAINTAINERS community
> URI that's why I have changed it to linux-drm. I will remove community
> URI in future version of the patch.

The chat should be in subsystem entry, not in individual drivers. People
will not hop between 100 IRC rooms to figure out discussion. Just like
we have only one mailing list dedicated to given topic.

Best regards,
Krzysztof

