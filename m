Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4126FE4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjEJTxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEJTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:53:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F7D449C;
        Wed, 10 May 2023 12:53:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a516fb6523so72351715ad.3;
        Wed, 10 May 2023 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683748430; x=1686340430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1W4uqEw+0QjDuIqb5LwmtDskQMM72Nc3FiWOEWWSIU=;
        b=bAmLwZB2OYKVGc1eFyp9Olwwlhe1e213Fm6w4youNp+X8FpGJwS/YUIsfbCwwsoiLL
         bFKR5YRaJJV5Uvol2/Bb+n1h9yUj8wBuyVBUfUlQ2hdLL9xvnZvzcAkOFTWWkBGtJa0r
         9fz4vaM1sVGQf1I/9jvaClvwnv5nD8IZ9jo1KrnMzt8NLn8/0d293UuPJ1iQ3PL2aLxv
         FU6zZf2GPXdr/KsOovOY1MQ0hq6vSUTVyiGhizL/v3MBn29wFuEuBa5EF9+zHJQCF+3Z
         w/Zy2CfYDWifVRbGkPmzv7IX3NLg1i+Lf2+q63JoLLhVB7aFnv1K2lzcuoi1vNlzvyQ1
         lOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683748430; x=1686340430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1W4uqEw+0QjDuIqb5LwmtDskQMM72Nc3FiWOEWWSIU=;
        b=DflTIvkuuRbZPcHcc8TaWzzZlxMIkcQGPJt7sFQqmdBZQwXZTdye+6VLe4b/jxhDTj
         fYtuL1VNkYp4Bm3Q9SPeXT4wccmyzwAtmG5SfH6mDRoQ531uRYdqzJIW4fig4C4ip9NA
         T2Sdxo902tLWk/JkieJcBbXuPGu4Asch4IC2KXXQRcAVCxvgyewiY0Jx8a15K5d90qmc
         GtvcyRlUquCD8m0c4YnqOGDRiC02JZB376cNzY9yB2jLNMh7uYJ/lMvMHcwJxGcSc8+h
         fYL/mgyLWtXicMxLmIs98q1ze4XJtzRHnFNPdiFNOrk+t/CtkpU8mcOkDeX4mZX8C7L9
         VSjw==
X-Gm-Message-State: AC+VfDxRWbIT9kbwf+82zGMlku7eCIq4OYikF2yjkEEMJLIPW/VMzurO
        MlweQ8a9O/kx3K0CqbtrcPE=
X-Google-Smtp-Source: ACHHUZ5/zkYXLcb9Lzc5gleFvypNUl55bl4EUFRViFwjuCxQrTKzxgUePO3U5+fR1EuFBia1UmC0JQ==
X-Received: by 2002:a17:903:1110:b0:1a6:8ed5:428a with SMTP id n16-20020a170903111000b001a68ed5428amr22480545plh.22.1683748430442;
        Wed, 10 May 2023 12:53:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ij30-20020a170902ab5e00b001a6c15cad12sm4214978plb.166.2023.05.10.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:53:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 10 May 2023 12:53:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, laoar.shao@gmail.com
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <4d3c5462-1788-426a-a44a-e839b1c4970d@roeck-us.net>
References: <20230509030611.521807993@linuxfoundation.org>
 <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh>
 <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
 <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:00:42AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On Wed, 10 May 2023 at 09:46, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > Hello!
> >
> > On Wed, 10 May 2023 at 01:43, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, May 09, 2023 at 09:12:33AM -0600, Daniel Díaz wrote:
> > > > Hello!
> > > >
> > > > On 08/05/23 21:26, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 5.15.111 release.
> > > > > There are 370 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> > > > > or in the git tree and branch at:
> > > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > New warnings are introduced for Arm, PowerPC, RISC-V:
> > > >
> > > >   /builds/linux/kernel/sched/debug.c: In function 'print_cfs_group_stats':
> > > >   /builds/linux/kernel/sched/debug.c:465:41: warning: unused variable 'stats' [-Wunused-variable]
> > > >                   struct sched_statistics *stats =  __schedstats_from_se(se);
> > > >                                            ^~~~~
> > >
> > > Odd, and this isn't on other kernels too?
> >
> > Only on 5.15, not on the 6.x RC's. I'll share more info after my
> > bisection is done.
> 
> Bisection leads to:
> 
>   sched: Make struct sched_statistics independent of fair sched class
> 
> Reverting makes the warning disappear.
> 

Commit 769fdf83df57 ("sched: Fix DEBUG && !SCHEDSTATS warn") explains why
this works upstream.

Guenter
