Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1929B710448
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbjEYEvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjEYEvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF89B3;
        Wed, 24 May 2023 21:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5AA641E9;
        Thu, 25 May 2023 04:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4545C4339E;
        Thu, 25 May 2023 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990260;
        bh=SS6Fkpk1F+cGWEf8h/dptYrA0Jn6Ac2l6TEMJLMtg74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwjOX0RyGO+63v+KET1ZFGpQlfGhs0sPOb+0VNUKM+YCp+h/gHucpr91veUDhq598
         uLQcVHoUdyBpsr54g129NYHQ8o40IgvpGGt04TVVxtXyrOaBSGc5v9UmqPYLnBP90x
         VwLUoj5fSiIwF3JUCS8n7CMdEgwGRaUqYsBO0C/ItQzITKIndxJoE9Q3hHlhtzMttF
         tnkrZWvMnp9uQZ6xrvxuS+Hjok0Pq/l6UrPbjXaJqiSO3lxwqq6u7E7/X6jg6iSy1l
         z7lHRgFgjB/Wb0BOrKzUtvAF506f3GnTwq0VwDOm+jq3+0hpUwUhSFSUerUQTg5eC9
         Q2pA3Cjy2EZjg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        quic_schowdhu@quicinc.com, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH 0/2] Fix EUD dt-binding doc & sc7280 EUD node syntax
Date:   Wed, 24 May 2023 21:53:40 -0700
Message-Id: <168499048178.3998961.1535766346472551958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
References: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2023 14:49:20 +0530, Bhupesh Sharma wrote:
> This patchset fixes the EUD dt-binding doc & sc7280 EUD node syntax.
> 
> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> 
> Bhupesh Sharma (2):
>   arm64: dts: qcom: sc7280: Fix EUD dt node syntax
>   dt-bindings: soc: qcom: eud: Fix identation issues in the example
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc7280: Fix EUD dt node syntax
      commit: 9ee402ccfeb1638a039f2e0d455300b5f8600a81

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
