Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC35644BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiLFSXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLFSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B740918;
        Tue,  6 Dec 2022 10:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77E60B81B32;
        Tue,  6 Dec 2022 18:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03550C43159;
        Tue,  6 Dec 2022 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350817;
        bh=XoqOWA7atyu7exW3K4w+tqmSMBPEgARiYKXRQvMreK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItQR7CKZY8M/6R/UBSiXpoqItoWlCHnqpg90mN4zS+vLdqU5sxFwQzfRajbs+i+gk
         QXfEcIH+S3nWJgYgB345O+Uz+stlgSGWyX3xdh14iXUk4fX/0AaLr+dtMAAFmXOF10
         Eg+4twP7ztmoi6AET+cQvTz+eTEHTDCzzsahIbzv1upKO0TfDy3PMCV080jvMG29cq
         wYho3W0UK2dU4ZjDfa51CrmXFFazv1YJ31cb8Q1JAZyZLGm+rBe0X8D79UE30iKSif
         xN1QvFAMEgSxDiL1hWqjHuvvORUh73esB+NXShp630nlfaIU3wAmO5rOCdYPooDggN
         30QZNSzMD/z8w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Cc:     phone-devel@vger.kernel.org, robh+dt@kernel.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        jingoohan1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, kgunda@codeaurora.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        pavel@ucw.cz, daniel.thompson@linaro.org
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: backlight: qcom-wled: Add PMI8950 compatible
Date:   Tue,  6 Dec 2022 12:19:22 -0600
Message-Id: <167035076359.3155086.6360460042390908299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221101161801.1058969-1-luca@z3ntu.xyz>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
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

On Tue, 1 Nov 2022 17:17:59 +0100, Luca Weiss wrote:
> Document the compatible for the wled block found in PMI8950.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: Add configuration for PMI8950 peripheral
      commit: 0d97fdf380b478c358c94f50f1b942e87f407b9b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
