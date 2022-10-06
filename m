Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D65F6DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJFSnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJFSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:43:05 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F6C5111;
        Thu,  6 Oct 2022 11:43:04 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1326637be6eso3173726fac.13;
        Thu, 06 Oct 2022 11:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdAt9/qLW5IR5INzlShOk7D7K7dX/WFEcR7pwh4Zg64=;
        b=aqMOkOcMQWaSPHP1Re52Tdk67xLRkyKz3d26Gr2uRJVtGyMWlrScmhaS/ukwLLaAjv
         Z4cgrd9FgURSJcud5HV0v3OT6z+JntQP1o/+UfVabD2nL7e5m29Cu2tmPPCuvnaw7y34
         77Obe36PMr6UMak7y/ho+p1KhlAs+W+l7RYu++5CDTG/40r+c+oSlecMWQgdeC5L4y/6
         jhTFcFD4xP/Pbfbp7aGKuhoxZhB26W4WrG3fNcd/NdrQJ1lxDiAb5Xifr5iGBBfmhT52
         90bh8MYL9er74DR6cPVuHdOLJ+7I8/ueGEHXP3Dn39qtYvEPTWvgEQdOlui/jNEvN9Gf
         gU4w==
X-Gm-Message-State: ACrzQf08nT5+bil/MO+uKWul/oZLXGbYJtttrb3aOVCuOpeXPeRSh14W
        d/RgOLtUgfb9VrNZquJbSQ==
X-Google-Smtp-Source: AMsMyM55YDTxBklF/F1OYqyNGI1pGr12gI6xwgyldyXHl8kwNwKlvT/IyxyprHweGspqsaAZBnXH/A==
X-Received: by 2002:a05:6870:178e:b0:126:7055:fc78 with SMTP id r14-20020a056870178e00b001267055fc78mr661154oae.58.1665081783067;
        Thu, 06 Oct 2022 11:43:03 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id t188-20020aca5fc5000000b0034fbbce2932sm6078021oib.42.2022.10.06.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:43:02 -0700 (PDT)
Received: (nullmailer pid 16909 invoked by uid 1000);
        Thu, 06 Oct 2022 18:42:59 -0000
Date:   Thu, 6 Oct 2022 13:42:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        chiaen_wu@richtek.com, pavel@ucw.cz, cy_huang@richtek.com,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: mt6370: Fix MT6370 LED indicator DT
 warning
Message-ID: <166508150927.12105.8845851165188366469.robh@kernel.org>
References: <435f6888ebc20c5abae63eb9cb3a055b60db2ed1.1665050503.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435f6888ebc20c5abae63eb9cb3a055b60db2ed1.1665050503.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 11:16:13 +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add '$ref' and 'unevaluatedProperties: false' in 'multi-led', and remove
> unused 'allOf' property.
> 
> Fixes: 440c57dabb45 ("dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../devicetree/bindings/leds/mediatek,mt6370-indicator.yaml          | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Applied, thanks!
