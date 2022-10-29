Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06726611F22
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ2Boj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Boh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:44:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B822189
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:44:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 130so6199276pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOilMmjpabMBP6lbtmoPdAvGW0C2EX+ahZ9p24ZQQlI=;
        b=lmLpsUA1Cvy+01SKRuVljHn8ljwtr5HWbkQY5Dsldo2NPanmhoJEOUYixPgpxspCkH
         smsV2XBCrNqBdjs9No4ZFj58GewppuFM7R6Or9WofJUS/bMSrZK2vPQ6myjTljbIcUGM
         FtbAb0BLnwe1LWbqwfySZyUfLDGdmh39E5MoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOilMmjpabMBP6lbtmoPdAvGW0C2EX+ahZ9p24ZQQlI=;
        b=H26X+9efnnSIfYmf/TIQ7FZE5taHzyeEcoL0FrZylut9IMfNQDaWevxSRQUx/KU7Pu
         xqETlKSKe1Xg0M64ONbg1CC8t3vTM0ENNTLAq/zL7UAbf0ITEfMwty6LiUQ6/14i6NNl
         WvCy3zXJ3FYJui2w7C+ohH3Mpqc2HibNggzzgyGJ3mH0wIhCRFRRTRIrPyMh37b7Dp50
         Oi3TY9LZrulgFo0jkW/ZM/dP7ubhrPdJBOj3dzZe41FqbEql05H8zt7kSNwrGdJrKppz
         7bF0Xy0bEWK31eDi38t0ezPs1rVlUA4kG4KblU3249RFn2IoeHAr+6FH/Oifa1dbyXL1
         TydA==
X-Gm-Message-State: ACrzQf0UvxvJ729IfCwx//zrXU6qQVD1ko5Dzn5Vy8pSsOJ2oJn4qYyZ
        W8btrKQWeHGWccRPtJ2uS/RIrw==
X-Google-Smtp-Source: AMsMyM7GrMDVnCAK61/LBqnfafk4zDoWcDpN6Y9d2KXnr9xk9xrXRf+n16gCEpTSzqs54S73/5h81g==
X-Received: by 2002:a63:581e:0:b0:43c:29a0:6390 with SMTP id m30-20020a63581e000000b0043c29a06390mr2156483pgb.552.1667007869602;
        Fri, 28 Oct 2022 18:44:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with ESMTPSA id z190-20020a6365c7000000b0043014f9a4c9sm85791pgb.93.2022.10.28.18.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 18:44:29 -0700 (PDT)
Date:   Fri, 28 Oct 2022 18:44:26 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: ehci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Message-ID: <Y1yFejAhNogYVpIW@google.com>
References: <20221028141821.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
 <Y1x+KmXhzikbEm8U@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1x+KmXhzikbEm8U@rowland.harvard.edu>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:13:14PM -0400, Alan Stern wrote:
> However, I'm curious to know why this patch makes ehci-pci use 
> PROBE_PREFER_ASYNCHRONOUS even when CONFIG_PM isn't set, whereas the 2/2 
> patch makes xhci-pci use PROBE_PREFER_ASYNCHRONOUS only when CONFIG_PM 
> is set.

That's definitely a bug in patch 2. This has nothing (or, little; probe
order can technically affect the PM suspend/resume order) to do with
CONFIG_PM, except that the .pm hooks tend to sit nearby, and repeated
driver patching makes the author's eyes glaze over sometimes...

Thanks. v2 coming.

Brian
