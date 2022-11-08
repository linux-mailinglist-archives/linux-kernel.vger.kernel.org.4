Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A3621A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiKHRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiKHRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:08:02 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338784874D;
        Tue,  8 Nov 2022 09:08:01 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8FQ86N000855;
        Tue, 8 Nov 2022 17:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ytIZCGjJ/R1zkcVHgVdQAa0kj1Jkc8l9xXqY1AZ+78A=;
 b=eA2N3FkY6WMUnFo+rOOYdQMM0oHMllCPl5ZkjrLrV8mA8Edyk8Eg+GouRDbL5kKgspB6
 aVjtbN7Uc+CLv8dPDhwJt0Uy8sHW1tULWT3hywJVj5V7H8tRqNbKQhKT8m5wbdnlGU+y
 cgDU8nFg6iHz009NzKr0iJBmXbN6b7GSrdl9a9AbDoe1JJGpYH1J4gRkbhblBijJ71Hw
 /8a+GCWqDtybfiprHzZOprNytxEd6DerF9wtiZDKNvVFCI0xM5qGNsR8vY07sf+Fafrj
 oqmen0NucMITY2SBTbbOB8pjeqr5tihxVdDZJrtSA1fXcr9rKgKMvkN9GJ34wZWUerH6 ug== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kqsrbh2pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 17:07:30 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 876E0803740;
        Tue,  8 Nov 2022 17:07:29 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 05:07:29 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 8 Nov 2022 05:07:29 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 05:07:29 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgHQUqRvDHN1KT9Fh6IuGe3X7dFy2NnNrF07DuhH85jLh1Fw36vzXCYpb5WzS/MJwMgzlmjtI0TvWAAo2r/EeEwNBFgITdpYqrqdeiaaMywk7LHfIIr3akqpbkovTB+iAfbDOIw71I+T9QewRB+2ux0ZoXaf6ZfNMYBKPdnaXeFUqBMbIkFDyBwWpnLRTcuzct9bAK/PSyJnOReEsxYj5LDAAyFf4HQYFpt1ULKHSptd63yBizwEzFJ+otjrOr7P4wwnCG6Lwlg0WkYbJf/4CD9jJCZL63dqDXvOt9yLSLUyPOgaBPzvupYrfvL125fkGZtBTgArrt2W/opomh4C/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytIZCGjJ/R1zkcVHgVdQAa0kj1Jkc8l9xXqY1AZ+78A=;
 b=DRz9iYcD4OHBrCFKUwf3ccBnsSGrdk5uRNTcnCbEH1on37dXwS6q7AiUaIN5nXxDyB5TwLZxPmpNElAsKiWc0Uro0vm/eMxYXCB6NQskSjSn9hWXHJWS8n9SoF3ilr+OUtAcoqXB+RWYYQe7DdJhlvqMt++hdifzlxVrJQtEl9tyHxFksryxQ2qNqROIhYDMdsdq7R0mBstZdHOyGn2r7+YjrpER3p23QNqu2/IPoIs3PNiyznxv4lRLOR3+8H4hdvTTb6/PMuixmUAcFsTqD7QoJ+haSWc6PePDrabnsSV8gL6HHSeIOm8EbY9l8tf7JwRXemFSPsM0GynC+0E2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1494.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 17:07:28 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7949:4505:4974:ad5f]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7949:4505:4974:ad5f%6]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:07:28 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Thread-Topic: [PATCH v1 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Thread-Index: AQHY8IUCr0UALtDyXEemicJgxN8JHq4vL1SAgAYIcpCAAA5QoA==
Date:   Tue, 8 Nov 2022 17:07:28 +0000
Message-ID: <DM4PR84MB1927932BB574CD149E1C1809883F9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
 <20221104193657.105130-2-nick.hawkins@hpe.com>
 <20221104200111.GA2562021@roeck-us.net>
 <DM4PR84MB192759BA77DDC69C61E5923F883F9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB192759BA77DDC69C61E5923F883F9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1494:EE_
x-ms-office365-filtering-correlation-id: 4b1e7bb7-c002-494c-49ed-08dac1abb709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gYXw6NxtCMDfIW0lK/qqwyoTapRT3APOhONfUmesTWW2qxX2W9hIoNp4aVGG5pIbf3dNJxHgy4CQsKdmY/0OXV39WFb6wMqveH5R7LjCBjWMhAG6/IQrxm5To2/AxH4v84JEdE6JfMtGNdkFWJGHXVeuCz4BSHOAnzFksiK3r6+qA8DbKEwUSvpxKG5WC0n5zQQOt/bUvojZz1fTpms1VFUrDGJ8CSSjzGxqqaMJVwKseqLn9pxiEFQ56+/tS2CcNMQl5HhDjseEQw3SUwHyewF+EKyoyJiIuuRMNbd8V52deTjHHXaosd/vOHv6OmR8WIPmDFlKtJyncsUmh2nxZVi18OkmMM7szMp+f6HqfFTe2rN2XXjFKEp4NxMw86yJ0tdHJuh9SrhdscP63B9WZl+fJXRffk9NymwHX/spM3pjWqdzye9GmePAGbl+JC4VFEUzXcqaZJtHpPby0NyubwM09YJV21Y7iws0Q7dweX5N0wzCW9ugr11UqFrPUDgcD1VyeZXi7fJt5IR5tWH9UdGDRBD3E7R0lDWx9XaFGjlodtioMxVubJWVKmFeFeQZcEAYWvNL4ApCmbzBSWw++yo/3wz0Aljxacfz4uYQzeJxrpHOb79MZ0k5KT3Zjr31ubJlSevFk/DYFQj4qI0sIa15bhapd+tW82weH0BCxDMdK2vm0ZOHEjWJRHCxGuAP2yWt/6S6oJrY/rmKlfEbHl095R5DliwXLUYaNw/+4DevqqfnQ3LhFg5tBFoFxf5TqqN4AZFQ0vMoMVtEuUYFsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(7696005)(9686003)(2940100002)(26005)(186003)(55236004)(83380400001)(122000001)(55016003)(6506007)(2906002)(7416002)(478600001)(54906003)(76116006)(5660300002)(52536014)(41300700001)(4326008)(8936002)(38100700002)(316002)(66556008)(66946007)(64756008)(66476007)(8676002)(66446008)(71200400001)(6916009)(33656002)(38070700005)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VRS5/3j+83uTZKUbqr+W3+SVuiiCpI6nA34mIXL4j01w9lbGfAIALe6FhgPm?=
 =?us-ascii?Q?WKMz9ftBLXlHoS4pDRG51lQLfKNpiR8pzEWNmqX05D4aJJm9crzk1ujrR2fJ?=
 =?us-ascii?Q?KD5oEZe+BcwAJRplVoaUpj6ArgpEsE7b9ny3tMGJRMwn9ai430Jgw3Szvjf4?=
 =?us-ascii?Q?YYmJIwERi/MP3NVCIppMj7S2nXEgv57fQKkugDHB4Wt31fjn/Ql1Qu4ONbe/?=
 =?us-ascii?Q?GRGBFnswKCXUEW0hXaJq/NV3ao+vlZa0wKfyPexvrt5TqdwKTRSX4qW73bp6?=
 =?us-ascii?Q?6qINQB0wpSK8Dot7sSJ9PxbZG+sDrUAMJNGooepfhl+i7KvO19Ne0NhCpwVh?=
 =?us-ascii?Q?KkOAZfCIaCFaZUTte3tvtmIVqPTnXoCkClGUDIkWSNNhyjoVlrEhFEDSpxVI?=
 =?us-ascii?Q?mcwgI1WSs5D35SLkf1iFOYRNpopdsvolvf19HF9Dd6HzGcb+0rsQjdo47EoH?=
 =?us-ascii?Q?XRh5+nf60Q6rVShBt8k8Y2wG/SZdRm0r3wmfvEzpRbHTH44kPcSxQYnADpvh?=
 =?us-ascii?Q?z2nzRNJvH54z/ehdUmtuF2UGaeA+NjH/Gn3+4ELuY2ATMHUJP11MNvsloC/z?=
 =?us-ascii?Q?8m9aJJkGWQZ7dnf9ZfufKDRc8D4c5tcD4QFuhc0DbtzGZZV6u6LbN7qEdQmx?=
 =?us-ascii?Q?y2isRVYsK+7RJR74ACjW4lIa61SkmYHGVRERobinW+j+Owcw1BRk3uwhlGYF?=
 =?us-ascii?Q?ijS9pW6eIl0Nl7Elh2gUqc8k+0M7gaWjyspCfOK9Vfo12ysaMmiwFkohAKDE?=
 =?us-ascii?Q?xfxl2Tw1Gqd7LktHmWZQdU8U6JV/W1lW4umJ5rHrbSjKk3xloKSP30dA7e0N?=
 =?us-ascii?Q?tiuV4Xf0rdWMQn3LPg99iUJG5wfeT5v8CzwGJvBLXshSmArhZ7bH3FIUJr72?=
 =?us-ascii?Q?dPwleILQOqPIB+e5EWQDKqmO+e9SpOTYe9E59ZIXm96ZmizbpITI9vmRV3go?=
 =?us-ascii?Q?kcqRNjZspw9wixMFm8BfqcFDBMtDMUxPlZAh1UPBFBm+CN73hOnMAnTA0ICO?=
 =?us-ascii?Q?29Ys3rz60QJ3DcDzYdYF+ul/Xym/PiCuJSgmno7VugL2EtHURz+mqwrqvfbY?=
 =?us-ascii?Q?GerTmsPLlSBaIpYgg5q8UsAcUWEjheEdzVq/ZR/MKfpBn5GlxjeAUXh4vSmn?=
 =?us-ascii?Q?hZBu6oU70HY1QY/rfWKsRHyW/SuF3pu5rIE5FNZWgKnjHpSE47BJl9ldI/j4?=
 =?us-ascii?Q?OA6pYlL8hVOSXzR38yi1oy1VLOobUfJw5yJ7lGOt9+j7bc0NxEUqwihs0aJb?=
 =?us-ascii?Q?zdtDbb6nHZFjok9RkxPU5Lkpj0Egc8k50Hwnc7PUAnyGe+TJp35HhBpJ7Unt?=
 =?us-ascii?Q?5Svtd9A4Okyf5v68MIUy4E6OQUOBM2AjU6k3weJLD15aFKBNj010nVukPu/W?=
 =?us-ascii?Q?eez5DKn4PE2uB4M+XMkzrbIQZX26ACBy+dNNe4zsPk8VS/dsHuMXBRdcrMx5?=
 =?us-ascii?Q?k/SkigiL9+fNntC/l4rUNb42z4bfY3zbKfEgOsVLmsXd2RVA5Xtx0YRyFUi5?=
 =?us-ascii?Q?xKQQEkidmCQtfVPdBBl36uvhyJFUT2dhfcqkPEvcGuva8f9zE4Vof1Z83HRd?=
 =?us-ascii?Q?oFqTW04Kpf0uMJBFEFMHZwro6NYF0OzU7ozjJmQd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1e7bb7-c002-494c-49ed-08dac1abb709
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 17:07:28.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUKric/grM7NsAZb9DA7G7Kh3cht2I1jEvpNuyDV8H9uk0F8SjcfG5PaS1XOZ2hWvYl4NDKwUz4ZmC6Q5ZnWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1494
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: cBz9k5_MbPttnWieZ2hDZYxnHLdq4Re0
X-Proofpoint-ORIG-GUID: cBz9k5_MbPttnWieZ2hDZYxnHLdq4Re0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is a resend, my email client decided to
Change my paragraph format with 70 char lines.
Apologies.

Greetings Guenter,

> > +static bool fan_installed(struct device *dev, int fan) {
> > +	struct gxp_fan_ctrl_drvdata *drvdata =3D dev_get_drvdata(dev);
> > +	u32 trans_offset;
> > +	u32 trans_shift;
> > +	u32 val;
> > +
> > +	address_translation(drvdata->data->fan[fan].inst,
> > +			    &trans_offset,
> > +			    &trans_shift);
> > +
> > +	regmap_read(drvdata->plreg_map, trans_offset, &val);
> > +	val =3D (val >> trans_shift) & drvdata->data->fan[fan].bit;
> > +	if (val =3D=3D drvdata->data->fan[fan].bit)
> > +		return 1;
> > +	else
> > +		return 0;

>	return val =3D=3D drvdata->data->fan[fan].bit;

> Those calculations look quite complex. Is there a public datasheet that w=
ould enable me to understand how registers are actually assigned ?

There is no public datasheet as of yet but there is work ongoing to
create one. I will however document exactly how it is setup in hwmon.
There is so much I/O on our board that most of the inputs and outputs
go through an external CPLD we are interfaced with to save pins. A
memory area in our SoC reflects some of the I/O from CPLD in bytes
ranging from 0 to 0xff. Each byte represents information such as byte
0x27, which on this particular platform represents the fan installation
status of fans 0 to 7 respectively with bit 0 to 7. The byte 0x28 represent=
s
something else. Regmap_read/write does a word instead of a single byte
which we are interested in so we use address_translation to keep offsets
easier to read.

> > +	} else {
> > +		/* Power Off */
> > +		val =3D 0;
> > +	}

> What determines power to a fan ? Should the power state be reported with =
fanX_enable ? Or possibly the installed state ?

This actually is the power state of the system, not the fan. When the
system is off we will see a PWM value of 0xFF on the fan. The idea
here was to report a value of 0 if the system was off.

Would you like me to use fanX_enable (read only) to show it as
disabled while the system is off ?
From a hardware standpoint that would be accurate.

> > +static const struct fan_ctrl_data g10_data =3D {
> > +	.fan[0] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x01 },
> > +	.fan[1] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x02 },
> > +	.fan[2] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x04 },
> > +	.fan[3] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x08 },
> > +	.fan[4] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x10 },
> > +	.fan[5] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x20 },
> > +	.fan[6] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x40 },
> > +	.fan[7] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x80 },
> > +	.fan[8] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D =
0x01 },
> > +	.fan[9] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D =
0x02 },
> > +	.fan[10] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x04 },
> > +	.fan[11] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x08 },
> > +	.fan[12] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x10 },
> > +	.fan[13] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x20 },
> > +	.fan[14] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x40 },
> > +	.fan[15] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x80 },
> > +	.power_bit =3D 24,
> > +};
> > +
> > +static const struct of_device_id gxp_fan_ctrl_of_match[] =3D {
> > +	{ .compatible =3D "hpe,gxp-fan-ctrl", .data =3D &g10_data },

> I don't understand the point of attaching g10_data here.
> Why not just access it directly ? There is just one table.

The reason for having this data with the of_device_id binding is that
each platform has different byte offsets as mentioned above. We
would like to be able to reuse the driver if possible for this. We will
soon need g11_data that will be added here. Would a description in
Documentation, comments and commit message allow us to keep
this ?

Thank you for your assistance and feedback with this code,

-Nick Hawkins
