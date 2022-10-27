Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA860F380
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiJ0JSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiJ0JS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:18:26 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB333E00
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666862304; x=1698398304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kvLAXbtC50g6ZzyI4fPHRtBiFei4HcUvRqhE6dQ7SAY=;
  b=Y/evegBwXXmne3YQKstvtLknwmrngoIeJmHATT9z50ruGIoxgDpF2y1g
   rpPQuHXr65tKWTKlHzqiUGSatgP7B+tmT+LB/XQDpdhjFycCL5OamyV/E
   jfWEJGfBHVVwnlBpfQYMn3uha1A7vyxVU9xxFHEpsxGNb+uk8yJY/vfSH
   6U9SUUBLp2DC2uB8kZiKZ6uZdwHVdrO2gKvILJrtUKM+I3SyZVRM5O33B
   WaYfjU+ziAbenU14HUfCz7YmD+B9RNMcd439igUyyV+/j4ZvD4VqFSxtP
   otHFN4ulJnUyNDrTYgh2P+h3+sbZs6Zn7mc8EGuwezmWGWn7+ypGRH+FG
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319187707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 17:18:23 +0800
IronPort-SDR: YWFBql/ZExPNuTZ3rMnCldOfYG+zPhuLY3MnDdlNJsoWxlCAGPnNWXYko+D31f47rfxRxt+l+t
 5Zu37AJ1elyequeWWUPb7X8uM09nU1fI2n4mWej+EzbkvbLYUL+8CJWjQhsGbJ+vgqWVmQwO2t
 S48jkEh3Xzd2JYVdlfFyXykXzWgPVdMLdRqZBzjdWWtIjw7unLiozlpQUPIRWZAnqeELM8c5jN
 xTNsT8B7yw7sibwKXEVekrvdYb+ZE4Np5Sq3ZFbx69gSahh+e4gc1/diZJ6wSKx6oEAM2K3q9l
 GwGWorA/mTOgocKrhksg8rVC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 01:37:43 -0700
IronPort-SDR: 3Cc93bYZoyUVo2K/NAX1idkZNI2rL3xHeEM4d4Pdth26gdYYqEhQL1Zvrd7TIu46Mqz5bWW/BQ
 zFprfbp4EKUNRkSU6XmK7GoZciLvB9JbsG1dxu3L3mZfYnm/PInbf23ObRwY23D/S2ZCUms4os
 VmYIk+qMqrUzYOpXHYZbfbx4SCP1+KOV8QIwXXdKSPIFRI7xNbJISqnlZqGxTtuTZPfdmw+X7j
 9RBeWxoruzmaiDoUamhM0ZZLvsUipxEe9C/J3s4euef69hp4oaj24Fa0nZTwzBcCeWnc2jvQx3
 cNY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 02:18:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Myg8G00Ggz1Rwt8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:18:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666862300; x=1669454301; bh=kvLAXbtC50g6ZzyI4fPHRtBiFei4HcUvRqh
        E6dQ7SAY=; b=FF28ulx/sZ2DShKxKICmthkjOStRutL/PHIMQJpOMFQm1DxB0X0
        Sn72UimYGywoe8Do+Vtxucn5eDw3gTl2keRDFUUAZWWRAg2JuNZs/GuCcT/JCWB5
        mo00urhbRkb0n9feEdJvJRpoxdZta8OvBhyLWO3+cCfzML4RNrln1keXBYjBnMK9
        NaTf17qHuLidD6x+8j+nI8AnThO6PvpHDYucrXhqT1efi/1G3gJETCJmH7qJTh5D
        nuWRBZR3AUvRcTfUT1HRTk0ua68qSC5wT1GFPC0qGQgmWZEOIB98vsataqX+2Ses
        +ilKVGVYXN/5R6NUPjXRa9WOQrqwkgRN5lg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GwtNpZBXUy-A for <linux-kernel@vger.kernel.org>;
        Thu, 27 Oct 2022 02:18:20 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Myg8C0F9dz1RvLy;
        Thu, 27 Oct 2022 02:18:18 -0700 (PDT)
Message-ID: <b9a287ad-6234-1bb6-3f20-3e019b6be879@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 18:18:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 04/22] scsi: core: Add support to send reserved
 commands
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-5-git-send-email-john.garry@huawei.com>
 <c30e421e-9652-ebb8-9733-b286cb0f9f19@opensource.wdc.com>
 <76fe5007-5c53-9cdf-7c57-6af7ebaf8c97@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76fe5007-5c53-9cdf-7c57-6af7ebaf8c97@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 18:13, John Garry wrote:
> On 27/10/2022 02:21, Damien Le Moal wrote:
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (blk_mq_is_reserved_rq(rq)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct scsi_device *sdev =
=3D cmd->device;
>> This variable is not really needed. You can call:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi_device_unbusy(cmd->dev=
ice, cmd);
>>
>> No ?
>=20
> ok, your suggestion is good
>=20
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi_mq_uninit_cmd(cmd);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi_device_unbusy(sdev, =
cmd);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __blk_mq_end_request(rq, =
0);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&cmd->eh_entry);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&cmd->device->iodone=
_cnt);
>>> @@ -1718,6 +1728,21 @@ static blk_status_t scsi_queue_rq(struct
>>> blk_mq_hw_ctx *hctx,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_status_t ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int reason;
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (blk_mq_is_reserved_rq(req)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(req->rq_flags & RQF=
_DONTPREP)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D scsi_prepare_cmd(req);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (ret !=3D BLK_STS_OK)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out_dec_host_busy;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eq->rq_flags |=3D RQF_DONTPREP;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
lear_bit(SCMD_STATE_COMPLETE, &cmd->state);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_start_request(req)=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return shost->hostt->rese=
rved_queuecommand(shost, cmd);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(cmd->budget_token < 0);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>>> index 91678c77398e..a39f36aa0b0d 100644
>>> --- a/include/scsi/scsi_host.h
>>> +++ b/include/scsi/scsi_host.h
>>> @@ -73,6 +73,7 @@ struct scsi_host_template {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * STATUS: REQUIRED
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (* queuecommand)(struct Scsi_Host =
*, struct scsi_cmnd *);
>>> +=C2=A0=C2=A0=C2=A0 int (*reserved_queuecommand)(struct Scsi_Host *, =
struct
>>> scsi_cmnd *);
>> Nit: This op name sound like something returning a bool... May be a
>> straight "queue_reserved_command" name would be clearer ?
>=20
> or queuecommand_reserved ? I'm just trying to have the name a variant o=
f
> "queuecommand".

I figured that :)
queuereservedcommand ? (hard to read...)
queuecommand_reserved is OK I guess.

>=20
>>
>=20
> thanks,
> John

--=20
Damien Le Moal
Western Digital Research

