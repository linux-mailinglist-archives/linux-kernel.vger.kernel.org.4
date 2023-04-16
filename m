Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1466E391A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDPOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDPOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9AB1986
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A25260CE8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F050FC433EF;
        Sun, 16 Apr 2023 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681654547;
        bh=IJ/KLvgNXsd9AoIh2GNOX1lbUJteynHZL0yqKS/lun0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L/sqBDQqAkrUPyAnQJoIWII4VDnPxMLUSQQlOKcv+osZ065YJy23uc/J0Gox8zUb4
         PGIwhClkBvY8TWbI+5oroRdZPEk8GUrlY9+nDeohWzvd85XvKfZXkQU6ns2ecyc2lj
         lnD09ZHiHeD2MJoxk38XfNvVEPwCVoWEFXdr8sE3ulHHXa70NSWkqLCxcWrWBI3nQM
         dBtw2L7YUHHiw5AQmqbZrY+mdHAYGeeQXKKVBp5zbpihfU+yXSjdOKqRBIEPCMs/kR
         himMtOmaIYfSkOGPUbl58Zr4wckxdBHSDfoEb24pdhCc7gstMwHexkRtS3hfCZOANs
         hBHGknVxUXdUA==
Message-ID: <a30999d4-bc1c-8b5b-d2b2-186c80bac4b6@kernel.org>
Date:   Sun, 16 Apr 2023 22:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] erofs: tidy up EROFS on-disk naming
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LMKL <linux-kernel@vger.kernel.org>
References: <20230329054935.78763-1-hsiangkao@linux.alibaba.com>
 <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230331063149.25611-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 14:31, Gao Xiang wrote:
>   - Get rid of all "vle" (variable-length extents) expressions
>     since they only expand overall name lengths unnecessarily;
>   - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
>   - Move on-disk directory definitions ahead of compression;
>   - Drop unused extended attribute definitions;
>   - Move inode ondisk union `i_u` out as `union erofs_inode_i_u`.
> 
> No actual logical change.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

