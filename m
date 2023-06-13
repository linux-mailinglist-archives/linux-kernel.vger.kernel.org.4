Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8E72EF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbjFMW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbjFMW1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B471FE5;
        Tue, 13 Jun 2023 15:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D8C61625;
        Tue, 13 Jun 2023 22:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D52C433C0;
        Tue, 13 Jun 2023 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695248;
        bh=hORHxp0o75kkXMsCEOK+p4yvDj8X5quTYDb1NM8yE4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTmLuqik26zCrYcsb6Asz2vOTAH/LESdscfSocTwZBiKHmnY7btuWrTz142AB4Tba
         gP6gFfsRSoBYQSuWm1VfkbJaZhjcUN17xmSDLJoTZzz42/xHQKuqJfblLc6DRjrfi0
         j0ciiZra9yoY6oeORJ+fUWspMuB5m3ZDglPe3I7ZwBDjdflMChsQZamxfoXyMPxl9x
         Bos7dnYWJgNosTVXS2VozHEPVbU25D9JJNqiqJ3KDRvKolaJJN0PNY5dPSVaj3Qeby
         HoO1VkJ+QrJyjTYzF0BXF0GrNtnynjzVsrL8MZKWNUeRi4ZEa1oQDenUtPEylijEJg
         Momvzb/rFY8vg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Move DisplayPort for MMCX
Date:   Tue, 13 Jun 2023 15:30:24 -0700
Message-Id: <168669542893.1315701.4992774349220832185.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612220739.1886155-1-quic_bjorande@quicinc.com>
References: <20230612220739.1886155-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 15:07:39 -0700, Bjorn Andersson wrote:
> The DisplayPort blocks are powered by MMCX and should be described as
> such to ensure that power votes are done on the right resource.
> 
> This also solves the problem that sync_state is unaware of the DP
> controllers needing MMCX to be kept alive during boot. As such this
> change also fixes occasionally seen crashes during boot due to
> undervoltage of MMCX.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: Move DisplayPort for MMCX
      commit: 2d7b1a31ffb865d1f8e95e985cdbd0df72f671cf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
