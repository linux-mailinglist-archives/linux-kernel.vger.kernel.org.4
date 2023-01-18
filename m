Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E26672D26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjARX4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjARXz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4545BFD;
        Wed, 18 Jan 2023 15:55:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E62D761ADE;
        Wed, 18 Jan 2023 23:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BA9C433F0;
        Wed, 18 Jan 2023 23:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086154;
        bh=FzOrmZ4zaqjbt/e9+QApYGb6CGTUnh4yd7AqFSLVJso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkzDXvzwO+THphU0ils6FfiOcn1lFGPMUsNg8avnr2fx5dCLryYh9N8ymo1v1wvgF
         6icOENh/ztyXC5mUmGzA3d3Evx9hePMRU/Jd+3FMsuW995W0rxrM7uwNLSWef0UrCF
         vRdhstGnqYJd3lOZFib+Ut5jHYmCgbs47oUT5usyDvKJoSywTJxIlVdnRYfZsCAfv4
         1D1HhoDI9xF4q0QTERNvU+rAXGQamBydQP2QDQaDeh4dCGwrCD9MOZV+c162K8Rk+a
         neEtUyhVlAtLN54OCdnAnrVUymoW1yP6YYNFaj4QTcxxrFAlB8PXdeNZ4ZFfw5gaQ6
         r/zxW8qjWPihw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linmengbo0689@protonmail.com, devicetree@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, konrad.dybcio@somainline.org,
        markuss.broks@gmail.com, JosefWMenad@protonmail.ch,
        julian.ribbeck@gmx.de, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        stephan@gerhold.net, nikita@trvn.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH v6 0/5] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Date:   Wed, 18 Jan 2023 17:55:37 -0600
Message-Id: <167408614064.2989059.9530033047968534075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106142748.546975-1-linmengbo0689@protonmail.com>
References: <20230106142748.546975-1-linmengbo0689@protonmail.com>
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

On Fri, 06 Jan 2023 14:28:38 +0000, Lin, Meng-Bo wrote:
> v6: Rebase on linux-next and reword. Add MUIC. Drop WIP J3 device tree
> v5: Fix address typo tz-apps@85a00000 in msm8916-samsung-j3.dts
> v4: Try "git format-patch -B -C -M -D" to fix errors.
> v3: Drop msm8916-samsung-j5.dts temporarily before moving it.
> Minor rewords.
> v2: Reword and resend. Split common dtsi patch.
> Add missing suffix state in pinctrl.
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add initial common device tree
      commit: 66e9ba516be3c165b1adf86ed2bd7e2ec4a3b578
[3/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add new device trees
      commit: 4414bdf9c56513f6f706bc936cb9e35126ac8773
[4/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add Hall sensor
      commit: 027523b77c0cecf4e4afbb7c587aaa10fd33b510
[5/5] arm64: dts: qcom: msm8916-samsung-j5-common: Add MUIC support
      commit: 83a54e61b2bdfd81865bee12033b1d9d5af0016f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
