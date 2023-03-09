Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBAB6B25BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCINpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCINpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:45:45 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14951DE1F8;
        Thu,  9 Mar 2023 05:45:39 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id da10so7222645edb.3;
        Thu, 09 Mar 2023 05:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369537;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTwP3RLCRbcGBgHOojwsL1bMygr8dn+g2IYURs1uRg8=;
        b=YsMgtqg2uPZVLqoF8PkzyqyNIwox0kFCybQIjbyhAbzWqlJbzx1BPoMd41ZqTVUjDl
         gEYjTyMjZ5mvMtSaGdNnDFthpFZlppoZOduDiF7Jt4340eO6Tsw04SogPj8YqQMUdqDZ
         leLVLodqZYPdpmTf1l29d4ICfLL6Jfry0c0Ux+vj8TPN55IChI+qADCTtzA8VnNXgRXR
         6LF88n4v3iDPJd9egOAOpBIXzkwIPCx8dmO0otSVUKcBqLCatDxMfO9CZBLNFU5G3xpF
         /mQ54AuqHct0sKWmCFe4hTk8uc5zdK2LTvK5o9grihjVpX+olbdzdhnMNb/I8NmqAYOP
         KFOQ==
X-Gm-Message-State: AO0yUKWTeksSKpNQdAVCWWyMio0g7aQMWKMQH/4o3s14AlLlJObMClPE
        jScuofDRWQ1auHCemnKxrrfQq5IoqmY=
X-Google-Smtp-Source: AK7set9hzV3X7Oq7gLEItu8pyiE0OVjA6C+K2GiL7RfDT248ZqK6tEdNxtcMNSplwIgl3FscKRAM3w==
X-Received: by 2002:a17:907:8a06:b0:889:ed81:dff7 with SMTP id sc6-20020a1709078a0600b00889ed81dff7mr27540244ejc.9.1678369537478;
        Thu, 09 Mar 2023 05:45:37 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id a25-20020a50c319000000b004af62273b66sm9593859edb.18.2023.03.09.05.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 05:45:37 -0800 (PST)
Message-ID: <b7e72552-d4ec-46f2-4f45-d8baec914ff1@kernel.org>
Date:   Thu, 9 Mar 2023 14:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] n_tty: Reindent if condition
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
 <20230309082035.14880-8-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230309082035.14880-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 23, 9:20, Ilpo Järvinen wrote:
> Align if condition to make it easier to read.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/n_tty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 0481e57077f1..1c9e5d2ea7de 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1176,7 +1176,7 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
>   
>   	ldata->num_overrun++;
>   	if (time_after(jiffies, ldata->overrun_time + HZ) ||
> -			time_after(ldata->overrun_time, jiffies)) {
> +	    time_after(ldata->overrun_time, jiffies)) {

Staring at this, what the second time_after() does in the first place?

>   		tty_warn(tty, "%d input overrun(s)\n", ldata->num_overrun);
>   		ldata->overrun_time = jiffies;
>   		ldata->num_overrun = 0;

-- 
js
suse labs

