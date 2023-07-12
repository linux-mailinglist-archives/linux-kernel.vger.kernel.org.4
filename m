Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89B750752
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGLL7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjGLL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:59:03 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA72173C;
        Wed, 12 Jul 2023 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689163128; x=1720699128;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OJouoYxXrVKCuCSEo9CjWQgz9MDgSlk0EBb35C5ZGhk=;
  b=nG6rOHQmlcHkvsHvggjw9cY3iT9lUW6mh1TzbhUyzXVqlwEAE4DegdhN
   8vQbBdPnJt2UXkb9FOfc8po9k63uvDaMpub1t7UlGJ5Q4duUqW3g0EQLR
   IawOO98bYBlRhKDeE9JgTZgHMfTXM4ScAFrm7SohMh6dtCTqfeMboiqJq
   c=;
X-IronPort-AV: E=Sophos;i="6.01,199,1684800000"; 
   d="scan'208";a="226107911"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 11:58:26 +0000
Received: from EX19D004EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 2263140D5A;
        Wed, 12 Jul 2023 11:58:25 +0000 (UTC)
Received: from EX19D044EUA002.ant.amazon.com (10.252.50.212) by
 EX19D004EUA004.ant.amazon.com (10.252.50.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 11:58:24 +0000
Received: from [192.168.102.31] (10.85.143.172) by
 EX19D044EUA002.ant.amazon.com (10.252.50.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 12 Jul 2023 11:58:19 +0000
Message-ID: <4d9a0899-145e-3223-41da-b91b81afaaa2@amazon.com>
Date:   Wed, 12 Jul 2023 14:58:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: hwmon: moortec, mr75203: fix multipleOf for
 coefficients
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <farbere@amazon.com>
References: <20230712081124.110345-1-krzysztof.kozlowski@linaro.org>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20230712081124.110345-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.85.143.172]
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D044EUA002.ant.amazon.com (10.252.50.212)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2023 11:11 AM, Krzysztof Kozlowski wrote:
> Few coefficients use default values multiple of 100, not 1000 (in the
> example DTS and in the Linux driver):
>
>  moortec,mr75203.example.dtb: pvt@e0680000: moortec,ts-coeff-g:0:0: 
> 61400 is not a multiple of 1000

Why isn't multiple of 1000 correct?
According to the Moortec datasheet for the series 6 of the temperature 
sensor
the coefficients are:
G = 57.4 (57.4 * 1000 = 57400)
H = 249.4
For series 5 coefficients are:
G = 60 (60 * 1000 = 60000)
H = 200
J = -0.1

> Fixes: bf1fdafdbc61 ("dt-bindings: hwmon: (mr75203) add coefficient 
> properties for the thermal equation")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> .../devicetree/bindings/hwmon/moortec,mr75203.yaml          | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git 
> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index ae4f68d4e696..bd67cfee6d19 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -105,7 +105,7 @@ properties:
>       G coefficient for temperature equation.
>       Default for series 5 = 60000
>       Default for series 6 = 57400
> -    multipleOf: 1000
> +    multipleOf: 100
>     minimum: 1000
>     $ref: /schemas/types.yaml#/definitions/uint32
>
> @@ -114,7 +114,7 @@ properties:
>       H coefficient for temperature equation.
>       Default for series 5 = 200000
>       Default for series 6 = 249400
> -    multipleOf: 1000
> +    multipleOf: 100
>     minimum: 1000
>     $ref: /schemas/types.yaml#/definitions/uint32
>
> @@ -131,7 +131,7 @@ properties:
>       J coefficient for temperature equation.
>       Default for series 5 = -100
>       Default for series 6 = 0
> -    multipleOf: 1000
> +    multipleOf: 100
>     maximum: 0
>     $ref: /schemas/types.yaml#/definitions/int32
>
> -- 
> 2.34.1
>
