Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6766A5350
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjB1G7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjB1G7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:59:20 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F521A64C;
        Mon, 27 Feb 2023 22:58:51 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id r18so8616548wrx.1;
        Mon, 27 Feb 2023 22:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayvPpqIegArr0R2l9x+qh7I7UJDUnZK9Guk3caLM4Dk=;
        b=4ic3CmoSyVN9ZRPJrHtR9fzLVvM840/xDR5udbGfM2MwC3LG/bt8GVkHv2mjRf5qEt
         it/aikIHUQ11Crwzc/gZyVn+ppSiTXxQ3Z56zNUuKAUGEUNUntxVrn07Hb3+phha8HcB
         9bVWERHw6HaJ5mpJjirHJujMfgt31rLnLVQjhnHWMmSp7q/kX3jyQ7oc3TvFOWqI8JUn
         DJXWXbuOOoU3klMRpWqr7s//Cc2zHzJt8S4JidixAQhwZ6T+BlgiaNdJgdOrYixrl8u8
         Kcooew3cuIjBKoJGbFUn1Xq4N7ZlPGc3goFpW3y6T+4dVtowZwuU5gr7xfEuBYVvEKed
         P3sA==
X-Gm-Message-State: AO0yUKV8f9lT1dYXVCUkv1jcq3H4rUKzb9EvXkNosCjqoIV6axXTxHl/
        OTyOgVruL42RWnoIL6YX6QUopXKYuS0=
X-Google-Smtp-Source: AK7set/pkhWYzfYDqv+j9RR/uQGrxiBA3vL4Qx23vTgcgpWrAStnV/VuGmWDhj+EUtcQ7d5rWkMDkw==
X-Received: by 2002:adf:e642:0:b0:2c5:5870:b589 with SMTP id b2-20020adfe642000000b002c55870b589mr1487555wrn.14.1677567529887;
        Mon, 27 Feb 2023 22:58:49 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b002c57384dfe0sm8749348wrq.113.2023.02.27.22.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 22:58:49 -0800 (PST)
