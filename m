Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899366650DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjAKBG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjAKBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:06:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9701C421
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:06:54 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B03wwv030578;
        Wed, 11 Jan 2023 01:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uBdNQUaTYlmOy5l9nYoBt+IzpP61DBzpzgQ3vXy1XJQ=;
 b=jVI8Zw7FzMFl/p3HHXWNm0q9ZdfLSiyIfAmfzOnDDxB5z3JhLYjn9Our2s2Vf6s8c6L3
 /KvWnGqm7mO/nOrT5k8w05AUKJw4tYNbDpsG8ESIkJRLGf8eCHEHE+AP5DuuRrXVp6Lp
 bcIx+cHnxJcdxxA1wjTPbk+HlwwMAxuXftbLOqy/3rJJxLDLeTyepRh7MdL2Nl7JDavz
 1zivbMu2U4R4Hym2ZSOCJEMXcYfihjuJK/W8Mu+O3kqyW1LYb4MOe1/K8Pn62h8DmiZy
 O3IINluVnrZtvr7SMA2cUlA+HPguNg7dJdy53rxXR7+E4dyrkJSz8BS60smfJngyORrX Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1fe58cxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 01:06:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B13iIt029745;
        Wed, 11 Jan 2023 01:06:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4905cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 01:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU9l7cEs7pwu7Se/+IMhBan6MvpHcTQDpt7/KFsvGzFid0m5KJWekrbvtQcuKblI1HAmbr9J/JsXeZpAphivbwfw01vocLoJdjJW2wRF2cIHs7khm/kjIxPJy9BqWtBOIc9AMKPcPd7o2hmTw+gXzxQbzvfC+xQ69neuith47dx65APsh5MLP5GNr4bwktFC+OTkG8SfjBgeZD8FWO7plRgoWNSIyG2DZ1vwrNcw6GxuJIn+eEPVMYxhstOYfUvluqfk4XZ0jtEgsNJLz00HFXT8FfJPTFCa7Cs7AkjqGJ4EXno7HCkyGtYMEY2VN8o+ndNqBQ3FZ9yvXtpi7pdHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBdNQUaTYlmOy5l9nYoBt+IzpP61DBzpzgQ3vXy1XJQ=;
 b=C3az5tRFJdzAfEP6AzuU2eGCOEtrARKPuYXzKAq5d1nWbxEtqUfxDVD2lC+myr2lA3A6whDgHLrGD1Vfas6McbEie02ZsvHRyKVt1/w+yapEZBmwQpL4RIarIop1VOWNdFtks/P3RDhIIdXHoqPn9gEYcpkc094WlZDZaUZL7HusvkkZ3KLz1OYUOUlqPAOOu1ssNoYGUYfmBe/xoanHK17oYhb4YnFgOVZyBUFRkGzmE4ckzN7y8TQA2NQk9LC5l2wWEjUUHKhrUL83Odf/msm4Ykez3tArQCanNAbWSWZrZhbxrMRLYZT0V82vm7/2pHYAMC+OrYt7Wr+Pk8KKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBdNQUaTYlmOy5l9nYoBt+IzpP61DBzpzgQ3vXy1XJQ=;
 b=K6XlQcfGk/ZEyumZ2WFWWPHisoUascMFF+QfweKdykpdHTHugFHfbtCujPntnOF49xIJcXYG4UMtfrwKSw79TU+FbyHIaZjBomh1Pb0bhfHu5Nbe2f7SpUYetvWwDrRKc6r53+L0qOfXkZXR+9nIosTIT6Fw5qHkCKZNiOp0dzc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Wed, 11 Jan
 2023 01:06:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 01:06:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] userfaultfd: Fix vma iterator conversion.
Thread-Topic: [PATCH] userfaultfd: Fix vma iterator conversion.
Thread-Index: AQHZJSNfPVijqOTwG02AmHpqei9IHq6YP7uAgAAn34A=
Date:   Wed, 11 Jan 2023 01:06:38 +0000
Message-ID: <20230111010631.xnyhyc3cei6v5biy@revolver>
References: <20230110184247.1268710-1-Liam.Howlett@oracle.com>
 <20230110144349.43380df0c5714ec015a151b9@linux-foundation.org>
