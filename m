Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FCD5EDD90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiI1NRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiI1NRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:17:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2BB7391D;
        Wed, 28 Sep 2022 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664371056; x=1695907056;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TqqRxorbrrXPyzEErTjmB+PhKQymZUKomze1VCzLHrU=;
  b=ELsFM0BYgUr9kvV+9TuFoxe/RH/d/BgWsyGCGU7+SZCmVVwcHx4yLtLE
   1vzKXqea/8m6Kpq0ze/UywND5VlgtT0A5tY8KfRQ74tSl17x4DccL5OBm
   W5ClW1vZe19HGlB+8p1ioEtwigJZBS+WNc4hGMMRDIczxhv/vU01QuJVm
   9mAPSTWDSMrqIkSBVRto7Yhv7BPk8NCZ2m7lMtKSO776OGWvKb2Y5kSt1
   mv8n89JTgV1yLGPI7TSu8WhnIAmsyuG6pMM4haMS74zpnde/bxilSvNkM
   T315LcJl9kNGH8j4jxaZXWfIiu48rj5SPHdUYecUtCc3J9B+n3Nws4Jt9
   A==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654531200"; 
   d="scan'208";a="212491779"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 21:17:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Wx01We9fN1+tv5oCbIALtseewMm+SZa5L6fup/zDUQoFIw5E38o3VXCF3IIJTScq76MeocwE5J7A0Rjso7FU1CKT6gnQS32ecPai/PUmAzeD8t/8w7rGLFOWCBbor4YArp5ZC4pCGGGiQwpUCUszUszNEhPEMFxu74vWGZNdyfeZZFvPGX04yhqFLbJOnksd6Fmnh1L3FI0OpYzt3+6MLagvFNvDMQtMrb9DsVFlXkpu7Nl9A+hER5Ehl5yD8Uq+ySD5ap4GtLbrusGK4SNq+5En1Z2AiWUhHYXXye4YVCeCSS4uXMcKp9WcwtBglkVhOFflXj9sybK9qRoA3DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aCVQXnTEw58iDSaRJUF0X3TMKqQKzFV2SYIh0n8AGI=;
 b=UZqYt7tzAhGSCLczs2ErD0DHDFu3+RSDMgaU+oB/IPqIT33QCmykX0inA+Z8QLbaz/eCb3bZcboBHnm5L3gIFyVMca5/XDjDSCAr9z8ZnILedmHGbLyO2UhRI/yN3fqdsuF+ckkQFSi5kSAmwKHVtKxiRFXI+57EhUc2XtusRIJQ1Jb3jy1LDg2YKAVtmmIZBO57dSiIRQNRg8S2r0SzWYJzW3PQ21rkiS2jmRoU8FpYf26gydCi4BWyv2b2lzAaJV0HP+omJl6Ia8jMw36nLM4OY67CryDO0VOhS0FZZBgs244+HUUL26a9QFrTsfGY8wcVpte3m0r8Y/m6TKkhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aCVQXnTEw58iDSaRJUF0X3TMKqQKzFV2SYIh0n8AGI=;
 b=y9yPCpoNO9n5kNsQAwyIVvvEP9Yqs4fr/abnFuYAlKhqsMXdU++F8KialiNyJttVox017hL0qrfYiSAWIYtR3eLzaxMjAEVew7rvGSnL7yQ2M6vMeCH4YC/usL41Zs6E6xmftvL7wp8RDwjTroXmYNMFwFeXuGJcoVimMDjc8Sc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5711.namprd04.prod.outlook.com (2603:10b6:208:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Wed, 28 Sep
 2022 13:17:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 13:17:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     John Garry <john.garry@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "ipylypiv@google.com" <ipylypiv@google.com>,
        "changyuanl@google.com" <changyuanl@google.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
Thread-Topic: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
Thread-Index: AQHY0zapIGo+Met9mEGqTMQhhuqFnw==
Date:   Wed, 28 Sep 2022 13:17:31 +0000
Message-ID: <PH0PR04MB74164CE477846FFDB843D5419B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5711:EE_
x-ms-office365-filtering-correlation-id: 3e50e74c-67c5-4790-7a35-08daa153ccb1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQY7HUp88/s3+2EYcDknP4yFW3RfNWRRMRhEVc+ot6LSr5p5zUJmQ7WJZrSMtIACkIRS/C13slYxYGPKbGZWzbQQOOoy+7OB3QOvQZIde9Ojzyl9WqJYRKl3J/tgvxFb8yX0JvjYBUujB6EX+IXF8/DznvV1FBY4JTxP83bnUNbO0fwJ81oQh+/hMMHuGDnmQS71RXZTvH4uj+Ytp1IiAdGJ5mC+sDRDmhmfVa1QNtd/SIHmDUJpF1oTW1pf5Gt9q3m8gN3DeiNKPeB0x5fFmUe/oo39tgNaoElrZSu5qs079MA0Nqv2GJTnKVGgkQfTQjksAPIJxFLX+LbHyMCbtfZMHsYdBBDTgw4AZ/I+eBJyghilf2FOsPuxA+wiGskwRyp+JrapKb5H5lr0pMdVQl2l/oileA55TM1W/hBE1gESV4w3aAfWchUV0dYJubUxukphi5t0CZquApbM9oEWneMpd1c/Cl3rO0fqx0+Y723uctETDCm5lAnmA7sHlBBVohr1aJE/kYa38u590mcs3n5M507DocGkdH2tHvpuo0TFxnaV8lO/R9fSYTcLtz2Jm86tu3BfbRanm9Oc1Pv9TzMmj4Bthwx+kteUbYmF3YmYPWu7LBx1Ps7myx7TN9BIkVS/3/lYKdeAMDqGx3Rjdc9PBH70L6rtlYKuI+5t1I0B8EtzggmXv/I79vVN9jQSJNODV1LZus2PNgI+mVH4LoYhDGR7l6wIgQRGXS06pkVbg5gPaotlszDqye3Xwb68FY5dLz6NMReKCpyxG5drPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(83380400001)(71200400001)(38100700002)(110136005)(54906003)(4326008)(66556008)(33656002)(64756008)(66946007)(66446008)(8676002)(316002)(7416002)(76116006)(122000001)(53546011)(478600001)(91956017)(66476007)(186003)(55016003)(41300700001)(5660300002)(82960400001)(2906002)(8936002)(86362001)(6636002)(6506007)(52536014)(38070700005)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z/4ntsQOGCJ9rrUKXzvLM6X9pCjdovXlndRGylt1kYY57t+20MLYbsl1tYMe?=
 =?us-ascii?Q?CdfbcRSqO5aotPn3izOclr8cCoeTWAGylxffupi1NHgFUHTxqB/PhepH0Ijv?=
 =?us-ascii?Q?VLHG7yudCHkJPfEVHSt9kVpTSaWPX7wz9XfCdX6oRCRsxmfou1fK3OGx7+Gm?=
 =?us-ascii?Q?XATDSepG6h6t2gDznJpHSkefPVl7vA5BJQcf6G9Cp/coMLf6AGWEGoyKhhC0?=
 =?us-ascii?Q?P6UAFkg2MYeAtBois7atJ2cPvC/6PKv+QpXoR6nJsOauJlRltHIX+1FDSwVS?=
 =?us-ascii?Q?kiEfHQvc1nSVgd8fItkpkJoazdA1A+rJ4rajlfltOcNown8WKnkjDcwJLVdK?=
 =?us-ascii?Q?xDxNa8/F8rxdyrQ4dgJj1UYl8c82QXVSf5ny3eA1i4hyMANSCL+/r6V7NrT6?=
 =?us-ascii?Q?QI+kD3ByqTqbn+1Oh2l64GpqKbE82p7xAJdLc0zkyuGNpE/ZvtLwXWenLjJV?=
 =?us-ascii?Q?83LXDHT8Fp9xttobsEtPHIYrr4pdZvdLCeG3RI0Kk3hcqePKqKOpaXeIcWbv?=
 =?us-ascii?Q?QaVcn8VSwRn27QAa/H04053xOP+HOORvP2sULutHTB/8Ho58P+Ss3Hs5PlZb?=
 =?us-ascii?Q?FitRyqiv+yOGfhnhREpzVkl3viJsxaxtGDnFaPx5TipSQ1BcBMoymej9tvpt?=
 =?us-ascii?Q?aKx4pmNY014sa0m62SJ5Q25uYqenrDL0BprEEAdaSOWIZi81TfVrE4OkDff7?=
 =?us-ascii?Q?qWsrKaaVSmKI5wqCcwSN2VxZMwLWKNG1vzNCViPAH8tbD4DAe9ojECxHU7x/?=
 =?us-ascii?Q?4UBRd11yertUxbLJyw1SSpxsVwiFe+AgwjpZEEtif+Bn+1ZDxy9pOfoQ5PQW?=
 =?us-ascii?Q?tSDZ5i5I43cYLBH++jYvbd6+P+ZhEnJHWj3mELkqs+1jZPG5KcYXUehfBEQW?=
 =?us-ascii?Q?MtfDGXNmxefKTvXHC3+wBNMxJL2Z7dtZgcK5z3z8CD8sSNYiV6qafmafiE/t?=
 =?us-ascii?Q?DZM0azY2Envsf6QsQC8yqv79uPC/WRXpIPaW/MpFfbuPzna7JwKj1iokLuyW?=
 =?us-ascii?Q?HvZOCep0LORPv0mTu9fZqZSzTm4UU0GD/LPwjl/l9QM19CztSs7ZwgiqRGr9?=
 =?us-ascii?Q?SmD7yBX7YdNlRocxoG5Tj698B5WVxYQT1wwpILgfuTTw/e9W0XAP+dThPmY/?=
 =?us-ascii?Q?L7BLD9ECgs33nViiYWo3UH5x0kBakRjV1+/vBWk0u06/jXdWHE2gs5G4Up93?=
 =?us-ascii?Q?59wptl0zkEfJ+7p0to2Lebn84GhNitLDQAk8lO3Yfl0zW0kU3XqYbylKsRO0?=
 =?us-ascii?Q?vAWcAFZx6LlWAEtUcwsdNbudpEUQSCf2aLjJsvjpwzjkGEzm5WZxWaVSwVBl?=
 =?us-ascii?Q?4ftzeyGilpoFv3E24LCt16A62modQZjDQDTjPyqSGLrtBZ8pEkNj2ThVa91B?=
 =?us-ascii?Q?0X6Bzn3a908ZSx16OK4ipvzJJY0rISfCo+MWLoaBE/P012ICQ6dJRlb7g13H?=
 =?us-ascii?Q?EcsyYlxjRZguxTT/TVVOSozioiFe8L8ZKyRYrZ2ONOPXwnb/Lb4mSRV3ef+N?=
 =?us-ascii?Q?5FS5YlBIPhQOOH6Xjoa4LLM2HPEVJEw+pipkIVeSEcGXOjqH4jvaBOAjzKOU?=
 =?us-ascii?Q?rqOtjc1/R+N1jYgxDScsF5R5ARpWE7jm4ijtTda4cK4oRgMrDRh7/1AQ9Mzn?=
 =?us-ascii?Q?yio5VSVb7tA4KQLwxpLbDMebaPTZ0izhcYIGXhAFcAkK0iipv0rtSc+f1/15?=
 =?us-ascii?Q?2bSPwCNW+3wupfNneozfIg1J8aI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e50e74c-67c5-4790-7a35-08daa153ccb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 13:17:31.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GrbS6TEh7IuO0REs5kVhG4e4MCCO2zdba3tidrrAzUH8aGGjr1dgIWkqYmD3bEEwzfsQEUv8jjRj4hFiQQp9sF+v0y5O4cqu1ZdN+NYeJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5711
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.22 14:34, John Garry wrote:=0A=
> blk-mq already provides a unique tag per request. Some libsas LLDDs - lik=
e=0A=
> hisi_sas - already use this tag as the unique per-IO HW tag.=0A=
> =0A=
> Add a common function to provide the request associated with a sas_task=
=0A=
> for all libsas LLDDs.=0A=
> =0A=
> Signed-off-by: John Garry <john.garry@huawei.com>=0A=
> ---=0A=
>  include/scsi/libsas.h | 22 ++++++++++++++++++++++=0A=
>  1 file changed, 22 insertions(+)=0A=
> =0A=
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h=0A=
> index f86b56bf7833..bc51756a3317 100644=0A=
> --- a/include/scsi/libsas.h=0A=
> +++ b/include/scsi/libsas.h=0A=
> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct sas_=
task *task)=0A=
>  	return task->task_proto =3D=3D SAS_PROTOCOL_INTERNAL_ABORT;=0A=
>  }=0A=
>  =0A=
> +static inline struct request *sas_task_find_rq(struct sas_task *task)=0A=
> +{=0A=
> +	struct scsi_cmnd *scmd;=0A=
> +=0A=
> +	if (!task || !task->uldd_task)=0A=
> +		return NULL;=0A=
=0A=
Is anyone actually calling sas_task_find_rq with a NULL task?=0A=
That doesn't make a lot of sense from an API POV for me, having=0A=
the only argument allowed to be NULL (and not being a *free()=0A=
kind of function).=0A=
=0A=
> +=0A=
> +	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {=0A=
> +		struct ata_queued_cmd *qc;=0A=
> +=0A=
> +		qc =3D task->uldd_task;=0A=
> +		scmd =3D qc->scsicmd;=0A=
> +	} else {=0A=
> +		scmd =3D task->uldd_task;=0A=
> +	}=0A=
> +=0A=
> +	if (!scmd)=0A=
> +		return NULL;=0A=
> +=0A=
> +	return scsi_cmd_to_rq(scmd);=0A=
> +}=0A=
> +=0A=
>  struct sas_domain_function_template {=0A=
>  	/* The class calls these to notify the LLDD of an event. */=0A=
>  	void (*lldd_port_formed)(struct asd_sas_phy *);=0A=
=0A=
