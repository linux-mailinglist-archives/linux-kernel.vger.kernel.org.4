Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15474A4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGFUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGFUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:14:22 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59F1BF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:14:20 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id HVMmqW6WO8cFBHVMmqGNyt; Thu, 06 Jul 2023 22:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688674459;
        bh=goTJCh2BuleVgu8hJNaBlgxPFcS6fDBL6v0oOW8Rpas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kaWHGjB1nftlx5hiWASp9S35FQy/7g7gZh1qa5VHSEcUyfZx2tCDAqZfPI86IU2Su
         SUIJ+BHF5JgDlBkDl6kA47sAHWs0/LknqKP0SHgVhipzovfSCq12fdFMx/w2aZN4MA
         /jaPBNDlAjDWPgnv+0/sZ5qK3kzAjY5YbaA4UTlEXz7wADyG6uUfxB15zk04OZxs1B
         n2NeGsNsBR9yZJh6rJ9q41jSyFUPIXEG0P3p+DeoYoSNxFn+Od6wmENQUZDICQm+3T
         6fcZsF4ygz6vkZ6YmzIECfK245eIL3Osm07BCi+L1nm6qWT7jcs0eBaumruz77BQNt
         LlsuxQAD8YAAw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Jul 2023 22:14:19 +0200
X-ME-IP: 86.243.2.178
Message-ID: <e83f6b8d-eb50-3fb7-1993-fcc03604c016@wanadoo.fr>
Date:   Thu, 6 Jul 2023 22:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] scsi: bnx2fc: Remove a duplicate assignment in two
 functions
Content-Language: fr
To:     Minjie Du <duminjie@vivo.com>, Markus.Elfring@web.de,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        "supporter:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laurence Oberman <loberman@redhat.com>
Cc:     opensource.kernel@vivo.com
References: <20230705115236.16571-1-duminjie@vivo.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230705115236.16571-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/07/2023 à 13:52, Minjie Du a écrit :
> Delete a duplicate statement from these function implementations.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   drivers/scsi/bnx2fc/bnx2fc_hwi.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
> index 776544385..0474fe88a 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
> @@ -1521,8 +1521,6 @@ void bnx2fc_init_seq_cleanup_task(struct bnx2fc_cmd *seq_clnp_req,
>   				FCOE_TCE_TX_WR_RX_RD_CONST_CLASS_TYPE_SHIFT;
>   	task->rxwr_txrd.const_ctx.init_flags = context_id <<
>   				FCOE_TCE_RX_WR_TX_RD_CONST_CID_SHIFT;
> -	task->rxwr_txrd.const_ctx.init_flags = context_id <<
> -				FCOE_TCE_RX_WR_TX_RD_CONST_CID_SHIFT;
>   
>   	task->txwr_rxrd.union_ctx.cleanup.ctx.cleaned_task_id = orig_xid;
>   
> @@ -1763,7 +1761,6 @@ void bnx2fc_init_task(struct bnx2fc_cmd *io_req,
>   				FCOE_TASK_DEV_TYPE_TAPE <<
>   				FCOE_TCE_TX_WR_RX_RD_CONST_DEV_TYPE_SHIFT;
>   		io_req->rec_retry = 0;
> -		io_req->rec_retry = 0;

Hi,

just a blind guess:
    io_req->srr_retry = 0;
            ~~~

?

>   	} else
>   		task->txwr_rxrd.const_ctx.init_flags |=
>   				FCOE_TASK_DEV_TYPE_DISK <<

