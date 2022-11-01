Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C42615187
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKAS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:26:22 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB5D13B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:26:21 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v81so8121044oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j13+RdBhueYLBa+gZTK00atTbWK5kdZidNW/hkmhbwQ=;
        b=n2AxkPgmqto4tH3j65TvYJJyeMZJOVrWyPOTduayeVrDeBcpKWdmWFwoHGWu5y8DA1
         5jtIiKmupXbwBLpA+WJAOWp5QwFhIbliflFMC5lsflDQZdQ5qhc5WncGaoaZH/9Szosk
         Rz5a+oL5bAOZbpijyokB10EwLigXhTIDyecgpuiYbNBd3XULrX0iFx7V+5m1RaKIXSBx
         n+4E6hMf2G6qvlpDsyOeLgdwnmMF0fWygDhiZHPZqJ2dfkxIVOBXq3L/xE5u0n9eRtO8
         6HMp8zRL78azl2vMwIBuOV7feNoZU51aC4JhXlJc9dh06PmVErVKStpm66wFqtDaelgc
         qkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j13+RdBhueYLBa+gZTK00atTbWK5kdZidNW/hkmhbwQ=;
        b=A3BNanA+xK9Khdx9zsXURPoIsHBfz27wbu8LAwS59DsSp8ww56naVYXB8em3aIV0Ok
         eDGQvoEzV1rWhyhl4PPXMCMkrNRxz9AeFMyxJQc6eCu+t/rnv/SnFI9s78VUocogiy0T
         mQec9wfsX8Op3ZaLylz4tIpjTbKzykcj/hM0oaRqICS074Xsb2gIeK6tvEuw1jFlb6lr
         uAaKtx70Uv4IkOPjMKKLNqddIA8zihz8Mg5x9ZUNTOKdOtst/7Ra+eXnJbgnJUheY+KS
         W6C2BSkk53O+13FqtvdWOW93tDauqOrvANWhKzLzKPV9Rxaxbnl9PElA/NNriO3gSjH9
         Qi4w==
X-Gm-Message-State: ACrzQf06F9I40tDPNUPGm90IQ7aBfP8VBp16i40peA+bhRWpRrejuAI4
        EhRbdfiZGGikFnRVToUCYtLl8t6c0mc=
X-Google-Smtp-Source: AMsMyM6Z5x00Xi5CAwkr3wcF2tRHOLJPjfrS373frSb9omJXx41PIPu5dtQdCFJ8FRJrVXBVQXaIlA==
X-Received: by 2002:a05:6808:2023:b0:359:c826:8085 with SMTP id q35-20020a056808202300b00359c8268085mr10947774oiw.156.1667327180648;
        Tue, 01 Nov 2022 11:26:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k29-20020a056870959d00b0012c52bd4369sm4810311oao.19.2022.11.01.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:26:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 1 Nov 2022 11:26:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Linux 6.1-rc3
Message-ID: <20221101182616.GA1328619@roeck-us.net>
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net>
 <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
 <29d07648-29a9-432a-a666-f9c9e55c32f6@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d07648-29a9-432a-a666-f9c9e55c32f6@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 06:57:41PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 1, 2022, at 18:29, Linus Torvalds wrote:
> 
> > IOW, I expect it is - once again - some random linker-generated stub
> > that ends up causing problems, where the re-link stage ends up being
> > unstable because of some subtle alignment issue or other. I think
> > zero-sized symbols have often been involved.
> 
> Linker-generated symbols are usually the cause, but those tend to
> be fixed with the extra pass, and Guenter said that doing an extra
> pass does not avoid the issue here.
> 
> I have not tried to understand what the 73bbb94466fd patch actually does,
> but as the description explains that it uses either 1-byte or
> 2-byte encodings for some symbols, I suspect this is related to
> the new problem here, possibly it gets into an oscillating state
> where making the symbol table shorter causes a symbol to use the
> longer representation in the next round, which in turn makes the
> table longer again.
> 
> What I've done in the past to debug this was to change
> scripts/link-vmlinux.sh to use a larger number of steps,
> mainly to see if it eventually converges, grows indefinitely
> or oscillates. After that I would compare the temporary files
> from the last two different steps to see which symbols are
> actually different. Unfortunately, there is no built-in
> debugging mode in kallsyms, so this is a rather manual process.
> 
I have been doing the same, but so far I never encountered the oscillating
situation. In those all I can find is that some symbol addresses keep
changing, but I have not been able to track down the cause. The possible
explanation above makes sense to me, but do you have an idea how I could
track down what actually happens ?

Thanks,
Guenter
