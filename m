Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1D65502A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiLWMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLWMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:10:41 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880504AF2E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:06:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so6887096lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlCXAwdO/mz/cXYX3UWbY4nAqrujGEVKbpFeE3SLQNk=;
        b=XhBBwkRdZ8DGm4b3pnYd3KcRYru3gnKX8kY+va5S6IZ8rbMSdcFEP/KTCJEoHuO5aK
         AQCeiAs3H6ExrJ1UnBnN6oMtyJhUzrmsWFW6IAGsv7qeMb7hLNfJg/7uemzx8LwaHinX
         yV+NW5xdaz0SsJUMrPvPcX3auG90mXirNUiXRJ4ENRVF0+vXX3PMAGOCJrunzq6wBOCv
         Jws26oY9pXkRWblQKzfwaSfYJY+QtNtWCUpi15v2RnFdyCVsej6cFEiGDiEpcoE6dArW
         prUb//3VmKDu91ZgilhX+i90/a2uIozR89z16n66CT4NYLXcz0CJ5mSvpsVWaBNY0B0v
         0ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlCXAwdO/mz/cXYX3UWbY4nAqrujGEVKbpFeE3SLQNk=;
        b=K5wqWAHlAe9ZGhb+GEAAJX658cWKFTaL7/zCxqr1jU7T2UTUt+8usZAAe32yn9F7X1
         F3bcrjcUDP8WeSbRXqP4eYrannZGJrASXGWcpVwY5t11Nq4+51M+NYvvXvJPj2K0ik6d
         3RHGqU9wFRgvQ4GRhfacbwg3lcAHzegJICNiLk1iLfh4E5nchNE7SW3sONLqyloNtEri
         GXnVvIB57ONglmF+WaI1t4rDYWPCRLtXQHYBU2qR07EJ+mjkMkRtfZiNDIEAEhlrNx2u
         LAajy4VWZP3F0ZW9C4zlWMdwaOn5NYZdb1n8Afq8IzTigL9/XXHfhTdwwOGUe5XX6lVj
         jprQ==
X-Gm-Message-State: AFqh2kpbZ+WdikOshkI12ZzoePhwKfNJspybvDNNe+LKW0uxrXGxo517
        FcBlqqspfGHfx5ZcymvXl30TNg==
X-Google-Smtp-Source: AMrXdXvh0YYp1o3nnjY3mzA3nKO381f+B7NX0kIC3NndvsKJF4nsO8msym7mwCkHmtIxBqlrs3o7TA==
X-Received: by 2002:ac2:5e71:0:b0:4a4:68b9:66d3 with SMTP id a17-20020ac25e71000000b004a468b966d3mr2364499lfr.30.1671797152253;
        Fri, 23 Dec 2022 04:05:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r12-20020ac25f8c000000b004b585003839sm494955lfe.265.2022.12.23.04.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 04:05:51 -0800 (PST)
Message-ID: <258196d4-5279-daf8-0b9d-b4847149fe9c@linaro.org>
Date:   Fri, 23 Dec 2022 13:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] dt-bindings: remoteproc: ti: Add new compatible
 for AM62 SoC family
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, andersson@kernel.org,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, s-anna@ti.com
Cc:     hnagalla@ti.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, j-luthra@ti.com
References: <20221223115638.20192-1-devarsht@ti.com>
 <20221223115638.20192-2-devarsht@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223115638.20192-2-devarsht@ti.com>
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

On 23/12/2022 12:56, Devarsh Thakkar wrote:
> AM62 family of devices don't have a R5F cluster, instead
> they have single core DM R5F.
> Add new compatible string ti,am62-r5fss to support this scenario.
> 
> When this new compatible is used don't allow cluster-mode
> property usage in device-tree as this implies that there
> is no R5F cluster available and only single R5F core
> is present.

It's v3 but addresses are still not correct.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Best regards,
Krzysztof

