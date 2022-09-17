Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA415BB8DA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIQOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:49:33 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395FC30E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:49:28 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220917144922epoutp02fcbac7f37ca91ac2cee8322d4a3bc339~VrUgeJ50U3103331033epoutp02T
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:49:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220917144922epoutp02fcbac7f37ca91ac2cee8322d4a3bc339~VrUgeJ50U3103331033epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663426162;
        bh=BsAauzcqvNNVeqImcp9I3CG4uOfDsEQD2S4eOyim4BQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O7/9ZDytDgosXjDKGYAWTTgEkKeuU7fGF8soGZEMhSEq4GYl4txopQ+oOAJ55RmVU
         vDgGvG84Wdkwvd+TvwV5Vmn75Vz+XAPd/10AgazDokB3v3xGM+DAcSdS3HD49qJkK5
         ZJcwJscwruUhAR2v2+Sq9XbU3uQhPjrA0/+a9vrk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220917144921epcas1p4da9b0db30621e65d657d4c9205a79a46~VrUfR6pTy1395813958epcas1p4U;
        Sat, 17 Sep 2022 14:49:21 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MVDNc2Krmz4x9Pr; Sat, 17 Sep
        2022 14:49:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.59.07146.07ED5236; Sat, 17 Sep 2022 23:49:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220917144919epcas1p25842370f2680f6b5fcbb25d28e41ba53~VrUdZRMkL1016310163epcas1p2E;
        Sat, 17 Sep 2022 14:49:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917144919epsmtrp27e1b0612c8ccf9d4dfdaf111a81d5cf9~VrUdVsPLg1715917159epsmtrp2G;
        Sat, 17 Sep 2022 14:49:19 +0000 (GMT)
X-AuditID: b6c32a35-47bfe70000021bea-4c-6325de70ca7d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.A3.14392.F6ED5236; Sat, 17 Sep 2022 23:49:19 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917144919epsmtip2cc5a9dfc4b7ddcdfb553cbf69bb72b33~VrUdJOuPV0643506435epsmtip2h;
        Sat, 17 Sep 2022 14:49:19 +0000 (GMT)
