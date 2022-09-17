Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7E5BB6FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIQHjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:39:15 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623072E6A2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:39:13 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220917073911epoutp018d11a50daea2b06d599a57bf0d76112e~Vlc5_wocJ3169831698epoutp01Z
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:39:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220917073911epoutp018d11a50daea2b06d599a57bf0d76112e~Vlc5_wocJ3169831698epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663400351;
        bh=xpfNcpO/uhe7cfrO9Rfq5dLxoXqD5uZUnXXzp9s6lQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PttA6lgP1PpuCbLJVK1VRRzUClYKcaTe3JArg6uBG1kf81E250r8OvU1H9HwiS1E9
         gD/4yNPOArv72IRggmHJxgrf8431QQnro981U1UHwAsqw8WRY/uNVFplvP7zi8qXxq
         7yIp7fUe9n05+SIkzdMqu6otve1yk4m9yruBes3g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220917073910epcas1p3a70d2bb5a298cd97afc5b7779153805e~Vlc4zIzPe2138421384epcas1p3J;
        Sat, 17 Sep 2022 07:39:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.133]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MV2rF2MYDz4x9Pp; Sat, 17 Sep
        2022 07:39:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.CD.64988.D9975236; Sat, 17 Sep 2022 16:39:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220917073908epcas1p388c3d51816ec1c7049da75e62531cc90~Vlc22Ssmv2138421384epcas1p3I;
        Sat, 17 Sep 2022 07:39:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917073908epsmtrp275865d55b6183a6e8f94703a4875aa5e~Vlc2zANkx2634126341epsmtrp2W;
        Sat, 17 Sep 2022 07:39:08 +0000 (GMT)
X-AuditID: b6c32a39-8d3fa7000001fddc-1d-6325799da3c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.41.18644.B9975236; Sat, 17 Sep 2022 16:39:07 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917073907epsmtip274826178143433d075c022f930d2c873~Vlc2nW9eB3199931999epsmtip2X;
        Sat, 17 Sep 2022 07:39:07 +0000 (GMT)
Date:   Sat, 17 Sep 2022 16:39:07 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH 3/9] trinity: Add load/unload IDU files
Message-Id: <20220917163907.3dc80493dd21f3f2e2fbff4c@samsung.com>
In-Reply-To: <YuE6IrM/8slDjsdL@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmru7cStVkg9vfuC3+TjrGbtG8eD2b
        xeVdc9gsbjeuYLN4Pu06iwOrx+9fkxg99s9dw+7Rt2UVo8fnTXIBLFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BaYFesWJucWleel6eaklVoYGBkamQIUJ2Rmntm1gL3jEX3Hy9lX2
        BsZ1PF2MnBwSAiYSn998Ze9i5OIQEtjBKLFm8QsWCOcTo8S1xr1MEM5nRom9N5+wdjFygLW8
        6YyFiO9ilNiw5SUrhNPBJLF35Rd2kCIWAVWJH23RICvYgMyZM9awg9giAhoSL4/eYgEpYRZI
        ldixNhQkLCxgLXF23zqwEl4BR4n25++YQWxOAU2J7zN7GSEutZC427MC7AReAUGJvzuEQcLM
        AvIS29/OYQa5QELgHrtE99u7LBD1LhJ903cxQ9jCEq+Ob2GHsKUkPr/bywZhZ0tM6VgEVV8g
        ce75VmaIF40lLq5IgbhSU2L9Ln2ICkWJnb/nMkKs5ZN497UHGiC8Eh1tQhAlShJL/hyGWiQh
        MXXGNyYI20Oi7edqaDjdY5R4t/ob2wRGhVkIz8xC8swshMULGJlXMYqlFhTnpqcWGxaYwiM3
        OT93EyM4CWpZ7mCc/vaD3iFGJg7GQ4wSHMxKIryqnirJQrwpiZVVqUX58UWlOanFhxhNgfEy
        kVlKNDkfmIbzSuINTSwNTMyMjE0sDM0MlcR59bQZk4UE0hNLUrNTUwtSi2D6mDg4pRqYalxP
        Tjhy5Uxx1aHZUWEyR5dGvuX9vVhq7qLnS94wlfkUPtz3N1ZF54qwa270pluyXx7qWVpu7dzV
        KJbkLS15vuVU0jWmD++9/8jXfrsqNcN7Vkej3PJAM7flz3aeys3dlGTAWnw3wip8n/uygAur
        Tp5t8wgU278latK/h4d+KHu2anazX0/bZjfRRnDdszMJsvdS1GTPbdO+Y1HFtSXPbR2HCuPG
        4sm9SuodN+9ebXqxxbh1v9mU+xvMbi17e/7aPvUsnvJiwVXeH19VPDxmV5Bq/lST31fK4Mvf
        zqBlDve1FK+/c8h03WNeMYE9/sPh29t7D5TH8Aj+n8x6SLwstv/sK+kf31qM+pJXFwmvU2Ip
        zkg01GIuKk4EALU/AroLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvO6cStVkg5vMFn8nHWO3aF68ns3i
        8q45bBa3G1ewWTyfdp3FgdXj969JjB77565h9+jbsorR4/MmuQCWKC6blNSczLLUIn27BK6M
        U9s2sBc84q84efsqewPjOp4uRg4OCQETiTedsV2MXBxCAjsYJfY9XsDYxcgJFJeQ2HRvOTNE
        jbDE4cPFEDVtTBL/fm1gA4mzCKhK/GiLBilnAzJnzljDDmKLCGhIvDx6iwXEZhZIlehev4QZ
        xBYWsJY4u28dWA2vgKNE+/N3YHFOAU2J7zN7GSHmP2CUuNDzmAniBguJuz0rWEF28QoISvzd
        IQwxU0vi4S+Y+fIS29/OYZ7AKDgLoWoWkqpZSKoWMDKvYpRMLSjOTc8tNiwwykst1ytOzC0u
        zUvXS87P3cQIDm8trR2Me1Z90DvEyMTBeIhRgoNZSYRX1VMlWYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamKRNs47JkbTYsULVo6oqbcGGZQNqbT9yz
        j2pd69mzONIpdUuOgOS5Cyua69I1K0OvrPQw7ZWdLT3NmG2u+XoFneniiltlFSui9L+57Jr5
        t11dvum0OdcDJ5sCQckX5+f8WVGj3WX4hbOF5Wbg3FgDVcvipVd2l1w6tDq8/sUMqdMFj5X2
        3S1lFcu25f8Y456WJZ73R/+LqbHZG3+tOTP0F9UUTLxTlpS/9Z+tyj4ur7THwWKP792xzBDL
        /NpvcnNC+92vM19meu2KNvnwQvTU6TvPqpLV7eaJJDUlWqlnBJ7qzKw3bBGc5/Jq1lepnfn7
        veX/aC4+3j5RWTe6puzj37DaxdK9zDe/6vlvWKfEUpyRaKjFXFScCADUEUfT3gIAAA==
