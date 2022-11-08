Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC1620851
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiKHEgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKHEgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:36:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092326AC8;
        Mon,  7 Nov 2022 20:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E65061474;
        Tue,  8 Nov 2022 04:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31272C43144;
        Tue,  8 Nov 2022 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667882195;
        bh=yKFdqtKN7H6EDBU3xG0gnhwBiJcdmwyuLSnRxrZVtF0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VXVyyNDlOC20xdRkBRkBioybUj+84wB8hRZOtitPXsc3P4VNvJtf5dtOWXnDAzSIX
         HdfTb/pys9a9p4v9bprD9immbqCORdd7PESlGcDJ1a/BvukmxgoPa7EQg4s/lT8y0W
         rUBCiU8u1ENn3mRnrmCciCd2msVeDa24kw/1RtXlJjT4BGEF5TR5WVTEVG5Rsj3phz
         pCgHN9T1Vevgscbn1sFltouCqMRQhl5niAmsn5BJzF9tgeTqfiKKVoN5+r/sQB45yK
         QquDgUFStKiPc08/5Hn9skH+UuAKJNDRYC6/aQfVoT1MdZx0aCNj3xTC1C9dvdCSP5
         H79wRrTzZo4nA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8660: convert to dtschema
Date:   Mon,  7 Nov 2022 22:36:28 -0600
Message-Id: <166788218320.625965.13129692544220208864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
References: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 7 Nov 2022 19:59:30 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8660 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> 

Applied, thanks!

[2/2] ARM: dts: qcom-apq8060: align TLMM pin configuration with DT schema
      commit: a4633387ce9481a10068f4e6a939c5a694e3f2da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
