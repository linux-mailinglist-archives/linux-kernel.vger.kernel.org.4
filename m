Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD596F03B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbjD0Jw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0Jwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:52:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEFF92;
        Thu, 27 Apr 2023 02:52:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a682eee3baso61717235ad.0;
        Thu, 27 Apr 2023 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682589170; x=1685181170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gfS9zL9pATTv1kREOztKOoRXHTEBi6ELKiNPxXxGI+0=;
        b=LMmy8TPo5qZnNygwSY8DoDFxVGlxIWzJ+ElDtUQGiB05zf5ay+hMBIjeIh2jXKvG49
         w/6DUnSpvTE0xvE80l9BAlX183DCiCjiK/TmVmCIlkSQdmad34NTOqbXozfzmLBGCL24
         m8odkuGZhHHV6J2xBl63nDecxq3mz1nwFNlY6o51myeEp2/cvSbW5kz238735Rr+vz9a
         Z799iewxW/8Qtbz/PR/YKK88tZqNgOo3eZbuDFP2t9x0p6if+GInd5uJzoWk77kwaTGF
         FnRIeL4pBmBAvF8zFRsu8vAl9zPXFma3llUwNGnLOkjaVAJsM/v4xvE9OAUkj+KJlIrM
         lMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682589170; x=1685181170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfS9zL9pATTv1kREOztKOoRXHTEBi6ELKiNPxXxGI+0=;
        b=TOVifVtqfaCmTq+dth+NWdoNiP/M1Df4cM9P3zH0xc+C7ydFZPsKLj1pKNvOMRRa9A
         siZE/H+gl2TFVXRu2B/Qd6XDdvZD71isR0zStz8OSpq33+6qjuRRBylnq8+LDV4xITmQ
         AZdb7owlsV7xUagkMXiQCRqJR4hOfNvv7TCFzognGQ1lCdZ7gQRvJKxPLggBWNeIFEMF
         t2DdC8rzC184uVQobo9E5n/NEIC1PQpo5sWLJnBdGfToVOKmUe3ZXP1P7SdCUxe4264l
         8xOjlMGX6gPeeaazhMXuam/VUbN3SVKEFhOEKuMC4CDTpuvv8ZVGuZaDPUFn3YCSKN97
         6Elg==
X-Gm-Message-State: AC+VfDyD4BNXRdY4RwqUpf5cSsWVVFzh4JF+fPkI96+tTV4PW0MiouXa
        ebYWbxIi4wYRliJGOXyfePQ=
X-Google-Smtp-Source: ACHHUZ7kBq9LYS3yAot64ywR9A5gxganVwso7Dvgm6LUbt3XfC3FTfTXWw70KXj8ams7K5Bjel70qg==
X-Received: by 2002:a17:902:c94d:b0:1a9:6d25:b2d2 with SMTP id i13-20020a170902c94d00b001a96d25b2d2mr988803pla.67.1682589169887;
        Thu, 27 Apr 2023 02:52:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001a64c4023aesm11329065plj.36.2023.04.27.02.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 02:52:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <01069261-7e88-b4d1-c435-0298072ac699@roeck-us.net>
Date:   Thu, 27 Apr 2023 02:52:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] k10temp: Add pci ID for family 19, model 78h
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Richard gong <richard.gong@amd.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-3-mario.limonciello@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230427053338.16653-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 22:33, Mario Limonciello wrote:
> This enables k10temp to work on this system.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Acked-by: Guenter Roeck <linux@roeck-us.net>

in case someone wants to apply this patch together with the first patch
of the series. Otherwise I'll wait with applying it until after that
patch is available upstream.

Guenter

>   drivers/hwmon/k10temp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index ba2f6a4f8c16..7b177b9fbb09 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -507,6 +507,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
>   };

