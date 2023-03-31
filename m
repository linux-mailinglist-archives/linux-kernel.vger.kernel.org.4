Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8166D1E48
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCaKpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjCaKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:45:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E391CBAB;
        Fri, 31 Mar 2023 03:45:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so13566321wmq.3;
        Fri, 31 Mar 2023 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFG50WRg6TSYZLbPU6VURtL4QTslWUkc9E2u7XffhHw=;
        b=ebVOy1D91/lypLEASvIfFCCjQPxepj6yXQhVOmf6weRMM5icXLf3friwMda5FfC8RH
         a1Pdj22qiKZYdLU/xczr4d1nSGeEsD9s5pX5YQvfJBVO19k89KRZa9x5qWzbYVhbp2Zv
         YxFovem6dOLggU8dErsjuyIRnc7335xctRJOuk00wjj+5wTmjUjkbwO0icEBS1iCLSFO
         /85Y2siNCESdwYgdI52Pd9dWDM2oDFlDqQUjLt6dRqLjFTtqyQf9+jB1N1N5cJwHRdoa
         EpSvwnQYxeLR4spZynFSeybTCKkMBUIZgQYDpFVWAgh30ly/GUhzqrabf7p5ni2MMNgT
         LnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFG50WRg6TSYZLbPU6VURtL4QTslWUkc9E2u7XffhHw=;
        b=7Wb5LcVQvMYfCrR680k+XALWlYzwRdeIidumnS+6ZcHxsGT8ClOH0LFSslpk27uFjH
         QRKZJ7TmyYWhbphqUtmPLNjPi+DUKTDwoR3oLpF1tHuQpvtOBF2kGXXjBukZTd2T+0yU
         JD+Vs2GDCxj5F1jcRNTzUmSiLOtzWvuGvvKcsQk3tgxD9qsYtNZEu0zrSCQlZM4Fe3qx
         qI7tuWnrKghcd8b57lGEuAEzwv+6+baibKItNwT/OWzHcYYrwKyO7SD/E+p93BTyNc/n
         FrFTjsYY336khBvU0qIH7d7nAEjFhKilQH30ZXx53HVFF40CtiADI6LL1Tggba4S0hQg
         EQBw==
X-Gm-Message-State: AAQBX9e9tx7X9CnnWa4W+q+HKgsSqjo7oSy+WFCVRKbdlhF7HVnS5/Q9
        5PX5EFMhM6aAOKdn4qeZCjk=
X-Google-Smtp-Source: AKy350ZzIbqgsPxbenHIVxySZF3wlNwF7uniuuHQNYNE9Vjs92UzxssJUrRef7rvNSSrb/rLXndW7w==
X-Received: by 2002:a1c:7c12:0:b0:3f0:3368:5f7f with SMTP id x18-20020a1c7c12000000b003f033685f7fmr4663596wmc.31.1680259547957;
        Fri, 31 Mar 2023 03:45:47 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003ee2a0d49dbsm9391820wmo.25.2023.03.31.03.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:45:46 -0700 (PDT)
Message-ID: <c95c2ab1-e57e-8e77-4db3-04a2a4cfc16f@gmail.com>
Date:   Fri, 31 Mar 2023 12:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 4/4] arm64: dts: mediatek: cherry: Add configuration
 for display backlight
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
 <20230223145426.193590-5-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H7ADKUu1bsGrF5F-EgJBM6WW0N+AFw=m+hH_00QGHDew@mail.gmail.com>
 <CAGXv+5GnbP+hEy_J+vNsQgwr6qK5oQpDCaszqOkWmrcKfupAgw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5GnbP+hEy_J+vNsQgwr6qK5oQpDCaszqOkWmrcKfupAgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2023 08:44, Chen-Yu Tsai wrote:
> On Fri, Feb 24, 2023 at 4:52 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Thu, Feb 23, 2023 at 10:56 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Configure the hardware PWM for the integrated display's backlight:
>>> all Cherry devices enable the backlight with GPIO82 and manage the
>>> PWM via MediaTek disp-pwm on GPIO97.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> with some additional patches to enable the internal display.
> 
> Matthias, could you pick up patches 3 and 4 from this series? They are
> independent of the other two patches. Having them picked up would reduce
> the number of patches that have to get carried for testing and resent.
> 

Applied, thanks!
