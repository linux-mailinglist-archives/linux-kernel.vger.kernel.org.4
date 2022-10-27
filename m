Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F131F60FADE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiJ0Oyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiJ0OyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:54:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB718B4A2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:54:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g16so1288265qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Esp3bgczyp/bd42qH2O1nm3VZIXuQMi2cu0xsZVGq+s=;
        b=N/CCjZm3MpGvyBcgyzc5rLM02GMUIWyAFnlKPuGtsSSnW2FE8nLpElsmTEY8gt9NRG
         oKzGanNkFtGI1G9DxTjfx0/1K33r1hbq0UII3+P3OYcVAfMDj5T3iu+yqtamFLdYekGC
         IDpcyemQU0BPKpALZMjrUFTV5YKVa6ky2sykjBxRogU0pMoDDmFla4OhTR/9uHXRWx9e
         eyMKMaQF7Js/HaQLBvi5sud2DwOQLhDlE5yeTYOuX05akiEgBVac1CfwkYV53t+/X3b/
         iKSzu1ST4J0jj1t+9sAFjJOYgRec8QqHLiAYu0T7ewgeM6vEJlIQ7Jk7bqteBd7xkzxU
         o14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Esp3bgczyp/bd42qH2O1nm3VZIXuQMi2cu0xsZVGq+s=;
        b=jEXM22sOoigcdJGPjlwmKjrKE9XRMamTr4KFcHDgww2HhXwrqeKvw6Fg66wj+bRtbj
         7ObdPfaLrvQ3qNk5cSCWn2ZpASm1Jd6TOW00+xVy+ndzM/SKwj7UVMWJ7xHFpKzxgl9H
         7VqA2/etgdhdkWRMBn/qdb7dR7HkGjibzgERQv6tT8I85yIXRnEzkdmOto8gvZ3CuuIT
         pEikkczU3FArturM3WGIP4gZIuCViCHgRtoisG7WEf+/Gc0To8rdGCAAGNtYZtX4yOja
         InXU359XtgVOsYB/rLwgeOA55+eDFZM91pgB7rfgACvlkI1AXEFkPQYtDIy+GP0H/Tss
         7Qpg==
X-Gm-Message-State: ACrzQf0awrYqMDOSYDnQGalEJ7/iBhVDCsrJR3rSmKf0zxTZ5QCh+XWe
        sj8cbeg8D8HCTiV237eofS9Zyw==
X-Google-Smtp-Source: AMsMyM4FAvMRQOjYBuzP0DxssE5MRDphL4DEBLzHhTJRFGW9EiSIvlE4OfLPQd15r5f3FSv7HrFpJg==
X-Received: by 2002:a05:622a:1ba5:b0:3a4:ffd9:22d8 with SMTP id bp37-20020a05622a1ba500b003a4ffd922d8mr1390995qtb.356.1666882447502;
        Thu, 27 Oct 2022 07:54:07 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a240900b006b8e8c657ccsm1096333qkn.117.2022.10.27.07.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:54:06 -0700 (PDT)
Message-ID: <43e02cd7-94d3-372c-8091-60faf821880d@linaro.org>
Date:   Thu, 27 Oct 2022 10:54:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/4] dt-bindings: arm: rockchip: Add Rockchip RK3128
 Evaluation board
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
        heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
 <16afe467-7b9e-6e99-ca27-7eefce50a066@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <16afe467-7b9e-6e99-ca27-7eefce50a066@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 20:51, Johan Jonker wrote:
> Add Rockchip RK3128 Evaluation board.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

