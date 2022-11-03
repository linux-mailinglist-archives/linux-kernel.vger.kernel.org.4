Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CE617F77
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKCO1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:27:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8337726DC;
        Thu,  3 Nov 2022 07:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39459B8284C;
        Thu,  3 Nov 2022 14:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DA6C433C1;
        Thu,  3 Nov 2022 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667485652;
        bh=beAxNysO0/02dNrQ4AL9u1axY9WMy2HSTHIwCnmhK+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxNZy2ezr/VDjMQEaDjETMGmZhUUPfKrBW4Dv1hKkdSRhOu/8ZoNVZbFOAc2eoh/f
         wKn0cHbJIT6ttCsy/Wz3R5wSi+mcSJCUxFBJrPRuU6Dl8TTR01FP7qBvX2nc+PYdGP
         PkDFMXIAMALEc5h7aSZ1fQSNErgptug1SI3Di2dw71GOOLKDcp1PpMlyxmTjhgaswY
         25+ddSgaqrnvQdaAH3n/HqYdco1lKotKpo2zKe2/ludXbU+ykLT4XHJF7ocpqeK75j
         iU0AzL9fqxPQxOkurEd0jYkMF/xEgM08C1GSFEpXrcBTlwVSZ5Yd5aEPWvch3RsBRO
         Alf6GECanJxSQ==
Date:   Thu, 3 Nov 2022 19:57:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <Y2PP0cZaJ1vpv1Em@matsya>
References: <20220914165212.3705892-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914165212.3705892-1-vkoul@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-22, 22:22, Vinod Koul wrote:
> Hello,
> 
> The is version 5 of support for PMIC v7. I have added a new property
> qcom,bus-id for supporting v7 and then add driver changes for v7

Stephen,

Can you pick this? It has been so long...

> 
> Changes since v4:
>  - Fix David name and email
>  - remove trailing line in binding
> 
> Changes since v3:
>  - rebase on spmi/next
> 
> David Collins (1):
>   spmi: pmic-arb: Add support for PMIC v7
> 
> Vinod Koul (1):
>   dt-bindings: spmi: Add qcom,bus-id
> 
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  10 +
>  drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
>  2 files changed, 231 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 18c42f8d23426d3f4048df89523aa47203c3493a
> -- 
> 2.37.3

-- 
~Vinod
