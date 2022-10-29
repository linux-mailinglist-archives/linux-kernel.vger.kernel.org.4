Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F268611F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ2Cid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJ2Cib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:38:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60F1C4EED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:38:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i10so4499041qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPMGFP4WsRn5RhnkYFMzq7QYqhO9Igv5Sk67nHNTQRo=;
        b=MJwCFk+aRBBC8yd7D+5PFoGt0kiSGdcuGlh3JIifzrsC1i8jU4jPAyCvkS+RmyTHMd
         45IzP/KjzBK4Zn5lBL3Zg4YPSP8KGvJ/kh0mPvfvESYuWobXLwLCt2YItNJzBiZOCFU8
         54rdgdznGC9NcSrvXQi6ngFnU2KWM0M/moQ3oZJXncIgMSNp4CJc//Pf57UrH85UXpEl
         trotKbRjumdkACTez/+EOcMRyPaHeHBNCINaRnu7KOZTmZnPb5MKz+7uTjdE2XgrtdUM
         rwndRbiObLn5022CBO6Hz8XCD8odbZNUDNwy8cq+mEhEEoxtqgI4rD+NwUT8uOXs3U3m
         9WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPMGFP4WsRn5RhnkYFMzq7QYqhO9Igv5Sk67nHNTQRo=;
        b=PpVBmVrHSBauxGYsuIEXIfDqMWXz7b3OpXgsyTqCJw1f/Uz5Hly1eRYbbwk6OjCO4E
         FF5pXMwWo64OlmmeT+SWoNUl7lrWWN8qz66LgLEifL3jEuXdupUnIlkK9ZA8AoIZQFKp
         +1y1XW3WfhedFw6iXuLQGTNLpYroOYNsX1vi/x+DnYWQiQyZYF6bzfZsb9HwMbiNC6gu
         p2Uo0Y4TZltoAy6gf1hQKnWTTmQanhM13g3X/8aHFHnjN+BqwRMA5o5LE9q/kzQM7cPA
         A6xNvgvsNsCVJkiDcQqyMMqo8yGxWRE4L+ypKRz79e8B9ljwVj3pmh8DlfwGT5zWJzNo
         qK0A==
X-Gm-Message-State: ACrzQf3jDkfDUnn/D7IbMUjXrj134LOxTPHCqlkI8ZgOAWK4NTm3ZEGi
        Ehi9MZfDOiWHNduMmycNJf0=
X-Google-Smtp-Source: AMsMyM7AzOH6l57xDEEegyODYLZVLdheWGCQnXWR8evxDZaSt595rcEy9FcNF0NxUt6zhj3TO7DBeQ==
X-Received: by 2002:a05:620a:4606:b0:6ee:e73b:aecb with SMTP id br6-20020a05620a460600b006eee73baecbmr1635401qkb.681.1667011108994;
        Fri, 28 Oct 2022 19:38:28 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x10-20020ac84d4a000000b0039ccbf75f92sm224764qtv.11.2022.10.28.19.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 19:38:28 -0700 (PDT)
Message-ID: <fc09a68c-bd6d-0328-4052-88d40b50077d@gmail.com>
Date:   Fri, 28 Oct 2022 19:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221019204626.3813043-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 10/19/2022 1:46 PM, Cristian Marussi wrote:
[snip]

> In V2 the runtime enable/disable switching capability has been removed
> (for now) since still not deemed to be stable/reliable enough: as a
> consequence when SCMI Raw support is compiled in, the regular SCMI stack
> drivers are now inhibited permanently for that Kernel.

For our platforms (ARCH_BRCMSTB) we would need to have the ability to 
start with the regular SCMI stack to satisfy if nothing else, all clock 
consumers otherwise it makes it fairly challenging for us to boot to a 
prompt as we purposely turn off all unnecessary peripherals to conserve 
power. We could introduce a "full on" mode to remove the clock provider 
dependency, but I suspect others on "real" silicon may suffer from the 
same short comings.

Once user-space is reached, I suppose we could find a way to unbind from 
all SCMI consumers, and/or ensure that runtime PM is disabled, cpufreq 
is in a governor that won't do any active frequency switching etc.

What do you think?
-- 
Florian
