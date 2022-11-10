Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D369623AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiKJEJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiKJEJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81C27CD5;
        Wed,  9 Nov 2022 20:09:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 262A9B82089;
        Thu, 10 Nov 2022 04:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14842C433C1;
        Thu, 10 Nov 2022 04:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668053356;
        bh=3FEJA0KkULpgej9nxe0ZxnRNLWUnIRECmTmwA/pWKFw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eulmPpg88/YWoGE9kDGoaBgroCfBUDoaIEfYyLhMMJ8yvswywZhzaleZXbJMQ6+uz
         2Uy8o693DhAcmZG3rKA2gzIdpo5Tqll2X7bUgAY0FsFnS74XLSyUUf2zbPdVzI/5Uz
         DIlwDVQaWLbCGX8ziBxLFdIi21Y9zl6+UsfvGsPyR6/nJ/2QLTByGbMTOnsk3AN896
         EWbfY5NtX9SLfEfTkXfjryn6t6jdgPwlY9dbYKfaYqRa1v2tfofsa8bBuA0Kyl/HBe
         xbK/MWlf8avjFDwNjI2zf0o72q7eF1vZniyXL8+0h/vL11B80suNOZTaeU7FwHiTUg
         PQ7voWD2V2jsA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: pinctrl: qcom,msm8960: convert to dtschema
Date:   Wed,  9 Nov 2022 22:09:09 -0600
Message-Id: <166805334843.800572.5669261969891914293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
References: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 9 Nov 2022 11:51:38 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8960 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> 

Applied, thanks!

[2/3] ARM: dts: qcom-msm8960: use define for interrupt constants
      commit: 33c21ece867e845123a5c10d4384aea58cf6a21a
[3/3] ARM: dts: qcom-msm8960-cdp: align TLMM pin configuration with DT schema
      commit: 0bc33727c491dfe07e19a11f1610f0a632e0e935

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
