Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED2710D24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbjEYNUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbjEYNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:19:59 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D5F18C;
        Thu, 25 May 2023 06:19:58 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QRpZ35Pkxz49Q76;
        Thu, 25 May 2023 16:19:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1685020795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qetPBPgd9hVIq6M58pwalvrkrjuv/rSJBgHk7CnDNA=;
        b=NQbDvhVxiaRGXJjuc+Jd2Ockby8SWIOEsMstnWOA5IhXCMoIrFElwCykOp3L+zm7yjC3cY
        Zc/ZxrremUTWFoMLrTKD7ZtVZgYvUbqLwoWggnTZkRc9RgnD4stzgPLitp3bo4IrSytg5g
        a6K1P/vufidWxIRLT29wj5/Gx/ixNpL1vO22RaXuvKEqSmOoda2hFwKK7DqnIqugOUvewa
        KGh7/EDBCyK2Jumr6W/kxjajCjRj8PDbpdGKhUpEeWGw7PmDKcJys0ykJx2yRzTjROgJrv
        pYmJMjlYdzQBker9uQbW2shaIQHjR+9a+POQ/RAu86zhGgIN1VNPFiGUTEaCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1685020795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qetPBPgd9hVIq6M58pwalvrkrjuv/rSJBgHk7CnDNA=;
        b=aoVtERg41iMgL2DTOyJXSGRwV7K+2GDB2coIVsnzxBxCJM1T5qJPdgHEM8VXokKQP6AVac
        FZHWPY703xIl5IgXgMhnltcE8WI+GvRc0PCmsu8cpGRlyFUTp8WAocpJ0rqLzlLSVLl8k+
        /8N7oh0TZxl/PmajclTT8a6qEmyCdHobC0H0+TS8RAwLa78V2SxWqaoWGpvp2GyERE0owk
        k11fbNm8pJaFsnfb7NkxIjgm8fR9g1UpNM/hvrMHTrL+rNazB+d3kBOtRQhiO2C/Q4BxcY
        JXh2bG79SNOUuxfaX1Neb9TawjBjyDo1tH6RJJOunXGpLZZfvzgsBpTElMVsew==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1685020795; a=rsa-sha256;
        cv=none;
        b=efqD3vaGzuMwKAX5crbjHumwetM35Wf3CIlqu3vc9agehICnsodaIH9kn2um0WhroiJYQ5
        usexy3uEPSzkIUoCyvfeed17Un/uE+WRdWg22XaC4z4N0iPZrLMQAaZrpr1qJ+ZF7c++cd
        L5FKqTtMjiccuc8QZGghS0NBCxaoKB19NBpLs+IHCLr2tvwgy4ScjsvWI/9hcD3IkRgv38
        zn+cGrxUXQu+uturY8ca20qAU1sc31M09LEnX8wZA3z+73efIXBYefQ1lwI/0kAviH4+YO
        ZJFzLS+RxWaL4379SLh+isKa94hmQVjcNCslU4h/E4uUu8gOTrTLJkiXU+kCEg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 16BBE634C91;
        Thu, 25 May 2023 16:19:55 +0300 (EEST)
Date:   Thu, 25 May 2023 16:19:54 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joe Tessler <jrt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Message-ID: <ZG9ger4WE2VWoVEF@valkosipuli.retiisi.eu>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <98a77653-ec58-56c4-9893-3b424f67c87e@linaro.org>
 <5afcec8b-b8f6-35b0-278a-5de185e4a7a2@xs4all.nl>
 <ZG9XJCD98VWjGjTN@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZG9XJCD98VWjGjTN@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Thu, May 25, 2023 at 03:40:04PM +0300, Sakari Ailus wrote:
> Hi Hans,
> 
> On Sat, May 13, 2023 at 11:57:33AM +0200, Hans Verkuil wrote:
> > On 12/05/2023 18:35, Krzysztof Kozlowski wrote:
> > > On 12/03/2023 14:12, Krzysztof Kozlowski wrote:
> > >> The driver can match only via the DT table so the table should be always
> > >> used and the of_match_ptr does not have any sense (this also allows ACPI
> > >> matching via PRP0001, even though it might not be relevant here).
> > >>
> > >>   drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
> > >>
> > >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >> ---
> > > 
> > > Hans, Sakari,
> > > 
> > > Can you pick up the patchset? There was positive feedback:
> > > https://patchwork.linuxtv.org/project/linux-media/patch/20230312131318.351173-1-krzysztof.kozlowski@linaro.org/
> > > 
> > > but it seems it was not applied.
> > 
> > I see it is delegated to Sakari in patchwork and marked Under Review, but I don't
> > see a corresponding pull request for this series.
> > 
> > Sakari, did something go wrong?
> 
> I spotted this as Hans notified me in IRC, I wasn't cc'd. Apologies for
> this --- I intended to take these but I think I must have missed something
> important in the process. I'll take them now.
> 
> Thanks.

This no longer applied cleanly. Mostly there was fuzz near .of_match_table
changes as probe_new (and remove_new?) changes have been recently merged.
There were other issues as well, I marked a few patches in the set "not
applicable" as other patches had already done equivalent changes earlier.

There were substance-changing changes in the 20th patch, replied to the
disuccsion there.

I've pushed the result here and intend to send PR to Mauro soon if there
are no issues:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=of-match-ptr>

-- 
Kind regards,

Sakari Ailus
