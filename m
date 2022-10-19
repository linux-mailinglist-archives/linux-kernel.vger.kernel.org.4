Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9826045A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiJSMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJSMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:45:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25B1119F2;
        Wed, 19 Oct 2022 05:28:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j4so27885056lfk.0;
        Wed, 19 Oct 2022 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEslt1RuSXUcyMvZuWV2zoIP99mcfhq4IT43n7JtoN8=;
        b=CHDCVUQxhP5zedafe5Fy0AcTvPDy2APY6prls4+epl+l8eKvD/foanWlFtPyvPmIbk
         vyETXKgyJh32IvytlFx2z1FOFTA4UYbxs3vA9Lbs2XOSO6Wh7aNK+rntsIz70A6k852r
         j8Zs3AFWu4AFeAnu9RcvgtS5eaUHzubhG0BM7jVIFfYvdQpb+zYvZPysCvg4pJCUwCLc
         5jXHEMa02Uuoz28IKa1Aorlg2n5MffTr4vz0Y2sJtheV/s7NmP4OZiqekpuvZpF3rKZE
         31ePzg8TjiXRFMQRU1spjaDXC1LcHmJpxZuBH0BenmJ83v66XJxoSb8Pqq7JbglGgbz0
         gg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MEslt1RuSXUcyMvZuWV2zoIP99mcfhq4IT43n7JtoN8=;
        b=PzIo5ibXmqzh3VtOhcZ9M1R/Dde69Ebj2teHV+z0JtIv79zA+hn3vme0ec8/+GV1Il
         XM9cDINfJ++9TEK/TRh/G5GMS9XZ4D9Wz2KvVtgE5eZpWMg7Fd48qHN5PZVqpyqvkY/n
         0VgvBqoodlJMSHFdxwqnoaE00aabi320doX0I68/PWARx+TxRrLdE+U/78h1LyPocSH8
         svCzzscphAX7fzxzrk4eQWN564QwATf3vUAHM48jnu92LiPwT8UF+1rCnJHqXM/96f1i
         lqpYhGSCq0YhgjlXE+oGMk3g3IRvgUTJLt4aNxoyWF9tHPROQvrJQ6weIi0K7Q81PYnS
         9+qA==
X-Gm-Message-State: ACrzQf2wtYdwFE5LKlyrQn/6a/UE4znEtkAz65/xPw6wom3L9LWVTYV4
        //UTWC1axBjESZ/UHw6usqe5Krn2srI=
X-Google-Smtp-Source: AMsMyM4gLXcYIkULuHyL9C32E1bcJWwX7brePnpuiphaKMj+qGQE5gfjVZ/3+0hBVMaCfCSsbeCZPA==
X-Received: by 2002:a17:907:6e0e:b0:78e:1385:c06 with SMTP id sd14-20020a1709076e0e00b0078e13850c06mr6518840ejc.485.1666180397196;
        Wed, 19 Oct 2022 04:53:17 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id ey4-20020a0564022a0400b00459148fbb3csm10430043edb.86.2022.10.19.04.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 04:53:16 -0700 (PDT)
Message-ID: <c8d12dd0-7504-0198-dacb-b3723d82fc60@gmail.com>
Date:   Wed, 19 Oct 2022 13:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 2/2] mtd: core: set ROOT_DEV for partitions marked as root
 devices in DT
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20221019114855.31639-1-zajec5@gmail.com>
 <20221019115041.31805-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20221019115041.31805-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.2022 13:50, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This adds support for "linux,root-device" binding that is used to mark
> root device MTD partition. It's useful for devices using device tree
> that don't have bootloader passing root info in cmdline.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/mtd/mtdcore.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 07249af4f890..034b06aff660 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -28,6 +28,7 @@
>   #include <linux/leds.h>
>   #include <linux/debugfs.h>
>   #include <linux/nvmem-provider.h>
> +#include <linux/root_dev.h>
>   
>   #include <linux/mtd/mtd.h>
>   #include <linux/mtd/partitions.h>
> @@ -735,6 +736,12 @@ int add_mtd_device(struct mtd_info *mtd)
>   		not->add(mtd);
>   
>   	mutex_unlock(&mtd_table_mutex);
> +
> +	if (of_find_property(mtd_get_of_node(mtd), "linux,rootfs", NULL)) {

I forgot to re-do "format-patch" after "commit --amend".
s/linux,rootfs/linux,root-device/

I'll fix that in V2 after giving this patchset some time to review.


> +		pr_info("mtd: setting mtd%d (%s) as root device\n", mtd->index, mtd->name);
> +		ROOT_DEV = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
> +	}
> +
>   	/* We _know_ we aren't being removed, because
>   	   our caller is still holding us here. So none
>   	   of this try_ nonsense, and no bitching about it

