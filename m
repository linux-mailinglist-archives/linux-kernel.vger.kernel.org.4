Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01C06AA0B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjCCUmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCCUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:42:44 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AD25B5DC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:42:43 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id y9so1452255ill.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677876162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyrM72Z2jRw6kq7m7VSw4pzq9PHD7tBUBxa1SWVu9e4=;
        b=GkOa0X+H4TEwHEGgFomKCxJcwnyXh9t8e1mw1QE/tXUy2+3PsHaMlJ1Rzb/0grbShy
         9WNIGAPs4lCU1Wp14AiE4CCopzp+qX2QLUnUUDcpQYC2xEJFMwkchO423Ng5Gc1fUgq4
         5No4AiVK5tDqZDoU5wzQpUCc0fmoMCdjN9Xy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677876162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyrM72Z2jRw6kq7m7VSw4pzq9PHD7tBUBxa1SWVu9e4=;
        b=cZX8jtmzu1HSFw/zJbNjsO9F3/wQZhupCuShj3EexpjaUSKk2WIe6gdDGYKwgc3NSj
         HztEtF5Q+eULiBDFfRi0xN9lQ13HzelQcjcGn/OHvYirGKNumRl1znhTj5MkfeS49TaG
         BGKRSTmnLc7sQtqR33A+8iwKK+vVQoOA9MwJ10on+c5JpO8MOvXZnxRIb0RInm4Tc6Ef
         NcE81BSYzYABgLwofn0Ke8baUQvaVIxeCl/y/K1DnW9v9irC7GlIdaF2QdHMTdwonaK0
         X20qn8/30DGetiswchoTlrXFB8FuW58mMhzF9ujVcPmwMoUGApWjIZd8rdivIbvETfnT
         YwQQ==
X-Gm-Message-State: AO0yUKWtaMxGGi53e0TfkWTSSLyln+kNWGDIXduIbpHUcd5ousIxSBvJ
        A285GqakcZGjjZNuT59euqfUTg==
X-Google-Smtp-Source: AK7set+yxi6/63FZ4KhGjkBs/pZftIEsVtHjqjrjK2hLkpNibmRgb4QlXf7NefrJh+o7sY6sSba+ZA==
X-Received: by 2002:a92:194c:0:b0:317:943c:2280 with SMTP id e12-20020a92194c000000b00317943c2280mr1485174ilm.0.1677876162583;
        Fri, 03 Mar 2023 12:42:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h27-20020a056638063b00b003c449a192cdsm978921jar.73.2023.03.03.12.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:42:41 -0800 (PST)
Message-ID: <5194a1be-73d1-bbc1-879f-bec8353663bc@linuxfoundation.org>
Date:   Fri, 3 Mar 2023 13:42:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] selftests: ir: add config file
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230221070301.1323044-1-anders.roxell@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230221070301.1323044-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 00:03, Anders Roxell wrote:
> Building and running the subsuite 'ir' of kselftest, shows the
> following issues:
>   ir_loopback: module rc-loopback is not found in /lib/modules/6.2.0-rc8-next-20230220 [SKIP]
> 

Why is this an issue? I am not saying this patch isn't necessary.
But the behavior above is valid behavior when config options
aren't enabled?

Perhaps the commit log could reflect that adding config file
with the right options allows the test to run as opposed to
describing a valid behavior is an issue.

> By creating a config file with RC_LOOPBACK=m, LIRC=y and a few
> IR_*DECODER=m in the selftests/ir/ directory the tests pass.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/ir/config | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 tools/testing/selftests/ir/config
> 
> diff --git a/tools/testing/selftests/ir/config b/tools/testing/selftests/ir/config
> new file mode 100644
> index 000000000000..a6031914fa3d
> --- /dev/null
> +++ b/tools/testing/selftests/ir/config
> @@ -0,0 +1,13 @@
> +CONFIG_LIRC=y
> +CONFIG_IR_IMON_DECODER=m
> +CONFIG_IR_JVC_DECODER=m
> +CONFIG_IR_MCE_KBD_DECODER=m
> +CONFIG_IR_NEC_DECODER=m
> +CONFIG_IR_RC5_DECODER=m
> +CONFIG_IR_RC6_DECODER=m
> +CONFIG_IR_RCMM_DECODER=m
> +CONFIG_IR_SANYO_DECODER=m
> +CONFIG_IR_SHARP_DECODER=m
> +CONFIG_IR_SONY_DECODER=m
> +CONFIG_IR_XMP_DECODER=m
> +CONFIG_RC_LOOPBACK=m

thanks,
-- Shuah
