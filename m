Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF95E7DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiIWPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiIWPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:09:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7A1704E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:09:38 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220923150935epoutp0489aff483db1444ec7db654804967c12b~Xhd3Vscs01108311083epoutp04D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:09:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220923150935epoutp0489aff483db1444ec7db654804967c12b~Xhd3Vscs01108311083epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663945775;
        bh=njEDpC5oeJPSNhSYmRD3X20OTsya0gdbEZd6SkCmRhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uJPfFpABAk7bmBkYXfyptGpLMG20TcvFAPdYiUybsUdvuSBN2t742M1HTydtbNFK6
         C/4RFK7KzpmPvOFjJUqafKFLTwojXXErquX72Ksa99hc8YzaH1SmJiZtJIkvP4P2Q9
         aykFRD8qY/DcA7vU7OfuknGq1bId5tDKNDD9ZlOs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220923150934epcas1p45e25c0a20a62821e1d61b90921f684cd~Xhd2p94c-3133331333epcas1p4i;
        Fri, 23 Sep 2022 15:09:34 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.232]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MYwY92pV2z4x9Ps; Fri, 23 Sep
        2022 15:09:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.EE.51827.D2CCD236; Sat, 24 Sep 2022 00:09:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220923150932epcas1p260522873fcf003b821a0d88211e7fec2~Xhd1DxUPn0139301393epcas1p2O;
        Fri, 23 Sep 2022 15:09:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220923150932epsmtrp256a0228c003e923fecf04979080ba55e~Xhd1C-2Ak1039410394epsmtrp2f;
        Fri, 23 Sep 2022 15:09:32 +0000 (GMT)
X-AuditID: b6c32a36-17bfa7000000ca73-09-632dcc2dbc64
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.66.18644.C2CCD236; Sat, 24 Sep 2022 00:09:32 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220923150932epsmtip20a8a5da2fe887c335cf636f1c3cd3cc2~Xhd0yniwQ1911719117epsmtip2U;
        Fri, 23 Sep 2022 15:09:32 +0000 (GMT)
