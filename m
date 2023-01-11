Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B566539C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjAKFWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjAKFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8013F62;
        Tue, 10 Jan 2023 21:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F0DC61A3C;
        Wed, 11 Jan 2023 05:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35975C433D2;
        Wed, 11 Jan 2023 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413814;
        bh=cPHRfYFrciciPqgeb/VBfaXDkyxy0ej6ZDA9dHDDWeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4kLZhc1JJJh+2Sm8L6cp4lXs0+smI3/63BFCe6MlLsjZP2b+6O/6IJFrKLvphL+2
         Er/a8DFQ2ZrX4HR1OpbnXbUlmwqIYYtt1penBOJXQuf36VSXu7i3S8GyF7kBQAOdZ9
         z4MWFBXGdeognNruArXc2cHDxn9yywEmouyZgHLSETU8Zfmixm7KStQlm/K+M++YOm
         pmV9tMV6m9AYG7wmNcajUjnIiLMP4ZJRKrO9vzWE0pvkYkV8kV4cCYFA/XXw9jaODm
         1BAkRlkOCv52UfPWXqoiFEAS2PsVUixy7ESfat4RC9fbHskKiPDNRp37QsU3riuliy
         9SCGcdzLPhOSQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_shazhuss@quicinc.com, johan@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, bmasney@redhat.com
Subject: Re: [PATCH v5] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Date:   Tue, 10 Jan 2023 23:09:39 -0600
Message-Id: <167341377722.2246479.7988718666819689426.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221213095922.11649-1-quic_shazhuss@quicinc.com>
References: <20221213095922.11649-1-quic_shazhuss@quicinc.com>
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

On Tue, 13 Dec 2022 15:29:21 +0530, Shazad Hussain wrote:
> Add the pcie2a, pcie2a_phy, and respective tlmm nodes that are needed to
> get pcie 2a controller enabled on Qdrive3.
> 
> This patch enables 4GB 64bit memory space for PCIE_2A to have BAR
> allocations of 64bit pref mem needed on this Qdrive3 platform with dual
> SoCs for root port and switch NT-EP. Hence this ranges property is
> overridden in sa8540p-ride.dts only.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
      commit: 2eb4cdcd5aba2db83f2111de1242721eeb659f71

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
