Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168AF677A75
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAWMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAWMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:03:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FFB9008;
        Mon, 23 Jan 2023 04:03:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E82560EA8;
        Mon, 23 Jan 2023 12:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737EEC433EF;
        Mon, 23 Jan 2023 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674475403;
        bh=2vRkJy1jPVn+EmgWE8R3/Pd6by7UgXua8Abm0Bc7PCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWZHlRqE/XIb8+Uk+e2IeM6ZAogxeV6RThWrJpfxV7YKO718XgVecGuAQrk6HsIBn
         Jdn4M95qDKHTE5IIw/3DYEeIVi0MPCJtUCrmJGh1vtkR7ZAdRmQyT2LxBp9C2ETyY+
         U/HlL0pFntlEXTZkuRoDuXmOst/wVSm93dSbBXGlcYEaKU/otRhzqTpjc6HWvylsAN
         VpbrOjlveFNmCOnwumkr2Wn1LBkhoaIuj8C2o/sY4QRs8jEy7vK91OJBDX01AdVoxK
         DoPcTH8lPqKIUM9WbyvLhxuynDzUbI7NHyFNvU0/5Uk5qT39Y9s6az4ZVX/HaF9sot
         EwwqbAp+Wp55A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJvXk-0001zc-Rh; Mon, 23 Jan 2023 13:03:20 +0100
Date:   Mon, 23 Jan 2023 13:03:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y853iEBf1e7uh/wX@hovoldconsulting.com>
References: <20221130081430.67831-2-luca.weiss@fairphone.com>
 <Y6xP4YRAp68TfxFi@hovoldconsulting.com>
 <Y8BIX+js1ircJyb9@matsya>
 <cf968a25-02f7-d402-530b-eb379b707e54@linaro.org>
 <CPR2LS3SJQ3I.Z7UY505COG3@otso>
 <CAA8EJpoOMMALHz7ysft6KvQaYhGWPD+xZiUjOTrC8CA_y81n-w@mail.gmail.com>
 <CPX2VVT5EUDV.2LH6VI2586F02@otso>
 <Y85WqDrGXAXp7gS/@hovoldconsulting.com>
 <a18359f8-6495-dbea-2323-8ab73bbfc472@linaro.org>
 <CPZJ4F39LES0.ANG4EP8EUFI7@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CPZJ4F39LES0.ANG4EP8EUFI7@otso>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:22:32PM +0100, Luca Weiss wrote:
> On Mon Jan 23, 2023 at 12:15 PM CET, Dmitry Baryshkov wrote:

> > There are two SERDES regions. One used by USB part of the PHY (at 
> > 0x1000) and another SERDES region used for DP (at 0x2000). As Johan 
> > described below, vendor kernel handles the DP regions in the DP driver. 
> > Possibly this caused a confusion on your side.
> 
> Ack, I think I got it now. I also see the registers used downstream
> now, e.g.:
> 
> techpack/display/pll/dp_pll_10nm_util.c:#define QSERDES_COM_LOCK_CMP2_MODE0             0x009C
> 
> So now .dp_serdes should be 0x2000. Do I need to change anything else
> also? I think not?

You also need to add new dp_tx/rx pointers to the offset struct and use
those in favour of the current ones if set. I think we hashed that bit
out in one of the previous versions of this patch.

Johan
