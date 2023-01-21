Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3742A6763E9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAUFK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUFK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:10:26 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A944673145;
        Fri, 20 Jan 2023 21:10:25 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30L59vDa068254;
        Fri, 20 Jan 2023 23:09:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674277797;
        bh=GRALvZ1/s09JXcu+MfUwyisGifXl6ED/LK1oOMDHrF4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LEZRaYTvGHAexOujqnqLKCQxTNKS5neQccpZT9fMFaEXmqqqhW6jXG3iMw2k9+PZw
         Vn2CsLnUeoeUz5qA9UT5U2APJOgknLCyA7OfGnMq+bpqhjfKwfIgKYm7YKyFkDNAG+
         mJGVi5F/8gZkn5srcr5u7Riz+v9slPQeMK59E/uU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30L59v6K115078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jan 2023 23:09:57 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 20
 Jan 2023 23:09:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 20 Jan 2023 23:09:57 -0600
Received: from [10.250.234.171] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30L59rPJ003598;
        Fri, 20 Jan 2023 23:09:54 -0600
Message-ID: <4b83bbef-7481-77be-03a2-3efde086cf60@ti.com>
Date:   Sat, 21 Jan 2023 10:39:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: mtd: partitions: Fix partition node name
 pattern
To:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230120020454.3225796-1-robh@kernel.org>
Content-Language: en-US
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230120020454.3225796-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/23 07:34, Rob Herring wrote:
> The 'partition' node name pattern is missing start and end anchors, so
> anything is allowed before or after the regex pattern. There's no in tree
> users needing that, so add anchors to the pattern.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>



>   .../devicetree/bindings/mtd/partitions/partitions.yaml          | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> index 9aca4e6c6047..2edc65e0e361 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> @@ -32,7 +32,7 @@ properties:
>       enum: [1, 2]
>   
>   patternProperties:
> -  "partition(-.+|@[0-9a-f]+)":
> +  "^partition(-.+|@[0-9a-f]+)$":
>       $ref: partition.yaml
>   
>   required:

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

