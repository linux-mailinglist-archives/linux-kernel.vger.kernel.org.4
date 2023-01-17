Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9566DE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbjAQNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbjAQNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:12:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4A360A3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:12:44 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so23412592pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67VThcpI2x2PWH5UFNvSAgzY9u26UXk66nDlvm2jIEc=;
        b=PK2BVU4ZjH3qP7V1qf6i9aQ+cp6pMV6URQxbcsaTkO25a8xtIQDnCFqF3Yp6WrwnPu
         gj5A9r7vZ8ZlBhWeTiP/lRebm8yZsUfOZ1E+qESVWiRPeuVrqTSgieLXsfqtY5TyxP/x
         Dd2DzhJ+4z/3V+aGaZqyFzQ5Zq+XhTrORD4uAu4diCcDxDO8LNZQBwPPZZYmKqAEJgKD
         yVWpio+KgY6cjhoDxmx1d74z/VlUb9KfSTNtuDyxt0vsLB8vqUsehqOrHdhezGQLep2h
         he7CHReYmn+YhydZAmCnIKkHQqZzh8uoyG4CZ9kR80yml8EGNXT/et0zjCG+6ATf2N4Z
         lz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67VThcpI2x2PWH5UFNvSAgzY9u26UXk66nDlvm2jIEc=;
        b=DtkzHYOobNpn8x1ks06hBBGVuhPFFAOUomH4ZY5tal6aFxthDpAaGhGI3XhlaOVSNx
         itGFMR0335lLGdi7Ma7gGeX3UJxs+IPX/LtolOxrIyQSHUhDpLnznoxgHEmXgpP4XOQk
         SADIbrUGyylSxVbVuh87NqBLToVXMi9KCJ++l6W//eSP0UbnCHRR+pO6bVmCHBITpJMI
         y+fibIdHVSQpNlaYXtq2iNz7YLVcF7wZmN61XNGCaGMI2xmU672aL4NjqSGcGJ75o4IP
         Zo9YPiI8rBsxDmNUatlTYsbLkgrVU6in0OaoMhxv4yCwi1F60SDJrhB/VFddEIbQHqBW
         ALvw==
X-Gm-Message-State: AFqh2kqGLEvkKWZNV2/HUMQ9FrsjLHUbctkTbhMAzaPkbkASIzT9Qtpz
        dj5/YN/5Bd/hWXgdUott28cRMw==
X-Google-Smtp-Source: AMrXdXthY76wGuVwFDwuHjj4XXBHcX3l/xHiP+DG+xJUfB8VR1ait/AJdVXI771NbQe8NcUIlwxQXg==
X-Received: by 2002:aa7:9ad9:0:b0:582:4a5e:b1ec with SMTP id x25-20020aa79ad9000000b005824a5eb1ecmr819079pfp.2.1673961163760;
        Tue, 17 Jan 2023 05:12:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7956f000000b0058bacd6c4e8sm4689685pfq.207.2023.01.17.05.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 05:12:43 -0800 (PST)
Message-ID: <ae9a5f7e-7c1d-c791-a0f3-894b4d724699@kernel.dk>
Date:   Tue, 17 Jan 2023 06:12:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <Y74cXN4SP7FNtSl3@T590> <ca08f6b8-a491-3a7e-f576-833acdf2135b@kernel.dk>
 <87k01mmgwb.ffs@tglx>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87k01mmgwb.ffs@tglx>
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

On 1/16/23 12:13 PM, Thomas Gleixner wrote:
> Jens!
> 
> On Wed, Jan 11 2023 at 12:04, Jens Axboe wrote:
>> On 1/10/23 7:18 PM, Ming Lei wrote:
>>> Hello Thomas, Jens and guys,
>>
>> I took a look and it looks good to me, no immediate issues spotted.
> 
> Want me to take the blk-mq change through tip too or do you prefer to
> merge that into your tree?
> 
> If this goes through tip, I'd appreciate an Ack. If you want it through
> block, then I give you a tag with the irq parts for you to pull.

I think the risk of conflicts there is going to be very small, so
please just take it through the tip tree. You can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the series. Thanks!

-- 
Jens Axboe


