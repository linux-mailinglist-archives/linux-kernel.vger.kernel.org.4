Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038AF6F1267
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjD1HdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjD1HdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:33:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECBE26B9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:33:05 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id sIbGpc4gTOW4ksIbGpuCv5; Fri, 28 Apr 2023 09:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682667183;
        bh=7thGFqsXnUZKI/1GxZfW7o8p/ReedXSSfe8i9pCipgs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W/MU0nZsswz7tKo/OpfB9j7+U2zS8ZLcDusNlR+tmaYK5ToFBDm8l0kUCGc5BHcSy
         JU871dzu1Np1bK6lqhKwYmqZ10xHQwSEdihP+NfHIS9piV+AdIjDyvCeE/7a/Qf8EQ
         csSgwnWvGxESp9lXBU8bqEcEo1MJKOQ6nDzm+PDLjoZsQ+rcyIOIA39uyprJkLzPFP
         xY3MNgmGjHRpxoHINrU9/edpEhNzTZGiU9dWZ4xfxZway0HDMUeF6qPEV9Frg33NCp
         /2K8N2fABk5atlpUTIOi08clwPQF2lBPWWX7kbSGPMuXDnjHlSzXYBUmk7q/ZnTflJ
         xiFHA6Z2M22wA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Apr 2023 09:33:03 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c704568d-16d1-bbd8-2b59-1d719f2bcf8c@wanadoo.fr>
Date:   Fri, 28 Apr 2023 09:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/04/2023 à 01:12, Chaitanya Kulkarni a écrit :
> (+Keith, for host side)
>> ---
>> More aggressive grouping could be done to be more future proof, but the
>> way the struct nvmet_ns is written suggest that some fields should be
>> kept together. So keep grouping as-is.
>>
>>
> 
> you can send RFC and I'll be happy to take a look if it's going
> have any benefit, it will take some time though..
> 
> for host side :-
> 
> while you are at it, it might be useful to take a look at the structures
> that are accessed in the fast path on the host side ?

Ok, why not, but can you help identifying these structures or places 
considered as fast path?

CJ

> 
> unless there is some reason for not doing that ...
> 
> -ck
> 
> 

