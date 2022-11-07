Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A84561E941
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKGDOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKGDNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B42C11451;
        Sun,  6 Nov 2022 19:13:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF93E60EA0;
        Mon,  7 Nov 2022 03:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA75C43147;
        Mon,  7 Nov 2022 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790782;
        bh=8G0o2djxjwyOoVJ6/gYmzQrJSBNCorhqWBGJL815i7U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CSTSy7zjpv3oV4/DCdiNt0NPbp0hwsOzpddL1C4yMy3yCEhg4OTLW+8Ji0B4vE9Nl
         i5IbfjecthUnpGb2jfgkes0syVsZVME9FPfBzAGhkAYsfMZQMwGWy1pRsqPMNzEPyt
         M6VTvdpWYGuNXYoFH7s3Sgh9NEkIMBhtcFZRQil5vaeqRsQPaHq4SHyXaEx3vYRi2N
         SZBop0OulxM5a3e4iPi6Tjsd3y7MT+yEN37h9oQgywckpKn+mcuj8zS4Dx2ZKT6aoo
         tXEijDpN5WtDqDVqWM0LnGKm26AcAEj8RtUuBWe1dZNAx1Injm0C663nh764v8KUYp
         sPmSGJEANEUKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: clock: qcom,sdm845-lpasscc: convert to dtschema
Date:   Sun,  6 Nov 2022 21:12:20 -0600
Message-Id: <166779074268.500303.16519108461965441251.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104182108.126515-1-krzysztof.kozlowski@linaro.org>
References: <20221104182108.126515-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 4 Nov 2022 14:21:08 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm SDM845 LPASS clock controller bindings to DT schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,sdm845-lpasscc: convert to dtschema
      commit: 83bece0a9ef359ab4c135827ee54a222a3b62988

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
