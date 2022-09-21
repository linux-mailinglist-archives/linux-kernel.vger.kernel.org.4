Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA35C0551
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIURdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiIURdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:33:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2E0A1D67
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:32:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220921173250euoutp01a28ac2779ed94690f71ebbf7f14c1498~W8IXipzj03068430684euoutp01O
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:32:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220921173250euoutp01a28ac2779ed94690f71ebbf7f14c1498~W8IXipzj03068430684euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663781570;
        bh=3Ci10O2BVi/HktN0SRzO4buCtgT/msmMdQxBp8IfR8Y=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=jFi1QKww3b6OGjZPqJJFuVmrch3IxUK9rBO4jjLJafGHkWikJOOUb7TDJvenuAiM5
         lB1cu5h5/F/WW4RQQK/3drIjzlIfwFi9VibTd+eu1vEpgAaKr6hJnxBynJJg9x3Cdo
         WnEewb/A/jYp6lE29W6DyYDM5aNQDwYRPafSeiZw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220921173249eucas1p205c67c6120e3314a1324332e3c725528~W8IWuikMW0485404854eucas1p2f;
        Wed, 21 Sep 2022 17:32:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 52.87.19378.1CA4B236; Wed, 21
        Sep 2022 18:32:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220921173248eucas1p23403baa578aa335747fb8a62145a577f~W8IWL9LNd0562805628eucas1p2p;
        Wed, 21 Sep 2022 17:32:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220921173248eusmtrp1119dd3978522ddbd060337edcc92edd2~W8IWLHoqA1591515915eusmtrp1V;
        Wed, 21 Sep 2022 17:32:48 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-1a-632b4ac1bb46
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.7B.10862.0CA4B236; Wed, 21
        Sep 2022 18:32:48 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220921173248eusmtip2825416e5fdc058383a65eb9819720136~W8IWAmJkC2186421864eusmtip20;
        Wed, 21 Sep 2022 17:32:48 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.192) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Sep 2022 18:32:46 +0100
Message-ID: <fc7d88a5-f65b-3962-22e5-cc393535d66d@samsung.com>
Date:   Wed, 21 Sep 2022 19:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v14 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>, <bvanassche@acm.org>,
        <pankydev8@gmail.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <jaegeuk@kernel.org>, <matias.bjorling@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <Yys9sTqCIzxVFwyX@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.192]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87oHvbSTDT4c4rNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWqxcfZTJ4sn6WcwWf7vuAcVuaVtc3jWHzWL+sqfsFhPa
        vjJbrLn5lMXixC1pi7aNXxkdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddZfP4vEnOo/1AN1MAVxSXTUpqTmZZapG+XQJXRsuJSSwFLcIVt+9MYGxgbOHvYuTkkBAw
        kTh3bgtbFyMXh5DACkaJXSv3s0I4XxglGpdeYoJwPjNK9De/ZINpWTHnMSOILSSwnFHiw2E/
        uKKPPxrYIZzdjBJ91zYAdXBw8ArYSbSvkAVpYBFQlXi29BgTiM0rIChxcuYTFhBbVCBSYs3u
        s+wgtrBAtsSrC9PAFjALiEvcejKfCWSMCFDvrWkuIOOZBQ4xS6xrew0WZxPQkmjsBGvlBDIP
        vvzKAtGqKdG6/Tc7hC0vsf3tHGaI+5UlZt6cCmXXSqw9dgbsZAmBR5wSv873QD3pInG28yQj
        hC0s8er4FnYIW0bi9OQeFgi7WuLpjd/MEM0twBDauR7sXwkBa4m+MzkQNY4S565uYocI80nc
        eCsIcQ+fxKRt05knMKrOQgqJWUg+noXkhVlIXljAyLKKUTy1tDg3PbXYOC+1XK84Mbe4NC9d
        Lzk/dxMjMA2e/nf86w7GFa8+6h1iZOJgPMQowcGsJMI7+45mshBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFethlayUIC6YklqdmpqQWpRTBZJg5OqQamlun7tzMdF9oxaYZZlnzYkncdod/m51V4
        btu54+2p8HLrC/f1+m8cyV7kUf/64ErVmdM4PlbOWHdi7buJX/JCe5s/zrTh+c+qsE/0PMec
        FbLrivoPG/rPlYpk/PvX9ON79eveJ+ICjqpMcWt71qJ8qO+Wg4OT5ocSle2rWt4VXA1bV6nE
        7To/6L7O7KDo+6bikmaGVzeZTIrN5j8vs+Bj+7PuWWKiJR/C/H7PeHr/QHDXVLEwhnWMXR9F
        hPr0Io9c+3Rm3Y5Hro4zb2e/0WZyPz+L52T43CDr3t5rr5X4BBYtFb9kMvGfnfyzb0oBx53F
        T002eWetZXX6i/La3zLe1xand6/zYL2v13Odq+THCSWW4oxEQy3mouJEAGmuP8jyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsVy+t/xe7oHvLSTDX62aFisP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLVauPspk8WT9LGaLv133gGK3tC0u75rDZjF/2VN2iwlt
        X5kt1tx8ymJx4pa0RdvGr4wOAh6Xr3h77Jx1l93j8tlSj02rOtk8Ni+p99h9s4HNY2frfVaP
        9/uusnl83iTn0X6gmymAK0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvo+XEJJaCFuGK23cmMDYwtvB3MXJySAiYSKyY85ixi5GLQ0hgKaPE3et/
        WSESMhKfrnxkh7CFJf5c62KDKPrIKPH+6FVmCGc3o8S2B/OAqjg4eAXsJNpXyII0sAioSjxb
        eowJxOYVEJQ4OfMJC4gtKhAp8XBZE1hcWCBb4tWFaYwgNrOAuMStJ/OZQMaIAPXemuYCMp5Z
        4BCzxLq210wQu+4xSmzufc0GUsQmoCXR2Al2HCeQefDlVxaIOZoSrdt/s0PY8hLb385hhnhA
        WWLmzalQdq3Eq/u7GScwis5Cct4sJGfMQjJqFpJRCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl
        5+duYgSmj23Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeGff0UwW4k1JrKxKLcqPLyrNSS0+xGgK
        DKOJzFKiyfnABJZXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cDk
        K6PW+rD/4XSJvANHuOwzNaXkbr7S3JDJtf/hrVPCPDPYJ+bsMw1WvSDQeC5+CY8MG+NbVXmH
        61PmGh2YlWG83Id5c5/T/IgPBeHzrVifWz9ZbClnPPdAmInT4XD7yLTfoQoszSsjNlUcWp3t
        dC5Yys8yo1bwBsOPJZ/LuA6GZbcVuf9+9+yJX6ZlTrEDm9TWD5rNLT2fTzqdZF66bkPY8o65
        qaFs5mm55REn4s7UND6c2pY+a+fKtUxGoTKpEV1K/35nvRA+89IzWdv5tGP1P5fpXq4z9FO4
        nt1/rjybeUKB+PHXLkd9tPkj395alNSYwGN6O2PJ9OWvNl7fPuVxR1eq1R33f3tu8xlmPVBi
        Kc5INNRiLipOBAATeEQ9qAMAAA==
