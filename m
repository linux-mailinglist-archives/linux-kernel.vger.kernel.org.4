Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1562D646010
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLGRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:23:50 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018142F74;
        Wed,  7 Dec 2022 09:23:49 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so18331ooi.5;
        Wed, 07 Dec 2022 09:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qhhglclNe/Y+Ww2TBaF/Rt3nwv66/xfoqUyqPeiMww=;
        b=BRHTE9fkdjDmVOpu+hy4mrR8CKSU9jiit/CBiDLDpqwEJwDMIqIrP9vAaNZ5I7oXnr
         eM4VzwHbo44qUbWWg4DW+mBSKJ2TuvCBjTKkWZTMF7J97TrRcOl6XIpKBhSTIfYDzdZ8
         WN6bOWUPPDrChtS2li0kuJ8amvmzhzqlbpvdPWQ+jg5H1Odt5Had1AIQ8/YVLQRc1WCx
         4C49f4zzMus3AycOQSW42jWMn6LijK2GOhYx9Juh45ZkR3r5xwEbEpbSY6XpTYzSCEhM
         m60DXJLmBD2TsgpBvw3JE4OBIMNt8TEHMW7FSm5R6KzlGSvREhnKZUeBJcSSa1OhbLX4
         21Qw==
X-Gm-Message-State: ANoB5plPMyrrxivGwhR0raJal7TxkR/Y4gzmHftbaR49KfO3kWvc4KAe
        xaKLMhGJklKqRNURUwhIgg==
X-Google-Smtp-Source: AA0mqf6Rie1pRr+wry5Yh3B2mB24YYud/ZXySwS1VnTqqk88pTw8r/yGavdUGW7iQk1zoJz50LknPg==
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id e5-20020a4ab145000000b0049f449a5f6cmr30324598ooo.93.1670433828843;
        Wed, 07 Dec 2022 09:23:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a4adbc4000000b0049f5ce88583sm9112297oou.7.2022.12.07.09.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:23:48 -0800 (PST)
Received: (nullmailer pid 2437289 invoked by uid 1000);
        Wed, 07 Dec 2022 17:23:47 -0000
Date:   Wed, 7 Dec 2022 11:23:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Steve Cho <stevecho@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v5,1/3] media: dt-bindings: media: mediatek: vcodec:
 adapt to the 'clock-names' of different platforms
Message-ID: <167043382716.2437231.1367322252075275050.robh@kernel.org>
References: <20221206064536.16592-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206064536.16592-1-yunfei.dong@mediatek.com>
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


On Tue, 06 Dec 2022 14:45:34 +0800, Yunfei Dong wrote:
> mt8195 and mt8192 have different clock numbers, separate 'clock-names'
> according to compatible name.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> compared with v4:
> - change min clocks and clock-names from 1 to 4
> compared with v3:
> - rewrite clock-names according to different platforms.
> 
> Reference series:
> [1]: v5 of this series is presend by Allen-KH Cheng.
>      message-id: 20221128143832.25584-4-allen-kh.cheng@mediatek.com
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 41 ++++++++++++++++---
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
