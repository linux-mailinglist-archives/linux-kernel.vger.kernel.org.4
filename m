Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933DC5ED95F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiI1JpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1JpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DC3A145;
        Wed, 28 Sep 2022 02:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6C361DA1;
        Wed, 28 Sep 2022 09:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A839AC433D6;
        Wed, 28 Sep 2022 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664358305;
        bh=1uTau1MwtuGWxrix0wbBApS6NpbmWi3b2Yso8vdhkF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWmh4j16lZcbVGHbvpRkJrAquaCsbPHptyth0yfnELqqWCip463YZ9pgIQC700wsl
         uVk2O0McEmRAgANJa9kxwjje9ZmxpvyPUDg4GvZEmaiXeqc/UAdtuQ01fma91EUS6p
         mH0mdXDmGGC5hooyMsAQK3vtW64lDqIgQ720UjbJM25ekBGcWZJjkCj8I17yCdXXkr
         m5q7PdGJ5E9pJKM9Fmq1GT6vZXlbQ7cAO5NnDJ/UNru8TUvEzz/mx0jDTblPvp39Lp
         zMHYvY3bByHvUkgDhqDO3PdoSuAw5iUKkrq8L2Gc5ILOlkDkzgplUY++ci82m7nwtp
         dpDPOzmn2W7PA==
Date:   Wed, 28 Sep 2022 10:45:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: qcom,tcsr: drop simple-mfd from
 IPQ6018
Message-ID: <YzQXnLBiv/nfnf31@google.com>
References: <20220909091056.128949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909091056.128949-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Krzysztof Kozlowski wrote:

> Commit 7677ed11e9fa ("dt-bindings: mfd: qcom,tcsr: Convert to dtschema")
> converted bindings to DT schema literally - including the
> qcom,tcsr-ipq6018 expecting syscon and simple-mfd.  Such configuration
> is not used in DTS and there is no actual need of it.  The TCSR block is
> purely configuration block and should not have children.  Any child
> device should be simply moved outside of TCSR syscon block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2
> ================
> 1. Rebase on current MFD changes.
> 2. Split from the series. Nothing depends on it, AFAIK.
> v2: https://lore.kernel.org/all/20220817145901.865977-2-krzysztof.kozlowski@linaro.org/
> ---
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 46 +++++++++----------
>  1 file changed, 21 insertions(+), 25 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
