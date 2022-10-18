Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC326033FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJRUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:33:04 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0B61D9F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:33:04 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h203so12803872iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oq6wgYQj/TBbdBfnpCFWn07F6umZaHlghKYwRrWRmt4=;
        b=EqTJRnGsNkvg2dFS+sNFuOhgwUsmc8Kc+ySOF5vKmzb++cK9xu0SI/WSoOnxWj9DDY
         AQCTsg7/WWB2fdAAcsRKk9E7/e9r430SWEmVheBWVMVzCUXGV0SjwpcLzCLJaVuwnUQG
         T+W5kul3qLFWUeKaxZdWxDXp4G6CgS7P9EHOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oq6wgYQj/TBbdBfnpCFWn07F6umZaHlghKYwRrWRmt4=;
        b=7swBWJLTQom53pLMYdZt6X/TUmFXEGpFBUc9j20CYT8t85lBoZsNHr7b9sgqE8FV2X
         f/22QRVZLS5SQH8w9w/cZPaMX9GnsdYHJeV9Q8jcC8mykr006OBRqX6lbivaXlD8qxvI
         p0cLwd7bi97nFQ8SYhzakcDAM8CfnpyQZ9G+Fgu7UlCNrYyN5qlyhcULGCM1gGy5NfCd
         UQ3ibzLEWZ6Jzybaw2O4JTQ7wrEcCN76p54uaq24mnKlo4tPY+jW1vDxucyRKBmj1zYn
         NSLDfcJvJKKoCvks2D/vmBvXTZEpkcGTI3hO5fXUS9NHm3SP3qZ11uZfKYM7VAXtWmF3
         3hZg==
X-Gm-Message-State: ACrzQf3mCRyf+KgiGoGNt4bwwmMYNHLW55RwDV0tz8cQFjAWPJZ+JIRX
        a4guMLTWuorv+ynmgqDHCEPhhw==
X-Google-Smtp-Source: AMsMyM6MWpgp6ZZSFCT/GDO+SiE1F11vXddR4Xv13Ha20gd1+QWO1R9E3YsfgUBa0m0odJngLxr8Cg==
X-Received: by 2002:a05:6638:2508:b0:363:c76e:babf with SMTP id v8-20020a056638250800b00363c76ebabfmr3226399jat.54.1666125183479;
        Tue, 18 Oct 2022 13:33:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g26-20020a02271a000000b003640f27d82esm1409640jaa.21.2022.10.18.13.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 13:33:03 -0700 (PDT)
Message-ID: <e07df85d-9b98-75b8-d773-1124278aeb2e@linuxfoundation.org>
Date:   Tue, 18 Oct 2022 14:33:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] power: cpupower: utils: Add malloc return value check
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, shuah@kernel.org
Cc:     trenn@suse.com, ray.huang@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221014042911.298308-1-kunyu@nfschina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221014042911.298308-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 22:29, Li kunyu wrote:
> Add the check and judgment statement of malloc return value.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   tools/power/cpupower/utils/helpers/misc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9547b29254a7..eafdbd6d760c 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -139,6 +139,8 @@ void print_online_cpus(void)
>   
>   	str_len = online_cpus->size * 5;
>   	online_cpus_str = (void *)malloc(sizeof(char) * str_len);
> +	if (unlikely(!online_cpus_str))
> +		return;

You don't need unlikely here.

>   
>   	if (!bitmask_isallclear(online_cpus)) {
>   		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
> @@ -157,6 +159,8 @@ void print_offline_cpus(void)
>   
>   	str_len = offline_cpus->size * 5;
>   	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
> +	if (unlikely(!offline_cpus_str))
> +		return;

You don't need unlikely here.

>   
>   	if (!bitmask_isallclear(offline_cpus)) {
>   		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);

thanks,
-- Shuah
