Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B625BF94F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIUIbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIUIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:31:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691B783F24
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663749101; x=1695285101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zHH3l9X/HeKDiIlxUvCnVofaW7UU0Ddgo8IUIDEHFm8=;
  b=FZFiT9MhCaVknIYFduHoJvy6KLMJfFjiUt6x2+05P39t6eyJ/ezGmUoK
   /zQCU7Y2S+rL29b4Lo/dOUh0jPIt21RRA+YStQNxRT3+FIw0XMVGczevH
   BNo+riS1hMaKrvaM0JGQxJ4lNyJUZvHidG1thBoosGxHla33RW+MqLlri
   sVekqqfchCXi4J9w6fM6KmamQvAL/OhdjckJn73fdl/Q+hHVD+aFwY7WB
   mVKcll1xV6E3SkuWjscuWZZyn5iIlO8+VRhRO3+7/EEP204fp4jv/aGXM
   76nBqdWHCWQOZN/fvXe4vdK69KKew22GAyVwFENWxjAxCegBQn1Q0MXAm
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654531200"; 
   d="scan'208";a="217070743"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 16:31:40 +0800
IronPort-SDR: P5HwTgsk6y7noX5j4hZQ+4eqNrEHmsgZl19LSmlZu/E73D6X3ndP2TGcsTSUqiGMlJfuHJ/XD+
 oJ5D1hXat8vZPfQ59Bxa4QStlWYjyjbHdscwIhwjpqXRpNRjuWhru1aRdV6xZ3OpnwaKYKZZ/5
 6gIoU5lsM4qr2kUTEzZm72j+QesrEFxCxYK0CHT0qVbK8jtEBNM2ujsrHB4MC9FJEniB+AS+kF
 2mQk/9fdmCxyevMmsWSA8qx8VYAzGxSKxXcBfoa0djJA8axOqgOG+vUBl3n0rrVDUSMFdbk3vF
 y48wQlhTf2YR9iSRvM/VVRUT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 00:46:15 -0700
IronPort-SDR: 3JBTNzE6FR3AKViRE3ru4RbfUJkHgGgAG9DAB9JCOxdgkSHP1yz+PRWrQrVliCsmyWCoeLzqnv
 3oRbRe+cSGspDsEHFsmwRML2aZDWU96sT3eyBDrqTJeWR2G8Okn7aqQtQ67ygb95aXnwHI9rd9
 nM4QK5bVWqTOmhbTc4H79stxXy0tYpE4gMGSuAQ6Gv4BAArBQBKNrP3i3QUXRYwP+n195SxT1x
 jqgFuNa4hWyNy9pTEqaqxHnruD+uEo3gx5R8PYXveQ9AKeLPDqSN1YTDwwy+PKMejvSVe1smFE
 XgM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 01:31:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXWq00vXZz1Rwtl
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:31:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663749099; x=1666341100; bh=zHH3l9X/HeKDiIlxUvCnVofaW7UU0Ddgo8I
        UIDEHFm8=; b=VvnzQmWU3AGg18eE207Qi1bYY/Ua2gbMQ4FgrPIjMhEbyWZA49l
        Mp6QBsqwpXldrZydkb7KrdwdyWuQaAhhomOZOFDETBgA6FOWNQ7BMxrAr8OgL8Wd
        hp/u03Db2LT5FX9NJjrx6O5bvaxSc/EYvCyi8aZL2fQ7qDfJffJe3XSZM8HVEZZ2
        W8AishmXmMKN+1EItnoiGdJzwdH0JhwppGehy+uq+9bEZforwsPyHbFYiVn8fISL
        KjQJI7xXRSGpE4koNp4U+eiBFZUBaYuHJfazdQb6fpItPYYcVgn/vAWzTJknNko8
        Z5QOBvlqH+oFskI+IawBnCAbQYHQxH9FkLA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7ML1Oerhbnof for <linux-kernel@vger.kernel.org>;
        Wed, 21 Sep 2022 01:31:39 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXWpw1Tm4z1RvLy;
        Wed, 21 Sep 2022 01:31:35 -0700 (PDT)
Message-ID: <0aecdabb-0472-34d6-447f-6a292e802683@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 17:31:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 0/6] libata/scsi/libsas: Allocate SCSI device earlier
 for ata port probe
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <40b9e090-5ba3-1191-4fe9-80467284ae72@opensource.wdc.com>
 <0ae5000d-8e9a-da0f-b470-9f87f1b5e290@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0ae5000d-8e9a-da0f-b470-9f87f1b5e290@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 17:24, John Garry wrote:
> On 21/09/2022 05:04, Damien Le Moal wrote:
>> On 9/20/22 19:27, John Garry wrote:
>>> Currently for libata the SCSI device (sdev) associated with an=20
>>> ata_device
>>> is allocated when the port probe has completed.
>>>
>>> It's useful to have the SCSI device and its associated request queue
>>> available earlier for the port probe. Specifically if we have the
>>> request queue available, then we can:
>>> - Easily put ATA qc in SCSI cmnd priv data
>>> - Send ATA internal commands on SCSI device request queue for [0]. Th=
e
>>> =C2=A0=C2=A0 current solution there is to use the shost sdev request =
queue, which
>>> =C2=A0=C2=A0 isn't great.
>>> This series changes the ata port probe to alloc the sdev in the
>>> ata_device revalidation, and then just do a SCSI starget scan=20
>>> afterwards.
>>>
>>> Why an RFC?
>>> 1. IPR=C2=A0 driver needs to be fixed up - it does not use ATA EH por=
t probe
>>> =C2=A0=C2=A0=C2=A0 Mail [1] needs following up
>>
>> Yes. If IPR could be converted to ata error_handler, a lot of code can=
=20
>> be simplified in libata too.
>=20
> Hmmm... yeah, it would be good to see progress there.
>=20
>>
>>> 2. SATA PMP support needs verification, but I don't have a setup
>>
>> Port multiplier behind a sas HBA will be challenging to setup :)
>> I can try, but I will need to open up one of my servers and hook a=20
>> small PMP box to one of the pm8001 plugs. I may have the cables for=20
>> that... Let me check.
>=20
> I was more thinking of just AHCI with a port multiplier.

OK. I got confused :)
Easy then, my test box is all hooked up already.
Will give this a spin.

>=20
> As for SAS controllers, I don't think it's something to be concerned=20
> about. For a start, I know for sure that hisi_sas HW does not support=20
> port multipliers, and I don't think that pm8001 does either. In=20
> addition, libsas does not even support it - I did see a series in the=20
> scsi list from years ago (to support it), but it did not progress.
>=20
> Thanks,
> John

--=20
Damien Le Moal
Western Digital Research

