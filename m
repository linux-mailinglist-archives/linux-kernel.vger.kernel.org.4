Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE420601115
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJQOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:25:57 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 07:25:54 PDT
Received: from smtp-out-01.comm2000.it (smtp-out-01.comm2000.it [212.97.32.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC092FFE8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:25:54 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-01.comm2000.it (Postfix) with ESMTPSA id 9411F842856;
        Mon, 17 Oct 2022 16:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1666016303;
        bh=byyLB/Q5qvbB+V//B3T1ZZ9p8aVBtWPiYb30AEr4b8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RqRaZ3o+OwIT+M71Wbow17+TaQ461unqVxyG4gdfGeCVdjpX5lLpWUVroiT99vedz
         1uBFP/QkCZms1+0DvnyQlXZozedH37I8UUUICG/53fi1J9Fg1mwjCjGEL+ZsJz9zzo
         gOEZ+/gNWZrVEyhxFdG0RVnTDPH9C3nyZn7RUkPAZECEtuMBuDNH5t4wmlBDOFngCI
         9RJt8sjdcRH/grUltkW2n2QXVJfjwvwpsyW5lgECBNgZtKH/qrJqVsDsP/DHuH4TO7
         bFO6jF2+NWubmYpQfjPPmOIQmLK6kEy15LJw6317MQaNH3BSe7YIpRpYtJjFxHMZWk
         JJPgWsSuTp2Zg==
Date:   Mon, 17 Oct 2022 16:18:13 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@linux.ie>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1] drm/panel: simple: set bpc field for logic
 technologies displays
Message-ID: <Y01kJbZjkwo1A8l1@francesco-nb.int.toradex.com>
References: <20220831141622.39605-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831141622.39605-1-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:16:22PM +0200, Francesco Dolcini wrote:
> From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> 
> In case bpc is not set for a panel it then throws a WARN(). Add bpc to
> the panels logictechno_lt170410_2whc and logictechno_lt161010_2nh.
> 
> Fixes: 5728fe7fa539 ("drm/panel: simple: add display timings for logic technologies displays")

Hello,
just a gently ping on this. It applies cleanly on v6.1-rc1, anything I
should do?

Francesco

