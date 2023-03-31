Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290C76D1E39
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjCaKkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjCaKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:39:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DC76AD;
        Fri, 31 Mar 2023 03:39:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s13so12596764wmr.4;
        Fri, 31 Mar 2023 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEh4cv/IiBUlEQPrhXi9p2fWPNI8o04lqTskgPtx5jk=;
        b=jwCxjNIRLM9CnNYShCAyldXTLn2ECc9ppPxCG4S7HYNNn/j2MK8ddWzxH8bGWyWQBY
         OI011512naw8QkAhE3Y972Iy9VkTCCZr1AFnFPeXyovjw7Kcu1VgnTnnZIxzFSVApi2/
         xzcj8VUpNoqckh8FMl0TfyYw6vEvsVZHf4oaYonbUtiv7NUPB4ZrrKNm32lef5JSfjch
         i7RiLnFkMJXkiuutR2Jse701srqeSikvqPhQqsvn9DxWm8wZaNvN4dKuVoCQoisIyYnO
         0h/oWJyQ1p1vphCnIh6Xo1m1Zkn73g8SVrvNCJaUzVBhhGr2BUWXebd4yBAu6v7fsm0p
         DlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEh4cv/IiBUlEQPrhXi9p2fWPNI8o04lqTskgPtx5jk=;
        b=BrqC3wj/m9RSnTZh/rH4yogGZ3ZfFolOlvYGdLRo2EuHJVlHeJ/9j7TFcWWilwDN+D
         taWTJZuTJZyt6xRnyhW+hFgZcdmj5Th7PIM2tBGHfFx/vaXA8jtwZ99tQNX/2sStWmnX
         DKvm+dBOfW0jO49rC3FZLeKRLGvc9sPJsxpc0JrlLMOLUnKVQO073U7654KwkSAUHPJP
         9LE994+Hc1xsO0GkfSHxrdcaUAP9EShZaBGoudxGyZII6pwrsTDmEi55PE/QoMuCZESa
         ZXFQK93TyNfYtkbKyJgfB2LUnq/4w+zGdoVQ7l7G83FycXCpuUiFnW1xTM7UC7JbjMsu
         sPNA==
X-Gm-Message-State: AO0yUKUWs3AvTDfvTUnC6xGN7VFHxc15BoNAtbNz4hYHt6bWJ6nV8kXB
        NyUkROoo8m9uxlq+CvaxWw0=
X-Google-Smtp-Source: AK7set/59lb83lDWDpH/BSoC/UaKyAJ0vQRM4WgzAcqFG3sNFSoipOAJ/dkn1TWiCBllOCKcuNAl3Q==
X-Received: by 2002:a05:600c:21d8:b0:3ed:2b49:eefc with SMTP id x24-20020a05600c21d800b003ed2b49eefcmr21150194wmj.3.1680259152917;
        Fri, 31 Mar 2023 03:39:12 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003ef71d541cbsm2282636wmj.1.2023.03.31.03.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:39:11 -0700 (PDT)
Message-ID: <3780c57f-f496-6cf7-75b7-b582c53172a3@gmail.com>
Date:   Fri, 31 Mar 2023 12:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 3/4] arm64: dts: mediatek: mt8195: Add display pwm
 nodes
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
 <20230223145426.193590-4-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Ff13sH9JTcBBi5j2mUX3BKOvpM=MxV-Fwwu370FdYjyA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5Ff13sH9JTcBBi5j2mUX3BKOvpM=MxV-Fwwu370FdYjyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 10:01, Chen-Yu Tsai wrote:
> On Thu, Feb 23, 2023 at 10:56 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Add the two hardware PWMs for display backlighting but keep them
>> disabled by default, as usage is board-specific.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> and
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> for disp_pwm0

Applied, thanks!
