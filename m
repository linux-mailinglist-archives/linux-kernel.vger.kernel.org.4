Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA472302C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjFETtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjFETs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:48:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4AE5D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:48:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77a103c5ebbso11194739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994480; x=1688586480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6zH+9Xd0L2jTwKGYq+vFLj3o1rkjfeZZQ50CrCjKh4=;
        b=lKiH6uLIpFImkDMiBZFmaPVn5w9ALw3PuWHNckVpTHlOyYPpgCuEDvCl8Y7FfbWWbe
         IsIyyZkXhboZJ3z1AEUH1h4mh9J8jJWOCGT32mo2vDYIVmUplEvDVdV605z8btVW/IYo
         CNcAWdn444IPzdk9pQNf30v+FZbMjcUrSNLdi/Nz/0uYvkyA/SGY1zBcbVmtcxVCGHr0
         XuM1jN70kiTxqXA0JWUXevrm4esRGNrzuvCdfILKs+CjUNpverjI1BfxlRSDD4YARGfW
         9hs/5R+xFNx8C2xpsR93Bas6RbgCVW/PPPLUUuO9O834Vam1vSaMmFKjlZ/MoagycplL
         yCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994480; x=1688586480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6zH+9Xd0L2jTwKGYq+vFLj3o1rkjfeZZQ50CrCjKh4=;
        b=iDGtO1xkOq+vg5rP7jBuDFx4onkf+T1N8EgNwCrwDRvypLztSkIhnI4vjbn49jigcX
         DDuDR9hsN7TY2SSJTBYEhptIznk1w2M1QoIiFIoqBLLEjlKdnoVj/Ojj9QEtmnfcZVCp
         coZsdJLsv4jDrq1SnRZrpoOeTs3Vqhv6bC4RRwOa5pmDd97merNxlp4/YckWgftoKNd/
         XcxspGXyhC4u57XfTjmS0aG3RuSu+dPecazohXR63nkaY1skBU/85RXf2g9v+RABHnqt
         oSSE4W/pvy0xgKSXVSY/lBjdVgIFYZjv5zWblJIQqPBlDZriLReCi7Db8jhdMiiVQniF
         94lA==
X-Gm-Message-State: AC+VfDxrZHgIB2WIXibqV70EVXiyFggGQBCUJ8B9Ukbsp6TpQzF4NOYZ
        3FYWPjB6EST972xBlfLMnf/2Cw==
X-Google-Smtp-Source: ACHHUZ4zIhiTXqg/NL168EHW0465pSuYIOB/5hvivBy1uG7YBfDJ+HGFxDDJzjjWUMZiApo63412Rg==
X-Received: by 2002:a6b:da05:0:b0:76c:c974:9da with SMTP id x5-20020a6bda05000000b0076cc97409damr96249iob.19.1685994479826;
        Mon, 05 Jun 2023 12:47:59 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id k25-20020a02c659000000b0041f5d9522fcsm855456jan.22.2023.06.05.12.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:47:59 -0700 (PDT)
Message-ID: <5374c703-f571-c646-dc12-bd4fba360e03@linaro.org>
Date:   Mon, 5 Jun 2023 14:47:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 08/24] gunyah: vm_mgr: Introduce basic VM Manager
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-9-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-9-quic_eberman@quicinc.com>
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
> Gunyah VM manager is a kernel moduel which exposes an interface to
> Gunyah userspace to load, run, and interact with other Gunyah virtual
> machines. The interface is a character device at /dev/gunyah.
> 
> Add a basic VM manager driver. Upcoming patches will add more ioctls
> into this driver.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have a couple of comments, but regardless of how you respond
to them:

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>   drivers/virt/gunyah/Makefile                  |  2 +-
>   drivers/virt/gunyah/rsc_mgr.c                 | 50 +++++++++-
>   drivers/virt/gunyah/vm_mgr.c                  | 93 +++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  | 20 ++++
>   include/uapi/linux/gunyah.h                   | 23 +++++
>   6 files changed, 187 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>   create mode 100644 include/uapi/linux/gunyah.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 176e8fc3f31b..396212e88f7d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -137,6 +137,7 @@ Code  Seq#    Include File                                           Comments
>   'F'   DD     video/sstfb.h                                           conflict!
>   'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
>   'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
> +'G'   00-0f  linux/gunyah.h                                          conflict!

The existing pattern throughout this file is to use capital A-F,
so I would follow that here.

Sort off related:  I prefer lower-case a-f in hexadecimal
numbers in code, and you use capitals (at least some of the
time).

>   'H'   00-7F  linux/hiddev.h                                          conflict!
>   'H'   00-0F  linux/hidraw.h                                          conflict!
>   'H'   01     linux/mei.h                                             conflict!
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 241bab357b86..e47e25895299 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -gunyah-y += rsc_mgr.o rsc_mgr_rpc.o
> +gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index 88b5beb1ea51..4f6f96bdcf3d 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -15,8 +15,10 @@
>   #include <linux/completion.h>
>   #include <linux/gunyah_rsc_mgr.h>
>   #include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
>   
>   #include "rsc_mgr.h"
> +#include "vm_mgr.h"
>   
>   #define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
>   #define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
> @@ -130,6 +132,7 @@ struct gh_rm_connection {
>    * @cache: cache for allocating Tx messages
>    * @send_lock: synchronization to allow only one request to be sent at a time
>    * @nh: notifier chain for clients interested in RM notification messages
> + * @miscdev: /dev/gunyah
>    */
>   struct gh_rm {
>   	struct device *dev;
> @@ -146,6 +149,8 @@ struct gh_rm {
>   	struct kmem_cache *cache;
>   	struct mutex send_lock;
>   	struct blocking_notifier_head nh;
> +
> +	struct miscdevice miscdev;
>   };
>   
>   /**
> @@ -581,6 +586,33 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
>   
> +struct device *gh_rm_get(struct gh_rm *rm)
> +{
> +	return get_device(rm->miscdev.this_device);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get);
> +
> +void gh_rm_put(struct gh_rm *rm)
> +{
> +	put_device(rm->miscdev.this_device);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_put);
> +
> +static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct miscdevice *miscdev = filp->private_data;
> +	struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
> +
> +	return gh_dev_vm_mgr_ioctl(rm, cmd, arg);
> +}
> +
> +static const struct file_operations gh_dev_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= gh_dev_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
>   static int gh_msgq_platform_probe_direction(struct platform_device *pdev, bool tx,
>   					    struct gh_resource *ghrsc)
>   {
> @@ -665,7 +697,22 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>   	rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>   	rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
>   
> -	return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
> +	ret = gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
> +	if (ret)
> +		goto err_cache;
> +
> +	rm->miscdev.name = "gunyah";
> +	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	rm->miscdev.fops = &gh_dev_fops;
> +
> +	ret = misc_register(&rm->miscdev);
> +	if (ret)
> +		goto err_msgq;
> +
> +	return 0;
> +err_msgq:
> +	mbox_free_channel(gh_msgq_chan(&rm->msgq));

I'm sure I've said this before.  I find it strange that you need
to call mbox_free_channel() here, when it's not obvious where the
client got bound to any mbox channel.  It seems like freeing the
channel should happen inside gh_msgq_remove().  But... perhaps
you previously explained to me why it's done this way.

> +	gh_msgq_remove(&rm->msgq);
>   err_cache:
>   	kmem_cache_destroy(rm->cache);
>   	return ret;
> @@ -675,6 +722,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   {
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
> +	misc_deregister(&rm->miscdev);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);

. . .

