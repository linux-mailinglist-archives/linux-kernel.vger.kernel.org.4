Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69932616A44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKBRNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKBRN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:13:29 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F063E7;
        Wed,  2 Nov 2022 10:13:26 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so10631141otb.8;
        Wed, 02 Nov 2022 10:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtCmOyazdlPr8IFINMztXSIcqGGdfwLEM9wCe7FOq2A=;
        b=arhkjc6KKweymQz21OV1TtxI5uu7D3DaKO9DhmKwTP+stqtJmaribPhuQSaPz3c+Ds
         ZIJjqaAhi7TNlZqRPILw/r3xYkF3CIKMVRbdVLTvchcXZ3nfyzBIjw9+aqJYM/mroF7x
         cUlKXtcy4+WBkalsKlD9A4zHQPPqYsQFzRMHUVARUrE6qvJxINGKGXzHtF1OR17BXEVH
         OU9hootFK8ib7sx4Z/5l89SW92bY/uY6h27k/fX2vUddXYV9vtlcMQS/hvtkJRFWk/zI
         LoLPoasI61+5jd4vzOYumBHJJJX5xTheaN0nezCpfj6stSsvoU0y54NFsYYbjUFAqPPS
         TvqQ==
X-Gm-Message-State: ACrzQf1Sp22x7GIFxdRsFE/5f18RLbZgOQICsg4yMlndqss0atJzTQRx
        nzZQ/1Lgqo7YwMrFFWiERg==
X-Google-Smtp-Source: AMsMyM6BuKM1boyK4sJAx5Q3fFBFuRydAB8uofuGARf+cqKyY4zzptmIRNcXFPzzLKFDCzQLqwFpfQ==
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id z24-20020a9d62d8000000b0066c4f8878ffmr8900209otk.269.1667409205659;
        Wed, 02 Nov 2022 10:13:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r5-20020a9d5cc5000000b0066c2ab15b13sm5303308oti.42.2022.11.02.10.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:13:25 -0700 (PDT)
Received: (nullmailer pid 4131422 invoked by uid 1000);
        Wed, 02 Nov 2022 17:13:26 -0000
Date:   Wed, 2 Nov 2022 12:13:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Weilong Chen <chenweilong@huawei.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, xuwei5@huawei.com,
        f.fangjian@huawei.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        yangyicong@hisilicon.com, brgl@bgdev.pl
Subject: Re: [PATCH next v3 2/2] dt-bindings: gpio: add entry for
 hisilicon,ascend910-gpio
Message-ID: <166740920604.4131176.3460424297227537626.robh@kernel.org>
References: <20221101082442.263448-1-chenweilong@huawei.com>
 <20221101082442.263448-2-chenweilong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101082442.263448-2-chenweilong@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 16:24:42 +0800, Weilong Chen wrote:
> Add the new compatible for HiSilicon gpio controller driver.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
> Change since v2:
> - No change.
> Link: https://lore.kernel.org/lkml/20221028022453.163186-2-chenweilong@huawei.com/
> 
> Change since v1:
> - Drop "Device Tree Bindings" and reg's description
> - Move description in top-level description.
> - Add gpio-cells to required
> - Use additionalProperties and decimal numbers
> - Use IRQ flags
> - Use vendor,soc-ipblock format
> Link: https://lore.kernel.org/lkml/20221026034219.172880-2-chenweilong@huawei.com/
> 
>  .../gpio/hisilicon,ascend910-gpio.yaml        | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
