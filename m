Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468DF64D3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLNXsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLNXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:48:13 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E931ECA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:48:12 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5754C32008FD;
        Wed, 14 Dec 2022 18:48:11 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Wed, 14 Dec 2022 18:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671061690; x=1671148090; bh=SLgELAxBK4
        9tyfuwt7e2QpMW23iZgCnbRJyNF5uq7lE=; b=D4/2jYTTdM/2ODNRR9uYHnsLk+
        j0gaRVMHzHhONiln89+hcHgjxcdzQOlAvnwrSHXOt7rKcEIElEVvlxyJsbERzd8l
        TNn+XPmd2OSVM4gGdviD6esWGL6Gh1u+SJP1ziF6jR7Lc7Q8tzEIv7198u+lNThC
        sRtkRlp+d7/0lV8nQ3hO3TA9hQs8UglBSCX9jTDGLoqnIQs2Y+k75cKbAv9ZXv5y
        u6J9fHjT/QIi056PVHw3bb01YqA6E7Oi3p6GOJpfyD8VJKyZkQTi+4s66rx+Y/tq
        s/oxMfxHNiZY4wqYy70qrU+i6KQjHijpwufWTjjk+A8eco7yKPuKQsrCpr2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671061690; x=1671148090; bh=SLgELAxBK49tyfuwt7e2QpMW23iZ
        gCnbRJyNF5uq7lE=; b=k6X69AvLVBp43zvrSHiCEc0/4UPRC7Cvn9JlPTwbSa6X
        vYSDRZBZEbXakuMk6/JMIdtgYOwG14hwzKAVRakjD9a6j2uFNQe3l4G+RPWqORfA
        LZx5r0ACLhVYx5XDtWiyjEkor/Ve+cn0notGfCKiGD4KliFW1LL/enFJY4qaogzl
        dQ1OPqjhE3JkKZYvgswD6f4oEiKMOBWrFsvRXfxFnktM0OzjvQ9MOkMmDXIx072R
        tw9XkttWxc8g6UiKFqY0+YuJo1oa7wARu/MzqZFk9kaX+CH3wsap1LfQnRGSYo+g
        sLzGAw9jIVr4GMTMDVyBrRLn4obNNkNa/yIT3OtLnQ==
X-ME-Sender: <xms:umCaY0lHCLpQieq48m6V8Zm3R-knbsQdUNBJ52UK0t2yKruaGMbzVA>
    <xme:umCaYz0M1PL1MbSHWG8KfAIAVrvMSUHlhZdybHKTmCfhjpyvO9UXULr6frnRUXuFr
    w6w7050SinYXLPa6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenfghrlhcuvffnffculddvfedmnecujfgu
    rhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivg
    hlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepjeel
    teehvddvfefgteefgfeggfevtdfftedutdehkedvheeukefgtdefgeehveeinecuffhomh
    grihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:umCaYypc5AzY65xx_CEdBMrgdbSdJWR0_MQ9vG_G1q-K56swpRmvPw>
    <xmx:umCaYwlmpE9u-xwv9UA6N13TiYSqrGO6pJJ6BS0DCxVkYwvyal0GFA>
    <xmx:umCaYy1MO7cnozWQLbPlajg2ISoM6L85zZFlqnzDcqlAwfP0fnc3AA>
    <xmx:umCaY3_JNNE8wBY9atCYH3AXpQYMglerkMHE6HKGeeEw2B4JVX3DCg>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 93645BC0078; Wed, 14 Dec 2022 18:48:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <263e2fc0-9833-4bef-84e3-902fb3a8dbad@app.fastmail.com>
In-Reply-To: <202212121614.1CSzW0Xw-lkp@intel.com>
References: <202212121614.1CSzW0Xw-lkp@intel.com>
Date:   Wed, 14 Dec 2022 16:47:49 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "kernel test robot" <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Alexei Starovoitov" <ast@kernel.org>
Subject: Re: progs/test_bpf_nf_fail.c:82:4: error: incomplete definition of type
 'struct nf_conn'
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022, at 1:57 AM, kernel test robot wrote:
> Hi Daniel,
>
> First bad commit (maybe != root cause):
>
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> master
> head:   830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> commit: e2d75e954c0a277b8fa0ddf666ddd4f9b73195f7 selftests/bpf: Add 
> tests for writing to nf_conn:mark
> date:   3 months ago
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>         # 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e2d75e954c0a277b8fa0ddf666ddd4f9b73195f7
>         git remote add linus 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e2d75e954c0a277b8fa0ddf666ddd4f9b73195f7
>         make O=/tmp/kselftest headers
>         make O=/tmp/kselftest -C tools/testing/selftests
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> progs/test_bpf_nf_fail.c:82:4: error: incomplete definition of type 'struct nf_conn'
>            ct->status = 0xF00;
>            ~~^
>    progs/test_bpf_nf_fail.c:7:8: note: forward declaration of 'struct nf_conn'
>    struct nf_conn;
>           ^
>    1 error generated.
>
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
> Attachments:
> * config

Not sure what to do about this. Seems like we'd want conditional compilation
for selftests depending on build config. But maybe effort not worth it since
there's a specific CI environment? And unlikely that connmarks disabled on
most distro kernels.

Lemme know if it's worthwhile to fix. Otherwise I will ignore.

Thanks,
Daniel
