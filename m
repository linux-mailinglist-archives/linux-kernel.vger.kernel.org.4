Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD186DF91F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDLOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDLOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:54:56 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A27A9A;
        Wed, 12 Apr 2023 07:54:28 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1842df7cb53so14075690fac.10;
        Wed, 12 Apr 2023 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311248; x=1683903248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1ld4A+EyaOJZgwE8soDndJOLjPy4G9o1T3qC2VEjLU=;
        b=0ARfFbpgur7h4Yt2P8YeDZoQj1+yom6knpyUKFEp130QQRfG5BwUKCazyzXtoKTjjD
         lQHHUNDLlX1MgCJ+OvBZAohh5iPO924JrSOXhYgDZlW4EX2leRAjQotiJznYewpg4btF
         JN2deD0k7QReFbSQKR/ELYFG+6PJrr6AWFvK8J8uryn0Hs1Evjm51466Nk/JkXDJ33Qq
         XedpREnd8kIX4Jgcw/BMjtxEy5Ap8yWnaWUINH7ud5EXATKfRxeUKIPmXilGv1KnVwER
         64c3KGJbzLIDvGX3poySDZ6Tva+XG7O9iJpAm+1f2p+sXyBugfP8ENQo1L1EOmHvA3uH
         J6ZA==
X-Gm-Message-State: AAQBX9eNcgQcsmjjrCr7iHRy7yjQ4LA7h4t7ayUvwevmb9mtnmE08DgI
        7fT2Dt5q501anMBsuvd/TQ==
X-Google-Smtp-Source: AKy350at9PyNT3M+ayDldLAfkYAQQX91gENPKVxW3VTEOJNxL5dGtdL3HANsRimXIALqRDVmi7e/EA==
X-Received: by 2002:a05:6870:4687:b0:17e:7d94:8b39 with SMTP id a7-20020a056870468700b0017e7d948b39mr12087755oap.41.1681311247820;
        Wed, 12 Apr 2023 07:54:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s32-20020a05687050e000b001729072f759sm6290375oaf.0.2023.04.12.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:54:07 -0700 (PDT)
Received: (nullmailer pid 2352212 invoked by uid 1000);
        Wed, 12 Apr 2023 14:54:06 -0000
Date:   Wed, 12 Apr 2023 09:54:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 6/7] dt-bindings: usb: mtu3: add two optional clocks
Message-ID: <168131124617.2352153.5564680427072213630.robh@kernel.org>
References: <20230407082937.14558-1-chunfeng.yun@mediatek.com>
 <20230407082937.14558-6-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407082937.14558-6-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 16:29:36 +0800, Chunfeng Yun wrote:
> Add optional clock 'xhci_ck' and 'frmcnt_ck';
> Add optional property "assigned-clock" and "assigned-clock-parents";
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: remove assigned-clocks* properties suggested by Rob
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

