Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3E6DD25C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDKGGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:06:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BDE65
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:06:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sh8so17473139ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681193203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RuGSEWbtWr4eU2VNJtutFDl4BvimrBoTwWCP7bAhk0=;
        b=LKFCpFiVWPt1C2PyKHhOkH7cOWiD688f1yUkghusUy5JIgo952wJp2u6v0Dy1KNj6F
         DyMahs4tzWfc02e3FBUKs+EQ9z0rD9ihCWBIiITUF5s954cQ+hjndy3F9Wo/D87sYtvk
         IYgxmj/rncEgx2Cg2zsLtkFzP+dsqqRj6YJYJIr+H39wybcaAsmwpJ2Hacdcwgup6NgP
         eu4GeHj8t8/cA+pr024H1r4By/bmdHfoHDGHL+DkPTTRtYyz7YLdfISkswf1AUEmwSGs
         kLucvjWI+fyBCdcrPv5aJRvvlqdv4VqioJUSE1nT0sHLu6vekvENhZjaoB+QCHULSSlH
         vZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RuGSEWbtWr4eU2VNJtutFDl4BvimrBoTwWCP7bAhk0=;
        b=ORBdx2WEbLlxT2K0xsUqbhXnAbfoaidMNOXdh6LNvJowgh0pz/UZhAESIQBg8l0Y7T
         YiRkqHL+IkJJhD5Cvt+vw3LGZWe4MDjfq70zszVkhcl/OLw95cCcDL1ig+gBGGDTc446
         7CxgA/MF0+OKCgHJaE4YNuqKt+v3PJKU501E5E4agpbXe0Sq+EZrnI9EqeBqXLTKO/su
         eCbWN4lSGvmo04BM79dbeQzpv2YgfzYAMkFQrm/N8VaPraAWX2bHyIsKoo/J4SNk3o7S
         jeey9EzagEcMRFmTDELFA8x3P99UGddLepVJB/gOMcziGIhmEW4XLPKuSGnejKr4wwv5
         3Z+w==
X-Gm-Message-State: AAQBX9e5w33FIM1CeBaLc4VBh4u0kaOJ1RdPOui/7iTMIbkV0lqBlSbO
        DMIdHX+qlhgNi8jw/W4w/gwRKg==
X-Google-Smtp-Source: AKy350aeV2/Y/zgxEs+xA/fMLd5DYGuG+h/tpM4592P5SpvtiXVajRdKLOY/98oVgqi14AxHuKtM2g==
X-Received: by 2002:a17:907:31cd:b0:94a:5d7e:d455 with SMTP id xf13-20020a17090731cd00b0094a5d7ed455mr7143926ejb.34.1681193202820;
        Mon, 10 Apr 2023 23:06:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id r14-20020a170906364e00b0094a82a236cbsm1860935ejb.129.2023.04.10.23.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:06:42 -0700 (PDT)
Message-ID: <6ba8bbcf-0d72-4bb9-a014-85e9f3e22cdb@linaro.org>
Date:   Tue, 11 Apr 2023 08:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: Add no-hpd property
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        jani.nikula@intel.com, tzimmermann@suse.de, javierm@redhat.com,
        ville.syrjala@linux.intel.com, r-ravikumar@ti.com,
        lyude@redhat.com, alexander.deucher@amd.com, sjakhade@cadence.com,
        yamonkar@cadence.com, a-bhatia1@ti.com,
        tomi.valkeinen@ideasonboard.com
References: <20230405142440.191939-1-j-choudhary@ti.com>
 <20230405142440.191939-2-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405142440.191939-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 16:24, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> The mhdp bridge can work without its HPD pin hooked up to the connector,
> but the current bridge driver throws an error when hpd line is not
> connected to the connector. For such cases, we need an indication for
> no-hpd, using which we can bypass the hpd detection and instead use the
> auxiliary channels connected to the DP connector to confirm the
> connection.
> So add no-hpd property to the bindings, to disable hpd when not
> connected or unusable.

Your subject prefixes miss device specific part. You do not add no-hpd
to all bridges.

It's also not drm. It is a display directory.

> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../devicetree/bindings/display/bridge/cdns,mhdp8546.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index c2b369456e4e..3a6c6d837593 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -57,6 +57,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  cdns,no-hpd:

No improvements - use existing no-hpd name.



Best regards,
Krzysztof