Message-ID: <7ad445d4-34b5-0973-1f4e-7413feabb206@kernel.org>
Date:   Tue, 28 Feb 2023 07:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230228062957.3150-1-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
In-Reply-To: <20230228062957.3150-1-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 02. 23, 7:29, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Parameter negotiation has been introduced with
> commit 92f1f0c3290d ("tty: n_gsm: add parameter negotiation support")
> 
> However, means to set individual parameters per DLCI are not yet
> implemented. Furthermore, it is currently not possible to keep a DLCI half
> open until the user application sets the right parameters for it. This is
> required to allow a user application to set its specific parameters before
> the underlying link is established. Otherwise, the link is opened and
> re-established right afterwards if the user application sets incompatible
> parameters. This may be an unexpected behavior for the peer.
> 
> Add parameter 'wait_config' to 'gsm_config' to support setups where the
> DLCI specific user application sets its specific parameters after open()
> and before the link gets fully established. Setting this to zero disables
> the user application specific DLCI configuration option.
> 
> Add the ioctls 'GSMIOC_GETCONF_DLCI' and 'GSMIOC_SETCONF_DLCI' for the
> ldisc and virtual ttys. This gets/sets the DLCI specific parameters and may
> trigger a reconnect of the DLCI if incompatible values have been set. Only
> the parameters for the DLCI associated with the virtual tty can be set or
> retrieved if called on these.
> 
> Add remark within the documentation to introduce the new ioctls.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
...
> @@ -2453,6 +2476,128 @@ static void gsm_kick_timer(struct timer_list *t)
>   		pr_info("%s TX queue stalled\n", __func__);
>   }
>   
> +/**
> + * gsm_dlci_copy_config_values	-	copy DLCI configuration
> + * @dlci: source DLCI
> + * @dc: configuration structure to fill
> + */
> +static void gsm_dlci_copy_config_values(struct gsm_dlci *dlci, struct gsm_dlci_config *dc)
> +{
> +	memset(dc, 0, sizeof(*dc));
> +	dc->channel = (u32)dlci->addr;
> +	dc->adaption = (u32)dlci->adaption;
> +	dc->mtu = (u32)dlci->mtu;
> +	dc->priority = (u32)dlci->prio;
> +	if (dlci->ftype == UIH)
> +		dc->i = 1;
> +	else
> +		dc->i = 2;
> +	dc->k = (u32)dlci->k;

Why all those casts?

> +}
> +
> +/**
> + * gsm_dlci_config	-	configure DLCI from configuration
> + * @dlci: DLCI to configure
> + * @dc: DLCI configuration
> + * @open: open DLCI after configuration?
> + */
> +static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, int open)
> +{
> +	struct gsm_mux *gsm;
> +	bool need_restart = false;
> +	bool need_open = false;
> +	unsigned int i;
> +
> +	/*
> +	 * Check that userspace doesn't put stuff in here to prevent breakages
> +	 * in the future.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(dc->reserved); i++)
> +		if (dc->reserved[i])
> +			return -EINVAL;
> +
> +	if (!dlci)
> +		return -EINVAL;
> +	gsm = dlci->gsm;
> +
> +	/* Stuff we don't support yet - I frame transport */
> +	if (dc->adaption != 1 && dc->adaption != 2)
> +		return -EOPNOTSUPP;
> +	if (dc->mtu > MAX_MTU || dc->mtu < MIN_MTU || (unsigned int)dc->mtu > gsm->mru)
> +		return -EINVAL;
> +	if (dc->priority >= 64)
> +		return -EINVAL;
> +	if (dc->i == 0 || dc->i > 2)  /* UIH and UI only */
> +		return -EINVAL;
> +	if (dc->k > 7)
> +		return -EINVAL;
> +
> +	/*
> +	 * See what is needed for reconfiguration
> +	 */
> +	/* Framing fields */
> +	if ((int)dc->adaption != dlci->adaption)
> +		need_restart = true;
> +	if ((unsigned int)dc->mtu != dlci->mtu)
> +		need_restart = true;
> +	if ((u8)dc->i != dlci->ftype)
> +		need_restart = true;
> +	/* Requires care */
> +	if ((u8)dc->priority != (u32)dlci->prio)
> +		need_restart = true;

And here.

> +
> +	if ((open && gsm->wait_config) || need_restart)
> +		need_open = true;
> +	if (dlci->state == DLCI_WAITING_CONFIG) {
> +		need_restart = false;
> +		need_open = true;
> +	}
> +
> +	/*
> +	 * Close down what is needed, restart and initiate the new
> +	 * configuration.
> +	 */
> +	if (need_restart) {
> +		gsm_dlci_begin_close(dlci);
> +		wait_event_interruptible(gsm->event, dlci->state == DLCI_CLOSED);
> +		if (signal_pending(current))
> +			return -EINTR;
> +	}
> +	/*
> +	 * Setup the new configuration values
> +	 */
> +	dlci->adaption = (int)dc->adaption;
> +
> +	if (dlci->mtu)

dc->mtu?

> +		dlci->mtu = (unsigned int)dc->mtu;
> +	else
> +		dlci->mtu = gsm->mtu;
> +
> +	if (dc->priority)
> +		dlci->prio = (u8)dc->priority;
> +	else
> +		dlci->prio = roundup(dlci->addr + 1, 8) - 1;
> +
> +	if (dc->i == 1)
> +		dlci->ftype = UIH;
> +	else if (dc->i == 2)
> +		dlci->ftype = UI;
> +
> +	if (dc->k)
> +		dlci->k = (u8)dc->k;
> +	else
> +		dlci->k = gsm->k;
> +
> +	if (need_open) {
> +		if (gsm->initiator)
> +			gsm_dlci_begin_open(dlci);
> +		else
> +			gsm_dlci_set_opening(dlci);
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    *	Allocate/Free DLCI channels
>    */

-- 
js
suse labs

