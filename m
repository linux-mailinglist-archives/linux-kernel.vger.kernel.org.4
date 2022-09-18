Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E0C5BBD6C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIRK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIRK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:29:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49B25585
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:29:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so9138570lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OsZQPKQaz+WzIBFuI25jrhG0FjOY9BOgLej5kVHDvTI=;
        b=qfYP8NJ9MGAgLRKQ3ySC18r4clkbQdaitJceDmvdq3BhcYeeSss9hKng/zkOa5gdcR
         UPp4PyKbpPG+vgkOEeyssP3+VF/E+Im7vEH8psuJUgOxGlvMx/E1TYUvsxfNQB7ZthxJ
         CY3INKNKrk0F52OZm1t23e1I+wUZHM1akde96O1UiQC/xBjM0nhjRj7OI/Ok66ToNgJT
         pkyVVDjpd/OG9NpMmfQCx1eD78GjbVLBMChdVChnIQo3DxxK3PxJx2KVw+4d5RlMGm5E
         dWfid0CTaDag2OK+CsrLw3nS9CHFYe0ZQR0nZ//aasmb9hgF/QCLnXboHCzKa3R+hcOM
         Z0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OsZQPKQaz+WzIBFuI25jrhG0FjOY9BOgLej5kVHDvTI=;
        b=tXI3ZgLltVF6vJsPi47zMjtCtyDkf5ic5+OJs9ABpG1JcoESxmwE4cthUuAhPuiWtp
         GTc9QKlZatP+HWUzFuA1VKELC9BAW9ZuGBLX6utSKAf65fF4Xpdnj+ngzUksZEMxdV2P
         GjXkphwtG93cWY5tTWgBRNOhEosrVcLgoVw68JwnM3PyRIZf5Gb6Gl94HeqlhWImS2ca
         tmZf7cczkuyYMdkjSxfMbyck8wvs4tHuS3XkVd7wTF+Q3/mQiBovQO01IyUMslQvy5bF
         sGyIpHnZCSE/SWalVuEyZmBPE0hUS3h97Ar5c6zwoIE3LvUcV5tjXF4JKRbCwrZ9TRHj
         seiA==
X-Gm-Message-State: ACrzQf2+weRetD1XIeIKY96mE+v18PLhQml25sWeUel6IF6tr3zM4Kbd
        faptiXYgowBVHRpCrOEcTVh0tw==
X-Google-Smtp-Source: AMsMyM7MooLPj97JicuQwYk0U5nKh2lKm409lDS2J4kkGuwS+B4r472TNMcve8L4AVdjPmIM5L+1dg==
X-Received: by 2002:a05:6512:2283:b0:49f:490c:8636 with SMTP id f3-20020a056512228300b0049f490c8636mr4251773lfu.273.1663496938983;
        Sun, 18 Sep 2022 03:28:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i25-20020a2ea239000000b0026c17415c11sm3266754ljm.99.2022.09.18.03.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 03:28:58 -0700 (PDT)
Message-ID: <be75776d-c55a-ddce-81f3-aeacc2f29592@linaro.org>
Date:   Sun, 18 Sep 2022 11:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913195508.3511038-17-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 20:55, Doug Berger wrote:
> Introduce designated-movable-block.yaml to document the
> devicetree binding for Designated Movable Block children of the
> reserved-memory node.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  .../designated-movable-block.yaml             | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
> new file mode 100644
> index 000000000000..42f846069a2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/designated-movable-block.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: /reserved-memory Designated Movable Block node binding

Drop "binding"

> +
> +maintainers:
> +  - devicetree-spec@vger.kernel.org
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"

Skip quotes

> +
> +properties:
> +  compatible:
> +    const: designated-movable-block
> +    description:
> +      This indicates a region of memory meant to be placed into
> +      ZONE_MOVABLE.
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reusable
> +
> +examples:
> +  - |
> +      reserved-memory {

Use 4 spaces for example indentation.

> +          #address-cells = <0x2>;
> +          #size-cells = <0x2>;
> +
> +          DMB0@10800000 {

The convention for node names is to use lowercase and generic node
names, so just "dmb".



Best regards,
Krzysztof
