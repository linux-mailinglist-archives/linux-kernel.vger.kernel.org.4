Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034B7640FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiLBU76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiLBU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D6EBC86;
        Fri,  2 Dec 2022 12:59:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F4168B822B6;
        Fri,  2 Dec 2022 20:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081A6C433B5;
        Fri,  2 Dec 2022 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014746;
        bh=3Op6TlsSXEw8qI++q/WlUZ64189LgkeQ2qYwrAfv/+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVSxhhUhHQ+xqSYNicwU9bF4EKFdi2pBoq58BX19ykgTWwFBT/7+LvBih9fleuJtJ
         vEV5m95K8GgXNMalxH91N1j5otaCxzHQ/RNnQX2fn4yt00i9cjcQGU6JecXbg/89Pl
         Pd8CnvLZOpHyGM0Np/slcK85PQ10/oxYb2v3GAoySQdE5/hDS24BYtwWcXg+aNa4Lf
         VH3IP6nPv06kI094JEtWDXLEVC6AIQ7FxEoKoBswZtBLw99cdp81URkP9Lep+wl5sN
         ZQng1cpbRFoJVZmyhnHF2TwM2idkiUTzmreGO6ROEqmTOkuBv+Rpsn1APi4D1zMRUY
         FvQN2DljC5VBg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     konrad.dybcio@somainline.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: hfpll: use devm_platform_get_and_ioremap_resource()
Date:   Fri,  2 Dec 2022 14:58:52 -0600
Message-Id: <167001472426.2721945.11969464965197684975.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <202211171403340042731@zte.com.cn>
References: <202211171403340042731@zte.com.cn>
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

On Thu, 17 Nov 2022 14:03:34 +0800 (CST), ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: hfpll: use devm_platform_get_and_ioremap_resource()
      commit: 0c44be063948bb02918c9ef5332e0e65daa94fc7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
