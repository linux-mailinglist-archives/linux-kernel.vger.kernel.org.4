Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A975613C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiJaRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJaRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:52:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A860642A;
        Mon, 31 Oct 2022 10:52:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so16622341pjk.2;
        Mon, 31 Oct 2022 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeS1B6pU6Ltvqw8iJ7EBFTp6ZywCc2y+06PBeH/h5qA=;
        b=Auvnmbd6VrtWGZvoNQdi+XQ5gq58+TmkVTyQiM95mBvxhA/zm+yF1xBHcidBykPvxT
         n5N09P+QwFm+gvRW5ENFxuJylZGVatnVE70lPPbbdpcbz0ObEcK5OSnW9WS/NmhRurMD
         jmOaLhu0aH8IdK283hOInrTn9QaIJgQIhQIb+bcmU56iNksazzU7mt4qHTNCTAW1D4P2
         6JBBKS146bOtAvO7dAu5KKRBzQWkbHqnx71A4fKW22Nva1n2WukMETkgtnRNd+LeJ8i3
         Ue9ih0MyYf1dFpwbgIg8el8PuR0n1PCfzbvNhp1FQnFzA2hcgFNDuTskjGJLX8xr2K+D
         Di0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeS1B6pU6Ltvqw8iJ7EBFTp6ZywCc2y+06PBeH/h5qA=;
        b=TSICLEm2evqKoBisTyHL4KeWgI9HvpYrx2z+PcL7pke2UHhvcscjYNeY+Juy3JBfMw
         1+iJAcLqaNLgt8GDXWOAHhivklP1pmcPEQGbAeKmcGJT/37r7xQu/mK3LjGSUeouCcd2
         Gz9/UPuDFroXb3cg9B6GZpFWHyqTm0IEmNjpIF7h436kH3H7NZvvXb9ulfu5ZEN1kOVb
         NAixb0M7FTqnhr/LrjcOckhPOEz7kzwwz/EKUqZxk2Hxrcuhvs+DOMp6ilbGIMXxsEAB
         JeEQPJwogAb3u7CTYJcAi6NbsZg0ID0gDbKoniIetFXtmp2Id0VYWS3xucV+/9smvcvC
         XMFw==
X-Gm-Message-State: ACrzQf2LNuMr195umMwGYs+m8kO0rkjFnA3h+Ke/BdOeiKNtDjZxUYGL
        XdPzEcpocIRvFQwmYKgpBKsUwX2xLLY=
X-Google-Smtp-Source: AMsMyM6EMpvDURvMVPXLI3m8+69cWRlvkcG5rZ5oXg6mzAERO6Pc8v4mq2qpmP4kJjV/Iyqc2QJ08w==
X-Received: by 2002:a17:90a:a415:b0:20a:f813:83a3 with SMTP id y21-20020a17090aa41500b0020af81383a3mr16142489pjp.238.1667238775339;
        Mon, 31 Oct 2022 10:52:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id x15-20020a63170f000000b0046b1dabf9a8sm4425214pgl.70.2022.10.31.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:52:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 07:52:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <Y2ALdT4e08bczeI+@slm.duckdns.org>
References: <20221031132331.76193df5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031132331.76193df5@canb.auug.org.au>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:23:31PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cgroup tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "css_tryget" [arch/x86/kvm/kvm-amd.ko] undefined!
> ERROR: modpost: "css_put" [arch/x86/kvm/kvm-amd.ko] undefined!
> ERROR: modpost: "css_put" [fs/btrfs/btrfs.ko] undefined!
> ERROR: modpost: "css_get" [fs/btrfs/btrfs.ko] undefined!
> ERROR: modpost: "css_put" [drivers/block/loop.ko] undefined!
> ERROR: modpost: "css_get" [drivers/block/loop.ko] undefined!
> ERROR: modpost: "css_put" [net/netfilter/xt_cgroup.ko] undefined!
> 
> Caused by commit
> 
>   6ab428604f72 ("cgroup: Implement DEBUG_CGROUP_REF")
> 
> I have used the cgroup tree from next-20221028 for today.

Sorry about that. Fix patch added to the branch. Should be okay now.

Thanks.

-- 
tejun
