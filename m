Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30479738D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjFURjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjFURjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F84193
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D5261642
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB6FC433C0;
        Wed, 21 Jun 2023 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369149;
        bh=XzATrKBRqfI29gJm2bbNLUAzSyjyHq8SXaCsI8n8N94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhs6UOnXah/SuVVEsfbiDT+iwMF9Wzi90aebzSJ66Jo1cMrkwGVOFd3I1XMp/HFLh
         8cPAQpZFolSPtP/hRFwR3T5YFbIxxkvo5+UH/UcMoNyt16e8Gr2aJVjBv1OVlYkMJ+
         4J38h/DbfH5qHfY44uTIJqOfhXjDqtfY5YwlSrE1A7st+35lxdi5ZbDG9ziNu8VmTA
         c7cDT4duhwTh6MzN3v29YBqZDRrllBMmiXdrg0NcMmGo+foHga1M57g6OSs8bXOBVw
         18w0uSEi+dY+tfrLfzYBP0MeSiZKdVicJgfjRLpA7lFGa//zri4tHxfQkz3P6IDSjz
         o1/TURbkre6Vw==
Date:   Wed, 21 Jun 2023 23:09:05 +0530
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
Message-ID: <ZJM1uQbXM7rciJ3l@matsya>
References: <20230522172415.1668975-1-mawierzb@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522172415.1668975-1-mawierzb@cisco.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-23, 17:24, Marcin Wierzbicki wrote:
> Add single link SGMII register configuration for no SSC for
> cdns,sierra-phy-t0 compatibility string.
> The configuration is based on Sierra Programmer's Guide and
> validated in Cisco CrayAR SoC.

Applied, thanks

-- 
~Vinod