Date:   Sat, 17 Sep 2022 23:49:18 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        ogabbay@kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Message-Id: <20220917234918.8b94d2690b8533bd47cf64e0@samsung.com>
In-Reply-To: <e035ac54-35af-4e86-a74a-9a4c7f936a19@www.fastmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmgW7BPdVkg5vnuS3+TjrGbjH14RM2
        i+bF69ks9r7eym5xedccNovbjSvYLPb1fGS0eD7tOosDh8fvX5MYPTat6mTzuHNtD5vH/rlr
        2D36tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VW
        ycUnQNctMwfoICWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpe
        XmqJlaGBgZEpUGFCdsbqFx/YCrarVcy818fewNgt18XIySEhYCLxc8dG5i5GLg4hgR2MEmdm
        nWaCcD4xSjw99IQFpEpI4BujRNsjXZiOYxtAOkDiexkltvxNhrA7mCSe/mADsVkEVCWevGwG
        s9mA7Jkz1rCD2CICyhK/fkxiBVnALPCHUaJv3xawhLCAmcSEqTPBbF4BR4lt79vAFnAKuEh8
        /XKPFWKxhcTdnhVANgdQjaDE3x3CIGFmAXmJ7W/ngH0gIdDLIbFzznsWkBoJoN4LW+ogWoUl
        Xh2HWCUhICXx+d1eNgg7W2JKxyIWCLtA4tzzrcwQrcYSF1ekgJjMApoS63fpQ1QoSuz8PZcR
        YiufxLuvPawQ1bwSHW1CECVKEkv+HIZaJCExdcY3JgjbQ2L51UPQwPzNKHF1v84ERoVZCK/M
        QvLKLIS9CxiZVzGKpRYU56anFhsWGMLjNjk/dxMjOGlqme5gnPj2g94hRiYOxkOMEhzMSiK8
        qp4qyUK8KYmVValF+fFFpTmpxYcYTYERM5FZSjQ5H5i280riDU0sDUzMjIxNLAzNDJXEefW0
        GZOFBNITS1KzU1MLUotg+pg4OKUamA4X/HNRa2iUk/rpy89trVyU5fSJYe4R8dOzyrvMGple
        8LxXe3bzpfW8bZezdeO//dF+LuO21M7GMuZy36HgT6190+TKVZcafZ+gfrnmYpfuJiEBk6j3
        m3dd5JjLGrpz+vTijMQbx3+0iYmW562e8W+V4tP/r0rZPrU9NyqbF1NcU7BzR9p76YNzG5bq
        5KeGeq7LNp1sXru06+TExur7CxqmqC3t+9zGPeV68ss3jfVP9nFKlL5adiTj6OPSC6L/Kibf
        KZ6/bLJjmcpxHvY68YMvAub0fT+75NkK60lbz2u97Q5O3qgXukJH/fIXwVKN9PlOO9VmLd15
        z9Uv3OuJgYkwR16D10aO2zdPzPx03EqJBehKQy3mouJEADC++/IjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvG7+PdVkg3k/uC3+TjrGbjH14RM2
        i+bF69ks9r7eym5xedccNovbjSvYLPb1fGS0eD7tOosDh8fvX5MYPTat6mTzuHNtD5vH/rlr
        2D36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY/WLD2wF29UqZt7rY29g7JbrYuTkkBAwkTi2
        YSNzFyMXh5DAbkaJa3dvMkEkJCQ23VsOlOAAsoUlDh8uBgkLCbQxSWxerA5iswioSjx52cwG
        YrMB2TNnrGEHsUUElCV+/ZjECjKTWeAPo8T7jqdgM4UFzCQmTJ0JVsQr4Cix7X0bM4jNKeAi
        8fXLPVaIBb8ZJa7u14G4wULibs8KVpAbeAUEJf7uEAYJMwtoSTz8dYsFwpaX2P52DvMERsFZ
        CFWzkFTNQlK1gJF5FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcFRoae5g3L7qg94h
        RiYOxkOMEhzMSiK8qp4qyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
        LYLJMnFwSjUwbfwXdG4ezwS5Vdf10q3ldOPZVNKTcgs3NJ2tTWSvUz7a3S/t/nGBjNyym6rM
        KZzJx67Onu8ibMbyfKHpmxVPnLN/tdy6I7ZyTS9XLsfMldv2BC5d015qMre6c5Fokekp44TA
        sizW7ZzuKmy31Bd+4ijmPGuwOGDWKe5bH/OX5m1aUnXcRbRwwY7Al86HsmwOnjFJb3jFKLzX
        JlEl2NBG4IiAx/t/l8Smv9mr2nosOn7Kh/0b+45xP/qwbo311tVSK6YVzkuWimaanpS08q1C
        zh4f1iW1D/+dblm76ngbz55Jk9bk61tFfF61/R6fptDrrXeS3sZL8vFmCJeZd0U4+lUz2e+S
        9iifYxV1/cIaJZbijERDLeai4kQA8xPLmvkCAAA=
X-CMS-MailID: 20220917144919epcas1p25842370f2680f6b5fcbb25d28e41ba53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p17b277154f0d020435417450fa0337906
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
        <20220917072356.2255620-2-jiho.chu@samsung.com>
        <e035ac54-35af-4e86-a74a-9a4c7f936a19@www.fastmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2022 09:41:13 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Sat, Sep 17, 2022, at 9:23 AM, Jiho Chu wrote:
> > It contains the base codes for trinity driver. Minimal codes to load and
> > probe device is provided. The Trinity Family is controlled by the
> > Memory-Mapped Registers, the register addresses and offsets are
> > described. And user api interfaces are presented to control device under
> > ioctl manner.
> 
> I'm not doing a full review of the driver at the moment, but
> here are some comments on the usage of chardev ioctl based on
> Documentation/driver-api/ioctl.rst
> 

Hi, Arnd
Thanks for your review.
I'll read the document more precisely.

