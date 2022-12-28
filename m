Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E365722C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 03:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiL1Clt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 21:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiL1Cln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 21:41:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BDFCE3C;
        Tue, 27 Dec 2022 18:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44008B81233;
        Wed, 28 Dec 2022 02:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBD9C433F1;
        Wed, 28 Dec 2022 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672195300;
        bh=ogXJsbxr2YbILraZuu067pLXUr0+ofWlMi1njY2j6RQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aX1voSu6wKn63YYnOXyt76FLIu1NmtLiNAZrWFVOCgX7doh1wOuAhyt0QrR3LkhXp
         jg+nH1PveS+2cspbItpIPfn4iiYaXnSEvLT1OvtodfNEOCHiQ9R2+/2j49mAS/9hBz
         CTpOaKbJ3CxVAD8DNRdvfihX3ep5k8lnYsmCDT1tpiX8pkvGGrtVUdTQNdYKm+jCgP
         rOINPqbyOBne+Pmt7nOpvhdR/Pbek99i5sJgY7gkgEHB7F0PsUoFE6vU+UapOC/Y3Y
         jNbHCKGGXD2LOPPK3w/4HlHWWCwaIZsWhb1CuOElZ/vCel/z4v77yUnWv85yaRKpNL
         2uoj2Dt/7LKbQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        krzysztof.kozlowski@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: sdx55-mtp: add MPSS remoteproc memory-region
Date:   Tue, 27 Dec 2022 20:41:33 -0600
Message-Id: <167219529293.794508.14584527754468674578.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221118113747.56700-1-krzysztof.kozlowski@linaro.org>
References: <20221118113747.56700-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 12:37:47 +0100, Krzysztof Kozlowski wrote:
> The MPSS PAS remoteproc bindings require memory-region.  The MPSS PAS
> device node is disabled, but schema still asks for it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: sdx55-mtp: add MPSS remoteproc memory-region
      commit: 3ddba3c2268c9539459008291ed816b46aa61e2f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
