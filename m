Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DE5FE57F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJMWmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJMWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:42:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5174A10D6AB;
        Thu, 13 Oct 2022 15:42:29 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DM3XjM012386;
        Thu, 13 Oct 2022 22:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ZLF0ibsSSdd0nlZUo8Do7LdzAvZdVj8S5w4YmrgILaE=;
 b=TxwVGWvtGLUpmdTmQHflFmbKmOeSTd1XfxvPS4kI27Ec9xCy8jmu5/Kilw3SoVv6j1bk
 n9q6C2lUcxfqmM5JBscTOestcdN6lGUTomJXgM3ELY+ZaQbFsME0QFyPfDsMpC2nSMc8
 1sGKo04h6+lekMc8zVRR/Be21MYEDbbykJvXvm8Ez4nbtSTqSj/hR0yslXDYlyA18v2D
 QS3Ct/npqvdMyUjp6htZvVCxSno2t7meDVFkauTtamP/p0xySwVAsIenzuuQOR6VybOM
 c1TyIwAJPYtvmXsLUX/RHV76qud1316q5A3+yNIo2l0krujbVixnUKCq6xKXGz70CAqa AA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6qw19syf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:42:17 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D595A806B52;
        Thu, 13 Oct 2022 22:42:16 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:42:00 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 10:42:00 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:42:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/EbUgCxOMimEuWtOxyZiIZxeib9uxxqYUPJF+q/EWiZ0H3SjUK72QyPmHFTmqRBv3rwkYv2DcQxnkWLhNxHnt0hXSsBe7/4vAIUYUoegkk9Y3ESB16Abcq0W3PaR8MR+KuOCVaRAFjsBz/PvXRSOb/bJB4tqpRYjqc25FNNfDY0AaZ0uxad8O94ecuhHaqKsrYdrEMaYQXpgqLmoeY6Z+nxXlZezRlQF49XOQBzKDgN0GM4thdDA/Crxw6yhPkFeRb6b5VTPz8E/bOg8HkvcXCfxe4sKcERD/CjSNwjJF6GTNiAhsFecOgYUduGaH6JOWJckeduL+ZWcq/os9r8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLF0ibsSSdd0nlZUo8Do7LdzAvZdVj8S5w4YmrgILaE=;
 b=GbS+M0tc3KPA2jsp4jJYALdeTzwJd9bqCnAmibW5twieMuhAFrJ0MqM0NONhgs6ZJWQLbaa6anD/JjYrWsDERYyBmGAf/4TavMOwE9STQTqev385JmXby9GoYet5eFd6ZO8Fgne7VBTvnypSJV6L/uevh2cHE5DxcHxrSweQqsQoxiDb1Y8XNBibdlES2uORiT0bHiuXeZj12Mp4ro+OqIClGMO8I3efalnFQR+h5vTQDshvMe2V5BM9mkW6xF2rUsFw56m4F72V3s65lk+EwUgxjIX4OM14hFXKY18WeOGdbhlL/0x60A2iMge0WQQtZMnqrSvklyOfSHwJl7NuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1422.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 13 Oct
 2022 22:41:57 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:41:58 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: :Re: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Thread-Topic: :Re: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Thread-Index: AQHY3oYBXsDUQQFB3kuWMnaA6CWxOK4L1DAAgAEYxMA=
