Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8629162B0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiKPCDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiKPCD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:03:28 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37064272C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SgmPhoOddXJ9ja4e+7tjqVR//aDGlJTvvArkHGveq5E=; b=s3zHc1o9jdt8nXSMRhrA7jc+kU
        ChJsnOMOfsIuzA+Zy3yq7V74ArjEAq0dhCLetLCPAo0oIYd1jIaXSQxyQttXXLwY/PmVU5aH/Nj4x
        nZ378idq86lq30/666/7KFcBLooDo6H90ewYbUnPu7Bw120exLw6YIBX0t5OnEmfUzfg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ov7ls-002WHG-P9; Wed, 16 Nov 2022 03:03:24 +0100
Date:   Wed, 16 Nov 2022 03:03:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: switch to using gpiod API in pm-board code
Message-ID: <Y3RE7LD0+iBEr+8m@lunn.ch>
References: <Y3Qc6et/d+vhd71Q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Qc6et/d+vhd71Q@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:12:41PM -0800, Dmitry Torokhov wrote:
> This switches PM code to use the newer gpiod API instead of legacy
> gpio API that we want to retire.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
