Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F46B8AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCNGCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:02:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9574994768;
        Mon, 13 Mar 2023 23:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 479B6B81854;
        Tue, 14 Mar 2023 06:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E21C433D2;
        Tue, 14 Mar 2023 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678773762;
        bh=2z8L+7OUL/6MuF2OlPGvdfpv41n7u+Ie+JYlo0G7z9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeDMa9TsHbPr3SmTLaKEzZeHqoNNfJjvAa8LinvbECZFn1yaPd/gu4MBjiRQu3INs
         +4uoGFbmwA/OjSSaqBraPYbzY9CDfblJEm41dJfTGatb1xNmXZpI6D5N7SuwMx2co1
         +xe3FINNjhdFoi6U2Raw71kxD6PEM57KTD8jMcWc=
Date:   Tue, 14 Mar 2023 07:02:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Samu Onkalo <samu.p.onkalo@nokia.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] misc: apds990x: Remove unnecessary return code in
 apds990x_power_state_show()
Message-ID: <ZBAN/DHtskVQd2E5@kroah.com>
References: <20230314012732.2267077-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314012732.2267077-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:27:32AM +0900, Nobuhiro Iwamatsu wrote:
> In apds990x_power_state_show(), the return value of sprintf is returned, so
> 'return 0' is unnecessary. This remove 'return 0'.
> 
> Fixes: 92b1f84d46b2 ("drivers/misc: driver for APDS990X ALS and proximity sensors")
> Cc: stable@vger.kernel.org

Why is this needed for stable kernels?  It's dead code removal, no
actual functionality is changed.

thanks,

greg k-h
