Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7907742E51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjF2U3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjF2U3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:29:38 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809DF2682;
        Thu, 29 Jun 2023 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dO7hmIBOrzfcsHDi0fyYC7YAlquxnjdeIh7cab91GmU=; b=VHiiSWZ4h708fyUTJkrjSCti1o
        tozxn2uTuIc4bjtaJR7lKIwkYTeIO2LA8gKJlStGlzmsbA37aiCi0mZ7J4+kemdAaqZnhjuGuhEu3
        nQFFl/X5/x+EZcOU28dnSk4gfeWEiacci/0a8E12GfLaWXbUzpBuzkm68bwjRVEaidzI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEyGk-000FkW-Sx; Thu, 29 Jun 2023 22:29:34 +0200
Date:   Thu, 29 Jun 2023 22:29:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
Message-ID: <7c0b2987-743f-4bb6-9783-a5484f6ded0d@lunn.ch>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
 <20230629191725.1434142-2-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629191725.1434142-2-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 02:14:17PM -0500, Andrew Halaney wrote:
> Using dev_err_probe() logs to devices_deferred which is helpful
> when debugging.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
