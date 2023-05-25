Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40727104C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbjEYE4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbjEYEyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC93C1738;
        Wed, 24 May 2023 21:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0ED6429D;
        Thu, 25 May 2023 04:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3E4C4339E;
        Thu, 25 May 2023 04:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990309;
        bh=Mg5+xNblxzB7LvQdn2eyHhoWieOkwzZvTCkzwL+uBr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAmL5qTR4Zo+OzOCSN6FAAbskXnnIXHzNwOrGxdlzR5X3CEEToKIG5Gbdb0sTcFjM
         OacMf7WSBYmeEjYS0mfKYNBVuZxDYlC3EJI/hSNgqepnxhBtWQF+zXBpBVHNPK1yQS
         oRpWidpBkF3WqNqCjTl3sIMR1e3OqlgTxV3k9f+o3ptlACwtUCtWmMYcfuIqzDG36p
         sLzegKflv4fVgGoikOHMsi4hImg04Wi7439+1ZEUTQ+zoo/3dC907eFxkewoZ4OAOP
         4qWvHfix1VKAUmcS28sTEyLXjTg4TzU3/X2O+fCGrAduND676uLPhqScPCq79LS+n7
         et/cFTXIoYlxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mantas Pucka <mantas@8devices.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
Date:   Wed, 24 May 2023 21:54:27 -0700
Message-Id: <168499048180.3998961.1263304299273224277.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1682413909-24927-1-git-send-email-mantas@8devices.com>
References: <1682413909-24927-1-git-send-email-mantas@8devices.com>
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

On Tue, 25 Apr 2023 12:11:49 +0300, Mantas Pucka wrote:
> SDCC clocks must be rounded down to avoid overclocking the controller.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
      commit: 56e5ae0116aef87273cf1812d608645b076e4f02

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
