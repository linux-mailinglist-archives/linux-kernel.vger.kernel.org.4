Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA164362C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiLEU4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLEU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:56:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7725E10B9;
        Mon,  5 Dec 2022 12:56:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B5D61382;
        Mon,  5 Dec 2022 20:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB2CC433D6;
        Mon,  5 Dec 2022 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670273803;
        bh=vk+UZ6tUq7mNy/roi7+hY87YUI/a6jLm+DDd/E/E9ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfpXJ0XLZ6VnzsONDET4qRF8KKe1UDuxi1Nh+q7Ae++1QZJiRrm0zOIgndJ5K8pNy
         TL4JXQC8g0vGKe5fU3D/z0pAA3aTe57OFvds3PBNCnhcJaLldHonUGLDKefB4rFlhj
         jihBMagbzyn3mdMOSYlxg5+Tgp2brE9ZWVgodaO2c5WoD+cbLuesyioEdkvWAcxF4N
         jq1WVg5SqP5FK/24raToNWF52w0et/m79ZAaMaqg2wl8HS/RgPuMKbfh+W2bGub4Ch
         Yb1+er4kRdChZrMRKdEjOWJ01tiCORUGQMG6iaN3+kr5c3A6WpP0AB34I/KJseAW7v
         tEZEItD1jkfeA==
Date:   Mon, 5 Dec 2022 14:56:40 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, patches@linaro.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Message-ID: <20221205205640.kawreo3yyeh2meci@builder.lan>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
 <20221118133855.GB4046@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118133855.GB4046@willie-the-truck>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:38:56PM +0000, Will Deacon wrote:
> On Tue, Nov 15, 2022 at 04:27:19PM +0100, Konrad Dybcio wrote:
> > The SMMU on SM6375 requires 3 power domains to be active. Add an
> > appropriate description of that.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Let me know if you'd like me to take this one via the Arm SMMU tree.
> 

Yes, please pick this through the SMMU tree.

Bjorn