Date:   Thu, 13 Oct 2022 22:41:58 +0000
Message-ID: <MW5PR84MB18425B011CA1E206921DD539AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com> <Y0eosAIgkvMzYJz8@sol.localdomain>
In-Reply-To: <Y0eosAIgkvMzYJz8@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1422:EE_
x-ms-office365-filtering-correlation-id: 86ce6fcd-ba57-4bb2-f0de-08daad6c2333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZ8sCUlfnuyJfnXtXQY+I6Sq7dKaBtNJzMItytDD62x2jk9vZ5fY9pzU3DONfMwlvx8dagNj6RAzgEOB+m9fQ8r6UWXgn+tq9XaAIBnWLwGB0k9Pk/tZBFiWUVkL2KCIxstLez7phomB60Yjwcv3LPfcCr45kqHejomNdwP+Ipp7573KR4eCOyMmhwCWz41ST8cYVMM1fMGO3fGFR8OOqvbLfY3vU5CKjRyx2MEjKofXTwoC1YEvVlIALhhRjolhEI9XTzBVHl14hLt7W1wxh5KpC+DvOb1DHcLA3Ca9TLczCQEt6ViZyUXpxpESKnX5CXx2sYLgH/DNjtC8aM19gSWceIKD+7x/tkBqQz5EFR7sCp1IZRVpZ6ZxqHrU/AcahEfuVGLAHFDgjjDGK/z3avNZI+L6ij35EPPme71ZKis+SB+s9xD9lGqHbns3qj/pvnfUcxxnp6ZF6woQhkPgxiMabkiIp5OhLbHuULZY2Ax7gl1EDS8g80ZmNaSoXHcj1ZGHzNSnttX+BBQxa5GLOKPKbFM7SHill9wlmUtlq0WhBiq27CtcrrBViDbQ7cFZ+mD2GRLHK+OEpprz18JCCicQfuZvCse+UNFpRpg1/mu3Q19V+j7Qzm6Th+gdLoePn87/T5jUhlVFLcUkf2zGO4TCtnA1xgpHNiY4gLbXVBHXIQOKzoqFZ0fCO/aVNs4mpKGWCMd9zryy+fR4/rlWwPK5mEQcDg7d4NcBfqf+ZtlX7e5lLZNy3JLtQ0LxCRoVEwYfQhmLQ3ilb4UHtRd2iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(5660300002)(41300700001)(38100700002)(33656002)(316002)(86362001)(54906003)(66556008)(71200400001)(8936002)(6916009)(38070700005)(66446008)(83380400001)(4744005)(82960400001)(66476007)(2906002)(186003)(7696005)(6506007)(4326008)(64756008)(76116006)(66946007)(122000001)(55016003)(8676002)(478600001)(52536014)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kSV2JmolXwPK1qNWsoKX9nxc71+D/fGptzBBE8XdCuYgKmjPMZlAE9+LVZmS?=
 =?us-ascii?Q?MIMjIah8/gBG/dDsS9AYB497R5a9THuVc2x2dAYDBVU9HVnPOKRJ22xQaBmY?=
 =?us-ascii?Q?i4KdJ8KKdz80UP4/Narvc4gLtqH0M/G5JlRlnVV1O9EOTYvTtkSDfJYbcJOK?=
 =?us-ascii?Q?IlxYKy8TooAxS5CiAbQLes9EcDHpTMnSzKysr5V9BgsTdxasLMHkj0H48b3D?=
 =?us-ascii?Q?rLNzd5tWXE3AyUuMt+kWrvHwIqdfPEiLOqZz7aQaJ9/r0SSNzcGHBQEV5Nqr?=
 =?us-ascii?Q?ynIALSaKomGrtb5SsKAXSZCIosC7VQ18mW2U607WefwOg8qM+hH70BovSUvW?=
 =?us-ascii?Q?m7afXqOxkhUPMm3XypmX0ZzTvnDGcOfD0XyYn3zYgFto/ckkZhg0W2aKj2Kq?=
 =?us-ascii?Q?Vp/6drBvztEI8DLosoyfeHHyRmBk31z+2vNJpMzqGpEljzgLjWAym01GUOwy?=
 =?us-ascii?Q?CLZNVRnGwRqKJRwDTD+AGer9IFJYXVGdkG+JAU0DNTvxdsfN8MBUbYSC6gPh?=
 =?us-ascii?Q?crO7oYO6CibFMbvwpAt9h2vcGtKwDC0g4Tc1iFk1BFCPVdcJywf1KP58t/41?=
 =?us-ascii?Q?D1E5Lqb1SHrQpRKyU+yxZtKB+j5byGX45rJOXgMKOQxK6HcrRyznCZB1mhOv?=
 =?us-ascii?Q?SF2mzgoUSpskys2WufezvxiCenSC7p9XZCqIf2ZLAdQT6v0XHk+le71bXrIH?=
 =?us-ascii?Q?eI/XR/KoWFzwOT9H82uje28QvkWV1h08BbxdFHFNbXN6MXt0IH4OnqAdwAmG?=
 =?us-ascii?Q?eOyXMpfnznTO/4h/FYdoyvXeZH6aRg/81iiTG2emqdFK2XI7jgC6glHquA58?=
 =?us-ascii?Q?Zus4fr7z0RxPF5HrqqVPSjzHxR6m3p959dyXkZJRUA7XwS8sKwkTd5JFKvuy?=
 =?us-ascii?Q?zO7ekYLNc1ayGBvEVWaW9OOoAxpiq+NseV8n2lkzsfsEw9yltYPv3ebOHJ7u?=
 =?us-ascii?Q?oPRmmLkoVb6xGsexk5OHxtIoynUL28Z3LV/tmkhHZ/AfuFTTwsQ07n4pA5FD?=
 =?us-ascii?Q?g2zzZ1D5szIXY/T5URsT6FWay0XI9aoComH6/ZADv/D5wHT6nPBwp/hC6765?=
 =?us-ascii?Q?rAM0oFt4AkDnuLJWAahROM+STDtlyo6zlSK+hW29cqqb96NuSgK9gXVLrHtR?=
 =?us-ascii?Q?+9L6+sKYJChyvJhufnpaivNgZs0/ul2IHvX3PGHMFUz8CGmOFLzB4H02eX8b?=
 =?us-ascii?Q?yaHBrJ2koES8ZBNwnaN+J3K60+7AKmCwdviY+bmroECnmxnYHh/FPnMUbLJS?=
 =?us-ascii?Q?YFHueUc30GZtwrMq2XTR/2istk9+cgAva5+AgUTy9RkLFym7ZodyWWsEfsCe?=
 =?us-ascii?Q?iBOodo98DpSNTMWWK+LgFdfL6/D/IYpCYf4GyHwFkXHuAZiQw9cmXDsWEZ41?=
 =?us-ascii?Q?cBfTu6xk0+cnvkqlILwN/VyYv1jtSkN2z+sqSSguAxQv80LQvOYErHGD9cRf?=
 =?us-ascii?Q?MuS/OjdkfeXHx+K9sXDnjMI9ZTYkXqrwMhByUnCg9eMEWEwzQqzedur3fPSM?=
 =?us-ascii?Q?So6nJZeyWHyICRsXLrhLTQQnv8zJYDQX7r9iKpTl/8kEMrBxeVcidb8mpkOZ?=
 =?us-ascii?Q?zUTBJGYY65MF0fialDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ce6fcd-ba57-4bb2-f0de-08daad6c2333
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 22:41:58.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Pn+PwGJltPwt5wclWk9kz6ptpQISER3mXWkYCkn/ZiGQyWtKfHDdpz4JPJnY1vL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1422
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: EchuSr3LGt7nmEyWOjbdsxvq_RCkNuNW
X-Proofpoint-ORIG-GUID: EchuSr3LGt7nmEyWOjbdsxvq_RCkNuNW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=801 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > diff --git a/arch/x86/crypto/sha1_ssse3_glue.c
...
> > +	do {
> > +		unsigned int chunk =3D min(len, FPU_BYTES);
> > +
> > +		if (chunk) {
> > +			kernel_fpu_begin();
> > +			sha1_base_do_update(desc, data, chunk, sha1_xform);
> > +			kernel_fpu_end();
> > +		}
> > +
> > +		len -=3D chunk;
> > +		data +=3D chunk;
> > +	} while (len);
>=20
> 'len' can't be 0 at the beginning of this loop, so the 'if (chunk)' check
> isn't needed.  And it wouldn't make sense even if 'len' could be 0, since
> a while loop could just be used in that case.

Thanks, I'll remove that if from all the sha functions, since they do
have that protective check upfront. I'll review the 0 byte handling in
all of them.

