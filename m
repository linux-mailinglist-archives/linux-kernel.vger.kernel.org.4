Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E951F65856B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiL1R7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiL1R7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:59:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB83165AE;
        Wed, 28 Dec 2022 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672250357; x=1703786357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WKEc+1GkZ4ex9XlZ3wkrUwrELqAWAxxjGrgfjQrVBtw=;
  b=LSUz6w49u+Ciem5anPX8XunFtelU3CMVffykaifxxMOESWLKHfa+4Pq0
   SLtPLVdqbjS850Sbfe+yNHYjMnQknJ3vKQH5LQJK5e7WQi1eKdgQa/Xz/
   XAvrIj+6/qJRaa2jSdqqQrmMp812+/v8mkUZBtpCNA46herJYCjqoYpYG
   Ygt2HaGXAI9NRqvDTSimoXLV9xCvNYdTuKzYLujkWuBcyz1FXpUTPgHvp
   U4FZdk5l4M0PSfQfSKZXV0jlDksPzpCnibNKEoGpTn9GwSCOBfPHYxei1
   IAbFP7FlOKF5pfOCYtgwGLBvaWDCDZTusXCCgX1TtBZXGcv03PgliYc2y
   g==;
X-IronPort-AV: E=Sophos;i="5.96,281,1665417600"; 
   d="scan'208";a="323938399"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2022 01:59:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxLbRp5oqmkWc03lNkW/gUEKiy+MogmXeEBB7ZWZHFhPKA047KwPR+kZ1GTvQzZkmdlpJzLpYGxwSl+9kWe4n3vkakvFpAhojj14bkF5rZ+u2gre+dLHX2fviV1s4hF9WguBKaV3IaM1pJJjrl/dYmKB03scuWlE2NzAahlcU3/SONm25QtYUMdaTnnYAaZYPRgLvZmuF70x2jL7XqrraqaB+MJnZXBYkKobvpMG4b1+IhqcGOSusyycgnJzMbARw+z2fwlZuB5qPX/ayjYV1H2qduSU46UsWl0f7sebeK9/qehQPaQIEmbXy1MlMiwMcTYlhoGN1TElfMKHNsaVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/SZRtABe8pshcdxKWAwLd9QhvH46xBJHHmoQZ0O89I=;
 b=h3qqUXKobrnvrThRSjyc6fmpqwLeEnPbEHTlQJCIkKaqE4Hqu6/OFz2F1tqS+R+7WshDG/pFuGxaHy8eBQHVp9G8kZW/0N5fVeFNj+pjMTRCMk8M69WSz4JNKT06XOJR+9qwKAP9vIPEAl1RqvQHLHwB7PxeM4A7C4PO0j2MqmEwRh2Nx/xlYwWu6xtXTEYATY6U9NVCL7rKtX4s6F4eR3zNxrdBCHgja+aM4rZ7ZbRn0UYYjNZzLe/or4Do+cz7C/rXQ40ZuR0AKTpqRr46G6iE4XZGhHJlEAOGFg4Y0ovJgHjiuzEW7ReLfRjwns3WyW8fLaZt45cfOMPqzJkmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/SZRtABe8pshcdxKWAwLd9QhvH46xBJHHmoQZ0O89I=;
 b=OCtknICLI3n4IDalmVVi7VlLFHQ1+0I0rTzoov9Ggpn0YOIjVH7+nTiJNRXkDqn14/yvmtVXIH1CQaUAA5dR7RyWx6U9SeHSS9oSX2m41gCyOcTnK9oQWeZXPiblcSsC82h8HT7q3eJNQqeYUkrtHXkxx2sFVE95ByJkbJOLNVU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6434.namprd04.prod.outlook.com (2603:10b6:408:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.15; Wed, 28 Dec
 2022 17:59:10 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 17:59:10 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Wu Bo <wubo40@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiuchangqi.qiu@huawei.com" <qiuchangqi.qiu@huawei.com>
Subject: Re: [RFC PATCH] ata: libata-eh: Retry the cmnd when normal complete
 occurrd after scsi timeout
Thread-Topic: [RFC PATCH] ata: libata-eh: Retry the cmnd when normal complete
 occurrd after scsi timeout
Thread-Index: AQHZGuYWLF0ErbPJak+5UhizCm3L1g==
Date:   Wed, 28 Dec 2022 17:59:10 +0000
Message-ID: <Y6yD7Jy0vNr2ZAmE@x1-carbon>
References: <1672220216-46938-1-git-send-email-wubo40@huawei.com>
In-Reply-To: <1672220216-46938-1-git-send-email-wubo40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6434:EE_
x-ms-office365-filtering-correlation-id: acbaabc2-80bf-43b0-3bce-08dae8fd38a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWdcZS9Icb6T5rQxKVyLocxc3zJ3XzDbngpqYnVWQ2bZveKCoWx0+iEyiZXpySyxR1bONO4naiYzXZPy4A3w7mPuVwXmI3MXYIecD82sGeO+31wDdaVk1j1KS7HkbkBHb9KGGKlMfRkf5vKGhqCmgyMLKkUpi460+IgmRwH243BDU3CLyTAk8pN+RRjcC1YaWXAHsFR7Bp7mhGzwleKpfQ4F2J79M/C+aCru9ULaRnBWjsCDZKU1RNbfGe+DNgi/dIfHlHwLKdZXcrZSEAfZQQRObEohMn1vASCBAuifq3S2o0iWiNxcbiGiAMyXbSB0wGnAU9+NGaX1Xs2BF/c7RG2/7wd/fVLKCqiuaninawHX4t+c43CZYCIy5O/ZJQKrv0eV/bOLfpQUm0YlMREwJdm6Bv1Ey3REjQ4S83pVsE5wmiKPqrVTxmRh7NgQOrcas9kWPcUpijOsxpDvoQqg9P2/WxxWYFahASPQNJgNodfWLsupXp7nzRzLb2ros1CoZnUcwu8uT3ZBubLMIZm+wz+DPQIKUc76Mgefub/5zY4o6LnNFbMG7n/79E68a0vzy3wdgmptY1NsAPh3Dq/65wcY1XQd1PtsosWxp2CIjPtrB9EIbJlegybea6t7jF4VwfdJKlSGq/Azu/ZXUPMcRXcZcrV+xfgDPl2QF8MGW2xxudxkvpO9J9KqsWMYLkuut1nC+qVkqPTRCh7edpxwtYDUIMErqFBoYb79q2/72uCjfnxXaQKfkYQ1gGIrIKQoHypzhW4uY12UUvHcifaVzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(6486002)(478600001)(966005)(6916009)(2906002)(54906003)(316002)(33716001)(38100700002)(38070700005)(83380400001)(82960400001)(122000001)(86362001)(26005)(186003)(6512007)(6506007)(9686003)(71200400001)(91956017)(5660300002)(8676002)(4326008)(76116006)(64756008)(66446008)(66556008)(8936002)(66946007)(66476007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCPoKKAw52Kde6yIBGh1BzYavQDWFv8Y/3xRzqV4DYDLcjITRszV8lw1hdAH?=
 =?us-ascii?Q?WQ1GKCrM4knMiYHuLDZC3JPDoH5IJs3JeGTvKYJSa075Zbj/ytlRGBJTC5+L?=
 =?us-ascii?Q?BUjIe0Y8oyZ8zwij/oImju+ScMmXbIb8xvoGHhClsbjt+tniqJyeLMCCPgO6?=
 =?us-ascii?Q?/V6HNsAxwOFsn+rjcfP+vAfmG2IjoPaKa762ztSVTmrrJyD6+xWlNzdUHadb?=
 =?us-ascii?Q?4S4o19e1B4ypHTMYwAIm/x0j/ZdzsJD1KJQkguJpYZPH1BVC9xuhoNW5jBNX?=
 =?us-ascii?Q?LqopXzNRl2GQao79U/rd8bce+lhRvJYq4NAtGnXlTEsDQxIfshaXCUayNu8X?=
 =?us-ascii?Q?iFitCLN0Ul3eyfuU7joliHxVQRzdjEc2KHO/P2KDHvhO0gzObl8QaSvDDaRz?=
 =?us-ascii?Q?GSplZDVv++a/pQ/gDGVApqVNS0ZtuPR0PgM1N5C5JofO2uGW8oCSepMC7KxL?=
 =?us-ascii?Q?OmJ+89iFUDy3IIAR2N2cXi7gzjYp6f2Nr+lH+G6vIbz0RV6KvWCgEl5u/7vX?=
 =?us-ascii?Q?qNvduaP7+U+w2Qq7mzijsNHB3xQnyQNihe15o1YF1p0FAcoEPq3ExO1txGpi?=
 =?us-ascii?Q?QXYiVAfqs0s7kNx2/+m9RYZoq6ZP8oSSbQlT5pg25/M9cclifbG/VXMtIomC?=
 =?us-ascii?Q?ai8XoUYj4eiYHBF8e3D9cxEyV/hKNHys47KMMdtF+59Cz+f2cjhtKdr3qtem?=
 =?us-ascii?Q?LaCpITELyBztQRbbApd4vuaoDeegi/JS/oGCPPF5yQQssClrmahWpC2PhKYd?=
 =?us-ascii?Q?B61rbe01t7hEUqQrRkcjm6TDu0ih3oLHY/CJW5vAgzPE3mEfZo9e0NfRaTa9?=
 =?us-ascii?Q?befO6AnTZlHRCHhD24y+AjZNfW4EniWOJVOX/lkwbg8qG8qnPYZGd/F76OOo?=
 =?us-ascii?Q?nnJ3iVWLBjL+jzbBI05i4U0OF9+s/Y5FQN9g9z1G4DV4b7K/BFRzMom+PZTk?=
 =?us-ascii?Q?XGnSLopikghIarPa0iSMbtqYVTE2fKn791TxQUAz+uJu+n7jNkItoXhFHkOa?=
 =?us-ascii?Q?YT8ov2+2wR+tQDzR2F6Ygw3JdvdMeLNRvUOqmS9AZf1rjonM/3/aSmX+5MYD?=
 =?us-ascii?Q?TNa6hfUqRek4sW3BpUPEvgHCIRttdQ5mH5RuX/ZYH329BMANjxdlOq+9IFHR?=
 =?us-ascii?Q?4Bx85L/9sghnL9pHPIAvqJCqqzqoBoSvHhpPwvnFPXN6Xjghx7ZVLZ73ffrT?=
 =?us-ascii?Q?btjjOwgMdr/gVPPDwBEcti6s1OAhOiQ2rfyCMDw6/OiKrwy6M+9ZBiOyvYlY?=
 =?us-ascii?Q?gPxAJ8qYvXLiQPr1RG3mYvMx/JjZGvHL/7P/GX+xtyPshm/uCQkaQtSVFLce?=
 =?us-ascii?Q?mNYV5nkGoPLBSCpt0qV4XqtFrDrhoITkZ+zsP0TTUkGvPF0E2ZO3bTtl0h8/?=
 =?us-ascii?Q?7Ic6gUklnZOobV2sNPWrF7MzFhp1JHV3wHPanzo19PoOAN2ptU9LPwuIXpTh?=
 =?us-ascii?Q?CQDvbNfogGstSssk7RGWdDK5k0C6Tix+E95C2BLvaFyuaoQl3SDeAYQB3h4i?=
 =?us-ascii?Q?qkeTiS9U1OtcUgs5w4c0lCKTkEb6qzwFyGGe8Qdnq5sK7mQF/SuvPrby/RoO?=
 =?us-ascii?Q?0Hhgp9nESBvwEQL9VtWVWSZex2yBROgrDQsv/sjuTHQaxDHOBUkTv4EVbxdy?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F94093310E84CB41A1AFFC250FDCA190@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbaabc2-80bf-43b0-3bce-08dae8fd38a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 17:59:10.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnD2swai1W6QqX5jKmsl2Ch6hr5KZOHSrj4fkaf84mYTEFp5b6GCX3MjLwrFdhS3vgVL/oIct6YnBkP/M+WACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6434
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 05:36:56PM +0800, Wu Bo wrote:
> From: wubo <wubo40@huawei.com>
>=20
> Hi,
>=20
> Now SCSI middle layer EH and normal IO handler can only choose one of the=
m,
> after the SCSI command is completed normally after scsi timeout period,
> Should this scenario be given a chance to retry?
>=20
> Signed-off-by: wubo <wubo40@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 34303ce..8d1856f 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -617,14 +617,8 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *ho=
st, struct ata_port *ap,
>  					qc->flags |=3D ATA_QCFLAG_FAILED;
>  					nr_timedout++;
>  				}
> -			} else {
> -				/* Normal completion occurred after
> -				 * SCSI timeout but before this point.
> -				 * Successfully complete it.
> -				 */
> -				scmd->retries =3D scmd->allowed;
> +			} else
>  				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
> -			}
>  		}
>

