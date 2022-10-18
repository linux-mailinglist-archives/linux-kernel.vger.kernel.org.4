Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C160224A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiJRDMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJRDJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF39AFFE;
        Mon, 17 Oct 2022 20:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B08E0CE1B21;
        Tue, 18 Oct 2022 03:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B88C43141;
        Tue, 18 Oct 2022 03:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062443;
        bh=GHNCgtC7z1MVH/4tt9YVK6G8eWtXxNGZduRca+S4AEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXUXaAKn1KUxl+FsZj5lGJzk45waxTbjn1Xyfvd0izYVLRu1Iy+/SgHoXd/Cwvkmz
         0O124jITkLE+8Z4uL1jwzw03kbnNWGRigqGNrtfQfVU8odwdxK2NmWB8DASSfxxSfg
         8cVy4ztNPypk2zxzYQpm4yvns29JWA9PVWGxA4U6qCCsMfdUesP3xMzKtFV6KHPJAF
         qotALH5dYtRrQp4eWrCh5fiaER47QiNUy+PC2GXQsudITb5TYqPxOAi46UgiI+59Cy
         oLemNTnOvQBEbjW5wQKdFL06wvlRNZACyFdLy563a467vUVkooxI3RCxS3Jf+dfhTc
         wRC1yF02Qy4Kg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-sony-*: fix multi-led node name
Date:   Mon, 17 Oct 2022 22:05:55 -0500
Message-Id: <166606235858.3553294.27052917573380837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220925175631.103535-1-luca@z3ntu.xyz>
References: <20220925175631.103535-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 19:56:30 +0200, Luca Weiss wrote:
> The name rgb-led is not allowed, multi-led is supposed to be used.
> 
> <snip>/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb: pm8941@1: pwm: 'rgb-led' does not match any of the regexes: '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
>         From schema: <snip>/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974-sony-*: fix multi-led node name
      commit: 5da0f6fedb18d447cbe6d8aa5be33291bce1e7ba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
