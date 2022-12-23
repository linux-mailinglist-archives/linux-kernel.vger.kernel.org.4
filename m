Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866C654F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLWKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:18:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEEA1BEAE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:18:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x11so6601926lfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRC804NMX4Ft7zElwiwbqtFM7vLNhKQd0+x9jqgtXVU=;
        b=etA0VGxOKwiDf0ID/nnsO2FOPTdemnS1pE1whMCSq3ZCeGBmgstZGp2VgEfy/qi6ar
         T0feRKhj7r19A1bkJjaGbRr/Li0H1iuxCaPYJ++DnJIOxVubTxanaVlcUOnxaa2Jyq+O
         BoQO+zctjPVflzH4a6aeDk5IRItyUbW7/NYOKzECzethsDhdEqmyvxtMIw9lJZou8N3t
         oBwlGlDieqZ53Qkirxz7jaSRJXMz7cWVpey485IAzHCEE9hIQc/e8KOED5rHH0R4lVtC
         JIg+TU9s8BECXDuwT8qFR0xU91hE/uRXs4A+Jkz7+C/4Ajx2OvXePJWtbEqZ6rKgn4vj
         7fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRC804NMX4Ft7zElwiwbqtFM7vLNhKQd0+x9jqgtXVU=;
        b=QH6o57DyhyrSPgvhoQDJ1YJv6sNsXkcW7PfxzuEUyUL13DvHIHtqrRUEiF+EYYFIF5
         GMHr9uA6mdVThizwbJ3+IiAzihfS/FNuEpGg+PLuNI/3RvwZgZ9R7fubTCrf+hEjwiyJ
         ZsFH1fPIXd1YcY6TZbj/uGztrN0vgo7hL9Auyvf8nTfDKGjwhrTenDfXHf+GS98RfGmv
         C+FK1zMRECIMbdri06nY3ztRyywCk3lqmXU0l0x0LynrS0/Bt6Hc0vSVQU/vYD6yuaov
         kwN+vpnc+5qEAeTRAbqtIGqzZfUy1gsVncxkiC3wjuTaVXwhpn9M7k/G6Cbvs5ox1gHA
         IgFw==
X-Gm-Message-State: AFqh2krswzW5pbXFM6ODlAQ6VhFpyubIIHQzC3cDNsBtWJ3YKfnY5PuP
        zmqI04kZ2F2bkJKDNSmekLLgaQ==
X-Google-Smtp-Source: AMrXdXtymcn25ZBG/zJxhmOxOPKCJ0TJ5CVw1wGAsbh0Dg1p4XoieT9sdgtZe5B+ULnpKGF4hzZGOA==
X-Received: by 2002:a05:6512:507:b0:4a4:68b7:e719 with SMTP id o7-20020a056512050700b004a468b7e719mr2260436lfb.3.1671790719194;
        Fri, 23 Dec 2022 02:18:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q21-20020a19a415000000b004a46f92a15bsm473828lfc.41.2022.12.23.02.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:18:38 -0800 (PST)
Message-ID: <62e62d16-aa18-4487-db98-d767f1f9d438@linaro.org>
Date:   Fri, 23 Dec 2022 11:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 2/3] dt-bindings: arm: rockchip: Add EmbedFire LubanCat
 1
Content-Language: en-US
To:     ty <zonyitoo@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Wenhao Cui <lasstp5011@gmail.com>
References: <Y6UdvrhLjS0/8Oic@VM-66-53-centos>
 <9a73d8fb-8a73-f8db-2ca7-51bf67cbf659@linaro.org>
 <CAMmci2UkBVaBgYMF8JaZkL==b9-0AB90VPGK7SNdNV5w5Zyzhg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMmci2UkBVaBgYMF8JaZkL==b9-0AB90VPGK7SNdNV5w5Zyzhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 10:42, ty wrote:
> Hi, Krzysztof,
> 
> Sorry, we do not know the process, this is our first contribution to
> the Linux Kernel. There is no change since the last review of this
> file.

So I linked you the process and explain it.


Best regards,
Krzysztof

