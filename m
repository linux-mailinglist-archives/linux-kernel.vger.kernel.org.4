Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF36F9BB6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjEGVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:11:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE5100F2;
        Sun,  7 May 2023 14:11:33 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac7707e34fso44529741fa.1;
        Sun, 07 May 2023 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683493891; x=1686085891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQ4wLJjYk0xbWAICQf5Qqk2+0cmn7o5zLqWACRjv/RE=;
        b=XuQRMcRHAXVeRo/tjDPQEDrxwmyqSS8ATManSb8DXaEINhjOuaQ+3a8BrPAXc/ZiKE
         2vFKPoFrwa7vaQ/oBTM6G7CH3BSucIiGohszbMCCwPO8LM6p7vB6P15rwwHP0Y9ezaK3
         m6JORm22/vbsK3+0I+rllafMb3Z6y0q+W7MttMqADkRiMvAUaus91WN13wjocVkbSc87
         QPA4XpUs49uUFhoVRtZcyaKleyLJ7JJVAc9jxlowJifbnR1rymolFqwLRZwcpB69riHN
         HE4MMKrFt03Sc6Sg0tFlKAch22enSc6taV+6HzM5p/IYqNDnmtpID6/2CJz/+GAkyAbL
         mWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683493891; x=1686085891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ4wLJjYk0xbWAICQf5Qqk2+0cmn7o5zLqWACRjv/RE=;
        b=kB7Chd4hprmLEyYKLhd1rqwGXEqIjjqnA9T3PXSI+pJP33VMr/Eyx7GoU8CqCf5HzE
         5nNbOnTQhKM4bcSwvK3IVTO06b6FFKQ/marI99KAQyEqhiaxXNFoHlWWkYe1sXqEElFf
         4d+u6mFP1xwBKLj9OF5CF0L/0DBZH/zPVT7yUclLguCEhHC6bUAWVtyYQDg7ZajbNZRO
         QQXTl17jU9sxpDHXQNexofk80aZwhMpbYZp2FPFGg4E4KAzjFG1T3XTdMZh2OOjeI3BM
         NgvqUsfT48UcaJt//GOMqEvQ6Tv4yRdD8zM0hc7+TfPdb1Sb9KXFwiprHMnobay0rF4l
         nbng==
X-Gm-Message-State: AC+VfDzE9WtaCQ3zp1vNEEANL4XUIjN5M2IP5JxDwp1B3Zq1UbPTNAEX
        eYgGx9m52+xgtamOZZyO4ms=
X-Google-Smtp-Source: ACHHUZ7s0YF8/MfPt0sSPY/bfKSLDUpfncfX3Bo34sClYSBDbaaOiG70+Juh3LYnmMgEhFQIF68p9Q==
X-Received: by 2002:a2e:b051:0:b0:2ac:8bc1:9cb1 with SMTP id d17-20020a2eb051000000b002ac8bc19cb1mr2349188ljl.42.1683493891055;
        Sun, 07 May 2023 14:11:31 -0700 (PDT)
Received: from [192.168.0.108] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.googlemail.com with ESMTPSA id q6-20020a2e9686000000b002a9f966f4b3sm930876lji.26.2023.05.07.14.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 14:11:30 -0700 (PDT)
Message-ID: <1e02c292-f3c6-f67d-0e25-d22a00bcf6ad@gmail.com>
Date:   Mon, 8 May 2023 00:11:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/6] thermal/drivers/qcom/tsens-v0_1: Add support for
 MSM8226
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-4-matti.lehtimaki@gmail.com>
 <33d373fa-91cc-2ab6-b59b-34967dff1109@linaro.org>
Content-Language: en-US
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <33d373fa-91cc-2ab6-b59b-34967dff1109@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.5.2023 23.40, Dmitry Baryshkov wrote:
> On 07/05/2023 23:12, Matti Lehtimäki wrote:
>> The MSM8226 TSENS IP has 6 thermal sensors in a TSENS v0.1 block.
>> The thermal sensors use non-standard slope values.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Note, the driver from 3.10 also provides custom data for non-calibrated mode. We can either ignore that (in the hope that all devices leaving the factory are calibrated), or fix it in the manner close to 8x74.

That is true, 3.10 kernel does support non-calibrated mode. I can add support for that in a new version if that is wanted.
