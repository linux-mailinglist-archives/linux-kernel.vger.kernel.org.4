Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B774DD84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGJSky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGJSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:40:52 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF60E6D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:40:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7658752ce2fso346368585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689014429; x=1691606429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp4+jo/0AHmLulNuvIh/KwLGCyw4HNK3R4SueheNcGY=;
        b=lYxf8rghghWJv0Q/vA+V23rYsyKhY8pOyeUVCpJjWaQeoVTTwwX5NsHIOYN6eF/d5q
         1OzslYw7Mew3LXDQCKkepu0Mk88a/7qtxxHvKbssn1FyLQ7dc10gcdJv6dtWSE51dqeq
         EBE4968gpBAofOVhg3FiKpizWNQgR7ux/JcfgP37z0nzpjyNHw/6MYL38g/Aj1kfytSS
         A8QlNgghxoMgCo26xqlUi3iXl8p7ENNY9Ev6lhCIkFPIiEAhJUJvX/icgklDaLGZ772+
         GjDzmwjFSJsSnlH2SGmSoJi7KBvTF5JRBpQok9/rdqRbYvqTwGN2tDW0hQY2kjtQhndb
         +h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014429; x=1691606429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp4+jo/0AHmLulNuvIh/KwLGCyw4HNK3R4SueheNcGY=;
        b=Rl2NTlg5smnlit/u9gLo4lTz0l5iy25DYNIgLvaKCzmGGS75v6sA2aqlBS4ASkX5FR
         Jh+zVBuhZyuqgg3BG5+0txZaPW5+2463/6Vh3WGGZ6PImnJ4o0NLzzA8QfWhMjRDDZP2
         8DGNYAHeoRQB4SkLp2EzMD19TQyOiayoQR7ERrXxPi7fjH/XWkwdlhzC+bxxC05BcJgO
         kC3sGROlnTiaiqy8keYj1PoYI1TcwFm9Qk5/wgaWtyIP+AisWB07o7DBVzHBirAW6D1M
         8MFGLzyXqS8lEdZYSRuaKgo7UmHZFRGy0gQDbVrWe1R8eddVuyj+if2/3szTFgeDVZk6
         FutA==
X-Gm-Message-State: ABy/qLZOqyWYVIrAPgCaGZOfhdCJ5gYajSWgg6pU7UCBPF/9RgaSqKpC
        CiP4fxSV6Mi7lC25o6q2ywycow==
X-Google-Smtp-Source: APBJJlHFbNkZF410er95MF4TKaxREjQwy7UnQBG18GsQoNgShoGn/BNZdT9yh3AybAWNLnEhuqOvOQ==
X-Received: by 2002:a05:620a:45a1:b0:767:3771:f770 with SMTP id bp33-20020a05620a45a100b007673771f770mr13588204qkb.40.1689014429364;
        Mon, 10 Jul 2023 11:40:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a079400b0075772c756e0sm119355qka.101.2023.07.10.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:40:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIvoC-0004j8-Gp;
        Mon, 10 Jul 2023 15:40:28 -0300
Date:   Mon, 10 Jul 2023 15:40:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stanimir Varbanov <svarbanov@suse.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZKxQnKhqKziyxX8f@ziepe.ca>
References: <20230710082252.9702-1-svarbanov@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710082252.9702-1-svarbanov@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> Add def_domain_type implementation op and override default IOMMU
> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
> could be enabled on some distros. The current quirk has been done
> for Tegra234 machine, because I found the issue on it. The issue
> itself appears on USB host controller which cannot be initialized
> without IOMMU translation. Something more, we proved that IOMMU
> translation is needed for display and GPU drivers as well.

Generically, if you find HW combinations where certain end points
cannot work with passthrough (which is really weird in the first
place) it should be narrowly quirked - not just an entire platform.

Also we don't really have a way to force non-passthrough, ARM32
systems will always run in passthrough, for instance. Broadly the
kernel expects it to work.

Jason
