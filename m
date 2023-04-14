Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269536E2C78
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjDNWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNWgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:36:15 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E046F59C5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:36:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id dd8so7415556qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681511771; x=1684103771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUnJTVe353X7D+kk1qyBsl2qfE9bNXB0zqwKLC3dEcQ=;
        b=GY7MwPymVJ7DaG2xBowO1rpXTXaq+S7n4WuoAoaOVCTGNa/bi1nV2IFkY8mJuSAMbW
         i+X0DXrmgpgUMSON8MpVguPXIrwQEJua6HhNxUs9H1WyFSLgya1JcHTiVbJqx0svoz6W
         ZaG5yv5qgzA1MfNuOAn5m1o/X/27YLq9jTFeWI27tXvFZpS7nPesbNHyUNFMR0VGlTe5
         hjTu/LOor8WP8XbH6gmxNC2EY83INlYMVGdH3qe02uGKJnMQ3mT2DxPFGKD0nR5ygio1
         VQbNqqwWi9zB8DD1jDwl+j9P2QsmB+GPV0Bx/5jzwYR2YRRxDdFIyZE5kWYVxK5Pdetj
         N7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511771; x=1684103771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUnJTVe353X7D+kk1qyBsl2qfE9bNXB0zqwKLC3dEcQ=;
        b=VKy9bAwz83p1mmoql/RwGW6R/tOHeGJwP+QgnSDTRRNf+DG7EoNvOqXrFzKvKLWQM0
         JKV+JoaC6s3s4tE5CfM7do4nk/uqaJDqbcRgsAmnkoJYHNYLjRmOZW372S6Th52DhuzJ
         fgsQitCt0MXoLb9qszjRY8eG56Ng/RbgdPNOwiCKkMC30vxlI1F03tTMf64JDYOrzzwB
         +rXqGx53CrccZCh435HM3r2H8I4NRM2xX6h09NmzXmc7hRJQKki2L5Pucq067TftrbWV
         uF/gvmDjIIkQpoOQO+3asj4wus0l5TY5hIM+syb6DwjMxDn682NVKIObo/GxOBSNpHZM
         UVgw==
X-Gm-Message-State: AAQBX9cHm+e9MitrlLvyUNtPM00iTXkk/l5fqJNIoqbLzGXiO49NaaKD
        UilMWcs96/zci3aFc2pfCVM=
X-Google-Smtp-Source: AKy350bOTQyHeEN6YKpacGZ+oIIlEXaVh8Wxtpu4Y1VIM5LfLwYEx5cJX5nBMxjBCDrTn8V7oKbZrQ==
X-Received: by 2002:a05:6214:20a3:b0:5ef:565d:ae6a with SMTP id 3-20020a05621420a300b005ef565dae6amr5772073qvd.20.1681511770919;
        Fri, 14 Apr 2023 15:36:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r11-20020ac87eeb000000b003e38e2815a5sm1521104qtc.22.2023.04.14.15.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 15:36:10 -0700 (PDT)
Message-ID: <15abdf3e-1a01-a568-9089-625e771c9d53@gmail.com>
Date:   Fri, 14 Apr 2023 15:36:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/4] cacheinfo: Correctly fallback to using clidr_el1's
 information
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230414081453.244787-1-pierre.gondois@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230414081453.244787-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 01:14, Pierre Gondois wrote:
> v4:
> arch_topology: Remove early cacheinfo error message:
> - Only remove the error message if the error code is -ENOENT
> cacheinfo: Add use_arch[|_cache]_info field/function:
> - Use a static variable instead of a per-leaf 'use_arch_info'
> - Reformat the use_arch_cache_info() define
> 
> v3:
> cacheinfo: Check sib_leaf in cache_leaves_are_shared():
> - Reformulate commit message
> - Fix rebase issue and move '&&' condition which was in the last patch
>    to this patch.
> cacheinfo: Add use_arch[|_cache]_info field/function:
> - Put the function declaration in one line.
> arch_topology: Remove early cacheinfo error message:
> - New patch.
> 
> v2:
> cacheinfo: Check sib_leaf in cache_leaves_are_shared()
> - Reformulate commit message
> - Add 'Fixes: f16d1becf96f ("cacheinfo: Use cache identifiers [...]'
> cacheinfo: Check cache properties are present in DT
> - Use of_property_present()
> - Add 'Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>'
> cacheinfo: Add use_arch[|_cache]_info field/function:
> - Make use_arch_cache_info() a static inline function
> 
> The cache information can be extracted from either a Device
> Tree (DT), the PPTT ACPI table, or arch registers (clidr_el1
> for arm64).
> 
> When the DT is used but no cache properties are advertised,
> the current code doesn't correctly fallback to using arch information.
> 
> Correct this. Also use the assumption that L1 data/instruction caches
> are private and L2/higher caches are shared when the cache information
> is coming form clidr_el1.
> 
> As suggested by Alexandre, this serie should ideally go to 6.3 fixes.

FWIW:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian

