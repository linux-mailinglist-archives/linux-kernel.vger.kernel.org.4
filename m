Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725BA60F379
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiJ0JRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiJ0JRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:17:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D64DF85
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666862223; x=1698398223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q9/SkNOCAmP0U3/ZAegGPkz4MOkCYIOvnO9GX9L+WZ8=;
  b=TFwuJ/ejionPCAd+vMLdQerJfaIyENXKssyAoYoE80qNqP92Rkp/4GE0
   QLZz+eTKPk2n1g29rXrY38CQPWHzgaT1skbhFWaL+Z6HMAdl9jGF7atFW
   N8eoQMuTQAJ/6lnhY1kon7q2p/qFcStfDLqbQLAkcUBee9sIYosehgw9q
   gPuPdYNpFmi+dgl0GHh7LKJZD/VIVrf8Wt92OUJprpRY9uMFvuNHbWoFN
   zkTWicv0XNqDl9ABSbK9DryQ2wnwMF6jxWXUlL/MUbJ8JNQ4MKFSgyEB8
   LlaVGO7zqAujbXAAjCDCT561EcUtU9sEpPOULVBmcf5CWV95dIIuLIei6
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319187619"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 17:17:02 +0800
IronPort-SDR: uXVKas6n9oDQswkaorqahxSoKDVlLamJRwHZfQtNoPAWdwtSQNhsNwRfRMp8kZ/dHhO3osYFCS
 PBbj0f4fAKHBsl2zmabQI1Mamcib0v1QUxtId3e37/og1SITdI9qyxypx5GqZdfkxznZ6Pbu6Z
 4MQ06IbSq9lCGIi3FKzpaheXjuYzRThse6al6ckiAF0EdR8TObIxZ4oKFp315Z3fbwNJvwb40x
 cCmSmkqC0pUIpIs6c5iNpRoaFYoWJq6nv0akGBPSRdLqyrxG5gbhk4MYHagfpwnEtK26ptUIuX
 PPs9ydDlc0zs+HSZkaJLm/Wv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 01:30:41 -0700
IronPort-SDR: DSLb7OmacW2UMGVQgo1no/h4havuNbbP1f98CspQCJ6YfP+aH87oUdqI7w8QVg1+EOGZv7090Q
 zRcgMrSEsUfUPyjpkQZK/FFS/t8pquRAjrTu1ZTPf+2SkpQzI6VIKX8fg6SzCsyx5Rj/krOzvQ
 RVNwn4n606sxgbIm06dJSD2VQnZc+FeryMyvEBzEEBeY/bNfjnvXfFnElTcv5uItngDWKxDF4l
 Lt/undrFOpWc8Z4iHJ6z4pNq0DGfmamEphy3fiifwU2Y1yL9CDLVB/Gt3moIsojdCqxvsRTMQu
 p+w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 02:17:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Myg6k2GWFz1Rwtm
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:17:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666862220; x=1669454221; bh=q9/SkNOCAmP0U3/ZAegGPkz4MOkCYIOvnO9
        GX9L+WZ8=; b=mthPmqXvyern+Gs/hB6teVKMvC7h1852cNUqbGXGa7g2EqSHHIJ
        zavv2SVjhifKBStdR7a7OhG+pvap+Lx0qwP4wXlUw5fdjiM4xHWQ7dv1ibQJAJ8b
        aE/W0HPLvsfUrIXZkQvASgxDg36UTaMxxdx36kdFYXpJ9aaCQGunofpyyjMu+PQg
        UvNPotnuzorebyK/eNOdY+IDiRJL6Q1HG+HFA74HY1vv0VoF1MKbqiVNJwLDzP7d
        TWlDBBoCByt1u+RAvvrXDzwA/8N4uS9Qy8nnP6CYPqhvMnDGNRjXycZ5WlTmzUOd
        uWtT0ddUqUFN9CW0dJBt/XRFso+5tOM2qOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G9s_CTv9nTMc for <linux-kernel@vger.kernel.org>;
        Thu, 27 Oct 2022 02:17:00 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Myg6f00VXz1RvLy;
        Thu, 27 Oct 2022 02:16:57 -0700 (PDT)
Message-ID: <5417d401-6fb3-c1d7-58df-e24e0013cfb8@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 18:16:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 16/22] ata: libata-scsi: Allocate sdev early in
 port probe
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, bvanassche@acm.org, hch@lst.de,
        ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-17-git-send-email-john.garry@huawei.com>
 <6c0a4a75-786a-c946-57f2-c511bd765bcc@opensource.wdc.com>
 <d4535f4f-d9cf-30de-ce8c-9d8ee9c0decb@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d4535f4f-d9cf-30de-ce8c-9d8ee9c0decb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 17:11, Hannes Reinecke wrote:
> On 10/27/22 03:34, Damien Le Moal wrote:
>> On 10/25/22 19:18, John Garry wrote:
>>> Currently the per-ata device sdev is allocated as part of the scsi
>>> target
>>> scan, which is after the ata port probe.
>>>
>>> However it is useful to have the sdev available in the port probe. As=
 an
>>> example of an advantage, if the request queue is available in the pro=
be
>>> (which it would be if the sdev is available), then it is possible to =
use
>>> a SCSI cmnd for ATA internal commands. The benefit of this is then we
>>> can
>>> put the ATA qc structure in the SCSI cmnd private data. It will also =
be
>>> useful if we want to send ATA internal commands as requests.
>>>
>>> Export scsi_target_reap() so that it can be used to put the extra
>>> reference we get when allocating the sdev.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>> =C2=A0 drivers/ata/libata-eh.c=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 drivers/ata/libata-scsi.c | 23 +++++++++--------------
>>> =C2=A0 drivers/scsi/scsi_scan.c=C2=A0 |=C2=A0 1 +
>>> =C2=A0 3 files changed, 11 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 08e11bc312c2..1ed5b1b64792 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -3446,6 +3446,7 @@ static int ata_eh_schedule_probe(struct
>>> ata_device *dev)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ata_eh_detach_dev(dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ata_dev_init(dev);
>>> +=C2=A0=C2=A0=C2=A0 ata_scsi_setup_sdev(dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ehc->did_probe_mask |=3D (1 << dev->de=
vno);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ehc->i.action |=3D ATA_EH_RESET;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ehc->saved_xfer_mode[dev->devno] =3D 0=
;
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index efdba852e363..476e0ef4bd29 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -1109,7 +1109,12 @@ int ata_scsi_dev_config(struct scsi_device
>>> *sdev, struct ata_device *dev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev->flags & ATA_DFLAG_TRUSTED)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdev->security=
_supported =3D 1;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 dev->sdev =3D sdev;
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Put extra reference which we get when all=
ocating the starget
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * initially
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 scsi_target_reap(scsi_target(sdev));
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 @@ -4289,26 +4294,16 @@ void ata_scsi_scan_host(struct ata_por=
t
>>> *ap, int sync)
>>> =C2=A0=C2=A0 repeat:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ata_for_each_link(link, ap, EDGE) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ata_for_each_d=
ev(dev, link, ENABLED) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct scsi_device *sdev;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct Scsi_Host *shost =3D ap->scsi_host;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int channel =3D 0, id =3D 0;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (dev->sdev)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ata_is_host_link(link))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id =3D dev->devno;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel =3D link->pmp;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sdev =3D __scsi_add_device(ap->scsi_host, channel, id, 0,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 NULL);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!IS_ERR(sdev)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev->sdev =3D sdev;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ata_scsi_assign_ofnode(dev, ap);
>>
>> Is there something equivalent to what this function does inside
>> scsi_scan_target() ? I had a quick look but did not see anything...
>>
> Typically, the SCSI layer has two ways of scanning.
> One it the old-style serial scanning (originating in the old SCSI
> parallel model):
> The scanning code will blindly scan _all_ devices up to max_luns, and
> attach every device for which the scanning code returns 'OK'.
> The other one is to issue REPORT_LUNS and scan all LUNs returned there.
>=20
> Mapped to libata we would need to figure out a stable SCSI enumeration,
> given that we have PMP and slave devices to content with.
> To my knowledge we have ATA ports, each can have either a 'master' and
> 'slave' device, _or_ it be a PMP port when it can support up to 16
> devices, right?

yes

> Point being, master/slave and PMP are exclusive, right?

Never heard of pmp with ide cable :)

> So we can make the master as LUN 0, and the slave as LUN 1.

Yes, but isn't that a little wrong ? That would assume that the ata port
is the device and the ata devices the luns of that device. But beside
the "link busy" stuff that needs to be dealt with, master and slave are
independent devices, unlike LUNs. No ?

> And for PMP we can use each PMP address as LUN <pmp> + 1, and keeping
> the actual device as LUN 0.
>=20
> I think we can figure out whether it's a master/slave device setup
> upfront, so we should be able to set max_luns to '2' for these devices.
> For PMP-capable (or devices which _might_ be PMP capable), we could
> emulate the REPORT LUNS command, mapping on the PMP mechanism to figure
> out which devices are connected.
>=20
> Would that work?
>=20
> Cheers,
>=20
> Hannes

--=20
Damien Le Moal
Western Digital Research

