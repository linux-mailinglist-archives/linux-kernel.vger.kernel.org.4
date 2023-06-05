Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8971723023
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjFETsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjFETsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:48:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79232115
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:47:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33bea381adcso21026785ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994470; x=1688586470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fS4H1vmagi/9HGtKjLe9H44pep5EenWwrSTFDihg3Hw=;
        b=ZDJiIJ/ZiS1a0YRKlYQFROx8s/LH38+MySyoMrgxA9Ww4GsGFHanWxA5F5vHIS9vff
         1TXuh5HdMk57wDZbTLrjJXypkiQM9pFEjeDZ9HwcOdkGFUjNHQr4MMWjt39v2CxCx1pU
         SpfkMj2EYq9rUIT/XFnn7kJkjJ9RLnj0yyvKg491+USz3/3ShH/CVn46TnyCQR34C9CK
         6RpsznOJOHqytz8m9iNeQblC72xaUdbjlftuT8gg61m05F0fAP+A69qIm2aVDQ5hq4Yq
         7ZFNS2p0hVW0WhyObSmzbMadgbEC4NyYcXwmtCBdSWD564UzKy8KeQKKJTgldkii5RnV
         b9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994470; x=1688586470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fS4H1vmagi/9HGtKjLe9H44pep5EenWwrSTFDihg3Hw=;
        b=dQnwrzC2Yfli3rVHHkiwm9KJ5ClKZsRe6rN168NCbyKc4Gw/qo1aqxZVngbMBIokCG
         JLO99ucKdTd9JZLppg1nLa6atnltjbz05182XLn29LEEommxKCTcwxdkvQQ7a2gON8sO
         wROcAFG6/oSIwFKi9ZduNqYLoR3Buc2aETM/65Bw5Y4fyqfY1DR63Bh2L7RruqWf7fU6
         rX3K2tp1xddNnALx1L4RTQEW/6p25NnwCpER3KFX519k4mX1XY2sylVdanikL2bzWDEu
         ikFkmd3maDmRzl882AKZqYB7fIyvesGSANGZiZAHKk52tdBAAA7CkOnaL7BWn0By5iJo
         91fw==
X-Gm-Message-State: AC+VfDyovkY1Jj6h0fbhKYAnb/TVahhhtvwg4RFEPRJUHrAHTskLQneX
        exKiV12aSWdhzaxQSRYLoUOTMg==
X-Google-Smtp-Source: ACHHUZ52M/rbpY/BYLeE7U2Ul5H2e1qLHVs2OHOR+ZV048nfZ1FRMFqEHjtFilYA8VbAqkJQcbsTgA==
X-Received: by 2002:a92:dac5:0:b0:335:908b:8f5 with SMTP id o5-20020a92dac5000000b00335908b08f5mr78375ilq.10.1685994469772;
        Mon, 05 Jun 2023 12:47:49 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id g12-20020a92d7cc000000b0033d16a45a64sm2582554ilq.14.2023.06.05.12.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:47:49 -0700 (PDT)
Message-ID: <34e595df-021a-8544-2956-d492a07930cb@linaro.org>
Date:   Mon, 5 Jun 2023 14:47:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 06/24] gunyah: rsc_mgr: Add resource manager RPC core
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-7-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-7-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> The resource manager is a special virtual machine which is always
> running on a Gunyah system. It provides APIs for creating and destroying
> VMs, secure memory management, sharing/lending of memory between VMs,
> and setup of inter-VM communication. Calls to the resource manager are
> made via message queues.
> 
> This patch implements the basic probing and RPC mechanism to make those
> API calls. Request/response calls can be made with gh_rm_call.
> Drivers can also register to notifications pushed by RM via
> gh_rm_register_notifier
> 
> Specific API calls that resource manager supports will be implemented in
> subsequent patches.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have some comments below, but none is critical so whether or not you
address what I mention:

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/virt/Makefile          |   1 +
>   drivers/virt/gunyah/Makefile   |   4 +
>   drivers/virt/gunyah/rsc_mgr.c  | 702 +++++++++++++++++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h  |  16 +
>   include/linux/gunyah_rsc_mgr.h |  21 +
>   5 files changed, 744 insertions(+)
>   create mode 100644 drivers/virt/gunyah/Makefile
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>   create mode 100644 include/linux/gunyah_rsc_mgr.h
> 
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index e9aa6fc96fab..a5817e2d7d71 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)		+= acrn/
>   obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>   obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
> +obj-y				+= gunyah/
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> new file mode 100644
> index 000000000000..0f5aec834698
> --- /dev/null
> +++ b/drivers/virt/gunyah/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +gunyah-y += rsc_mgr.o
> +obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> new file mode 100644
> index 000000000000..88b5beb1ea51
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -0,0 +1,702 @@

