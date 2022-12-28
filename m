Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5A6572DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiL1Ejw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiL1EiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:38:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D80EE30;
        Tue, 27 Dec 2022 20:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC294612FC;
        Wed, 28 Dec 2022 04:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480A9C433D2;
        Wed, 28 Dec 2022 04:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202241;
        bh=7rlmZW5PltjK5AJQHhRWI2zhFCaSzpd0kXIzYX9FBMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inEnizrBWQCQesQkNZH76Fn3BUg0aIQy5QmAEC29h3Lf3iZifeYBx3ZXm6pMpfCIn
         VUghkd6e+uNdyBnbDdTvabsSRCZVSlttGqGMmhMk2sj1OA87s/Z0OeeSQ9xiWNy6KB
         EruUPjAejW6hadWflNrKF8yhmodPieUjnOpVfHVNWTW1rG9run6W6nISXxHfVuLvoC
         GkOXoWDCCWwK6EKoGWCUOyBiye1gY1bPOu4qN2Ih+qTbgjmpPhg0FBGsquKCoDdxhn
         bpbwNMRCIB4ROIsnYS27Iebl0B24eRjdYU9mQgMDE3wOLCB884sqP8pN1JQBb1AsvH
         UEoQPMYrxf+pA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     konrad.dybcio@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, luca@z3ntu.xyz,
        Martin Botka <martin.botka@somainline.org>,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, jami.kettunen@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use plural _gpios node label for PMIC gpios
Date:   Tue, 27 Dec 2022 22:36:55 -0600
Message-Id: <167220221232.833009.17232659499836858198.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209220450.1793421-1-marijn.suijten@somainline.org>
References: <20221209220450.1793421-1-marijn.suijten@somainline.org>
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

On Fri, 9 Dec 2022 23:04:49 +0100, Marijn Suijten wrote:
> The gpio node in PMIC dts'es define access to multiple GPIOs.  Most Qcom
> PMICs were already using the plural _gpios label to point to this node,
> but a few PMICs were left behind including the recently-pulled
> pm(i)8950.
> 
> Rename it from *_gpio to *_gpios for pm6125, pm6150(l), pm8005,
> pm(i)8950, and pm(i)8998.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Use plural _gpios node label for PMIC gpios
      commit: ea25d61b448a51446edb1e8cab8a8d38fc719476

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
