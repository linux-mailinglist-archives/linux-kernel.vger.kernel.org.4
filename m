Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F876D8667
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDES5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjDES5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:57:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5513A9D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:57:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso1671798wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680721069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfK/ruuUAIVsaAum9iERPkTyValfNQl6BGUoiSN+Q9c=;
        b=A2dfbpa4yjmhPFNsLPDYm25h4SnPTXoF8szEJengRiCITcljVlgz+fF4u8MDpHWONM
         QCGgzCcX3LbfLXrBFiulnBMtVX/yw8pVsmTPQcXscyfkUOlu+MuGP3QIhZVAJO1KBQN6
         xuTlY7LOjemgJsh/IDbnSBA3wJfRKcmLevjcIpsgdXkNqfnC9hN+G3do7+JeAZtQEzW6
         K+NRVXUMgjiftBE/XpL8ZXjrjbwpZhti5IS49cPrw7v0XFEYaGWkVYKkNsr0U0t7K1bX
         bcq+066VWnrfFNJQ7sNBE1vt/UL2orOC7WiXUAW1FE/iVeWBV37ioqHIFyLxgrXSOUun
         +JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfK/ruuUAIVsaAum9iERPkTyValfNQl6BGUoiSN+Q9c=;
        b=0uLQJR7x9ubzrlZfJWKtPlKZiv+Z9omdwyg6f0WzFSBxRa//PsoMZmHejWUOtehIgr
         hitlDVzcDzGTHkwMOk1ecA34ESrZeib/+gnmPptXE9mqx1+08DT9gopJgOArDkCuaPYj
         TeZyhHPu9dvMxJa5ZFrXPsqfOvBdbPU+sloNt5V171umzVNDfdHJ4gx/UFgkpflI5M9s
         80PU4wc4WCT555WwvSoCeP408oo/nkdY7cqkBl2cpKpXYEOVLqaULmk/TYvc1sblHXDG
         LKl6DrbZd3NeN4gmzw7gI1KYgJzkXZ7cTEGH9wAuWcwVckTYrghwos2cyCM51qMSGRJl
         S+tQ==
X-Gm-Message-State: AAQBX9fVvnzFGOFkubIuNMPVT6b3ScjBL7DStzE6g4gEYgG2JgTu8Rr/
        JbzWa0GvoeOiZKzzSlIMb1wtlA==
X-Google-Smtp-Source: AKy350axVpdPw22PByVRZ9ZA2cBFUasTWfKl93dB2TAQj0kvAxjYOL5YSOQOBMpf8tORSDmuKgkxuw==
X-Received: by 2002:a05:600c:3644:b0:3eb:42fa:39d5 with SMTP id y4-20020a05600c364400b003eb42fa39d5mr5488382wmq.29.1680721069215;
        Wed, 05 Apr 2023 11:57:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b003eeb1d6a470sm3037768wmi.13.2023.04.05.11.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 11:57:48 -0700 (PDT)
Message-ID: <0a89bfa4-a473-b75f-3c06-b9d4a1f547a0@linaro.org>
Date:   Wed, 5 Apr 2023 20:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] thermal for v6.4-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
 <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org>
 <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 20:39, Rafael J. Wysocki wrote:
> On Wed, Apr 5, 2023 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> just a gentle reminder
> 
> This is in my linux-next branch, I'll merge it into thermal tomorrow.
> 
>>   because more material will come in the next days
> 
> So why can't it wait?

There are more changes to be sent which is against thermal/bleeding-edge 
+  patches on the mailing list

The branch thermal/bleeding-edge is based on thermal/linux-next which in 
turn is based on linux-pm/next

Having thermal/linux-next merged will allow me to merge 
thermal/bleeding-edge into thermal/linux-next, then take the patches on 
the mailing list and merge them into thermal/bleeding-edge.

So at this point, I can send more patches based on the exported branch. 
Otherwise, the patches I will send will depend on patches on the mailing 
list.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


