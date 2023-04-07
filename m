Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4D6DB2D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjDGSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDGSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3093C8;
        Fri,  7 Apr 2023 11:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F656531A;
        Fri,  7 Apr 2023 18:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE81C433D2;
        Fri,  7 Apr 2023 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680892437;
        bh=s0plrs8iSd45hBOeT6kgwGcKEnZY+1w4oxOTbutlxpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMCgtA/fRri2tzcNOUto4oRPbVmsKFXuftdtlvSK1jlzWP/L83XaXNtpZN66OYp2N
         N6SIynsK8SmFgpEi59p50x3jxU4O+TioNdp1IMwgWAfbGHs8utw5je32EeK9c7MJlT
         LQ3jc4U21JSwNQ5wfU4zG6N7YcZXb0z2ornpKv4kp6WSpLugCSVI5hUOxc1Q5eiHCO
         xlDAvP1PrbJKIehKf1N19A1vcCrgaMFTOxHmFXZnaElj4+/q1B+X79zej4Xdh4x/el
         MMaXZuxXl48x9+BkJoQMSuT+XfLsZcJjMfM0IYfxy48Y+TbJVBKIgep/F9p4B+S73A
         oqSYKBxzdl9kg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: qcom: add PMIC regulators for sa8775p
Date:   Fri,  7 Apr 2023 11:36:43 -0700
Message-Id: <168089260338.2666024.5382115595397872318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406192811.460888-1-brgl@bgdev.pl>
References: <20230406192811.460888-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 21:28:08 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Here are the remaining patches from the big PMIC series that add the DT
> bindings for RPMH regulators for SA8775P platforms, implement relevant
> support in the driver and add the regulator nodes to the sa8775p-ride
> board .dts.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sa8775p-ride: add PMIC regulators
      commit: 27eba11291b0f9a8e9ca1f50ba0f6fd3fdda486b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
