Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D58A6640B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjAJMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjAJMll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:41:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D1E0BB;
        Tue, 10 Jan 2023 04:41:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gh17so28276997ejb.6;
        Tue, 10 Jan 2023 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C51649fpTl175M3ajSK92Mj6ei8+4GDKwYm0Na7tsdM=;
        b=gViHDhQoiQEX08lI6j47oLsVSgPEBcGTzmen+JV5Jj9yJszqDMqWd8O+/v60XjyzVh
         GBrFbpV9hpLopUWQlU+zLkLrNrn7DNzTmDWLs+Z1NKb1CKz1C2/kiHYSgcDBbg37QyWF
         by9akFqR4tr47B9lDSoZstuGd45bgxV1vSmW+OnBDGrMYYKiGDrFEmtS9NFbu5FzR4qr
         ApcEyy8JYNxlt+Bsyt/3dhJspkq49jtlXnqkGDeuVvi4ArUFQZPOyzm8nD+DQO/sKM68
         JCG5eQ9Zo5YVYJild1Ebga39ekEKEVyWN+g83KXAylu4C5byQ+gK60WM9CiQkUcORgYg
         Bn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C51649fpTl175M3ajSK92Mj6ei8+4GDKwYm0Na7tsdM=;
        b=2Bd2ErlqLbXGxX6Nfm/oUCgCFuT69CjoLFRjILhNHU3A6VcpcfoEW1cOfHcW/K6SCH
         pJVgSF9uedawxPs8b5IoO3WFaY9wy+PB1NX9JQI8pswi/JkqQrVDP6/7p3OfVjiRlsKf
         rwFrzkU5DNFzalx2ZZS1EjdrT6Y7kcpjAgzyoTnrG0L3Z8a8eT1YEmGw2/xQLAr/exGF
         1v4Mp1OnRupblN2QRWFBRqI6GuvVG0ZKuN8x8Drino/Q6QNXr6SrWOSfG1sQSMDMDEKS
         32CCIhY6chag5z4KADnPK+nqSHuVspFoBGeN/lVlca1fDnSftjYq5oD45XWZVoXN+otI
         s8OA==
X-Gm-Message-State: AFqh2kqYZ6jYg5p0XgFFERAaqGFoRZs0dlyT+did/QxYRAmVN/A7yiaF
        P86kvcAFeN4LHIkx36yywkdaMG8B8zs=
X-Google-Smtp-Source: AMrXdXu6gJ1+RoYG7OexNWuKf1JIFQzIEegg/FbztmCHINfYZwsWEmtp7YK//aEda/k2YVT/h4WG8A==
X-Received: by 2002:a17:907:cbc8:b0:7c1:ed:171c with SMTP id vk8-20020a170907cbc800b007c100ed171cmr66159532ejc.26.1673354498935;
        Tue, 10 Jan 2023 04:41:38 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm4811448ejx.169.2023.01.10.04.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:41:38 -0800 (PST)
Message-ID: <6b30d7ae-ea99-61ba-6d41-15d1a5de7729@gmail.com>
Date:   Tue, 10 Jan 2023 13:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 6/6] nvmem: u-boot-env: post process "ethaddr" env
 variable
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230110105425.13188-1-zajec5@gmail.com>
 <20230110105425.13188-6-zajec5@gmail.com>
 <c4cc5b274745fe9dcb83747e74879582@walle.cc>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <c4cc5b274745fe9dcb83747e74879582@walle.cc>
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

On 10.01.2023 13:19, Michael Walle wrote:
> Hi,
> 
> Am 2023-01-10 11:54, schrieb Rafał Miłecki:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot environment variables are stored in ASCII format so "ethaddr"
>> requires parsing into binary to make it work with Ethernet interfaces.
>>
>> This includes support for indexes to support #nvmem-cell-cells = <1>.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>  drivers/nvmem/layouts/Kconfig      |  1 +
>>  drivers/nvmem/layouts/u-boot-env.c | 24 ++++++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
>> index 8a38c514943a..566b4f25630d 100644
>> --- a/drivers/nvmem/layouts/Kconfig
>> +++ b/drivers/nvmem/layouts/Kconfig
>> @@ -23,6 +23,7 @@ config NVMEM_LAYOUT_ONIE_TLV
>>  config NVMEM_LAYOUT_U_BOOT_ENV
>>      bool "U-Boot environment variables support"
>>      select CRC32
>> +    select GENERIC_NET_UTILS
>>      help
>>        U-Boot stores its setup as environment variables. This driver adds
>>        support for verifying & exporting such data. It also exposes variables
>> diff --git a/drivers/nvmem/layouts/u-boot-env.c
>> b/drivers/nvmem/layouts/u-boot-env.c
>> index 95c314553952..63baeb18bd56 100644
>> --- a/drivers/nvmem/layouts/u-boot-env.c
>> +++ b/drivers/nvmem/layouts/u-boot-env.c
>> @@ -4,6 +4,8 @@
>>   */
>>
>>  #include <linux/crc32.h>
>> +#include <linux/etherdevice.h>
>> +#include <linux/if_ether.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>>  #include <linux/nvmem-consumer.h>
>> @@ -36,6 +38,26 @@ struct u_boot_env_image_broadcom {
>>      uint8_t data[];
>>  } __packed;
>>
>> +static int u_boot_env_read_post_process_ethaddr(void *context, const
>> char *id, int index,
>> +                        unsigned int offset, void *data, size_t *bytes)
>> +{
>> +    u8 mac[ETH_ALEN];
>> +
>> +    if (*bytes != 3 * ETH_ALEN - 1)
>> +        return -EINVAL;
>> +
>> +    if (!mac_pton(data, mac))
>> +        return -EINVAL;
>> +
>> +    if (index)
>> +        eth_addr_add(mac, index);
>> +
>> +    ether_addr_copy(data, mac);
>> +    *bytes = ETH_ALEN;
> 
> I don't know how to feel about this. This will only work if the new
> size is smaller than the old one. Can't we have a correct size in
> the first place? I.e. while adding the cells.

I didn't think about such solution. I like that idea. Will do.
