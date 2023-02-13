Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8906942C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBMKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBMKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:22:51 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242281BEA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:22:49 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so8267031wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pH0ZPRW44cRqRjeRqfvW1keJmEULHDXfxjp1kWDi+Po=;
        b=HUe4mSG/R0kcHOxC+1DlC/XFExpQKx+bhdmCsoaAePZuiOPiyE7oULUn5W8no2xd3T
         RKCIbzU3rWbMynhG9utVoBiPS6vsHPHhQTnTkgUb63X86F+yZgJ3RWUD9VFcTSqnykuT
         dJXdDf7pgw+AK4hFUQqz4b0nAtHQo/hQa19+K09VJ36ZNicNZi8Qlfxb8PNO7Dm6R385
         UkXoelWq9t/d0i+VBExwaLNN62ZD3iGiiJ1KTtD/1L/79xCBDce4zsiBz3ZZQE9kcnr9
         C9g7ieckT8xMpCnbSklfzngtPbyyWWdi61zsWXZ8UB3F940zLzFGjq4M/mvRbdRjr5V4
         jROg==
X-Gm-Message-State: AO0yUKXnBeEB0d/9dKSQ8PKvs7yYrEFy9YNGuy39k8cee7IzoUQmjdQJ
        qdUuQbe0R4m40xdEaI2prC0=
X-Google-Smtp-Source: AK7set855zDTrzmCyVYGzn5OjOWDS/iJyZa3b6uAkBb7ZHmxAI2ur5qAxgInbrxDSjmXxU8eVdBl2w==
X-Received: by 2002:a05:600c:5108:b0:3db:35e3:baf6 with SMTP id o8-20020a05600c510800b003db35e3baf6mr22572396wms.4.1676283767754;
        Mon, 13 Feb 2023 02:22:47 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6850000000b002bfbda53b98sm10140041wrw.35.2023.02.13.02.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:22:47 -0800 (PST)
Message-ID: <fa0f909e-9d3c-ff0d-d887-a3ce838c0769@grimberg.me>
Date:   Mon, 13 Feb 2023 12:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Content-Language: en-US
To:     Ivan Rubinov <soltime@riseup.net>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <96afa026-e1a9-0ce5-d9ff-36f7e5c1a5b2@riseup.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <96afa026-e1a9-0ce5-d9ff-36f7e5c1a5b2@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> Date: Fri, 10 Feb 2023 14:59:41 +0300
> Subject: [PATCH] Add quirk for ADATA SX6000PNP

Is this referencing to a bugzilla or other?

> 
> Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> ---
>   drivers/nvme/host/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c734934c407c..c63443d531b3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
>       { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
>           .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                   NVME_QUIRK_DEALLOCATE_ZEROES, },
> +    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
> +        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | 
> NVME_QUIRK_BOGUS_NID, },
>       { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
>           .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                   NVME_QUIRK_DEALLOCATE_ZEROES, },
