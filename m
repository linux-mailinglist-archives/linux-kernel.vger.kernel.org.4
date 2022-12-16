Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7387364EB67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLPM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:27:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC5B87A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:27:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay40so1756731wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZPaMP3NS+aG29yEIXQBJU1PSsBR12KX/WLHE5hgBhg=;
        b=EwFoobbGkq3kdjSSddn4dP2DlSB7v/6ahM91tKSIieGgu+t2VBP+wiUReEbfdbUGJK
         1nzxnBgzE9dJDL8sJpgAwbbITAg4hMet8YEVncMfCCQptz4Uba1E7CgXT/MtOeiecOn/
         u6R0pgxgQUp9TMpJuPy/nWddVXSqx7ybynW5OIiUOnTON1l0hdR2W40LxB+pVZUB+8q3
         cEffdmakFndWYmWpy4pm1rSjuGUUSKtEPI36OaBC4qhe+timSCbiqEcL0TZxSDaTlRXb
         E7mH2irkhjMd+vhj/wQ/Wtw2r3a/OHgo6pbgYtAIfhaCO/J76X+xhbQKw2jwQstGC72o
         4wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZPaMP3NS+aG29yEIXQBJU1PSsBR12KX/WLHE5hgBhg=;
        b=8LAODWoLv44r3ZVbR0rhMmGHjMYRohSdeiPvi6ROVKuzYh96I2nVQKtzDfzv8CQtwp
         8bU7ais800pPdYTrVxM1qO4aTrm4fgqsUz1gGKQx4yJt+YmhdLi5yhRzrJ4C3dYG79Er
         tmK6VcjGoi98fEhhpmYqsPe2SVq9jRyQWCcygQoq8ircGcXN+NQl+XTklfGOOv2CumSJ
         55g8gJzkWUU06gRiWwCAiaMegZSHfiDb/9GhTmmUabF8VVQJgoOQgAN4sq73XhD7378t
         V76CWC2Z8q3tRiHLotm3xgvX+OCpRN5h+apRqFfWskRTpk0z9KfnS4mLLMjdmYJsJdz5
         gdQQ==
X-Gm-Message-State: ANoB5pn4MrFNooZ/G0s/NBMbZGxfMU3gxwMIinrPFUZXVZj49+LZ5EqN
        PMPYXOGLEBRB6h8WnbuHWow=
X-Google-Smtp-Source: AA0mqf7bKZceTCnbTeFmQTOex7vWRPHqCRpJCrTYtkC7Fo4tgMc3BDdfxaa/jW+75d5ACMzJnmPTDg==
X-Received: by 2002:a05:600c:35cd:b0:3cf:973e:c874 with SMTP id r13-20020a05600c35cd00b003cf973ec874mr24892024wmq.14.1671193626213;
        Fri, 16 Dec 2022 04:27:06 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i26-20020a1c541a000000b003c6c182bef9sm11464603wmb.36.2022.12.16.04.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:27:05 -0800 (PST)
Message-ID: <23f30de6-8122-2ab1-e519-1ade6650d8c0@gmail.com>
Date:   Fri, 16 Dec 2022 13:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] soc: mediatek: mutex: Drop empty platform remove
 function
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
 <20221212222549.3779846-3-u.kleine-koenig@pengutronix.de>
 <0670a966-2449-977d-a791-4b1c4478524b@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <0670a966-2449-977d-a791-4b1c4478524b@collabora.com>
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



On 13/12/2022 10:50, AngeloGioacchino Del Regno wrote:
> Il 12/12/22 23:25, Uwe Kleine-König ha scritto:
>> A remove callback just returning 0 is equivalent to no remove callback
>> at all. So drop the useless function.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Totally agree.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Applied thanks
