Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D152602275
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJRDUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiJRDT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8ED8E722;
        Mon, 17 Oct 2022 20:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E0BB81BF0;
        Tue, 18 Oct 2022 03:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B419CC433B5;
        Tue, 18 Oct 2022 03:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062883;
        bh=V2lYs+zHbsp9NGkfaLKOXzinOBWLMboZkj4bkaSx5wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyGVBrtCM60Ky7Wo9s0AtgNCH0xBj7CznS3fXIyrzAnmjpqhl20uM1m5ytzq6Rure
         dU2cfYs99hKdjBppcdvJExxjk8giYTkzf45me6nt/uOViYXts9SxwMV8QAcOxFYcRW
         1WNGnsRcHY71OMz3r/7JZxgDxWK+rFMjwzTFZH4bvKKgxO2h9lruEq93idujU6eUVH
         eVbUYeE8+fqoI9z+h5JG55GdcDzoPHfHr+nC77gp/Jnf0gZRCizfL49UGU/qlarVei
         sBHifGCp7b4sjDAh2uux+HZgNhxC6QAfddxSeHr3Q+ERK+LOTU/wwt1oXzn6gU2B4m
         Ak0s1/P+ErapA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org
Cc:     dianders@chromium.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_kriskura@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add required-opps for USB
Date:   Mon, 17 Oct 2022 22:14:33 -0500
Message-Id: <166606235842.3553294.14845104148907454767.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927102646.14785-1-quic_rjendra@quicinc.com>
References: <20220927102646.14785-1-quic_rjendra@quicinc.com>
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

On Tue, 27 Sep 2022 15:56:46 +0530, Rajendra Nayak wrote:
> USB has a requirement to put a performance state vote on 'cx'
> while active. Use 'required-opps' to pass this information from
> device tree, and since all the GDSCs in GCC (including USB) are
> sub-domains of cx, we also add cx as a power-domain for GCC.
> Now when any of the consumers of the GDSCs (in this case USB)
> votes on a perforamance state, genpd framework can identify that
> the GDSC itself does not support a performance state and it
> then propogates the vote to the parent, which in this case is cx.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Add required-opps for USB
      commit: 5d6fc6321db1b0ea4df0c4654ccb0432f740fcf4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
