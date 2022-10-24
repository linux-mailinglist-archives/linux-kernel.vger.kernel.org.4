Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815760AD89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiJXO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiJXOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FCA9834A;
        Mon, 24 Oct 2022 05:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16135612F4;
        Mon, 24 Oct 2022 12:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBE4C433D6;
        Mon, 24 Oct 2022 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666615833;
        bh=muZZQCY2YzmlU83yu+6go4k9bEyOW1zq3CdA5eo6BEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3gaU+rlu3tHAPHeK/twHPUpXCK2BibDRPeLcmuyZnr5/ogwB5gL5452WF7WxeFkr
         LiFv0N0G/mv8Pz/fjbe5um3/fgiUvVDCdV/ggczrVZG8pshGu3uuecHahC+OB/4Idp
         GMSj7ylh26GrcbGg2jjUlJDzOO+YDgG/c6iymYVD1w8z//TQVcv+CtlBq3jzx52mFp
         agXgmdbsbLT+8huJHUVloo8T8wQQ3K9m939uhLyHhLRTTOlOwbVu5m/6yoJbnW3Ovt
         xlljEMYYI1GXC1a36p99/SKm6tzw1hE+rI0WulrjFaAwt0wDlk0+CofHaFoHZAdfRl
         2Uv3UPdyz4LHg==
Date:   Mon, 24 Oct 2022 13:50:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 5/5] Input: mtk-pmic-keys: add MT6357 support
Message-ID: <Y1aKEgitetNgNDNa@google.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
 <Y0ReqmnLfKo20HO5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0ReqmnLfKo20HO5@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022, Dmitry Torokhov wrote:

> On Wed, Oct 05, 2022 at 04:57:25PM +0200, Alexandre Mergnat wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add PMIC Keys support on MT6357 SoC.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Please merge through MFD tree with the rest of the patches.

The MFD part is only a small doc change.  The Input and Regulator
changes should be merged through their own subsystems IMHO.

-- 
Lee Jones [李琼斯]
