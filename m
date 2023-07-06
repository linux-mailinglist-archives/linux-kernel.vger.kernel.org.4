Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8186749FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGFOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:50:48 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE22125;
        Thu,  6 Jul 2023 07:50:13 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Ci5qr005470;
        Thu, 6 Jul 2023 14:49:55 GMT
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rnv8w12yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 14:49:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjzhB8Cx8fmuRm2GYlyCTps59wP11udzIjz3VoCYnV3rkR1P3CysoSNlQsWbGTQngirXNfpaqqc2gbXK06CLSNuOYvZifUR7LargpkB2KQWs9xrLkrqrrihJE8MqqQ5ZNJrlVCDA+Qy3IazV0kCDCwf+NCG1calLFtHeIMSuCWJmONzZySC3E8heBaNtwkfVtqmiqeBW9rdJVixcOFFloXySsVfgriVFng/r2e2EIhseC0FBr5db74aF8Bg+qVm3CKPRi03Mx5NWs3CyTjqgPSku1AfOPnhYQunsoOR4NnQVEMvMPAllQuKNQVUVUPiXGo2tn/dg9FbeSPyk0cGrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWZIlWNPB1W9QaHXmMRcObA+yg9j0gYJa7lSXyiadmI=;
 b=PktP3TDKPl+F3d3Q5cSGRiV4qMcqtn6HUhUoZEHgsfWOqJSqf0XajRYgzyxIlYs1zVomTV6G0q7Yu3OcEXJ1ehvFV/MWjPyKVLuvpb4uDuQcIeM2cwzJgturjCQeHjbBF8vwbIMh0/tK62EpsE4qjyfi6oQQ8Z4o97q+EeHnpPj3KCn6VNw21GCRvfJPKtJ6XCn1iyf+HE7nelMrHWOQ1ZQYBP6uD+CBHBMHscFTZW77vrEQK5dOFD+kc0sUj9A/O0hKU7MovjcUaxcjFsjMhnB4Z21OZLSQKjn/a8PdxhmGmaM6gRt+ySvb/uQFl4yOL+VB4q3awBzI6g2+Xd+6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWZIlWNPB1W9QaHXmMRcObA+yg9j0gYJa7lSXyiadmI=;
 b=irP48auE3DmiNh4tRpBL7/1smAfyKFJXMIbZGnC/TLM37A1SmsmmKAqAfP42HluZFxlSovCrVq2fi8TCDkyZCvc+6gJ2xpHLlDN2kQhPdpzA2Wxs6+n3ggkCi5BvWc7KFxmCRA82ryJSt0e8+TQTj2dDwMfQQfpy8MQR/RTP6bMBBDrsWtvxxUMSlarotQzGLvKVIMIHlQE/XzM4cSXC6H8+TmgKOjhvndXbJSldPn/NKCRGTKNugsfM1nt8n2GVvkrsHqYFHRzeqWAjHjnsMIOXmHJhY9piC+h2rZvqF/X/V00i3/eajTyopnAiRvEa8z5aklp0PFtYyVR+tD7N0g==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB9PR03MB9639.eurprd03.prod.outlook.com (2603:10a6:10:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:49:51 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:49:51 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZmJMVZdZ9jTlnl0a4bbb/rGp54K9+7TMAgC4T4IA=
Date:   Thu, 6 Jul 2023 14:49:51 +0000
Message-ID: <20230706144949.GA830797@EPUAKYIW0A6A>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAtdLTvM6qh4r9W@surfacebook>
In-Reply-To: <ZIAtdLTvM6qh4r9W@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB9PR03MB9639:EE_
x-ms-office365-filtering-correlation-id: f87fc475-d02b-405c-2df6-08db7e3040ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CskNQW8PaSkfCK0+GYdMvBqePOk9nHWrBHKDWFXulSsJfa/91cDMXLIf8lFjp67rk3qGNEuGTy6dCVZaoJzNXhIsJ/cKZl7WCQ8y3oGeNxNfEWBrP+YqIj9IAq+kQA/YHZlIFEFvljRoDNqb4Usbo23/g3Ah8DxLLSNnnhSyCc1ks9NCDsE7iDFNx4392Q/1azHC6PAR75cipjgHZpaWNtvHz5w8HVcX25RHotAP/bKm0cmlibrUFeFzaOhJXNFCn3fjv2mDP3yqIospJABRuPuoZt1O3fnt/h3kHkxyXGH0BDhHnbvJcVaqhDmgVQaF3CVueYMIHFCvdK1qurn9ANE+xXeNWSXrDO06QSHE/4vLeruQav1ewJ746taqyrDFME82yO9+w9lPBf+OGbn+v3naM44sJPhfP7Yr2X+5DL3wHYFlrPGyEOv+JYtMPcgfDYHaq/yRU3V98DcTsEIxcXhjHtAgU/zzhqhSL3x88dW/WMmJvEOz2y6svFLwyDCWwa5bGNlyMIL/bH9d676/giarNX32EprwcviZPWy3qRAXFb16NuzkQ++xk0do9oJWMFAmHmb87jcX65Bc4AYaLOlAc92eD+vwJ+hP2MATMa5xVZ8X0O4uVn6SgIeJ4j7E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(71200400001)(76116006)(478600001)(91956017)(6486002)(54906003)(83380400001)(1076003)(38070700005)(33656002)(86362001)(66946007)(2906002)(33716001)(186003)(26005)(6506007)(6512007)(9686003)(38100700002)(5660300002)(8676002)(66556008)(316002)(64756008)(41300700001)(66446008)(4326008)(66476007)(122000001)(8936002)(6916009)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sDvkdLpb5GRnw68uQni+NymaOSKAvNdCirdmq7au/WdZ10Oz75oG5dLbU5qh?=
 =?us-ascii?Q?RixEevmJO+amzAYyDhpLbjk6143EdZldNVzEGfGUEIOx26niA3LDWGu8wWL0?=
 =?us-ascii?Q?kjXbFhi02H7Exrg+gBe7HcpIBf8DaD2fjLeeSQTJN64Q5EwH3Q7n/EH4gaD9?=
 =?us-ascii?Q?Y2gH40abs5uuSEABlolcthrUHW498lQlopbbbhSZPZfAzPOFNVvpxH3/OTZv?=
 =?us-ascii?Q?DEOjGB6793rPl/oTCex/rc9wbTH/itXEN3oUiP89YaV5oYZJWA6eOpjN8adr?=
 =?us-ascii?Q?3zHdfAsbbldpbOdGrP/dFBSdmM8/mSWS7SNkVnQCKakGHggVGp1UR6y41ObU?=
 =?us-ascii?Q?3v3FiTbXFNiToTUsF+2vOWl0mVvm4wDZ7w/oJ8uRlAiVJgkXKCax6RY0S8Ug?=
 =?us-ascii?Q?+qAzYa7wBRJMbWt9jLz73/qhf1mI3/TxaUjU0/vpkC+yVTFmAOksE247ztJq?=
 =?us-ascii?Q?psw/nbPtJkC2Ut+BtqLYfS3AXKRL1Kt6GsZck8a0pKUVLr35KqV6ZoWSXxaR?=
 =?us-ascii?Q?URQKq2r6F6iOskB8A1PiRjp1+f+JiKCmBQkWkUn6gWU8K5oUAEZmNkO4hZqj?=
 =?us-ascii?Q?PfjXx3U4NboXNgzsfysTu9oy7axo+1hlD1uiz+9mT+ZVXfSmsPQLfoKxSHuQ?=
 =?us-ascii?Q?PGT+zETZ+NcdlhFEXqj+Ri/mTWkG/o8z2dlBPab8f962wn/vhWfVtINXFPQ6?=
 =?us-ascii?Q?2luwGcTJZ72JvYSE0eEoA72md/MuiNmHs2+3Dup86gd0xNqClncJmg59svCW?=
 =?us-ascii?Q?yPOEKe8f0AK5lVhYgWpwqAW/2W0rwzdgQsIIrCyFpvgXkvT74SopGHZHl23t?=
 =?us-ascii?Q?NwGNDIUsPrKgvBk4FI7BwzriYA8BM/YqRkC1WsF/Gbr6EiR5ciRfZQ3FsDfW?=
 =?us-ascii?Q?xOw9eNOD2nCvKBWP0LIXuHzvcOtA3TObrDLkhIN7oFSzkSmQlpisCpwD4fxj?=
 =?us-ascii?Q?4SilQf2jlBfMpdud9TXbyldZJUUXgv2bL/H2/oHWYfRQ3V2RPTUae4S/ek1O?=
 =?us-ascii?Q?j9opuG0B1SUmAEXQAVDGrXWnC2vGrhs18VDo+nnxKcSJHDHJn/t9Y6W7uTDN?=
 =?us-ascii?Q?0FJMWbzS0zLMVQ9co0aAb9zYOnklBtxNrUIExBXnHZDXbke3g7+TZrbm/WAQ?=
 =?us-ascii?Q?R1LoxG1jVt6W8PFf/gHd9BbQjM2s4VvOYYtk+s55l8bFByBrjXwOTd52TCHq?=
 =?us-ascii?Q?oFrWwNiL5QENMaHYif/T6DUkhrvUzvG7fr8EojXIkf/+4M7in/r6SmD5Tk0K?=
 =?us-ascii?Q?mEcmX9uQtHMnXaYXKuScAg9uLyf7QZcD8/gOUO52Zblmwlty8oaXjBltllNX?=
 =?us-ascii?Q?MTGsTCdsyYnSGI3KVNtkjizO9JA2awz35oZe/a8LkwAyGnHKeB2gtU85528d?=
 =?us-ascii?Q?tdjzxCUcIMcu19W6JXSuK0j+Ybo1uSqjNiY7KUWUw/PLkqSQcCW8kPVa1EpE?=
 =?us-ascii?Q?49dNRb885+AhcrEfPb5uGIAcf2ttJ7Y7QzSgS1lWR2960HfrhkPeA8MNHyRj?=
 =?us-ascii?Q?E4zOQ3/b6IRPvgGWCHwsnsgkcYtaaKRLAg0N6jwE3TQbNO4rEMw9AgzXjOZ1?=
 =?us-ascii?Q?P5M49D+OHa21UdFLYkdRmsn4eQxXcI9YqatPcHmFOp61RVtiMWfjAc22qCox?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E43BC40527F95647B89C33147E62EB04@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87fc475-d02b-405c-2df6-08db7e3040ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:49:51.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwpgWI2xhHNKG8g3JqldvOOGo0nDjwzEFXeXZMG/6AJ7jGMLLp1dC6R4OPH7ez2MDlu92CktPHpr23Ssoom9igGBdI3BdIRkz6uXsKRxNTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9639
X-Proofpoint-GUID: CM7_LAv0vym0UHKruHqXZmrOw_ibybC_
X-Proofpoint-ORIG-GUID: CM7_LAv0vym0UHKruHqXZmrOw_ibybC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Jun 07, 2023 at 10:10:44AM +0300, andy.shevchenko@gmail.com wrote:
> Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev kirjoitti:
> > scmi: Introduce pinctrl SCMI protocol driver
>=20
> Seems like you forgot to remove previous line(s) in the commit message an=
d
> the above has to be the Subject here.
>=20
> > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > excluding GPIO support. All pinctrl related callbacks and operations
> > are exposed in the include/linux/scmi_protocol.h
>=20
> drop include/ part, everybody will understand that. Also mind the grammar
> period.
>
Fixed. Thanks,

> ...
>=20
> > -scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o s=
ystem.o voltage.o powercap.o
> > +scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o s=
ystem.o voltage.o powercap.o pinctrl.o
>=20
> Why not splitting it and make it ordered?
>=20
> ...
>=20
> Missing headers:
>=20
> 	bitfield.h
> 	bits.h
> 	byteorder/
> 	types.h
>=20
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
>=20
> Missing
>=20
> 	asm/unaligned.h
>=20
> ...
>=20
> > +struct scmi_group_info {=20
> > +       bool present;=20
> > +       char name[SCMI_MAX_STR_SIZE];=20
> > +       unsigned int *group_pins;=20
> > +       unsigned int nr_pins;=20
> > +};=20
> =20
> So, why struct pingroup can't be embeded here?
>=20
> > +struct scmi_function_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	unsigned int *groups;
> > +	unsigned int nr_groups;
> > +};
>=20
> So, why and struct pinfunction can't be embedded here (yes, you would nee=
d a
> duplication of groups as here they are integers)?
>=20
> As far as I understand these data structures are not part of any ABI (oth=
erwise
> the wrong type(s) / padding might be in use) and hence don't see the impe=
diments
> to use them, but would be nice to have a comment on top of each.
>=20

