Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578C16728E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjARUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjARUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:01:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FE59E40
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:01:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so18148wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dYEwLlHafATWFxoot4gAkpZeqySUmli4e77a+Kz66Q=;
        b=YG2vrGt09g0yHnyyvId1HwQgn8Ll2rfdESrrdfrmWb1rRAXLf92doKETB0eY4JhCdV
         d8ZN3RPTPar5q3ru582m4Cb0kbKdASv0uiQMcABTflWx0A0NajrZo5pOSJQXW4Ke/gYu
         TNT0UTkw9nAtuGiQ7Pcle7xM68tzESmuBMgS6l4HYXRmZqzXi6iXffITyI67mO1lbQf2
         I4iu3rdhJwsLHUFK/mLaElQZPfd2DOoygFff0ey2+2HTidDl/8tXiHgWCNVtKBV4RKsH
         aC+EmW2ddQCDx+YvPw2o81xfKit3Ek3bJWCZ/m5c1q2l3ZR87lV4KOC0L+jI/AuetXCX
         Luew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dYEwLlHafATWFxoot4gAkpZeqySUmli4e77a+Kz66Q=;
        b=heH3sMjGJn2byrHBboAyIKT3PWE4uond8vF7thtBuGZ+O+AG6Q3Mxcs2T/vdioE+bG
         RqHYkKopWnbK8MNtKk/dtXxVncecq4cQcu8mDbQZxlRGRprc21KEN1v55vgXc9lXlWVp
         k82eWVbEvWIAiJED9Yuep7g/9JHbsg7BiEBNFiNtz111lzRxB+8MObXjgSNvdk0e9dyw
         LpSkbzJVRQmxyVIJLxsaf9CNvpjq7FiE9mvW1w5MHcfhUMDMqol7iYnv1dKVXLyDcgbp
         +sRwrel/izsJc8ZKmLgBtlmzDuGf3xqIK60PyL0qqWtHmLpEfsLHbpyrNxuIC6CWQhph
         cdiQ==
X-Gm-Message-State: AFqh2kpf/eood6B04rqfcojZwrwbQJxL3NjnXF8Evbms24J94xUqxJfZ
        AABrpGuuZUT9AjFlw2Ehl8hSJg==
X-Google-Smtp-Source: AMrXdXsKOk9RGH34JouXfHO4lX3tTXExBI8r27KQ19DpAYc2hCkx4gJMYsL82f9A3100rJ6R74M13g==
X-Received: by 2002:a05:600c:714:b0:3d9:ed30:79d with SMTP id i20-20020a05600c071400b003d9ed30079dmr7915447wmn.18.1674072060565;
        Wed, 18 Jan 2023 12:01:00 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b5-20020a05600c150500b003daf98d7e35sm2635658wmg.14.2023.01.18.12.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:01:00 -0800 (PST)
Message-ID: <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
Date:   Wed, 18 Jan 2023 21:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
 <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
 <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
 <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
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

On 18/01/2023 20:16, srinivas pandruvada wrote:

[ ... ]

>>> But we'd better wait for the thermald test result from Srinvias.
>>
>> A quick test show that things still work with thermald and these
>> changes.
> 
> But I have a question. In some devices trip point temperature is not
> static. When hardware changes, we get notification. For example
> INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
> Currently get_trip can get the latest changed value. But if we
> preregister, we need some mechanism to update them.

When the notification INT3403_PERF_TRIP_POINT_CHANGED happens, we call 
int340x_thermal_read_trips() which in turn updates the trip points.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

