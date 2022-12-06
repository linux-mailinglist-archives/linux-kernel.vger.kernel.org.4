Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDE644BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLFSX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiLFSWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9F40905;
        Tue,  6 Dec 2022 10:21:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68A561847;
        Tue,  6 Dec 2022 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB811C43149;
        Tue,  6 Dec 2022 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350821;
        bh=MLAgFv05RvApij99zbYZ6d1xiJ6FG0fQ0Z8D8PgMU4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcnvUzLwFU8ZcNCMDZSVPH87zbC6eFcdPIMfcVdlEHmPg72fLcao/FFLBQ0B4RV4t
         FD+l+Ni/jEhMMgSqhP6rjrVuoXGvuAoFEtIdKPiQ/lJttXLmMUg5zhAJWRcfEa6sWt
         6APyL+1aD0SXxdzxm95KDNHzU5YRbEIk1lO9owiMrHC+D3B9nRONAb7hFfinGn2cCJ
         BBcL1TdVseB2C2QkylRX0qohWkykgnWWNAdGWRafyxVmevlsu/OCR705mA6Iw88MET
         rubfJEh7jDvqYV32W6LpBJpSeGP90WnJ3O3rwLCWz04m9+vCtVEQdxcT5NLPqDTMWU
         V1PH9o7oDTSVg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     broonie@kernel.org, nfraprado@collabora.com
Cc:     robh+dt@kernel.org, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Andy Gross <agross@kernel.org>, derek.fang@realtek.com,
        perex@perex.cz, oder_chiou@realtek.com, alsa-devel@alsa-project.org
Subject: Re: (subset) [PATCH v2 0/8] Adjust usage of rt5682(s) power supply properties
Date:   Tue,  6 Dec 2022 12:19:26 -0600
Message-Id: <167035076324.3155086.11660793655282109085.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
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

On Wed, 2 Nov 2022 14:19:54 -0400, Nícolas F. R. A. Prado wrote:
> This series sets straight the usage of power supply properties for the
> rt5682 and rt5682s audio codecs.
> 
> These properties were already being used by sc7180-trogdor.dtsi (and
> derived DTs like sc7180-trogdor-kingoftown.dtsi).
> 
> We start by documenting the power supplies that are already in use and
> then add few others that were missing to the bindings.
> 
> [...]

Applied, thanks!

[7/8] arm64: dts: qcom: sc7180-trogdor: Add missing supplies for rt5682
      commit: 172cb25fd25786a3290cffd38dea677edb0b7cca
[8/8] arm64: dts: qcom: sc7180-trogdor: Remove VBAT supply from rt5682s
      commit: 147e8b2080f1a0496a1f51739cf591324f133619

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
