Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CC6093A0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJWNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJWNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA7C28E30;
        Sun, 23 Oct 2022 06:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C9D60E76;
        Sun, 23 Oct 2022 13:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D75C433D6;
        Sun, 23 Oct 2022 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666531496;
        bh=6+eyAwHUM9a5SiSkImPKRvPHxNJ5ZzLmEvwu/JNzIS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGI1FuWoO9e8gz9ZZ/K+wvqnEMLadLSRXst+zRA5TSGxrtmwrmTXS5iyi4T1AQkNp
         325pKC7EI/yodEDxGNWAzWOF0spEGTi+M9qPczQr8637tI12bUTwBFkgBlnO2r2h0q
         sDVyiokFcAW0oGSW92p+q5d9EV0B67xV8bxR6Qx4LkNKoJuwld9rdQHKwgOL+KDHfc
         /jskNF1iTdCy67euuJvsMcgXtTP8rRUALDSkodMf/c+7sTIrQtftVZHDzEo3aRYmLs
         CJdi6jQJyFhYdp/HoEZ/67ePV1vTCXT+RipaDuCBaGrK0LqJhimknVEsIMdzIOns8/
         RRcvenrA7jMlw==
Date:   Sun, 23 Oct 2022 21:24:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] accumulated dts updates for ls1046a
Message-ID: <20221023132448.GQ125525@dragon>
References: <20220922214030.9004-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922214030.9004-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:40:21PM -0500, Li Yang wrote:
> v2 updates:
> - Style fixes
> - Updated to use MACROs for interrupt and gpio property
> - Remove dma-coherent for remaining nodes under SoC
> 
> v3 updates:
> - Added dma-noncoherent exception for edma

I probably forgot to reply, but v2 of the series has landed on v6.1-rc1.
So please send updates against v6.1-rc1.

Shawn
