Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F331A5F6097
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJFF0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJFF0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:26:46 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6337EFD6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:26:45 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id n12so884743wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 22:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dwwkExrLA8SdWGSJDWZivH0sxUpUk6pDIB+w+DtImE=;
        b=SYcapRtYuiLeGpzOVpuTgnQY66w50OA5L6qQD9f0p8nOo7AScBoayOuma3E7c+K6B8
         wBM2cj/4flES0PjUJMPnSgr95yYCpUmLUq6dEb/BA+wXriEvDl5GzGSEYyslGIO+KbGS
         nDG53ajWHoOXKdK4NEFtO5uL2qYEKnp0k0hbv/Lk8uXgqcmcxjpSI2OropAgEpSYuBA5
         O1boWQBoaAHEnERkk/oMHS2NiGmsXMFbOEUV66v3BwJg7CE3O1HsPS4nONRV6750iX/I
         Ya8iLEUbwXJ1MEZOI50NWjbVcwZxlDypr3tt8T44L8Vf4liCVuW9qL/DcbK9iZE6HGYl
         NDag==
X-Gm-Message-State: ACrzQf2dxxiitVfbZj9NOyTPr0f7ulP9jpzuSRhkiaAzgT3kV9wc3DYo
        68PFbtcV3SOLdXiCIeDIqQY=
X-Google-Smtp-Source: AMsMyM6y2/h2q5zi/YJUy2pgw0d9oKpiMybw1tdpLeOY5KkfLya9IBvNlZeBEArbrL3iq+0ZMxJA3A==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b1:faf7 with SMTP id f2-20020a5d64c2000000b0022e41b1faf7mr1657355wri.428.1665034003473;
        Wed, 05 Oct 2022 22:26:43 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m3-20020a056000008300b0022afcc11f65sm15880662wrx.47.2022.10.05.22.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 22:26:42 -0700 (PDT)
Message-ID: <ec9d6f4e-08fc-1518-3c72-6e5a24c11204@kernel.org>
Date:   Thu, 6 Oct 2022 07:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] tty: evh_bytechan: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <23f608ca57e7e19bc7060d3e563de383e0b2b337.1665033575.git.christophe.leroy@csgroup.eu>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <23f608ca57e7e19bc7060d3e563de383e0b2b337.1665033575.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 10. 22, 7:20, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/ehv_bytechan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
> index 19d32cb6af84..8595483f4697 100644
> --- a/drivers/tty/ehv_bytechan.c
> +++ b/drivers/tty/ehv_bytechan.c
> @@ -118,7 +118,7 @@ static int find_console_handle(void)
>   		return 0;
>   
>   	stdout_irq = irq_of_parse_and_map(np, 0);
> -	if (stdout_irq == NO_IRQ) {
> +	if (!stdout_irq) {
>   		pr_err("ehv-bc: no 'interrupts' property in %pOF node\n", np);
>   		return 0;
>   	}
> @@ -696,7 +696,7 @@ static int ehv_bc_tty_probe(struct platform_device *pdev)
>   
>   	bc->rx_irq = irq_of_parse_and_map(np, 0);
>   	bc->tx_irq = irq_of_parse_and_map(np, 1);
> -	if ((bc->rx_irq == NO_IRQ) || (bc->tx_irq == NO_IRQ)) {
> +	if (!bc->rx_irq || !bc->tx_irq) {
>   		dev_err(&pdev->dev, "no 'interrupts' property in %pOFn node\n",
>   			np);
>   		ret = -ENODEV;

-- 
js
suse labs