X-CMS-MailID: 20220917073908epcas1p388c3d51816ec1c7049da75e62531cc90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p20c847655e7332c818fc0fd2c50fb0e27@epcas1p2.samsung.com>
        <20220725065308.2457024-4-jiho.chu@samsung.com> <YuE6IrM/8slDjsdL@kroah.com>
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 15:14:10 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jul 25, 2022 at 03:53:02PM +0900, Jiho Chu wrote:
> > +static int triv2_idu_load_file(struct trinity_driver *drv, const char *dirpath,
> > +			       const char *file_name,
> > +			       struct trinity_resv_mem *sector)
> > +{
> > +	struct device *dev = drv_to_dev_ptr(drv);
> > +	struct trinity_resv_mem mem;
> > +	char filepath[NAME_MAX];
> > +	struct kstat *stat;
> > +	struct file *filp;
> > +	loff_t pos = 0;
> > +	size_t size;
> > +	int ret;
> > +
> > +	dev = drv_to_dev_ptr(drv);
> > +	stat = vmalloc(sizeof(*stat));
> > +	if (stat == NULL)
> > +		return -ENOMEM;
> > +
> > +	/* if dirpath is null, use the default path */
> > +	if (dirpath)
> > +		snprintf(filepath, NAME_MAX, "%s/%s", dirpath, file_name);
> > +	else
> > +		snprintf(filepath, NAME_MAX, TRIV2_IDU_DIRPATH_FMT "/%s",
> > +			 utsname()->release, file_name);
> > +
> > +	filp = filp_open(filepath, O_RDONLY, 0400);
> 
> That is cute.  And totally not ok.
> 
> Please never do this, that is not how to properly load a firmware blob
> in the kernel.  This is racy and broken and probably a huge security
> hole.
> 
> Heck, I wrote an article about this very topic, way back in 2005, with
> the title of, "Things you should never do in the kernel" and can be seen
> here:
> 	https://protect2.fireeye.com/v1/url?k=9f82c8ca-ff605597-9f834385-000babd9f1ba-3ee71f9f013fb8d9&q=1&e=0963e638-a9ed-43d0-95e3-adfcbdba2425&u=https%3A%2F%2Fwww.linuxjournal.com%2Farticle%2F8110
> 
> This should not be news to anyone, again, never do this.
> 
> thanks,
> 
> greg k-h
> 

Hi, greg
I just resent second revision of the driver.
As your reference, reading user space file mechnism is changed to use IOCTL call.
And many of your reviews (abstaction, open count, doc,, ) are very helpful and fixed in the revision.
If they are modified in wrong way, please let me know.

Thanks for your review.

Thanks,
Jiho Chu

