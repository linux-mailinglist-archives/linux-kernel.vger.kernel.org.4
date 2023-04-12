Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289286DE9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDLDGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLDGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:06:01 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14F10C3;
        Tue, 11 Apr 2023 20:05:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 22C665823DC;
        Tue, 11 Apr 2023 23:05:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 11 Apr 2023 23:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681268756; x=1681269356; bh=IV
        QogybHkDC30haD/hPAJ0xHNHCLaD023WW6qkRFZlo=; b=DUiD+QcvT1Mj6zjUzO
        KIYP8xoaiGUexa2Zl7b6xwBzL+JHGQeqKNHJUBGWdWN+7jIg+Vp41xaYjj93nDqn
        zXXJsXdiXeaZgCJypXBvk79dA6WSvoNV8ygKtqFiiiRZ65mMMvc8if8ElNXOaBRG
        LuAKFUp6+ZOyRk2JE3OoKiyAonaDK3Uu+XQjJfcQ0cODB8qdTxayaC5NY1paMLWj
        VKI+gD+BmJ0gkA/8xAI22MCYJkSkRq/A2QwO7vrV7hagtAz3CxQlFTmuAhEORGXh
        iksibwAWWxPhouSDFvyekpUB1EJmV8rB0LyWRRQiF8JpXbpcaXRT+qjS+zBOYFsk
        bmMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm3; t=1681268756; x=1681269356; bh=IVQ
        ogybHkDC30haD/hPAJ0xHNHCLaD023WW6qkRFZlo=; b=Viivpd2xdLzx4FotxxF
        84+fTR430q5HwBVCmehQRFW1pEUgnCaSfe9NutEqvOMI4BJ84qgDOTsSFhInpi5T
        FBh2S1tDkxpTXBJ1y57DqDfQPPuvgrT9vEwqw2AI0QdRcz69h6PT1tqKTRfZN8R7
        rXGRACBxl38EkA8KtylGIpj9mY1dmDQYALLmYq3vT2nuvWr1mkfCV+yDZnl+zr+w
        4T+NDojjEgtE53lJEI2ye6UEdbQpxuGHfnlJkhRcmCpzELLkzJx2FmFQiECEfMu/
        IIQMXQZB1ERvjAZSxFsXEQBd4cm1Ro4ccpieRZwuIupC++6nR23xtTZEZVweOZt2
        RlQ==
X-ME-Sender: <xms:EyA2ZDU4rwMFXxC0phxJPhN5nnRdjMyhbvA7xkDb_XEE8TWfSj4JEQ>
    <xme:EyA2ZLmo7AyLxBkMlHIcBbt1s363w4hTa9UM90trnKUiCVkhnKiqqsK4b_gYMv7hq
    8QWOT4bLN8MU2vvJL8>
X-ME-Received: <xmr:EyA2ZPZkRhC0DfxkI5qyn7Fz5PcvOmIE9snK30WHS1jg9lU9DxjMcJRqkZQb6Wj7JDpiS__yiolys-fBAfcx0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekhedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdegtdfgvdfhgfekvdektdfgfeeljeel
    gefgkedujeeiteehgefhgeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:EyA2ZOVsWdhxRnpTbGJBCIokMREM-why9Pv6L28TprXajstMcBqPxw>
    <xmx:EyA2ZNnfSKsO0G91vC61jzGGZYHOD8X3oiQWGOObtda4exN2z93Ahw>
    <xmx:EyA2ZLfhFnIHwVVyNLJNyFrKIvEDrjR-qoiPE17qSzvUUilSqJsjQA>
    <xmx:FCA2ZAtZR_XEUCEY3_bBTVkz3icqVzuwuJTvLQKUxkFbMe4F7Kg1fmmV9PI>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 23:05:53 -0400 (EDT)
Date:   Wed, 12 Apr 2023 12:05:51 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     chaitanyak@nvidia.com, akpm@linux-foundation.org, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH blktests] don't require modular null_blk for
 fault-injection
Message-ID: <c57uedevavvjwlcvgxfv453dfiy4cgq4f23dscu5dy77sujgw2@pb6fyyfov5se>
References: <7c00f4f8-5bdf-4fa6-d9f0-141cf88c9ec9@nvidia.com>
 <20230329162145.147395-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329162145.147395-1-akinobu.mita@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu, thanks for the patch, and sorry for this slow response.

On Mar 30, 2023 / 01:21, Akinobu Mita wrote:
> I'm trying to allow configuration of null_blk fault-injection via configfs.
> 
> This blktests change changes null_blk fault-injection settings to be
> configured via configfs instead of module parameters.
> This allows null_blk fault-injection tests to run even if the null_blk is
> built-in the kernel and not built as a module.

It's good that the three test case can run with built-in null_blk.

> 
> However, to keep the scripts simple, we will skip testing if the null_blk
> does not yet support configuring fault-injection via configfs.

Hmm, it means that blktests coverage will be lost on older kernels without the
configfs support. Before this change, the test cases were not skipped on older
kernel with loadable null_blk. After this patch, the test cases will be skipped.

Can we cover both the new and old ways? When the null_blk set up with configfs
fails, we can fallback to the old way with module parameters.

For example, null_blk set up of block/014 can be like this:

	# Here, we fail 50% of I/Os.
	if ! _configure_null_blk faultb0 timeout_inject/probability=50 \
	     timeout_inject/times=-1 timeout_inject/verbose=0 power=1 \
	     > /dev/null 2>&1; then
		rmdir /sys/kernel/config/nullb/faultb0
		if [[ -d /sys/kernel/config/nullb/faultb0/timeout_inject ]]; then
			echo "Configuring null_blk failed"
			return 1
		elif _module_file_exists null_blk; then
			# Fall back to set up with module parameter. The format
			# is "<interval>,<probability>,<space>,<times>"
			if ! _init_null_blk timeout='1,50,0,-1'; then
				echo "Configuring null_blk failed"
				return 1;
			fi
		else
			SKIP_REASONS+=("requires fault injection via configfs or modular null_blk")
			return 1
		fi
	fi

