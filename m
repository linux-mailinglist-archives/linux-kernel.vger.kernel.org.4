Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E265BB1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIPR5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIPR5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:57:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF6A6C77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:57:31 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220916175727euoutp02022ddbd9268bbf3a5d478332660c18aa~VaPcTw1Qc2770927709euoutp02O
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:57:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220916175727euoutp02022ddbd9268bbf3a5d478332660c18aa~VaPcTw1Qc2770927709euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663351047;
        bh=k7hjlb6AiF7jh1iuh9LKDhE7ZOyrX7xUup0+nfGc/5s=;
        h=Date:Subject:From:To:CC:In-Reply-To:References:From;
        b=D+pdMVtQ8bxrwLYytL7X0K38R6vQ6LW1kOJce7HKao8/VYbNAFSktF9XgHWQj+T64
         N+2a6A7LZc0Yfwkx5PsFLdFOLbjJwo4Pdwot/C9gbWMEw3XRZb4FK/r4R/2mLiIOTf
         yvjurKXfcWX+oR5Zl5xkbAKy/PfXwLDouzruhZx8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220916175727eucas1p29f8779dd295b1870898730a928a1732e~VaPbzdcPJ0630006300eucas1p2i;
        Fri, 16 Sep 2022 17:57:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B3.EC.29727.709B4236; Fri, 16
        Sep 2022 18:57:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220916175726eucas1p2b96d3dda893b1e3b47e0ae4f22da13d5~VaPa0z9ck0629506295eucas1p2x;
        Fri, 16 Sep 2022 17:57:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220916175726eusmtrp20aec6fd837cb9c97323960623fd98cb1~VaPaz9JkG2811228112eusmtrp2i;
        Fri, 16 Sep 2022 17:57:26 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-45-6324b9075764
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.B7.07473.609B4236; Fri, 16
        Sep 2022 18:57:26 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220916175725eusmtip282c3befede6e547a184672cacca605db~VaPanlpJO0439104391eusmtip2m;
        Fri, 16 Sep 2022 17:57:25 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.192) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Sep 2022 18:57:21 +0100
Message-ID: <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
Date:   Fri, 16 Sep 2022 19:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v13 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <hch@lst.de>, <agk@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <linux-nvme@lists.infradead.org>, <pankydev8@gmail.com>,
        <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>,
        <bvanassche@acm.org>, <gost.dev@samsung.com>,
        <dm-devel@redhat.com>, <hare@suse.de>, <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
