Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7EC682DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjAaNUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjAaNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:19:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3604FAF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:19:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so14163571wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMo1Uvj2rFI4YHTrqKmdTiIi+u7MqVqqdbblHM1ubeA=;
        b=kT92r7GyRZTYR8mGvgkCO/iUaBkKd9TU3//8coQoHSHU+cufA/dutHuoRLuzdyc612
         cmMfzb32RJyjFvQBBazq4YCQZjXecLfEvDgswp3vd5OrAovEyua7dmxfVhBAynZr9X5R
         Z0w0gg3rmzsp6BhvnC368L3nI/Zdj5m6hy8RQiVJLY1XkBJzBHqZ2mM5dpIjz0vqzUBJ
         pF66ooIVvEvvgLvrI59mXLlVQpMLH715+rNS6fu+ZhoeXdRHTQgc6bPEHtBeCFoQNQXS
         /zBc2fq5ZJOVg+my1zToMpg8UTKAftWOoYJXVXf3w8MsWv/lUK9oKNblKUdnP2+a/Kbi
         mTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMo1Uvj2rFI4YHTrqKmdTiIi+u7MqVqqdbblHM1ubeA=;
        b=6Lwjw5di9ioe1EMbLZ0M8c4AB8GxbB+1MYWNiru5xTQSDZZsOhvIwuKE2Y2hYaZ8rN
         UuO7iB7O/pT/kfglzuwggFSKuppacvQ9fkNyqH1RN2QehDkWbMgIPSck+xgDUHSmmi95
         phnBKEV5C1MJT9zMPa+jLq/TayNoh+HyVIq11eaqcUs0ZlnCHbfHZIFLOZFWRKv/FdFJ
         cq622Rsjs49mCgQ8RblmFgJgXkagIJJuC5nkEWoW5kzvMPzwOqGU7MkjBLWDvu/CbD06
         TwfmNdNS/iYHCY21ecmIYxeD6R5bbVUMnHr2gXFF9Vy7rTtUms/BEjJFGc9cHLgUh+Rl
         w6jw==
X-Gm-Message-State: AO0yUKW4t8v7jvXu5FxAFuTv+eaBYquTQl6z8EvIHO3BKnjKdsme5MUk
        CEARMYKATu3Y0ueWQC3a2vBvDA==
X-Google-Smtp-Source: AK7set8+z14j6byknzmPNfNDAcrTd590sAlEwun1KVKdHHIegxp6ZEjbaL4ahrm/j8PcjQbdAxnScg==
X-Received: by 2002:adf:a11e:0:b0:2bf:e9dc:5536 with SMTP id o30-20020adfa11e000000b002bfe9dc5536mr7841401wro.45.1675171167643;
        Tue, 31 Jan 2023 05:19:27 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b002be34f87a34sm14918057wrr.1.2023.01.31.05.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:19:27 -0800 (PST)
Message-ID: <05668142-761b-e422-5c81-15a70fa77be8@linaro.org>
Date:   Tue, 31 Jan 2023 14:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/8] thermal: intel: intel_pch: Eliminate redundant
 return pointers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <1847763.CQOukoFCf9@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1847763.CQOukoFCf9@kreacher>
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

On 30/01/2023 19:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both pch_wpt_init() and pch_wpt_get_temp() can return the proper
> result via their return values, so they do not need to use return
> pointers.
> 
> Modify them accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

