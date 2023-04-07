Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3858A6DB1C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDGRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjDGRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23033B45D;
        Fri,  7 Apr 2023 10:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBCE612B8;
        Fri,  7 Apr 2023 17:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8510C4339B;
        Fri,  7 Apr 2023 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889110;
        bh=SVNdCzS5dOwnIbizNI04FQZAvngU0frQKSwP0pYnE58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/s2ZLcAgk9hLlTiaAr64AUYtH7rj+xQMjm2/KR2Kno4hH5n0M/fgaqYWE6/sAXej
         U51utwPwJFdgXtqjg2cdIDhc3u2JKQcqWNWpZhZULplQlfArsSG0IMLJm6t/WNa7OD
         42raklQ1RSyVOArMHkTZUZ+msCYv3zJ7QxRrWBk7zhcBQvLHmyTOkbEgr1LlZF16fY
         ULZGADQglbjJH8fu+rz38gz1lwRahgHfjqP7nm/LTzfhbA/mFHWkrj2QEFgCoYljXW
         ao7AlYCzCeK6GlFYVGMbzba3QV1C/KXO9kgWkO6+fYVXWD/KATDcIQKIWVGlhm0+qa
         1kbOj5qxPq53A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, Alex Elder <elder@linaro.org>,
        robh+dt@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     mka@chromium.org, quic_jponduru@quicinc.com,
        quic_cpratapa@quicinc.com, evgreen@chromium.org,
        quic_subashab@quicinc.com, caleb.connolly@linaro.org,
        quic_avuyyuru@quicinc.com, linux-kernel@vger.kernel.org,
        elder@kernel.org, quic_rohiagar@quicinc.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ARM: dts: qcom: sdx65: support IPA
Date:   Fri,  7 Apr 2023 10:41:07 -0700
Message-Id: <168088927576.2561591.15794170389939298837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327195605.2854123-1-elder@linaro.org>
References: <20230327195605.2854123-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 14:56:03 -0500, Alex Elder wrote:
> The upstream IPA driver now supports IPA v5.0 for SDX65.  Add
> IPA-related nodes and definitions to "sdx65.dtsi", and enable IPA
> in "sdx65-mtp.dts".
> 
> Having touched these files, Konrad advised I should update them to
> move the "status" property to the end of nodes where it is used.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: qcom: sdx65: add IPA information
      commit: 14079448cccc2fb8e2709d5ea194bd5e6a11ded9
[2/2] ARM: dts: qcom-sdx65: move status properties to end of nodes
      commit: 280ecc191281892bf33ed6bfdea46b4c27ce582c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
