Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3955B8D09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiINQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiINQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:28:43 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A767B832EB;
        Wed, 14 Sep 2022 09:27:49 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1280590722dso42472048fac.1;
        Wed, 14 Sep 2022 09:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0Y050b+bqDXjMFJ0FQAtLb9qk0gbyprIyKNchoQmXT8=;
        b=El924nw0bwKHOBPgPNhF59PcrfgNTmbLFUwXnXPgWQih6/K5ZnKZjkR96Z1NGGfgPj
         F7+HEEIVJ64Mal6gPVvn9+BXO8PJ7Gy9ExT834f7auZj8fyX6SpyzXHHST8vswZoPsTb
         4heZacP/raQR5awluHgjR3zCdc+ka0ifyTVJ0KjOr9siGu2Mvnt/yeZ8d2eOCbXWvd+k
         kjQoJxY7fhELJEKyIWbYaM0JPJFBWxH4iVEV4ac7nOaXIrWVkeghjZsjBIAHeYfe7lf0
         QOX4YJMXRdKa3D4ezngKCc+/oRhR/EZLN2NhU8BzmrwsXOAoavtpS0OeqPIAhS5KYDwN
         Jylw==
X-Gm-Message-State: ACgBeo1SljhE25FMXjv+arM/i+8r3Jjumhqwln7xmXL+rt0IDhvGhjQ4
        80NHaHmUz1N+mAjlzD+x5Q==
X-Google-Smtp-Source: AA6agR5JPh3F/7WxyKo5hFzduVLue4pftUF2pPAoQkbx7N1C4y8oQD4shtXx254V59inZFs9XEpmlg==
X-Received: by 2002:a05:6808:140e:b0:344:d2fb:43fe with SMTP id w14-20020a056808140e00b00344d2fb43femr2244433oiv.112.1663172864306;
        Wed, 14 Sep 2022 09:27:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w35-20020a056830412300b00657a221eb71sm848607ott.65.2022.09.14.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:27:44 -0700 (PDT)
Received: (nullmailer pid 2502825 invoked by uid 1000);
        Wed, 14 Sep 2022 16:27:43 -0000
Date:   Wed, 14 Sep 2022 11:27:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dmitry.torokhov@gmail.com, linux-mediatek@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, chen.zhong@mediatek.com
Subject: Re: [PATCH v2 2/2] dt-bindings: input: mediatek,pmic-keys: Add
 compatible for MT6331 keys
Message-ID: <20220914162743.GA2502746-robh@kernel.org>
References: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
 <20220914103021.43593-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914103021.43593-3-angelogioacchino.delregno@collabora.com>
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

On Wed, 14 Sep 2022 12:30:21 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the keys found on MT6331 PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
