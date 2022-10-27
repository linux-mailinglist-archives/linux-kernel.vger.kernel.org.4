Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C201A60F5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiJ0LA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiJ0LAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:00:55 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376509C2C6;
        Thu, 27 Oct 2022 04:00:48 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so883625wmb.2;
        Thu, 27 Oct 2022 04:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHEnS+Slg2F0l8c+oL+CMwvqzeF+IF9SKbytuqB4NfE=;
        b=SGNsXH8wV4K5z9hCYfmEgnSYSve9L73/qm72UPl1wAMCcZMc+K3KwdmVwW4+EZSzu+
         a6yOWjnvYqglkIwFAJF4xPYxwBfuNnEetPXvw+5hAZskbHR4XdfqUTlafyM/xYBHk7BY
         wCVDZvhZxo2dWaiR+UdoB3bakEavGbbwlF9S2r6H6bMSPWfmkBxrxrmH36S2njjQ2v/H
         mdVBrT2LLKPpKTwto/0jqVbr7Snw33znpb2dB/qPP2sImOvTRZsD30cbIklpTK183NBE
         wXEztVP0n4R5fZTsZwPnI9mZjOK5Ed28lsE1xt76UvaMifeXb3v+G0WyOU8nD1lTVFVa
         FqMg==
X-Gm-Message-State: ACrzQf1QgnrzC0bOrjCscXFn/jIq4hyda6VDFQIZ2l+BJ84jOTFAg2dU
        dbgPiC44D/iaDbJU5eW8+p0=
X-Google-Smtp-Source: AMsMyM4q29eRevlz2I05St46B/JtJp19AlKV8R9PeZjiH9DXTFr1mAk2TzwBdiTYoWikgpJ9yuGChw==
X-Received: by 2002:a05:600c:444e:b0:3c6:fbb0:bf3c with SMTP id v14-20020a05600c444e00b003c6fbb0bf3cmr5519318wmn.189.1666868446664;
        Thu, 27 Oct 2022 04:00:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c15cc00b003c6cd82596esm4016619wmf.43.2022.10.27.04.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:00:46 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:00:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hyperv-fixes tree
Message-ID: <Y1pk3CFSC8x2mbrt@liuwe-devbox-debian-v2>
References: <20221027085220.32076be7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027085220.32076be7@canb.auug.org.au>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:53:32AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hyperv-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> arch/x86/hyperv/hv_init.c: In function 'hyperv_init':
> arch/x86/hyperv/hv_init.c:447:29: error: unused variable 'dst' [-Werror=unused-variable]
>   447 |                 void *src, *dst;
>       |                             ^~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   f8162cff19f1 ("x86/hyperv: Remove BUG_ON() for kmap_local_page()")
> 
> I have used the hyperv-fixes tree from next-20221026 for today.

Thanks. I've fixed that.

I will also turn on CONFIG_WERROR in my build test.

> 
> -- 
> Cheers,
> Stephen Rothwell


