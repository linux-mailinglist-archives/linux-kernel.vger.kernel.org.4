Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D643B65231A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiLTOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLTOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:50:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A01CFC1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:50:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bx10so12019293wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjZvuZKXxzFJRZq3j75PnAQGUgw8cFsM3I4S8oUerK0=;
        b=WeKBmMXkUslzNxtSl6xTWfys/L0DO0+UMz2LRHCQAQYGrsz2BBNvQt8vKMu96DAo9q
         xvKkCWuB0tULogMjegQmkUADXcLST3yFJga1+5MXRKp5XSkiSH58ERtX6pFouLpnFHxn
         SPXQCgRDarI3pgV8Nl58IS0adEHjPL+0GwFUw6J65qosRLkir1LtI4qUecSPwsRy1wcm
         OtkLGwZglNOSxNpp5XW07h7g4gCYrspHFABL1Q+xlxBxrXAv+y1RtdWvlkIebIYVbhEO
         HE5EkduLREZPmvj2mwAIIqGkcAHYAQsR+OdOuYPJalEig1ZD4/w30qDKAAD+VWGO+T5U
         3xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjZvuZKXxzFJRZq3j75PnAQGUgw8cFsM3I4S8oUerK0=;
        b=6q+k1K7lpBRh6vJysgVA3WskcT2FqH3aXezt+/oJ0hn0E9I9of4oqI5l0as0t55JJr
         rs4Aj+zMHCzRSgVxRghguw1ZVODHhD7k+lbaN/2x/Q/AISlu/14jHEu/lFGn0mlKyhxW
         PehPHuezHeT5mYi818mFeS8MfiTnYKBW1fVXNgFDfB8LWlteeO3ZFqru7y6XMNP+uLgs
         YGO9HTZVwSDiD7uYCGAMcXdKVQvChX9r2dY8lgWEC5mB6QTqhxgB42JqaRTGrTFnSLJH
         nDES9m4Lgux118lC/FCWOpNgy1QYb98hmhiPo59S670JOV68I/dPoeGOqS5FxlZvcgZL
         Df6g==
X-Gm-Message-State: AFqh2koY6KcdbMWPnObUPsbK6QYqZsIpk5bsTWMw+um06SMQtv+eomC1
        6Lbge2zznDqCDP+LyN+6gLM=
X-Google-Smtp-Source: AMrXdXsRXdqhXHnX5GaEcKChWQBEkh2vtqo9tt4aSVQrTqMRw9a6fhOSpxHrDn1nBpfr/5ne00KT+A==
X-Received: by 2002:adf:a554:0:b0:248:ab8a:5144 with SMTP id j20-20020adfa554000000b00248ab8a5144mr1823739wrb.63.1671547829189;
        Tue, 20 Dec 2022 06:50:29 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm13171989wrg.104.2022.12.20.06.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:50:28 -0800 (PST)
Message-ID: <e0d3f5c7-6f6b-ee21-170c-51e5240de114@gmail.com>
Date:   Tue, 20 Dec 2022 15:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
Content-Language: en-US
To:     =?UTF-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
 <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com>
 <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
 <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2022 12:03, Roger Lu (陸瑞傑) wrote:
> Hi Matthias Sir,
> 
> After applying this patch, SVS probes fail as below on my MT8192 platform. If
> thing isn't too late, please do not merge this patch. I'll ask Ricardo how to
> reproduce this issue and give the correct solution. Thanks in advance.
> 

Ok, I just dropped the patch from v6.2-tmp/soc branch.

Regards,
Matthias

> #MT8192 platform SVS probe fail log
> [   10.209430]  SVSB_GPU_LOW: init02 completion timeout
> [   10.214402] mtk-svs 1100b000.svs: svs start fail: -16
> [   10.219479] mtk-svs: probe of 1100b000.svs failed with error -16
> 
> Hi Ricardo,
> 
> Could you share us how you reproduce this issue? I have MT8192 Chromebook and
> can give it a try to reproduce the issue you encountered. Thanks a lot.
> 
> Sincerely,
> Roger Lu.
> 
> On Fri, 2022-12-16 at 13:47 +0100, Matthias Brugger wrote:
>> 
>> On 30/11/2022 12:00, AngeloGioacchino Del Regno wrote:
>> > Il 27/11/22 21:22, Ricardo Ribalda ha scritto:
>> > > If the system does not come from reset (like when is booted via
>> > > kexec()), the peripheral might triger an IRQ before the data structures
>> > > are initialised.
>> > > 
>> > > Fixes:
>> > > 
>> > > [    0.227710] Unable to handle kernel NULL pointer dereference at
>> > > virtual 
>> > > address 0000000000000f08
>> > > [    0.227913] Call trace:
>> > > [    0.227918]  svs_isr+0x8c/0x538
>> > > 
>> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> > 
>> > Reviewed-by: AngeloGioacchino Del Regno <
>> > angelogioacchino.delregno@collabora.com>
>> > 
>> > 
>> 
>> Applied thanks!
>> 
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
