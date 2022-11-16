Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1662C660
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiKPRak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiKPRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:30:37 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3628A32B9D;
        Wed, 16 Nov 2022 09:30:37 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13c2cfd1126so20855294fac.10;
        Wed, 16 Nov 2022 09:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d94m8A4mnC43bFCgCMyqlrhWiu3NByipxHjP5JFmrF8=;
        b=M9zvtOWURcE5oFPDm2eaQvKS9seyj8/RWrCO7Li6pIOFRh/BdbEOqe+Z96AA0YGnqz
         z6+5bDMG0z3X8s7kDDfKXce7Fxm2oqKqEFyU+sUgq6nElN5evXSRaxrKWk6oAcq8sYbL
         aR/kcq4SBHcPzQxzomqeeF9pNPmz7jcE0EAYzgQW8VWM+9loUdqWG+BpCDHBF4UMav1J
         0EVqZb2YuR02zui5/W9fjIhKDvDfp/mDhCNLLGAdD6lz1R5RjDp8n9KZhmv3mgx5owjI
         IX1+m2GbShEFm9BejZ0Jqa5k8T4YgQkcLw8DjALZhVV0w+SFt3vZ+LlazJwGBN/2F52C
         Ojrg==
X-Gm-Message-State: ANoB5pnScmTvfY5qWp5SjCUzOVXaDlMk9YGxos8TTQsfRXkG+ikRBFq/
        4miyz+6OXazf6QX0vpjRTw==
X-Google-Smtp-Source: AA0mqf4W9ic8trKFbcLCupIweHpywnpJAlbo74qba9pJnN/1t1QeCfL5Lgix9ZRfDFycFgC2Pz6D9Q==
X-Received: by 2002:a05:6870:b40d:b0:136:b625:9d4b with SMTP id x13-20020a056870b40d00b00136b6259d4bmr2234868oap.247.1668619836444;
        Wed, 16 Nov 2022 09:30:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a4aa802000000b0047537233dfasm6208359oom.21.2022.11.16.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:30:35 -0800 (PST)
Received: (nullmailer pid 555476 invoked by uid 1000);
        Wed, 16 Nov 2022 17:30:38 -0000
Date:   Wed, 16 Nov 2022 11:30:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-mediatek@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steve Cho <stevecho@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2,2/3] media: dt-bindings: media: mediatek: vcodec:
 Adding racing control register base
Message-ID: <166861983726.555415.9641697136442986438.robh@kernel.org>
References: <20221110102834.8946-1-yunfei.dong@mediatek.com>
 <20221110102834.8946-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110102834.8946-2-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Nov 2022 18:28:33 +0800, Yunfei Dong wrote:
> Need to add racing control register base in device node for mt8195 support
> inner racing mode. Removing 'maxItems' and adding 'minItems'.
> 
> Adding description for each reg.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> compared with v1:
> - add description for 'VDEC_SYS'
> - add description for 'VDEC_RACING_CTRL'
> - add description for 'VDEC_MISC'
> - change maxItems -> minItems according to AngeloGioacchino's suggestion
> - Fix dt_binding_check fail
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
