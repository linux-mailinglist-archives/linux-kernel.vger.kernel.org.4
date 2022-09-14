Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BEE5B8B19
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiINOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiINOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:55:10 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDDD27FC6;
        Wed, 14 Sep 2022 07:55:08 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1225219ee46so41667957fac.2;
        Wed, 14 Sep 2022 07:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tByLw1qEkiOZGzDHv1iwtkakEjYoENISc7jNLUAn1ZI=;
        b=37nhlQGZpq+xkUuAniQQrE0zVlIfMreR4MhwBx0+WmPiJ7zO2fKsD3salZ/uBmf+2W
         PKpwsDkWIj1epW0b/pJAqHPATJvtuk+j9do1BQ7TEwkrl2M6iYQL+o6lFw8IJKcykfkB
         7g6sVIbLYqzd4D9y6NIDGbCUMSe6m8MBWlYMkjH4eRzCiC/Wfyw/G+7Od7z0Q6bRkZJf
         olNNV1T8yWQkROrlYtgjPoyfV3E8Y42Pl0a+J0GEDqhhq/UBkhuCDzSGC+2fMZstTZwi
         H5rm7Z1tyg7Xf9QHubHFWUdNq5lcLzG/khAY0Os2JZ3wC1u2u34tAzKCYCdpAbcaHE7q
         SmNA==
X-Gm-Message-State: ACgBeo0ndcBiRxxfMiyQFysqH8mc3bBmjvMTps4RHHzk0YZsbhzvfYuR
        9ZVryzBxEAnvNqqAhT5wRQ==
X-Google-Smtp-Source: AA6agR70yLqmwAo8ampR4EIA+plNY4V86lsveWAcGrBtki2l9qALN86LHK3Z0XMIwQY5gPpxtS1baQ==
X-Received: by 2002:a05:6808:ec7:b0:2f9:6119:d6ed with SMTP id q7-20020a0568080ec700b002f96119d6edmr1974104oiv.215.1663167307860;
        Wed, 14 Sep 2022 07:55:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z8-20020a056808028800b003431d9b3edfsm5303651oic.2.2022.09.14.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:55:07 -0700 (PDT)
Received: (nullmailer pid 2198793 invoked by uid 1000);
        Wed, 14 Sep 2022 14:55:06 -0000
Date:   Wed, 14 Sep 2022 09:55:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Message-ID: <20220914145506.GA2149379-robh@kernel.org>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-17-opendmb@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:55:03PM -0700, Doug Berger wrote:
> Introduce designated-movable-block.yaml to document the
> devicetree binding for Designated Movable Block children of the
> reserved-memory node.

What is a Designated Movable Block? This patch needs to stand on its 
own.

Why does this belong or need to be in DT?

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
> +
> +maintainers:
> +  - devicetree-spec@vger.kernel.org
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"
> +
> +properties:
> +  compatible:
> +    const: designated-movable-block
> +    description:
> +      This indicates a region of memory meant to be placed into
> +      ZONE_MOVABLE.

Don't put Linuxisms into bindings.

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
> +          #address-cells = <0x2>;
> +          #size-cells = <0x2>;
> +
> +          DMB0@10800000 {
> +               compatible = "designated-movable-block";
> +               reusable;
> +               reg = <0x0 0x10800000 0x0 0x2d800000>;
> +          };
> +
> +          DMB1@40000000 {
> +               compatible = "designated-movable-block";
> +               reusable;
> +               reg = <0x0 0x40000000 0x0 0x30000000>;
> +          };
> +
> +          DMB2@80000000 {
> +               compatible = "designated-movable-block";
> +               reusable;
> +               reg = <0x0 0x80000000 0x0 0x2fc00000>;
> +          };
> +      };
> -- 
> 2.25.1
> 
> 
