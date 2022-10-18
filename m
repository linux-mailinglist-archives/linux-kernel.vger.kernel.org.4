Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380F2602295
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJRDWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJRDWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7979D52C;
        Mon, 17 Oct 2022 20:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06D9261435;
        Tue, 18 Oct 2022 03:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414DC43470;
        Tue, 18 Oct 2022 03:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062903;
        bh=Smk8kgyZhN1b/9ztA7o2UtiGyjBB8IjtEU79OEQW95Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ivqrx5pT4jMRRaBOvZTdGWxYa5gH5Tk0iyLyKjxSA2ehkuK/Wb0h54CnOY6jzCHPn
         qZzhOe56Wo9sxUwcBAt6eKzWQB6AQtN5+8OL44fTuZaU0yJS7genOB0n2oEb4uA9JX
         7mip40iJOT+Sy8ZVy9Y8WrbSBt1YY0RU38dxeC5XxKD+wY8pNqtFtDkVEMaIZs4LUs
         QRKDwYwPJ0WXTeoABAI8jPE9Xgz7of1F3caeW9b+gZWSdlELvmk+FEs3/2ze6jikWX
         bnZ7OX513cOvxET6hQBC5Wv8XYH3ZGsY4JzlqJr/bvcUC0qw1Uq0VileDWUkm/37pA
         b4ZtX/MlzVxyA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org, jic23@kernel.org,
        lee@kernel.org, robh+dt@kernel.org, konrad.dybcio@somainline.org,
        linux-iio@vger.kernel.org, robimarko@gmail.com
Subject: Re: (subset) [PATCH v8 1/5] dt-bindings: mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Mon, 17 Oct 2022 22:14:56 -0500
Message-Id: <166606235844.3553294.16931333730353040478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
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

On Fri, 19 Aug 2022 00:18:11 +0200, Robert Marko wrote:
> Document compatible for the PMP8074 PMIC.
> 
> 

Applied, thanks!

[4/5] arm64: dts: qcom: add PMP8074 DTSI
      commit: 01da7baf018c4977a260b40e7e6978133c9ef824
[5/5] arm64: dts: qcom: ipq8074-hk01: add VQMMC supply
      commit: 378c2064264e18b61922c388c09faba544ce7a15

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