In-Reply-To: <20230110144349.43380df0c5714ec015a151b9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN0PR10MB6005:EE_
x-ms-office365-filtering-correlation-id: ea14793d-acde-4b4d-4935-08daf37017d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzMCO9V+aC3pZO7yX2m4DTQZnsa40AwlGgErAalsYI79WWSk23+9bkmf4uQrM0JNkp6Z2n+yHEN35D7eQSrLnWtVibyXn2UuDnYc/GwMS4ag6T7ZVACaZqTMrCR8/jOAgqQNf7t5ugKjXuJgxQm6mzXBADwIMlukH8DwwEXWZjLLFqwoKVhqp5qNsDdNIVn0bXwGGOCX9HzhwkIj3tHUUhqdpimsLzuaK2iZRuukpE/C+SZCRrbjByB49JIl0sZ9C+ycF23tiSQ4uJv/yub2cMh5xDVtEkUZ6O+j/FoBOCQ5cPqeb4ha6fx1p4zUvAB9DayjOjznWOanOS7X2Tt0PT61oLJJZGCvAkKQYIqFXhM45cPlHWp7OuJB8VdpY+bC7qYX5OYc0cZcSB5FGZShakmS27ENdHR9M8SS98qlnQ/Q+Fj4j2JZUwHmNwn9pt4ph1NzyC/ougROS12mZSgJLPMJ7g7QctRZhNqAMJr0/ULZdJ9U361LQW2jb4BDXSE6Eh7nbpWIvk0VA5V3UsNUzrXbnkk/PgVbN+dbAPQ7JUwOogzhr184vxj9PoNylLn6298KsPVQ85GG2cKgj+ylUUKHRlBplAMNXKHTfwVth+w2yJBCWj4mEz9XYTAPSDPJi0UPS76O7lJdADuJJOHD0AhsLrgQgZic/nJsIO+cMIPlf7qMTWmbRTaSR0WQzxEW/6cV1bl1HRGviBRcaPq7EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(66556008)(91956017)(41300700001)(66476007)(76116006)(6916009)(4326008)(8676002)(64756008)(66446008)(4744005)(8936002)(66946007)(5660300002)(316002)(54906003)(44832011)(38070700005)(38100700002)(86362001)(122000001)(71200400001)(478600001)(6486002)(2906002)(6506007)(1076003)(9686003)(6512007)(26005)(186003)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ADJs5Ai30DIHuoVTsuF2loEoWP2ba1IFkYEPXy9cjXuVfTqev5ZNitjTSvej?=
 =?us-ascii?Q?Pc9yWIZ8xqDDScPSdWzBsRK2PGqQ1E/q1mYGfDVGAYroQJtDMfqSjhfEgN/3?=
 =?us-ascii?Q?TKUAk8wpE0cu/m7UbpEsddgSinY2tDnBGuG44amINmB8pxpcmYye9E1X3n99?=
 =?us-ascii?Q?jeNNGoLenQMPS4lnWvwHs5CCXcNwLNHi15k5pLZfPLQLr1bo92pMzRP8oTZ+?=
 =?us-ascii?Q?epqoRgm2S2iSIuAaaqGz8vY+6nyYQR11b2vGyOWzh48Uv0549UgBEFMijmeC?=
 =?us-ascii?Q?HtFMPSpl7O/vA3h+jVzuQCX14BMRcNlv5LSdEFu5nJ5SS1D5bVzNfrZ1SEVT?=
 =?us-ascii?Q?E7+ubfKug4cXy3Eypc4ultOEPI8rxnzBNhDIumx0ogQMbkZYi06cOJKv9X3H?=
 =?us-ascii?Q?Rxx8pMkNHBvozirF+MrxNU51QZEkjf7zi+kI1Asg/tGEZKl8SpbzjLIDxvmz?=
 =?us-ascii?Q?tLDuu+77LVfvY0utn/vD3k6Xuq4v0M3WOntQ3f/2bQcO+e1wP1xHbip5FdZe?=
 =?us-ascii?Q?KN9+/oylxGk1j3vw2Y7OKILp9WCPQOdnc5ObDuxXjhCoi9BRp+Cn8+iOedMR?=
 =?us-ascii?Q?q5tvNQEJeir9V+496oPPCthz+i8eWFRmHR1O80r7HsQBd5E3L+xpVPw22WCA?=
 =?us-ascii?Q?viOTwKbpbZRYUZGLaZSrYWxbOPae6ymeWytRS2ONWVjaVTRyby2mv/+r0E/l?=
 =?us-ascii?Q?HkTYAatcwCzrSpVKx0kTj+kNOlQ6hjWsgCEBHW+oXk3ong3gQLD2PV/0kyuz?=
 =?us-ascii?Q?3ZD8L4AibafH7aUBuhtng+Bblrfg1TYCuZhFiahWRip11HpavYC8rfHDrlOn?=
 =?us-ascii?Q?eEW6QVQhDOH3fpKjoTbSQd7zD3QwNKXyJm+vOc069tfWAtyBTkupzBcqMccc?=
 =?us-ascii?Q?eOakEYI0qI0xkBB4KwZWGFU9eEsthqNrYNRGW783Eue9TswQ9aTCTlvY1G2I?=
 =?us-ascii?Q?re8vp98eshpviI49EVt2MEmuXFLnICenHNN/aojZNLCGWrwl66aTYrHsBbXy?=
 =?us-ascii?Q?h5/mS5g/Vmw2aF0j3v7Z6pS4gM1HCHwpYIh72BFQALxriU+KMM6IZF6Tw8pH?=
 =?us-ascii?Q?TdAgxzyqsarR1EkyTyqxxnz+pFndHfi6bEc5wlOgobtVg3D72P4rqpuqrz+L?=
 =?us-ascii?Q?0A5U7A97S/Qup/TrpLAwEiAPVhigtA+5zQnkOWqqGQk9AZGIRINtIiqJoHoX?=
 =?us-ascii?Q?zsJVQLUNUCjvuIzB36xRjnu5t0y4Vy/tVWK/Fg3jWz3iXkky2mQNGBu0Anxt?=
 =?us-ascii?Q?QuLLHYf8TODwKWDJKWjEcgo1jNHUXxDN2a+WAkscl3pS2++ULem/DJ5CCswl?=
 =?us-ascii?Q?pdm5fZfuSJV+2ituXXwy0fIO4N6++kTnLLXBpdLoKR0JXykeexC5Arac4qHk?=
 =?us-ascii?Q?zgM5MaWT99xk3fLl3cHLRwwbrT06Sg+8CwKbyJ22ZGGvudRucGEQjgmiXaAT?=
 =?us-ascii?Q?GVVZe+jdv/9bHgLifvfJ465gxEXuh7r5MjgjK2qc3pZ7RaeKwtCM7ppXDyPH?=
 =?us-ascii?Q?VUCmYdNlhio/UOb8Wf/qXGACVdSJMA9e06C94T5segrWbU31g7FBCTd3LE9H?=
 =?us-ascii?Q?hUgDyZbz/XgKj2bEtjyBjX588szLMWsAGZvNSJd4CCnWlMmz21+9ODrjxgcj?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14D38D16323E3944BDFEEE30655829F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c+EmV6xQgmXlg7Q1jd3CwbXNg+3jDTSCgnTX0Tg634Z5qHnGNAn4eF+DKsou0kMTCqxqaz74nSXMsrlGaR80tOxQFzfyWTcJM557Dao+Mww2GzEvPkU2KhR9AcA9DN1MpI2NEi6TeoKeOmlY7g63oAL1VQaS9S8ksGm8REksx2LW5lxShxbayofRXDMXl8IVb9G89UbmfqpWnZRsK83zw2/OFl08hSbKnPXhaH1VYg5Fw5QvFo0PXBk0I0jteoL/uG+L+yytYNoF+eMpjzIGbWC3onCghimLOFIwTdTeGSzzU6gQckYMaJX10uoiHWFOcMhKSRRXsO6pqrBrUpx7zqidKAGJZrDUPWfh4ceebxx3jlIF0bvbVwkaRYjriLrpZfA58UXfJd55p06LkwP1BXCMVvU5GkuZ5YGcQrfazMlUkmTkUq3lmWbnUG2D2RKgVXiFPDA43J5XW1oRKQpt2pGYN76u4TCvEj3tzJhvRwZ37UsYIcZ70evJsRd9yaVlz9ejBVyTttmQxc1XeU4Skrp2kIMX8yjQo/KfqQkcjfL2ueeqTcRGP49UfA05Vz7AbIK9z6d0DvEifRTjZIM1LbuUk0N0XFkL31CEFY1prOTCB4+UG8/VxEPLcimJAI8FK3TKTYzTk5mEHcdEOi4czDlwXRQoPX5KNeNyhigJLfg26R+5Az5y2sXFtET7sr5dB1UZ3pHIF/EvAGWmLiBtq8giS9LX28ZN43Dn5wNI51SiGZWxyLzYaF4VXPbeUNRnuUP9QuM6UhcZOWIZL4YpWMo3IzmC5ju1IXuPkkucd44loztSsYYdnFDQ28M5rXnA9Ti4gBzRCtHQYMQlGDn3V9t00V3/zkl2jsfDH2XD+Ja9Cgb/oPZGS9Pj9fbywfsD5Kgh4gpTMV4FYUHErl3D2w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea14793d-acde-4b4d-4935-08daf37017d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 01:06:38.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQt20lPcbFlSf7NfdRhF451vtgY4QRiwhs+T0Zj6sfNHS+pn7RJdJ7oT1AtWq2+FLFWVrLDexL4YEii4aKC9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=788 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110005
X-Proofpoint-GUID: GrGrOyG1jpypHNtAV2SD-UT1tlviVl8P
X-Proofpoint-ORIG-GUID: GrGrOyG1jpypHNtAV2SD-UT1tlviVl8P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230110 17:43]:
> On Tue, 10 Jan 2023 18:43:03 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > Please squash this patch.
>=20
> It throws a reject.
>=20
> This series is getting pretty mauled.  I think I'll drop it and ask for a=
 v2, please.

Sounds good.  I'll send out a v3 after squashing & cleaning things up.

Regards,
Liam
