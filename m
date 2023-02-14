Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54D696748
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjBNOrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjBNOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:46:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCEF2A982
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B116B81DDF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35905C433EF;
        Tue, 14 Feb 2023 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386003;
        bh=smGI7DY9OWtQnV799tOhSSpYqiEykyh0bwRllXtyKjo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V0PCCwfrk6ia+7Q5OgirJHOLlV+G8xlqSjOdPXClZOXR8zdpkSduvciwO8wjDjsk7
         SzPDNAdl5Tl2Fnxa5+TjJbewNZv3nmqq6ukXc5DN4x7gb2vXxrO8iF0pyyx+uy0VDf
         EzuqcerqnIx+fR7l9HA1XQjWCqw3JUN33nn+kDfRoBCjhUPCmipSIoNkvMepAv5KfX
         5ucySfn2c693t5O5ndNlc0mLq5uq0y4sEO+mbWqv31g0mTeT4keXQ0CWUo+E71v68d
         P4HDVhTnAS6eRAaCI1tB9rqn9gFWEa1tWCFgyU9jSQ0GNWBQruDb/IHHX8/+oWHLWt
         ARLJh8fyI1TNQ==
Message-ID: <662e3a0b-e4ce-ab39-b4a7-665de3b4c7e6@kernel.org>
Date:   Tue, 14 Feb 2023 22:46:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] erofs: tidy up internal.h
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
 <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230204093040.97967-6-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/4 17:30, Gao Xiang wrote:
> Reorder internal.h code so that removing unneeded macros and more.
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