> > +int trinity_probe(struct platform_device *pdev, const struct 
> > trinity_desc *desc)
> > +{
> > +	struct device_node *np;
> > +	struct device *dev;
> > +	struct trinity_driver *drv;
> > +	int i, err;
> > +
> > +	dev = &pdev->dev;
> > +	dev->id = ((desc->ver & TRINITY_MASK_DEV) >> TRINITY_SHIFT_DEV);
> > +
> > +	/* set private data */
> > +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> > +	if (!drv)
> > +		return -ENOMEM;
> > +
> > +	drv->dev_id = ida_alloc(&dev_nrs, GFP_KERNEL);
> > +	if (drv->dev_id < 0) {
> > +		devm_kfree(dev, drv);
> > +		return drv->dev_id;
> > +	}
> > +	snprintf(drv->name, DEV_NAME_LEN, "%s-%u", desc->type, drv->dev_id);
> > +
> > +	platform_set_drvdata(pdev, drv);
> > +	dev_set_drvdata(dev, drv);
> > +
> 
> If you have the need to manage multiple devices here, maybe use
> a dynamic major number and have the chardev code allocate the
> minor numbers, instead of using multiple misc devices and
> doing that yourself.
> 

I'm little confusing. It means that managing own char devices is proper,
not using misc device? But, it's still under misc dir.

> > +
> > +#ifndef TASK_COMM_LEN
> > +#define TASK_COMM_LEN 16
> > +#endif
> > +
> > +#define TRINITY_APP_NAME_MAX TASK_COMM_LEN
> > +#define TRINITY_APP_STAT_MAX 10
> > +#define TRINITY_REQ_STAT_MAX 10
> 
> The structure layout should not depend on whether an application
> has included a header that defines TASK_COMM_LEN.
> 
> What is the purpose of including an application name here?
> 
> > +/**
> > + * struct trinity_ioctl_stat_app - Describes stat of the target app
> > + * @app_id: Trinity app id (currently, equal to pid)
> > + * @name: Trinity app name
> > + * @status: Trinity app status
> > + * @num_total_reqs: Number of total requests in app (including 
> > finished ones)
> > + * @num_active_reqs: Number of active (running or pending) requests in 
> > app
> > + * @total_alloc_mem: Total size of allocated memory in the device
> > + * @total_freed_mem: Total size of freed memory in the device
> > + */
> > +struct trinity_ioctl_stat_app {
> > +	__s32 app_id;
> > +
> > +	char name[TRINITY_APP_NAME_MAX];
> > +	enum trinity_app_status status;
> > +
> > +	__u32 num_total_reqs;
> > +	__u32 num_active_reqs;
> > +
> > +	__u64 total_alloc_mem;
> > +	__u64 total_freed_mem;
> > +} __packed;
> 
> 'enum' in a uapi structure is not well-defined across
> architectures, so better use a fixed-size type there.
> 
> Instead of packing the structure, you should keep all
> members naturally aligned and add explicit padding
> or change some members for 32-bit to 64-bit size
> to keep everything naturally aligned.
> 

I checked, the members will be aligned.


> > +/**
> > + * struct trinity_ioctl_profile_buff - Describes profiling buff info.
> > + * @req_id: The target req id for profiling
> > + * @profile_pos: The start position to extract profiling data
> > + * @profile_size: The size of user-allocated profiling buffer
> > + * @profile_buf: The profiling buffer which user allocated
> > + */
> > +struct trinity_ioctl_profile_buff {
> > +	__s32 req_id;
> > +	__u32 profile_pos;
> > +	__u32 profile_size;
> > +	void __user *profile_buf;
> > +} __packed;
> 
> Don't put pointers into ioctl structures, they just make compat
> mode unnecessarily hard. You can use a __u64 member.
> 

OK. thanks.

> > +/**
> > + * Major number can not be dynamic as ioctls need it,
> > + */
> > +#define TRINITY_DRIVER_MAGIC 0x88
> > +
> > +#define TRINITY_IO(no) _IO(TRINITY_DRIVER_MAGIC, no)
> > +#define TRINITY_IOR(no, data_type) _IOR(TRINITY_DRIVER_MAGIC, no, 
> > data_type)
> > +#define TRINITY_IOW(no, data_type) _IOW(TRINITY_DRIVER_MAGIC, no, 
> > data_type)
> > +#define TRINITY_IOWR(no, data_type) _IOWR(TRINITY_DRIVER_MAGIC, no, 
> > data_type)
> 
> These macros just hurt tools that want to parse the headers.
> Please just open-code the usage.
> 
> > +#ifdef __KERNEL__
> > +__s32 trinity_run_internal_req(dev_t);
> > +#endif
> 
> This doesn't seem to belong into the uapi header.
> 
>       Arnd
> 

macros and useless codes will be cleared.

Thanks.
Jiho Chu







