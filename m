Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B87690F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBIRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBIRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:46:49 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA75C88B;
        Thu,  9 Feb 2023 09:46:45 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id z25-20020a4ad1b9000000b00517affa07c0so277607oor.7;
        Thu, 09 Feb 2023 09:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSXbtWoaGGp/BTK6eNZyW7mgvCIslW3pWGgTjKzsKzo=;
        b=nGKP8RnURJ2Bag2bN67RBH2hqTog7j+U+mB1O7YR0ZEPemEZA+4U2vWYbyN3qVFKb1
         /zpBlU4CuYICLH8BE4IJvJAXwQc0mTxS0Z9WX7KN2M2T84JNoUzs6QUGSL2KaAbANg1u
         W+RgpkESCIY1AphLVPeWLJcGA5OQDnQ+CevY2xc4RbPID1tfnpSopEN0Jwmn/KKMtay6
         Wto4yEamqQJVwPXbTMl4fRJ5C6/fA98zYR2YPdXYbXBDX6JWI1EQNh7px8IGSV2qMU1W
         OMRnJqUTeGRCB/CpAEZrOPQvy1Ien2DKTXayk0Bdd9e6zbts9rkAmFeuAdSXElPZ/RE+
         deuw==
X-Gm-Message-State: AO0yUKVbldihdXKRTyfJBvYCl8yNHm7t3J5c9JjPZuNBov1FFiJD2Abd
        u4fukRmbyCpFqRbdEonp/Q==
X-Google-Smtp-Source: AK7set/eXd6Yae5b5DJrkNsNG5JrvEE5wM9N1+YnsOlzDB7xG37bnt0BvLI1Wk6P5udfi3frUiEWpg==
X-Received: by 2002:a4a:a34a:0:b0:51a:c9a:ee78 with SMTP id u10-20020a4aa34a000000b0051a0c9aee78mr1295818ool.1.1675964805065;
        Thu, 09 Feb 2023 09:46:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p6-20020a4aac06000000b004f241603c49sm990419oon.20.2023.02.09.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:46:44 -0800 (PST)
Received: (nullmailer pid 557296 invoked by uid 1000);
        Thu, 09 Feb 2023 17:46:44 -0000
Date:   Thu, 9 Feb 2023 11:46:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 01/16] dt-binding: mediatek: correct MDP3 node with
 generic names
Message-ID: <167596480328.557242.18288362631745115908.robh@kernel.org>
References: <20230208092209.19472-1-moudy.ho@mediatek.com>
 <20230208092209.19472-2-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208092209.19472-2-moudy.ho@mediatek.com>
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


On Wed, 08 Feb 2023 17:21:54 +0800, Moudy Ho wrote:
> The DMA-related nodes RDMA/WROT in MDP3 should be changed to generic names.
> In addition, fix improper space indent in example.
> 
> Fixes: 4ad7b39623ab ("media: dt-binding: mediatek: add bindings for MediaTek MDP3 components")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../bindings/media/mediatek,mdp3-rdma.yaml    | 29 +++++++++++--------
>  .../bindings/media/mediatek,mdp3-wrot.yaml    | 23 +++++++++------
>  2 files changed, 31 insertions(+), 21 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

