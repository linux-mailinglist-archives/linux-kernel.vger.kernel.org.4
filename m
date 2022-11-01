Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0D615167
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKASTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKASTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:19:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36744272E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:19:01 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p184so13019771iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yIMEyIdM9BFDMzy8xupZjUmRK55OQN/jxJjTBfmY5U=;
        b=byGLyGcJKLOMhhsYAQFyqJgNnvmQuTaMJQnsrFQK//IAZfxxe+xgXEs+28NOOOYHHH
         P3N1E7F8M5Qg1/BsI4pmCP49cuq6ySdvXOMOHoWE1E5wS81OUbvo9uRZyL31R2zHRHp4
         lqh1Se/P+OPv+OlJ8BHfH3YNvIi/j6Yj0GfMA2/pY1j28kb0EbyxGQNfr9LCP0gIx/i4
         6GAXOXVkQssZuJ7+Fd4EKtfhXm4HKZz6uTB4zGzozInOGnx6fM4lxvbDbTBnXu6qrJlo
         0HcGlZI2DmfGX3Pfi8+9F39NPJFrRbvbKlfztyNk60Ng5aE1Ex0uyLrVrYignOIwK6VA
         Mv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yIMEyIdM9BFDMzy8xupZjUmRK55OQN/jxJjTBfmY5U=;
        b=uke/CKqgRGUtiw3Iea4E6bpfS2ENx4Zo1vX+SYme4yuZ4yhji8R47gq5thfhxnTtxp
         dO5tRNd6Vl6DrBmEQQQTtp/QzvMQzeOYp7adYvQBh7AakkqluYn8esX2FK4JzNRQewp1
         UPzb+IOMen6xKS9GvmZKAfn6QHfsAlCK/5iDXpIsghqxI2GfGkoWLJRSujLdskTR2hKo
         oGAFUTiIw6zCjhu7vsxGC0aM4CoBY0HSxNXs3GsbCjfVfwAKiDAb4lcjk0kMuqNeFk0J
         oo+eO0GCF4n1AltX48jVALNiThJdzsr2Bvw+CsA94H7slog6+K+d/mGU+whI/quybW9v
         067w==
X-Gm-Message-State: ACrzQf2jOu+pft2rbi6BYk0M+vvfxz47dcoLHhtgxC40sSCuMsaLDSFH
        C6Ajrp38kwXpd8cGFENTLW696Q==
X-Google-Smtp-Source: AMsMyM5iqTn0JiWuPyYF+ArhsuAQdoP0+FUNeulzs4XTkBmK6csGrqZ0zEZNaXySRPU5rceoVtrAog==
X-Received: by 2002:a6b:ba8a:0:b0:6d3:c907:63c3 with SMTP id k132-20020a6bba8a000000b006d3c90763c3mr1750723iof.15.1667326740519;
        Tue, 01 Nov 2022 11:19:00 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bg3-20020a0566383c4300b00375217ea9b6sm4108469jab.45.2022.11.01.11.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 11:18:59 -0700 (PDT)
Message-ID: <37138d05-c2b2-a106-416c-6be134d94046@kernel.dk>
Date:   Tue, 1 Nov 2022 12:18:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/4] blk-mq: improve error handling in
 blk_mq_alloc_rq_map()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <992db53bdeaba35d37de3784fe6f80879c9bbb35.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173401.GA20690@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221101173401.GA20690@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 11:34 AM, Christoph Hellwig wrote:
>>  	if (!tags)
>> -		return NULL;
>> +		goto err_out;
> 
> Using a label just for the direct error return here is a bit silly.

Plus that's not idiomatic code for cleanup, just keep the NULL
return if there's no cleanup to be done.

-- 
Jens Axboe


