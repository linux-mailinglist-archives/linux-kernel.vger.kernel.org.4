Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1EA672D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjARX4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjARXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ACD38B47;
        Wed, 18 Jan 2023 15:55:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31B08B81F9F;
        Wed, 18 Jan 2023 23:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91EC43398;
        Wed, 18 Jan 2023 23:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086148;
        bh=qQGzsSAM2QPWLrGb22NTyD7vnj4DsOxSlTjuYuFJ2bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EuhTUB0HzTht/rFnr5ZzrPTugVUwYj5jv+8wkKrVfV8wpawPHo6rTnwF+aVvNgKt7
         q+4KXuXxMLoMV6+FoDzE/NBb4fIiFbZ0rqTn+gFxAYlC+lbjWSmUf7y6zcvCAiBTma
         0Edbi/JDs5kSYNG73nR2vp/1M+JUF/LN2yE6mzzcSN9V3H24Sru4SE8yaEq0mDjuC/
         rmYQ0tlG/dgmaR2Gsk4Mniil3qDugmZdV0Om0Y1YzG+VOumN10iEb9pamMv9EqhQKu
         Y5mQMsptFV8iGZX2VnPYrV8m7EIXUJNjbD6EzSXXPMJtvmgwZ1DfXn6mBVXmpfzQcL
         W9QTwh/8uysfA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, elder@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     quic_jponduru@quicinc.com, caleb.connolly@linaro.org,
        quic_subashab@quicinc.com, mka@chromium.org, evgreen@chromium.org,
        devicetree@vger.kernel.org, quic_avuyyuru@quicinc.com,
        quic_cpratapa@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@kernel.org
Subject: Re: (subset) [PATCH 0/2] dts: qcom: use "qcom,gsi-loader"
Date:   Wed, 18 Jan 2023 17:55:33 -0600
Message-Id: <167408614060.2989059.5524021758961149936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221231002716.2367375-1-elder@linaro.org>
References: <20221231002716.2367375-1-elder@linaro.org>
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

On Fri, 30 Dec 2022 18:27:14 -0600, Alex Elder wrote:
> IPA hardware has a GSI component that needs firmware loaded.
> Recently, the way to specify how this firmware is loaded has
> been changed.  As a result, indicating this via the presence or
> absence of a "modem-init" property is now deprecated.  Instead,
> a new "qcom,gsi-loader" property is used; this permits a third
> method of loading GSI firmware to be supported.
>   https://lore.kernel.org/netdev/20221116073257.34010-1-elder@linaro.org/
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: qcom: use qcom,gsi-loader for IPA
      commit: cbf91f46a72a0a1f8d2517c166101c4c85a0b940

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
