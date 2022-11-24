Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6DB637D91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKXQVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:21:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E816F0E1;
        Thu, 24 Nov 2022 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FGjzuXAIl+wHDnB9X06Lj741Z1ohvCHZzEDHufjgoPA=; b=TdfHq33K0iHRvayUCiTchGcsns
        dQfP4CvpGuk/CioBXk1AvcvjsZKIR9oDbLWGmTqtFpddFjkzn3MFNF4PcC5eoFzmZJ1kRqTzqVtKd
        JzIN0cDJLD47KiZTybbsOGWD2ysOHOKZEJhy6VSWSL8JoDlNj/LWJc3pucDObBYSYW2nvphz7A1sM
        08Bqpeb9DePDC3PcLqU715jUKJAtHYeHToklPMDaWYBJknUQ5PNrkxtRgLNwvCyQ1L54Srj6Zyo1G
        5s5eqQ5MphEj0WnAEWaGgJzyR6zDnBrlNJeeJf6UC7MHQXmHwu5S9kjEMNuj6lIiVuJrzW3+71cG0
        ZMitPOWQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyEyn-00A3Ox-N0; Thu, 24 Nov 2022 16:21:37 +0000
Message-ID: <387ebede-048b-203c-ffe7-7f0ff2014d3c@infradead.org>
Date:   Thu, 24 Nov 2022 08:21:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi: megaraid_sas: fix some spelling mistakes in comment
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
References: <20221124092514.32032-1-yuzhe@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221124092514.32032-1-yuzhe@nfschina.com>
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

These changes all look good.
One small nit below:

On 11/24/22 01:25, Yu Zhe wrote:
> Fix typos in comment.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 6650f8c8e9b0..c53c29a0a018 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -80,7 +80,7 @@ static void megasas_fusion_crash_dump(struct megasas_instance *instance);
>   * @ocr_context:			If called from OCR context this will
>   *					be set to 1, else 0
>   *
> - * This function initates a chip reset followed by a wait for controller to
> + * This function initiates a chip reset followed by a wait for controller to
>   * transition to ready state.
>   * During this, driver will block all access to PCI config space from userspace
>   */
> @@ -334,7 +334,7 @@ megasas_fire_cmd_fusion(struct megasas_instance *instance,
>   *
>   * This function is only for fusion controllers.
>   * Update host can queue, if firmware downgrade max supported firmware commands.
> - * Firmware upgrade case will be skiped because underlying firmware has
> + * Firmware upgrade case will be skipped because underlying firmware has
>   * more resource than exposed to the OS.
>   *
>   */
> @@ -2588,7 +2588,7 @@ static void megasas_stream_detect(struct megasas_instance *instance,
>  			if ((io_info->ldStartBlock != current_sd->next_seq_lba)	&&
>  			    ((!io_info->isRead) || (!is_read_ahead)))
>  				/*
> -				 * Once the API availible we need to change this.
> +				 * Once the API available we need to change this.

				 * Once the API is available we need to change this.

>  				 * At this point we are not allowing any gap
>  				 */
>  				continue;
> @@ -4650,7 +4650,7 @@ megasas_issue_tm(struct megasas_instance *instance, u16 device_handle,
>  }
>  
>  /*
> - * megasas_fusion_smid_lookup : Look for fusion command correpspodning to SCSI
> + * megasas_fusion_smid_lookup : Look for fusion command corresponding to SCSI
>   * @instance: per adapter struct
>   *
>   * Return Non Zero index, if SMID found in outstanding commands

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
