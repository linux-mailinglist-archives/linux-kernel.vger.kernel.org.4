Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B16515BF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiLSW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLSW7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:59:13 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077C111178
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671490752; x=1703026752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nBOnBM2AbYb8rMTgdV7VKM1gSLrZ9214921NLXhZivI=;
  b=F7pCc8TxoNQXJedG2BsSB2L2vsjFLULKuWlzoENUxM0tUsN2Wr/5lrOO
   vrIZNSjOd5lKxQUME0JbogU+lWcZ/jIthYfmV9MtiD7xuojkpU1RlYcQS
   N9JeI1w5qDD9+irbCADLpYLR3oy2j+nnwbwf1STbkE8lmzriZLJj8YL4/
   Uo0Th8K6YRr92CA2pJ21KzC4FPeIRKE8DSU7IRxTWGghFIJlz5ILM+oCB
   WfpxCo1TYB5Oy16leQj8C5Ci6uUVeW+DlNifCtF1z/uH2kcNwfQLXGJq6
   iu7ZRDMz8+xDtZ/qkG/cE/rs9smfpyGQv1l+rALf44cliI31IyPxxiXIT
   A==;
X-IronPort-AV: E=Sophos;i="5.96,257,1665417600"; 
   d="scan'208";a="219253042"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2022 06:59:11 +0800
IronPort-SDR: B3rUsuGDL+R5XU1NQDUvQzdUu/qKUzWrmgGBjY+3lErpSYkc21VigrKTeKrdup847pXXqv8GkD
 S/ZFQnIuCwJtYNJYoElwBO9EN8gIvee1XW0jyQB4MvKDh43fdfDSOlFtWIazLFNH/OM2WNsqU0
 vPoBpgCVj+bq+mnTjevdPHdmDdFJUjKnuz6JzIv3kwgnQNEdY8scPlvl58P2Lj4D1J7fMjp1Gg
 ZIIW+dWDbajlbZciNSt1Hog9/CJnV1ItAk58OV2G2Pm3zieO8IHSCGgOBvY729fWpFyyVswgg8
 yHU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2022 14:17:27 -0800
IronPort-SDR: QFVI1SyqF4jTnTSN2VrRp7XsZU7ZLWEvqSxx4drW+Jz1HnM3gjDQZY0SV0wPNshQkZIGuInkEz
 JSC0aIYMxZMf5L41SwYGvMhglBBoUEPfKdsv08sO2JYiyASRTz3NEoImpZIbYy0gBG73OQfb4A
 yS788awr2f6FTbUi/KUPmn9MAdoNm5OMK/gFRag6bnfGZyClAqMG2Ffg3dPcgNHlzlRVzdIkNK
 cdQRES1ZIRgAl4JrD6T4r58qNMi1+Zhb4FpQdKGAmnfpq4ogxnaFDQuX2bZI45UAPK+aDS4CtL
 lGM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2022 14:59:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NbZrt5ZTZz1RwvT
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:59:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671490749; x=1674082750; bh=nBOnBM2AbYb8rMTgdV7VKM1gSLrZ9214921
        NLXhZivI=; b=Dtvc58csZf+Jy7BMgd54A35CyniVwl59EYZIhYNurtF/xBMu56w
        aSTwVhUJdfeY3rAyGpVaB3hf7kgh7USFI3c46nN5rRB81SThKZXvLW3BhR74A2yo
        xJqNAvKRADNFIncenxq/iSiE/HDaR+PD+NUxUcvuz23qpVsNHj9xf5yUSr1svTIE
        /PFTMPuI4JQ52cBlgVkWaUR4m7dTE6p/b0kSS5Ao/HAXqHmdujvImuxkEynuNcrm
        XuiYsFa1kpKYrieFAA0JSUr3HG8j+/H/VRtQRtKHJeNLQq/aLs0pCaXJmEs2pGQQ
        fW+DnOs3HkX5ULaM/N7q4GNTB/NoBJAkK/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id svnSvSTB-aBJ for <linux-kernel@vger.kernel.org>;
        Mon, 19 Dec 2022 14:59:09 -0800 (PST)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NbZrq4hc6z1RvLy;
        Mon, 19 Dec 2022 14:59:07 -0800 (PST)
Message-ID: <234e04db-7539-07e4-a6b8-c6b05f78193d@opensource.wdc.com>
Date:   Tue, 20 Dec 2022 07:59:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-ide@vger.kernel.org,
        hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 00:28, Jason Yan wrote:
> On 2022/12/19 17:23, John Garry wrote:
>> On 16/12/2022 10:03, Xingui Yang wrote:
>>> If the ATA device fell off, call sas_ata_device_link_abort() directly=
 and
>>> mark all outstanding QCs as failed and kick-off EH Immediately. This=20
>>> avoids
>>> having to wait for block layer timeouts.
>>>
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>> ---
>>> Changes to v1:
>>> - Use dev_is_sata() to check ATA device type
>>> =C2=A0 drivers/scsi/libsas/sas_discover.c | 3 +++
>>> =C2=A0 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_discover.c=20
>>> b/drivers/scsi/libsas/sas_discover.c
>>> index d5bc1314c341..a12b65eb4a2a 100644
>>> --- a/drivers/scsi/libsas/sas_discover.c
>>> +++ b/drivers/scsi/libsas/sas_discover.c
>>> @@ -362,6 +362,9 @@ static void sas_destruct_ports(struct asd_sas_por=
t=20
>>> *port)
>>> =C2=A0 void sas_unregister_dev(struct asd_sas_port *port, struct=20
>>> domain_device *dev)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 if (test_bit(SAS_DEV_GONE, &dev->state) && dev_is=
_sata(dev))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sas_ata_device_link_abort=
(dev, false);
>>
>> Firstly, I think that there is a bug in sas_ata_device_link_abort() ->=
=20
>> ata_link_abort() code in that the host lock in not grabbed, as the=20
>> comment in ata_port_abort() mentions. Having said that, libsas had=20
>> already some dodgy host locking usage - specifically dropping the lock=
=20
>> for the queuing path (that's something else to be fixed up ... I think=
=20
>=20
> Taking big locks in queuing path is not a good idea. This will bring=20
> down performance.

With HDDs ? You will not see any difference (and SATA SSDs are not a thin=
g
anymore, enough that we should worry too much. NVMe took over). And that
"big lock" is libata is really an integral part of the design. To remove
it, you will need to rewrite libata entirely...

>=20
>=20
>> that is due to queue command CB calling task_done() in some cases), bu=
t=20
>> I still think that sas_ata_device_link_abort() should be fixed (to gra=
b=20
>> the host lock).
>=20
> For sas_ata_device_link_abort(), it should grab ap->lock.

Which is what libata code comments (mistakenly in many places) always
refer as host lock.

>=20
> Thanks,
> Jason

--=20
Damien Le Moal
Western Digital Research

