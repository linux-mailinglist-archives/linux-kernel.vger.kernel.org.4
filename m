Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9470E3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjEWQ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbjEWQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46451DD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D804E61FA3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6749C433EF;
        Tue, 23 May 2023 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684861183;
        bh=P3E2wDx4PEFJ1c/DNsxb1khluBUhnUj2BBZJb9GtYPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2fyuG+9DOrriKhZKdsLpsz25X0bvQmBoEP/aXVT7gfs86khsKU3qMVBnCfE0LBUL
         dHgdLcaoJtOhB1JmrlciCBpepxcQYTVCUDTTihkO8GV6DjGYJcriOicmEJrBIka6hg
         BUp4w3yG8rzbBqCbUBWzN8z1Yu+XSaMgLrfLouiY=
Date:   Tue, 23 May 2023 17:59:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Message-ID: <2023052303-bless-elevation-6905@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
 <20230523100239.307574-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523100239.307574-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:02:38PM +0200, Miquel Raynal wrote:
> +		The cells/ folder contains one file per cell exposed by
> +		the nvmem device. The name of the file is the cell name.
> +		The length of the file is the size of the cell (when
> +		known). The content of the file is the binary content of
> +		the cell (may sometimes be ASCII, likely without
> +		trailing character).
> +		There is currently no write permission but this could
> +		evolve in the future if the need arises.

No need to have these 2 lines, you don't know what will happen in the
future, don't tease people :)

thanks,

greg k-h
