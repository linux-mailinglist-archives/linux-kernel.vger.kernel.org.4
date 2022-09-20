Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8725BDD27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiITG33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiITG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB235E321;
        Mon, 19 Sep 2022 23:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F9A62068;
        Tue, 20 Sep 2022 06:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417D0C433D7;
        Tue, 20 Sep 2022 06:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663655363;
        bh=M2rh+TZcI3pHu7rb0WluCI+L/HBvP1YH3JrnG+uT+Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0NNS4gqb9ikKNBk02KO0BPJ3SNR1Mlrt+RrwO1GP49y5+l5Gu/fE+kKv4sUMF/t/
         BCck4RZ2YoK1QsJZJGe/YJGpMY8x4SdhAsvQH8x3aFcZA76Hk26l779WRYE5L3XLtk
         xmiUuKUq224x1OTwwkkQhNeyod+tF0QY1H4tuS4DS7ZqIUrtU6zhg8nBI3kZMDIN4/
         RbeVwoeAa2dOfBAAqVdPrZQNe+HLr4m69XsRtDzflaytzRum4m7im0nioWlVViAw0Z
         tB7rMVV5OhFLVxd8AybTv5djoZ677d6Zbl5kqaDfZLBNRvgN3OLHDpX/727nu/pko8
         mo0yzPYW8Dcmw==
Date:   Tue, 20 Sep 2022 11:59:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: phy: mediatek,tphy: add support type
 of SGMII
Message-ID: <Yyldv9J8CEA7odiM@matsya>
References: <20220914060746.10004-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914060746.10004-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-22, 14:07, Chunfeng Yun wrote:
> Add support ethernet SGMII, forgot to update type supported.

Applied all, thanks

-- 
~Vinod
