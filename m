Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A55B7701
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiIMQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiIMQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:59:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E627B530A;
        Tue, 13 Sep 2022 08:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4F1DB80FF4;
        Tue, 13 Sep 2022 14:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0E4C433C1;
        Tue, 13 Sep 2022 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663079739;
        bh=gHtSpBRJsCnESx+CayMi4+wi3MLvP1nBbt0jgudGcb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KT7JJaXONwENE/J0cMDX8w8EzH5DVOKvDagK9zNtJy7siD6i42v0Utw/L9SaMiO+B
         qyRcrmL4U+5O//MWQ3mqRYGDEht5qCz/jrDrn0NvYrx66WMiSgOmTvFu9SnSBWjb3u
         7N9KQ/K8NjktevfXodVY9aTsf43LwiGnuHNGVxjtlxIS3yxgT8jJ1HaMpC1o9UY4lK
         Wzn3aTo5zesxswtXiZpndF59fjAfmiDPS22q1p63LLgJQAnZyJCB4x39QPbcucTN2O
         o8QzMgBgaS1e7OA8Lx3V6dIrBTjOqhcHdT1tWiEyOWaQHWqMFD4YLm1C9ejojTEia5
         TYI0l9Uu5qjww==
Date:   Tue, 13 Sep 2022 20:05:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dt-bindings: phy: qcom,qmp: add missing
 power-domains properties
Message-ID: <YyCVN2W/98FKi5ew@matsya>
References: <20220902080705.12050-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902080705.12050-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-09-22, 10:07, Johan Hovold wrote:
> The new SC8280XP USB PHYs require a power domain to be specified so
> amend the bindings.

Applied, thanks

-- 
~Vinod
