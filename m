Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F366B1FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjCIJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjCIJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:20:41 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83057769DF;
        Thu,  9 Mar 2023 01:20:36 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso746303wmp.4;
        Thu, 09 Mar 2023 01:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678353635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4DnOrK6eluIY3csFfRpB7iVzEAaVZe/zURRAiYA2H0=;
        b=8Opm1xHwy1Us7W9hSVEoWUwJYspXpQ7AJYK3hNqoffpSRpF/+dGMV+HxwuNq3p+4xx
         zhmENzl6K/M6OH6lpljPv1SQKU5Lp8OiZZYG32Y6SW5RokZpZiP/v2kWH7x2aFrDLGls
         VaB48jiHWjbolCSchMi3uu8m0SGdgQCl8bEwNrwF3Had9MIo+LRt7zLLmzfpi54Tpu6L
         gFfsVgznhGSgtrud1VWW4sW3KrhDfxyYMWqf8mcpDKPBgyTZIZ4oe2QhzPrEfQuPM0nw
         J11rmGw3h8rUZrCCjvgqBEEYkbsnNpyr0K1GiY3pr+nFB3i063+cecCaPLwJQ42ITR2V
         k5jA==
X-Gm-Message-State: AO0yUKW3dSN7L6HAGqseTWAbfPZDmTCjrcyPiBh+pa2A8zW23Ng6y2zV
        xmla65iT761v5lGBuxXqBDc=
X-Google-Smtp-Source: AK7set8O87BBg+d2mUeI1CxhxmCi92kGzMzTqUzavkVL5P8z3TFNd0uw7xpCE22oHD/Ia+FYkGWwDQ==
X-Received: by 2002:a05:600c:3ac5:b0:3e7:534a:694e with SMTP id d5-20020a05600c3ac500b003e7534a694emr1500950wms.3.1678353634959;
        Thu, 09 Mar 2023 01:20:34 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003e11ad0750csm1874514wmb.47.2023.03.09.01.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:20:34 -0800 (PST)
Message-ID: <538393e2-3435-7e93-d688-d77f45552286@grimberg.me>
Date:   Thu, 9 Mar 2023 11:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] MAINTAINERS: repair malformed T: entries in NVM EXPRESS
 DRIVERS
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308144132.13368-1-lukas.bulwahn@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230308144132.13368-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
> or topgit) and location.
> 
> Add the SCM tree type to the T: entry, and reorder the file entries in
> alphabetical order.
> 
> Fixes: b508fc354f6d ("nvme: update maintainers information")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
