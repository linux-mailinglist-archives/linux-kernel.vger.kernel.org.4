Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8483675315
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjATLKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjATLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:10:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857A39297;
        Fri, 20 Jan 2023 03:10:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FAB461F27;
        Fri, 20 Jan 2023 11:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F20C4339B;
        Fri, 20 Jan 2023 11:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674213034;
        bh=8ILoNXGp/nOCwjGVsc/+wzYZ4Z5EcwigmF6JP/H/AR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TR5AAFedGSa9dPlj7WdQUhWsh6VwPUpearZEsZu6Kys4dvlLJEVixwftd7meQ8ih/
         MVlNeXlxnEEnuLhXsLU5VaGm+9iwKaslC0BNmFG4gMzbbIdQubWlhcHCCPKsRTYvJ6
         SSyqLSZlWvsKhhxU0fZMgkUhxhGAqTSLUdL76bxY=
Date:   Fri, 20 Jan 2023 12:10:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     appanad@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH v7 4/4] drivers: misc: Add Support for TMR Inject IP
Message-ID: <Y8p2qOdzONxHfN+X@kroah.com>
References: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
 <20221125054113.122833-5-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125054113.122833-5-appana.durga.kedareswara.rao@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:11:13AM +0530, Appana Durga Kedareswara rao wrote:
> +static int xtmr_inject_remove(struct platform_device *pdev)
> +{
> +	debugfs_remove_recursive(dbgfs_root);
> +	dbgfs_root = NULL;

Nit, no need to set this to NULL.  Not an issue, but something you can
clean up later...

thanks,

greg k-h
