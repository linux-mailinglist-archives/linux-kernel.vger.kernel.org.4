Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4E6DA5E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDFWg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbjDFWgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:36:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5101A9EF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:36:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n19so23292580wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680820611; x=1683412611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skWX9V317pI7NFnUDRVjdiomu/IWGv9zO3PQr3O+0uk=;
        b=jJgrKDCZPq1PQ1wu7w5F8v68QGssbbDfm573xRWw9vyrk0++cFgNOdWVe7UrNK2XgI
         S82GTTZYB7E+30OH/XfjlMNOGdtXnNi3z3UeOURigvi+/lPvu0vkdazXXD4VKrdob/+d
         90YU76FquqdagkLcvZ2QfLVFCocFAank4eE8dAF2q6MrbE4FmILp8i3+ALQmDff34JV7
         HUg5p2/4HOp7THF8qBCnz9SrV2wQT6zx5jWzLPY4i2a+6FeRPp1XTPGMZAtTJqL7XRlj
         3d/QEzYxT7p4cfSYcmF/hWIPVhja7LfbtYqgfjIdUj7DOTLBduZgWcmixWO2XR5s6J3k
         8BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820611; x=1683412611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skWX9V317pI7NFnUDRVjdiomu/IWGv9zO3PQr3O+0uk=;
        b=FjoakAJlPCdY1gyBsplGjTjxI/uls0ayZHUvS/tVhOq1uUMsW8prx1WE4Id8bwqgcj
         zLPcl10zhFwjodBTYJN0U8jA0Jzdj5WmvwPUBGRfY3TVNo60ZN2BcHeHoSVzM5+3jKVE
         Ij575lwwT8gt5tDUvaccyHelddyug5lQ3Ux0eb90zWYj/oCgz5zZju9kKAqdPHvmDgEy
         DShATUQVRWrSQ9l9BAOxCqAdhYvnRexGA10cr3j9nwsJmR2EJEv1T0Wn6lj5Rf7IiyEh
         QCnlAkpGgPDI5e6As5xIu4Yq6CnlB13FQ0RKNfxEmJSmDxUy1+7V7S6p/CZoDeasUqs/
         L0cw==
X-Gm-Message-State: AAQBX9fWWa85xZmkthAJYiKc8QVh1DPWeHyek0xwGPWcvte5oNss8kpT
        wEPu3tJeypkjlHnJsvW3sESHLg==
X-Google-Smtp-Source: AKy350bWXvtTUpNp9GTweEAhj6nDrtaEn4yUhBWLJ3Zerlt9BYOtC8MU31tkTPGRoxTkQ0C8h0yKxQ==
X-Received: by 2002:a7b:c5c2:0:b0:3ed:c84c:7efe with SMTP id n2-20020a7bc5c2000000b003edc84c7efemr26055wmk.7.1680820610709;
        Thu, 06 Apr 2023 15:36:50 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bce13000000b003edcc2223c6sm2764839wmc.28.2023.04.06.15.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:36:50 -0700 (PDT)
Message-ID: <af18c56b-3133-542e-541a-2589b3d3e5ed@linaro.org>
Date:   Thu, 6 Apr 2023 23:36:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] drivers/thermal/qcom/tsens: Add ability to read and
 shift-in non-contiguous calibration data
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        dmitry.baryshkov@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
 <ZC7xSG7qVZ7vlOB7@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZC7xSG7qVZ7vlOB7@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17:20, Stephan Gerhold wrote:
>> Reviewed-by: Bryan O'Donoghue<bryan.odonoghue@linaro.org>
> So with sensor hwid=10 disabled, I think this patch series is actually
> not needed? 😄

I can hardly be expected to remember back to January ..

dropping
