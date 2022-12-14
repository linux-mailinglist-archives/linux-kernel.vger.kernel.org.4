Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734E64CD74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiLNP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiLNPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:55:42 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663A28E18;
        Wed, 14 Dec 2022 07:52:53 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id l127so2925020oia.8;
        Wed, 14 Dec 2022 07:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4xHwLe/pd/VD5CKhSEoAMsLKafV5CRSbF22OBqvyP8=;
        b=NgzX6l6WICjbmWY+o3o951tCy7a/wVFaZ2Fj+N/+ynXwu7llgIqQGBlAXnlJnbkeKE
         cVKfpPFCgeem0wMkNZQ2Q8x8U1MRyE3XlgvpWRwSYcXGJvC2fsxG9DaTNVEvw5NsnuZg
         phZVROpk5xOKHl+BUBsZX+8jGEYesL0o6nz7ytvJi0WbR7MolnEaB47Fx8dyR5BYQA8S
         vYT1GOIc5dCn3Lwq7KAog9zK8Fv0zCfWzd/q8yXN9mxh+HPINkyUj7MGbGGOHWuOQAAq
         OQ63mS326miAizhGgAUjcX16Nq4DDWvwGBTU7SK3aIWdlWIL2zZ6vruWuJf6aI2L2EZS
         ko8A==
X-Gm-Message-State: ANoB5pkXhgrQa+EB5aXHuLfPXOgPeO1L0xvRRutl0jpUa+YveXkUJ5K0
        zVS2fKTleDHV0vYnGZjuaA==
X-Google-Smtp-Source: AA0mqf533Y3MXNGVuA3GJkuW7JtzHZqn2fg4QDPst1Zqq/hgTjNtN2e6RQhnUAJ9S1oggdCXIjSXVA==
X-Received: by 2002:a05:6808:159c:b0:35e:9270:7b0e with SMTP id t28-20020a056808159c00b0035e92707b0emr6784321oiw.29.1671033172176;
        Wed, 14 Dec 2022 07:52:52 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id z7-20020aca6707000000b0035c073aa0d8sm37229oix.18.2022.12.14.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:52:51 -0800 (PST)
Received: (nullmailer pid 1127423 invoked by uid 1000);
        Wed, 14 Dec 2022 15:52:48 -0000
Date:   Wed, 14 Dec 2022 09:52:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: adi,ltc2992: correct unit
 address in example
Message-ID: <167103316837.1127369.14707637163188224968.robh@kernel.org>
References: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
 <20221213092643.20404-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213092643.20404-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 10:26:42 +0100, Krzysztof Kozlowski wrote:
> lower-case hex is expected for unit addresses:
> 
>   adi,ltc2992.example.dts:22.24-38.15: Warning (i2c_bus_reg): /example-0/i2c/ltc2992@6F: I2C bus unit address format error, expected "6f"
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
