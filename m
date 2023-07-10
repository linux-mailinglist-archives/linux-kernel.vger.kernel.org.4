Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82774D783
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjGJN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGJN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:29:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21EEB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:29:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9924ac01f98so601126266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688995758; x=1691587758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9UOUiiYpLeZoevckgJr9J8JUa+Ud+RYHSYC0luWiKI=;
        b=HsToygUrUgn71pI6VeP1OcdkLE6ca9RRwF2heZdv0NXu/F+Y1oixsKbUsOxDwAt7LR
         a3Lb2p2FX0cArsgRKux2NdWODDlLx4wjpsYNuf10nxQTYKWUnGfHl5P+aA4EzKXsWuhF
         rVndwS6EuI0TGNOgKt4QfljrCK7/OKpMJbHco6Jj0cDQb/XJffUhZ3orhlnasES5Tnfi
         VWiSiqYIZ8FDxZocJusseaPlqrFJAfIlMkcAOKMat3w5idwjwCKJ26e54U5qa1FBDFsW
         CuUoyi3VChTosFiYulTl/yA6Sdx3N9wxXkbgC+xZEGq7UYsvFiNYQjWZo149I3PjOk/K
         sjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995758; x=1691587758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9UOUiiYpLeZoevckgJr9J8JUa+Ud+RYHSYC0luWiKI=;
        b=YID8pgwaupmzE6d9fCDzXwvzGlPfk4WqbvzOHMcQI9Gx2xvBUnrWQbAQFhlcNFVivk
         ExR/VYIHDCe5lJxe9AVxKn6g4ws1L51L7J7mKUKNUeglAmcmQTyBh7qM0vUgTG0faxTV
         3e7Opw0myS/1C6D33s+fgQ4Y0zpE4SOo6JCE8MufwyIzOdPNB0NHdxiDfJfKKYwPQFbt
         SWYty0X9/6mkouJVPIrsKk4PHSfYq4FGRYV44NxJMdIbRzwI2cI0xH+Saw1lBhW9rFMG
         +KKwCEc7RyWuubAQKMUytnvDm+gdy0ldVyIA7q+kqM5B2QzGGbqBXHTSFyZ4Ba8Ajtz4
         nbfw==
X-Gm-Message-State: ABy/qLb5unwlUoTqI6fBbnT9kVzutJPQAz85uRNMsg9o+8Q5Wmhzqp4g
        0pXF5CII9TJfO6HKJ/TYFmhVIQ==
X-Google-Smtp-Source: APBJJlFSkacruVQJMp7GdUScVpgieU1tXcsK8x/WfftHxSb5guRgl5MBGtWiAbIyLhTEqgBMmFPt6g==
X-Received: by 2002:a17:907:d30d:b0:965:6075:d100 with SMTP id vg13-20020a170907d30d00b009656075d100mr13915267ejc.39.1688995758132;
        Mon, 10 Jul 2023 06:29:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090608cc00b00982be08a9besm6163959eje.172.2023.07.10.06.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 06:29:17 -0700 (PDT)
Message-ID: <1ebfbbec-d5cf-c6ac-2cf1-eab970903500@linaro.org>
Date:   Mon, 10 Jul 2023 15:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629160132.768940-1-thierry.reding@gmail.com>
 <1fd1d5d7-7296-0e62-9f65-7347ac0f0500@linaro.org> <ZKwCYjKXtuDsOF9E@orome>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZKwCYjKXtuDsOF9E@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 15:06, Thierry Reding wrote:
> On Mon, Jul 10, 2023 at 12:10:43PM +0200, Krzysztof Kozlowski wrote:
>> On 29/06/2023 18:01, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
>>> interconnect support in Tegra234"), the PCI driver on Tegra194 and later
>>> requires an interconnect provider. However, a provider is currently only
>>> exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
>>> indefinitely.
>>>
>>> Fix this by adding a dummy implementation on Tegra194. This allows nodes
>>> to be provided to interconnect consumers, but doesn't do any bandwidth
>>> accounting or frequency scaling.
>>>
>>> Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")
>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> Applied with checkpatch warning. Please be sure you run checkpatch
>> before sending the patches.
> 
> Are you referring to the Reported-by/Closes complaint? 

Yes.

> I didn't include
> a URL here because this came from an internal test report and there's no
> corresponding public reference.

Ah, ok, apologies for pickiness then. :)

> 
> I suppose I could've left out the Reported-by altogether.

I think it is fine. Checkpatch warning is just advisory.


Best regards,
Krzysztof

