Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08C615FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKBJ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiKBJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:27:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42011EEEF;
        Wed,  2 Nov 2022 02:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5CBE6CE200A;
        Wed,  2 Nov 2022 09:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7516AC433D6;
        Wed,  2 Nov 2022 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667381189;
        bh=mSmVuNa2iVDMcz+0i0b55GRgIdK4V6DaNIrH02lHInY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0ZqnIl7ITyNb8t/Z6wirSZHpRM9fmnk9SwW0HbPbDNEw9djBZS8FmSUDNU14vf/K
         ByHyWYJS72Ai19W3mlLZ4AO0Ayn1z2U3OjrMo2NEmtuQnLBgygkYlESQM0/UoN/dTl
         LQy43pECrao9oYusKOvejSJwer6NYm3saPTgTTP3bOC/nRpZsqPNuv6DDz6u4cE9Bb
         sXB1s2t6vRwJqcl8utU850F8Qv/UqWzuWtmPy6KqjlBRhAcs6m84Ws7Jkrfbem6VZo
         fFVB4wkCQcMRe6b3kD35vLuMkZ/S4BOHQVdmZOZGN1oK59CoPE0JjxSwljvZQvRceP
         OBERs9G78BlKw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqA0j-0008R1-MK; Wed, 02 Nov 2022 10:26:13 +0100
Date:   Wed, 2 Nov 2022 10:26:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, andersson@kernel.org,
        bmasney@redhat.com, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Message-ID: <Y2I3tekSAO42r0xR@hovoldconsulting.com>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
 <Y2IZaxukERXNcPGR@hovoldconsulting.com>
 <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
 <Y2Imnf1+v5j5CH9r@hovoldconsulting.com>
 <bb590bfb-07a4-97c1-e5c0-d00d840e2e11@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb590bfb-07a4-97c1-e5c0-d00d840e2e11@quicinc.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:15:26PM +0530, Shazad Hussain wrote:
> On 11/2/2022 1:43 PM, Johan Hovold wrote:

> > Right, but if the PHYs really requires CX and it is not an ancestor of
> > the refclk then this should be described by the binding (and not be
> > hidden away in the clock driver).

> This makes sense, will be posting v2 post for the same.
> I assume this should use the Fixes tag then !

Yeah, I guess to you can add a fixes tag for the commits adding support
for sc8280xp to the UFS PHY binding and driver.

But please do check with the hardware documentation first so we get this
right this time.

I've already asked Bjorn to see what he can dig out as it is still not
clear how the two "card" refclocks (GCC_UFS_CARD_CLKREF_CLK and
GCC_UFS_1_CARD_CLKREF_CLK) are supposed to be used.

Johan
