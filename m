Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA45BC130
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:00:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E25F47
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:00:46 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220919020044epoutp029b4164ecf95c0089b0b15cb3b76f71a7~WIH90Y29a0790207902epoutp02g
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:00:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220919020044epoutp029b4164ecf95c0089b0b15cb3b76f71a7~WIH90Y29a0790207902epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663552844;
        bh=h7/jWRt60NfwI77l8YXNhMtu2wl0SFpp68AT0RraZV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SOyrvjgZiAdJgPak4TqjPOpkxJok2pbuTUwywJBb1KjyT5JMVk9LawisN9q1W6NiD
         gmQ6fRsfyPNmT7XW3jIy1L6Jjk7Et5PXZnW87Wc9EkIGhjDUvdC+50+tFTD1fpsqtp
         R8vk8bmudiLgtEWIsKzWOT1+ULcVlO9xZyZvuuUA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220919020043epcas1p440a270c6c6376aab5773ee65e9a32af3~WIH9MBEQX2566525665epcas1p4Q;
        Mon, 19 Sep 2022 02:00:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.232]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MW7Dp1Z4Hz4x9Q7; Mon, 19 Sep
        2022 02:00:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.F5.07146.84DC7236; Mon, 19 Sep 2022 11:00:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220919020040epcas1p3b03272333dd0584783b4862d74592721~WIH6V3hIT0800208002epcas1p3q;
        Mon, 19 Sep 2022 02:00:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220919020040epsmtrp22947fb2c04eb297a29b979adf31bab62~WIH6VFPOr3212132121epsmtrp2m;
        Mon, 19 Sep 2022 02:00:40 +0000 (GMT)
X-AuditID: b6c32a35-47bfe70000021bea-49-6327cd48c364
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.DB.14392.84DC7236; Mon, 19 Sep 2022 11:00:40 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220919020040epsmtip222e66a66c3090e366c023cb2b92fe1b1~WIH6IOu0z0821808218epsmtip2l;
        Mon, 19 Sep 2022 02:00:40 +0000 (GMT)
Date:   Mon, 19 Sep 2022 11:00:40 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, ogabbay@kernel.org, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Message-Id: <20220919110040.80b06ab4aa7460ad02c3246e@samsung.com>
In-Reply-To: <Yyb0a96poEWZUe1y@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmvq7HWfVkg1MHDS3+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKCrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5
        xaV56Xp5qSVWhgYGRqZAhQnZGWsPb2AsmKlW8aTrCEsD42nZLkZODgkBE4n2GTdYuxi5OIQE
        djBKXP94jgUkISTwiVHizGEWiMQ3Rom/9x+xwnQsOtrADJHYyyjx780CJging0ni3r/HzCBV
        LAKqEpsb/rCB2GxA9swZa9hBbBEBDYmXR2+BjWUWWM8oMblpD1hCWMBMYsLUmWA2r4CjxL8N
        MxlBbE4BTYmpi3oYIVZbSNztWQF0BgdQjaDE3x3CIGFmAXmJ7W/ngF0kIdDJITF33g0WiHoX
        iYvf9kGdLSzx6vgWdghbSuLzu71sEHa2xJSORVD1BRLnnm9lBpkvIWAscXFFCojJDHTC+l36
        EBWKEjt/z2WEWMsn8e5rDytENa9ER5sQRImSxJI/h6EWSUhMnfGNCcL2kFh+9RA0QO8xShzs
        ms44gVFhFsIzs5A8Mwth8QJG5lWMYqkFxbnpqcWGBYbw+E3Oz93ECE6jWqY7GCe+/aB3iJGJ
        g/EQowQHs5IIr6qnSrIQb0piZVVqUX58UWlOavEhRlNg1ExklhJNzgcm8rySeEMTSwMTMyNj
        EwtDM0MlcV49bcZkIYH0xJLU7NTUgtQimD4mDk6pBqbcLU0Ga1YuMLV1KL2dEGRUW925tPPN
        JzfGnWv41xon3ni7dccD6zPaFWtCnu/Udn3plyw832uj0DzGIxOsPySzHfsYVrX585KKM/Pm
        3v8WmSMi4/OeOzL0WNin69mi2v4t57J4g4JSH35MWlJyYj/T489hnuo7V/yzzvr3ynuuRTDv
        lbINdz7emH7h94f1aufn87x5u8RK7Wj4/Jp5rLy5yjE/W0S1kw6ysV/UWNmc53nqxqmMpYt3
        MLBc0Xever2AbxpD/Ub3vupH74s/qqWv/7RljqWayI79H5dpHn+bd9lZmNe79lSM0erw/iXf
        rVvvVb5YvnpiV+ZKhysvtxf2XprE8fN72GyPmohD8nkXlFiKMxINtZiLihMBsqyKuiwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvK7HWfVkg3cfhS3+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MtYc3MBbMVKt40nWEpYHxtGwXIyeH
        hICJxKKjDcxdjFwcQgK7GSX2f+9jhEhISGy6txwowQFkC0scPlwMUdPGJLF971o2kBoWAVWJ
        zQ1/wGw2IHvmjDXsILaIgIbEy6O3WEBsZoH1QEOXqYPYwgJmEhOmzgSr4RVwlPi3YSbYLk4B
        TYmpi3oYIRY8YJR4tu41C8QRFhJ3e1awghzBKyAo8XeHMMRMLYmHv2Dmy0tsfzuHeQKj4CyE
        qllIqmYhqVrAyLyKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4QrQ0dzBuX/VB7xAj
        EwfjIUYJDmYlEV5VT5VkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpiOff17wVj+2fHYN6kXJYJUPvt9sn/jG1VU7LRGomvTyYkOq6RyFxg9FO4wesvg
        zq2bLqb3mm120pR19fP/TdeJbOW8dVWm2eemz+Jk1qWyqe8SX3zUisjglBE7rSuW0Kpwv8ne
        mDn0zaNr0WYu0kqf4l/LzOVpU1/Oa6DzV53l8t1O+R9KlrPa9WXfd/5LdLBLbm8onZQsl9kv
        8kj6PNPr2Asyut6XCg0+1E49laDat1NDf1ZAiZyjkMtlU4Ys606H5ERDkSk/2hSZfyxN/Dnr
        sHJ+5WOvJ9fq/EIDXm666LYo+Lqup+Gid+YTGrjv5Qkt/Xxk+fQ7kzSiX0vt3mp3+Kvd7PWP
        ZQ+Zv5mepsRSnJFoqMVcVJwIAE+mIkD/AgAA
