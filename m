Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6519D5FB411
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJKOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:04:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CB8F263
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:04:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f37so21231930lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miXLZk8v5YqNNtiDLYh+RE8Lp+zqisULlUcCYgeHoAE=;
        b=VCTokd2xjoi7u4WGZYNZlVC3KvGj/Zwa3YIctwlsTfta5SBxhK8l1EBxyOSAHZbYqv
         /0Qr3SMo1BiLWJ5q1EWD/DOmKxe6otD2Q46i3M+BrNWNEm7jOpf0GH4CdPD+Se98xXmJ
         Fdk4PAyxKXgHXouIdi+m6U6o7dIhjSuTNcV6aHEyG/f9Xl22sGl5qMdhDrduIFxfTe9P
         B6g21isG/BFzLjKezb4vh5bD6ZT4zAwb1/L1wUTMU7jU6brqIvcQT6f88X6doY2liHG3
         8c96nICAbtsvRN2JowboqAXiIqylWZaSwBOYora7geeMWtOIvpqAkLfsOTDJAKNr5+B3
         LKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miXLZk8v5YqNNtiDLYh+RE8Lp+zqisULlUcCYgeHoAE=;
        b=oXn7lyzuEFb79RFESaIrENglNv0wXFy9HmKv9SNn+oxDdylZ1jaIVEOrPeyLX236NV
         xbQgwUd3F6SxMzMQH0RP8dnOGR+1iDZnyAqMSs8pwm5Yx1sJ9D/OcaZDNlwWG8hN1M3f
         sxZaR28NlMTbW4jfznQzIkpW/UApwcULTzX0LhN89XsrQcMPOOECtRjR8IEGWOqocwhF
         XkH65BqOo1TX0VAO2+/gG/Zs50tUg27t5LPdeZo2FgObQxOljFKyiRQGci9tW3p+j523
         I1wzf06gyrkL0yMKUYeq+H7kevlXNSysJyPrdxnNDpr1awRXZsrmk2bLIwJXO7SxRV66
         tbjg==
X-Gm-Message-State: ACrzQf0JYgd8KSu23qB29T7EDBsBjrTUrrJSlW39JR2NdMkO+LkEvGMt
        4bhC6PurxU5l4nbBk3HqI7SRow==
X-Google-Smtp-Source: AMsMyM5ltcAwdQHcdi8OnPxvv/cRJbPc0SAmnFJd7Ua6IjdfR1eSgoyRab2DlhLFc9bI4SQhvQwW3w==
X-Received: by 2002:ac2:4c18:0:b0:4a2:6dbd:97d7 with SMTP id t24-20020ac24c18000000b004a26dbd97d7mr8327795lfq.144.1665497045747;
        Tue, 11 Oct 2022 07:04:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c14-20020a19760e000000b004a031805c8bsm1872414lff.106.2022.10.11.07.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:04:05 -0700 (PDT)
Message-ID: <ebe1e26a-7335-29ac-4990-6b8fdb02ba7c@linaro.org>
Date:   Tue, 11 Oct 2022 17:04:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 08/13] phy: qcom-qmp-pcie: drop power-down delay config
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-9-johan+linaro@kernel.org>
 <66261491-530d-c368-6cc8-daeef74fcbda@linaro.org>
 <Y0V1TIBySTPhYqX/@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y0V1TIBySTPhYqX/@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:53, Johan Hovold wrote:
> On Tue, Oct 11, 2022 at 04:46:53PM +0300, Dmitry Baryshkov wrote:
>> On 11/10/2022 16:14, Johan Hovold wrote:
>>> The power-down delay was included in the first version of the QMP driver
>>> as an optional delay after powering on the PHY (using
>>> POWER_DOWN_CONTROL) and just before starting it. Later changes modified
>>> this sequence by powering on before initialising the PHY, but the
>>> optional delay stayed where it was (i.e. before starting the PHY).
>>>
>>> The vendor driver does not use a delay before starting the PHY and this
>>> is likely not needed on any platform unless there is a corresponding
>>> delay in the vendor kernel init sequence tables (i.e. in devicetree).
>>>
>>> Let's keep the delay for now, but drop the redundant delay period
>>> configuration while increasing the unnecessarily low timer slack
>>> somewhat.
>>
>> Actually, the vendor driver does this 995..1005 sleep. But contrary to
>> our driver it does that after programming whole PHY init sequence, which
>> includes SW_RESET / START_CTL, but before programming the pipe clocks.
> 
> Right, it does it after starting the PHY which means that you don't have
> to poll for as long for the PHY status.
> 
> It's a different delay entirely.

No-no-no. The 995-1005 delay was added guess for which SoC? For ipq8074, 
where the config tables contain the ugly CFG_L writes for SW_RESET / 
START_CTRL. So, it is the same delay, but added by somebody who didn't 
care enough. The original 10-11 delay is a completely different story, 
you are correct here.

Thus, I'd say, the PCIe delay should be moved after the registers 
programming.

> 
>> I think we can either drop this delay completely, or move it before
>> read_poll_timeout().
> 
> It definitely shouldn't be used for any new platforms, but I opted for
> the conservative route of keeping it in case some of the older platforms
> actually do need it.
> 
> My bet is that this is all copy-paste cruft that could be removed, but
> I'd rather do that as a separate follow-on change. Perhaps after testing
> some more SoC after removing the delay.
> 
> SC8280XP certainly doesn't need it.

I think in our case this delay just falls into status polling. We'd 
probably need it, if we'd add the noretain handling.

> 
> Johan

-- 
With best wishes
Dmitry

