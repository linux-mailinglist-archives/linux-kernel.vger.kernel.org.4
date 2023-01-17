Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA366DC77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjAQLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjAQLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:31:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3A18B24;
        Tue, 17 Jan 2023 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955079; x=1705491079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=csXXDL3NsaAqXDT+FItt2p2CSWBTqlmNoHbAeHBdx5U=;
  b=ZPeZ0Z4RbyX0664158E94f1OemBqN4cfZcgbXyCfhwN/RmYx992LijaH
   +04xf6HHdhIQHwxglkfuaf+XQZpxySw21tqOdrEOoR6PZ5sf/316H7wHt
   I2LGQafX9eisYJTYsnYDzgJ4wGmfX8W0UiUXEr9+zyUt1KU0JLUAQf2yD
   yxy+kHNGmc1tEq0BYtMuBa/ti8WqZ+/7U4vAJn5689PtWXE4PZWetEt1b
   f+m4GhJHdgmJOiwFFyzhK7gTSPHDR+dJrYpafLpaa/iRJ0yrt17BBgoTH
   LFzHPaw/1+kBxnx+PqcdGZ5YX7HMU0T+evlI/bmjeAYdSLt+Pj7KhV84a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323369181"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="323369181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:31:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904615217"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="904615217"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.10.213]) ([10.213.10.213])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:31:14 -0800
Message-ID: <5b80ac60-10aa-48a9-370f-358fbc9d03fb@intel.com>
Date:   Tue, 17 Jan 2023 12:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 2/5] dt-bindings: display: bridge: cdns,dsi: Add
 compatible for dsi on j721e
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, tomi.valkeinen@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        lee.jones@linaro.org, Rob Herring <robh@kernel.org>
References: <20230103101951.10963-1-r-ravikumar@ti.com>
 <20230103101951.10963-3-r-ravikumar@ti.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230103101951.10963-3-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.2023 11:19, Rahul T R wrote:
> Add compatible to support dsi bridge on j721e
>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
> ---
>   .../bindings/display/bridge/cdns,dsi.yaml     | 25 ++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> index 3161c33093c1..23060324d16e 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> @@ -16,9 +16,15 @@ properties:
>     compatible:
>       enum:
>         - cdns,dsi
> +      - ti,j721e-dsi
>   
>     reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description:
> +          Register block for controller's registers.
> +      - description:
> +          Register block for wrapper settings registers in case of TI J7 SoCs.
>   
>     clocks:
>       items:
> @@ -67,6 +73,23 @@ properties:
>   allOf:
>     - $ref: ../dsi-controller.yaml#
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,j721e-dsi
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +        power-domains:
> +          maxItems: 1
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
>   required:
>     - compatible
>     - reg

