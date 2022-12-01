Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93463EDA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiLAKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLAKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:25:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C8FC99F4D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:25:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA30D6E;
        Thu,  1 Dec 2022 02:25:29 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86CB03F67D;
        Thu,  1 Dec 2022 02:25:21 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:25:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH]mailbox/arm_scpi: Add to support Phytium FT2000/4 CPUs,
 show temperature of cpu.
Message-ID: <20221201102519.epkictlook3lzs4q@bogus>
References: <414EB9088FC46457+Y4hS8eOJa/XUQ8xR@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414EB9088FC46457+Y4hS8eOJa/XUQ8xR@TP-P15V>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:08:33PM +0800, Wang Honghui wrote:
> Add to support Phytium FT2000/4 CPUs, show temperature of cpu.
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>  drivers/firmware/arm_scpi.c       |   1 +
>  drivers/mailbox/Kconfig           |   6 +
>  drivers/mailbox/Makefile          |   2 +
>  drivers/mailbox/phytium_mailbox.c | 193 ++++++++++++++++++++++++++++++
>  4 files changed, 202 insertions(+)
>  create mode 100644 drivers/mailbox/phytium_mailbox.c
> 
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 435d0e2658a4..876eb2f9ff81 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -904,6 +904,7 @@ static const struct of_device_id shmem_of_match[] __maybe_unused = {
>  	{ .compatible = "amlogic,meson-axg-scp-shmem", },
>  	{ .compatible = "arm,juno-scp-shmem", },
>  	{ .compatible = "arm,scp-shmem", },
> +	{ .compatible = "phytium,ft2004-scpi-shmem", },


Where is the binding for this new compatible ?
And why do you need this ? Any particular reason why you can't use the
generic "arm,scp-shmem" ?

I don't see the need for this change. Please drop it.

--
Regards,
Sudeep
