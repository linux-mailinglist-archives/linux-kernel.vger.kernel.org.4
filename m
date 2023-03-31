Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73FF6D27A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCaSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCaSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:16:23 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C3DBF8;
        Fri, 31 Mar 2023 11:16:23 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso24064766fac.4;
        Fri, 31 Mar 2023 11:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IKPA0ADOBppfJTT2W2Ch4plvhP4oOyoQ3vJ9If7+rE=;
        b=C03V7OKKSaj4leAzfzpH/Ek9DiUU7THeouEmHQspISF0SHF90obYh9m4Cq2cwKSwgA
         37A883yrg0PSMOKS3cO0Hqfq0fxOjnVPytolvywW+6pN+EsDkE3dIn/b6ClwBQH50tIo
         DOx7P0XnNls7n/urW2HqGqMcan1Hpj+olmyOxcyxAPM9e0x7mAx8DS6ZNkGZI/bSX5CG
         S0KOCHYm3tJ98elFPRt5bc3J0yw41SsQiQsL4t4rmBognS5EKKmL5Riv87cahWIuXqBt
         2MOrtxVDonODJMjkMUAuzSXEAqkfkGfiQIuV1hFQDKdR715eq9SRJbPHtzNHlxjpwZck
         3hPA==
X-Gm-Message-State: AAQBX9d2ciIlq7h7hsk4VqItdqauWA005vtvwQ1KHEcSA6Rf1eFBMBeX
        CF0daBnRtfu3prPv/NSJhw==
X-Google-Smtp-Source: AKy350bbJ1oniqfGXQupv7Am9GdmIkPkG2rGdl3Nxbu7FwzW8n/5xV6zuPgFcSRgI+p9mG38HNZYBQ==
X-Received: by 2002:a05:6871:70c:b0:17e:f313:be68 with SMTP id f12-20020a056871070c00b0017ef313be68mr16700497oap.37.1680286582313;
        Fri, 31 Mar 2023 11:16:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s15-20020a0568301e0f00b006a1508d348dsm1423158otr.22.2023.03.31.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:16:21 -0700 (PDT)
Received: (nullmailer pid 1883565 invoked by uid 1000);
        Fri, 31 Mar 2023 18:16:21 -0000
Date:   Fri, 31 Mar 2023 13:16:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, jdelvare@suse.com, andrew@aj.id.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: trivial-devices: Add acbel,fsg032
Message-ID: <168028658037.1883248.3391058874077647984.robh@kernel.org>
References: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
 <20230322114623.2278920-3-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322114623.2278920-3-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023 06:46:20 -0500, Lakshmi Yadlapati wrote:
> Add new Acbel FSG032 power supply to trivial devices.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

