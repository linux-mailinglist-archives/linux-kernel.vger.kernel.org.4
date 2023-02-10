Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E878E691920
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjBJH1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjBJH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:27:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9B5BA42;
        Thu,  9 Feb 2023 23:27:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml19so13582118ejb.0;
        Thu, 09 Feb 2023 23:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gklS3FAiP8CjmVjxSYJByCBxxX2M8eLNPi6SGKg0SSU=;
        b=LP3fB0sauO/2tmXyRx85cBUpb6irgkVj5mLS6jLKWiSk2ijBn3h476Y6cPPmen71vX
         sleFX7p1axeIlv5Q201fJy4FPuxsTA6z4zGwcnMHrWQCTqg96ECmIZrapmGYMUiIbTsg
         b/az1LvPqX3Xef3uubTKxQPda6krQZ+a5xi4aWrdVZQQpRBjeuCSW0enPCVgZkdaO/7Q
         W/+niQL6R0Ep4itcHj32QTrXV2p1/LGD3iFSezkPkPvhJtn8nNmnz8nEmWnGKX05VWNW
         rTdm8YwYy+zKzk3TPLdTBO0JYi0XUHggOy4dv7bAEPfaC9evPxRTCe9bK05EA5KCh3P0
         4New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gklS3FAiP8CjmVjxSYJByCBxxX2M8eLNPi6SGKg0SSU=;
        b=Kmj6KFF1P9AQvrnLM62aIhI2QjVEOQsteTigG5KGfyIac8Tn7YRrFe8TPvIyosVxl1
         nGi6DvajCEQwQSNbPIVYdLnB8lHdJlKoysgGuV3VIYsR2E84lRHdDe8rXit9KrPHskm2
         m8dLtZ1vmlYjMLbD1UqGc3pMSiz1zfq4F3BjPGeXHpl2MEZI4mHvJzhtBBy4Ql2/vNUX
         9/03kwlWjP4AAeJm8jAjl3/l1w8ps3i6ph+E/5FUx4C8aeeP1KcFGFHKnEg49v3IenN4
         Eapgf/IE790B5HK9IjHKkHcVWBYHttn8EreOcV+aGwqJYSMBxItUVl3aQwf4SQul7HOi
         RnzA==
X-Gm-Message-State: AO0yUKX78VBlXybH1G7wXjSOwBT9B4bIQQu3U5nVc98rRa86W3ZZJCIV
        lO97E/2ArPuipkYllIitaII=
X-Google-Smtp-Source: AK7set9ItifQev8+p52y0b5h6z/ngAGGDwVCaKSgu4+C6cUktAAmwUb53s5HzuzYJZGsMdxceXgSPw==
X-Received: by 2002:a17:907:3ea2:b0:8aa:a802:adcd with SMTP id hs34-20020a1709073ea200b008aaa802adcdmr17054242ejc.30.1676014033423;
        Thu, 09 Feb 2023 23:27:13 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-57-202.cust.vodafonedsl.it. [188.217.57.202])
        by smtp.gmail.com with ESMTPSA id k6-20020a1709065fc600b0081bfc79beaesm1972542ejv.75.2023.02.09.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 23:27:12 -0800 (PST)
Date:   Fri, 10 Feb 2023 08:27:07 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] media: mediatek: vcodec: Force capture queue format to
 MM21
Message-ID: <Y+Xxy49JcqXlKADI@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230209074025.1816-1-yunfei.dong@mediatek.com>
 <Y+S1cA4PXT1MVJm8@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <28f167b7-c468-8752-29d1-2a122e8142dd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f167b7-c468-8752-29d1-2a122e8142dd@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Thu, Feb 09, 2023 at 01:56:45PM +0100, AngeloGioacchino Del Regno wrote:
> Il 09/02/23 09:57, Tommaso Merciai ha scritto:
> > Hi Yunfei Dong,
> > 
> > On Thu, Feb 09, 2023 at 03:40:25PM +0800, Yunfei Dong wrote:
> > > In order to conver the format of capture queue from mediatek MM21 to
> > > standard yuv420 with Libyuv, need to force capture queue format to
> > > MM21 for Libyuv can't covert mediatek MT21 format.
> > 
> > Sorry, just some clarifications on my side, just to understand :)
> > The problem is that libyuv can't convert mm21 format into yuv420
> > than you need to use mm21 (forcing this).
> > Did I understand correctly?
> > 
> 
> vcodec can output either MM21 or MT21C; libyuv can't handle the MT21C format,
> at least for now, hence he is forcing vcodec to always give MM21 for things
> to actually work... at a later time, I hope and suppose that this driver will
> change to not force anything anymore.

Thanks for the explanation!

Regards,
Tommaso

> 
> > Thanks in advance,
> > Tommaso
> > 
> 
> Yunfei, since this is required to get "basic" functionality, this commit needs
> a Fixes tag: can you please add the right one?
> 
> Thanks!
> Angelo
> 
> 
