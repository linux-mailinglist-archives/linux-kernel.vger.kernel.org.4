Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB676E4725
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDQMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDQMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:09:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43B76BD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:08:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dx24so19459202ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681733292; x=1684325292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyjCqigehhRKiED+F7i3vp1+UnMWF7PX5LVbym+vBgo=;
        b=eQ/pX6Pevn30y70TZq3BnGur7Qv7Y+QHdBV5HQbPhPQNMotYG22G/1W2bDgBpa1opH
         0u16TrJwKJgvC2W2CCerev70jsUcGpTvdyy+TDCzzo0syb6024IEULDHSBzQtjEGSR2K
         nnvz2qVv3wT5bWXKQF/YY4ka+HkgVVMYgYzTuxI9QwFVZHOo2GL3mStHWb7AxH8fAyLG
         Gda8aFXZ3COmfANJaXtpuF7NtyV5RQC1R8i/toWNDAMr5D8tdZbv3M5tgADKJL1XzjND
         qDiD4Wx0ttkvBPgkhCUQ/usDq2EeQPtDh/YlF+n2bVYDNJDBTEJrG7/fuW7Cx0Ew3hzI
         imkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681733292; x=1684325292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyjCqigehhRKiED+F7i3vp1+UnMWF7PX5LVbym+vBgo=;
        b=Jecs3s5gtnvV9Q4JfkkI7RBrDmmGzDUR/oFG/mJE7KGgC0tFDCfSlX7PEWnbgwJ6ES
         2jH1CuEzppWZmpaUT2yfW1iNYGZQqIbpTTAiXq4g8XJF8qVacomDDOUWFuhKgEtYpqSc
         UqFeRetsl3BgX29uLNOwYtNohp9mpUYhbBuriLbgSsCEFkoKFvJbEsjLI+BLGZLspm1M
         y5/51je+whf539WihxC+GYq/2/hnjLSbhMuEehnjY91Bd+HltUd2pRlxzq8euq6SOXU2
         uTaErTrBwRqE2uJjFm2og0Kdr6d/88gIR2f0pJ55RTEd52z0WjyrEylLi2hn2XINsDtY
         410Q==
X-Gm-Message-State: AAQBX9dH5MXoyyBlRuWJVY4CAYaoQBXqGSnzKMY5JQh3sNOcjv9tetwX
        /YsvzKk0fx870NiGdEIOTJ54sQ==
X-Google-Smtp-Source: AKy350Z9M8w8QtKoLzHMqZ92p1x/RdWw+D+90EtnaEBd1Rdy0qMwdeE+XVr5iDzYlUx2fn7cjTHsaw==
X-Received: by 2002:a17:906:d9b:b0:93f:505b:9742 with SMTP id m27-20020a1709060d9b00b0093f505b9742mr7135280eji.65.1681733292530;
        Mon, 17 Apr 2023 05:08:12 -0700 (PDT)
Received: from [10.27.64.40] ([193.205.131.2])
        by smtp.googlemail.com with ESMTPSA id gl17-20020a170906e0d100b0094f09cd4658sm3963255ejb.71.2023.04.17.05.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 05:08:12 -0700 (PDT)
Message-ID: <dd0c6f67-99bd-afda-cbc7-797797b82f2b@linaro.org>
Date:   Mon, 17 Apr 2023 14:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] thermal/drivers/intel/int340x: Add DLVR support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230413213753.129962-1-srinivas.pandruvada@linux.intel.com>
 <5c21f6b7-8c7e-6e42-fe02-c8fd3ae64016@linaro.org>
 <CAJZ5v0ir+-MEYkPSZKFSyZ=iAnUbVXtk9jMZHdgpWM6LMQ10jA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ir+-MEYkPSZKFSyZ=iAnUbVXtk9jMZHdgpWM6LMQ10jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 12:16, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Mon, Apr 17, 2023 at 12:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> do you want me to pick this patch ?
> 
> No, thank you.
> 
> You can generally assume that I will be applying patches for
> thermal/intel/ and ACPI-related ones directly.
> 
> I may pick up thermal core patches too.
> 

Ok, noted, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

