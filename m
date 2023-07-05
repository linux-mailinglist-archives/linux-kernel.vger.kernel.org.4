Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1A748DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjGETbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjGETa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:30:58 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5895198D;
        Wed,  5 Jul 2023 12:30:47 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-785ccf19489so333980939f.3;
        Wed, 05 Jul 2023 12:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585447; x=1691177447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3mlRz7gktaWpRdrv06g72Yt1MD5uxYRKr++3Evm7ZM=;
        b=i7UmV1/a+Mxfq79BP/a1bF5FeQgDk5frJiglxmRoVYMcrVPLBMsl2oSDcwb7FgL+T8
         wzzaVEJ8omfk+djGN8wSjNyy3A4Yiep8NpmPtkuUJK1YF2t6+qBW+3Tn4GUxVkp7L3dF
         RMfT+eehkAbuuh5Y0vcF+GFGz4RQ2OcEpzA5qxvJ830hJz6ZDN8/d91infQdiWuIKLVa
         Zmh023khgu3GDdNUKZn/tGZchffyL1CIFSAQP4AGTThfLLb06g8zAn+841oC/M8w5Oi0
         Np0506ffLj68b8LFb8hXhp8w1mSMB/YhXQnIihhq+qD7QdAFVgl3R7r5sOIkVpc58U8S
         FKMA==
X-Gm-Message-State: ABy/qLY0XgFcAqO1py7g8XLW0T38BoiwPYqhgdwuZUDjImpIKxFEoxB+
        PrJ2Hj6W/aiwBk/emjgBRg==
X-Google-Smtp-Source: APBJJlEzFhLmGb+irBzIwS0P0x8xQEA1wCS7orNzq6bNP8zuCZeppl8Ds3njMNRfclsij6AuH8FhOQ==
X-Received: by 2002:a5e:c916:0:b0:783:6526:a1a0 with SMTP id z22-20020a5ec916000000b007836526a1a0mr41501iol.15.1688585446834;
        Wed, 05 Jul 2023 12:30:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t4-20020a02c904000000b004266b4a05afsm7981950jao.39.2023.07.05.12.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:30:46 -0700 (PDT)
Received: (nullmailer pid 1702773 invoked by uid 1000);
        Wed, 05 Jul 2023 19:30:43 -0000
Date:   Wed, 5 Jul 2023 13:30:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jason-ch chen <Jason-ch.Chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: Add mt8188 pericfg
 compatible
Message-ID: <168858544290.1702735.16154973553045477437.robh@kernel.org>
References: <20230705065744.25848-1-jason-ch.chen@mediatek.com>
 <20230705065744.25848-3-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705065744.25848-3-jason-ch.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 14:57:43 +0800, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> Add mt8188 pericfg compatible to binding document.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

