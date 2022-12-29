Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25B4658FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiL2RZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiL2RYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B0515F39;
        Thu, 29 Dec 2022 09:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D07D61868;
        Thu, 29 Dec 2022 17:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F8CC433F2;
        Thu, 29 Dec 2022 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334643;
        bh=UikT6pOTq9LMNnCfthaZUWR/9lJHtRQVGaaR01pfx30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv6sBxeH3LdymsecIbWoC0OrB20e99abX3kfdEWMxzWZuypMN+PDoLyO37uq6anDZ
         Ndsvy7esljEVI9UxgONNJWTBMeM0DbEdJ1karPHXllimcPTGs/hKjN0UTcrkl1ohlF
         QcScGXZ5STB/wca5ahTOl/PhtvwsixcDYPdm8Agnw6fYBKbbo3Tvhat0SawKyFdMYw
         gQi1cyrERWk5ivWOEXvJaWebaw2qQP1Q424QfLasXiwU9SWI1jhFfJgb6bitUj7cxF
         QXaZGUjoS85lwd/zWvfXOWJXakthrK054fAAEj2Pf/+pBHIM2CMEYRL0fbDWXo51A5
         UX4t6ChgGfQYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     matti.lehtimaki@gmail.com, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, phone-devel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
Date:   Thu, 29 Dec 2022 11:23:40 -0600
Message-Id: <167233461728.1099840.5576881190676029409.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221218211957.118473-1-matti.lehtimaki@gmail.com>
References: <20221218211957.118473-1-matti.lehtimaki@gmail.com>
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

On Sun, 18 Dec 2022 23:19:57 +0200, Matti Lehtimäki wrote:
> Configure the reserved memory for ADSP and enable it.
> Delete nodes with reference to label.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
      commit: bd445a04d8ca4104c6831148134cd637b135d9f1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
