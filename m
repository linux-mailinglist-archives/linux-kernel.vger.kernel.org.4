Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE10611844
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJ1QyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJ1QyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:54:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865B21CD51
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:54:07 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id hh9so3804767qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmuritYpfhIEOF1X+rtosFks48G8Ge/OmMv0BpD+cGY=;
        b=Jomx+oheKolMSkNx6v22oT27TT85PjFQw9xsYUFbz+2aZlK+vL6HM6I2Jv6DswW1dz
         +/BxkNQf6fLIe9UT9LFl0wsSKZ6F6oK1s+SI5Kqz68neFvTUZxGxN0V+VB9mrlKZP2Qn
         9+Zoe+SUrv4NYf9k0AzLe29mV6ZiBNM6tPyfB0FNWXYkT1+8YLXWtdH/bD84SCFE+2Rs
         gEWDGQo4RIdtLZ+Gc9Z9594rhx56vpbCZTUa6jKyE8Q2HecuwHmxrcrjJ6mO7iN64FBr
         KjKLjUkKaUs/NiNIuosRRZAhg3n+UBJ+XEEkkK6eaBt6ZqxcBTwUpadYAm+ysgiZwlO2
         vhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmuritYpfhIEOF1X+rtosFks48G8Ge/OmMv0BpD+cGY=;
        b=dIZCccdMEytofcJIQglZlwLcEcnM7A4gJemT/qAimSgpVROh5bicz5ZsUke793vabm
         pFF87KIjP9SwpyqjzdJ90OixpXsXdMU+LFhLErrCk2dMBfRSw6T7+Xu6d4SFUY+h3Swc
         7TcWBS3ykJkAaEnbLmsbzkZFAYnlPlBGpFT80NRK5Jfx4BeVUL359WyYTc9231nlTHvG
         ybHEeXl9qBBXklwxuvVAbaxYvpDdxRe7YMc+KdLygYuH5C5wnGiwxUFPy9EXpRNFVY48
         J13Ba9zSSWX/Bh1iJdKBbUIhaGFJd+K5SVetzTFvnECt/PMOyAAK96x6X9OnNz6J3vE1
         EEqQ==
X-Gm-Message-State: ACrzQf35M6mldcqXcPb85Z98Z6BV1VmhE3ODq9oYTC4L+mT65NZ/r/Mh
        h4isYAc7QV2I9pf/G3Bl+M0rAQ==
X-Google-Smtp-Source: AMsMyM4kbG0BKvQ7RxfkpSOGioHi7r+d/ui61IOJaF4139vdRc+jaYkZamGH2qUn9FD7i3H0XgDFMQ==
X-Received: by 2002:a05:622a:1194:b0:3a4:ea9f:f48e with SMTP id m20-20020a05622a119400b003a4ea9ff48emr343992qtk.241.1666976046890;
        Fri, 28 Oct 2022 09:54:06 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id k2-20020a37ba02000000b006bb83c2be40sm3198311qkf.59.2022.10.28.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:54:06 -0700 (PDT)
Date:   Fri, 28 Oct 2022 12:54:04 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: Re: [PATCH 05/15] coda: remove CODA_MAGIC
Message-ID: <20221028165404.hzslvndpg26wop6k@cs.cmu.edu>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <a6eb2dae62abf49b351760a4f55031d1c6f4ea01.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <b65541bf-ad17-b465-0f77-66d9e9c242fb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b65541bf-ad17-b465-0f77-66d9e9c242fb@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:23:38PM +0700, Bagas Sanjaya wrote:
> On 10/27/22 05:42, наб wrote:
> > We have largely moved away from this approach,
> > and we have better debugging tooling nowadays: kill it
> > 
> 
> Again, see [1] and [2].
> 
> [1]: https://lore.kernel.org/linux-doc/47c2bffb-6bfe-7f5d-0d2d-3cbb99d31019@gmail.com/
> [2]: https://lore.kernel.org/linux-doc/9d96c96d-dfc7-7749-07d4-2601c00661c2@gmail.com/

I guess I must be old-school because I appreciate magic numbers and
assertions to catch situations that should obviously never happen.

This https://lkml.org/lkml/2019/4/2/923 bug would have been caught a lot
sooner if ext4 had happened to check a magic number in vma->vm_file. As
it was, we ended up passing a Coda file instead of a file handle for the
the underlying filesystem which then ended up with the wrong inode and
their mmap_sem happened to scribble the spinlock on the Coda inode.

This wasn't really ext4's fault, it wasn't expecting to get a mmapped
region with another file system's file handle, but that is exactly the
point of these magic numbers, to catch the unexpected. Not sure what
better debug tooling would catch that unless you were already expecting
the problem.

Jan
