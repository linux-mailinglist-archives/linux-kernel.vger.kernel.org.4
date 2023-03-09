Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120016B280C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjCIPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjCIPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:00:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF096A046
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:57:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso3799419wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678373846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcSAcUKERpimj8PFFDmVRfuOLaQLta93SnD5jOr/Zg8=;
        b=pqgljRMCE+BQVRPIY9J6v+fvfncls5I/K25hHOnXp7pzkJQd5bI7Ci+o7sg0MwkcJa
         +JsSU+suCedwjkL+ZGx/xAHn3dA1XQMTnSUQ8dShxteFM441EvQ6iogJWFBIV+XuOgN4
         4dbKFtx2rEsvZPIwF+ck0vnqqjxdy/dV33JmwymliR0i6qLw71Kt2OtQBZCNQ/myXQDf
         sRwH5pxmfKRbad6nKK6pbgee00aX2lN/RDzNqNWjFnps3cm82AJZ+nLWibKpjGP2W+jG
         dZ0KRZUfiddys0hHMDREIi78mAa3k2coQ1Dr7KYFVGygBcRB6XjRjAToUEafJm+0pHx8
         /+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcSAcUKERpimj8PFFDmVRfuOLaQLta93SnD5jOr/Zg8=;
        b=0JpM+B0cvSHtVycnVNs+WywuboxbhKKzJL2Shuzycdfb2caqxmypdwKyW8hsBGqNPi
         w3Tp83ndnb5WYqrP009i7mSzxlxd65bAciSeTCXBGha9roqVKV/qQBLGppbunhUfp5xL
         WlCZJ0AmkUACBH6yadnYHbBtryQ6JNV3h5GDA6D5EM6JnU2zTf+b8EZmuEAbKPeokbpX
         487wlCfziMJGvxH0lC///DtPN0dCXva8SbT5L87LhbXvXw/6KXZ5kdiA6whjGbfv8cc0
         +oPHb6JBCg1d7e0f9zRmKJKv19/paxSyjTsuQf5uP1Krjt74lDHx103Wmd41BGEe3Zi0
         euWw==
X-Gm-Message-State: AO0yUKUZvGlA34cPxEpgl1YOgz5Kzds48FunRE75mQLvErTxoF0jUnD+
        9MDNqzrrfYci2etzoUTZBzrKDA==
X-Google-Smtp-Source: AK7set8ak/WU5ZyG7fUciVCezPKcPTmpqMtiPFyBeHZUQLgVXQ2aqIiXmrRdqS1JG1UFna6N5KmgGA==
X-Received: by 2002:a05:600c:5008:b0:3df:e41f:8396 with SMTP id n8-20020a05600c500800b003dfe41f8396mr19069741wmr.37.1678373845894;
        Thu, 09 Mar 2023 06:57:25 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b003df7b40f99fsm141198wms.11.2023.03.09.06.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 06:57:25 -0800 (PST)
Message-ID: <58445cac-501a-c4b8-01a9-34b5c21ef6e0@linaro.org>
Date:   Thu, 9 Mar 2023 15:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] mips: ar71: include linux/gpio/driver.h
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308145303.826942-1-arnd@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230308145303.826942-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 15:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The change to remove the implicit gpio/driver.h include was done
> after fixing all the other users, but the ar7 file still needs
> the same change.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 21d9526d13b5 ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/mips/ar7/gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


