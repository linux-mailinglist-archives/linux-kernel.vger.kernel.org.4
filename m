Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545495EF055
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiI2IZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiI2IY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:24:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3DB7F1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:24:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l8so434459wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=OopjgA8vzC9GdcA7Dtfq242o4VGLvu/Ywzf24vdE4bY=;
        b=ag4uzhw8aKsIxErrBbHxW883xPqjI1HkYp0/h+XP0QCb/P6KMxySAIsxm6ZPoDKiTw
         RqsQcDsV/yBE+ouvak9JioxH1MLwXpAffH1gvpyp3a+xozlBd4BGymjae0jlj/ZIbCa0
         mnWvP1W14dZkpmxtZJIc+hrD/PTtSQt4GXhnZT68B4R81EV0NxMBQCfUSCdZ51p+5YHA
         Rcof0k+cKBf4SA4w6cV+a6QIOlE55Gsd/nFwvwP9trOU6N4NEOdRb5lzFuI70Ajp2rZP
         0s74QaiyznpQdUKxNZujP+8WZ0nJZ4WAQSAEKLWOtyGUK6ahSR7n0NLRbBFuFywQvX1n
         DWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=OopjgA8vzC9GdcA7Dtfq242o4VGLvu/Ywzf24vdE4bY=;
        b=rjTuRM+owcf9SDWz7xWg7dQD9cgwL6V6+V450mOo8aROgL58AA0VjczTkZpLbGdE6m
         PVW04wazfOXa3mvfrpEAQlUxlwpGzcFycqrn1j8Yt/d0ACCC/pqRtCd8cVvaXnCiv7No
         Kq4zRIY44uHjRCOJYqaanoK2ngJxqWJCgQA64DUhliiV4+3ZOGSkI00It4lLH3Z7MUOk
         EGt8v0MOFJzbqM/FGuraWTrZbMSbx9GS9KtRB5Wzj1bIow8Sf1L89dIo3swgP+xO5Qjm
         5njBEcSBUhOJ+QY3nmZFQxhQOCln5MsJw+ptO4RUxJZ8r8a3woOxGqLnSQ6kYr24MUCp
         jTGw==
X-Gm-Message-State: ACrzQf0C9KSDxZjUNdZhnmr4XX5TcOKnr/kF8QC+VIux/hl9Qi8ngVcI
        HOneyWDHL0EZhCiYDWnIKLoVEA==
X-Google-Smtp-Source: AMsMyM4vYNiot0JEE43ZwvudM28MvEU9xeCa+cf1fPzHDOB1ELtp99d0UcKvNTBPNPFGDTw/KRZTuw==
X-Received: by 2002:a05:600c:2e42:b0:3b5:1134:8ec8 with SMTP id q2-20020a05600c2e4200b003b511348ec8mr1278349wmf.58.1664439892927;
        Thu, 29 Sep 2022 01:24:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b00228692033dcsm5965119wrv.91.2022.09.29.01.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:24:52 -0700 (PDT)
Message-ID: <d27c5ddd-4178-f058-7073-f276eebb0ba4@linaro.org>
Date:   Thu, 29 Sep 2022 10:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/7] arm: dts: qcom: mdm9615*: add
 SPDX-License-Identifier
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-2-b6e63a7df1e8@linaro.org>
 <2529003b-b253-9764-1060-02aafdcd44e3@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <2529003b-b253-9764-1060-02aafdcd44e3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 19:55, Krzysztof Kozlowski wrote:
> On 28/09/2022 11:14, Neil Armstrong wrote:
>> Replace the licence blob by a clean SPDX-License-Identifier
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
> 
> 
> Rebase on linux-next - you use old Bjorn's email address.


Yep sorry, my first submission from Linaro... I added Bjorn's new email (+mine) in my local mailmap so it won't happen anymore.

> 
>> diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
>> index 0827de5426c1..073c15354483 100644
>> --- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
>> +++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
>> @@ -1,46 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR X11
>>   /*
>>    * Device Tree Source for mangOH Green Board with WP8548 Module
>>    *
>>    * Copyright (C) 2016 BayLibre, SAS.
>>    * Author : Neil Armstrong <narmstrong@baylibre.com>
>> - *
>> - * This file is dual-licensed: you can use it either under the terms
>> - * of the GPL or the X11 license, at your option. Note that this dual
>> - * licensing only applies to this file, and not this project as a
>> - * whole.
>> - *
>> - *  a) This file is free software; you can redistribute it and/or
>> - *     modify it under the terms of the GNU General Public License as
>> - *     published by the Free Software Foundation; either version 2 of the
>> - *     License, or (at your option) any later version.
>> - *
>> - *     This file is distributed in the hope that it will be useful,
>> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - *     GNU General Public License for more details.
>> - *
>> - * Or, alternatively,
>> - *
>> - *  b) Permission is hereby granted, free of charge, to any person
>> - *     obtaining a copy of this software and associated documentation
>> - *     files (the "Software"), to deal in the Software without
>> - *     restriction, including without limitation the rights to use,
>> - *     copy, modify, merge, publish, distribute, sublicense, and/or
>> - *     sell copies of the Software, and to permit persons to whom the
>> - *     Software is furnished to do so, subject to the following
>> - *     conditions:
>> - *
>> - *     The above copyright notice and this permission notice shall be
>> - *     included in all copies or substantial portions of the Software.
>> - *
>> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> - *     OTHER DEALINGS IN THE SOFTWARE.
> 
> The text is actually MIT, not X11. I think they differ by last X11
> trademark statement.

You're right, I checked the amlogic DT SPDX migration that used the same licence blob [1],
and we switched to SPDX-License-Identifier: (GPL-2.0+ OR MIT).

> 
> Best regards,
> Krzysztof
> 

[1] 114abfe1aa5f ("ARM64: dts: amlogic: Convert to new-style SPDX license identifiers")

Thanks,
Neil
