Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5768798B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBBJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjBBJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:55:48 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485748934B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:55:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so917187wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8EnhWnwszf0qr8z5+wPtUgbjgq6MRr3dIr/Z/EQU9c=;
        b=TvqFHFwagLxB1rxmJuY4K7HYNruvzblKn97uEc0ZoJyWESaSBp53RH7YJRw/mSQR3r
         xJaf1N8A7YBBWJhCJKawNXow4sLXInXZMFcpCqJV4xSOIzE3Te/D3znVNQrzQeUXN5FB
         rpdIp+ZDdgnIv/GSbTBPKq3J5VQWmxU1uIKeNDrYF2DnkhQG8EsIQwLj/t8SnAphgqQx
         lMVthwwQPoi+rpPYdHkHgOrM/2KETd5X4W6zhgaXvbu6/HuEGBic5ZFlPD3wyTdVS6ek
         LdkSrfz68mselAT4dNi+vulRummyGiLeq0jw+sA6Rq7993S1hZtvNp0fOKK58O0Q+wmA
         tUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8EnhWnwszf0qr8z5+wPtUgbjgq6MRr3dIr/Z/EQU9c=;
        b=oS613TEIrJTKQJhxqspwyTvHq0/RxTLwDr4xLXOVxq9Jw4QhicCzS10XHWBouEPujj
         0AF2VNdvSMrFGbXcxxqDEay63b3O6YIwWD5mSIGo1hRuexLugJnLjOq/O4WTtuM/opnC
         kXckkCHwxLG5yzPJQvWcVS1B72TrOo7EyeycdiWA90pieZoHzCDrA1mVe7eiLDBdM2Kk
         aeACpvpIgRMUHDeu/IMfo39ZwUSa2UHF4wGRzPxmV2PRmj6g7SIogqdGg89FWGvopsit
         O6IB/tc8E+R2gAGnkW/GLUP+mQxQ55OGZi9S3YeyEl4+STOBe+JtzDrsoH5pl8VLlhPw
         uqjw==
X-Gm-Message-State: AO0yUKXOOgcS/2gEI4XyCRpcwhCeCVbauQCugqEWCFklE37PhxMXCNAX
        qtDCtkpZA518GKsSdIlR0vErjzEuqME=
X-Google-Smtp-Source: AK7set8sKz/UU4df3SC+11Rw2FrDgvYF6OZErkElcifAIA8x4teukttDBCFRgb6Q9oYMhmoE5bmLag==
X-Received: by 2002:a05:600c:538b:b0:3df:a04a:1a7 with SMTP id hg11-20020a05600c538b00b003dfa04a01a7mr2300590wmb.22.1675331717450;
        Thu, 02 Feb 2023 01:55:17 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c130e00b003df241f52e8sm2877394wmf.42.2023.02.02.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:55:16 -0800 (PST)
Message-ID: <1423871e-7dd1-4582-3bb9-85913868e951@gmail.com>
Date:   Thu, 2 Feb 2023 10:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: Update entry for MediaTek SoC support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org,
        arm@kernel.org, soc@kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230201152256.19514-1-matthias.bgg@kernel.org>
 <4db8fb55-a02b-d98e-65f4-1a095c43104f@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <4db8fb55-a02b-d98e-65f4-1a095c43104f@collabora.com>
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



On 02/02/2023 10:08, AngeloGioacchino Del Regno wrote:
> Il 01/02/23 16:22, matthias.bgg@kernel.org ha scritto:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> The linux-mediatek IRC channel has moved to liber.chat for quite some
>> time. Apart from that, not all patches are also send to LKML, so add
>> this ML explicitly.
>>
>> And last but not least:
>> Angelo does a wunderfull job in reviewing patches for all kind of
>> devices from MediaTek.
>>
>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Is a R-b tag appropriate here to say "yes, go on with setting me as a reviewer"?
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In general yes, but I think it got already merged :D

> 
> P.S.: Thank you :-)
> 

Thank you to you for all the effort!

Regards,
Matthias

> Cheers,
> Angelo
> 
