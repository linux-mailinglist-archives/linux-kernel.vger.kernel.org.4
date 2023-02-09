Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B868FE7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBIEXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBIEXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:23:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E704215;
        Wed,  8 Feb 2023 20:22:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DCB66188D;
        Thu,  9 Feb 2023 04:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5CFC4339E;
        Thu,  9 Feb 2023 04:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916480;
        bh=SFUT3VGFn8/Q/iO9Sl+Rn0E0SDYWTwCE25MxTeAoBvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5AXm1ATH8KyNoNgDRBFpRXMhEWTcOvz3+gQmUN2RchzxsNxTfHAsWI3oHosIXN+6
         OqALGfrI9+D6XVDbRXBP8H9XtxRFBn2MotXjiqkuIP7aYvI1iPuxsATyyCzZGrD+Lh
         wYqVrfR6bulTmXHbKKIKmX/2i31uaDnimNto6s4EbBhmloe/vGq9bHkOAaRwyRw6t9
         n7wIIhVzgQ8AZsHMipP2upVWnvKl1yUqibolscDvcn/8guc4bp8zBAxdBXok2+hilW
         wTJiOPgI/OawoykxsRFnIDMV+MjvoOk+kPypoor+OWNi5sTNsOMNCItmQVDQHSSKYe
         R1+fov2h/DIPA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: arm: qcom,ids: Add Soc IDs for IPQ8064 and variants
Date:   Wed,  8 Feb 2023 20:22:38 -0800
Message-Id: <167591660367.1230100.11250387895518349565.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124143236.1038-1-ansuelsmth@gmail.com>
References: <20230124143236.1038-1-ansuelsmth@gmail.com>
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

On Tue, 24 Jan 2023 15:32:35 +0100, Christian Marangi wrote:
> Add Soc IDs for Qualcomm IPQ8064 and variants.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add Soc IDs for IPQ8064 and variants
      commit: d615ef0c922683320d2f8e814637cf1c9b53ed44
[2/2] soc: qcom: socinfo: Add Soc IDs for IPQ8064 and variants
      commit: 79802479250f4ea25b49571f982786c7ef42c43b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
