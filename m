Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4D672A34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjARVQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjARVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:16:45 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795E37543;
        Wed, 18 Jan 2023 13:16:44 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id y1so374241plb.2;
        Wed, 18 Jan 2023 13:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjsummV7518A+4FcdJk2/pYHPUTTMOOZZxC0gC0Y1Jo=;
        b=oDnHKnSmaxosdOGI8rnBTaqK7Qvzg1KPD+rQiqJrexqaLD+Je3aIQe3xn5QNBXjhKW
         DHLzIVXBn/kAMRU1z5fZqN9WiMSzxxcM2PMOSjmgmuNvzH6ekYIZVLeesRLnOg3ahJDE
         DILNo1Q2cjZ9ZpWsNs6RpMOxD+CKhxRrUdgvqPnv0b3xplVzp05tmC8ae+sfuRwalPP3
         ADlVWqEm0JqDxRzM4kWwRwjchmQsPbPe6Va2aunzGeAIP1+kJOi1y8zO87ZpVj8/lsEM
         /ddK6ocQ7Fbm0Mj3mTCMlaY+d0IPE8WnS9QBiYye3fo6iRLbb1NkyOfSAUAfac2ZDIBY
         QOtw==
X-Gm-Message-State: AFqh2krrx07zmk1EP1mCbw7NR+Lph7hwyvUgTZCLG5nXaA/mSaOiy9CK
        UY5b5Zrz3L94BKUDHGd/Qyw=
X-Google-Smtp-Source: AMrXdXtbrdnw+aYJeP5KSNkywGAs872/lpchih0psx1ivHb9yNa6lmnXblMOkpKgSDsL5S43w1nLaQ==
X-Received: by 2002:a17:902:aa48:b0:194:892b:8654 with SMTP id c8-20020a170902aa4800b00194892b8654mr8788300plr.17.1674076603915;
        Wed, 18 Jan 2023 13:16:43 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:22ae:3ae3:fde6:2308? ([2620:15c:211:201:22ae:3ae3:fde6:2308])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b001885041d7b8sm12609262plf.293.2023.01.18.13.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:16:43 -0800 (PST)
Message-ID: <377df20f-332e-4ec4-16ac-ca4359e0919d@acm.org>
Date:   Wed, 18 Jan 2023 13:16:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] include: ufs: Remove duplicate entry
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     avri.altman@wdc.com, martin.petersen@oracle.com
References: <CGME20230114022406epcas5p4963a02aee5acb201c5e3495b6cfd44fe@epcas5p4.samsung.com>
 <20230114022010.27088-1-alim.akhtar@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230114022010.27088-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 18:20, Alim Akhtar wrote:
> PA_GRANULARITY is duplicated, let's delete one of the entry.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>   include/ufs/unipro.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
> index 6c553f98fe57..dc9dd1d23f0f 100644
> --- a/include/ufs/unipro.h
> +++ b/include/ufs/unipro.h
> @@ -141,7 +141,6 @@
>   #define PA_SAVECONFIGTIME	0x15A4
>   #define PA_RXHSUNTERMCAP	0x15A5
>   #define PA_RXLSTERMCAP		0x15A6
> -#define PA_GRANULARITY		0x15AA
>   #define PA_HIBERN8TIME		0x15A7
>   #define PA_LOCALVERINFO		0x15A9
>   #define PA_GRANULARITY		0x15AA

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
