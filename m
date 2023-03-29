Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44AC6CD097
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjC2DR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2DRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:17:23 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE81FDA;
        Tue, 28 Mar 2023 20:17:22 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so14752946pjl.4;
        Tue, 28 Mar 2023 20:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680059842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLjUKExRZYqRLUfr3tzAXkQagcsDKdjQLlBbO0Cmu08=;
        b=QS5p4YmlT/rPPgG4wdhKjv4+pu9pEDL//gOii7klYgTeB53St+CJCX0u4w6JtjZVF5
         mPHFbnqiR+R0DTPiRHSsuNTgFzGQYwMF0Y4uU2l4sna48RkbpHOfOmPwSxHZGPZGSJ/K
         B0rwnJw55tsRql+mBau1ulF803fhDp4NWiBEi7jNGNHjMy9e3grbz7JAX05kkHPoN45r
         o5ZGkyREAvZ0utKDxqEF0koztggfsisKc3d6KNFlWikqmZUASfrT1O9G+m+hUESj5gIq
         yjW9U6EWUJppSdhMlh1qgjF3K/OgKwRW9nxiaqnFoqyduaitlaEQVsrk78Ywlqv4F2vo
         eOLA==
X-Gm-Message-State: AAQBX9cZ/6H1gR7F9uHAASjDAAFZO17f0VkEKu/OIL+/0KqfkzJTbJHj
        4XHqtNXESz2jPEDRyNX6SvmnvCxynIQ=
X-Google-Smtp-Source: AKy350YzVZu7jRaQqedo3XXu6FnU0XGFplGppJjGk6e5le4T7qcgACa5GO7OfY6ejksf9kF5QL3ZAQ==
X-Received: by 2002:a17:903:3092:b0:19e:786f:4cac with SMTP id u18-20020a170903309200b0019e786f4cacmr14079031plc.53.1680059841938;
        Tue, 28 Mar 2023 20:17:21 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b00199023c688esm21853735plb.26.2023.03.28.20.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 20:17:21 -0700 (PDT)
Message-ID: <9266aa1b-2d63-43d5-f06e-5a228bc131be@acm.org>
Date:   Tue, 28 Mar 2023 20:17:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a module
 parameter
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
References: <20230328103000.10757-1-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230328103000.10757-1-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 03:29, Po-Wen Kao wrote:
> A dedicated queue for dev commands is not mandatory, hence let
> UFS_MCQ_NUM_DEV_CMD_QUEUES become module parameter `dev_cmd_queues`
> to allow sharing first hw queue for dev commands.

Which queue is selected for device management commands?

What is the impact of this change? If a device command is queued on a 
queue with multiple pending commands, does that mean that it can take 
long for the device command to reach the UFS device?

The answer to the above questions should be in the patch description. 
Please expand the patch description.

> +unsigned int dev_cmd_queues = 1;
> +module_param_cb(dev_cmd_queues, &dev_cmd_queue_count_ops, &dev_cmd_queues, 0644);
> +MODULE_PARM_DESC(dev_cmd_queues,
> +		 "Number of queues used for dev command. Default value is 1");

I prefer a solution that does not require any new kernel module 
parameters. That means either a dedicated device command queue for all 
host controllers or no dedicated device command queue for any host 
controller.

Thanks,

Bart.

