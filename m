Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A84644B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLFSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiLFSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5E3FB8D;
        Tue,  6 Dec 2022 10:20:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 020C3B81B2C;
        Tue,  6 Dec 2022 18:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D4FC43142;
        Tue,  6 Dec 2022 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350815;
        bh=ZhxiiqgKG/KjnaKZJmO/uIL8Qa0U7Jjy2kHvv/Cox8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbLOWrrHvqZQ/iQu0hWxX870Ok1UZaC1hKV/MPlY1hhfLHYIZ/5wPIklZyCi6ARgp
         +Uxj/Ug0sBQueQCYU8F5LJ++eNIGTvNI98sYn0u9R6i8Q21zy8/13bm/h/FqdWcPeq
         BsdrNKsJRUqg5LbwTiD9Btmqbn6CB8cdlqQ4U8wUlUPCu8nOGwnpNvLjPDsauw8h2e
         QfVkfabn5Ytd6gTJw2Jc3TC9avDFoho2eZhSPYe8RG36PuRfcL7+pohVq2zPxCz1Jo
         zfhtTSOedMHLoERV+BlZaS7J0IEtElOZgsPFQjfd8qA2iY9hIt6AHyEYw1YjsaoIDY
         juvo2V5HrdO0g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Cc:     phone-devel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
Date:   Tue,  6 Dec 2022 12:19:21 -0600
Message-Id: <167035076346.3155086.1338360785182149402.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221128172531.828660-1-luca@z3ntu.xyz>
References: <20221128172531.828660-1-luca@z3ntu.xyz>
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

On Mon, 28 Nov 2022 18:25:29 +0100, Luca Weiss wrote:
> Document the OnePlus One ("bacon") which is a smartphone based on the
> Snapdragon 801 SoC.
> 
> Also allow msm8974(pro) devices to use qcom,msm-id and qcom,board-id.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
      commit: c8f740af515848b26be9469c5f338e3b5dd0e57c
[2/2] ARM: dts: qcom: msm8974: Add OnePlus One
      commit: 378f0231330dd13da27e856c44031cef00012ee3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
