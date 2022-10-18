Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456AA6021DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJRDI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJRDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7679A9E4;
        Mon, 17 Oct 2022 20:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DCB86136C;
        Tue, 18 Oct 2022 03:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8A5C433C1;
        Tue, 18 Oct 2022 03:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062410;
        bh=rmg+THWpR/MKQb7BlLfBQsPOe6c3oh+VNPMjIG32ktw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7PZlVSeHIdUyVvAvWo8NgWXaAmVrqxFgdHX2gk9Q7jxrwEbGqPeDyqzukyZUlCxy
         dZEa4I3KtC/PCvXIOCy1PXVsPNvb/AdjDSDkq33e6DBLH/gHqz0E7Vt3boKxIDN2M9
         X8mMFJddNOLlUhPbzGBdoEwlCktTKT0xBtk2Ecresfg4l8T1lHhhsdzOMrZ+YOC/Jn
         2QMN+SCj5bj1G34tvYv3oxejE+LCB7gSTxmVcXvtRE4v//4U4K+BflnBTFDpvMMlm+
         orFVqcW2H/L4ARixbS8o0hggJGO704j9fo+ly2wiEV4EBwKbUYvgAYnr8r44T0pXpt
         U7gOOSd4dxoLA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        devicetree@vger.kernel.org, martin.botka@somainline.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8998-yoshino: Fix up SMD regulators formatting
Date:   Mon, 17 Oct 2022 22:05:25 -0500
Message-Id: <166606235856.3553294.8008356623826519525.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921004741.152765-1-konrad.dybcio@somainline.org>
References: <20220921004741.152765-1-konrad.dybcio@somainline.org>
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

On Wed, 21 Sep 2022 02:47:41 +0200, Konrad Dybcio wrote:
> Add a new line between each subnode and make the { } consistent.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998-yoshino: Fix up SMD regulators formatting
      commit: 732479bda06e1dfe5f46bfc682d94f40dff0af1f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
