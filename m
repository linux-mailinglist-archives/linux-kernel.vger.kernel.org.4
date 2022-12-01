Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FD163FC61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLAX6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiLAX6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:58:03 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD1205F1;
        Thu,  1 Dec 2022 15:58:02 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id m204so3771575oib.6;
        Thu, 01 Dec 2022 15:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWVVNliZTYEWF5fFNtzs+9P9giHEjE14UGyme1WyflI=;
        b=TBWQrE9NWrWpDpF4b3BR19Q6vT1wNP0Q2GvixVNw77C0p4iPPtoPMCdlFST6qjmzF+
         79uph4DXb2dkhD85u7ja1s2gDPKCJE6EXTb9fkKbzaRhYbwbXkCW2vtH8ByInwkeQzTO
         SPsLYhz7KDBgb/FAoZEsJYSId4sU79rbsqcUyBiFsxp09meFFz7kJY9PJCHhP1ujUOFg
         0Rz5ihgU3B2hiHf2OFWIQtmNX/SycMNKNoaUycYxpKqvwi/awMgN7fCEhs2Z2AKGLFFO
         BDOilc0cDhrq1ATAQdQVXzYCUPHJi7LoYKY+hlRpoSBxRAFEpkE+NVUfORKZbFrItld/
         eH4A==
X-Gm-Message-State: ANoB5pkGL1yvLojorqb9q0a6GTL/wUC+TO0PP6iFrvsioa7tC6DfKQ73
        XYXx+48XJYMEsMKnUfpRIA==
X-Google-Smtp-Source: AA0mqf4YVTkuZvfflbzP+Mc3FwFsYD5Oo+5FxUcIgBACGlK4Na2GfKNmSrAZRDWlBHAEh8J3UbTh3A==
X-Received: by 2002:a05:6808:81:b0:354:b67e:611d with SMTP id s1-20020a056808008100b00354b67e611dmr34806088oic.210.1669939081714;
        Thu, 01 Dec 2022 15:58:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ca19-20020a056830611300b00661a3f4113bsm2731191otb.64.2022.12.01.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:58:01 -0800 (PST)
Received: (nullmailer pid 1720098 invoked by uid 1000);
        Thu, 01 Dec 2022 23:58:00 -0000
Date:   Thu, 1 Dec 2022 17:58:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3,2/3] media: dt-bindings: media: mediatek: vcodec:
 Change the max reg value to 2
Message-ID: <166993907978.1720037.12508933639302184491.robh@kernel.org>
References: <20221201121525.30777-1-yunfei.dong@mediatek.com>
 <20221201121525.30777-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201121525.30777-2-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Dec 2022 20:15:23 +0800, Yunfei Dong wrote:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
> 
> Need to add racing control register base in device node for mt8195 support
> inner racing mode. Changing the max reg value from 1 to 2.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml      | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
