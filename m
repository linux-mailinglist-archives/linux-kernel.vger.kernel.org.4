Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA862635A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiKKVGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:06:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C583BA8;
        Fri, 11 Nov 2022 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+vynhbCwRkbGMhiHBv11R6jjJpnHaAbZwLIQxZZtLpk=; b=ORz9IqPvlnqc0RVi+bJGkXiPXL
        HFUJhtslRgybimCcPnzbKmH31gCSyGqIaZEvsap++X5C6uzUB7M0jUq4KFZInoOqZc9yB+aJeaUIY
        QXYeiOB/2s6aipfYg7ObQQVNHiISPu96jVgOo64CVU5cJoVBksadVXk2BfQq3nfy/1/nslsQZRdeD
        xZL2awHuYnkAO5NGrCJoR0VYm6bEaOaHUaVezNTSknHIGRc3c442SLyyhQXGV8WhWoM+uDbZDtDTd
        OLRRizjjO/7eqoqlEIP5RPIbnTJCGZopJ5fCD/Tb4hxbdRtoQxe2lslVhhH8cp1kZ9s3+lGApUab9
        /JF4KckA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otbDX-0017Ce-77; Fri, 11 Nov 2022 21:05:39 +0000
Message-ID: <eea50fc5-8520-760a-7d41-0f362a6efe0c@infradead.org>
Date:   Fri, 11 Nov 2022 13:05:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] async_tx: Fix some kernel-doc warnings
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, dan.j.williams@intel.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111064441.2926-1-liubo03@inspur.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221111064441.2926-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/10/22 22:44, Bo Liu wrote:
> Fixes the following W=1 kernel build warning(s):
>   crypto/async_tx/async_tx.c:136: warning: cannot understand function prototype: 'enum submit_disposition '
>   crypto/async_tx/async_tx.c:264: warning: Function parameter or member 'tx' not described in 'async_tx_quiesce'
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  crypto/async_tx/async_tx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/crypto/async_tx/async_tx.c b/crypto/async_tx/async_tx.c
> index 9256934312d7..8840731cefbb 100644
> --- a/crypto/async_tx/async_tx.c
> +++ b/crypto/async_tx/async_tx.c
> @@ -33,7 +33,7 @@ static void __exit async_tx_exit(void)
>  module_init(async_tx_init);
>  module_exit(async_tx_exit);
>  
> -/**
> +/*

This change is not described and is not needed.

>   * __async_tx_find_channel - find a channel to carry out the operation or let
>   *	the transaction execute synchronously
>   * @submit: transaction dependency and submission modifiers
> @@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(__async_tx_find_channel);
>  #endif
>  
>  
> -/**
> +/*
>   * async_tx_channel_switch - queue an interrupt descriptor with a dependency
>   * 	pre-attached.

Same as above.

>   * @depend_tx: the operation that must finish before the new operation runs
> @@ -123,7 +123,7 @@ async_tx_channel_switch(struct dma_async_tx_descriptor *depend_tx,
>  }
>  
>  
> -/**
> +/*
>   * submit_disposition - flags for routing an incoming operation

Just change to
 * enum submit_disposition - flags for routing an incoming operation

i.e. insert 'enum.


>   * @ASYNC_TX_SUBMITTED: we were able to append the new operation under the lock
>   * @ASYNC_TX_CHANNEL_SWITCH: when the lock is dropped schedule a channel switch
> @@ -209,7 +209,7 @@ async_tx_submit(struct dma_chan *chan, struct dma_async_tx_descriptor *tx,
>  }
>  EXPORT_SYMBOL_GPL(async_tx_submit);
>  
> -/**
> +/*

Not described, not needed.

>   * async_trigger_callback - schedules the callback function to be run
>   * @submit: submission and completion parameters
>   *
> @@ -256,9 +256,9 @@ async_trigger_callback(struct async_submit_ctl *submit)
>  }
>  EXPORT_SYMBOL_GPL(async_trigger_callback);
>  
> -/**
> +/*
>   * async_tx_quiesce - ensure tx is complete and freeable upon return
> - * @tx - transaction to quiesce
> + * @*tx - transaction to quiesce

Just change to
 * @tx: transaction to quiesce

i.e. s/ -/:/

>   */
>  void async_tx_quiesce(struct dma_async_tx_descriptor **tx)
>  {

-- 
~Randy
