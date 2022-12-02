Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C614E640FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiLBU7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiLBU7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D3EA5D8;
        Fri,  2 Dec 2022 12:59:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F65623E4;
        Fri,  2 Dec 2022 20:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BC5C43141;
        Fri,  2 Dec 2022 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014741;
        bh=E619DqsmNYY8wpx8H2TgbMDNM5V5sxQzguYauTOe9xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRzj6JwLE4Ypy0UtKNU7f5F5ZPvaeYfSybHeyPBHBUmPEWRjb+/jWse2C7Mx7noDK
         CD8A9GadAtzwoBFG/2N1r2QcCkl8BVwu3iHCkk1hFKUN5iFvoxF8OYH5pfQUfAh8T2
         PHClQquFT2JzlecOfxrr37qB2RrZhk7jahnbpal5PS1tnYOhSENQBlNZXUh1H1lauz
         dympxMmnkXTMrzjyQt1Hur971aLFfxtBqZOcoWsNt1n5y9rNcmLYWKNhqxRQLYvgb2
         bMYu0aj1pHVKWoZGQt35HJdF3kkOxfwJNA9lbbq+wDb/JqmAiIwClMlTS/ahbDAVk8
         a4JoXhihXlG0g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        bmasney@redhat.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        quic_shazhuss@quicinc.com, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: sc8280xp: fix UFS reference clocks and PHY nodes
Date:   Fri,  2 Dec 2022 14:58:47 -0600
Message-Id: <167001472415.2721945.17224914588032652616.b4-ty@kernel.org>
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

[1/2] arm64: dts: qcom: sc8280xp: fix UFS reference clocks
      commit: f446022b932aff1d6a308ca5d537ec2b512debdc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
