Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F505BD4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiISSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiISSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:41:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C51CFE5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:41:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g3so458680wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uWQ7T4ULEMkWHcrwgyebDb55aLd/F5un+PkfavEBgNw=;
        b=guvMAMckTLxvhxmZIhPWw9rBhESRliZmMc2RGO756G9++ih2HpHkrA4z4q0u8gvl/Z
         XnR58Z7K9lHlTo6gl5DWCCv6O3tHZ8Um3qTTU7vSmWWU6VzN8ZygtrkYCCdT5KoBf1Qn
         oMhKvLGiZjDUXWoqprcVhxLmI9isWF4PEIY1KIByoMjEQKuIXewXphPtZo2MoZEpWY2a
         O2dnKWDcIF7w5VZ5yJamFRwZCJ5jhfEkQDfIuMLM3cfd9LaF0yqzqIfJG/nbhraE07F3
         pzmzF2cABp+PK6tippaszX6vM8Ch1ux8EjeCrx2u3IVfkm3urr5MYQf3HYQ0TxAnvMLt
         kEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uWQ7T4ULEMkWHcrwgyebDb55aLd/F5un+PkfavEBgNw=;
        b=6nwd7FjBbLO2COHJh0JqBYZ2QWwGQn8/zkUwbcGCIPmid67zs1YhCU63wP+sjY8ML2
         KpT5tMICR5sCrR1JJEp/8MSr3nc/pYZqEtEkd0fYCWNLVktvV9WOjVuEZA1jYbjvTICZ
         VRYcyIQaUNyUZa5fUQxdmVIVSpzIsAKzsyh0vu1rzQGB+4lDEe5l6YhAsdh+3PZO1NsY
         KzzQIvJBijwkDeYF3cFaG3z8HdfJx3NYwAxbgyc50hy9pCw+PMHva/0lwbCzncNnAh+o
         c5pw7lc5AyUENOmpGg9HAq1EPJdt/KitCy2uMPf+4hLzy7gyAhykbkg7cONZwvy7iokI
         YIYQ==
X-Gm-Message-State: ACrzQf1a5RIXJHSc+pSGpqdmzD4jtLtIVaHuIzV6DeH6nGw6lluaRo+C
        wHWdVhDCIZ/cSy8Qscxa3IU=
X-Google-Smtp-Source: AMsMyM79krc+bAL3soEkCU5wkQR1+og3LJ5/D3GzQSod8bO8Kf1YgZSKuG+6y1fmnGSjRAuJ9zJYpA==
X-Received: by 2002:a5d:5687:0:b0:22a:89ca:404b with SMTP id f7-20020a5d5687000000b0022a89ca404bmr11938476wrv.53.1663612885303;
        Mon, 19 Sep 2022 11:41:25 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a10:9fb4:d689:f4a2:c991? (p200300c78f3e6a109fb4d689f4a2c991.dip0.t-ipconnect.de. [2003:c7:8f3e:6a10:9fb4:d689:f4a2:c991])
        by smtp.gmail.com with ESMTPSA id q5-20020a05600c2e4500b003b497138093sm13619973wmf.47.2022.09.19.11.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:41:24 -0700 (PDT)
Message-ID: <590b49c9-5940-c7e6-0a23-9a82cd06fe62@gmail.com>
Date:   Mon, 19 Sep 2022 20:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] staging: rtl8192e: removes blank line
Content-Language: en-US
To:     Aruna Hewapathirane <aruna.hewapathirane@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     f3sch.git@outlook.com, guozihua@huawei.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220919135812.8307-1-aruna.hewapathirane@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220919135812.8307-1-aruna.hewapathirane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 15:58, Aruna Hewapathirane wrote:
> This patch fixes a checkpatch CHECK issue
> CHECK: Please don't use multiple blank lines
> 
> Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_tx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index d5275319a486..f651947f6b44 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -920,7 +920,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
>   					tcb_desc->bTxDisableRateFallBack = 1;
>   				}
>   
> -
>   				tcb_desc->RATRIndex = 7;
>   				tcb_desc->bTxUseDriverAssingedRate = 1;
>   				tcb_desc->bdhcp = 1;

Please avoid the 2/2 in the subject. This is only for patch series.
Create a version 2 of this patch with change history.
Removing blank lines is OK but do this for the entire document.
Add the file name to the subject to make it more unique.

Bye Philipp