. . .

> +/**
> + * struct gh_rm - private data for communicating w/Gunyah resource manager
> + * @dev: pointer to device

This points to the device structure for the RM platform device.
(Maybe that's clear...)

> + * @tx_ghrsc: message queue resource to TX to RM
> + * @rx_ghrsc: message queue resource to RX from RM
> + * @msgq: mailbox instance of TX/RX resources above
> + * @msgq_client: mailbox client of above msgq
> + * @active_rx_connection: ongoing gh_rm_connection for which we're receiving fragments
> + * @last_tx_ret: return value of last mailbox tx
> + * @call_xarray: xarray to allocate & lookup sequence IDs for Request/Response flows
> + * @next_seq: next ID to allocate (for xa_alloc_cyclic)
> + * @cache: cache for allocating Tx messages
> + * @send_lock: synchronization to allow only one request to be sent at a time
> + * @nh: notifier chain for clients interested in RM notification messages
> + */
> +struct gh_rm {
> +	struct device *dev;
> +	struct gh_resource tx_ghrsc;
> +	struct gh_resource rx_ghrsc;
> +	struct gh_msgq msgq;
> +	struct mbox_client msgq_client;
> +	struct gh_rm_connection *active_rx_connection;
> +	int last_tx_ret;
> +
> +	struct xarray call_xarray;
> +	u32 next_seq;
> +
> +	struct kmem_cache *cache;
> +	struct mutex send_lock;
> +	struct blocking_notifier_head nh;
> +};
> +
> +/**
> + * gh_rm_remap_error() - Remap Gunyah resource manager errors into a Linux error code
> + * @rm_error: "Standard" return value from Gunyah resource manager
> + */
> +static inline int gh_rm_remap_error(enum gh_rm_error rm_error)

I suggested something similar last time.  I you are operating
on an rm_error value, so I would call this gh_rm_error_remap().

> +{
> +	switch (rm_error) {
> +	case GH_RM_ERROR_OK:
> +		return 0;
> +	case GH_RM_ERROR_UNIMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case GH_RM_ERROR_NOMEM:
> +		return -ENOMEM;
> +	case GH_RM_ERROR_NORESOURCE:
> +		return -ENODEV;
> +	case GH_RM_ERROR_DENIED:
> +		return -EPERM;
> +	case GH_RM_ERROR_BUSY:
> +		return -EBUSY;
> +	case GH_RM_ERROR_INVALID:
> +	case GH_RM_ERROR_ARGUMENT_INVALID:
> +	case GH_RM_ERROR_HANDLE_INVALID:
> +	case GH_RM_ERROR_VALIDATE_FAILED:
> +	case GH_RM_ERROR_MAP_FAILED:
> +	case GH_RM_ERROR_MEM_INVALID:
> +	case GH_RM_ERROR_MEM_INUSE:
> +	case GH_RM_ERROR_MEM_RELEASED:
> +	case GH_RM_ERROR_VMID_INVALID:
> +	case GH_RM_ERROR_LOOKUP_FAILED:
> +	case GH_RM_ERROR_IRQ_INVALID:
> +	case GH_RM_ERROR_IRQ_INUSE:
> +	case GH_RM_ERROR_IRQ_RELEASED:
> +		return -EINVAL;
> +	default:
> +		return -EBADMSG;
> +	}
> +}

. . .

> +static void gh_rm_process_rply(struct gh_rm *rm, void *msg, size_t msg_size)
> +{
> +	struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
> +	struct gh_rm_connection *connection;
> +	u16 seq_id;
> +
> +	seq_id = le16_to_cpu(reply_hdr->hdr.seq);
> +	connection = xa_load(&rm->call_xarray, seq_id);
> +
> +	if (!connection || connection->msg_id != reply_hdr->hdr.msg_id)
> +		return;

Do either of the above conditions warrant reporting a warning if
it occurs?  Or are these expected to be possible--and if either
occur they're harmless if handled this way?

> +
> +	if (rm->active_rx_connection)
> +		gh_rm_abort_connection(rm);
> +
> +	if (gh_rm_init_connection_payload(connection, msg, sizeof(*reply_hdr), msg_size)) {
> +		dev_err(rm->dev, "Failed to alloc connection buffer for sequence %d\n", seq_id);
> +		/* Send connection complete and error the client. */
> +		connection->reply.ret = -ENOMEM;
> +		complete(&connection->reply.seq_done);
> +		return;
> +	}
> +
> +	connection->reply.rm_error = le32_to_cpu(reply_hdr->err_code);
> +	rm->active_rx_connection = connection;
> +}

. . .

