Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA367C09E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjAYXJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAYXJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:09:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A737F28;
        Wed, 25 Jan 2023 15:09:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A0961647;
        Wed, 25 Jan 2023 23:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6FCC433EF;
        Wed, 25 Jan 2023 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674688182;
        bh=hCZ1XZTCSjWNvYxTSWzJ96eH/+NdoV+UKJq6grJNktI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XVVbEZ2kErRVnh97BqcWzoxJC5vh7Wn67EbUPoNnLYZUoz6EHueLMmDFG+xfpX8zY
         zp75rSQSDY21OrXuj1KKP/Xcnmh/EazCRNkl4y6RtS25VJAO4xEgIzo8lGTOM2hSRu
         FEoD2awLy5d1XvQ74PTQM24/JZamMA/zEYebtOqSJqHf0L31jqhGKk3zSy7oYNDt5b
         sKc/c5LQzbt4EUOCRrgwXQPX3b2ubDgh9Nfcl+7IE/xSPs21n87TS1fyLvv3dFmFji
         9pqXQX/d2fEAqoVaw5DZbrqDHZl1ma+UG1tIgWsrW/0qXXj+ry+cEfUNaTU6LXxqWy
         8RLQqhNcCCaIg==
Message-ID: <3dfa96e2dba814930445e8dcfae97e89.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
References: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 00/23] MediaTek clocks cleanups and improvements
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 25 Jan 2023 15:09:40 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2023-01-20 01:20:30)
>=20
> * Some more spare cleanups here and there.
>=20
> All of this was manually tested on various Chromebooks (with different MTK
> SoCs) and no regression was detected.
>=20

Do you want me to pick this up directly? Or is there some mediatek
maintainer willing to send me a PR? If I don't hear anything soon I'll
go sweep my inbox for mediatek clk patches and start applying them.