Date:   Sat, 24 Sep 2022 00:09:32 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        ogabbay@kernel.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 01/13] trinity: Add base driver
Message-Id: <20220924000932.689c44f37abecb153175ed8b@samsung.com>
In-Reply-To: <51275e33-c791-4593-84d1-eedad27d7fd6@www.fastmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmga7uGd1kgzubBC3+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKCrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5
        xaV56Xp5qSVWhgYGRqZAhQnZGZ+eN7EVLOCo6DuxkK2BcTNbFyMnh4SAicTigxPYuxi5OIQE
        djBKPPh0jRHC+cQo8fnqbDYI5zOjxPz9u9lhWv5eaWKGSOxilJiw6wUThNPBJLF01XFGkCoW
        AVWJ7rf7WUFsNiB75ow1YN0iAsoSv35MYgVpYBb4wyjRt28LWEJYwExiwtSZYDavgKPEpc4F
        LCA2p4CLxNfZXYwQqy0k7vasAGrmAKoRlPi7QxgkzCwgL7H97RywiyQEpnJIvJyzjRmi3kVi
        XctOqE+FJV4d3wL1gpTE53d7oeLZElM6FrFA2AUS555vZQaZLyFgLHFxRQqIySygKbF+lz5E
        haLEzt9zGSHW8km8+9rDClHNK9HRJgRRoiSx5M9hqEUSElNnfGOCsD0kll89xAIJqrdMEvem
        32CewKgwC+GZWUiemYWweAEj8ypGsdSC4tz01GLDAiN4BCfn525iBCdSLbMdjJPeftA7xMjE
        wXiIUYKDWUmEd/YdzWQh3pTEyqrUovz4otKc1OJDjKbAqJnILCWanA9M5Xkl8YYmlgYmZkbG
        JhaGZoZK4rwNM7SShQTSE0tSs1NTC1KLYPqYODilGpiKzcT4r9Z9KF26a+eFHeYFd8rN95yd
        YP4h4pJjvHDNne31Ztuz5/y44L5e6omC17fIbj4hv0yNe+tlZVcLHGdYctU6Z3vZnDIf/pAl
        h+JVvz7TNM76/Sjax0B026pmZS1pze4t+X2fP7FdXvDMpSngy6vZXZUzyxoU3tg0i5SrrF7T
        lnPBSnfn7Th2gaqFX19OXMVgL6jv4sX1xnXWtR9LzpyZuXxXPIPxAb2Zud3TDU49CDbZ8bBh
        fdKd9oLfz6r3fF75+9q3rw/fvVZRWCjzXjC3RsVkdtn+c/OuPl5zPYg7oqn+fgKTRsU194ks
        GZzxZVcWdlr9Kfn9sl4w5XrOlW0KU/J3fgyV3dD/8bucEktxRqKhFnNRcSIAwF87Gi0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvK7OGd1kg3k/FS3+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MT8+b2AoWcFT0nVjI1sC4ma2LkZND
        QsBE4u+VJuYuRi4OIYEdjBJPVnyASkhIbLq3HCjBAWQLSxw+XAxR08Yk0dX6gwWkhkVAVaL7
        7X5WEJsNyJ45Yw07iC0ioCzx68ckVpAGZoE/jBLvO54ygSSEBcwkJkydCVbEK+AocalzAdgg
        TgEXia+zuxghNrxlkrg3/QYzxBUWEnd7VrCCXMErICjxd4cwSJhZQEvi4a9bLBC2vMT2t3OY
        JzAKzkKomoWkahaSqgWMzKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjREtrB+Oe
        VR/0DjEycTAeYpTgYFYS4Z19RzNZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp
        2ampBalFMFkmDk6pBqaAxbUvlqpbHJ21RFK87Xv2w6PmUyraXl09qdfh8XuddvHvN3+btsoa
        cy6Wboj4WZKS7cFvUzUlgn/n7BN1Sh5cxx+qWaUvqpzYvPH/52Mdnzqnun6ee6j70qxvGkdm
        Suj47PcNuntX5cl8liTWSq+Ua4eeqUkkF0d+lpoQ1fBYmEvQQP3DVhmmrZlOJieYX2de+rXA
        L2t2qO+P41Lrzv3KPF6nZf7gt3t5qearU67Zx3Z+WJTg8cPDSCNiT41Mbdw2LtHoSeKPOw8X
        3TVMCv9yb0V+7rENBoct5uaf3z3bo+dg78NW99cXKnRjhJcWewrq8t3RqIxIjb3ykYX/Q6lz
        wr/alWuP/p635pHfbB0lluKMREMt5qLiRACva9QdAAMAAA==
X-CMS-MailID: 20220923150932epcas1p260522873fcf003b821a0d88211e7fec2
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
        <20220917234918.8b94d2690b8533bd47cf64e0@samsung.com>
        <51275e33-c791-4593-84d1-eedad27d7fd6@www.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 15:56:51 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Sat, Sep 17, 2022, at 4:49 PM, Jiho Chu wrote:
> > On Sat, 17 Sep 2022 09:41:13 +0200
> > "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> 
> >> If you have the need to manage multiple devices here, maybe use
> >> a dynamic major number and have the chardev code allocate the
> >> minor numbers, instead of using multiple misc devices and
> >> doing that yourself.
> >> 
> >
> > I'm little confusing. It means that managing own char devices is proper,
> > not using misc device? But, it's still under misc dir.
> 
> There is no strict connection between miscdevices and drivers/misc.
> 
> The former is for drivers that tend to have only one instance
> in a system, while the latter is for drivers that do not have
> a separate subsystem.
> 
>      Arnd
> 

Thanks for the clarification. Allocating a dynamic major could be better
for trinity, which could have multiple instances.
I'll rewrite code for it in next revision.

Best regards,
Jiho chu

