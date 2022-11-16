Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7062C340
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiKPP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiKPP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:59:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566EB17416;
        Wed, 16 Nov 2022 07:59:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F8061EC0;
        Wed, 16 Nov 2022 15:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50499C433C1;
        Wed, 16 Nov 2022 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668614386;
        bh=S/Qn3kH5ALUoC5eZzAeX7uEt2ddePH/2S69OegeMfPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtiIKoRfX2SW+UMfcLOL3emzyCmWbWnIpv9m0mL6ThKt5ht131dcFNbnAZo06Q0Ks
         DhzrGyMOLcmADpTUtQGM+ptcqdbW56R9d2l1skOwdoW0Qr0Cu30Ir2CpLeJn/8T4bG
         uqImRRjZjqcZo8fvb0aFCXw2dAbEejMPfJB0O0hJzi8p/jwSN9hpczBlQOEK91eEdm
         dkkY8xrAOdwHr66qyO+F6z8CAPIa4XVM3Qcw9Ixykq3l+KuAMR1hKZQIYpXw2NAskN
         pug1C5B6jm61DearkjOQdV8A5NVO6IfiPGNUmloh8dNyKAb96G32xvP8PMJT+Abw9x
         aMeZ8k++fMbdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovKom-0004Cq-Vg; Wed, 16 Nov 2022 16:59:17 +0100
Date:   Wed, 16 Nov 2022 16:59:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v9 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <Y3UI1EOBQEt0oLZl@hovoldconsulting.com>
References: <20221116154932.17127-1-quic_ppareek@quicinc.com>
 <20221116154932.17127-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116154932.17127-3-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 09:19:32PM +0530, Parikshit Pareek wrote:
> Introduce the Qualcomm SA8540P ride automotive platform, also known as
> Qdrive-3 development board.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs and USB.
> 
> The SA8540P ride contains four PM8450 PMICs. A separate DTSI file has
> been created for PMIC, so that it can be used for future SA8540P based
> boards.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Tested-by: Brian Masney <bmasney@redhat.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Tested-by: Eric Chanudet <echanude@redhat.com>
> Reviewed-by: Eric Chanudet <echanude@redhat.com>

Looks good to me now:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
