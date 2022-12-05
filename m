Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BA86435E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiLEUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiLEUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:43:30 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579C10B67
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:43:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k7so11954908pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 12:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QllzgBmKfeFLd2Tk+Su9MVLerqnhHMQ0mpp6R6EDUXA=;
        b=mKvQCyVr71vjuMH69/4lkzgJiGF88wXIISBmVb+39eLRquY/w9CfmCxsVQU6U2qnv7
         HVV7LsRKb/hwJtni3Bwk7o2yKUYdHUHm9WwEZbh9eTfMZP92J5kfYnBphxhJ9maf5Xyg
         hShv0t6sZeoHAfadns2kCGyDLXYqxPzkY6Z6T2WSSH056KMwtzUnBjkzPYrFmSGqQGYL
         iaLSU1idIPd1OFX38X4J9cNzp0rm8g0nPCy6f+RIxgnVWwz5NoDgSvbCwSRwnI6kITIq
         AylZNXoHhJJc0UKD3uhrkDsdoe1bk633bTf8O2U2DAP0PUGY0mBKLX6Qjp02/dUpYOaT
         A8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QllzgBmKfeFLd2Tk+Su9MVLerqnhHMQ0mpp6R6EDUXA=;
        b=1uvm1CfFGMkqCYVROAXw9PXMwGqXE7cX4IvOq3bK4/fUphzmh5bMLEBrhIEKRsXHhl
         ljH3grR9Avmy02TH896B7d2L5a8I1TRCwvDsEMNXzlbsIGPnPye1k76NbZUBLIgF6I1z
         vgEABlc7KVDNfM1sodIvamqWAu2gO0NhWqZP68RuzSoHJLtP65DK3bTQ2R6330rhoYEF
         K/O/vwPuFhFl2RFpXQhAu4MzuS7W5SlAi8JyjfJnWRU6qkNXf7j4k9lQq24Rs//p+6XW
         qr3NGcYxGXNrPiSMaBIUdDL92971sUCG/e6bpJVC2tseJVnLBTarIbJAhwFJ2HQ7Glu+
         wquw==
X-Gm-Message-State: ANoB5plZ3SNZgduk3J3jTETR2s7ZDEOvO7p+inDhwqgwgl60rfns2VL2
        fnk4jvDJu4joH+WLvwNS7vDsug==
X-Google-Smtp-Source: AA0mqf4DpCaPvj5EwsaAn7jVOzJb1S4VxqyLXqWRa1NJBqfrL+eIA/EyADCanzo2IRsyNREgOSWBTw==
X-Received: by 2002:a17:90a:4615:b0:218:8f4:bad5 with SMTP id w21-20020a17090a461500b0021808f4bad5mr97558223pjg.55.1670273008901;
        Mon, 05 Dec 2022 12:43:28 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v129-20020a622f87000000b005761c4754e7sm8670210pfv.144.2022.12.05.12.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:43:28 -0800 (PST)
Message-ID: <be8563d8-1992-f9bc-928f-e9e5f3227c1c@kernel.dk>
Date:   Mon, 5 Dec 2022 13:43:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/9] blk-throttle: correct stale comment in
 throtl_pd_init
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
References: <20221205115709.251489-1-shikemeng@huaweicloud.com>
 <20221205115709.251489-2-shikemeng@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205115709.251489-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 4:57?AM, Kemeng Shi wrote:
> From: Kemeng Shi <shikemeng@huawei.com>
> 
> On the default hierarchy (cgroup2), the throttle interface files don't
> exist in the root cgroup, so the ablity to limit the whole system
> by configuring root group is not existing anymore. In general, cgroup
> doesn't wanna be in the business of restricting resources at the
> system level, so correct the stale comment that we can limit whole
> system to we can only limit subtree.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Which one should be used? You have duplicate SOBs in each of the
commits. It's marked as being from Kemeng Shi <shikemeng@huawei.com> so
that is what I'll use.

-- 
Jens Axboe
