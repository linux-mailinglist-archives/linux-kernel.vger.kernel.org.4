Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070796F0A19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbjD0Qmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbjD0Qma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:42:30 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1610CA;
        Thu, 27 Apr 2023 09:42:29 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-18f16bb1a9bso5462911fac.1;
        Thu, 27 Apr 2023 09:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682613748; x=1685205748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qeBYaCNg6vo7r6D0tyPOnjAI0l2bKMXlNaKIsxUD8Q=;
        b=knqjUB4EWivaN5jZEET2tvIpss4BZlxcHvQNnUsUnefHIeb0qOdm8mw6Dss99MYd/L
         QBFPTXNcDEWKc3lptu16z65DK2kLfeKOKhVyY19RzoYkIzhMSckWDDNTMnaLI2p2X1b/
         THVHpnCMWxS6uSOO8Z39iA7orJ7g42rfMaJiK0SWDqZwDFbYgKHygCVsrspE5Y2HXxTg
         9/KA/0rExf3JEjAEvbTcstNSk5SHPTcuLpsMie9p2fuW80+Qgi6X+kxOyzKoxye5GYMp
         8CkVXX7B4oCPC7MmGsZYx0+r3vsxpu86xH6GMUj5+pmoaHTieENmpLRpCMy6poUKPPBj
         y+Rw==
X-Gm-Message-State: AC+VfDwSbBV7/ZlUtlgshfCcRiYhgY90XCKRsUodPjYw7YXlTQK8axwz
        5NZxAr1aNbVT7tQHEzjo53Z5IE3W1g==
X-Google-Smtp-Source: ACHHUZ4SeuCwkCmh9WCQyYFk06qXMizq4bawaVPnJEuzjd3Tyz8kqq3GIBmoGpqeV8Ux/KWyv8rPkA==
X-Received: by 2002:a9d:75ca:0:b0:6a7:cdb1:88ff with SMTP id c10-20020a9d75ca000000b006a7cdb188ffmr1143258otl.14.1682613748637;
        Thu, 27 Apr 2023 09:42:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a9d5c02000000b006a1508d348dsm8063612otk.22.2023.04.27.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:42:28 -0700 (PDT)
Received: (nullmailer pid 3146107 invoked by uid 1000);
        Thu, 27 Apr 2023 16:42:27 -0000
Date:   Thu, 27 Apr 2023 11:42:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc:     kernel@axis.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: Document TI OPT4001
 light sensor
Message-ID: <168261374711.3146053.15570341588238197618.robh@kernel.org>
References: <20230323-add-opt4001-driver-v3-0-62e121dab294@axis.com>
 <20230323-add-opt4001-driver-v3-1-62e121dab294@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323-add-opt4001-driver-v3-1-62e121dab294@axis.com>
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


On Wed, 26 Apr 2023 13:57:29 +0200, Stefan Windfeldt-Prytz wrote:
> Add devicetree bindings for opt4001 ambient light sensor.
> 
> Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> ---
>  .../devicetree/bindings/iio/light/ti,opt4001.yaml  | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

