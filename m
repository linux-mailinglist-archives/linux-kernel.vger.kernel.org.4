Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC96488DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLITO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLITOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:14:45 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3126AF9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:14:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 82so4200220pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng1RhCjjgJxlAMj/eBzYgJZBujugnuk3KFNVzl7SR1k=;
        b=kuax1zp5PPVbbsMHx2tHlga+RouRPVqfrOzC/greEof/sWS5OJk0Sv8nj7QYJ6M1gw
         PilOoJMZHMiT3V1TlCMFSX5AqEQHr338xZVW7fusZymU0TB8wmrdz2g0B+9/zie+lK2Y
         xZ919NLbiquoq5tkuXvkIkwTk3EmbOMd7azOUmxGo3N3UhUNImEIYvuIXM3jsLhFOKYX
         yfXdJRomn9w8iKq1+t9WMJiOsB17O+m2k4qgHkccR701ksF+pS8cGxBlFbbK+EJZZS3H
         /ktTiZ6TjyU1i5JEdvtS31OUpfvAr99tfChC4CGMk2wV2iTaNziUlFOhGZjZ+VsgR56G
         xuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng1RhCjjgJxlAMj/eBzYgJZBujugnuk3KFNVzl7SR1k=;
        b=whjtcIBW9ffm8Jf3uF2qcyCbZgkCBmp29syNv7mig+lENp9H7W8u+MqLvgdAp1paEP
         P7sWGi/4rwhZoeTkOtZNI3L348HAvYm/mI+5CTuGuw0VYua4yYAJiCIvXz0S3l7WtwVJ
         C5WHB5gC+Ki+7zxX/Q1kMq9BvrAbW9/yvAquOzJEZw5Qhy7E6fkcpyt1tPVCw3hQeOG8
         vqrUrMIXknnPNdeQp9EO5ZyTpm9jZrAN+saC3J+P/8Pe4oG0Er3JKAfzTcfqUuVS76ea
         jcN52RHLrvS54v09RdL6h6eq84mCvSVcM7Tea+j1Yp4P4X3bMIbeLFsldsmKfMdc5OoQ
         kyYQ==
X-Gm-Message-State: ANoB5pn1jeZzP/zzOHRcCTL+zIT8PK3O/lbNUvjdG5IrLpGJR0JkDBye
        4+MgE7EfX66ltKhu+/UhI9nazg==
X-Google-Smtp-Source: AA0mqf5xdkWcge2HsPPTKQw/T0PiZ1TlDl+mmQnZvW92kI0eqJDFGtO9cNkOhYQvH9PMI4ZRWj9HkA==
X-Received: by 2002:aa7:8589:0:b0:56d:74bf:3265 with SMTP id w9-20020aa78589000000b0056d74bf3265mr5592710pfn.19.1670613280696;
        Fri, 09 Dec 2022 11:14:40 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id x3-20020a626303000000b00576ce9ed31csm1556787pfb.56.2022.12.09.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:14:40 -0800 (PST)
Date:   Fri, 09 Dec 2022 11:14:40 -0800 (PST)
X-Google-Original-Date: Fri, 09 Dec 2022 11:13:40 PST (-0800)
Subject:     Re: [PATCH v3 2/2] mailbox: mpfs: read the system controller's status
In-Reply-To: <20221123175652.327859-3-conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        jassisinghbrar@gmail.com, daire.mcnamara@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-33aa5a63-85de-4a94-a1d5-d4507a0f55c7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:56:52 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Some services explicitly return an error code in their response, but
> others rely on the system controller to set a status in its status
> register. The meaning of the bits varies based on what service is
> requested, so pass it back up to the driver that requested the service
> in the first place. The field in the message struct already existed, but
> was unused until now.
>
> If the system controller is busy, in which case we should never actually
> be in the interrupt handler, or if the service fails the mailbox itself
> should not be read. Callers should check the status before operating on
> the response.
>
> There's an existing, but unused, #define for the mailbox mask - but it
> was incorrect. It was doing a GENMASK_ULL(32, 16) which should've just
> been a GENMASK(31, 16), so fix that up and start using it.
>
> Fixes: 83d7b1560810 ("mbox: add polarfire soc system controller mailbox")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/mailbox/mailbox-mpfs.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
> index cfacb3f320a6..853901acaeec 100644
> --- a/drivers/mailbox/mailbox-mpfs.c
> +++ b/drivers/mailbox/mailbox-mpfs.c
> @@ -2,7 +2,7 @@
>  /*
>   * Microchip PolarFire SoC (MPFS) system controller/mailbox controller driver
>   *
> - * Copyright (c) 2020 Microchip Corporation. All rights reserved.
> + * Copyright (c) 2020-2022 Microchip Corporation. All rights reserved.
>   *
>   * Author: Conor Dooley <conor.dooley@microchip.com>
>   *
> @@ -56,7 +56,7 @@
>  #define SCB_STATUS_NOTIFY_MASK BIT(SCB_STATUS_NOTIFY)
>
>  #define SCB_STATUS_POS (16)
> -#define SCB_STATUS_MASK GENMASK_ULL(SCB_STATUS_POS + SCB_MASK_WIDTH, SCB_STATUS_POS)
> +#define SCB_STATUS_MASK GENMASK(SCB_STATUS_POS + SCB_MASK_WIDTH - 1, SCB_STATUS_POS)
>
>  struct mpfs_mbox {
>  	struct mbox_controller controller;
> @@ -130,13 +130,38 @@ static void mpfs_mbox_rx_data(struct mbox_chan *chan)
>  	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
>  	struct mpfs_mss_response *response = mbox->response;
>  	u16 num_words = ALIGN((response->resp_size), (4)) / 4U;
> -	u32 i;
> +	u32 i, status;
>
>  	if (!response->resp_msg) {
>  		dev_err(mbox->dev, "failed to assign memory for response %d\n", -ENOMEM);
>  		return;
>  	}
>
> +	/*
> +	 * The status is stored in bits 31:16 of the SERVICES_SR register.
> +	 * It is only valid when BUSY == 0.
> +	 * We should *never* get an interrupt while the controller is
> +	 * still in the busy state. If we do, something has gone badly
> +	 * wrong & the content of the mailbox would not be valid.
> +	 */
> +	if (mpfs_mbox_busy(mbox)) {
> +		dev_err(mbox->dev, "got an interrupt but system controller is busy\n");
> +		response->resp_status = 0xDEAD;
> +		return;
> +	}
> +
> +	status = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
> +
> +	/*
> +	 * If the status of the individual servers is non-zero, the service has
> +	 * failed. The contents of the mailbox at this point are not be valid,
> +	 * so don't bother reading them. Set the status so that the driver
> +	 * implementing the service can handle the result.
> +	 */
> +	response->resp_status = (status & SCB_STATUS_MASK) >> SCB_STATUS_POS;
> +	if (response->resp_status)
> +		return;
> +
>  	if (!mpfs_mbox_busy(mbox)) {
>  		for (i = 0; i < num_words; i++) {
>  			response->resp_msg[i] =

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

I'm assuming this is aimed at some other tree.
