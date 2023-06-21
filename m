Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1580A738DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFURx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFURxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328812D7C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0343A61668
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA13C433C8;
        Wed, 21 Jun 2023 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369869;
        bh=z8h5oRBpUjD/vlwParcejf7w/puARjba0CWI1Xgexlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwMLAntWMTm/M6O4PJW+igS7jgGz/1ryrqDjyXu5qAXqnJPBX1FQSMK72Rcldeh76
         Q02OMMFAk6mf6wBL0XXJ9KR64/sG79ftm+ChTD2vFp3ZtJ+ak021wDR4h45Vpip+h7
         Ct3PCAflYVr+/CdW8MivG0ScPVd/mEw0oE9d/XPianpQB6s/z8GYk3k+IAMnPJmeip
         ZAtHEJ1r47JAxpHhoNKw208JnOLTC6y0daD7NDGFhdG1OmgvDQ81E3ZBR/CTG19XlQ
         Fvbq+GCFKFhxkD9XexNj2wQyP0hUdKHKhzyrDExpm/AYbQ7YGk/tO6GQTZeLCv+gEV
         ShR9bRZy/C5UQ==
Date:   Wed, 21 Jun 2023 23:21:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marcin Wierzbicki <mawierzb@cisco.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        danielwa@cisco.com, olicht@cisco.com,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: Re: [PATCH v3] phy: cadence: Sierra: Add single link SGMII register
 configuration
Message-ID: <ZJM4iUrlMIVwlfK+@matsya>
References: <20230522172415.1668975-1-mawierzb@cisco.com>
 <ZJM1uQbXM7rciJ3l@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJM1uQbXM7rciJ3l@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-23, 23:09, Vinod Koul wrote:
> On 22-05-23, 17:24, Marcin Wierzbicki wrote:
> > Add single link SGMII register configuration for no SSC for
> > cdns,sierra-phy-t0 compatibility string.
> > The configuration is based on Sierra Programmer's Guide and
> > validated in Cisco CrayAR SoC.
> 
> Applied, thanks

This breaks build for me, so dropped. This is with arm64 allmodconfig
and gcc-aarch4 toolchain

drivers/phy/cadence/phy-cadence-sierra.c:2556:32: error: initialized field overwritten [-Werror=override-init]
 2556 |                 [TYPE_SGMII] = {
      |                                ^
drivers/phy/cadence/phy-cadence-sierra.c:2556:32: note: (near initialization for ‘cdns_map_sierra.pma_cmn_vals[3]’)
drivers/phy/cadence/phy-cadence-sierra.c:2599:32: error: initialized field overwritten [-Werror=override-init]
 2599 |                 [TYPE_SGMII] = {
      |                                ^
drivers/phy/cadence/phy-cadence-sierra.c:2599:32: note: (near initialization for ‘cdns_map_sierra.pma_ln_vals[3]’)
cc1: all warnings being treated as errors

-- 
~Vinod
