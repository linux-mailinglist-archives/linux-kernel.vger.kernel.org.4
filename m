Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90479634B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiKWAIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKWAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:08:32 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB869D2F65;
        Tue, 22 Nov 2022 16:08:30 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id z3so12157062iof.3;
        Tue, 22 Nov 2022 16:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5ZPbYkKnK2IkXf6T8FgMRx12jqOc1F0dei+USA8qpg=;
        b=RWoJBoWJzSOjSw0arqQcRF3UNU5Qq2oD/uegmSJDwt524HCaUaAQOd9NXWannpyQaM
         N6y2z4AgFpQr8BBZL0WdZOSNkYiQ8GcouHNN9+8weK3PLiXFbwNOHKRhxb9gUytqbHtZ
         AT0VR2ZpHUv3DTMPVBP3uiu4sxhJrERnt1V/Q0CKDyNeibV1cgVO0aM0BK1rtUIju2WW
         GJ9akvm0cIx0Q2GcZ4C+6Jhdtx0+K19c2NTimy1sFObIZkt+yXPzszAslmv1ZCzHpByg
         7Zatp5JvCQdHKV3C+Qpvx3uKAiE2OMcHNHfIhiZERdVTnTni9zF12oipPs+Je/g1bn5y
         Ov4w==
X-Gm-Message-State: ANoB5pnuThT1QTCPDD/Hs+AqR3f9bLkZe+PnHbx/PTAUexbWXoddpKgu
        rZD3HQyKTJmlhVSbsEhmIg==
X-Google-Smtp-Source: AA0mqf6Wr7xqm6RogMUZda84qHyMvqZUsWZi6Gq6zcsxkRFMGZ1oVHNeafF1Qzbl4qKI3CfQBYwImg==
X-Received: by 2002:a05:6638:3458:b0:376:24f6:2dc3 with SMTP id q24-20020a056638345800b0037624f62dc3mr11956348jav.26.1669162110050;
        Tue, 22 Nov 2022 16:08:30 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z7-20020a05663822a700b003752e5b3c23sm5756588jas.20.2022.11.22.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:08:29 -0800 (PST)
Received: (nullmailer pid 828924 invoked by uid 1000);
        Wed, 23 Nov 2022 00:08:31 -0000
Date:   Tue, 22 Nov 2022 18:08:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Neanne <jerome.neanne@baylibre.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Andrew Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] dt-bindings: Move fixed string node names under
 'properties'
Message-ID: <166916210667.828774.15527231190149112577.robh@kernel.org>
References: <20221118223708.1721134-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118223708.1721134-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Nov 2022 16:37:07 -0600, Rob Herring wrote:
> Fixed string node names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified node name.
> These cases don't appear to want a prefix or suffix, so move them under
> 'properties'.
> 
> In some cases, the diff turns out to look like we're moving some
> patterns rather than the fixed string properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../arm/tegra/nvidia,tegra20-pmc.yaml         | 54 ++++++++--------
>  .../bindings/regulator/ti,tps65219.yaml       | 14 ++--
>  .../bindings/sound/tlv320adcx140.yaml         | 64 +++++++++----------
>  3 files changed, 66 insertions(+), 66 deletions(-)
> 

Applied, thanks!