My opinion is that we don't want to make SCMI Pinctrl protocol to be
dependent from Pinctrl subsystem. This will potentially require SCMI
protocol change in case of significant Pinctrl subsystem refactoring.
Another reason is that pincfunction has the following groups
definition:
const char * const *groups;

Which is meant to be constantly allocated.
So I when I try to gather list of groups in
pinctrl_scmi_get_function_groups I will receive compilation error.

Pinctrl subsystem structs are designed to be statically allocated and
can't be used for lazy allocations.

> ...
>=20
> > +struct scmi_pin_info {
> > +	bool present;
> > +	char name[SCMI_MAX_STR_SIZE];
>=20
> Swapping order might help compiler to generate a better code.
> Also this applies to the _group_info and _function_info.
>=20
> > +};
>=20
> ...
>=20
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
>=20
> Can you rather follow the usual pattern, i.e. checking for the errors?
>=20
> 	if (ret)
> 		goto out_put_xfer;
>=20
> > +		pi->nr_functions =3D GET_FUNCTIONS_NR(attr->attributes_high);
> > +		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
> > +		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
> > +	}
>=20
> out_put_xfer:
>=20
> > +	ph->xops->xfer_put(ph, t);
> > +	return ret;
>=20
> ...
>=20
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
>=20
> Ditto.
>=20
> > +		if (n_elems)
> > +			*n_elems =3D NUM_ELEMS(rx->attributes);
> > +
> > +		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	/*
> > +	 * If supported overwrite short name with the extended one;
> > +	 * on error just carry on and use already provided short name.
> > +	 */
> > +	if (!ret && EXT_NAME_FLAG(rx->attributes))
>=20
> 	if (ret)
> 		return ret;
>=20
> > +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> > +					    (u32 *)&type, name,
> > +					    SCMI_MAX_STR_SIZE);
> > +	return ret;
>=20
> 	return 0;
>=20
> > +}
>=20
> ...
>=20
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret)
>=20
> 	if (ret)
> 		goto out_put_xfer;
>=20
> (but in this and similar, aka one line, cases the current wouldn't be bad=
, just
> matter of the consistency with the rest of the code)
>=20
> > +		*config_value =3D get_unaligned_le32(t->rx.buf);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +	return ret;
>=20
> ...
>=20
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_RELEASE,
> > +				      sizeof(*tx), 0, &t);
>=20
> This is perfectly one line. Please also check entire code for such an unn=
eeded
> wrap.
>=20
Thanks, I will go through the code and fix this.
> ...
>=20
> > +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_hand=
le *ph,
> > +				       u32 selector,
> > +				       struct scmi_group_info *group)
> > +{
> > +	int ret;
> > +
> > +	if (!group)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> > +				      group->name,
> > +				      &group->nr_pins);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!group->nr_pins) {
> > +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	group->group_pins =3D devm_kmalloc_array(ph->dev, group->nr_pins,
> > +					       sizeof(*group->group_pins),
> > +					       GFP_KERNEL);
> > +	if (!group->group_pins)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> > +					     group->nr_pins, group->group_pins);
> > +	if (ret) {
> > +		devm_kfree(ph->dev, group->group_pins);
>=20
> This is a red flag. Is this function is solely used at the ->probe() stag=
e?
> I do not think so. Why then the devm_*() is being used to begin with?
>=20
> Also what are the object lifetimes for device here and the _group_info
> instances?
>=20
> > +		return ret;
> > +	}
> > +
> > +	group->present =3D true;
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_h=
andle *ph,
> > +					  u32 selector,
> > +					  struct scmi_function_info *func)
> > +{
>=20
> As per above.
>=20
> > +}
>=20
> ...
>=20
> > +static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops =3D {
> > +	.get_count =3D scmi_pinctrl_get_count,
> > +	.get_name =3D scmi_pinctrl_get_name,
> > +	.get_group_pins =3D scmi_pinctrl_get_group_pins,
> > +	.get_function_groups =3D scmi_pinctrl_get_function_groups,
> > +	.set_mux =3D scmi_pinctrl_set_mux,
> > +	.get_config =3D scmi_pinctrl_get_config,
> > +	.set_config =3D scmi_pinctrl_set_config,
> > +	.request_pin =3D scmi_pinctrl_request_pin,
> > +	.free_pin =3D scmi_pinctrl_free_pin
>=20
> It's not a terminator item, so leave trailing comma. It will reduce the b=
urden
> in case of update of this.
>=20
Ok, thanks.
> > +};
>=20
> ...
>=20
> > +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handl=
e *ph)
> > +{
>=20
> > +	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> > +	if (!pinfo)
> > +		return -ENOMEM;
>=20
> All the same, why devm_*() is in use and what are the object lifetimes?
>=20
Ok, thanks.=20
> > +}
>=20
> ...
>=20
> > +	for (i =3D 0; i < pi->nr_groups; i++)
> > +		if (pi->groups[i].present) {
> > +			devm_kfree(ph->dev, pi->groups[i].group_pins);
> > +			pi->groups[i].present =3D false;
> > +		}
> > +
> > +	for (i =3D 0; i < pi->nr_functions; i++)
> > +		if (pi->functions[i].present) {
> > +			devm_kfree(ph->dev, pi->functions[i].groups);
> > +			pi->functions[i].present =3D false;
> > +		}
>=20
> Missing outer {}, but see above as well.
>=20

Checked linux kernel code with the following command:
pcregrep -lcrM "for \(.*\)[^{]$\n.*if" .

As I can see - this approach is taking place in kernel code. Although
not as widely as for with outer {}. I will add outer {}.


> ...
>=20
> > +static const struct scmi_protocol scmi_pinctrl =3D {
> > +	.id =3D SCMI_PROTOCOL_PINCTRL,
>=20
> > +	.owner =3D THIS_MODULE,
>=20
> This is not needed if you use a trick from ~15 years back...
>=20
> > +	.instance_init =3D &scmi_pinctrl_protocol_init,
> > +	.instance_deinit =3D &scmi_pinctrl_protocol_deinit,
> > +	.ops =3D &pinctrl_proto_ops,
> > +};
> > +
>=20
> Redundant blank line.
>=20
> > +DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
>=20
> ...i.e. initializing the owner by this macro.
>=20
> It might require some update to the above macro and its users.
>=20
> ...
>=20
>=20
> > +enum scmi_pinctrl_selector_type {
> > +	PIN_TYPE =3D 0,
> > +	GROUP_TYPE,
> > +	FUNCTION_TYPE
>=20
> Leave trailing comma.
>=20
> > +};
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Thanks,
Oleksii.=
