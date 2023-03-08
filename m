Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8C6B04E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCHKqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCHKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:46:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F7A42E4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:46:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec29so33060501edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdWkIz4I/mxvd/Alb9OvKLBH8sveQNRk7IcI1jXiuY8=;
        b=AXZ8uCMWCcREcyS94FpoZqMnKKe/WpjFlOMRO8KYKhs+YCTQodptdJuUyp8JVnGCl5
         XQitDjfSuOEj9nopmoTe2oVQMWwNwt/bjknTKYlDjXhJAGB2iAfrWRRI037DROIeDhhZ
         grxln2NnNtjXp7yqkIKCwVKjzzbVb5S5/avPGiglZbc1ov/R5LyAqpOLrfMDU+zOaqhh
         aatvRB4nPXJDCqevA5UKOAE6bSOwDaYbPHrBzZP4tgVgqM/YFmhKkiWzKPLv4+3W0p0v
         CWN/kxlAHOXCljZgUm60bZZ3o+NtZ23chsVfAPiTvr5xgDiwjQNN0RByCYRs3WSENLJn
         ReaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdWkIz4I/mxvd/Alb9OvKLBH8sveQNRk7IcI1jXiuY8=;
        b=x1koFH5K2AjgNt1PM0ZDmJ/gXYD6DlTzgpiINiuaCC12ZZ7UvR+d+Plz2jQAuGjlvF
         iqp2byM1I6qNtYIF5tpEiQduDvzt/YwxjKMz1RlgNznpkZu8aOgfSe7qnSBFuP6YEUTn
         qlEKWx1JOGvv+zTSECL/FRYYrmqgllCDcqGpVZSSHZnWPP0hRAJ3pBIHdLSenPePsqY9
         gE1guxolYrR/G6nfnGWM4M5KHuWi2EaRV86s0mqfLz+14C107oH0yk7aLRs3MeuPzSWD
         pOOr/eguuA7R/01D1FLkSIMXdF9w0LKXG4N+mZX4gEFOuJftPiGS1O4EdKiXF+bmzcJr
         Jubw==
X-Gm-Message-State: AO0yUKX+2xMe3MXlkVOCwjHyFodQJiF9G0FxMCeA9/28fCmtOHerpbYA
        EAsp1z1yxmzW+JDzFntxPjFbSg==
X-Google-Smtp-Source: AK7set95jOe3tjacrO60yOKeB/hWtdyT8wql5anCCp+Jg47/qP+Fx45GFy11PcpWricimaeVl4I+zw==
X-Received: by 2002:a05:6402:690:b0:4ad:7301:fe77 with SMTP id f16-20020a056402069000b004ad7301fe77mr15651638edy.9.1678272410334;
        Wed, 08 Mar 2023 02:46:50 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906255700b008d9c518a318sm7432293ejb.142.2023.03.08.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:46:49 -0800 (PST)
Message-ID: <c686f36d-995b-394d-1745-f59e5ebdb1b2@linaro.org>
Date:   Wed, 8 Mar 2023 11:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20230308083759.11692-1-clamor95@gmail.com>
 <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
 <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com>
 <190897d3-39b6-fb7c-dc18-dac580fadea6@linaro.org>
 <CAPVz0n37tyi0ErjGJFGUviX0p4+ZuxHm=4K16FnfDoUztbtXTA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n37tyi0ErjGJFGUviX0p4+ZuxHm=4K16FnfDoUztbtXTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 10:29, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 11:11 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 09:58, Svyatoslav Ryhel wrote:
>>> I would love to, but max77663 uses max77686 rtc
>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/max77620.c#L123
>>> how to handle this?
>>
>> Don't top post.
>>
>> Hm, so it seems max7763 is already documented via max77620. I missed
>> that. Add the new property to max77620, not to max77686 RTC. It does not
>> look like RTC's property, but the PMIC's.
> 
> There is no max77620 yaml, only txt. Add property to txt?

If property was to accept, then unfortunately no, you need to convert first.

Best regards,
Krzysztof

