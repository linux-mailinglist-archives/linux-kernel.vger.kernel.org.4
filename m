Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6D5BA3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIPB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIPB2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:28:39 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6671BFB;
        Thu, 15 Sep 2022 18:28:38 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11eab59db71so49994323fac.11;
        Thu, 15 Sep 2022 18:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UkEDuL7RkJje1ybCpvMuHrhS0RikUQWzoLzozh6GvAM=;
        b=3YuY9GI2EG8De6z9qbLP5wEXhLLSQSkX10yGl9ydO6QEp2e6Q8HJV1pMw/+JdOn01J
         CKIPzYOIhcodvdnyfiJHpEZozkif5VnGLXsqC98tFdtmK5w8LIlBfmDxW4IZXiGTdq5s
         UO9eaNBm0YBSr/bTG/yKkDO0ypgdYm9omMA1N3WN7VAjx0IDrAkgO6PjJyJl/iiWf94Y
         HztYvy9oKaQYl2yzUMB0XVxLOtJdQF+Cv3X907CSl3ioBcwhrj2HDQZdm9Xd+xJt5p8h
         gYY6/89/JvQgVVfX5dL2SyNRyMjnydmhwn5xbcQMpdyv3tn950nQ7VAyRfZcvi131owA
         vGUg==
X-Gm-Message-State: ACgBeo26E1KBOFNvbu1yymB+XFl35KiFt8vZ3pAMSll7bi7YfJ4EojY2
        r3k4bnIy7eVKYQBJyPoSuw==
X-Google-Smtp-Source: AA6agR7iDIbG5iuuyYzEX3sYvdifMDH/GOPsdSZMCWjyv/+6aHZMgdVrdi2DHFpBMf9sIVl9KyXaFA==
X-Received: by 2002:a05:6870:c34e:b0:127:a3df:8ff with SMTP id e14-20020a056870c34e00b00127a3df08ffmr6921135oak.186.1663291717570;
        Thu, 15 Sep 2022 18:28:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x30-20020a056870331e00b00127a91041a9sm2078500oae.38.2022.09.15.18.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 18:28:37 -0700 (PDT)
Received: (nullmailer pid 2725214 invoked by uid 1000);
        Fri, 16 Sep 2022 01:28:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        houlong.wei@mediatek.com, linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        matthias.bgg@gmail.com
In-Reply-To: <20220915101716.70225-1-angelogioacchino.delregno@collabora.com>
References: <20220915101716.70225-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: mailbox: Convert mtk-gce to DT schema
Date:   Thu, 15 Sep 2022 20:28:36 -0500
Message-Id: <1663291716.321839.2725213.nullmailer@robh.at.kernel.org>
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

On Thu, 15 Sep 2022 12:17:16 +0200, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce mailbox binding to DT schema format.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mailbox/mediatek,gce-mailbox.yaml         | 104 ++++++++++++++++++
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |  82 --------------
>  2 files changed, 104 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: Documentation/devicetree/bindings/mailbox/mtk-gce.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