X-CMS-MailID: 20220919020040epcas1p3b03272333dd0584783b4862d74592721
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p17b277154f0d020435417450fa0337906
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
        <20220917072356.2255620-2-jiho.chu@samsung.com> <Yyb0a96poEWZUe1y@kroah.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2022 12:35:23 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Sep 17, 2022 at 04:23:44PM +0900, Jiho Chu wrote:
> > It contains the base codes for trinity driver. Minimal codes to load and
> > probe device is provided. The Trinity Family is controlled by the
> > Memory-Mapped Registers, the register addresses and offsets are
> > described. And user api interfaces are presented to control device under
> > ioctl manner.
> 
> Where is the documentation for how the userspace api works?  And where
> is a link to the userspace code that talks to these devices?  That
> belongs here in this commit changelog text please.
> 

Hi, Greg
Thanks for your review.

The user space library is published in:
https://review.tizen.org/gerrit/gitweb?p=platform/adaptation/npu/trix-engine.git;a=summary

It needs to login to tizen, access guide is:
https://docs.tizen.org/platform/get-started/open-source-project/

And, this information will be included in commit log.

> > +config TRINITY
> > +	bool "Samsung Neural Processing Unit"
> > +	depends on HAS_IOMEM
> > +	depends on HAS_DMA
> > +	help
> > +	  Select this option to enable driver support for Samsung
> > +	  Neural Processing Unit (NPU).
> > +
> > +	  This driver works as a base driver of the other drivers
> > +	  for Trinity device family.
> > +
> > +	  This option should be enabled to support Trinity
> > +	  Vision 2 (TRIV2), and Trinity Audio (TRIA).
> > +
> > +config TRINITY_VISION2
> > +	tristate "Samsung NPU Trinity Vision 2"
> > +	depends on TRINITY
> > +	help
> > +	  Select this option to enable driver support for a Samsung
> > +	  Neural Processing Unit (NPU), Trinity Vision 2.
> > +
> > +	  This driver enables userspace system library to access the
> > +	  device via /dev/triv2-N.
> 
> Why do you have 2 Kconfig entries for only a single driver?  Please just
> make it one.
> 

OK. It'll be merged.


> > diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
> > new file mode 100644
> > index 000000000000..a8e5697d6d85
> > --- /dev/null
> > +++ b/drivers/misc/trinity/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
> > +
> > +trinity-y := trinity.o
> > +
> > +trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
> > diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
> > new file mode 100644
> > index 000000000000..1704eecfc439
> > --- /dev/null
> > +++ b/drivers/misc/trinity/trinity.c
> > @@ -0,0 +1,225 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Base device driver for Samsung NPU Trinity device family
> > + *
> > + * Copyright (C) 2020-2022 Samsung Electronics
> > + * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
> > + * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
> > + * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
> > + * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
> > + * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
> > + */
> > +
> > +#include <linux/of_address.h>
> > +
> > +#include "trinity_common.h"
> > +
> > +#define TRINITY_PADDR_BASE (0x0)
> > +
> > +static DEFINE_IDA(dev_nrs);
> > +static DEFINE_IDA(model_ids);
> > +
> > +/**
> > + * trinity_release() - A common callback for close() in file_operations for a
> > + *		Trinity	device node. If there are device-specific data to be
> > + *		cleaned-up, it is required to clean them up before invoke this
> > + *		callback.
> > + *
> > + * @inode: Inode to be closed
> > + * @file: File to be closed
> > + *
> > + * Returns 0 on success. Otherwise, returns negative error.
> > + */
> > +int trinity_release(struct inode *inode, struct file *file)
> > +{
> > +	return 0;
> 
> If a callback does nothing, odds are it is not needed at all.  Please
> just remove.
> 
> And why is this a global function?
> 
> 

Thanks. All empty functions will be removed.

> > +
> > +	/* get reg info for MMREG_BASE */
> > +	for (i = 0; i < TRINITY_MAX_MMREGS; i++) {
> > +		struct resource mmreg;
> > +
> > +		err = of_address_to_resource(np, i, &mmreg);
> > +		if (err < 0) {
> > +			dev_err(dev, "failed to get %d-th mmreg info", i);
> > +			goto err_cleanup;
> > +		}
> > +
> > +		drv->mmreg_vaddr[i] = devm_ioremap_resource(dev, &mmreg);
> > +		if (IS_ERR(drv->mmreg_vaddr[i])) {
> > +			dev_err(dev,
> > +				"failed to remap %d-th mmreg resource info", i);
> > +			err = PTR_ERR(drv->mmreg_vaddr[i]);
> > +			goto err_cleanup;
> > +		}
> > +		drv->mmreg_paddr[i] = mmreg.start;
> > +	}
> > +
> > +	/** get a TOPS property */
> 
> Why the odd "**" in comments?
> 
> thanks,
> 
> greg k-h
> 

It fixed.
Thanks for checking that. 

Thanks.
Jiho Chu




