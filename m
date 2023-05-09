Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0F76FC824
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjEINlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEINl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E9AF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E10E631EB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F63C433EF;
        Tue,  9 May 2023 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683639687;
        bh=R7cToSUJhPLimXgiY5o29IKd+9R8oGu8VsdxVABf9ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTj6WY0BXcDV9ys7JEOJjBBwIi9uXroTPcTCRQxpHBKrxwpyloSetG5EVBWinhcuM
         cnt5/jRHD1+ai3KhQ8BTeFLc4oEtCn9u09Q6Gp84Z/mrXefSAzArR6fBEJnwPPVp89
         JXIu2A8aZur2TJn1fIr3WCxqU1Eaem/cjQ5u+Jdc8i8+cMBiLCxioPWEkkHgJ2M4pl
         fKQKVjmAsRihbL4ywFRojFtDKzuc4Ismv4QeuiHZ4lR1ZNgVR0eBNcRHQpArBu3JCb
         F9f2yoY8qNZqqkWXPYVi6Zz+ZLPAW+t1lx9wum47L5cnkMO7bVp29azsEc5Qjtok8L
         UgJKswNQl0EXA==
Date:   Tue, 9 May 2023 16:41:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: remove __skb_frag_set_page()
Message-ID: <20230509134123.GM38143@unreal>
References: <20230509114337.21005-1-linyunsheng@huawei.com>
 <20230509114337.21005-3-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509114337.21005-3-linyunsheng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 07:43:37PM +0800, Yunsheng Lin wrote:
> The remaining users calling __skb_frag_set_page() with
> page being NULL seems to be doing defensive programming,
> as shinfo->nr_frags is already decremented, so remove
> them.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> RFC: remove a local variable as pointed out by Simon.
> ---
>  drivers/net/ethernet/broadcom/bnx2.c      |  1 -
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c |  5 +----
>  include/linux/skbuff.h                    | 12 ------------
>  3 files changed, 1 insertion(+), 17 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
