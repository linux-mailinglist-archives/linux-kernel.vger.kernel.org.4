Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0168FF21
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBIEdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjBIEcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:32:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F441B64;
        Wed,  8 Feb 2023 20:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6902DB82014;
        Thu,  9 Feb 2023 04:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2EFC433A0;
        Thu,  9 Feb 2023 04:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916527;
        bh=ItY8ZiNdTRg3NbJjxSFjaG3Ja6Sqa2KR+GQepypZTzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRwWH3S0dN6bEV+1cmWWsmUBYYnrH7Oo8Qhu7O7w2MCxOfWUiNIDG8G9Hv09eOrNS
         pFpHsTFwj6TxKnKIuHniZrojFQY3qnKiS/x69jlcrxxHyrK/0E62JaNAdieJ6gz8hk
         Ju5VOxSyBB8DTJuDeOojB9vhsgILq8WSqDX4veqF8BpsLJkQeHZE8KPaSPeAUxbMvI
         mQDanhQ/pzr59JlDpVyvWczVGC3OQY0rfoC3z61IQ7DyQHRdiQz7sVguN8b6SqHVAR
         wcqWn9P9b9Bh3e41JExIBH/9pYgKgFFTaoQnwV7R1YtDFenobDCEoupOk+kDwt4T1l
         2sIyvPXR5VwbQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, neil.armstrong@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: firmware: document Qualcomm SM8550 SCM
Date:   Wed,  8 Feb 2023 20:23:23 -0800
Message-Id: <167591660369.1230100.6930687682010340977.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207-topic-sm8550-upstream-scm-bindings-v2-1-ca12bd33fa1c@linaro.org>
References: <20230207-topic-sm8550-upstream-scm-bindings-v2-1-ca12bd33fa1c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 14:46:46 +0100, neil.armstrong@linaro.org wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Document the compatible for Qualcomm SM8550 SCM.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: document Qualcomm SM8550 SCM
      commit: b9fd335389776b7bfd7db4dfdd57c1bfe29c54e1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
