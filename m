Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE6619604
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKDMOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKDMOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:14:47 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D22DA88
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:14:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FB615C00D4;
        Fri,  4 Nov 2022 08:14:33 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Fri, 04 Nov 2022 08:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667564073; x=1667650473; bh=LO
        vDsVoLUrJplt7gXkyiR2uvQtrZHCbVkz23HdeHqBk=; b=MgCnkNNsc2RwT9vAP2
        J1v+Uh/lUWbvL0Ga5wdbMdyzbiJJd5fH4EGe9xn1W73Ru17KKfHmsUJfhO+j4860
        XIm8wIHVGRtfX3Z8LKRsjeiL/BaAatMeY4Jei1yl9rE/XmsmlEpYpKZKP/Gba0eR
        l11EJPd5OMWLvhHJH7nUmxAyGih/dlq9+7H/Vmf6PF7medwHRS9zPQnvgw7VJI3I
        gxeMhBpT/qiYQnSzWudT1qQMh2WFtPiKuLRUk835uJbGjefBJQOdes+1FeIIo4+K
        pjgHhp5V8sTTgLqW/R9+CkfQ9r4+6cXRU0lfuNhQLzjLiXWbQkdXBWCp8BFf4l1q
        ZcJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667564073; x=1667650473; bh=LOvDsVoLUrJplt7gXkyiR2uvQtrZ
        HCbVkz23HdeHqBk=; b=WpOZxiKPf21643x0WifBh4fllIEwkLQ7YtRhog81v83N
        Dt409D0nE3k8YfNpAT9OkzP95u0kv2Vg3h7Zu5n4Wp1g6qJQ9clmjI3VBThxRt4q
        JsyX5V7Bj089jcYKtDutaQY8mbaOZEKZ1d+bw+xliIWjVqKrhfgqcdzgorcduLyy
        ybH4qdsz4uZWUKBVDWQe6rtCuvwDRMHFkht9ewDE+xyqjQ1lEHBX0L7pySlrP6rr
        uzn/5jtbZv9ByI2HikH+Ej9E4b7f0bFG+DTIHRVHsfATb/T2InDeEcJnvtetGWdp
        brkCa0k4eT/aXKfAQgLNspcccEPU0Ec60l0iokpjeQ==
X-ME-Sender: <xms:KQJlY7dTe4Rtvt30dVgzOFrj1Gd5c5TsZhG8DtjfJaEezBNINQ1Ryg>
    <xme:KQJlYxMrY1wXfTszObbjhAr3xSJ1sLlWW7hxBIjO4i7q-kxW6-UTB0dcA2i_NmBEs
    w2f5LwUKQMQ-lsNeCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpedvueetjeegtedvfeetteelheekhfehhfefudelteehtedvvdefhedugeej
    hffgvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpgh
    hithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:KQJlY0jB0JUMAKYLC9S3HJ2POWUHoRORWPaYk-4koZaKb2mx9lKEEQ>
    <xmx:KQJlY89nzDpZG2YI1GyxRvUMZyjOCnm2bhEm5jhLOXG6avY1l-lSWw>
    <xmx:KQJlY3vxYx9NkzsJNQeX3yELhJaspfFEPHKP28O8TrVXG2UVcVEr-w>
    <xmx:KQJlYw6Tbydu6conV-5ny90eMrIT3JEWj8yT23jv1WaxpFyitODrmQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 61052A6007C; Fri,  4 Nov 2022 08:14:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <c56bcb20-9ea9-43ac-9528-db62d01ad072@app.fastmail.com>
In-Reply-To: <202211041947.EOX4mt7V-lkp@intel.com>
References: <202211041947.EOX4mt7V-lkp@intel.com>
Date:   Fri, 04 Nov 2022 13:14:13 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "kernel test robot" <lkp@intel.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/soc/apple/rtkit.c:947:38: warning: cast from 'void (*)(struct
 apple_rtkit *)' to 'void (*)(void *)' converts to incompatible function type
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 4, 2022, at 13:04, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> master
> head:   ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
> commit: 9bd1d9a0d8bb1a549831fd98fcc3105960f7068b soc: apple: Add RTKit 
> IPC library
> date:   6 months ago
> config: s390-randconfig-r002-20221104
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 
> 2bbafe04fe785a9469bea5a3737f8d7d3ce4aca2)
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bd1d9a0d8bb1a549831fd98fcc3105960f7068b
>         git remote add linus 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9bd1d9a0d8bb1a549831fd98fcc3105960f7068b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
> O=build_dir ARCH=s390 SHELL=/bin/bash drivers/soc/apple/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

Thanks for the report, this instance is especially brain-dead since
apple_rtkit_free isn't even used outside of rtkit.c.
I'll send a fix later as well.


Sven
