Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3155FF505
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJNVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJNVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:09:07 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454BE1DCCCB;
        Fri, 14 Oct 2022 14:09:02 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w196so6338277oiw.8;
        Fri, 14 Oct 2022 14:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFbWOiyQ97fl6msdrmbKRp8AqMUR98EgH4kmS3rexak=;
        b=E7KB33jyJ/sd2rJQRjKFTdsdBWUi5QV+DHKu8SgLYC/FYscvzy9vYr25TsMmmMMk5Y
         2apIukM7I7rsdwJ6hBlsbrFwb6dLXcfzhvrnCldxfnhjTMzwMKKrERWNnKJ7Y3y4DnuF
         E07Zy6vaSn5RqffuQv5RvtYJ46GsYvAdaGcWsh4LAcy6/QxpdGwrrdtfrAlGVaVxdfcF
         hZ8DgA6wvreGNIvyE6/W4ZMzcq6cd2ZJnDPz490fRtH2elonuuSVZZZ9BKYWsDeUwr7g
         8C7JTagmpogp427iPMkXL9+1hlu+lRSxWDGbuLngPD6z0IdV9e2mcA21IgAa96hQejSZ
         M3xg==
X-Gm-Message-State: ACrzQf1T79mqGCb46RBEHo3vrhPtDy/Sra+ZuTiDU+QnsJ4JUxY2xq/T
        Hx4ali5nBcFas6QJ5m7+4t31ON+sXhyE
X-Google-Smtp-Source: AMsMyM5exSaegpHBePjo8BcVuZoo8kQdXZomJxgyXZ72GJFXcpyYNV6f3Nb7Cbh/csJE79kBBPNDuA==
X-Received: by 2002:a54:450c:0:b0:354:9464:2e64 with SMTP id l12-20020a54450c000000b0035494642e64mr3424172oil.178.1665781741786;
        Fri, 14 Oct 2022 14:09:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l36-20020a05687106a400b0013669485016sm1797234oao.37.2022.10.14.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:09:01 -0700 (PDT)
Received: (nullmailer pid 2899059 invoked by uid 1000);
        Fri, 14 Oct 2022 21:09:02 -0000
Date:   Fri, 14 Oct 2022 16:09:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     devicetree@vger.kernel.org, paul.j.murphy@intel.com,
        mchehab@kernel.org, daniele.alessandrelli@intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.com, jacopo@jmondi.org,
        sakari.ailus@iki.fi, linux-media@vger.kernel.org
Subject: Re: [PATCH v6 1/3] media: dt-bindings: imx412: Extend compatible
 strings
Message-ID: <166578173132.2894359.17034886949314932517.robh@kernel.org>
References: <20221014180417.3683285-1-bryan.odonoghue@linaro.org>
 <20221014180417.3683285-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014180417.3683285-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 19:04:15 +0100, Bryan O'Donoghue wrote:
> Add compatible bindings for imx577 which uses the same silicon enabling
> reference code from Sony in the available examples provided.
> 
> Cc: sakari.ailus@iki.fi
> Cc: dave.stevenson@raspberrypi.com
> Cc: jacopo@jmondi.org
> Cc: "Paul J. Murphy" <paul.j.murphy@intel.com>
> Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-media@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
