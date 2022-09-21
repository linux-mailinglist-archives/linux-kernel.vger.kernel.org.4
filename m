Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468F5BF7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIUH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiIUH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:28:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C083BE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:28:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j16so7775695lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2s5lxGbf4cvyY0Y4pz0pmATsk4vxoVx5/GPuUckLOdk=;
        b=LuHeP+1tR0AIDRsBxb1Ekcmt+YHYmYvl477n9lTq3EbygeOzZMSO4QZ73Mp0FwrMd5
         Op/InV2JCc2lG2J49qqG3H0a2IWx226hi66gfjmPQkm+AOIWssTJe5+8XOk78Xp9Jhwi
         TqREd5ju/xYEe5rVad7x7Q3vPRskOZ1RK+LeVfdzxw1u2eIpVAvkUcbz8AkhaIa+lwEF
         gcCcCzVLt6RmYYjGFI+TL+ifvvP4KD73c3Du7wL7p4DSzO5bwkIr9v2CAEypDdoauqsX
         FMJMwq/0A8Ln0LIdIZgqppfACoc4QEIoZzXbWvAf3GEXkp38KEJGRQTcmfgvk/pHsIEP
         ixVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2s5lxGbf4cvyY0Y4pz0pmATsk4vxoVx5/GPuUckLOdk=;
        b=YSa6BTs36hMk7xCrWU6v0ewOb1FAUkkZ8kzd4H+g5s2cdvSs0sxnDVaDWVGYFqdnR3
         eC1j7lZILxNEvYVJa6DvDhXTF1B1CZt3RTHQV07Lz49bWtcmGywtsZehWW1CKaWepYRx
         qJG5YhIcS90ewoe3hDfYXCGWmzEz0rzHXJlqCYbE5QopfVR0ntZ2Kn5QKMQ/AU/YP5uo
         NMLxttCurFXabMYzdeZNxC6QodmHlZSlqOvrBs3RELaIZ0wKueTPjIgBXnbpARPBiSp+
         F+n4xBwHRwpO6UOu6SGtKIaneVO1LTDPLLmZYM+YiYnXH0ZslbsUeEWj5tkxMxOMPZnp
         cF8Q==
X-Gm-Message-State: ACrzQf1eYgyU1R1jtj2DYza/ux2ZqL6lxsJWiPh6FnDxBX6nEcOdT7lJ
        SqDlS0DeOfqTnmg1GnVRMpUqMw==
X-Google-Smtp-Source: AMsMyM73JuF+jdQrmITpzImiIu0l/sXxcecWmqzRuEoqbuqa584VPSacsh+E32Lv3H5uLCcB1uhA+w==
X-Received: by 2002:a05:6512:15a5:b0:49a:84f4:9284 with SMTP id bp37-20020a05651215a500b0049a84f49284mr10659192lfb.477.1663745294807;
        Wed, 21 Sep 2022 00:28:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6-20020a2e1546000000b0025e4dcc48b1sm320173ljv.19.2022.09.21.00.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:28:14 -0700 (PDT)
Message-ID: <b257ec4b-fb59-9118-0efb-abf87ea54695@linaro.org>
Date:   Wed, 21 Sep 2022 09:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/8] memory: tegra: Add API for retrieving carveout
 bounds
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920081203.3237744-1-cyndis@kapsi.fi>
 <20220920081203.3237744-2-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920081203.3237744-2-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:11, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> On Tegra234 NVDEC firmware is loaded from a secure carveout, where it
> has been loaded by a bootloader. When booting NVDEC, we need to tell it
> the address of this firmware, which we can determine by checking the
> starting address of the carveout. As such, add an MC API to query the
> bounds of carveouts, and add related information on Tegra234.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Add check for 64-bit phys_addr_t. In practice phys_addr_t
>   is always 64 bits where this runs, but it avoids warnings in
>   compile test.
> ---
>  drivers/memory/tegra/mc.c       | 25 +++++++++++++++++++++++++
>  drivers/memory/tegra/tegra234.c |  5 +++++
>  include/soc/tegra/mc.h          | 11 +++++++++++

I still need here Thierry's ack.

Best regards,
Krzysztof
