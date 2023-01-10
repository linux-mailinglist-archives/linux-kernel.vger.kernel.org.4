Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4DE6637D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAJDTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAJDSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:18:45 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9641D59
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:18:41 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 200so1596337pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2vMuRifEflR0rqW4sVbUmQc1/LuBQa1QT5vJMZvjAc=;
        b=X2TklK6j3bpjXI8F9pl0dTcLZeEW9rmtOm9P6qKtQjrt7FgcPXyioe0lNefGzeViIB
         +pLK38NB74PfUxiGi2RvEBwD89DoJW+RQzzFMVsfcq5Y8Q6GYw/KyUmJVJ2L4TBqWj/E
         UwMzHyubCpYuuV3dZPMsMJNpzrYn+kcIoaeSE+0pkejMvaBH5+VSjAFhjU5RchZwPh9I
         yY6NthoZvdF4wrGoCc70PbufBEVRq+AwbYzI5L8EaiZAzfFUkAK+xhEuRUHYebPxGvIE
         DxBweGNr4e1HnPUV1SPYBQ1QGD6FSbqYhH/tMf2f7nMpxZOWbIb0mwF0MQkBqcnKBhkE
         0O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2vMuRifEflR0rqW4sVbUmQc1/LuBQa1QT5vJMZvjAc=;
        b=0IIVSYb6ZNX9za2np3mBJl2NKBQU0uY1SXnJNB2taXK3ix+3R9OHIoXlXFaAOCBkDB
         0G97QIFSwBJLlr4o2LWuEtwL0Ywf/KkcR7CqdttHlwCrvIMQ8PQww5Yc8ehcG9Pbk004
         +2jAo72ARduaid8EERZHpSbb1FJ27jrkcuNDUkSqjRmU08gAb0+0wfZNv+PGYSVWmJJi
         l/6JFnUyb0nATYePBRIJidHZYWBOwUn6kaRhqtQ/I7d7zMIpthmT3DGqbmypWB+9dK30
         eRksuKLmkjqpK3UUHpq54yAZ74UKBP+HB0gTP48Kn4DIdqmxe1fiJJ03LoEPaMntTnuO
         7hPw==
X-Gm-Message-State: AFqh2koe76mbFmyv31aMrqeWDQhQZmjzkr1N9C+7yzV5D7MCcz5DyiPO
        GxnMzbeuwr7RMjTJZXqe12pvcA==
X-Google-Smtp-Source: AMrXdXvBg0uBp69ddXdGZcOkOEPW1BK7ZjQr2Kd9Z1AjIxSSnX02TnQVanCB2HrHkQ+GP/UBL3z07Q==
X-Received: by 2002:a05:6a00:2a0b:b0:585:4ca7:5c4b with SMTP id ce11-20020a056a002a0b00b005854ca75c4bmr2754545pfb.2.1673320721376;
        Mon, 09 Jan 2023 19:18:41 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u64-20020a627943000000b00581816425f3sm6480835pfc.112.2023.01.09.19.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 19:18:41 -0800 (PST)
Message-ID: <f37f8e60-d580-0b7c-0fa5-a26ab49c9781@kernel.dk>
Date:   Mon, 9 Jan 2023 20:18:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Content-Language: en-US
To:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com,
        logang@deltatee.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com,
        maorg@nvidia.com
References: <20230109144701.83021-1-yishaih@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230109144701.83021-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 7:47 AM, Yishai Hadas wrote:
> The last_pg is wrong, it is actually the first page of the last
> scatterlist element. To get the last page of the last scatterlist
> element we have to add prv->length. So it is checking mergability
> against the wrong page, Further, a SG element is not guaranteed to end
> on a page boundary, so we have to check the sub page location also for
> merge eligibility.
> 
> Fix the above by checking physical contiguity, compute the actual last
> page and then call pages_are_mergable().

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Andrew, can you pick this one up?

-- 
Jens Axboe


