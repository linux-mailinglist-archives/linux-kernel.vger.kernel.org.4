Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62925B8F37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiINTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiINTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:16:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB93D8287C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:16:39 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220914191634euoutp0263d4a2ee028d446d73d16b44817630df~U0B88vZC40310003100euoutp02h
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:16:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220914191634euoutp0263d4a2ee028d446d73d16b44817630df~U0B88vZC40310003100euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663182995;
        bh=ybgLp9AM+jxatL7OJOF20wcIYaSKEdwWOvPMbm2oBTU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=d004FnXNA0bakbll66O+fyaleJdcZ2xmZSDGBh3bLK8zddaWSylqQpKwpGxTp6hRQ
         +zhDhzjUFz6OI2sYlLqNX8g8dQOHVMxoetqJ6XrBX3VZkcG1v9vJju0r9549YCRV5+
         HlYQY4RbRaqEljEtjK69PPsZsUtyddSvoq9GR2Ik=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220914191634eucas1p1cf5b4ecb952a15dfc537688c908269a7~U0B8hWI_J1511815118eucas1p1r;
        Wed, 14 Sep 2022 19:16:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 35.A8.07817.29822236; Wed, 14
        Sep 2022 20:16:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220914191634eucas1p2a45bbf2def4de9892a2be10ac1dbf9f0~U0B8LBDtD2516825168eucas1p2K;
        Wed, 14 Sep 2022 19:16:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220914191634eusmtrp186e492d3798a7679a64cd166315ebf94~U0B8HD3T12885828858eusmtrp15;
        Wed, 14 Sep 2022 19:16:34 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-29-632228926819
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.5A.10862.19822236; Wed, 14
        Sep 2022 20:16:33 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220914191633eusmtip2e0cc3b377eff18a4ddbfd661eb461652~U0B76ya3t2784627846eusmtip2Y;
        Wed, 14 Sep 2022 19:16:33 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.192) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 14 Sep 2022 20:16:31 +0100
Message-ID: <e42a0579-61b2-7b77-08cb-6723278490cc@samsung.com>
Date:   Wed, 14 Sep 2022 21:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v13 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <hch@lst.de>, <agk@redhat.com>, <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <linux-nvme@lists.infradead.org>, <pankydev8@gmail.com>,
        <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>,
        <bvanassche@acm.org>, <gost.dev@samsung.com>,
        <dm-devel@redhat.com>, <hare@suse.de>, <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YyIG3i++QriS9Gyy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.192]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7qTNJSSDZZNkbZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbklbtG38yugg6HH5irfHzll32T0uny312LSqk81j85J6j903G9g8
        drbeZ/V4v+8qUOh0tcfnTXIe7Qe6mQK4o7hsUlJzMstSi/TtErgyJq9/zF4wT6Ri1cm1LA2M
        3QJdjJwcEgImErOPf2PrYuTiEBJYwShx7MwuJgjnC6PEj5fnWSGcz4wS/TuWMsK0LLz3DKpl
        OaPE36OX2UESYFWNO0MhEruBZs37DNbBK2AnMW1OE5jNIqAqcfz4FTaIuKDEyZlPWEBsUYFI
        iTW7z4INEhbIljh4bRMziM0sIC5x68l8oJs4OESAem9Nc4EI72eW6J9nARJmE9CSaOwE6+QE
        MtdfX8IEUaIp0br9NzuELS+x/e0cZoj7lSVm3pwKZddKrD12hh3kZAmBZ5wSPX8PQT3pInH8
        1lwoW1ji1fEt7BC2jMTpyT0sEHa1xNMbv5khmluAIbRzPRvIQRIC1hJ9Z3IgahwlGqb9ZIYI
        80nceCsIcQ+fxKRt05knMKrOQgqIWUgenoXkhVlIXljAyLKKUTy1tDg3PbXYKC+1XK84Mbe4
        NC9dLzk/dxMjMDGe/nf8yw7G5a8+6h1iZOJgPMQowcGsJMLbF6KQLMSbklhZlVqUH19UmpNa
        fIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoEp5OEcB94n0lHR/4tfzZzgtex0k9TM
        OQFXzGc55sdPYMqeOCPMY/sBDo1PtmfFz89Q+SDSe9ixY2K21YuaQvazV3WM966fJJLEs+eU
        fgXDgZRU3igJwV1ip/Mru9niuVarLm/rcXsT0aDudsPv/1f1FcHthf++3ROdyDwheMe5xWW6
        GZa/Xq+eqcc347feTzsuf5cFt5l+dR9iOzHLd2KE/XYrY0aOUzeXsaRbf2u49G5XiZJQe4Dg
        FO6LRZ9tg5q1OB1tGESXX0mwLV4TfLZmgcvGqpc93jwZuXVvLp5OrnpyP/xbKV/fBPuZqb59
        BXWWmnGyay9dTLHIjkrIelGWlVS1c0q5pC0vY1XYTSWW4oxEQy3mouJEACla5g/7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xe7qTNJSSDc4IWqw/dYzZYvXdfjaL
        aR9+Mlv8Pnue2aK1/RuTxd53s1kt9iyaxGSxcvVRJosn62cxW/ztugeUuKVtcXnXHDaL+cue
        sltMaPvKbLHm5lMWixO3pC3aNn5ldBD0uHzF22PnrLvsHpfPlnpsWtXJ5rF5Sb3H7psNbB47
        W++zerzfdxUodLra4/MmOY/2A91MAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
        sVZGpkr6djYpqTmZZalF+nYJehmT1z9mL5gnUrHq5FqWBsZugS5GTg4JAROJhfeesXUxcnEI
        CSxllDh+5ykrREJG4tOVj+wQtrDEn2tdUEUfGSX2XDvHCOHsZpQ4MP8DE0gVr4CdxLQ5TYwg
        NouAqsTx41fYIOKCEidnPmEBsUUFIiUeLmsCqxcWyJY4eG0TM4jNLCAucevJfKA4B4cIUO+t
        aS4Q4f3MEv3zLCB23WGUuPTjDwtIDZuAlkRjJ9hxnEDm+utLmCDqNSVat/9mh7DlJba/ncMM
        8YCyxMybU6HsWolX93czTmAUnYXkullIrpiFZNQsJKMWMLKsYhRJLS3OTc8tNtIrTswtLs1L
        10vOz93ECEwn24793LKDceWrj3qHGJk4GA8xSnAwK4nw9oUoJAvxpiRWVqUW5ccXleakFh9i
        NAUG0URmKdHkfGBCyyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRq
        YCorNRVcPO1eyaW/qsXFO34K7p+bsr/9dHjc2+m9PCvZhPVzr0a4J78+rNCd2Md3SjfCcTGn
        ln3tmrmf6jp1hT/+ZOP4H3V2Z+7hSOudHDLbhQ7PmDOxbYp9JLOpqsm+o1vrb8094C3FKuC5
        nYM9TLPQ5dtk65kms11nFSYeLruucmbOEYut9Qe27dDbXcCUa+dUN+XCCqt3c+88+BNW3vr3
        y6kGg4cNcTPME0+fvmMUs2uxwEc2AdZ6dt6PrcvvNfqqXOl/7Lrtud4mW9nZp6xmmhZFRyrf
        n33XImthRfysokUN007sOd56aBXrLTmFmkyhPrYiyeSpN8s+7V3zs4anzEth9gwV1gmhB9Oz
        limxFGckGmoxFxUnAgBKA+adsAMAAA==
