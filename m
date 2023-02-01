Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CEA6867EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjBAOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBAOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:05:06 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCCC268C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:05:06 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z3so12678290pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYY8AT0ENZljGYO6C36OZtTsh5N/Rgqc7QoUfqtNprw=;
        b=AbuPCU9Tw0G5TTVc51fl5WvI38E1Rmzh5FShZrE3cucqPCgOc2Yi0QgNCbbpMV2heM
         hMXm3e4/fDHgw/FTr0beIUcg67DkLTsEWMlT00c4cWwrrYfX2z6TnGPelTFc+HIkEIDe
         Ouqu4hQFo4qzZRVsvhbmXaZC9AKQXPLhzwT7vdSdbAd1sxDXY/WXtEwR4RqGUw6UMn0p
         O1fvyW36YkMIKF6owbirP6Mxe54zSFHMT6Tuds9y6GX2DJG7HsvnVHx0nf4kdHXSH+mM
         NHrDONd0dOpFxN7VmY3Ge8n0gsk8PKxfO37xhfQf6HWtjD6hAr48Lx5gOLzx5NZKGLwd
         hAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYY8AT0ENZljGYO6C36OZtTsh5N/Rgqc7QoUfqtNprw=;
        b=ZClhOe8ed6OeFrgS+BkHGCaPc7oELpGR6RXYQPwRg3bYwH/2637TaiqVZ1EhnNmBdB
         dLC9pEr4c9/1bomLLudmXIwEyPeTtPFb5b060g6wCcdWzsfjAP3qbcdeXMp5G+EJeH0R
         IlEZOPyAlvS5b6OMsVpBdTOpf0W81bEAS1eA2hXFwsmzuo07QnH/Kl4s4A/cT+k9vl+/
         RrDJrsSw7k7F7Hp1p460tZYTdajigaavq+pLuyNdbheZJTn4GybicLexh5E4iZFxr0/P
         QErWtVXeEpnuQAxI3ftFqYuIRQxasy3Yl3IfqG8lPlhiQOhJPU2tIu032iu+AiTXXoKB
         sWpg==
X-Gm-Message-State: AO0yUKUVWOE2ad8zXgAd+3SKiDsgO1Qs/OOZuwOljDgJFHVYiynpXxS4
        YwVW+AX/JfrTQRQn7FDQxgQBLA/jePTjMmkI
X-Google-Smtp-Source: AK7set9x6nWuFrvi6ArGt3T+3uQRCwNeeLU8SBVZ6ln0Utp7Gt+56jRquS+ahU+0v5NzakhFDYUDvQ==
X-Received: by 2002:a05:6a00:1d89:b0:593:afaa:b5e5 with SMTP id z9-20020a056a001d8900b00593afaab5e5mr2202126pfw.6.1675260305524;
        Wed, 01 Feb 2023 06:05:05 -0800 (PST)
Received: from qxy-XPS-13-9360 ([43.224.245.247])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b0058d9710cb18sm6879770pfd.2.2023.02.01.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:05:05 -0800 (PST)
Date:   Wed, 1 Feb 2023 22:04:59 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     xiongping1@xiaomi.com, qixiaoyu1@xiaomi.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2 v2] f2fs: fix wrong calculation of block age
Message-ID: <Y9pxi7C+uUumQKFA@qxy-XPS-13-9360>
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
 <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
 <7c12ebaa-4d3d-e475-dfb2-7b459cd26e64@kernel.org>
 <Y9ZWDVV3HJ431Fis@mi-HP-ProDesk-680-G4-MT>
 <Y9pZqOMBipT2NZk0@mi-HP-ProDesk-680-G4-MT>
 <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:57:33PM +0800, Chao Yu wrote:
> On 2023/2/1 20:23, qixiaoyu wrote:
> > > > 
> > > > How about updating as below to avoid lossing accuracy if new is less than 100?
> > > > 
> > > > return div_u64(new * (100 - LAST_AGE_WEIGHT), 100) +
> > > > 		div_u64(old * LAST_AGE_WEIGHT, 100);
> > > > 
> > > > Thanks,
> > > > 
> > > 
> > > We want to avoid overflow by doing the division first. To keep the accuracy, how
> 
> Alright,
> 
> > > about updating as below:
> > > 
> > > 	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
> > > 		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
> > > 	res += rem_new * (100 - LAST_AGE_WEIGHT) / 100 + rem_old * LAST_AGE_WEIGHT / 100;
> > > 	return res;
> 
> if (rem_new)
> 	res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
> if (rem_old)
> 	res += rem_old * LAST_AGE_WEIGHT / 100;
> 
> Otherwise, it looks fine to me. :)
> 
> Thanks,
> 

Thank you! I will update v3 soon :)

> > > 
> > > Thanks,
> > > 
> > 
> > Friendly ping
> > 
> > > > >    }
> > > > >    /* This returns a new age and allocated blocks in ei */
