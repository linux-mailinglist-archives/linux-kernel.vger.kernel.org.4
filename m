Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2826B1EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjCIIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCIIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:53:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21276392AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:53:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h11so1088466wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgsd04bd/4ZlXKnGTYrKD1brl2xaIFoF6CeDsO4R2+k=;
        b=UNYfRpl5IDPD7X1lssRtZwOAbexVl2G3nPgbYuy+hCS3Dm8tMrZJwQr6CGS6QEGrTi
         X0gQs5Fgv8FdTxoqxrvJfyIeUjKA8u5KVpznJouanmOZk4mavwCpKT+nolJcXM9NlF2e
         OAMuYRS9Ipp6Jg1gC+Omc7pJa3e7S3g5JVycgaTA0iSzHrTIf6gdCLL1bz1Nn7MhPxkb
         UUt/P0/p3THefFCgmRzYsXuA1A53LQxlCvlNOiFDMsUwvtQHgb6IEkgnp4FQ3BCDx1XS
         10I4C5pNHPsSsKnqvag3nvGhNJZAm5QWU7zEB6vVEeMUVpbj5hmXKHgDOu/MBrGIbMf/
         DN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgsd04bd/4ZlXKnGTYrKD1brl2xaIFoF6CeDsO4R2+k=;
        b=A/6ho/uZlPtfYxwzy9ZKhE1jd9pyBhT8iaug0KU2qs2lylrTfWHRRl9ohG8tLU38G0
         qTifMldNVdqYCu/Ta5L6ya8yAnWelfFz1PBvR7CLicaE+PtJ8Xnb7M/ixQ2EDftwiVBC
         5IPT/XQLaenkwzTx7g9SCLeW93W2IIlcs4wzGDKyOYgz/LMjuQndqYmjFgrKOGXoQIQt
         KjBvOYmCNAyFDMGh6syJJfjauXC3hNSNzemwGHIbFnCk8aIKSX3isWguPfsNwMUEfSoR
         TnlWD8wJggxqGLfam2NSUGGzQ8EFZTcgWjWGK4jpcN8xcrllfnRwbhuxUDwDQi21lxWY
         wKpg==
X-Gm-Message-State: AO0yUKWIz914Z/Vb4urtk0H3AuvA7p4A1S1L/A5oarhENpsuR+350pT5
        I/pNfqpO1CGLvnc2tVSkdGbkrg==
X-Google-Smtp-Source: AK7set8xpNyJ3o3WnUcz7wfa9DU7K46He76yy5JUXSygLLieBRvBj5E0uvIHvSlIDvoMZhrKwTYk4Q==
X-Received: by 2002:adf:df06:0:b0:2c7:6bf:16cc with SMTP id y6-20020adfdf06000000b002c706bf16ccmr13176676wrl.32.1678351969396;
        Thu, 09 Mar 2023 00:52:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:fbda:65f5:e873:7527? ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.googlemail.com with ESMTPSA id s10-20020adfea8a000000b002c7e1a39adcsm17428865wrm.23.2023.03.09.00.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:52:49 -0800 (PST)
Message-ID: <4e8235b8-9c2d-69e2-a965-b0787d016ef2@linaro.org>
Date:   Thu, 9 Mar 2023 09:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] thermal/drivers/imx: Use the thermal framework for
 the trip point
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230308214822.1317086-1-daniel.lezcano@linaro.org>
 <20230308214822.1317086-2-daniel.lezcano@linaro.org>
 <CAOMZO5CoYi2MpVLBqoKh7g9Dhjq77KfNy3QQNi2AawjGTrFZpw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAOMZO5CoYi2MpVLBqoKh7g9Dhjq77KfNy3QQNi2AawjGTrFZpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 02:11, Fabio Estevam wrote:
> Hi Daniel,
> 
> On Wed, Mar 8, 2023 at 6:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
>>          /* do not allow changing critical threshold */
>> -       if (trip == IMX_TRIP_CRITICAL)
>> +       if (trip.type == THERMAL_TRIP_CRITICAL)
>>                  return -EPERM;
>> -
>> +
> 
> Unrelated change?

The 'trip' is used as an index and it is checked against 
IMX_TRIP_CRITICAL which is a index in the array also. We replace that 
with the real type of trip point regardless its id.

But the extra line is a tab which was inserted, I will fix it.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

