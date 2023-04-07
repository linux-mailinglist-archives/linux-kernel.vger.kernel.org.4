Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3006DB3F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDGTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:16:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606265BD;
        Fri,  7 Apr 2023 12:16:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lj25so10363416ejb.11;
        Fri, 07 Apr 2023 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680894980; x=1683486980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQANRCEJ/Wf9JpOF80HK0eIogvOrPbo6UURifCL0g24=;
        b=C3Kn4pKyWyKvJQ1+mG7HHtGx1I9vYqZjna/jAR+ywqMX6yTxkrH+x4cpDq8uCR+bFo
         HTv7o3v+PAhQ80bN/eM0VTlbogJvuFHIIL7ZO/u7iiUNBx0Es67PZwHD7w6Hd9dm1hO+
         gllQtUUNUrmw01AEnGfmVbU5lS4fqb2fixq2eSURqslkYACWSi7vOTJBjkWZCSQEGUn8
         ROtlZdM+IKuKspAcanaxSqiAEW+9t63HVKkNvJhoYf70x2aEldjPfeONVJnmJuzS55iG
         3g6NLUdbBhijYnn6LllkBvgxDVXMBKFWIrAgXFnsT7d64llfzV2RbjQp8AVeC5X69Fmc
         lLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680894980; x=1683486980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQANRCEJ/Wf9JpOF80HK0eIogvOrPbo6UURifCL0g24=;
        b=eh7JK949kKoFhjodYhxzFoBvQM2EZeCx+jecx7YzeHellOO4nojpZyu0jp+UNO1SpR
         gK8UVeK3c4zdofmHzLAUEjrSSeX0I9GmAC9/qYlXlGKkn3OSbgbSI710Yv4UFm6V5aJd
         Dd/dcWeKCXX2kJoClLD/CsCG0RhQW6D4/Rua4E448pDx/fnaiXjMK7cBYXzUgbRPjQ2Y
         jZLSbc7YXi+IBLNlmNdo50xCvdOBtpl91gwQxJiYWwoumdcMgmutAk94Dqu3nCHNTnim
         9AbypogO6wSn8xdYPMbrhXCKPhc8AusCdcrSggAi33Ij+iwYKrFz7n5f9KyAtzpLCIEa
         q7Ww==
X-Gm-Message-State: AAQBX9fKWI5l0jPl++vP2hhTP8Xbp+770sXxsV5Uq0oS5IMZ/pgg3in5
        l3P1htu1mMh1Q2pp1Ghvc/I=
X-Google-Smtp-Source: AKy350brGvWNZE9Z6cc+Yg8UrPiyUm/ehRms/g4gOXmYbR/f+jduS7NvLvGJ84GMtMJymRq47OLoww==
X-Received: by 2002:a17:906:ef90:b0:933:89a1:57e6 with SMTP id ze16-20020a170906ef9000b0093389a157e6mr460264ejb.26.1680894979725;
        Fri, 07 Apr 2023 12:16:19 -0700 (PDT)
Received: from [192.168.178.40] (ip5f5b4297.dynamic.kabel-deutschland.de. [95.91.66.151])
        by smtp.gmail.com with ESMTPSA id f12-20020a170906494c00b00926b944676esm2297501ejt.131.2023.04.07.12.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:16:19 -0700 (PDT)
Message-ID: <2170fe67-2e65-630b-22dc-a8f6d3f7966f@gmail.com>
Date:   Fri, 7 Apr 2023 21:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scsi: target: cxgbit: check skb dequeue result
To:     Denis Plotnikov <den-plotnikov@yandex-team.ru>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        varun@chelsio.com, nab@linux-iscsi.org, martin.petersen@oracle.com
References: <20230406150405.300909-1-den-plotnikov@yandex-team.ru>
Content-Language: en-US
From:   Bodo Stroesser <bostroesser@gmail.com>
In-Reply-To: <20230406150405.300909-1-den-plotnikov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.23 17:04, Denis Plotnikov wrote:
> On a couple of abort packet paths skb dequeuing may end up with
> returning NULL, which, in turn, may end up with further null
> pointer dereference.
> 
> Fix it by checking the return value of skb dequeuing.
> 
> Found by Linux Verification Center(linuxtesting.org) with SVACE.
> 
> Fixes: 9730ffcb8957 (cxgbit: add files for cxgbit.ko)
> Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> ---
>   drivers/target/iscsi/cxgbit/cxgbit_cm.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> index 518ded214e74..d43fd761c20a 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> @@ -669,6 +669,9 @@ static int cxgbit_send_abort_req(struct cxgbit_sock *csk)
>   		cxgbit_send_tx_flowc_wr(csk);
>   
>   	skb = __skb_dequeue(&csk->skbq);
> +	if (!skb)
> +		return 0;
> +
>   	cxgb_mk_abort_req(skb, len, csk->tid, csk->txq_idx,
>   			  csk->com.cdev, cxgbit_abort_arp_failure);
>   
> @@ -1769,9 +1772,10 @@ static void cxgbit_abort_req_rss(struct cxgbit_sock *csk, struct sk_buff *skb)
>   		cxgbit_send_tx_flowc_wr(csk);
>   
>   	rpl_skb = __skb_dequeue(&csk->skbq);
> -
> -	cxgb_mk_abort_rpl(rpl_skb, len, csk->tid, csk->txq_idx);
> -	cxgbit_ofld_send(csk->com.cdev, rpl_skb);
> +	if (!rpl_skb) {

Honestly I have no clue about cxgbit, but to avoid null pointer
dereference, shouldn't it be "if (rpl_skb) {"?

Bodo


> +		cxgb_mk_abort_rpl(rpl_skb, len, csk->tid, csk->txq_idx);
> +		cxgbit_ofld_send(csk->com.cdev, rpl_skb);
> +	}
>   
>   	if (wakeup_thread) {
>   		cxgbit_queue_rx_skb(csk, skb);
