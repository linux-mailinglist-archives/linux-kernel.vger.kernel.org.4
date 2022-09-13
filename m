Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525A15B77C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiIMRXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiIMRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:23:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ABD2A707;
        Tue, 13 Sep 2022 09:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD60B80EFD;
        Tue, 13 Sep 2022 15:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC62C43142;
        Tue, 13 Sep 2022 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081492;
        bh=VxK/Ao0oo5PhdsdjlE6Wp+00HkGHmSbxr14/9GViX38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OanizUuulcrd15daBYvthHJlgIAPnh6XM/g3pcPOUR5n+60wyn+0a745+WO2MG7b8
         nYg86MyDT9zkigt+BjvRENI0OauaTwPXR3R05zpoh0+ucu4r41JVHLey3VlLg6A9Ut
         d+wqGQbKU10OdiHh12O/r3RYUlas+eLdVRNd2SBy+1m9NiLyTz3SBneNImPObciAjA
         Tcm/5eeSmCmyxyo+ThmCUQMLQ/UnUpa7uDbLbqe6sCjuL565KQsDcWxaviXP2a7l9H
         3TuIQhfarW+Y2omQJ3WPTFw3GZTxX7Yv1e5Hc9nWobCUyWFqs05Djt2ozoddZrJdvJ
         1v4iqb71kY9Gg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_c_skakit@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        robh@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, quic_tdas@quicinc.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH V9 0/5] Add support for audio clock gating resets for SC7280
Date:   Tue, 13 Sep 2022 10:04:44 -0500
Message-Id: <166308148204.625876.2348780942882389451.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1662005846-4838-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1662005846-4838-1-git-send-email-quic_c_skakit@quicinc.com>
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

On Thu, 1 Sep 2022 09:47:21 +0530, Satya Priya wrote:
> [v9]
>   * Fix the order of SoB for [/5] and [2/5]
> 
> [v8]
>   * Squash [1] into [5/5]
>   [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com/
> 
> [...]

Applied, thanks!

[2/5] clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon
      commit: 0cbcfbe50cbff331c775982a53bc4fa66c875b36
[5/5] clk: qcom: lpass: Add support for resets & external mclk for SC7280
      commit: 7c6a6641c24d30ab6f5456d19e15e64bea971b82

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
