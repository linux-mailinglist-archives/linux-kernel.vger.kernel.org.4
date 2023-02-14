Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2897696751
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjBNOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBNOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:49:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44E3596
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740C2616DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29094C433EF;
        Tue, 14 Feb 2023 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386178;
        bh=Hd39Bbt/oIFR+/8DTIbIyGdhtSgpK09BMQP2qSeF5wE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DZJxfqNQQ/OoeSuk1eQEEjyH6Cqo2MBxfq0SV17uW6JhwUAtpzEfvOY91jGm792u4
         R14eKWCigrKsnflRNPtIRVaSTlw7zWLEcpI2A6Vu2dLfDp1FzvAVsJb3xYBjxvutFW
         9OnWoOxvq5SLJRfpOJW+7fOsdzGw2N84kOo6mortxsX0H1ksDQAk4zYpGjFZ2GcqRd
         WBnufsdYW1D6F321srKZcqRsMijQvQBYv7E1AKFvvawpFUj2x75FuGSs35lSfWLwFD
         Nhn886+35P5n/w9knYpy7OEgETvC9EDG1CDd6V5pD8kI/bDciuzSrsN4z5GptUGI8i
         mf9dtmLbhgDug==
Message-ID: <8d6471cf-75b1-14b2-7c4b-27c38dc0428b@kernel.org>
Date:   Tue, 14 Feb 2023 22:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] erofs: update print symbols for various flags in
 trace
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
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

On 2023/2/9 10:48, Jingbo Xu wrote:
> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
