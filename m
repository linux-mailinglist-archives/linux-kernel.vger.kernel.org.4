Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE667BA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAYTLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjAYTLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:11:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943959E5F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:11:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q8so14514000wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCu7hF0XsK65JOzXs+6ZmCQ+Q5pOhHMgb8RXoQpNbGQ=;
        b=o6shlmjuRvcuo0LrFpm3pYEt33fIoxAPTEqm4InMwR2PJ52eJPAYqo86P/sg2g1M4S
         mIHbdkW/HBMfRQvBs5uxwl8cRqlnT5poX3YYXT+lL0f4r7nfGXAC0S1wuzAx2awWEoTs
         N89dwzQt0w4RyTUTPy91gjprPhHmfL9xmeEhW9cSmZ+kcubyws6h62cj0Dg+8kIr84DT
         Q7+7CdJw4I7lss8kye+k4bcio3jmMevX1lOdpOtQRLBg8PTfyA/ZJdfyN4EOEmsBUbt8
         o2zU1TvFJaQg/xn2IE8Xzo5/+K2MGLFqHu7pwpiZwsnW1qSuaoC3vtATQYQQfsDbU67i
         /u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCu7hF0XsK65JOzXs+6ZmCQ+Q5pOhHMgb8RXoQpNbGQ=;
        b=fTPRSfIUmVh5hybsWcHNBwlMMThOPm/gcV/7K0A3futRts1IG1akQcDx+ASo6tTF7l
         uXrbR2sokE/nzGFPkmiVUbjPv6dxNUNxJj8B+xHOrzm2kw80SAZDSFciNCZubx4f+aKK
         a+LB3y4LOkISW/I0Tl9fE5ZjGkIk+Vk18ELvfUvPDcbVdoHkO+5YjwyR285u7rA0cTmh
         nTmcOcMCpXCgtKKKNLOXgKeQSN3h1onUHyhdBcxDllNYilJ9X+zHeDuQIQUafxhiu1Oa
         2SaTy3ToPFsE1rEYMs0ftX6kXvLhPiiV64egpWVQ4vccmtRJVcm4Jq1M/b0jgUgNaZ94
         Xa9w==
X-Gm-Message-State: AFqh2kq1OKUKrESFyD8/h0LI5m3x6WCkISgK0Fog7GLtMpTrdh2ZaBjw
        LcKZ/HuKiefF07SQuEYf8Jk=
X-Google-Smtp-Source: AMrXdXsp5al+0K46OvxCZvD0/e8/m3DMiHOLLHh8WHcHeGbbf3oHno5usWF0lHKay5C/p5SKpvjgxQ==
X-Received: by 2002:a05:600c:1e1f:b0:3db:2063:425d with SMTP id ay31-20020a05600c1e1f00b003db2063425dmr24863447wmb.2.1674673863760;
        Wed, 25 Jan 2023 11:11:03 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b002bfb0c5527esm4645045wrs.109.2023.01.25.11.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 11:11:03 -0800 (PST)
Message-ID: <36e7ab30-8e59-5fb1-adc8-1a9f0e213b52@gmail.com>
Date:   Wed, 25 Jan 2023 20:11:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] soc: mediatek: mtk-svs: Enable the IRQ later
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Roger Lu <Roger.Lu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221127-mtk-svs-v2-0-145b07663ea8@chromium.org>
 <12f4d25e-fb2e-8f4d-1874-46f7404b05b6@gmail.com>
In-Reply-To: <12f4d25e-fb2e-8f4d-1874-46f7404b05b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2022 09:56, Matthias Brugger wrote:
> 
> 
> On 20/12/2022 22:35, Ricardo Ribalda wrote:
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
> Thanks Ricardo. Roger I'll wait for a Tested-by tag from you to make sure this 
> time everything is fine.
> 

Given the chinese new year holidays I don't expect a Tested-by tag from Roger in 
time. So I just took this one without it.

Thanks!
Matthias
