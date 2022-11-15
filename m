Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B076629985
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiKONBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKONBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:01:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031896458;
        Tue, 15 Nov 2022 05:01:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9262A61736;
        Tue, 15 Nov 2022 13:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F204BC433D6;
        Tue, 15 Nov 2022 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668517294;
        bh=cghDh8Va/Q5LQMx7fDxebOXRPrb9UBTPEQAnugP4Wq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQEqRBZumHPNLBw3c3qmEi6My9KaZH222LzaWmJvlnzLzeFMIakStZP/DorPVjpiD
         3qR2wS5R6A8NZZFardBqj6NayLGsZ/3Un70CGsQhlU9z/umUZs4IE6YdCn6NUA89bS
         Yv7D6Imc0lNIUkW6xpTj1j+voSA593SGyezGZxqkmGnkNjDs5pf+aEIZqIf+KnAIsw
         uOnoockxAbRYOTQZqJObCtRtDM4K/3IKw+T6WoVoBd1Rhu21iVbMx1tyDF6kKKcT+L
         b9uqd+uvapJrCSwQh10YeKYk5hxT5Dv+L8J7TE/AJ6PoOABExytcNeCn2lJDz3zba/
         CTeXyA1rffzkQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouvYm-0002Cu-0D; Tue, 15 Nov 2022 14:01:04 +0100
Date:   Tue, 15 Nov 2022 14:01:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org,
        sboyd@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
Message-ID: <Y3ONkOhcdK+gt46g@hovoldconsulting.com>
References: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
 <Y3OLDj6xzOVjvEdV@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OLDj6xzOVjvEdV@x1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 07:50:22AM -0500, Brian Masney wrote:
> On Tue, Nov 15, 2022 at 03:52:17PM +0530, Shazad Hussain wrote:
> > Added parent_data as CXO for three UFS reference clocks named,
> > gcc_ufs_ref_clkref_clk, gcc_ufs_card_clkref_clk and
> > gcc_ufs_1_card_clkref_clk.
> > 
> > Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> > Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
> > Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Put this Link beneath the --- since Bjorn will add one that's specific
> to your patch when he adds it to his tree.

I think it's ok to keep that Link if it was intended as a reference to
the discussions leading up to this patch. There can be more than one
Link tag, and this one is more in line with how Linus thinks they should
be used than the ones added by tooling such as b4 when applying.

Johan
