Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B35F2438
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJBRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJBRMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:12:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75FD24BFE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 10:12:18 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id b23so5282795qtr.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=B/mpr1D/Cf3GeGpEFQtpc5ZgpgZceqs0dyEsitRKt+I=;
        b=hOXO3xdxbkJiV4wc688W9IZv7efI+O+BeU+g8BDPXWgCyi5d7AV1QVvcl2W8/+Max8
         AWrX2tTmgRXXc1DzdSCO2JvqgA15o1qPhcdT34TPLE8v8CGYyeHG0rt5sPHKLaDqMDTQ
         nugwHPSJYjigTMomz5JillqUVCDclZJz/hIzlLPInjHhYYO4ZBjX9DbcqO77mR9L9GY0
         P1DqKdMYTKF/0wGxBrROj+ZMJfFqSBGnwaU1JoP/eea5+l9Nf0n2k6gfAQ9CK5u46gML
         lG0y1uGcunrPXx2p4VXQY9Mgb3yprAqXFdz96YI2karTsl0rXVoKwwkERiv3o/6LR7mO
         4g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/mpr1D/Cf3GeGpEFQtpc5ZgpgZceqs0dyEsitRKt+I=;
        b=GtjnCzQUcEkT8hctYlnAXthcxtjG6JlagqS1Qi+2+HSNaImDDVlRAS3tA6ihutI8nC
         oeql1MORDuc857lzolSNKMhjwBJXE8MVonJ/Ovu1qWJRdRfhFHl+IxZjVZIOw2HN+CoP
         i/0hv5I115tHWwqMg43C/sSQaYOe0mb62XEn/Kx+T4TBkgNLg4U5mEEpe/gACHduIO9y
         YJq7b1EtkBfWI5BNTBiuYGRHIddSYhP7nzC5ZKA+OvtvPRb4lCLX1SjwPzUTW0b73Wme
         LpLAXLCFxqwSqipYqPs5kGEnwikuMCcD5OBWKbJgrLALh2GaJTccJ2kJif/IBMSmSG/m
         QoeA==
X-Gm-Message-State: ACrzQf20BMQM7w6Vp+pU/dQEHE/qNIqhNB4soRjkiRTEUddY9Ne+9f6W
        Do/TuLqfS9b6LR0+qhmmUT8=
X-Google-Smtp-Source: AMsMyM6ZT8UAIGZf1J/tY3BediOLwcIjnusNk+DV09LpJREyb/czMI4tS03iJFb7dUZLZ26cFw2wnQ==
X-Received: by 2002:a05:622a:1052:b0:35b:b6cb:48f6 with SMTP id f18-20020a05622a105200b0035bb6cb48f6mr13185374qte.190.1664730737873;
        Sun, 02 Oct 2022 10:12:17 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id q19-20020a37f713000000b006bba46e5eeasm8376870qkj.37.2022.10.02.10.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 10:12:17 -0700 (PDT)
Message-ID: <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
Date:   Sun, 2 Oct 2022 10:12:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, james.smart@broadcom.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221002001909.20070-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/2022 5:19 PM, Duoming Zhou wrote:
> The function lpfc_poll_timeout() is a timer handler that runs in an
> atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
> As a result, the sleep-in-atomic-context bug will happen. The processes
> is shown below:
> 
> lpfc_poll_timeout()
>   lpfc_sli_handle_fast_ring_event()
>    lpfc_sli_process_unsol_iocb()
>     lpfc_complete_unsol_iocb()
>      lpfc_nvme_unsol_ls_handler()
>       lpfc_nvme_handle_lsreq()
>        nvme_fc_rcv_ls_req()
>         kzalloc(sizeof(.., GFP_KERNEL) //may sleep
> 
> This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
> GFP_ATOMIC in order to mitigate the bug.
> 
> Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/nvme/host/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 127abaf9ba5..36698dfc8b3 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   	lsop = kzalloc(sizeof(*lsop) +
>   			sizeof(union nvmefc_ls_requests) +
>   			sizeof(union nvmefc_ls_responses),
> -			GFP_KERNEL);
> +			GFP_ATOMIC);
>   	if (!lsop) {
>   		dev_info(lport->dev,
>   			"RCV %s LS failed: No memory\n",

I would prefer this was fixed within lpfc rather than introducing atomic 
allocations (1st in either host or target transport).  It was introduced 
by lpfc change in irq handling style.

-- james


-- james

