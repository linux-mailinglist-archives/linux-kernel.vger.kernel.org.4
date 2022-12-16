Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82364EB94
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiLPMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLPMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:47:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD813E0BE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:47:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so2342829wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZfHYT0dprqImc1Uk5LH4ld/kDbj0LXQMAuGNeIQ9Gg=;
        b=aYzV7VoSX6CuKs/G7KICpjbENvVAl9kfCsG7lfepzO6zY75eNnm6plOKLQqcTEFmfD
         OgjdM/uj2KgJZLa9Edu2anjN3+CVPe4Rt1VRQLqyK0gAMIgjN02W4CY4ku2k+ajeQHTc
         X5xOA0f/x498AwFOEpQ5A8YtXKf1kT3Jcl3xW5hW9CEDFVlDAxV+TDkwlqU2ced+6E2F
         hwn7Zt9safszm3aRB9/JSRbJAcvCy/ZevUZcMFNDhxZMhOPiZmORsk385I7YARk2NAwB
         ZIY1Ti3cK6+DQEyY8bxt14Rghqmfvp4czFsIxk9tI+uPn5ABOBvlxR8S84jBZujZvBLp
         xh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZfHYT0dprqImc1Uk5LH4ld/kDbj0LXQMAuGNeIQ9Gg=;
        b=EgztyeBwO8eiD4QrbDnigys7RG6SHONM76snnd0XYbSWAf9ntlSE93nn6maBK9/f5d
         UHwt7NjxldkNhwzi3RtqXPUGYbaz4QuxRhHuWmXuiPBY83PCR5drpC+dUCuwrmxt7F9G
         a2ZW9BDCCvv7Sc9WH6EzUOOhRIl6dtkpw3QKAPW0+rgXxyW2csXHWM0/Jhow0trkCsbb
         +F9lJSsbslHD1bBqtTIJ8a4C+ahjhLWMna0yl04aU7LTI8dduiHUS9pSK4CATLscADGH
         5PCQfcNZBjBho2WV0mPF5rxrQ4rn9A8hp8GXbklTheltfCKMVO3Yc2uJ52dI28uajIF0
         t0IA==
X-Gm-Message-State: ANoB5plbysz+KeeJORa9weQiiDaj0H7+ifunmtZ6QKY//qPF/4VS6yDy
        iLAy3p6Vty+qJEoTR1keuZ8=
X-Google-Smtp-Source: AA0mqf7ER8zAilcdCKnATmIWE4aKgTRGPT7fIFrqqaIyJhI1ToDaAFN9VsJN2oqyqmgBez6oUFBe2g==
X-Received: by 2002:a5d:5043:0:b0:242:87d0:bf30 with SMTP id h3-20020a5d5043000000b0024287d0bf30mr19657888wrt.4.1671194872027;
        Fri, 16 Dec 2022 04:47:52 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0024228b0b932sm2550487wrx.27.2022.12.16.04.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:47:50 -0800 (PST)
Message-ID: <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
Date:   Fri, 16 Dec 2022 13:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
 <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com>
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



On 30/11/2022 12:00, AngeloGioacchino Del Regno wrote:
> Il 27/11/22 21:22, Ricardo Ribalda ha scritto:
>> If the system does not come from reset (like when is booted via
>> kexec()), the peripheral might triger an IRQ before the data structures
>> are initialised.
>>
>> Fixes:
>>
>> [    0.227710] Unable to handle kernel NULL pointer dereference at virtual 
>> address 0000000000000f08
>> [    0.227913] Call trace:
>> [    0.227918]  svs_isr+0x8c/0x538
>>
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 

Applied thanks!
