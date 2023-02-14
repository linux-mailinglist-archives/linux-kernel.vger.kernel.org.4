Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9B696790
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjBNPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjBNPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:03:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE92917B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:03:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADAF0B81C9F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D0BC433EF;
        Tue, 14 Feb 2023 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386991;
        bh=QLQZyyz2dCE0X2QY3OFwV/Rc+966QInmCo2XHAK53SY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pemf4PCSWgePk+z/D5uD/EWjuniQPvddeiPT7hxTKuKbNYYrH6H2vAcwEdFacmipP
         IbfDF6DM8xrX88Z5Yhv5zeABiLpHc4X+wZPxfsWpLVSZJL0/Kgt/2WGpHrq6Ybxwl3
         IebWYIt6eLiv8mTsNwPGhQ1TAcOf+wVPcQmhTfW2u1AIzuJdtK/O7J3VI+beP6hRWJ
         +etTg17dbrv0ofAjZLEB3hT0xfomaIgW+EGXx9Y4SQIJLdots9FfOBqMQ3wQoQAU66
         A/RvUFVFYD1IPtTdZmnZR+mZZqf4YbSlPzzLBd3SYm6uPxKXWIWKrxia/eH0e9hBoQ
         Nl32ySXeMvwCA==
Message-ID: <9ed76b53-7d24-d49f-3c82-4530e9998ff5@kernel.org>
Date:   Tue, 14 Feb 2023 23:03:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/4] erofs: remove unused device mapping in meta
 routine
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20230209063913.46341-1-jefflexu@linux.alibaba.com>
 <20230209063913.46341-2-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209063913.46341-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/9 14:39, Jingbo Xu wrote:
> Currently metadata is always on bootstrap, and thus device mapping is
> not needed so far.  Remove the redundant device mapping in the meta
> routine.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

