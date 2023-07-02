Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C4744C1C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 05:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGBDcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 23:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 23:32:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4DC1703;
        Sat,  1 Jul 2023 20:32:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262e81f6154so1566132a91.2;
        Sat, 01 Jul 2023 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688268728; x=1690860728;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhN94lMUNnHFPAhVfo+rHKI0yY7VxURxglHWp96Srwg=;
        b=H1lg1nuWSIDnWqY4UVAXcXDJAvhU1YHPpPrusiQohNNE5GvwsK4w5d69Q7qkFYlCoQ
         84Fxd+lbFB7/3yFhjBHEutcwet2ZEWFcyPyx9Aiuz2AvTnO0DuUHAzVoq6G1FspI2tte
         n9rLvN+0COGioC0U1u981OUG9XFc6lhXnN8I/qBfkElWhYTtUu6u3S2CF4dAMVi4KAnv
         LtzVHkclYvagZB1hY7ZPMEONvED3cxV5uNqWv41hLLykZAZsPnIFRZfMy+hSSgBmAHwi
         gi3FnH1A2+JRvnqN3YD4PpzxbfUlw6fwQtvaX5GDyVPDSLN608urxpB41kGVdFjezpSy
         yjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688268728; x=1690860728;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhN94lMUNnHFPAhVfo+rHKI0yY7VxURxglHWp96Srwg=;
        b=cJDrCuXmL64fXmOU+uKy6y50G5CVpsMbwclaBAS5i/OZfDaWtwKepCcMVfpch5urOx
         B2eXxyGT6/LSYJ45x083w2/iI7iT/MA5Sj7t5jD3QzBJBf/ZhWhllIS9MW5PL5ms5iFQ
         na+cbVmg93EsZbc/HPyKD+NADzssswWnSADJfBWpbxX18E4LPvEJQ2ygsQOQrzdNQCj6
         Iqc3eA2es1zCkfYcAWXC0cGaXcOO8CbIL5LBV7+EBrhpzuy0ukDWuSo947H5+G/+cedm
         MugHzalTbGk9QUDDrrY+2Wm6zD+Jf8TgzkQ1drtwYSAtvKECYQh0Yo1W287m2ISItO8e
         DcqQ==
X-Gm-Message-State: ABy/qLY/uF1GPib/ILMUC6ccpZnWsNtegwa+oemEKVoDtWAnhAVUQuO3
        3IejLWXHJ4y2FaLuVN29aRI=
X-Google-Smtp-Source: APBJJlHZiamPWt4nUWriHFvnZ613G5ox0ZTDJ3hV30nK4Q6VIh6/Ew5xaB6xL5oCJQI9wAnlyBBErA==
X-Received: by 2002:a17:903:244a:b0:1b7:cee1:60c4 with SMTP id l10-20020a170903244a00b001b7cee160c4mr5800588pls.59.1688268727745;
        Sat, 01 Jul 2023 20:32:07 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w10-20020a1709029a8a00b001b567bb970esm12931622plp.84.2023.07.01.20.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 20:32:07 -0700 (PDT)
Message-ID: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
Date:   Sun, 2 Jul 2023 10:31:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        David R <david@unsolicited.net>,
        Boris Ostrovsky <boris.ovstrosky@oracle.com>,
        Miguel Luis <miguel.luis@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>,
        Wireguard Mailing List <wireguard@lists.zx2c4.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: RCU stalls with wireguard over bonding over igb on Linux 6.3.0+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I've spent the last week on debugging a problem with my attempt to upgrade my kernel from 6.2.8 to 6.3.8 (now also with 6.4.0 too).
> 
> The lenghty and detailed bug reports with all aspects of git bisect are at
> https://bugs.gentoo.org/909066
> 
> A summary:
> - if I do not configure wg0, the kernel does not hang
> - if I use a kernel older than commit fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c, it does not hang
> 
> The commit refers to code that seems unrelated to the problem for my naiive eye.
> 
> The hardware is a Dell PowerEdge R620 running Gentoo ~amd64.
> 
> I have so far excluded:
> - dracut for generating the initramfs is the same version over all kernels
> - linux-firmware has been the same
> - CPU microcode has been the same
> 
> It's been a long time since I seriously involved with software development and I have been even less involved with kernel development.
> 
> Gentoo maintainers recommended me to open a bug with upstream, so here I am.
> 
> I currently have no idea how to make progress, but I'm willing to try things.

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot to make sure it doesn't fall through cracks
unnoticed:

#regzbot introduced: fed8d8773b8ea6 https://bugzilla.kernel.org/show_bug.cgi?id=217620
#regzbot title: correcting acpi_is_processor_usable() check causes RCU stalls with wireguard over bonding+igb
#regzbot link: https://bugs.gentoo.org/909066

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217620

-- 
An old man doll... just what I always wanted! - Clara
