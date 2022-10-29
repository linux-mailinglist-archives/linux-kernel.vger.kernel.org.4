Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0A6121F6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ2Jp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2JpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:45:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C965358B4E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:45:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f27so18326051eje.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j33e+agco87KfecyN9tcnlEsDHXnUiSrxhuNYuLnEbI=;
        b=BECNFhV3tyhiIUHIPg6RbRBQRokZOoJswy9sq89QNVx8UPCf89gSNaW2XZ26ZtDiTZ
         VkThBxv9DdKARPofXB7//zeW3Xl8Q+SlqhVLSe2SAJ5IjCJ3DMdWJevLq3oPxsBxobRu
         V6iy//FyeztaiXeJ7wEmG4JDFl5z9IQj7fXtWEyOJHfRUV4iIIaBPKEedHdobG6QYl4y
         Rbdkhwp+LcPbI8KpkuEktXCqiMyQ3oovD9rd/YPOikeu1mdBES10+wkxsnLFpR4rhvkB
         13oqfDGc421p9AKjFSwgrw2DfpR4DgKwsctWj1W0sMb/SD8TO0ywd4iKBJ8tq9EBZAGO
         fmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j33e+agco87KfecyN9tcnlEsDHXnUiSrxhuNYuLnEbI=;
        b=hTBg5MHFVLqXvUAYhhIcKbOXU8fZ1l/jI1h3LbV1aOaidu+ZaMn03Q1dxxgrvJjDQK
         2IoUrrrKu6VGJqIdsMHrc7kfbqy+Xq2sAntAJPyBEnlvQxlgJJCZZi+Ra6wSVXW552V/
         sA0vscQ7FHtLHxGiwP/bEtzjQpbF/l9rF0I/mbJS4tsgq7Wd1Uf/EFSR/fbe8amTQ/o7
         e9T/7moi6b6HyUZWGBQ4NUBtdoBa0F00bHERYqfg3GxOZDylKvvLzRmCmxl1Y8scraqq
         /IamrP+FVSrH1DUMaEJCCG66wqxErp16/YV988xeRjKNK7Eq9DOOYN2tCzLNYepzGrA8
         +1fg==
X-Gm-Message-State: ACrzQf0o135d36jOAUkgGc5Rk+itRTlMqQWkPTbo5TDXZQvvY868c0SQ
        8RBNUdemcHVQwuJ4i6sFyg==
X-Google-Smtp-Source: AMsMyM6u3pe09FpO+Z8d/MO+IrQbt4TXhCFNqj9hnocoegqaJDn+QIhIb4EyEZbiuIdqzWbCbNYQJA==
X-Received: by 2002:a17:907:9705:b0:7ad:b14f:d89e with SMTP id jg5-20020a170907970500b007adb14fd89emr2043261ejc.745.1667036722277;
        Sat, 29 Oct 2022 02:45:22 -0700 (PDT)
Received: from p183 ([46.53.250.206])
        by smtp.gmail.com with ESMTPSA id fs29-20020a170907601d00b0078c1e174e11sm479034ejc.136.2022.10.29.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:45:21 -0700 (PDT)
Date:   Sat, 29 Oct 2022 12:45:19 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] selftests/x86: add "ffff8" -- kernel memory scanner
Message-ID: <Y1z2L8aAq7sOWxQT@p183>
References: <Y1wunXB2iv0QHr22@p183>
 <Y1yMlEqtiQwUoy9m@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1yMlEqtiQwUoy9m@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 09:14:44AM +0700, Bagas Sanjaya wrote:
> On Fri, Oct 28, 2022 at 10:33:49PM +0300, Alexey Dobriyan wrote:
> > 
> > I've tested it with kernel patch which installs rogue page and it was found.
> > 
> > 	$ ./a.out -h
> > 	usage: ./a.out [-f] [-r] [-n N] [-s S]
> > 	        -f: sequential scan
> > 	        -r: random scan (default)
> > 	        -n: use N threads (default: $(nproc))
> > 	        -s: lowest address shift (default: 47)
> > 	        -t: time to run (default: 256 seconds)
> > 
> > Intended usages are:
> > 
> > 	$ ./a.out -f		# full scan on all cores
> > or
> > 	$ ./a.out -r -t ...	# time limited random scan for QA test
> > 
> 
> The executable name is a.out, really?

This is copypasta from my internal git.

It will be named ffff8_64 by the build system.
