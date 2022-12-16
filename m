Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84164EAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiLPLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPLuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:50:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6452CC80;
        Fri, 16 Dec 2022 03:50:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o15so1670157wmr.4;
        Fri, 16 Dec 2022 03:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5f2szHXaGzFXM+QokmgsfkmBLkNqXSfiDGTjKRlczWs=;
        b=qNZ/FYhREmmt5LtYE0eoBDKw5tiLcmpSabQQ8BzMy35Npi5VQMIekUewPLAqdd/iyj
         8Yq7IbCiXb7szX5M/6hlnfGr9rMOGm4DdPuSy1DW3qp9QY216qFd8f944J6cv3ljEt/o
         KgnlPEjTDQIShYwigGHS/TGqgC2pvUQNKx53o/Q2Gz+D1yawFjyCZpKtAsZYvpgzlJjg
         lmFfkStNvmdsUZVGvOcArGBvfdMOl+IH9pMzTFk+kanuc2qPun0SOSosEqCUN572wmvi
         XFZTU4WBsW/OwBdcNAr6z+cKpCVhKoCiQ/LI40OnAtSg7jZKTZIZo5yz8HYjMJXgB8TN
         sUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5f2szHXaGzFXM+QokmgsfkmBLkNqXSfiDGTjKRlczWs=;
        b=jPsibZ+b8GWBFqyb6Le1rECERIubMLjpLiODGVO8/p4bbUpFiWFfC+Pdxw5/kPK4uP
         2DMF2oq2UzcR1VGX6rO43124961rhjCtD6FiMkNy6lxQ/oDL2RvLJYP7pDhu9yT1QOsf
         /yclTNeTTplgahWau4Cn3sw6emk9zzl3srm/Dn7tFplSgg1WQ7CxPJDMFmyOWuLumxz7
         h/G4pInpbwXQgUSjIdAMUMvKBVwN6+5LdcCny+fnHAbwBz4uyST04aYTfVF6wliGNS6M
         UOfmth1xWGM8rbqQMaUqsgYbLP8w/b3fUMt6m+ra3vlKpYb1+BZm6OAW9KLuNyNlZQBP
         X2lA==
X-Gm-Message-State: ANoB5plX21wh2wBOALp3glXHTy+6vvH8+xQiIkSYpYdDEfUTn0ca3qbY
        10CkRyvdb8AaoesfTjPjYwc=
X-Google-Smtp-Source: AA0mqf51vop4o/eMa8yjEyPDs/nsh8zNaWybH6NyGggUTd/tMDmyk1W78wI73sdCdOZ6ajioW9R8BQ==
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id h8-20020a05600c350800b003cfb73fbf8fmr25612865wmq.7.1671191407196;
        Fri, 16 Dec 2022 03:50:07 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf483ee8e0sm11375737wmo.24.2022.12.16.03.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:50:06 -0800 (PST)
Message-ID: <bc718a1e-13e9-db16-efef-06e94395ba39@gmail.com>
Date:   Fri, 16 Dec 2022 12:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 5/7] arm64: dts: mediatek: Remove pins-are-numbered
 property
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
References: <20221129023401.278780-1-bero@baylibre.com>
 <20221129023401.278780-6-bero@baylibre.com> <7ho7si56n3.fsf@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <7ho7si56n3.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/12/2022 14:20, Kevin Hilman wrote:
> Matthias,
> 
> Bernhard Rosenkränzer <bero@baylibre.com> writes:
> 
>> Remove the unnecessary pins-are-numbered property from
>> arm64 Mediatek DeviceTrees
>>
>> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> Now that the driver/binding parts are queued, I'm assuming you'll take this patch
> (and patch 6) via the mediatek tree?
> 

Yes, both applied now. Thanks for the heads up.

> Thanks,
> 
> Kevin
