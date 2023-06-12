Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5502072CBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjFLQjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbjFLQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:38:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B899171B;
        Mon, 12 Jun 2023 09:38:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3b5a5134dso11620075ad.2;
        Mon, 12 Jun 2023 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686587929; x=1689179929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cOOA0wV0diWZb0zSOKKshG2sxjapX4cPmdeh8wVoHCo=;
        b=NUT4qMQ1jr6s+x7d5YF7/jvJZ8C4lt0TU+QFamZL/ys/ECoccfCPTiBLsLurbBA+4z
         LFJKtS+CEkKXnr7JnBDHGOQ3IRvTloVxR8n6bxBmnHKjdFtEP0oMdBwOX2AQeTGpttQR
         3gTaSK9XhoqNZ9pMLUDrMEYBMOl27EMKxKOFM016FbRoOziLEcj+hBql687R4X1K9Zt5
         NF+FCC+0aIV3tHqekTBhXArS9ZAyxNY0NPdPHqY+OWG4M95v+0xCcDMsXxLhweO+Yhw0
         M1IlLN6cM3gDE8KQDupuO4iZSRyVqYGKsznS+bJrdvgPm7Q6NXY8BmP/8xTPBogFcWcA
         IWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587929; x=1689179929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOOA0wV0diWZb0zSOKKshG2sxjapX4cPmdeh8wVoHCo=;
        b=QvDVCRFTWXOfOoeifBGckaaCHYB3LdqG/FPX+cz5pRTBTUbiQU2pe0zmp9+ufkIPrb
         4fbQRzi/UsHvCtY0+hCOImeSc4EbyYRe+dNeLg5vM1nFK42rv0xha2D60MV7X/enmzlk
         BnYDI0DaQzlF9FDqBmQaAgZFthrcHt5nKEApm/2AoCF90HUws9yqMk1ASZsIhNI7dRWd
         Jhc3R0l3fSYB8c//z7sjUbybs58SrLotEFED/JqJvZSJieRML6mTJeeEA/gAQcJbAjxM
         BWu2OlowRo8qEzrjWkYTp6Z4yhJb9ZEFJQwKZEZ4z1Di7hqzMSCh9Pt8cq97ouKVTu0G
         ulaQ==
X-Gm-Message-State: AC+VfDznXnGthYL4VK4cPqaTgsOSjyrFUIK3XzbQlTfdyA/At65X/E9Z
        melf7zADH6PGmtvl5tI2C4I=
X-Google-Smtp-Source: ACHHUZ7KS1/zy/6C+8K7aw/uoAvhOn0EiQYUKQwltIclkn2JPdBIlix7H1t0RYc2LamTg/XYT/7Pig==
X-Received: by 2002:a17:902:6b45:b0:1a9:86ca:38cd with SMTP id g5-20020a1709026b4500b001a986ca38cdmr6882792plt.2.1686587929397;
        Mon, 12 Jun 2023 09:38:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b0f727bc44sm1529642pld.16.2023.06.12.09.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:38:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c55875f2-31e2-2dd8-c949-aaa6b06b62ee@roeck-us.net>
Date:   Mon, 12 Jun 2023 09:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [v1,1/1] watchdog: sp5100_tco: support Hygon FCH/SCH (Server
 Controller Hub)
Content-Language: en-US
To:     a345351830@gmail.com, 345351830@qq.com
Cc:     amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        zhijun.hu@advantech.com.cn,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612031907.796461-1-a345351830@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230612031907.796461-1-a345351830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/23 20:19, a345351830@gmail.com wrote:
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> Add PCI_VENDOR_ID_HYGON(Hygon vendor id [0x1d94]) in this driver
> 
> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sp5100_tco.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 14f8d8d90920..2bd3dc25cb03 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -96,7 +96,7 @@ static enum tco_reg_layout tco_reg_layout(struct pci_dev *dev)
>   	    sp5100_tco_pci->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>   	    sp5100_tco_pci->revision >= AMD_ZEN_SMBUS_PCI_REV) {
>   		return efch_mmio;
> -	} else if (dev->vendor == PCI_VENDOR_ID_AMD &&
> +	} else if ((dev->vendor == PCI_VENDOR_ID_AMD || dev->vendor == PCI_VENDOR_ID_HYGON) &&
>   	    ((dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
>   	     dev->revision >= 0x41) ||
>   	    (dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
> @@ -579,6 +579,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>   	  PCI_ANY_ID, },
>   	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
>   	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
>   	{ 0, },			/* End of list */
>   };
>   MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);