Hello Wu,


The function comment looks like this:
	/* For new EH, all qcs are finished in one of three ways -
	 * normal completion, error completion, and SCSI timeout.
	 * Both completions can race against SCSI timeout.  When normal
	 * completion wins, the qc never reaches EH.  When error
	 * completion wins, the qc has ATA_QCFLAG_FAILED set.
	 *
	 * When SCSI timeout wins, things are a bit more complex.
	 * Normal or error completion can occur after the timeout but
	 * before this point.  In such cases, both types of
	 * completions are honored.  A scmd is determined to have
	 * timed out iff its associated qc is active and not failed.
	 */

And the code looks like this:

			if (i < ATA_MAX_QUEUE) {
				/* the scmd has an associated qc */
				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
					/* which hasn't failed yet, timeout */
					qc->err_mask |=3D AC_ERR_TIMEOUT;
					qc->flags |=3D ATA_QCFLAG_FAILED;
					nr_timedout++;
				}
			} else {
				/* Normal completion occurred after
				 * SCSI timeout but before this point.
				 * Successfully complete it.
				 */
				scmd->retries =3D scmd->allowed;
				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
			}



If SCSI timeout wins, but there came an error completion after,
then we will go into the if (i < ATA_MAX_QUEUE) case, but we will
not enter the if !(qc->flags & ATA_QCFLAG_FAILED), as ATA_QCFLAG_FAILED
will already be set by the irq handler. This QC will be completed
by the ata_scsi_port_error_handler(), which gets to run just after
this function has returned:
https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/ata/libata-eh.c#L54=
6



