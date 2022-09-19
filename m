Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC75BD4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiISSnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiISSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:43:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270E474D2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:43:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c11so482277wrp.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XXL755xKEDAaIr3RDQbYzg0dLX5U1WGFXrDCkU4fSpY=;
        b=J4wPiGC7ovl46qAq7l3sYYxHuoVAfzBgVQ3EGrQ/Y4UUYC9xm06X6ADhTHPLoNnzRV
         GMPM5UtiTcnDUp1qw6c7br5p4dsNKpOg4r/03b/IZBOtOlItu2YkUniSlPFfLgmK6G+Q
         P97NMIFPUOkAnZr3Ra2MP71O8u0t1itle7O0sH5cq2Q+YwUzrqvZhQVJnWGGFZs0UclL
         c1l+YsM/8WMDTBMdXp3voktas6vUgoCSUkfrvoLITW/GntgQB6sWuDpYHdeW0AWfiG/o
         8ZW8S4SnUSafjpqy/7gBS7KHVofu+ZsFeNOlCfFIZf1xjh/9oFFh8LqH7L0jh6tA+FsR
         tMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XXL755xKEDAaIr3RDQbYzg0dLX5U1WGFXrDCkU4fSpY=;
        b=Y6lF/EjaYhhzAHIYaJ2uBhenmgCEGfjLDMF3R14uhrADIOOBQXCKhS+MYBLvhh5OV/
         /zb8bMaOHu5UkDVTtpgsojfgCrM6SVCTqVsSMgkuTqqX0Tl/vUIhbtR4sP+PFjZr7/XM
         AsaGmPMbTFmhcuCnjttY3gZa29cU3YVYxj388fNQWPJOT2y7QBc4ScierpSBP+jgBusQ
         eKP053xLPt6gCmKzFMm4ETdWbTdEYvD80a9GAG8WbhkQSZalx7bubwUnNlclbxQKgekF
         EnFucT+37nRNpI4TMxb8nzvVvTXBIEWy8T/5w2y2NQwpnMVpm4xXAIMmL1F3pYO5dFxt
         7Wjw==
X-Gm-Message-State: ACrzQf0R0+1ED7UWBSi//qibWuXkN53ENvtVSpjQ3FVMwK3YS6DyvXuA
        TNcKkIVDh69fafWt6tX0HehZF3u55GsPyw==
X-Google-Smtp-Source: AMsMyM6pYWIPMktvaPsLH3jpYC7dKvRYqa7TuL4nvhCWs/913tf3IFdaraB368dR6D/NgTk8prVblg==
X-Received: by 2002:adf:ee86:0:b0:228:6fe1:371 with SMTP id b6-20020adfee86000000b002286fe10371mr11181771wro.684.1663613005942;
        Mon, 19 Sep 2022 11:43:25 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a10:9fb4:d689:f4a2:c991? (p200300c78f3e6a109fb4d689f4a2c991.dip0.t-ipconnect.de. [2003:c7:8f3e:6a10:9fb4:d689:f4a2:c991])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b003a844885f88sm14032089wmb.22.2022.09.19.11.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:43:25 -0700 (PDT)
Message-ID: <e56a77ac-7d63-e428-cc7d-4e512c5e7da8@gmail.com>
Date:   Mon, 19 Sep 2022 20:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] staging: rtl8192e: Removes blank line
Content-Language: en-US
To:     Aruna Hewapathirane <aruna.hewapathirane@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     f3sch.git@outlook.com, guozihua@huawei.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220919142726.9101-1-aruna.hewapathirane@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220919142726.9101-1-aruna.hewapathirane@gmail.com>
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

On 9/19/22 16:27, Aruna Hewapathirane wrote:
> This patch fixes checkpatch multiple
> blank line issue
> 
> Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_tx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index 933f347fc17e..ee7c1a5e93c6 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -895,7 +895,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
>   				tcb_desc->bTxDisableRateFallBack = 1;
>   			}
>   
> -
>   			tcb_desc->RATRIndex = 7;
>   			tcb_desc->bTxUseDriverAssingedRate = 1;
>   		} else {

Combine this one with the other patch.

Bye Philipp
