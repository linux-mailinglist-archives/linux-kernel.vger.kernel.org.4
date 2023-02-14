Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC049696754
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjBNOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBNOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:51:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA1101
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3368061719
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC91C433D2;
        Tue, 14 Feb 2023 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386268;
        bh=Y94r2TscOLy/MxOKf0gUOIvXNThFe6Bsl7fFc+iHFvk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tLl68cg+GazPQfCYc3P5523RwC/doMFNOw1Jh2Z1/W4otRjhNahqRO6rQRAw6BDBa
         hfEsdRRhVBwqiq8Y5tn81QZV2C0OtjPkIuDUV95csz16oq+YrlzvU/h9l6yqbM7oFr
         0t1y67CZfucVCdwWxLYJLf7WJUm0+C7QhVZQw6vXyuNtNuHkd4L4pSSfObZ720QOuP
         tOb3PK4+Ony3udDANK99VMJ7PIwEnG0vw2r+2TJyQ29BCizZIKYRewHRfdGXJfuwIN
         6CO0wIeB6gGVHRZP+6ci5EIZqg0aqZTIBwdLNfO0Ths+hLu16ohm31bUblw2NoZo2S
         H9QEPYy4NgbbA==
Message-ID: <109243cc-6ebb-d76d-104c-6576b94fc4af@kernel.org>
Date:   Tue, 14 Feb 2023 22:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] erofs: remove unused EROFS_GET_BLOCKS_RAW flag
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
 <20230209024825.17335-2-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209024825.17335-2-jefflexu@linux.alibaba.com>
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

On 2023/2/9 10:48, Jingbo Xu wrote:
> For erofs_map_blocks() and erofs_map_blocks_flatmode(), the flags
> argument is always EROFS_GET_BLOCKS_RAW.  Thus remove the unused flags
> parameter for these two functions.
> 
> Besides EROFS_GET_BLOCKS_RAW is originally introduced for reading
> compressed (raw) data for compressed files.  However it's never used
> actually and let's remove it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