The else clause you are modifying however is for the case where SCSI timeou=
t
wins, but there came a normal completion occurred after the SCSI timeout.

In more detail, what happens first is that scsi_timeout() gets called,
and if scsi timeout wins, it sets SCMD_STATE_COMPLETE:
https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/scsi/scsi_error.c#L=
355
and then schedules EH for that command using scsi_eh_scmd_add().

What happens next in this specific case is that the IRQ handler is called,
takes the ap->lock (which is also taken is this function so that it can run
at the same time as the IRQ handler), then the IRQ handler calls
__ata_qc_complete() for the QC, however, when scsi_done() is finally called
in ata_qc_done() (from IRQ context), it will not be a no-op, since
SCMD_STATE_COMPLETE is already set:
https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/scsi/scsi_lib.c#L16=
23

Since scsi_done() never finished the scsi_cmd, we need to finish it here,
in the else clause, by calling scsi_eh_finish_cmd().

When the EH queue is flushed, it will check if scsi_cmd_retry_allowed()
and if it is, the command will be retried, otherwise it will call scsi_fini=
sh()
on the command:
https://github.com/torvalds/linux/blob/v6.2-rc1/drivers/scsi/scsi_error.c#L=
2150

Considering that we want to only finish the scmd here, libata sets
scmd->retries =3D scmd->allowed; such that the check:
	return ++cmd->retries <=3D cmd->allowed;
in scsi_cmd_retry_allowed() will evaulate to false.


So TL;DR:
It is absolutely essential to set scmd->retries =3D scmd->allowed;
in this else clause, as that is the only reason why this command will
be finished instead of retried.
Since this else clause is for a command that timed out, but got completed
successfully via the IRQ handler after timing out (so the QC got freed),
we only need to finish the scmd. Retrying the scmd is wrong in this case.


Kind regards,
Niklas=