X-CMS-MailID: 20220914191634eucas1p2a45bbf2def4de9892a2be10ac1dbf9f0
X-Msg-Generator: CA
X-RootMTR: 20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5
References: <20220912082204.51189-1-p.raghav@samsung.com>
        <CGME20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5@eucas1p2.samsung.com>
        <20220912082204.51189-14-p.raghav@samsung.com> <YyIG3i++QriS9Gyy@redhat.com>
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>> +
>> +	return 0;
>> +}
> 
> The above error paths need to unwind the references or any other
> resources acquired before failing.  Please see other targets for how
> they handle sequencing of the needed operations (e.g. dm_put_device)
> in the error path by using gotos, etc.
> 

Ok. That makes sense, and it should be pretty straight forward to do that.

>> +
>> +static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
>> +{
>> +	struct dm_po2z_target *dmh = ti->private;
>> +
>> +	limits->chunk_sectors = dmh->zone_size_po2;
>> +}
> 
> Are you certain you shouldn't at least be exposing a different
> logical_block_size to upper layers?
> 
To be honest, I tested my patches in QEMU with 4k Logical block size and on
a device with 4k LBA size.

I did a quick test with 512B LBA size in QEMU, and I didn't see any
failures when I ran my normal test suite.

Do you see any problem with exposing the same LBA as the underlying device?

>> +
>> +static void dm_po2z_status(struct dm_target *ti, status_type_t type,
>> +			   unsigned int status_flags, char *result,
>> +			   unsigned int maxlen)
>> +{
>> +	struct dm_po2z_target *dmh = ti->private;
>> +	size_t sz = 0;
>> +
>> +	switch (type) {
>> +	case STATUSTYPE_INFO:
>> +		DMEMIT("%s %lld", dmh->dev->name,
>> +		       (unsigned long long)dmh->zone_size_po2);
>> +		break;
> 
> Wouldn't it be worthwhile to expose the zone sectors (native npo2 vs
> simulated po2?) You merely roundup but never expose what you're using
> (unless I'm missing something about generic "zoned" device
> capabilities).
>

BLKREPORTZONE ioctl is typically used to get the zone information from a
zoned block device, which should expose the npo2 zone sectors(zone
capacity) in this case.

But I do see the value of exposing the dmh->zone_size instead of
dmh->zone_size_po2 as the latter can be easily calculated from the former
or it can be retrieved by reading the chunk_sectors. I will fix that up.


> Mike
> 
