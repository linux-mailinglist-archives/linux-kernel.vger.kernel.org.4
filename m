Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF31E6F3F75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjEBIpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjEBIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:45:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D924EDC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:44:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so4595546a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683017096; x=1685609096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brUDPgOvzwj8MygKH5XVldqWhb9T2TXDISFxJEfAkvQ=;
        b=jRph/bcjoY17ZpsA49xJ/ytd6O7vBZe2QNqNBSpFhbYWL4jinY8HGILkKxDo9ZOqeX
         zNcxRilPb0F2spiToCrTHb4sSP+ZV0kQ5uJOxGlYieK0raWoP6KSDzgV+BZ7QoPouxdF
         rYn/CETJF5xOl73Tju4KUEQtFpHd9bLn/UR26fTW7Nu0pcNdEeuauWZCW/uzt5iZgjRF
         oxWsuvINeYvAg8jiq7c1uOuYEJFhVCgexrUCSb01PErMnPuPorhP5H7Zrm/E78x3ZiU7
         ZEUjZnfSb4LQUalvBnhiig7L5pco4TjHlwdfvEB2GhXuiHskodW7pJmNeYjBf8Nj6YPf
         pulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017096; x=1685609096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brUDPgOvzwj8MygKH5XVldqWhb9T2TXDISFxJEfAkvQ=;
        b=l8A72CIpmXrlirl3PXMIW7pheQaGyQ9x5X4m2WuZtF+/plO9SOYGgV7AjdqWrrWRvB
         o0SoHxGrtwt5p0d5/uiU1Ohr+8aSMMrCScCCABi5tbPcP7WMvgbWsK1lwSzb7iau+R78
         LCQIONSYvYyxvkGK1i8NC3rPucxzLyzbQRAHK5mfsQw2eJfKpCVt44LwIYz+l/NeVzCx
         aFTO7pcKic+fkEtw+kWbnPoKS8yCT449KlpKhkpPvI7YSFvVWDl0pgbp0x/nHa4J0Z4p
         3ObKsiR9Em9iFT9gPk9Wk9eZaz6ZW/rBz4MuCjxK36R0Jnb0TA4oDxqVOCnc/300o5o5
         kR0g==
X-Gm-Message-State: AC+VfDwuDQ6lUlFLJ7hcGvejHwE0ozle2dbwASCtgzfIh2eiAB8xgoyl
        LVzqoo3isrHodyTCPRk/UHENqYa+zHkhv1QfK/4=
X-Google-Smtp-Source: ACHHUZ542NfmR9+d3Go/cLXLumhkt/Q/oJ9K34oLs40NkS5jvHsJP3xBBxIHYYYHLNH34t0rWU6f2A==
X-Received: by 2002:aa7:c1c3:0:b0:506:82b7:10c3 with SMTP id d3-20020aa7c1c3000000b0050682b710c3mr7217924edp.41.1683017096407;
        Tue, 02 May 2023 01:44:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402160c00b0050bd427a539sm353071edv.60.2023.05.02.01.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 01:44:55 -0700 (PDT)
Message-ID: <49d2b103-de1e-637a-1bf0-aaba1c6afaf4@linaro.org>
Date:   Tue, 2 May 2023 10:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: snps,dwc3: Add the compatible
 name 'snps,dwc3-rtk-soc'
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
 <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
 <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 10:05, Stanley Chang[昌育德] wrote:
> Hi Krzysztof,
> 
>> On 02/05/2023 07:04, Stanley Chang wrote:
>>> Add a new compatible name 'snps,dwc3-rtk-soc' of DT for realtek dwc3
>>> core to adjust the global register start address
>>>
>>> The RTK DHC SoCs were designed, the global register address offset at
>>
>> What are: "RTK" and "DHC"? These are manufactured by Synopsys as you
>> suggest in the patch?
> 
> RTK is Realtek.
> DHC is the department name in Realtek and the abbreviation of the Digital Home Center.
> The USB controller of RTK DHC SoCs used the DWC3 IP of Synopsys.

Then entire compatible is not correct. Vendor is Realtek not Synopsys.
DHC is not even device name. Use real device names.

> 
>>> 0x8100. The default address offset is constant at
>>> DWC3_GLOBALS_REGS_START (0xc100). Therefore, add the compatible
>> name
>>> of device-tree to specify the SoC custom's global register start address.
>>>
>>> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
>>
>> Based on your email, rtk could mean Realtek, so the compatible is clearly
>> wrong.
> 
> The compatible name "snps,dwc3-rtk-soc" wants to represent the dwc3 driver, which requires a different offset for Realtek SoCs

No. The compatible represents hardware, not driver. Use compatible
matching real hardware.

Best regards,
Krzysztof

