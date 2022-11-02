Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2462B61575F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKBCLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKBCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:11:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6B1F2E7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:11:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so787760pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbmauVFQEmSan6s50E+MhbGNKyCBU02VL+TZxUeQNvc=;
        b=M+6ltjJ5juYg7+NGiSDbW3SJhCoF8ZcirhbqZgwnqfhdeVdnq1FE+jcF+gAUmbEzgT
         rSuyovaIt3fTj8NcAmCIK5xfoVJayD2gnhiSf16hf8Li+Yc1NjQLumbPCWcHZYqO+XdF
         70JydiNX8/oytfjKZu1L1vVAXNsT1GblP7RBnsquWb6JEJ2uSh8myzViPJp7DhRZy3ZV
         TxmKZNGoWjnhXzLaCiXtsslVCxYantmR2eF/MVu4y7AiwLx5cqdBlg9dpCvwYUybOBn9
         +6mkJWhTbD5eIIJ/sFblBn1EfXpJ5DdDvKWFIydo7dKhU1Jw5licT8E5O8COV9cSsU9Z
         OGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbmauVFQEmSan6s50E+MhbGNKyCBU02VL+TZxUeQNvc=;
        b=tfaKxe7SBA/y1KsOO0Fci1mm+XvzMNiC68UjgAzagvIuiow4O1i29Qd+O8nngzhNOk
         Ta0/KlKlwzXN7TEw1w0EBY0BFSxDTzZsCHUWpQ8mzaZA9vDs+Qv81G2p91hC8A9TH8J4
         z0jWyaHpiB2ANugOa/pxwejPk4Q0G3Gzf1dZZr+I8segqkn9Z9da6Vk2f9+eGceeYbSW
         ywvMQudbXB1/RHavqpA7FNFQyvop5vJrDX2x5KNiUtCdev4eH+g8k4XgN9DfeQ2S5kLL
         2Y4uvVkKgbMO3qqHfqXMQpfryx7BjnCWnzl/ZaafZjlQ75D7gHKsDp04Vu8TW7jNlVEd
         odgQ==
X-Gm-Message-State: ACrzQf3Q0LZLkoKRpWPFyEbS5yqq9QEXsnH3PscdhKF2VDdx0Z9Ts1oc
        d6hOXWxlUgZBoFtI/pz2/7Pk/Q==
X-Google-Smtp-Source: AMsMyM6wYADM1GOKososBsPffvmpio0j6uQg8CrGRaj0/JMxGsBOTUyfq1SQu+pxwjJSoGf+mb3a2Q==
X-Received: by 2002:a17:902:8212:b0:186:a260:50a0 with SMTP id x18-20020a170902821200b00186a26050a0mr22157997pln.157.1667355085207;
        Tue, 01 Nov 2022 19:11:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b00177ff4019d9sm7010977plf.274.2022.11.01.19.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:11:24 -0700 (PDT)
Message-ID: <ee543096-ae21-99d3-f3a5-483deab03a5f@kernel.dk>
Date:   Tue, 1 Nov 2022 20:11:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next v4 1/5] block, bfq: remove set but not used variable
 in __bfq_entity_update_weight_prio
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
 <20221102022542.3621219-2-yukuai1@huaweicloud.com>
 <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
In-Reply-To: <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 8:09 PM, Jens Axboe wrote:
> On 11/1/22 8:25 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> After the patch "block, bfq: cleanup bfq_weights_tree add/remove apis"),
>> the local variable 'bfqd' is not used anymore, thus remove it.
> 
> Please add a Fixes tag.

Looks like the rest were good to go, so I added it myself.

-- 
Jens Axboe


