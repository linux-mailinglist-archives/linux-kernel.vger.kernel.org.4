Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7107161ECD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiKGIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiKGIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:25:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94813F7A;
        Mon,  7 Nov 2022 00:25:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB0060F2D;
        Mon,  7 Nov 2022 08:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1820C433D6;
        Mon,  7 Nov 2022 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809555;
        bh=BgvfSDSm1KzNyxI29x4rNw5VHuvwCpeNH5GsLnzFpWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hebR34ZdME225oyD8T0lUlNi/yquuSWbZqGGPugMTfQsGWJVLUpv/v1ndpgbUYuNn
         UnlKQKHLrmocbOS8m9KFpY8MaFf66n/TfGubmxKrWqkO3EvI4eQH/oOC6Z1lx5av2J
         avi4vMWYwNQ/qRbBO21wZx+H8HLPWIrSJ81cPVbDK/2Zq7ScKt+ueAx7WMB5d4Wy+s
         H2/WLqX0CIog5fFOV+outYWTm4XCoz0nDMZSUGPTJdBx8Wj/xlb4UQB9iv100ZhGYX
         ixCHOALz6c81yn4UyBdF3Z+k6ExiYWDGbW5Uaw0bXvRNwbOyayusD+jMjVs3RRIubS
         IojL+C6Uf/rJg==
Date:   Mon, 7 Nov 2022 08:25:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
Subject: Re: [PATCH 6/9] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8976
Message-ID: <Y2jBCh0PI/2uhVH9@google.com>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104172122.252761-7-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Nov 2022, AngeloGioacchino Del Regno wrote:

> Document the qcom,msm8976-tcsr compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
