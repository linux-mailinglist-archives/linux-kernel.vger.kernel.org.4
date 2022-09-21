Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3435E56DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiIUX4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:56:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4AA0270
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663804561; x=1695340561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R6QuspugV33sv/Nyw/jFGeLxlZk7c4W6yvVLK3L2FAo=;
  b=n8G5PIO9AbbUuAV960+X8Vq3i8FbM8SETtmcD2r+PZ5JFN1f/FsHYtuU
   CBAZ780HwZTki8a9u200NfI7ZWeE/02YJYg2xr5KAi9cLjST4pQCS7pRj
   c3qMQYh7TVibIxXaeY3mjUM+HdxEBxuRW/R+vs99e+0dq1cOM0YkSDyQW
   vyaotRukOXmaBTGbFWuf31zzflybIdnmfNYTr6KaqRWc2LzhUVQV5EhQU
   OKOsO35uOUFrg7iHStqKWfzlZypchG8w3qsusrT4vPPRkW/ZUEKTmzq8Z
   4cu2GRbEePbcJv0HIPbdKIpOduElcALsyQhx2WK2S8Uu0XkUwip6p9piL
   g==;
X-IronPort-AV: E=Sophos;i="5.93,334,1654531200"; 
   d="scan'208";a="212393165"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2022 07:55:58 +0800
IronPort-SDR: naE7yTAt8uQg5ddrWJR9OqBlrLVncfyKU+Ai/nj1rrBvJc65klX1DyRMRTolrIorp8xJFaa8Zy
 pSpQy6qDupLxnp5mNW2G7m/l9TyvxOAp+d7sFsw8zY7mcidOz82LGY3B9++9B/NttjPLbUItyL
 acNZb4YenxnSxHe+jtJilgwiiHz2W+Mgly6Hw49dIOkAFR5W8JlIyLOPI7XjGyzpAxO1HPQWRr
 5qCfBtzLqG+c71aDzRnV4DkKh/cQpl2w4X+neGFADssAR+QBKw2A0T7BDWpJAMVIpkT3fBQA+m
 cAA5gN8xnffHjyv2Ve/Lr7Xr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 16:10:32 -0700
IronPort-SDR: VS2gT/0fTHfMFnN4Kr5/FyQLKpNs6tKjA9aZaJ7SX6rP+Msozx3G15pnd685xZK1FwT1z9iuEg
 c7lECi/WiFrSQtk4kbJUl0KWMTCCxr2PQVQyrWteTrdP2YRZsBjWrepFiyFT54bqoSwZY8vPFZ
 Z7xSoM04ZrRhgoYwdh1Hlp318gg73UWmBLYxWAndQ7rgrba+L3r5bzyKVPLT7SQRp4UKPo9SN4
 wFo0G3J4I5ZkY4t6wjFmcVRIplolJeOQ5hZLDzGxQP0HYiBYl6U2u5d5aCCDYw/0LRIajCrBs3
 s+M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 16:55:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXwKT5MdRz1RwvL
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:55:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663804554; x=1666396555; bh=R6QuspugV33sv/Nyw/jFGeLxlZk7c4W6yvV
        LK3L2FAo=; b=eNHxOBlVsoK+cUKCyD9rk9mD9UapAH8S50Gd/aF6G73xvEjiVFt
        IPahmf+oO/PfuDBsbPev/J9gy4p41ePyNN7c+o2/mYyRfizL5IHCu/hofli6rSP/
        X7m3nvMbNqPklHHZONhKe2aPHooH/Ri3nAtu8SYFpP0/lzyapsY9A0z0R2f5z79f
        N4wg1kGcM0kGtkYxKveO6fwtrE8KfBaNOwg9cEI429jNWkhytreX3pgs/WfiwAJ9
        askQpSeu44kr/gQRw7bPMi3D6YQOMll8FLIYvljLueSh/4KSAk3fWlmIS+CTmklT
        XyUJHKxgM4gbQ0Lq196ni2r5gA/K/iAQ9KQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SXfpmramXAvU for <linux-kernel@vger.kernel.org>;
        Wed, 21 Sep 2022 16:55:54 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXwKJ1tkpz1RvLy;
        Wed, 21 Sep 2022 16:55:47 -0700 (PDT)
