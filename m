Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CFD6C4E29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCVOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCVOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:42:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30C66D31;
        Wed, 22 Mar 2023 07:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99AECB81D14;
        Wed, 22 Mar 2023 14:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE65C4339B;
        Wed, 22 Mar 2023 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496133;
        bh=+rtArz9QGyfrNHsU+wfHjMys4h4t76CgGRPnARKCF4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV2zvnzg5ZuopZJEnZIM0rjpxTEJBk1rSdNdU0LXkx9kNKTz3p7k27diU3tkXJpKr
         MWXMzkV2rwf7MfzmhWjg28nAcugOblKFyDM8pkTtlYX/1m7BInKPmDAayz35K7+h4s
         5jV91cHt+F5RBxpGMoMgArrh0THiWzbMccAqB1Q6vsiru2mEezYYcwwRLVxAaDm7ey
         WO/1ruu413elq4Dl1q/UfVPOHEkSgriJVbIShGjY1oIYijXoafDc+sTpT/p0x3eaea
         itmX3O0BUFdhrxfjOjCU5+9rQFPnFGbmjRWWeN+vUEOdWB1VlKGce2QIxa7e805IFS
         D5rW8pbZKRpDQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     konrad.dybcio@linaro.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 0/2] arm64: dts: sm6115: Perform USB node related cleanups
Date:   Wed, 22 Mar 2023 07:45:03 -0700
Message-Id: <167949631650.1081726.14012743385457876144.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314083633.1882214-1-bhupesh.sharma@linaro.org>
References: <20230314083633.1882214-1-bhupesh.sharma@linaro.org>
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

On Tue, 14 Mar 2023 14:06:31 +0530, Bhupesh Sharma wrote:
> Changes since v3:
> -----------------
> - v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20221215094532.589291-1-bhupesh.sharma@linaro.org/
> - Split the series into two - this patchset proposes only 'fixes'.
>   The USB SS qmp phy change will be sent out separately now that we need
>   a driver change as well.
> - Also fix the recently added sm6115p lenovo dts.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm6115: Cleanup USB node's label
      commit: 0ea0edc04a04e3e36fa7d0b3c8463b0440764cf1
[2/2] arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and 'dr_mode' properties to dts
      commit: 1f1e512288edf0ef99d9ceb9af29e2e004341ced

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
