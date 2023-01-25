Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85267BCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjAYUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjAYUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:35:33 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9359B58;
        Wed, 25 Jan 2023 12:35:31 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1442977d77dso22642fac.6;
        Wed, 25 Jan 2023 12:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moiufMQUU7UGAHvlsv+XSSPZUsPQZkEoM/OgPbzoeHs=;
        b=PMT9oVMh5KUzl1w72TAB/wYPV1hetKMPOJXa+ecaMwa13ImHQAjGbrWB6Ldx1CAs2n
         tVmYzRe7kHNxAcYmfUksoUt0m04Fsgewqkav4DIhS1Oo4KgPIfCNZt2jmCqlVqFhEXGm
         P0EX5+ixmn0RDCAEZ+xsxgzqvOU2c9GhdtixSAnbAmNvq3l3k302RaiLdkNg4eSutIku
         s8suXXCc7vk5zzOHUmoST3FUsn6C8nkvaw2/gPUKJFAEJ0E3mkRsqGS3Nlufh1+dCEBu
         5MQHu9qF6P1qqh0OoMBv2tpr4iY6biwOwcUQNKU8W2bst+pKbRw2i0xx0xunpwSSQ8YG
         pibw==
X-Gm-Message-State: AO0yUKVMuo3WsLGv50xOAidAGjwypODTxN3ZT1T9Q/v2sW+dui5tuCix
        eyrJXk5xaX6yVdELszFp2g==
X-Google-Smtp-Source: AK7set82Sv2tPnfS0f7sY7zxfI3PJ9ekb8UIP02XBGQpey5HlRn/W8pcSJHjnTffo1P4rZJeTA4N6Q==
X-Received: by 2002:a05:6870:b694:b0:160:34a0:546 with SMTP id cy20-20020a056870b69400b0016034a00546mr4741222oab.40.1674678930451;
        Wed, 25 Jan 2023 12:35:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ls11-20020a0568704b4b00b0014c8b5d54b2sm2338315oab.20.2023.01.25.12.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:35:29 -0800 (PST)
Received: (nullmailer pid 2861351 invoked by uid 1000);
        Wed, 25 Jan 2023 20:35:28 -0000
Date:   Wed, 25 Jan 2023 14:35:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v11 2/6] dt-bindings/thermal/mediatek: Add LVTS thermal
 controllers dt-binding definition
Message-ID: <20230125203528.GB2855708-robh@kernel.org>
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-3-bchihi@baylibre.com>
 <2471a5de-b7a6-fea7-152f-4fe25063abf9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2471a5de-b7a6-fea7-152f-4fe25063abf9@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:14:17PM +0100, Daniel Lezcano wrote:
> On 24/01/2023 14:17, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> > 
> > Add LVTS thermal controllers dt-binding definition for mt8195.
> > 
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> 
> Krzysztof, Rob,
> 
> are you ok with these changes ?

It says v11, but I sure don't recall the 10 other versions...

Rob