Message-ID: <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
Date:   Thu, 22 Sep 2022 08:55:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
        bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
        matias.bjorling@wdc.com
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YytJhEywBhqcr7MX@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 02:27, Mike Snitzer wrote:
> On Tue, Sep 20 2022 at  5:11P -0400,
> Pankaj Raghav <p.raghav@samsung.com> wrote:
> 
>> - Background and Motivation:
>>
>> The zone storage implementation in Linux, introduced since v4.10, first
>> targetted SMR drives which have a power of 2 (po2) zone size alignment
>> requirement. The po2 zone size was further imposed implicitly by the
>> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
>> across chunks beyond the specified size, since v3.16 through commit
>> 762380ad9322 ("block: add notion of a chunk size for request merging").
>> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
>> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
>> to be non-power-of-2").
>>
>> NAND, which is the media used in newer zoned storage devices, does not
>> naturally align to po2. In these devices, zone capacity(cap) is not the
>> same as the po2 zone size. When the zone cap != zone size, then unmapped
>> LBAs are introduced to cover the space between the zone cap and zone size.
>> po2 requirement does not make sense for these type of zone storage devices.
>> This patch series aims to remove these unmapped LBAs for zoned devices when
>> zone cap is npo2. This is done by relaxing the po2 zone size constraint
>> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
>> == zone size.
>>
>> Removing the po2 requirement from zone storage should be possible
>> now provided that no userspace regression and no performance regressions are
>> introduced. Stop-gap patches have been already merged into f2fs-tools to
>> proactively not allow npo2 zone sizes until proper support is added [1].
>>
>> There were two efforts previously to add support to npo2 devices: 1) via
>> device level emulation [2] but that was rejected with a final conclusion
>> to add support for non po2 zoned device in the complete stack[3] 2)
>> adding support to the complete stack by removing the constraint in the
>> block layer and NVMe layer with support to btrfs, zonefs, etc which was
>> rejected with a conclusion to add a dm target for FS support [0]
>> to reduce the regression impact.
>>
>> This series adds support to npo2 zoned devices in the block and nvme
>> layer and a new **dm target** is added: dm-po2zoned-target. This new
>> target will be initially used for filesystems such as btrfs and
>> f2fs until native npo2 zone support is added.
> 
> As this patchset nears the point of being "ready for merge" and DM's
> "zoned" oriented targets are multiplying, I need to understand: where
> are we collectively going?  How long are we expecting to support the
> "stop-gap zoned storage" layers we've constructed?
> 
> I know https://zonedstorage.io/docs/introduction exists... but it
> _seems_ stale given the emergence of ZNS and new permutations of zoned
> hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
> still left wanting (e.g. "bring it all home for me!")...
> 
> Damien, as the most "zoned storage" oriented engineer I know, can you
> please kick things off by shedding light on where Linux is now, and
> where it's going, for "zoned storage"?

Let me first start with what we have seen so far with deployments in the
field.

The largest user base for zoned storage is for now hyperscalers (cloud
services) deploying SMR disks. E.g. Dropbox has many times publicized its
use of SMR HDDs. ZNS is fairly new, and while it is being actively
evaluated by many, there are not yet any large scale deployments that I am
aware of.

Most of the large scale SMR users today mainly use the zoned storage
drives directly, without a file system, similarly to their use of regular
block devices. Some erasure coded object store sits on top of the zoned
drives and manage them. The interface used for that has now switched to
using the kernel API, from libzbc pass-through in the early days of SMR
support. With the inclusion of zonefs in kernel 5.6, many are now
switching to using that instead of directly accessing the block device
file. zonefs makes the application development somewhat easier (there is
no need for issuing zone management ioctls) and can also result in
applications that can actually run almost as-is on top of regular block
devices with a file system. That is a very interesting property,
especially in development phase for the user.

Beside these large scale SMR deployments, there are also many smaller
users. For these cases, dm-zoned seemed to be used a lot. In particular,
the Chia cryptocurrency boom (now fading ?) did generate a fair amount of
new SMR users relying on dm-zoned. With btrfs zoned storage support
maturing, dm-zoned is not as needed as it used to though. SMR drives can
be used directly under btrfs and I certainly am always recommending this
approach over dm-zoned+ext4 or dm-zoned+xfs as performance is much better
for write intensive workloads.

For Linux kernel overall, zoned storage is in a very good shape for raw
block device use and zonefs use. Production deployments we are seeing are
a proof of that. Currently, my team effort is mostly focused on btrfs and
zonefs and increasing zoned storage use cases.

1) For btrfs, Johannes and Naohiro are working on stabilizing support for
ZNS (we still have some issues with the management of active zones) and
implementing de-clustered parity RAID support so that zoned drives can be
used in RAID 0, 1, 10, 5, 6 and erasure coded volumes. This will address
use cases such as home NAS boxes, backup servers, small file servers,
video applications (e.g. video surveillance) etc. Essentially, any
application with large storage capacity needs that is not a distributed
setup. There are many.

