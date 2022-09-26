Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6602B5EABA3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiIZPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiIZPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:50:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B555072C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:37:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y141so5382909iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sw6FZfqvzqmIX08UU5Lp/Uj6v4XlSe1NzsiXFnfdCQQ=;
        b=Sgk7alXXb92f8PuIwx5286o8RmTgibl09jojUbn0aQnglsvqSkRc63Rbb/PKHCsnWp
         Zp9Ql3jXYfs9f9jPlBoEVH+KcUOtZTf9qDObHCVzc2DN/f32kF4n2DdbShZSIQWZ2LCp
         xphNxJPxas1kCrrp1f7LcqXPD/7Z0ir5kthtSk9Yt5F7Oe9x3WASdtNVhHQsRAawoqsO
         ZehgRkevoTRmE3+taiu8haTclgXb7j+oWKXpQEzTjWCU6pIP011YlIZLPU/z6H4/6/hM
         Cs10ttseX8HJ3duSUtX7rqDDEMYL2OnWWcy2LI/uOE7zIf3bwZCTJzFhyjcxlqhx2Elc
         GfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sw6FZfqvzqmIX08UU5Lp/Uj6v4XlSe1NzsiXFnfdCQQ=;
        b=YzTEvxV9seiJDgxOEOCSmg/hxbDknWQt3S1D7+b+NfIcqUj2m1KoHmFS2ESYo3FT3b
         hjklVkYWiZAjULXT/AuHpvdi+z1vlWt+RNsDBekwWpvw2RlMpLGV5sl7CPA0BRH+IyBq
         R0dZuwFCPYZKNbHtfUUBKSS1xaf+JJTz1g7fvZw4IsEvOZ3JyNUKibjVgwoUNwtvBDGX
         +5uXV0E/e4UMWI443zBGh+HTxPCd8TRJH2t8NOB0d8ASpAEcwwM/MBH/wfd4rCb/uOsO
         srvvd8yzU8WM+81//68CvYwYpADXhgFTMh4V2C/C/rSpZD/xkX6iuJKlhEkU4tgtDAcL
         rwEw==
X-Gm-Message-State: ACrzQf2Zn8+5Eavbw92S2DqQ7d2zfC9dQf8p772fdyAfcahdarh0AOVD
        igwz9sGaRtH1r7pq/ueTzzBVMWmQA8Dj3g==
X-Google-Smtp-Source: AMsMyM6dc8lGAnVF5vWLwpmxZCPIcuTQGiT+kISHXfhf5AFSZVDgnKY327j0Xn7BDiTqruKZzb9eHA==
X-Received: by 2002:a02:2711:0:b0:35a:4fb3:efcf with SMTP id g17-20020a022711000000b0035a4fb3efcfmr11779967jaa.14.1664203074842;
        Mon, 26 Sep 2022 07:37:54 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i7-20020a056638380700b00349d2d52f6asm7097615jav.37.2022.09.26.07.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:37:54 -0700 (PDT)
Message-ID: <e1ddd430-384d-f704-2373-41a455288380@kernel.dk>
Date:   Mon, 26 Sep 2022 08:37:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] io_uring: register single issuer task at creation
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20220926140304.1973990-1-dylany@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220926140304.1973990-1-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 8:03 AM, Dylan Yudaken wrote:
> Registering the single issuer task from the first submit adds unnecesary
> complications to the API as well as the implementation. Where simply
> registering it at creation should not impose any barriers to getting the
> same performance wins.
> 
> There is another problem in 6.1, with IORING_SETUP_DEFER_TASKRUN. That
> would like to check the submitter_task from unlocked contexts, which would
> be racy. If upfront the submitter_task is set at creation time it will
> simplify the logic there and probably increase performance (though this is
> unmeasured).
> 
> Patch 1 registers the task at creation of the io_uring, this works
> standalone in case you want to only merge this part for 6.0
> 
> Patch 2/3 cleans up the code from the old style

Applied 1/3 for 6.0, and then created a new branch for 6.1 that holds
2-3/3. Thanks!

-- 
Jens Axboe


