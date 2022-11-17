Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C362D404
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiKQHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiKQHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:25:07 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DD3206A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:25:06 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221117072500epoutp0456b06a8f42d92f96d9d3481482730543~oTm8WZQQF0283202832epoutp042
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:25:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221117072500epoutp0456b06a8f42d92f96d9d3481482730543~oTm8WZQQF0283202832epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668669901;
        bh=bomq5uKbuRivd/0IS2b2qGsu/Aszcoj+7st7Up+vv/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JbM9G9CIWhJmAJfpFAYG88FSoJ7R1x+5B2iG3W2ogx/Bgr7KoMq5ctXHawyjJRgtN
         wLpAGI2/kFGy7Fe13goClK6ZO8wgrsjJ3poTzuYdh2itZADjjm5j/oIbwvwkM5aMrE
         nfvjM2Tj3cXfNI2PM9TuCwCbG8fxh+hRzurO8zJ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221117072500epcas5p274e5f5728189dfc02d57e25c8bf34671~oTm75rPef3234232342epcas5p2I;
        Thu, 17 Nov 2022 07:25:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NCWdl1blHz4x9Q3; Thu, 17 Nov
        2022 07:24:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.5B.39477.9C1E5736; Thu, 17 Nov 2022 16:24:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221117072457epcas5p38a61bb22518e7c7eb7b32077621b948a~oTm5NKrE70971709717epcas5p33;
        Thu, 17 Nov 2022 07:24:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221117072457epsmtrp2b08b3c7f57446ba76b57ba015435039d~oTm5MWwaw0757107571epsmtrp2a;
        Thu, 17 Nov 2022 07:24:57 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-2f-6375e1c955d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.0F.18644.9C1E5736; Thu, 17 Nov 2022 16:24:57 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221117072456epsmtip277c450105fb88454edb235f699fe5325~oTm38ZaMW2257622576epsmtip2g;
        Thu, 17 Nov 2022 07:24:56 +0000 (GMT)
Date:   Thu, 17 Nov 2022 12:43:37 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     August Wikerfors <august@augustwikerfors.se>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221117071337.GA29422@test-zns>
MIME-Version: 1.0
In-Reply-To: <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu7Jh6XJBj8XGFocvXqWzeL/nmNs
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
        e+y+2cDm8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjMlvt7EXvOCo+PVuP2MD4yH2LkZODgkBE4lXz7ezgdhCArsZJe7fVOti
        5AKyPzFKXL3zggki8ZlR4sbFFJiGlXcmMkIU7WKUWNg+gw3CecYoce9VLzNIFYuAqkTDhEUs
        XYwcHGwCmhIXJpeChEUEDCT6//0Bq2cWOMQo8eDzMxaQhLBApMSjFdfBtvEK6EpsWHOLEcIW
        lDg58wlYDaeAm8T8wy/A5osKKEsc2HacCWSQhEAvh8Tejc+ZIc5zkdj0fxMrhC0s8er4Fqg/
        pSQ+v9vLBmEnS1yaeY4Jwi6ReLznIJRtL9F6qh9sDrNAhsTN23+gbD6J3t9PmECekRDgleho
        E4IoV5S4N+kp1CpxiYczlkDZHhIX7nWxQgLlDaPE9hNXmCcwys1C8s8sJCsgbCuJzg9NrLOA
        VjALSEss/8cBYWpKrN+lv4CRdRWjZGpBcW56arFpgVFeajk8jpPzczcxglOoltcOxocPPugd
        YmTiYASGLQezkghv7sXSZCHelMTKqtSi/Pii0pzU4kOMpsD4mcgsJZqcD0zieSXxhiaWBiZm
        ZmYmlsZmhkrivItnaCULCaQnlqRmp6YWpBbB9DFxcEo1MIV47LgRqb+XJbzots8i28Id8e19
        T+NPLg4MOrTYzbCc1VWMkT/iUsO/Qs6z/f0++RvXril6vtfovfTj9P0zDvedvGx9cLWAgXHN
        mbjrTxOtHgqvNhNcXuqcmKAW9WKysKmNz4Z1Hk3aUveOpGVvX/vcNb+G5+0Zk2mbPzz4r+Bz
        rvaU9qGrceL/De++5WVb9GH9rcrKi3MOvZi5PS/tvLZfxA8G7SCPLhkvYyGZB8nfPLnnBflM
        W1D58OVmFmu7a3lrezZVaTbfP785suBAi4hEpt2dDoa3DzZPSFaTlTm7dfUuY7N1j1cm/FAy
        na7Bk6JyLKIzXnzF471eN487OE60zt48MXiJ1Zn3YdbqxUosxRmJhlrMRcWJAGIpwbAqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO7Jh6XJBr/3y1gcvXqWzeL/nmNs
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
        e+y+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfG1Z3dTAWz2Coe9DQxNjD2sXYxcnJICJhIrLwz
        kbGLkYtDSGAHo8SXfQdZIBLiEs3XfrBD2MISK/89B7OFBJ4wSuxZywRiswioSjRMWARUz8HB
        JqApcWFyKUhYRMBAov/fHzaQmcwChxglev+eB5spLBAp8WjFdbBeXgFdiQ1rbkEtfsMo8WPz
        A6iEoMTJmU/AGpgFzCTmbX7IDLKAWUBaYvk/DpAwp4CbxPzDL5hBbFEBZYkD244zTWAUnIWk
        exaS7lkI3QsYmVcxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHhZbWDsY9qz7oHWJk
        4mAEup+DWUmEN/diabIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTEc0kqO9vA/x9czw4JQrrtmV9G/Npx18YouF/uYveh1U/fr8qqLz96zjXQJNn3xo
        2r9ye+L+STw7Sx13GzfNum7MXWji2Z1gX8JmuOme8EKt9DmflIXsd/6wXRvyveGOjFzMupPL
        3YUfhUx9lp7X/tvqweOHfZYV6y6eZwy8fX1X+tKyS5L/BLQk3rcxnqvf/siv6jCzRoPVqitW
        9itPV647ZLPm/qLMJ+vtfny+vHbX+6aVP5PD1rz9aFKRW3ttQ459vKDbp5W8X9btDxHdaCBv
        +aLzR6T9rxlnjx/9wObYuuhY3f2f1gJL327Z3JrCfSWx3CNqIs8tyz2l564bt3jI8Vys7pe+
        GF/zzDCBUVSJpTgj0VCLuag4EQD7cqZJ+QIAAA==
X-CMS-MailID: 20221117072457epcas5p38a61bb22518e7c7eb7b32077621b948a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116175159epcas5p4093dd66e85ed287cf9bd9acaec766aa3
References: <20221116171727.4083-1-git@augustwikerfors.se>
        <20221116171935.GA24524@lst.de>
        <CGME20221116175159epcas5p4093dd66e85ed287cf9bd9acaec766aa3@epcas5p4.samsung.com>
        <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 06:42:43PM +0100, August Wikerfors wrote:
>On 2022-11-16 18:19, Christoph Hellwig wrote:
>>On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>>>The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
>>>reports eui as 0001000200030004 when resuming from s2idle, causing the
>>>device to be removed with this error in dmesg:
>>>
>>>nvme nvme0: identifiers changed for nsid 1
>>
>>What EUI did it report before? Is the identifier stable after
>>multiple resume cycles?
>The original EUI is "002538e621b440e5". Using the patches from [1] and 
>[2] for debugging I consistently get this output on every resume:
>>eui changed from 002538e621b440e5 to 0001000200030004

Can you please share the firmware version of this SSD?

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_
Content-Type: text/plain; charset="utf-8"


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4e5e3_--
