Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB7672A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjARVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjARVRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:17:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92361EFE2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:17:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2310380wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9ViG6CPyovYHKt5fQnD0wSUd0WMg5dZKuBrX2Aheog=;
        b=SB2Oj2yLEiIFHIsW1CdtXEEQQVCaXqQj21SbNc3j+JRYCB8nVqBC5LHbBPn4GJ1sdL
         6zPYnE/b7S48+St6cpX2Y9FKCZPZ3PejrqIBkscQzpcAM5OegXmtZITB6hbORKhOLmZ8
         TkpHCOBMYHFNy+fjZvWxtwq+zpZYZAH6nyyDubTh2UE/dLK8r5gESBsmLo8TWFH3IWRq
         iePaIipwiq8qZTriVBjgCW+XFJEZX/CtxmwkhCTzDfreWISoa5nc1AM/fWvd75Wrm0/P
         KlpXVv66q9paOT+XzSes4nqpqVwsjNeKGiTcXSqrALOOLp1iU+MauWPyL8S5+AEReMG/
         7xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9ViG6CPyovYHKt5fQnD0wSUd0WMg5dZKuBrX2Aheog=;
        b=2N+7EytNUy9JSUgxc12XYcecqNMCHg50nlqQWstOsb699mNABONd8+00HZWkacSvOT
         QZb6BNdJ1rUtUHGLuyRiuZq52KJ7LUyaTIAeIcAVXYCnjXmLmcrJthWrbHH7nD4Y4vRB
         tBmud31IAXnmX8pmxtzQIQhetat8FM9XN4sneVTNdyndEmc3Vt749fcUuVvNCT4EnkF+
         KTp5KKTAq6VkpO31sLSSD8gxiJJhqA7D1nmKV9xFEzL3/A0TAoIMWrl+96Y5VXkeoABv
         bLIP1JPQBlNlrdRfYvvFaggG0sbSzBDraDkwVO+QiZj211srKyiRYUz8I4Ae97Rp69qD
         TnBA==
X-Gm-Message-State: AFqh2koTOQNPSoKeHM6cyGts3GTP9Nr4dO0sWAC7Us//gRhIx/Ee7wfa
        OLhJ0qWpfsXUq5Mq1GFb5ImlKw==
X-Google-Smtp-Source: AMrXdXsSef+uSFlPHOFrYrAvmSL77m3QfvUAwtfFoC6Z0m66YqvUb8SYoRyQqcvNYWKPL18cD1f27A==
X-Received: by 2002:a1c:7712:0:b0:3da:1e35:dfec with SMTP id t18-20020a1c7712000000b003da1e35dfecmr8033493wmi.4.1674076639344;
        Wed, 18 Jan 2023 13:17:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i18-20020a05600c355200b003d9df9e59c4sm3583632wmq.37.2023.01.18.13.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:17:18 -0800 (PST)
Message-ID: <41508a2c-85dd-a39b-300e-8b904360b66c@linaro.org>
Date:   Wed, 18 Jan 2023 22:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal=3a_brcmstb=5fthermal=3a_Use?=
 =?UTF-8?B?wqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202301181631362083446@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181631362083446@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 09:31, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

