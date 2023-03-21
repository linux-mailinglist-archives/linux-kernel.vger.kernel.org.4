Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C656C2ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCUGsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCUGsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259B1DB9B;
        Mon, 20 Mar 2023 23:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5FA4B81263;
        Tue, 21 Mar 2023 06:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE5C4339B;
        Tue, 21 Mar 2023 06:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679381288;
        bh=zAhzNf2FVAMCkoGYjb8wdeS65X5jjVy8UxYtpveB0zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOw/Uepo1U1ivrWB97hISCKv3yY9dsEm8dxwFQrKZ3GldmWCG0BhJ/BoAfKnvWtlF
         aArOfVhruKPz6PWvBdiVHs5cpBWhACYEAgPhnzJ6SqID2x+VyV2GKgdK94hY4f5I4Q
         95m9GRi8KSNsLWVMssBMAso2VNKNNjrye6HHqdfI=
Date:   Tue, 21 Mar 2023 07:48:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Drop unneeded quotes
Message-ID: <ZBlTJbdAmh5H3PD0@kroah.com>
References: <20230320233904.2920197-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320233904.2920197-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 06:39:02PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Or do you want me to take this through the USB tree?  if so, just let me
know.

thanks,

greg k-h
