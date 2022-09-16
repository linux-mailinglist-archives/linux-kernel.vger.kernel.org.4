Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C405BAD86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiIPMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiIPMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:36:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12272399C3;
        Fri, 16 Sep 2022 05:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 242FDB8269B;
        Fri, 16 Sep 2022 12:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AF7C433D6;
        Fri, 16 Sep 2022 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663331779;
        bh=gcyMo0TZkaZKxri6WCBWcf5BI/B7za30bb+XGBepbW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MysHRGETrWkDV49ac6JPmxT6JTxBdoa2ABqp1Gwg2HTlLiEec5um9qtgB1LMtifAs
         EV6UG4j0ysvdrwVbBc65zUGEkZvGzGZ9ceWa7k6vxU4DYx34FSdc8QfO9mykbBjF/+
         Af7vAV9JJkENvjHGqjuR4dFrB9VpwA+T2L2VPW2ZcfyWMbAGA31ahIgmK9hGm39rhR
         zVPP3V0dXo301cuOiiCQjvRwGTmHyL55zXRzc6PIvHGkdsoNKYzWKweMsxMvGlIKwj
         PZ4QnUFbi9RouCQxjLpr4TUJ5osY/o1TxL/AAGZQkXzPEtL+/IhWIYJ99hVKmBcRLo
         9e3cdeLVa5hmg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oZAa0-00025e-QP; Fri, 16 Sep 2022 14:36:24 +0200
Date:   Fri, 16 Sep 2022 14:36:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] scsi: ufs: dt-bindings: Add SC8180x binding
Message-ID: <YyRtyHpb5nppajcM@hovoldconsulting.com>
References: <20220916121204.3880182-1-vkoul@kernel.org>
 <20220916121204.3880182-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916121204.3880182-3-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 05:42:00PM +0530, Vinod Koul wrote:
> Document the UFS HC for SC8180x SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index f2d6298d926c..dd0256357247 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,msm8994-ufshc
>            - qcom,msm8996-ufshc
>            - qcom,msm8998-ufshc
> +          - qcom,sc8180x-ufshc
>            - qcom,sc8280xp-ufshc
>            - qcom,sdm845-ufshc
>            - qcom,sm6350-ufshc

Same here, you need to describe the required clocks in the sections
below.

Johan
