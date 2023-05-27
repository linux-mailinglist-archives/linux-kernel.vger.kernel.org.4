Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CA9713145
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbjE0BEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjE0BEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABBE55;
        Fri, 26 May 2023 18:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14251654DE;
        Sat, 27 May 2023 01:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4385C433A8;
        Sat, 27 May 2023 01:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149439;
        bh=nfmPm45a2JUKau9DbUMAIuvgdFb3pfdYNCXf9o7mpNM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IgNuJE/NA2AEktLm50dGDQYgXrz4h43MITaY8Pszg4SllljnohtcOw9crkAF7sh/2
         ANWWrBj5aWMimJL6bUERi7kZMxc4vCefVDahyk2vtS9/XiCOJsdNde/pBk7W3hk34s
         PljS8ukMDDW+kKrJ8I6VfimAFCbg168ohyv5SkNRpHEBqhYmZrmP+SC7gFRSKOjGBO
         c2TJz1VMvdAclMDdfoWeYbdsdRh/I25mSrH8HZsiSBloZzaLTPCxgjjEW027YTdXlz
         9CjHLOiJTCqc1NlaaZuE34wTqhMFt8Lp3ofK2hNiG1QWMGILAw2LLKicVpv7e9/RLY
         sqKsk64WpUiUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-clk@vger.kernel.org, agross@kernel.org,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: (subset) [PATCH 1/2] clk: qcom: gcc-ipq6018: update UBI32 PLL
Date:   Fri, 26 May 2023 18:07:34 -0700
Message-Id: <168514964949.348612.8816630754645554144.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526190855.2941291-1-robimarko@gmail.com>
References: <20230526190855.2941291-1-robimarko@gmail.com>
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

On Fri, 26 May 2023 21:08:54 +0200, Robert Marko wrote:
> Update the UBI32 alpha PLL config to the latest values from the downstream
> QCA 5.4 kernel.
> 
> 

Applied, thanks!

[1/2] clk: qcom: gcc-ipq6018: update UBI32 PLL
      commit: f4f0c8acee0e41c5fbae7a7ad06087668ddce0d6
[2/2] clk: qcom: ipq6018: fix networking resets
      commit: 349b5bed539b491b7894a5186a895751fd8ba6c7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
