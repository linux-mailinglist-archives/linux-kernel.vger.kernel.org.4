Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52561DB00
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKEOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5DFF3;
        Sat,  5 Nov 2022 07:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F916B80159;
        Sat,  5 Nov 2022 14:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E192C433D6;
        Sat,  5 Nov 2022 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667658810;
        bh=1TDRmbhSSHThH7G6bhltqeMsDuHL0/99z97pCjW6ghw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UlCOzLrU/xIunyk4HIiSbuVamAW4vq2m+18yFlFzh2C9fUUtKsyD2fxm+JOL82jPd
         mwINIT9GZgDqHku8VRq+RnrFsvRzl5QRM8h3yXbVK5MgsV8O6HFtPEHKbkxCkA7DYz
         QAF12bZUKjqbNVlkT8KR4+DSrOgjA6IsAYhkNdDiCEF1Do2X5nQf/emblGWXP/M8K/
         Q3Qmw4ub1IHxfkR6SZPLkpbNn1C6iu3HKKFZEVwiali6t8586szPalrm9D8K4KNXtk
         pZXaDMhZUVdf+9zw5Ibn+Gt4c4XkiR9uHJYM83hDLoVbpNnN5iihgokquHufzZT3Jx
         QkhfELS3WSFXg==
Date:   Sat, 5 Nov 2022 14:33:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH 1/9] dt-bindings: iio: qcom-spmi-vadc: Add definitions
 for USB DP/DM VADCs
Message-ID: <20221105143317.13cf93a9@jic23-huawei>
In-Reply-To: <5bafce51-5f03-499c-65d4-3040cfc03ed9@linaro.org>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
        <20221104172122.252761-2-angelogioacchino.delregno@collabora.com>
        <5bafce51-5f03-499c-65d4-3040cfc03ed9@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 14:25:15 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > 
> > Some SoCs do have a USB DP/DM ADC at 0x43, 0x44.
> >   
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Best regards,
> Krzysztof
> 

