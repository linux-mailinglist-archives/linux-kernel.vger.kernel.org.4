Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E796524F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiLTQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiLTQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:49:47 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4018394;
        Tue, 20 Dec 2022 08:49:46 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id e205so11026001oif.11;
        Tue, 20 Dec 2022 08:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpjiiMMEKUx7aLu2jmHLYDP5YyYL+OfcLX43RIXmyx8=;
        b=6181fak1LfSuntuymU13zXw1HjfSAvTj+9CNdgDcUvLDn31+oO2WMXHa2ivyFhcyKf
         aKam/6MiW/A0tVaq4YLi2Q0wgB8pQk4DPbwsajGxvuwGvwqVAvZWpM5x1V1F3/l39MNO
         V/0DA2WpTkLekZyrYxN8jURE1x7QYaTn1yl+bYxV378GI0tXhnEZxdV9bxON6BpeI8Pa
         i1v522ZbMAwuR9vaYkWMiZ4vZoYtnz3D9PkdRiHKosYC6HCGwC1wexI4HcYN6zY5YuGp
         khDPxVOkaN6ZVs4A76vP1kUK7Y5/kBv+7SEVe340DmPq726uw16nEA8fz6nHvi6boOQe
         +lRw==
X-Gm-Message-State: AFqh2koRtRkLf0tyRxVc3H6zQ874GU0naQAjDRs3o3IwwUAm7HNMDcjI
        81J2ZPYXDTKGlqcb5Ij9LA==
X-Google-Smtp-Source: AMrXdXucVzUYs3Qv4dUgwQz43Bm+id6hoba4q8xaAN5FGBFUMAmXiZFy27bVsiKNTFbzkSXCaWXFtw==
X-Received: by 2002:a05:6808:1525:b0:35c:3e8e:de6e with SMTP id u37-20020a056808152500b0035c3e8ede6emr8244033oiw.22.1671554986222;
        Tue, 20 Dec 2022 08:49:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l19-20020a544513000000b0035b7002af8csm5688297oil.56.2022.12.20.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:49:45 -0800 (PST)
Received: (nullmailer pid 726623 invoked by uid 1000);
        Tue, 20 Dec 2022 16:49:44 -0000
Date:   Tue, 20 Dec 2022 10:49:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-kernel@vger.kernel.org, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, daniel@ffwll.ch,
        swboyd@chromium.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, sean@poorly.run,
        dmitry.baryshkov@linaro.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_abhinavk@quicinc.com,
        konrad.dybcio@somainline.org, robdclark@gmail.com,
        freedreno@lists.freedesktop.org, david@ixit.cz
Subject: Re: [PATCH v5 06/21] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Message-ID: <167155489243.724404.14934163321956490554.robh@kernel.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-7-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220123634.382970-7-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 12:36:19 +0000, Bryan O'Donoghue wrote:
> Each compatible has a different set of clocks which are associated with it.
> Add in the list of clocks for each compatible.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../display/msm/dsi-controller-main.yaml      | 189 +++++++++++++++++-
>  1 file changed, 179 insertions(+), 10 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring <robh@kernel.org>


