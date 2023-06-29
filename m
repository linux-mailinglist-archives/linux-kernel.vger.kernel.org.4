Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BCB742E66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjF2Ucb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjF2Uc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:32:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43730DF;
        Thu, 29 Jun 2023 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/+B1m0JF0ePzkHMXkWMYiBT0nCuOnOyD0SNxb3jEcJc=; b=DKuS/3xwGn61aSTe2Kqcp7MWSz
        EdnetBlhOMCeR8CwTmvNc4EUI0vlNnU1w5XG6TXbgAqYgcG07X6zg4Pn95kkt8o/Ufven/chyeOIG
        W0R9kx3qLE+StGFBoukgnP8dTyVdmthlQioIYluZN7AHmytF7hXsN9B7zqiy8RxPOAaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEyJU-000FmU-Ts; Thu, 29 Jun 2023 22:32:24 +0200
Date:   Thu, 29 Jun 2023 22:32:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-qcom-ethqos: Log more errors in
 probe
Message-ID: <e9157117-bd7a-4b75-841e-090103f75d22@lunn.ch>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
 <20230629191725.1434142-3-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629191725.1434142-3-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 02:14:18PM -0500, Andrew Halaney wrote:
> These are useful to see when debugging a probe failure.

Since this is used for debugging, maybe netdev_dbg(). Anybody actually
doing debugging should be able to turn that on.

      Andrew
