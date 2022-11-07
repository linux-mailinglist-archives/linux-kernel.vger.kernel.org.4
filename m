Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF82161E901
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKGDM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKGDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7DDF8D;
        Sun,  6 Nov 2022 19:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 308C4B80D7C;
        Mon,  7 Nov 2022 03:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA37C4347C;
        Mon,  7 Nov 2022 03:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790758;
        bh=ifRe7r1sObmwAJc4shgX+Lou7yUUWP3rH96l9GNsS0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHwsG1Us3WRztebyfPFaLs2Q4D+7Fc/k7rrhcknIOE8X0v/Zb49SfXwAkGUwG8ZAg
         DYlTSVRQ93kEZ/Fp+qRmSL+sThLJhoQ0FdNPgvtXh/9t9rmvuZ2OljJGoC0oysKesu
         MuOY2AFr7UmGumZH7ggx4Vh3CAIajdO78EZlGR0m9OUfsRfQLLzagbI1nc81GlzOFh
         B2cG0xVJAJAM04nmgGX9JH72gZiCPYbpogTPPRDgy5BLO+XQDKIYrzG5ihlCfRgEYr
         Eg/nYYrdVg1boVDB/PCfH1061zfpISrsatPObENIO2asdhZhNIDK1G/57GoLEMVelI
         EDHkfF0FOdNPw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Cc:     koerhen@web.de
Subject: Re: [PATCH] ARM: dts: qcom: ipq8064: disable mmc-ddr-1_8v for sdcc1
Date:   Sun,  6 Nov 2022 21:11:57 -0600
Message-Id: <166779074265.500303.18425532491738983703.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024233817.27410-1-ansuelsmth@gmail.com>
References: <20221024233817.27410-1-ansuelsmth@gmail.com>
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

On Tue, 25 Oct 2022 01:38:17 +0200, Christian Marangi wrote:
> It was reported non working mmc with this option enabled.
> Both mmc for ipq8064 are supplied by a fixed 3.3v regulator so mmc can't
> be run at 1.8v.
> Disable it to restore correct functionality of this SoC feature.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: ipq8064: disable mmc-ddr-1_8v for sdcc1
      commit: c9713e4ede1e5d044b64fe4d3cbb84223625637f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
