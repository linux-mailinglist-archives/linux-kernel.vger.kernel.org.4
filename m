Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503466E557
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAQRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjAQRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:50:37 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BD4C0ED;
        Tue, 17 Jan 2023 09:39:42 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id b17so26783855pld.7;
        Tue, 17 Jan 2023 09:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Bl9DHBHJ8aVewkblTNTyqqFzHO/bksoIQSiFnCMsI=;
        b=oxp0XZe7dAeDBRhRR3sdS70e3NEZS7qFKpwi440rTpNa3i+BefYLDYSyTXSfmYkaN3
         HSbKpI21GPBxegLPP64PCT7bQcI7IWMjJudtw9Rjp4w67cLcGmsWJfpLG67OmJRQeSlt
         nxwHPhyUamvIPhh1VMYeLkd2YBvyZiODE+ud5gAfwzqPrJp7cbSkUZnfEId0gq7w7H+f
         sGwSm7azty8rpfQnwauyErEJWg48uPK8ksczOpjvlTR5lVQ/v40a8dNX+SO1eoCnV0Rk
         WsG7pavg9HMCwzSGv/rXvdayLBzZr+Bs6cwIf2+PSFwvnZsfecoRJr5kUbueX7MZUS63
         AIXA==
X-Gm-Message-State: AFqh2kqY07PEM1TE//tJ+VptcQjDxWIeHpprz/X4oya+IaSNNqqIEYQc
        jFbJnM4My7nwxLPhwbB6u4I=
X-Google-Smtp-Source: AMrXdXtH8e1aiVkRGfVOydjbOOyk4U68xnYWdn8ym5N+grRWQauq5PKf01E85tokrV6/bQURz1fPSQ==
X-Received: by 2002:a05:6a20:2d10:b0:b8:7389:2760 with SMTP id g16-20020a056a202d1000b000b873892760mr3841790pzl.44.1673977182028;
        Tue, 17 Jan 2023 09:39:42 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f632:d9f5:6cbb:17d0? ([2620:15c:211:201:f632:d9f5:6cbb:17d0])
        by smtp.gmail.com with ESMTPSA id p13-20020a65490d000000b0048f8efc53a6sm17589946pgs.80.2023.01.17.09.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:39:41 -0800 (PST)
Message-ID: <bc47c99a-8315-ab73-8ab2-a26674cadf95@acm.org>
Date:   Tue, 17 Jan 2023 09:39:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] qla2xxx: fix printk format string
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117170029.2387516-1-arnd@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230117170029.2387516-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 09:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Printing a size_t value that is the result of the sizeof() operator requires
> using the %z format string modifier to avoid a warning on 32-bit architectures:
> 
> drivers/scsi/qla2xxx/qla_mid.c: In function 'qla_create_buf_pool':
> drivers/scsi/qla2xxx/qla_mid.c:1094:51: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
>   1094 |                     "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
>        |                                                 ~~^       ~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                                                   |          |
>        |                                                   long int   unsigned int
>        |                                                 %d
> 
> Fixes: 82d8dfd2a238 ("scsi: qla2xxx: edif: Fix performance dip due to lock contention")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/qla2xxx/qla_mid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
> index c6ca39b8e23d..1483f6258f92 100644
> --- a/drivers/scsi/qla2xxx/qla_mid.c
> +++ b/drivers/scsi/qla2xxx/qla_mid.c
> @@ -1091,7 +1091,7 @@ int qla_create_buf_pool(struct scsi_qla_host *vha, struct qla_qpair *qp)
>   	qp->buf_pool.buf_map   = kcalloc(sz, sizeof(long), GFP_KERNEL);
>   	if (!qp->buf_pool.buf_map) {
>   		ql_log(ql_log_warn, vha, 0x0186,
> -		    "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
> +		    "Failed to allocate buf_map(%zd).\n", sz * sizeof(unsigned long));
>   		return -ENOMEM;
>   	}
>   	sz = qp->req->length * sizeof(void *);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
