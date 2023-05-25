Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8097710492
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbjEYEyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjEYExA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC810FD;
        Wed, 24 May 2023 21:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31FAD642C7;
        Thu, 25 May 2023 04:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D00C433A0;
        Thu, 25 May 2023 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990293;
        bh=ZThlpl0wh0DHlOhIIXitNE+co8zwdH3GfJCidxB7K3U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W37ESt4+GSQrDwuwXhmheEwE4w/IJ95OfrpojLMVRinI3UoxR2dNboYNbNQ3nupYT
         dS1aQfhr7DBGXeyJug7y0+pxhWBfVv99zCqxj9uh7F1DZ0A3pruAXTApfcYc18zjk8
         8wPaqLKoOmseQtv+3VFcdeJyhNTfjzEIndEUqjUzKqwJ2/a7gYssL15bwfshDWNpvv
         iHWy4+UgdoX0xX3yrxLtGGRtFmnQHrkoZXTbvzpUUK/rusDFBovf2+3YfSDXsIdVYg
         BGDG1Km449a0Qn0pn7iIWOGRbM5ws8kOFYAo3rUzoHrgU+hYNScW/TygSe9a1Sut/p
         rZz2MDIjPosOw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: drop unit addresses from USB phys
Date:   Wed, 24 May 2023 21:54:13 -0700
Message-Id: <168499048184.3998961.9662772861325874233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420065318.23503-1-krzysztof.kozlowski@linaro.org>
References: <20230420065318.23503-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 20 Apr 2023 08:53:18 +0200, Krzysztof Kozlowski wrote:
> The ulpi node does not allow children to have unit address:
> 
>   Warning (unit_address_vs_reg): /soc/usb@f9a55000/ulpi/phy@a: node has a unit name, but no reg or ranges property
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974: drop unit addresses from USB phys
      commit: b5c0e4a078772aa42257050df249af88301f6b13

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
