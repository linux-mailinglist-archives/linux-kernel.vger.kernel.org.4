Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02224608C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJVLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJVLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:11:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166541A2E12;
        Sat, 22 Oct 2022 03:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8BB1B81B14;
        Sat, 22 Oct 2022 10:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1360C433C1;
        Sat, 22 Oct 2022 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666434668;
        bh=+5LYMc9G1t+vORW3sJXjTTgdrtDBL6soqXawA6zHpeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDI97jjQHQ0d3rBWnQVJcP78xTV6jRZM+xQre1vGFQxtbVuyPWP3zr/gIwWAe++4o
         RRepSOxHCDif7tqHWh/oDFA1psAqDVbjmlvHi3ufVnTch/VlKxKR+/Pr4UjlYvcxyP
         9yXKaEvyJa/A31fsu91RbyrvoqkFLFrAPRdrRqSM=
Date:   Sat, 22 Oct 2022 12:31:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Chubb <peter.chubb@unsw.edu.au>,
        Stefan Eletzhofer <stefan.eletzhofer@eletztrick.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Helge Deller <deller@gmx.de>, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/11] ARM: sa1100: remove unused board files
Message-ID: <Y1PGaT1AtdoCNCgc@kroah.com>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155000.4108406-3-arnd@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:49:32PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Cerf, H3100, Badge4, Hackkit, LART, NanoEngine, PLEB, Shannon and
> Simpad machines were all marked as unused as there are no known users
> left. Remove all of these, along with references to them in defconfig
> files and drivers.
> 
> Four machines remain now: Assabet, Collie (Zaurus SL5500), iPAQ H3600
> and Jornada 720, each of which had one person still using them, with
> Collie also being supported in Qemu.
> 
> Cc: Peter Chubb <peter.chubb@unsw.edu.au>
> Cc: Stefan Eletzhofer <stefan.eletzhofer@eletztrick.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
