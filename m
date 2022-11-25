Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF33C638777
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiKYKYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKYKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:24:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB045EC1;
        Fri, 25 Nov 2022 02:24:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2C262354;
        Fri, 25 Nov 2022 10:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75A7C433D6;
        Fri, 25 Nov 2022 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669371854;
        bh=UZVGoBnwbqgX7QHkA+XxraCebfb9ih7yV/82oceIMgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAbBEKzxQW3BJZfTG3aYOohUWiAEpSVowGD+CqfEjT8iYkTbMJEAsEKTliV/+bqc1
         xxb9OJelnz/cJhh3L0D5Uz8EKycRJhlfH6T1vn2tOHn+YRcBMhlWIvc4ADNjpPpFW/
         gGCnr/UkoQ6/V7bjzt17DnpvC1acTDhrsqhX4sftEnHDIe19vcxaQQ1KRnQZz/FvWl
         4M/h/My7xpHg3YWA6UKLx+ISzvzs5uWGi0/O7FpL/Te4XIMIy0S/Zb0Q7KWzmTm0Kv
         /Uo9y+M9o27zetPCwtL1sNeJrwIQXRvzrEzrBx+FFAcSfyB4Cmz5vG7GZUgps4CTAF
         mnC9lixd0c2uA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyVs6-0002aK-Av; Fri, 25 Nov 2022 11:23:50 +0100
Date:   Fri, 25 Nov 2022 11:23:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] phy: qcom-qmp-combo: Add config for SM6350
Message-ID: <Y4CXtn/o3aNvBNh5@hovoldconsulting.com>
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
 <20221125092749.46073-2-luca.weiss@fairphone.com>
 <Y4CSYZE+3fZCV4Z3@hovoldconsulting.com>
 <COLAQH772WXW.P442ICY46TDR@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <COLAQH772WXW.P442ICY46TDR@otso>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:14:53AM +0100, Luca Weiss wrote:
> Hi Johan,
> 
> On Fri Nov 25, 2022 at 11:01 AM CET, Johan Hovold wrote:
> > On Fri, Nov 25, 2022 at 10:27:48AM +0100, Luca Weiss wrote:
> > > Add the tables and config for the combo phy found on SM6350.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > > @Johan Hovold, here I've added dp_txa & dp_txb, I believe otherwise
> > > qmp->dp_tx would be wrong. Is this different on sc8280xp or was this a
> > > mistake on your side? I think this should probably be split out to
> > > another patch to not mix things up too much.
> >
> > Yeah, that's a difference in sc8280xp which does not have dedicated TX
> > registers for DP.
> 
> Good to know.
> 
> >
> > This is probably best handled explicitly when parsing the DT by using
> > dp_txa/b if they are set and otherwise fallback to txa/txb (e.g.
> > instead of hiding it in the v5 table by using the same offset in two
> > places).
> 
> Are you thinking about something like this?
> 
> if (offs->dp_txa)
>     qmp->dp_tx = base + offs->dp_txa
> else
>     qmp->dp_tx = base + offs->txa;
> 
> if (offs->dp_txb)
>     qmp->dp_tx2 = base + offs->dp_txb;
> else
>     qmp->dp_tx2 = base + offs->txb;
> 
> This wouldn't handle ".dp_txa = 0x0000" but I don't think this should be
> a problem, right?

Yeah, that should be fine. I'd even merge the branches:

	if (offs->dp_txa) {
		qmp->dp_tx = base + offs->dp_txa;
		qmp->dp_tx2 = base + offs->dp_txb;
	} else {
		qmp->dp_tx = base + offs->txa;
		qmp->dp_tx2 = base + offs->txb;
	}

Johan
