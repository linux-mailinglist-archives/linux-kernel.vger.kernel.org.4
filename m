Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E3F5B9348
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIODhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiIODhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69392F70;
        Wed, 14 Sep 2022 20:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAAB362085;
        Thu, 15 Sep 2022 03:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34517C433C1;
        Thu, 15 Sep 2022 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213035;
        bh=4gCABYth7iyuEnJYrxDF3rzh8uFWqfeoMXfdYGxn5OM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ahWM0Ka4seYl+AhdUaDMszGXTPXl1zvC70QSY62vbMbSTVqOfJafC765H2CQYMyfI
         hVJat99jGo3vWrvbfhFgQdRDWSAwFbg0PI+fAUV0Gwhc2raDZOp9xErdXPMxEY1LAE
         uO4h8FBQRRc8yXjelJ+Wv+nc5fLYJ4YqfeF//7iRBKLoaupEarG8CV5ibmaBVNrVbN
         c2uy8aWCa5xitYuw6eL4lpZXeKAQGKF4KvWZrGSAqkMHKPvjmDVYtOb86QE0+NB02G
         30VB0ZLiDFZaoCgIsTDqAq5R5tVCQ5AG32uITcD+f3xveq0HsZtZOboz1ztshtAMPJ
         9hgvinQaOzthw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-mmc@vger.kernel.org,
        konrad.dybcio@somainline.org,
        Bjorn Andersson <andersson@kernel.org>,
        bhupesh.sharma@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH v3 0/5] dt-bindings: mmc: / ARM: qcom: correct reg-names and clock entries
Date:   Wed, 14 Sep 2022 22:36:57 -0500
Message-Id: <166321302059.788007.2442891324765168270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 16:42:40 +0200, Krzysztof Kozlowski wrote:
> No dependencies.  DT bindings patches are independent from DTS, so they can go
> via separate tree.
> 
> Changes since v2
> ================
> 1. Add Rb tags.
> 2. Correct typo in subject of patch 2.
> 
> [...]

Applied, thanks!

[4/5] ARM: dts: qcom: align SDHCI reg-names with DT schema
      commit: 5eb82ddb7273bd34a36c05df271f34919eeea675
[5/5] ARM: dts: qcom: align SDHCI clocks with DT schema
      commit: 49c19337d0aca2e7f362d3c1a1c6f09c2dcfdae9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