2) For zonefs, I have some to-do items lined up to improve performance
(better read IO tail latency) and further improve ease of use (e.g. remove
the O_DIRECT write constraint).

3) At the block device level, we are also working on adding zoned block
device specifications to virtio and implementing that support in qemu and
the kernel. Patches are floating around now but not yet merged. This
addresses the use of zoned storage in VM environments through virtio
interface instead of directly attaching devices to guests.

> To give some additional context to help me when you answer: I'm left
> wondering what, if any, role dm-zoned has to play moving forward given
> ZNS is "the future" (and yeah "the future" is now but...)?  E.g.: Does
> it make sense to stack dm-zoned ontop of dm-po2zoned!?

That is a lot to unfold in a small paragraph :)

First of all, I would rephrase "ZNS is the future" into "ZNS is a very
interesting alternative to generic NVMe SSDs". The reason being that HDD
are not dead, far from it. They still are way cheaper than SSDs in $/TB :)
So ZNS is not really in competition with SMR HDDs jere. The 2 are
complementary, exactly like regular SSDs are complementary to regular HDDs.

dm-zoned serves some use cases for SMR HDDs (see above) but does not
address ZNS (more on this below). And given that all SMR HDD on the market
today have a zone size that is a power of 2 number of LBAs (256MB zone
size is by far the most common), dm-po2zoned is not required at all for SMR.

Pankaj patch series is all about supporting ZNS devices that have a zone
size that is not a power of 2 number of LBAs as some vendors want to
produce such drives. There is no such move happening in the SMR world as
all users are happy with the current zone sizes which match the kernel
support (which currently requires power-of-2 number of LBAs for the zone
size).

I do not think we have yet reached a consensus on if we really want to
accept any zone size for zoned storage. I personally am not a big fan of
removing the existing constraint as that makes the code somewhat heavier
(multiplication & divisions instead of bit shifts) without introducing any
benefit to the user that I can see (or agree with). And there is also a
risk of forcing onto the users to redesign/change their code to support
different devices in the same system. That is never nice to fragment
support like this for the same device class. This is why several people,
including me, requested something like dm-po2zoned, to avoid breaking user
applications if non-power-of-2 zone size drives support is merged. Better
than nothing for sure, but not ideal either. That is only my opinion.
There are different opinions out there.

> Yet more context: When I'm asked to add full-blown support for
> dm-zoned to RHEL my gut is "please no, why!?".  And if we really
> should add dm-zoned is dm-po2zoned now also a requirement (to support
> non-power-of-2 ZNS devices in our never-ending engineering of "zoned
> storage" compatibility stop-gaps)?

Support for dm-zoned in RHEL really depends on if your customers need it.
Having SMR and ZNS block device (CONFIG_BLK_DEV_ZONED) and zonefs support
enabled would already cover a lot of use cases on their own, at least the
ones we see in the field today.

Going forward, we expect more use cases to rely on btrfs rather than
dm-zoned or any equivalent DM target for ZNS. And that can also include
non power of 2 zone size drives as btrfs should normally be able to handle
such devices, if the support for them is merged. But we are not there yet
with btrfs support, hence dm-po2zoned.

But again, that all depends on if Pankaj patch series is accepted, that
is, on everybody accepting that we lift the power-of-2 zone size constraint.
> In addition, it was my understanding that WDC had yet another zoned DM
> target called "dm-zap" that is for ZNS based devices... It's all a bit
> messy in my head (that's on me for not keeping up, but I think we need
> a recap!)

Since the ZNS specification does not define conventional zones, dm-zoned
cannot be used as a standalone DM target (read: single block device) with
NVMe zoned block devices. Furthermore, due to its block mapping scheme,
dm-zoned does not support devices with zones that have a capacity lower
than the zone size. So ZNS is really a big *no* for dm-zoned. dm-zap is a
prototype and in a nutshell is the equivalent of dm-zoned for ZNS. dm-zap
can deal with the smaller zone capacity and does not require conventional
zones. We are not trying to push for dm-zap to be merged for now as we are
still evaluating its potential use cases. We also have a different but
functionally equivalent approach implemented as a block device driver that
we are evaluating internally.

Given the above mentioned usage pattern we have seen so far for zoned
storage, it is not yet clear if something like dm-zap for ZNS is needed
beside some niche use cases.

> So please help me, and others, become more informed as quickly as
> possible! ;)

I hope the above helps. If you want me to develop further any of the
points above, feel free to let me know.

> ps. I'm asking all this in the open on various Linux mailing lists
> because it doesn't seem right to request a concall to inform only
> me... I think others may need similar "zoned storage" help.

All good with me :)

-- 
Damien Le Moal
Western Digital Research

