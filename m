Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54605BB700
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:41:37 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD69A2BB17
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:41:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E7C74580CFC;
        Sat, 17 Sep 2022 03:41:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 17 Sep 2022 03:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663400495; x=1663404095; bh=XPkVenvfJv
        t4HbcR6EFl5/JAay2QmmXoHzLNgHB1U44=; b=G7ysDfxgxf7O54nCE81ENnrpD4
        ABgywRhhRuvPSfgexFWtrKnaf5ZkH4Mqezwjq+H37jcaDWycMSmXLNeTluBkL4OB
        ct8Ozdq3X46rtDJMA7ptOHQxYsIozGLisi2r4DMNB+eFL79XWC1dH5oTeQJy5kND
        p9arbQjo2gSDIDlXssXW6hvWIzHXGAETkVIAc4pcz0qVRterJnchL3DHNf/2XKfj
        D4Yk1Gq/TCvz8WKQlRM/VnYBG6Rtftx/yQJYc3J4AMPCD5BoEIC2qOPoWnXwpEWo
        ihHvSAZdLfH24HebBPG8pu7fszEmpEC4jf582+naibVIana/eN8GW+lQACyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663400495; x=1663404095; bh=XPkVenvfJvt4HbcR6EFl5/JAay2Q
        mmXoHzLNgHB1U44=; b=LAXJ9k97n4bML+jmobtDOPi+ZIpzMI+yQ6vo4qaItv3i
        RFCMopN+NBHilP1MgvURxrlt1vEDvAWM1uHwcvoUWiI+8Bui6EJukLceDvp74H4f
        HyHcEvYPURoXgZbmQ7VyDXGYmmbeJRaf+3fYvBPXaVZhf7e3MRWAnZNF61FmeRqb
        PjADT3Bo3uQZdNyZfauNn6sNhothJ7Ybt8EagUtqEaa47n9Y6DsfK2MvhFU02dyb
        hIi45mEH3L7seMcy36MIQt++YnWcrVagCaatAIgrg0Brn+xr/u2xGwk66MsuhpiG
        7GRYUoc/yrQA0DirEgXiTN1qeKYr6MQEdZODdSCmNQ==
X-ME-Sender: <xms:L3olYxqeuxpdVpxJK_FkLWF9Y1wxPkJuoRa41I5tFNCipCHKFQVc9A>
    <xme:L3olYzrJ24VCYmogo_9gvbC030sx767xYd4p4kRiWLlpxxOW42JonsoipV1YE-3tm
    KOpgUytV8aQl3Ghh14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:L3olY-MhNzp-y4aH4OEZWB1-F-WHtBH3r8McR4pS3SL2hhbGbmV25w>
    <xmx:L3olY87LEq7bu9ulfh-B44GQCA8m8WiTE3ZxRDiSPy_zuYxK_nKEUw>
    <xmx:L3olYw6fR8OASzoTUBMMTiEyiB5xejndqs9hz7B20T2IeGl5tSdk5g>
    <xmx:L3olY6TT1zVUcGfHIgzAJ0Y-ZMXANeIaHTv-nn8UA2-H1EfW9KOd_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 710D1B60086; Sat, 17 Sep 2022 03:41:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <e035ac54-35af-4e86-a74a-9a4c7f936a19@www.fastmail.com>
In-Reply-To: <20220917072356.2255620-2-jiho.chu@samsung.com>
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
 <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
 <20220917072356.2255620-2-jiho.chu@samsung.com>
Date:   Sat, 17 Sep 2022 09:41:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiho Chu" <jiho.chu@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        ogabbay@kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Mark Brown" <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022, at 9:23 AM, Jiho Chu wrote:
> It contains the base codes for trinity driver. Minimal codes to load and
> probe device is provided. The Trinity Family is controlled by the
> Memory-Mapped Registers, the register addresses and offsets are
> described. And user api interfaces are presented to control device under
> ioctl manner.

I'm not doing a full review of the driver at the moment, but
here are some comments on the usage of chardev ioctl based on
Documentation/driver-api/ioctl.rst

