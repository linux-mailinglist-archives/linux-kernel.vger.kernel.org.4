Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD196B1B51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCIGTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCIGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:19:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96F62FDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:19:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so2889536eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678342779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTSUJLkYwADUhDqJdsPSx+O0Bg0vs7LmomPrh+7nD5M=;
        b=zUNWW2NpATq4qfxVXdMtQ4RhOhtbz2rtTWM3WDoeIFhGvSz62hQRPHUnnJ7Wgrnj99
         qjNQOUEIl1w2hXHsW6OPjvMraUrfSJA5Edyi3BkPUmLdSiNE1HR9CgKRLPCHS3VJ56ur
         SFrW+XGBYJoP9rtmDjNP3VLPpKuEpwVhiEihXKSwz75GivwZns5wFsUqsc/ui9VYsrzx
         G7L8Vg2SHpzCyYiscOC43r4BdcZKhf1w7e6nfdDrXUBijv4aql6ZHCkKZLd8CJLWf1E1
         +68ybzcx2TAXMd4FSZf+pDcbL6EUnQ1ydrQ2Ou6pncjVKDdVaqO1TRvTnkSiCIQJ9Wcu
         cGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678342779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTSUJLkYwADUhDqJdsPSx+O0Bg0vs7LmomPrh+7nD5M=;
        b=uBetBI7RBax0MVGwnBBPqoTFQabC0YfoOeTuSKkLgy8ncqR2KrlnSneoPHh8WWhN8T
         SsJztHtNjALkJ0G3xRy+dQ5n5g411Mb1VNxzd2qaXJoCZt6HCPVuT3QBDVPKvf2H11Do
         1gsM2ZADbSXM0Z8Jec4EQ92fR9CiD8WoASWdH0Xr2CyLGMgxCtyJsWHUmiYbOoFUQH7O
         jde3QUHcBcyCfTwSGUBgNX7YWpWj0sCJSFGavJXa925zRDEX/YL1V53TDSLvCZtWoJRy
         KO4LFAeFB0APGxFkNbzs7vw5kl4DBjnd8pmHIz12kMNvUouNj70ChUXL1WIFmu+DwxFC
         TZJg==
X-Gm-Message-State: AO0yUKXDUZQXwGAojLOnlJ2HlE7M73lH7VBboJl1Z5exMZQ9hZn6cFLl
        IZRBbd5UYLR16MZqYtLwm9cFQQ==
X-Google-Smtp-Source: AK7set//dU0C0Fr1BBWmciFTYcPyUq6KoCEt2AQ2CfkYl1mZSM1YZTKYvB+dYe4GO320HryqYflVQA==
X-Received: by 2002:a05:6402:1208:b0:4ac:c81d:149e with SMTP id c8-20020a056402120800b004acc81d149emr17928538edw.40.1678342778974;
        Wed, 08 Mar 2023 22:19:38 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id w21-20020a50d795000000b004d8287c775fsm7097764edi.8.2023.03.08.22.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 22:19:38 -0800 (PST)
Message-ID: <b4e07fa9-16c3-917f-5820-8a0f2f215ea3@linaro.org>
Date:   Thu, 9 Mar 2023 07:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] memory: tegra: remove MODULE_LICENSE in non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20230308202117.426808-1-nick.alcock@oracle.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308202117.426808-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:21, Nick Alcock wrote:
> Since commit 8b41fc4454e3 ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> ---
>  drivers/memory/tegra/mc.c           | 1 -
>  drivers/memory/tegra/tegra186-emc.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> checkpatch-clean and fused together now.

This is v2, not v1. Version the patches, always.


Best regards,
Krzysztof