X-CMS-MailID: 20220921173248eucas1p23403baa578aa335747fb8a62145a577f
X-Msg-Generator: CA
X-RootMTR: 20220920091134eucas1p275585b70fab48ba1f19eb5d2cc515b6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091134eucas1p275585b70fab48ba1f19eb5d2cc515b6d
References: <20220920091119.115879-1-p.raghav@samsung.com>
        <CGME20220920091134eucas1p275585b70fab48ba1f19eb5d2cc515b6d@eucas1p2.samsung.com>
        <20220920091119.115879-14-p.raghav@samsung.com>
        <Yys9sTqCIzxVFwyX@redhat.com>
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +/*
>> + * This target works on the complete zoned device. Partial mapping is not
>> + * supported.
>> + * Construct a zoned po2 logical device: <dev-path>
>> + */
>> +static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>> +{
>> +	struct dm_po2z_target *dmh = NULL;
>> +	int ret;
>> +	sector_t zone_size;
>> +	sector_t dev_capacity;
>> +
>> +	if (argc != 1)
>> +		return -EINVAL;
>> +
>> +	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
>> +	if (!dmh)
>> +		return -ENOMEM;
>> +
>> +	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
>> +			    &dmh->dev);
>> +	if (ret) {
>> +		ti->error = "Device lookup failed";
>> +		goto bad;
>> +	}
>> +
>> +	if (!bdev_is_zoned(dmh->dev->bdev)) {
>> +		DMERR("%pg is not a zoned device", dmh->dev->bdev);
>> +		ret = -EINVAL;
>> +		goto bad;
>> +	}
>> +
>> +	zone_size = bdev_zone_sectors(dmh->dev->bdev);
>> +	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
>> +	if (ti->len != dev_capacity) {
>> +		DMERR("%pg Partial mapping of the target is not supported",
>> +		      dmh->dev->bdev);
>> +		ret = -EINVAL;
>> +		goto bad;
>> +	}
>> +
>> +	if (is_power_of_2(zone_size))
>> +		DMWARN("%pg: underlying device has a power-of-2 number of sectors per zone",
>> +		       dmh->dev->bdev);
>> +
>> +	dmh->zone_size = zone_size;
>> +	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
>> +	dmh->zone_size_po2_shift = ilog2(dmh->zone_size_po2);
>> +	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
>> +	ti->private = dmh;
>> +	ti->max_io_len = dmh->zone_size_po2;
>> +	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
>> +	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
>> +	return 0;
>> +
>> +bad:
>> +	kfree(dmh);
>> +	return ret;
>> +}
> 
> This error handling still isn't correct.  You're using
> dm_get_device().  If you return early due to error, _after_
> dm_get_device(), you need to dm_put_device().
> 
> Basically you need a new label above "bad:" that calls dm_put_device()
> then falls through to "bad:".  Or you need to explcitly call
> dm_put_device() before "goto bad;" in the if (ti->len != dev_capacity)
> error branch.
> 

Ah. I naively assumed dtr will be called to cleanup but not in this case as
the ctr itself fails.

I will add an extra label on top of `bad` and use it for errors that
happens after `dm_get_device`. Thanks for pointing it out Mike.
