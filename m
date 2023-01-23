Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31967799C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAWKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAWKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:52:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477046B1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:52:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o17-20020a05600c511100b003db021ef437so8204057wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf6IzpiJWgjJ8XBMtpelOXKyiBWR2D24WcuFGb1gZAE=;
        b=GlQ/yiKj9WQ0flHkW2fHsanVpC+Hem4dYMR79eUouO6vNaJrIOpzsZLC5O2/W1JW1R
         zX2IcYdHng+NyIddvZzen0zGg1zo+ZYCyMJeWd0iLUt5jDc9LtLbidsFsF2KL900HzT4
         wIHn885vLC5xLEi2NK4lKZDJnU+iU+qc2LXyG+aj7M+AcSv5wDq+NiSM4ne0s0AmG5qJ
         qo0lKVVjFy3dGZaFhg0E+qF903Oj220vWSS9maki1xTMfJgmNvV0AsX9W+NaUXXBmHYQ
         IeKheWQvNppCRDwx00kSWiS+G7+LApgte/BzEUsn2/HVacuDIMuJsSpRPBhihEaW+Z4s
         tdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf6IzpiJWgjJ8XBMtpelOXKyiBWR2D24WcuFGb1gZAE=;
        b=0l7sNNoSx86A7DA4MLgO5FG+AEYPA7JbF7DbQwZjSQzqZruX3uIMst+QSXWQIrqBbN
         eTO7FcLUSdVk7FNg8nw89bipx/ypWmSbIqXxbM2rUK6Hx30drV/MPXAVMAT/I39mwsSB
         DhhHUVT0RXGRHl9EZ8ESbES3pvwFSAFS5ISqyYMJ2Xpd0g+O96Lls1LU7GMfUGu6ekLd
         y1ob65G+/C6oWOE2qv5q4vlFiNlxpLcddhja1P5tCZHjBH7FCXrKaH0VNbmyBx8O+IQF
         pO679rwwEdHQYfg5blGe23GbzgqtWw6hOHwQUZSEpXF+yEBCyWeAbVm4AwXEvRD5ks06
         SnQg==
X-Gm-Message-State: AFqh2kqiTyngNVn02OKVJgiDdbDuy++ccpSkllvWyAOlkEliwYsBVaR6
        DFUDmwT2r80TWExDvDMUalcfPmlw7+bxz/nT
X-Google-Smtp-Source: AMrXdXvqdASlQuynG2I5qf1duw5CyxmiHlmIGbxP9uDal5pHcNeK8sS7LdFXWlaKWwSjzjs4PNWM0g==
X-Received: by 2002:a05:600c:1ca0:b0:3db:1ded:1769 with SMTP id k32-20020a05600c1ca000b003db1ded1769mr15551397wms.10.1674471132537;
        Mon, 23 Jan 2023 02:52:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003d99da8d30asm11192811wmo.46.2023.01.23.02.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 02:52:12 -0800 (PST)
Message-ID: <65e5d86b-ab79-9652-2f08-bdab6ba03f89@linaro.org>
Date:   Mon, 23 Jan 2023 11:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [GIT PULL] memory: drivers for v6.3
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20230122121129.28699-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122121129.28699-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 13:11, Krzysztof Kozlowski wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.3
> 
> for you to fetch changes up to 4fd1a0e496cb81e939c55143fc81c2be130099c4:
> 
>   Merge branch 'for-v6.3/renesas-rpc-if' into mem-ctrl-next (2023-01-22 13:05:21 +0100)

Please ignore this pull request. I'll send a corrected one in few minutes.

Best regards,
Krzysztof

