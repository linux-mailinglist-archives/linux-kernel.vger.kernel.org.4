Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D316C0CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCTI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCTI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:58:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072510AAE;
        Mon, 20 Mar 2023 01:58:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m2so9544456wrh.6;
        Mon, 20 Mar 2023 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679302701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzJeoTbKWKmIBwgQA0Y6y/DCv+ZaiOaeERybU2fweUE=;
        b=QDRO/di0+W4wO0US7hLYQPt0JtqrXuz+l1/4iXt4x4pSqH1+Up7aPBXLgzauOOdr4t
         R4aV7r0anl4+aiGVdthztkDvMh13STej0atvbniaW+ZYi1AuLxQT5WD3x3pVlG7yVf4e
         dL9R2uq6DQsa2EfgQZg4XciDUjCT9prIVtNyNDpH16tFUnnVVIxox7ieHMFD1iRNu159
         wcjrALUHtCKlnPBrU5mZrtSyc1sfF5Jb+rXHsJDZYnytWbso+d/DnRzzr7cZ5I/dLNCk
         00u8YFwtqnSwRObn4iDBzgVlb/VBTi5k99cT2a4XC7oGphqujkc1lFpZ37nqP/ubyIgi
         MxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679302701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzJeoTbKWKmIBwgQA0Y6y/DCv+ZaiOaeERybU2fweUE=;
        b=RXWMgjp1ShFfhOsMQjj4q0UmNj8/egXDhZIhwK1i8todMwA5gkKnX4Xzq2V1Gckfos
         q5uG7djXHmETNTDR3PxC9BqtSBP8QlO/6GbT7ioRxJpw1/B/y0nPd/V6Agbm3sA9nBpU
         Gzt4lGY23TRys6a+p8YCHuqjkcwcyr6+l+ZcBXhuAQSAvJEVIwPczPDf41p1eJBRBkXq
         CdvpzsIExmVPB31QsPVj8hRPzhlopLPd/6Z/WulQFKnaLyPO6jdGMyDtnpOK+B5S3n8m
         nVoOaLIsqUQ6EaLQTQLUvPmUtFm2BINmzOn+djhcsW581spSCasM6iu6aaF4XoSjRAFG
         wgzQ==
X-Gm-Message-State: AO0yUKX7wvfodVfo9pkCUgkRvhFTUqUvOSKOBpwujUhXZEbnmZHpNIKX
        1Rl/aUtZ5UBie6XsXCpnI08=
X-Google-Smtp-Source: AK7set+KLxobAAO+fehPbXx6zZ9HiCLEkSn44tcxAykkKqp8FeNPy5vK22tOMa9HFICZsPo+2mWv2A==
X-Received: by 2002:a5d:6512:0:b0:2ce:9c6b:4fc5 with SMTP id x18-20020a5d6512000000b002ce9c6b4fc5mr8838497wru.16.1679302700800;
        Mon, 20 Mar 2023 01:58:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm8312838wrh.21.2023.03.20.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:58:20 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:58:16 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] Staging: nvec: Convert to_nvec_led from a macro to an
 inline function
Message-ID: <256ee298-e34e-4ff4-94ba-e4a0102ef2ac@kili.mountain>
References: <20230318175250.GA49618@sumitra.com>
 <417e944c-4653-43ef-b492-c82c536e4d87@kili.mountain>
 <20230320084422.GA126429@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320084422.GA126429@sumitra.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:44:22AM -0700, Sumitra Sharma wrote:
> On Mon, Mar 20, 2023 at 08:39:49AM +0300, Dan Carpenter wrote:
> > On Sat, Mar 18, 2023 at 10:52:50AM -0700, Sumitra Sharma wrote:
> > > Convert to_nvec_led from a macro to a static inline function, to make the
> > > relevant types apparent in the definition and to benefit from the type
> > > checking performed by the compiler at call sites.
> > > 
> > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > ---
> > 
> > You need to compile test your changes.
> >
> 
> Hi dan,
> 
> I am facing problems in creating modules and in compiling them.
> 
> Any help in this would be appreciated. Here is the link to the thread
> https://lore.kernel.org/outreachy/alpine.DEB.2.22.394.2303191336090.2867@hadrien/T/#t

If you're editing a .h file then you need to compile all the stuff which
includes it.  It's slightly complicated.  But if you're just editing a
.c file like here then what I do is I have use my Smatch script to try
compile it.

In Debian run:
apt-get install gcc make sqlite3 libsqlite3-dev libdbd-sqlite3-perl libssl-dev libtry-tiny-perl
Or in Fedora run:
yum install gcc make sqlite3 sqlite-devel sqlite perl-DBD-SQLite openssl-devel perl-Try-Tiny

git clone https://github.com/error27/smatch.git
cd smatch
make

cd /path/to/kernel_src/
~/smatch/smatch_scripts/kchecker drivers/staging/nvec/nvec_paz00.c

Also I run Sparse on the file.
~/smatch/smatch_scripts/kchecker --sparse drivers/staging/nvec/nvec_paz00.c

When I'm patching a file, then I like to look at any other issues I
might want to fix and deal with that as well.

regards,
dan carpenter
