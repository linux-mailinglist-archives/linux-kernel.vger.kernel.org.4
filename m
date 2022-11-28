Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7B63B1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiK1TBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiK1TBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:01:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC727B2D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:00:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mv18so10451755pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvEJDQxAkm5Pcp5ay5EjtKj5MIU+4aSru9VkuAAqDpI=;
        b=ZIxVcpTUMb/D5eaOHDEpksfQ3kJ7ZSLXnpj/xXuk9U3DX0xoA2fCl9AbKfhZwZhspV
         fbCcGlev/4EIGojtU1A9K3yvnZdq0T/YLnigSVlZGNQ4cmCpsz54dTGsTSZnzhQQSh2F
         Cfpm/jc+vFpNjyQ+IZMGe+5QzeVLYaYHfv1vY5263b/JPmEuMWLMhThQSjKqNuWjbaqr
         st2WSkGe+KfyQYa85gs07HW4jJt3Qgj8hCQALJ5ZvFw66ttA8YfEsaKse0X+lJHhwT/n
         JbSc9Xv4dAC1AUM24H/pg1KhjbiUnHTiPpNuNxguOTpswj0T3okv4RQZv7mFYqAHY8sd
         vCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvEJDQxAkm5Pcp5ay5EjtKj5MIU+4aSru9VkuAAqDpI=;
        b=6FcZLejABtDMsAUFK+9VL1PIbaGKigo2UC3SHqRXK9BtZ/yE3J6T1fzhWLMGa3hpjv
         PmTjYAexzg1VmqDVk3rRZ1i4IkRdHaa36SmkVGnv3SU3XEg7+b2zeb7dkzKkzd9PCq4Y
         yuiiCpcMJ/iRG3RTXs0+nrV1zkD5F4kzBidMksRJzceMH2ZAD7UXwAyDbi1wig8m6691
         JHQtqAlPO2+riRd8xmboy+aVfPWA5uh+GPIVRHWFeXqWm8TFC7W4OXb9EvTmy6ysC6GB
         HuWDKXoItRV98eGTaDSRKILM9ltAD+ltcgWD7VksGuzHcZAbJYqWqF4rHUC/decghPHj
         s6yw==
X-Gm-Message-State: ANoB5pl99r/C+oRuoOTcJPbSNw2s2E86ut2P5tV3uuVtHibr+NA9oGx6
        BupU62dyMbD+MA+f2CtWVWiWRw==
X-Google-Smtp-Source: AA0mqf5Tp1M+FX2RI4vi6K/Uf4ycXTS0LenkHg91EgRKhSqajbSJM3Ugd/1SDVwIRupnNt7JPvregQ==
X-Received: by 2002:a17:902:7d97:b0:188:f87d:70d3 with SMTP id a23-20020a1709027d9700b00188f87d70d3mr32810098plm.43.1669662058117;
        Mon, 28 Nov 2022 11:00:58 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b001ef8ab65052sm7929766pjb.11.2022.11.28.11.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:00:56 -0800 (PST)
Message-ID: <f89e922c-16d5-0bcf-7e7e-096f42793a36@kernel.dk>
Date:   Mon, 28 Nov 2022 12:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
 <d08a0059-7c0b-d65f-d184-5b0cb75c08ed@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d08a0059-7c0b-d65f-d184-5b0cb75c08ed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 11:56 AM, Bart Van Assche wrote:
> On 11/27/22 19:30, Waiman Long wrote:
>> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
> 
> Has Jens' for-next branch perhaps been rebased? I see the following commit ID for that patch:
> 
> dae590a6c96c ("blk-cgroup: Flush stats at blkgs destruction path")

I don't know that sha is from, not from me. for-6.2/block has not been
rebased, for-next gets rebased whenever I need to do so as linux-next is
continually rebased anyway. But the sha for that commit would not change
as a result.

I don't even have that sha in my tree, so...

-- 
Jens Axboe


