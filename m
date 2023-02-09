Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F8668FF24
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBIEdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBIEcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:32:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96273EC42;
        Wed,  8 Feb 2023 20:31:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EB49B8200A;
        Thu,  9 Feb 2023 04:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F55DC4339C;
        Thu,  9 Feb 2023 04:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916512;
        bh=aoVzDLeMkujPcEE1HgIT4u6yrAhA5tmBDBH0hkwi5Lo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UPrfd0s7h1pwNgI4gKghlEcjp3i0p46FgLFMjZI3KknVcjD5jUvMQATFT0EqbM2if
         wYCCSCj5TjmBoICbgm0P/zj6ucGRIke1ITBEP7Yco3crDAnvrOeGai8e1S/YzM6dlN
         Ixx9hxiYnv1QNfUtDy8MDg1QLVhMC33JeX6esnaoloRvLnOFBjOIcrbSx+5mDwiuZf
         S6GQgNQwF/rgFZovRfkJW3/TQ5DdcJj1BMDTccdqdOor+zXcd82XA0rS/rD+MbRStf
         43INtFf5i0qF6YLSmMWFHmuDP9mwGhGn1l1NoHzQJ3a2USo3pklY+x4jQ7SpJx3bgb
         qj4t6+RMocKkw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: apq8060-dragonboard: align MPP pin node names with DT schema
Date:   Wed,  8 Feb 2023 20:23:09 -0800
Message-Id: <167591660369.1230100.7439540530365917478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120174036.351937-1-krzysztof.kozlowski@linaro.org>
References: <20230120174036.351937-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 18:40:36 +0100, Krzysztof Kozlowski wrote:
> DT schema expects nodes ending with "pins:
> 
>   qcom-apq8060-dragonboard.dtb: mpps@50: cm3605-mpps-state: 'oneOf' conditional failed, one must be fixed:
>     'mpp5' does not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: apq8060-dragonboard: align MPP pin node names with DT schema
      commit: e58065542e8e95351df86dd3b5ef45dd05c2aa47

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
