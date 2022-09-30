Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC55F1216
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiI3TH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiI3THZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:07:25 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72D1876A6;
        Fri, 30 Sep 2022 12:07:24 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id m130so5642980oif.6;
        Fri, 30 Sep 2022 12:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7UvrZW9vDC7+RAHxe3Db0y/3HEdMAVA+5rTcMO4tU5k=;
        b=nQ44qQB85PLgupojjQ3J1/mSad/XlGgscbV2rHl/kq4iRzMa0NoyfTnohlxiH3ZNXm
         Qvo+UW+7a5ap+zJKkBXXdYUK/Okt8B7wNLOvG4Rq+zWKm75y2frVccBKlHbckomU5haY
         W8k60fFN3WIUBGiNASQ0qmpWDeIpbeYWwDPpqMkr3VN0lieTW3Mrkf++nBiQlIuTrd84
         69zBVELbi8b1SvRgOmv+d0IGGU+h0DGp3sAuM0M9kpBP6PnFrhXyrUKryfa2pTbX8krS
         lTHr+yeh3t50dN1nOc5DYnYnZ/G5JTiXmwhAbZCi3gluiU1ZoiVHTsGH9AKBU0kMQYZ3
         E67g==
X-Gm-Message-State: ACrzQf0ktROnRQfAdgX+8Px8Xk+0p/v7by7trqD7FYDYjDjqSKcHLohh
        IrNZQly1eGIYvOCluzk+/Q==
X-Google-Smtp-Source: AMsMyM5VXIZVfTULchEFX18RTnyFn2QWWcEhn3g4x9WvoM1p60VQNjZFgoQU5cttkyqY8L9g9cfcWw==
X-Received: by 2002:a05:6808:645:b0:353:2f37:553c with SMTP id z5-20020a056808064500b003532f37553cmr39700oih.212.1664564843865;
        Fri, 30 Sep 2022 12:07:23 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y37-20020a05687045a500b00130e66a7644sm905655oao.25.2022.09.30.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:07:23 -0700 (PDT)
Received: (nullmailer pid 692263 invoked by uid 1000);
        Fri, 30 Sep 2022 19:07:22 -0000
Date:   Fri, 30 Sep 2022 14:07:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        angelogioacchino.delregno@collabora.com,
        yu-chang.wang@mediatek.com, kuan-hsin.lee@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Message-ID: <166456484158.691972.4837005507829251946.robh@kernel.org>
References: <20220929114624.16809-1-johnson.wang@mediatek.com>
 <20220929114624.16809-3-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929114624.16809-3-johnson.wang@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 19:46:22 +0800, Johnson Wang wrote:
> Add the new binding documentation for MediaTek frequency hopping
> and spread spectrum clocking control.
> 
> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8186-fhctl.yaml   | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-fhctl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
