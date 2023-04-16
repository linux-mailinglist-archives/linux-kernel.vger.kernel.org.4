Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C76E392A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDPOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjDPOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B3B2D5B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B362D60DD3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0617BC433EF;
        Sun, 16 Apr 2023 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681654888;
        bh=jArUrVjOBK3lecBeZm/2KhzUx8jOfQnvVXBNfardV48=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GSC3RuE9wJQvxtZle+yhURnJRPTgo6vh1k1vhrLrTha/GeFkeixqXJkKDJ5b9sk+0
         Hz5fY+dpTcCXz4YosO9qAICOgtm7RXskrcMEDJq/fUAvlRqjhJ1xb38+G4Qt3EChX7
         Lue69w0bc5lo15wrI48kRI7tRnEsO1BHjpWHyLkhkqEEsjik4qREnwx66UrhPqUc9/
         Cl0tUPvcO4QUNQB5v6nz4yn7BahjzO0SwI61qQGxDqN46726X/elLVF/CZSvNjo31T
         5Y98HWmv4YxuPUraoP4SQazqI2g+HawaKlKZATJBB8ZYAdGQJz5S+mjFtSjpDZaedP
         hPRGVZG8IYaIQ==
Message-ID: <74b059d9-413a-7807-9c3b-b8cc119186b9@kernel.org>
Date:   Sun, 16 Apr 2023 22:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/8] erofs: move several xattr helpers into xattr.c
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
 <20230330082910.125374-2-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230330082910.125374-2-jefflexu@linux.alibaba.com>
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

On 2023/3/30 16:29, Jingbo Xu wrote:
> Move xattrblock_addr() and xattrblock_offset() helpers into xattr.c,
> as they are not used outside of xattr.c.
> 
> inlinexattr_header_size() has only one caller, and thus make it inlined
> into the caller directly.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