In-Reply-To: <e42a0579-61b2-7b77-08cb-6723278490cc@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.192]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djPc7rsO1WSDQ6f4rBYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbklbtG38yugg6HH5irfHzll32T0uny312LSqk81j85J6j903G9g8
        drbeZ/V4v+8qUOh0tcfnTXIe7Qe6mQK4o7hsUlJzMstSi/TtErgyGrfFF2xgqbg+LaGBcTVz
        FyMnh4SAicSF31tZuhi5OIQEVjBKXFnyCcr5wiixu20LG4TzmVGi51ATI0xLz4w5jBCJ5YwS
        +6/8Zoer2tWznBXC2c0o8enwC3aQFl4BO4mbZ98zgdgsAqoSM7/dZoKIC0qcnPmEBcQWFYiU
        WLP7LFi9sEC2xMFrm8AuZBYQl7j1ZD5QPQcHm4CWRGMnO4gpAjTm1jQXiIr9zBL98yxAbE4B
        e4l9Gy4wQcQ1JVq3/2aHsOUltr+dA/WzssTMm1Oh7FqJtcfOsEPYjzglNrVZgIyXEHCR2Nkc
        BxEWlnh1fAtUiYzE/53zmSDsaomnN34zg3wrIdDCKNG/cz0bRK+1RN+ZHIgaR4mGaT+ZIcJ8
        EjfeCkJcwycxadt05gmMqrOQgmEWkndnIXlgFpIHFjCyrGIUTy0tzk1PLTbMSy3XK07MLS7N
        S9dLzs/dxAhMiaf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8Kp6qiQL8aYkVlalFuXHF5XmpBYf
        YpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYJK1vHtb8uOdE7m/Ledwej2dFbBxUQHT
        nNOB2/9Pz4pSkSitr5vjIfjox66JDtHSp1WKTL5Vxfoz7eeO6fvxaGJabP/7ILc7Ch+S3D8v
        /v2Mw1Iy+qOT4GKGq2snfn958eS6MqHm+XnGFWkhU/yYZkU3zVVwXlQu+JnVs/TG3jW6lq/1
        7TmmOWTbn5h17EtE/uwKxyz5x1rxOpPWH2tViJaovvVD+di6loC4++v+LPl/ZOFJE4uZvtE7
        LgX0GNpvdLG62r/j9fzEq028vas1u1dwRrwKElfx3MBTxJIk3LOQ75I0c27P/M+W/iuao5Oi
        2zTvcTM9PjX7VFjj/rdf77ZYn9r/2j6kPem58rJWUSWW4oxEQy3mouJEAEG+Xgj4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xe7psO1WSDd69ZLVYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbklbtG38yugg6HH5irfHzll32T0uny312LSqk81j85J6j903G9g8
        drbeZ/V4v+8qUOh0tcfnTXIe7Qe6mQK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQyGrfFF2xgqbg+LaGBcTVzFyMnh4SAiUTPjDmMXYxcHEIC
        Sxkl1i1dywqRkJH4dOUjO4QtLPHnWhcbRNFHRomFuxayQzi7GSVOLL3EBlLFK2AncfPseyYQ
        m0VAVWLmt9tMEHFBiZMzn7CA2KICkRIPlzWBxYUFsiUOXtsEdgazgLjErSfzgeIcHGwCWhKN
        newgpgjQmFvTXCAq9jNL9M+zgFg7kUni34E7YGs5Bewl9m24wARRpCnRuv03O4QtL7H97Ryo
        L5UlZt6cCmXXSry6v5txAqPoLCTXzUJyxSwko2YhGbWAkWUVo0hqaXFuem6xoV5xYm5xaV66
        XnJ+7iZGYDLZduzn5h2M81591DvEyMTBeIhRgoNZSYRX1VMlWYg3JbGyKrUoP76oNCe1+BCj
        KTCIJjJLiSbnA9NZXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD
        0542hevvdr8ydz6+61fYTyfWvYalBXcjfgXLprX/WZmizajYcbPOID2kdeeyp5u9/IJCJZo3
        iWQWPzpvN8vFX+V8VOKqmFPdLDv5DRJ2pi+e/cQh/sDK96r9v8W0FxwwdZ6ffdwsJln056vV
        C8JibDeu5pDamlGTlZImHu0gtr3rh9vjumXrozwqj8vE7/C0aGdvOu9YpdkmuefI/Yynju/m
        mZxI2PVy0d1cnjl1yf3VUv2OK969DokssnuQdizg2N1DE2IPe1meaVR/+DQqfrXz7dPtDkY5
        uab/f35pbftTfEd3ZpHLmVtuQREnn4jf/b1apaZI+aRw8F3FalcjzetPU64ZTEnzPZytWfxU
        iaU4I9FQi7moOBEAgMk2La8DAAA=
X-CMS-MailID: 20220916175726eucas1p2b96d3dda893b1e3b47e0ae4f22da13d5
X-Msg-Generator: CA
X-RootMTR: 20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5@eucas1p2.samsung.com>
        <20220912082204.51189-14-p.raghav@samsung.com> <YyIG3i++QriS9Gyy@redhat.com>
        <e42a0579-61b2-7b77-08cb-6723278490cc@samsung.com>
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Are you certain you shouldn't at least be exposing a different
>> logical_block_size to upper layers?
>>
> To be honest, I tested my patches in QEMU with 4k Logical block size and on
> a device with 4k LBA size.
> 
> I did a quick test with 512B LBA size in QEMU, and I didn't see any
> failures when I ran my normal test suite.
> 
> Do you see any problem with exposing the same LBA as the underlying device?
> 

Do you see any issues here? If not, I can send the next version with the
other two changes you suggested.

Thanks,
Pankaj
