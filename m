Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680416910E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBITDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBITDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:03:02 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C05D1EB;
        Thu,  9 Feb 2023 11:03:00 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 14-20020a9d010e000000b0068bdddfa263so846289otu.2;
        Thu, 09 Feb 2023 11:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIG7XVUrEvHxHM2W2SVN/mGj6ui8gtTwgh3+jRqlHdg=;
        b=8IM8V3G5OWrZr6iwAs3K9hQ84jkviqvHg97FpWrp1TpU21hLJbd9tFO8JCTr9FnwAX
         z4KrAD9bxULAShLqed467hhp5xIvf6e1lZXxFfGSMFEXxY543ebpXMxpdp/ls2ZlfCFU
         IMpRjOysLaNQgNX4cNHzfh/JXluEz52OpDXiAQ/S3z2IlYyiNPdL/6MBqI45EI2yLWJC
         xnF6Y8ysQUuH58p8rL8ozxnZi0ZGYKJXm7mSWYLZpKpw7HhQGIZVH5IOATwqMXaI6oz4
         +aVwru8iiuKArdYJCyyglYzYYtONj0DCt9l7x3hYbuqB0dFhTjDtWeSo6xPuR3t5m5V6
         R1Fg==
X-Gm-Message-State: AO0yUKUNZHdniVSPmU8FjhVQm0cWtaKMtlRLMqA9qAYMxxttiEKAMGnD
        Xq3EyLF6feTOf9yt5zNb8mMFehRTvg==
X-Google-Smtp-Source: AK7set890dZ1sGgTNR93HC0ONDrNKfdkvrQ0cgzhuVqPSxNlKEotCQrIOOY1TJCe6wzGYabR5mBGyw==
X-Received: by 2002:a9d:12cc:0:b0:68b:c490:5372 with SMTP id g70-20020a9d12cc000000b0068bc4905372mr7565476otg.22.1675969379619;
        Thu, 09 Feb 2023 11:02:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u4-20020a9d4d84000000b0068d752f1870sm1065872otk.5.2023.02.09.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:02:59 -0800 (PST)
Received: (nullmailer pid 639835 invoked by uid 1000);
        Thu, 09 Feb 2023 19:02:58 -0000
Date:   Thu, 9 Feb 2023 13:02:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/12] dt-bindings: remoteproc: mediatek: Improve the
 rpmsg subnode definition
Message-ID: <167596937758.639777.17645426181511229001.robh@kernel.org>
References: <20230209074021.13936-1-tinghan.shen@mediatek.com>
 <20230209074021.13936-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209074021.13936-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Feb 2023 15:40:10 +0800, Tinghan Shen wrote:
> Improve the definition of the rpmsg subnode by
> assigning a distinct node name and adding the
> definition source of node properties.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/remoteproc/mtk,scp.yaml          | 31 +++++++++----------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

