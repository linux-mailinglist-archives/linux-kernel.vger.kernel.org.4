Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62826DBBB2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDHO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDHO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:57:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4F93C8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:57:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qb20so2584668ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680965874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2/qlTZK3oc+3BcIiO+i7wsdJpDN0YCENNW/riWaWBw=;
        b=hEiQFv4Ri1VXTALwil3u0QmuzXY0NHaOpRgLjpVfPDSS3CDBk/tqGai+aC2FpNSmSC
         WdE0SI1vxEIPPW4zKU67JMvoFtxvR3KkYlkXTyw/wR+Fi6IwLsqQL/DKFLzNqc77L+Dx
         y4aca0jvgoH1AvWAyWcEkvKN8oe/WP6bwIdYOaQU+vOFvKIxhIalNIt4GERDacNG2dvX
         e51p/jb08wUSRuPTKASgPD++ZBUFmHy6dhhZZOmBUVL7MJW9MQr3JFgETcb+2ZWICzKW
         ovr5iEDN1OoKDBozgKXEoESyxAU4fcC4hbFs1xUYEBIunL48uwU6VwVJbexyrmyc3LJq
         IS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680965874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2/qlTZK3oc+3BcIiO+i7wsdJpDN0YCENNW/riWaWBw=;
        b=hHszTjUOwKto01ETTH9hc0xmj6AvEy3vw30U2xK2am75RCpdJKcYcaPx6O8dEdT93h
         K9K9sl3W5L+5M3uXfz6vXskWztqqQMyGgoEIiX0L0H7b2tiFOzc/3Xe0aZpBq/DVJt/o
         Z9qfhsiu2umUUMc9RtEJxyeYbsDEwjkOxUC3vsExcg5Y23JpMG2tZ6jZZR9QIh3j4DV1
         9+uYOjkFVJfKIEhWPmKHhpZsvGxqRTYGokgwpoY5KOE6RezOg2s+ZjZQBJBxYi4q0Zhs
         tSiJGWLwxLG1FTIw+u7Mo+CXOxfGC7+IpD42xdc2ppYqOvkRChMhQCEAEWZp0L5x5cjN
         Snnw==
X-Gm-Message-State: AAQBX9cIBXWoFegmMXJPNhKa+HSNcsSgQEbuCmFen8mOuBmGSoCKyLfa
        f2bVRGrVHDTiQDs2b55JhfFTAg==
X-Google-Smtp-Source: AKy350adYYuy2WWnFavedFp4QpR1b9dBllUR2MoosuAuU4Q4DaBN8J38njDCEHhG4EuXGlh6kHrcZg==
X-Received: by 2002:a17:906:784:b0:949:c05d:73b6 with SMTP id l4-20020a170906078400b00949c05d73b6mr1966937ejc.17.1680965873987;
        Sat, 08 Apr 2023 07:57:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:e293:da16:7aac:96e6? ([2a02:810d:15c0:828:e293:da16:7aac:96e6])
        by smtp.gmail.com with ESMTPSA id f7-20020a1709064dc700b0093f83562f09sm3191976ejw.87.2023.04.08.07.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 07:57:53 -0700 (PDT)
Message-ID: <0205fab6-3665-f985-41a5-3fed24644665@linaro.org>
Date:   Sat, 8 Apr 2023 16:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: dts: stm32: fix typo in stm32mp15xx-dkx.dtsi
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230407193253.1.If11ffa6edfdfef0869478412ec3cec3169483cb9@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407193253.1.If11ffa6edfdfef0869478412ec3cec3169483cb9@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 19:33, Patrick Delaunay wrote:
> Remove unnecessary space in device tree stm32mp15xx-dkx.dtsi.

Your commit subject says typo. Where is it?

> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> index 11370ae0d868..ccd6c4722bd3 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> @@ -382,21 +382,21 @@ vref_ddr: vref_ddr {
>  				regulator-always-on;
>  			};
>  
> -			 bst_out: boost {
> +			bst_out: boost {
>  				regulator-name = "bst_out";
>  				interrupts = <IT_OCP_BOOST 0>;
> -			 };
> +			};
>  
>  			vbus_otg: pwr_sw1 {
>  				regulator-name = "vbus_otg";
>  				interrupts = <IT_OCP_OTG 0>;
> -			 };
> +			};
>  
> -			 vbus_sw: pwr_sw2 {
> +			vbus_sw: pwr_sw2 {
>  				regulator-name = "vbus_sw";
>  				interrupts = <IT_OCP_SWOUT 0>;
>  				regulator-active-discharge = <1>;
> -			 };
> +			};
>  		};
>  
>  		onkey {

Best regards,
Krzysztof

