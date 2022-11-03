Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD46185D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKCRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiKCRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B12706
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:10:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so2512354plz.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Zw/xbrx1mfYNmLCyYGWO3RwLiclCaks9djofi27mHQ=;
        b=Y3+twozvFsaxlvdGpWADTdQU3zUwjGsS2nxkmdv6zVXX4LBt31WCsHVISg4/3lopgM
         KyLl5QDy60CRumW9iiYkm76Nz8jXVNx5ExoUV8OEl8uAMg2ytTWn/NnASUwNxQfPoQw5
         2Wb5y+FbNiM40s3VaiatAIiqlbyR24Cl1Fwp8AqTmm/33aJy2rWJRo900bwT6vGcE2TP
         uLwbznp1CMg7CwGexGPli7T8ZICgQwFkTod7srBnp5tO2PIotLLVCYMYubH9r5eSG5DH
         LE8eVKT2CKnzBDAvVl5q6KWk8PDKI0B63mtwxDrLIp7EsWf/KXbNrAzYU2+jR8GSbrMm
         f21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zw/xbrx1mfYNmLCyYGWO3RwLiclCaks9djofi27mHQ=;
        b=SdN/ljBT7m/+kAnwCvGAqRa9HiA2c/GP9Jz0cqVVc9yv65vnuATs5BMznkVB4Ewqi4
         fl2gZpTl/+nNmY3cQ/wAUZr0RpuobOQXdgd05ZgivKtFqtqdQP9/iW01a+heMDqrhEDK
         2xRmg7Vh9HKvsjIZF5TDogtZWPuiO4wToNSC8mpBotzew6aYl5SPulDXDUD5FNPD0G5U
         88Us1T8QUzTmDsxSvkxU8JB6bKU/rEyeBWAXv08SPDRlntmRR0I94n+u06jzsr4BmZrw
         +eJ3EhObAq7dcu+We4y7UdJeAXIujyfMP/zCdUT3Z9lvOWGXs3JIfowF9nWK3LKxD1JT
         4Atw==
X-Gm-Message-State: ACrzQf35B+nrI/uv1aZqa6BEuMEBp70fT88k0i5vvbdCoPqS0yIU8eR8
        9DLzgoDhCBT3aqkWu9QPpNU=
X-Google-Smtp-Source: AMsMyM4DEgOZ5StLPoF3czSLE+zMqwxW+raJTUzURNiiYqiiy+SeY2VS8B6fRLlQ1Rz61sjl+zn5sw==
X-Received: by 2002:a17:902:e402:b0:186:6f1d:b463 with SMTP id m2-20020a170902e40200b001866f1db463mr30548171ple.23.1667495445609;
        Thu, 03 Nov 2022 10:10:45 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id w8-20020aa79a08000000b0056d98e31439sm1011141pfj.140.2022.11.03.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:44 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 10:10:42 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2P2EhgSCyeFqMBj@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2M7g9fFWoa+MPh/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2M7g9fFWoa+MPh/@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:54:43PM +0900, Sergey Senozhatsky wrote:
> On (22/11/03 12:05), Sergey Senozhatsky wrote:
> > [..]
> > > Just open question(I might be too paranoid?)
> > > 
> > > I am thinking someone want to add third comp algorithm in future
> > > to balance decompression and memory efficiency.
> > > 
> > > If it's not too crazy idea, let's think about the interface.
> > > Maybe, could we make the recomp knobs works like list?
> > > 
> > > # A primary comp
> > > echo "A" > /zram/comp_algo
> > > 
> > > # Multiple secondary comps
> > > echo "B threshold" > /zram/add_recomp_algo
> > > echo "C threshold" > /zram/add_recomp_algo
> > > echo "D threshold" > /zram/add_recomp_algo
> 
> As a side note:
> The way it's implemented currently is that comps is an array, so we
> can store more comps there. I sort of was thinking that we probably
> can have more than two algos at some point the in the future (hence
> the MULTI_COMPRESS config option).

Sure.
