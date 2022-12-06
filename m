Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7B644B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLFSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiLFST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB820983;
        Tue,  6 Dec 2022 10:19:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C7961847;
        Tue,  6 Dec 2022 18:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C49C43142;
        Tue,  6 Dec 2022 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350794;
        bh=lx0jANVV9LZ3xl4Ot2aDSQ2ge3a/nkd1ZA1aPMw0+X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFg2MO5/rxwmmSRxlXS4BsFbAwAT8CeUXyi9RlPmmYUpT+SNHzoDrcnOshlxC5wAt
         JHBO2vTnvNaQBrtSLTxMNgp585Du6kKVYudlLsa6zHt5OKZuuhGTxbHvGKnav/VeDd
         fcaemKN5OQbegnv3MuJsEyoUwcD4K5ueG5jODyB25LYdJn985/xarJB88KUzr7lSm2
         Byy+NbOUha1gTW5QbUg/aQA4LQzwSzrudlhNpj6g0BqRQumY+c9yVkp1gdHEaOd0bG
         Lbth/76fZbygnRMJ55LZe/AP5jUYUxisgBHUGY2QLvRkIRmXLPIDH+aMPClm1avV39
         eDh5Z31GV8hbw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        quic_shazhuss@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        bmasney@redhat.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: sc8280xp: fix UFS reference clocks and PHY nodes
Date:   Tue,  6 Dec 2022 12:18:58 -0600
Message-Id: <167035076326.3155086.76601785025638045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104092045.17410-1-johan+linaro@kernel.org>
References: <20221104092045.17410-1-johan+linaro@kernel.org>
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

On Fri, 4 Nov 2022 10:20:43 +0100, Johan Hovold wrote:
> After some initial confusion, we've finally settled how the UFS ref
> clocks are used.
> 
> The first patch fixes the UFS controller and PHY nodes so that they
> reflect the hardware. This one should go in 6.1-rc where the two
> previous attempts to address this are heading.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sc8280xp: update UFS PHY nodes
      commit: 33c4e6588e4f018abc43381ee21fe2bed37e34a5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
