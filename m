Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9C675DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjATTQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjATTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:16:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80624AA41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:16:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so5883257pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCTlYntdRgC/e/OHfXERmz4JTpH8MxX2a2uQoCMaeEw=;
        b=CcMDWOHcyMnDiMwpgS5KqKwroy7aL1E0Ae04q5EpKSaPeVXGENNuXVZh1k0Yl9Qz0v
         BQOBkxIcFHCOL3MMLUutpeFghnqEzE+QGhESgvpGiZg1X7LUn/pbyNBpeiiMgwGHVAep
         rdBKE8JXBwffXj2zUp06Yu8REDfy+HIl3/sEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCTlYntdRgC/e/OHfXERmz4JTpH8MxX2a2uQoCMaeEw=;
        b=KwWHbBF33TeBuy6dXULGqPNI9C0P4aUJZSSTCvohyCIN1rOAxQV4wZcl10DwTJMIPw
         NwjVK2rLkSLpmWDLpxbWPQUIXDNoDepPVFd0ZAr9C/t9PxUz4KtZk04yZRSl+uNQmi3q
         AJYGFEi9ruPIXbMemMbaZltw1dx7NmJ89zgUPk9Bk5uoDTXn1GsKk6phu5RF10Y2eRMC
         XSkKOjaXe1lbJTfwRJ5YMUqm00UjIyfOA8+zYVGTLr3VEUzQEmrmDo02SQ3D5CtG1i1l
         CyU70a4HD7slsfu83Cl2/zrrQSq0xpehf0CImbg3h545UatazuicJ8I+ijXQLcMD99e9
         kcdg==
X-Gm-Message-State: AFqh2kowddrMARoRAIq7VdBPvYLpEvhMVIyWEQ2YdZMhSYtWHrjWo9yf
        GAYmUnfuLCflJX18alTEJ6s5ew==
X-Google-Smtp-Source: AMrXdXtXgcXIzHSpoCCIGk2/oEfPyUo0g+DDqUTAM9VueR6qgPjttfn4ZtIrjTyXomEzUx6R0vvSKw==
X-Received: by 2002:a17:903:210a:b0:192:6195:44b6 with SMTP id o10-20020a170903210a00b00192619544b6mr14493111ple.58.1674242197238;
        Fri, 20 Jan 2023 11:16:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ab8b00b00195e8f97e72sm1447209plr.111.2023.01.20.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:16:36 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:16:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH] ACPICA: Replace fake flexible arrays with flexible array
 members
Message-ID: <202301201116.6ED85A70@keescook>
References: <20221118181538.never.225-kees@kernel.org>
 <202301151037.20CC3F0@keescook>
 <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 07:10:52PM +0100, Rafael J. Wysocki wrote:
> On Sun, Jan 15, 2023 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> > > Functionally identical to ACPICA upstream pull request 813:
> > > https://github.com/acpica/acpica/pull/813
> >
> > Any update on this? Upstream is currently unbuildable since October.
> >
> > > One-element arrays (and multi-element arrays being treated as
> > > dynamically sized) are deprecated[1] and are being replaced with
> > > flexible array members in support of the ongoing efforts to tighten the
> > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > >
> > > Replace one-element array with flexible-array member in struct
> > > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > > padding in a union with a flexible-array member in struct
> > > acpi_pci_routing_table.
> > >
> > > This results in no differences in binary output.
> >
> > In the meantime, can you take this patch for Linux, and we can wait for
> > ACPICA to catch up?
> 
> Applied now (as 6.3 material), sorry for the delay.

Thanks!

-- 
Kees Cook