> +int trinity_probe(struct platform_device *pdev, const struct 
> trinity_desc *desc)
> +{
> +	struct device_node *np;
> +	struct device *dev;
> +	struct trinity_driver *drv;
> +	int i, err;
> +
> +	dev = &pdev->dev;
> +	dev->id = ((desc->ver & TRINITY_MASK_DEV) >> TRINITY_SHIFT_DEV);
> +
> +	/* set private data */
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->dev_id = ida_alloc(&dev_nrs, GFP_KERNEL);
> +	if (drv->dev_id < 0) {
> +		devm_kfree(dev, drv);
> +		return drv->dev_id;
> +	}
> +	snprintf(drv->name, DEV_NAME_LEN, "%s-%u", desc->type, drv->dev_id);
> +
> +	platform_set_drvdata(pdev, drv);
> +	dev_set_drvdata(dev, drv);
> +

If you have the need to manage multiple devices here, maybe use
a dynamic major number and have the chardev code allocate the
minor numbers, instead of using multiple misc devices and
doing that yourself.

> +
> +#ifndef TASK_COMM_LEN
> +#define TASK_COMM_LEN 16
> +#endif
> +
> +#define TRINITY_APP_NAME_MAX TASK_COMM_LEN
> +#define TRINITY_APP_STAT_MAX 10
> +#define TRINITY_REQ_STAT_MAX 10

The structure layout should not depend on whether an application
has included a header that defines TASK_COMM_LEN.

What is the purpose of including an application name here?

> +/**
> + * struct trinity_ioctl_stat_app - Describes stat of the target app
> + * @app_id: Trinity app id (currently, equal to pid)
> + * @name: Trinity app name
> + * @status: Trinity app status
> + * @num_total_reqs: Number of total requests in app (including 
> finished ones)
> + * @num_active_reqs: Number of active (running or pending) requests in 
> app
> + * @total_alloc_mem: Total size of allocated memory in the device
> + * @total_freed_mem: Total size of freed memory in the device
> + */
> +struct trinity_ioctl_stat_app {
> +	__s32 app_id;
> +
> +	char name[TRINITY_APP_NAME_MAX];
> +	enum trinity_app_status status;
> +
> +	__u32 num_total_reqs;
> +	__u32 num_active_reqs;
> +
> +	__u64 total_alloc_mem;
> +	__u64 total_freed_mem;
> +} __packed;

'enum' in a uapi structure is not well-defined across
architectures, so better use a fixed-size type there.

Instead of packing the structure, you should keep all
members naturally aligned and add explicit padding
or change some members for 32-bit to 64-bit size
to keep everything naturally aligned.

> +/**
> + * struct trinity_ioctl_profile_buff - Describes profiling buff info.
> + * @req_id: The target req id for profiling
> + * @profile_pos: The start position to extract profiling data
> + * @profile_size: The size of user-allocated profiling buffer
> + * @profile_buf: The profiling buffer which user allocated
> + */
> +struct trinity_ioctl_profile_buff {
> +	__s32 req_id;
> +	__u32 profile_pos;
> +	__u32 profile_size;
> +	void __user *profile_buf;
> +} __packed;

Don't put pointers into ioctl structures, they just make compat
mode unnecessarily hard. You can use a __u64 member.

> +/**
> + * Major number can not be dynamic as ioctls need it,
> + */
> +#define TRINITY_DRIVER_MAGIC 0x88
> +
> +#define TRINITY_IO(no) _IO(TRINITY_DRIVER_MAGIC, no)
> +#define TRINITY_IOR(no, data_type) _IOR(TRINITY_DRIVER_MAGIC, no, 
> data_type)
> +#define TRINITY_IOW(no, data_type) _IOW(TRINITY_DRIVER_MAGIC, no, 
> data_type)
> +#define TRINITY_IOWR(no, data_type) _IOWR(TRINITY_DRIVER_MAGIC, no, 
> data_type)

These macros just hurt tools that want to parse the headers.
Please just open-code the usage.

> +#ifdef __KERNEL__
> +__s32 trinity_run_internal_req(dev_t);
> +#endif

This doesn't seem to belong into the uapi header.

      Arnd
