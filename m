Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530C36DB37E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjDGSur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjDGSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085AE059;
        Fri,  7 Apr 2023 11:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DA6622CC;
        Fri,  7 Apr 2023 18:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD91C433D2;
        Fri,  7 Apr 2023 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893344;
        bh=g/DECB0NPMqGx70KudliZomBC3L+DSn1Z5fdwDkRApA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pbzydyyGQ+AtFzD/bSJTLa32782t+UEi21SWetIZaeRYLUBVepGSEVy8Dw9Vo2BbC
         u0aBFRVRs6mxnOF3yQx2VR/gIKkhDJMRk66RKcjKi6ItMDLx8/Zs5ap2crXoP31x40
         UZ3EwHh6T2gpvuwXVQDe1nVYY6JmPsFnvXfk08lskgm9bgcg4DSnaenZqwgIS/Mtii
         eePCIzv1TsJCmbZjNVgNqaf5Q9veDg1SGiBteCMBW0J+sMxixQIePWpHXNJm00NXZJ
         xq2PwBldvodBn29BykyWt8bZ4gM1NB+oPKuVDTcjIsjU251YPjYI3PsNrMjHRaBRqT
         LJHrCffMOmQ3w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 01/10] arm64: dts: qcom: msm8994: remove superfluous "input-enable"
Date:   Fri,  7 Apr 2023 11:51:52 -0700
Message-Id: <168089350726.2675207.15586957876770131559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
References: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 19:57:58 +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
> input-enable") the property is not accepted anymore.
> 
> 

Applied, thanks!

[01/10] arm64: dts: qcom: msm8994: remove superfluous "input-enable"
        commit: e10121114e8fe10067c4c4dd1eb1241bd30c2bb3
[02/10] arm64: dts: qcom: msm8996: remove superfluous "input-enable"
        commit: 8db80be2af20ccdfca2c8d3a2adaf60621c2f34e
[03/10] arm64: dts: qcom: msm8998: remove superfluous "input-enable"
        commit: ecdc2fe1204ff515f59385a87994ea17a8d0d6c4
[04/10] arm64: dts: qcom: qcs404: remove superfluous "input-enable"
        commit: 8b58f799056b561e349bb56014f87a71ae517d10
[05/10] arm64: dts: qcom: sc8280xp: remove superfluous "input-enable"
        commit: 87e1f7b1a041a37390bf4fa7913683fb4f8d00d8
[06/10] arm64: dts: qcom: sdm845: remove superfluous "input-enable"
        commit: 2ee8a1525223af4d691aaa620e2d88d4ee2266c7
[07/10] arm64: dts: qcom: sm6125: remove superfluous "input-enable"
        commit: 36f038ad3a0779b58c2fea6b1b1df18d12d6c06d
[08/10] arm64: dts: qcom: sm6350: remove superfluous "input-enable"
        commit: a3752cc30e1557a7c5bbd5bda8ccd91dba0f3a06
[09/10] arm64: dts: qcom: sm8250: remove superfluous "input-enable"
        commit: 5a5fd14b22881d60911541750a4d6f66e501ea6e
[10/10] arm64: dts: qcom: sm8450: remove superfluous "input-enable"
        commit: d1333bce9e019f1e529a8f1c83f4e2a1a8612bbf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
