Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8F673A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjASNlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjASNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:40:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A980887
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:40:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2105314wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcoeZ2kZnaju4+VtNiFKzU3RYmZc2v0F4v89RyRolVo=;
        b=LbgxxrOfGOTgPygegnrzKZTqIeDa04JMfqw3oY6S/3yudde8/xt5m2x7quAoiwRs+s
         QMxz7lnat4EIEVQFsmZNDHZbeFyvV8KN8r9DhutWGRm+xNnZ3IL2k8fnCQCsTD78Lr/w
         Jq/1DLP/2sF2ocX5/vLa7OPPuToMEaSQUB/U7kJKjZrl7zLU1kZHX+UJCBsBAsE1TyzD
         Dx2CLMFdP+uQMgIcOisb8J8plm9ykb5zCisypsFHan0qNafYRPW8ukAr3FNLdveMVuPU
         fjjqH4rcLeq5kmSN/MljXgyYrfc2Z3I0ssfOsYXnAYIOutrKXh4AaKD8HOxWHJUYD33W
         9LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcoeZ2kZnaju4+VtNiFKzU3RYmZc2v0F4v89RyRolVo=;
        b=UctOQlj13AxKB2TRV74paM3Q2gXRg0+jPHAJervFzOGqL2q4CkxM8NqaP0kk1BFIdS
         baVNNx1DCy8BSjcl2M5HRUpc6RdGC6k8GByXUqMbd0LSgq4NBXXEqZnvK26gU/wEtchv
         KLlwd1B7Nk9gP4LHGhl7Waf80FudQxo9+6kgdeWr2hwMb2W6uljMlka8Ursi4yu6wF9X
         dvH165qHY6piFyst9qc7xRcDwr2y+CY3CsBXajm0vInGYbezTFPkMZ2Xwzr21vB21bHE
         rZMPTFyRdJqubHDBgDay8zumyp8R/+qPSrnkOgKQRZMSUUhridiYAAr0LEdpKWG9B59X
         Yqkw==
X-Gm-Message-State: AFqh2kpedfeXK8dZvLpRlseEOJh0SQcNUBZZ+dKbVH7Nx/0oKAUFl934
        yuwqYx7JQg5wkh+khP6rgkqa0g==
X-Google-Smtp-Source: AMrXdXuwRjv7fXtdMHXGsJnNizol1Hkxw5TN7y/jS2s40VORmJJWL65apHjMWaMSjMI3eI5JK7FxOw==
X-Received: by 2002:a05:600c:22d2:b0:3d1:f0f1:ceb4 with SMTP id 18-20020a05600c22d200b003d1f0f1ceb4mr10286742wmg.19.1674135629377;
        Thu, 19 Jan 2023 05:40:29 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e12-20020a05600c218c00b003d9ddc82450sm4707612wme.45.2023.01.19.05.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:40:29 -0800 (PST)
Message-ID: <5f90aef1-93e1-832a-6cee-6e2cb4d7ec25@linaro.org>
Date:   Thu, 19 Jan 2023 14:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] thermal/core: Fix unregistering netlink at thermal
 init time
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <CAJZ5v0h-QkrgyLYLn9S_mkWN5nN1fUXej8zmarU425xW-Lei0Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h-QkrgyLYLn9S_mkWN5nN1fUXej8zmarU425xW-Lei0Q@mail.gmail.com>
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

On 19/01/2023 14:28, Rafael J. Wysocki wrote:
> On Wed, Jan 18, 2023 at 10:11 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The thermal subsystem initialization miss an netlink unregistering
>> function in the error. Add it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> What tree is this series based on?

It is based on 
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

