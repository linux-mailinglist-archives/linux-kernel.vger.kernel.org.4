Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794326801E9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjA2Vvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjA2Vvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:51:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862819F06
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:51:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so9381657pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10Pr4T3evkPPQKg3Z4WSUnPLk+n8TOgwlOyguzNlXvc=;
        b=kQM+1CafTz4AifPNzW97tONzVLTLm+vEF8Iyye32LSIsoi36btod+M6SMhwuSjChID
         zoAjW+MhRE5AHd/9nnVasiSpPfx2pFhRz3w2VPXdeyyOtvIb0S/9kAPn3cO7p/a5Bids
         4i0kl0sV79hfhMzgfrww/yDdoYXYhA93VWWmIWzdY4wLIh8bCkz6sf4Dv0eT/eJBHJVw
         CX1cNIeOco0O1UHvXPSnM9nKEC4GoupqFJ3XcRc641i547oql4Ae23OUNhxjPGAluSYA
         vevkYAgoZjnI4OWp703RysiiS3knD9jAWzR/HP2wCXH/XmwtGDrxBiMBb9lx7oai85kP
         Ny+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10Pr4T3evkPPQKg3Z4WSUnPLk+n8TOgwlOyguzNlXvc=;
        b=Zk9kl2QzC36rX8Jdc4nz2y0pexeK4+YiuaHygoJfDembzGGW+nNhRLpx/o6VHzO59L
         wrJDwAqK1yANy9TH16gLVsM3EYqqiSRvm3G7oecq7mdKB99daDl/xYcpeNXHB+Y7IZzr
         HYy4fQ37iiWtrxVKA0YWly0iY7I9Ub+Ia5icc0kL6SDDPS14GuYtV0R61E98Tx/YMfRi
         tQa9NW6MHSk0T+wCogA7Wo4UZySt6Zb8Yyi1+6CngQm1za0VtQ75fzC/7O6jY4bd+rB8
         6VzSlGRJfpk8aApm2krpvauWC8KrQhSPPt7+wtBBh3q9Rn9kfFpo6Z70Gk2EjJfiaYlR
         JPKA==
X-Gm-Message-State: AO0yUKX5z+6C+qg4OcS3i5ZDF59H8dqJfKzRZuD4ZkGmXoGzNk2yFPSr
        OClvF4qAicnTUJgcHD6KYJz89A==
X-Google-Smtp-Source: AK7set9UwyyS480BvbwK2q/t9G/ERX1sK6n1yKDw4WAIvyBBQLF0ETzkHs48lSwH06DxKPhLr30o6w==
X-Received: by 2002:a17:902:780a:b0:196:5640:b065 with SMTP id p10-20020a170902780a00b001965640b065mr2217816pll.6.1675029100217;
        Sun, 29 Jan 2023 13:51:40 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902b68400b0019644d4242dsm90993pls.82.2023.01.29.13.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 13:51:39 -0800 (PST)
Message-ID: <7ae20fa2-d9b4-9e21-4209-81bf4845a3c5@kernel.dk>
Date:   Sun, 29 Jan 2023 14:51:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
        josef@toxicpanda.com, paolo.valente@linaro.org,
        shinichiro.kawasaki@wdc.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
 <4d3f6183-f9d4-b657-0205-fc240bc24c76@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4d3f6183-f9d4-b657-0205-fc240bc24c76@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 6:38 PM, Yu Kuai wrote:
> Hi, Jens
> 
> 在 2023/01/13 17:44, Yu Kuai 写道:
>> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
>> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
>> bic->bfqq will be freed first, and bic_set_bfqq() is called with the freed
>> bic->bfqq.
>>
>> Fix the problem by always freeing bfqq after bic_set_bfqq().
>>
> 
> Sorry that I send this patch will wrong email, and you might missed this
> patch.
> 
> Can you apply this patch? This patch can't be applied directly to lower
> version due to Paolo's patchset, I'll send lts patch seperately.

I'm confused... So this patch only applies to the 6.3 branch, yet we
need it in 6.2 as far as I can tell. Why isn't it against block-6.2
then?

-- 
Jens Axboe


