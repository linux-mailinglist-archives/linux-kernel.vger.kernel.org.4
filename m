Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5B626032
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiKKROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiKKRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:13:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B03C6E2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:13:46 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABGiv6R032358;
        Fri, 11 Nov 2022 17:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aN100HvrIQVzT1MJBCXxSF2cAkpJbGh+p07j3eBlVcQ=;
 b=1K7ARYJlt73emwJC/dylYYqAEfj/VCBO3oJdVDITfba0GBHUZHj1qOkDlKzzUnseP1t7
 nKMF/abof7Q6Fq25auU6USHCbRJT4emGEEzO5IUffsJ6bvMIDs2J8+daoSBCDdEcNjKB
 cyyfra1BRfuRWnUPW3jiWhUHv72hajFveXow00c+1EcER0k6vfgYYtCKC6PrBPMobwYl
 C0X4gIc/9kGOXffx3qGpyE1qWafJDfeUrPuNPyFMulosg+yARqpxqNSK4O3RFsy5rmq0
 QuKaIpndkSjDZMv5l3MqDrOHs3+UsvXGUkW1wnbYrgo488FU+e8zxq3jDf+TBr0sAujq Dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kst6d021y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 17:13:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABFnLa1022351;
        Fri, 11 Nov 2022 17:13:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcytjt6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 17:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyZJ/E9Rko9evUsg3tbKd90MlVz/B66Hol6DnXDQ0zt04w2/BtGM/hTDizkNy1uceT4BB4DgA93MF12ic3qil3JLBzL5Vi1/kRvi/ULma5EbJRvrIRZksArzj79zRZMsFB6TQ/+N+sDeOdARESHg97hp3aixuWatmk1+B4y9oPLuujMSyv0/I8KBl0vqh8GEBfyw9OhrvkwLvrRpHhu43tAUGPhifZSye37pPQ27c/VMLuEpufntAVkrxbEFfHuCyIbsAP8c9q9LQJKzCx/0FBz3GlRvcN2EqgGKY8E9RKpLvvjax+zbfAp824Tt42VItvrdKcKPIX5H7t9yhyYbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN100HvrIQVzT1MJBCXxSF2cAkpJbGh+p07j3eBlVcQ=;
 b=DfgqBwWfu22wnWMtHOEx4KbAsdkGwY3bsiJ/Yuqbs3k6e8Q+1059fVowFkI4wpr6iSNYdBE1oeaCm754/6MvH1+TyjAQtUuOriMWiouxvxnbBP0AruJlaGCYMG47pmLIDyAIalPyAe1nhZe47A3wUj27r3yl47HFgI3BZyITZbjeQTtYOe4EB98LCYQVjTCKlpxhCp0QbQx/U1X2GwqEIcol9j5Diu8LBSFHP5qekn4lJgub0tdEU1rr8Ffwx8wVjEGrhaRTK9AE/q7TCqchcFSBi6IL/hlazZH/+XuisZWC/CvB83d2chm/57ZRBEUNT6sMwzFrh4/Mnk5KnqIqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN100HvrIQVzT1MJBCXxSF2cAkpJbGh+p07j3eBlVcQ=;
 b=oW/jd4md66wS9pAaOxznFIOZppmDqsCzAU84wWuZFTrjf9OrHE9a4ncwGjgF0kMkvGiqfQNTVhxKRBgqEgy01cgn1uQyvqxkcP+edsPe3nCKUw1wdanT5wBKMt6Zr12ifqGM2k5EfAv8u+IFas+qT41QP56OkHd33nP6Lkzi94s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 17:13:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 17:13:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] maple_tree: should get pivots boundary by type
Thread-Topic: [PATCH RFC] maple_tree: should get pivots boundary by type
Thread-Index: AQHY9NWT1J4wfyUtEEayLl5nEGbTbK44VUmAgACpSYCAAPl6AA==
Date:   Fri, 11 Nov 2022 17:13:26 +0000
Message-ID: <20221111171304.anaqymv755udarxe@revolver>
References: <20221110072459.23656-1-richard.weiyang@gmail.com>
 <20221110161239.crapogyt7owdqd7y@revolver>
 <20221111022009.tfrap5qx5oy5vnsc@master>
In-Reply-To: <20221111022009.tfrap5qx5oy5vnsc@master>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB4972:EE_
x-ms-office365-filtering-correlation-id: 9288eab5-cdea-45a3-8c17-08dac4080bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RR48fJJM6UaLv5/v+0JAxDWd/JXcT121fdLndNjQB2u6Al/0OxQslyNeVQFFCodu4mLCQH+z5ulBkKwgqpjua0j2b2cJ9SvI5LzxHvJkQhCOTT+wbL9d2aIBEO9Ukl4dJSqLqSRd+xUM4kM+ljhHHDvPnvT0s2pC7tYyvQwIAYsTZQMDvUnApXIYHxyq8MOLULaH6RB5Mo98fPb9Npgmx/pzNL+NdmGgld7SsCXsWb06eagy+lR6XZArkUmkw3SmF/qJ5eOBkmKW9gneGgmRnuKlGOp2JdzXgBcefPH7phIUvZFYWq2BZBJh//+VqX1+GjJsefnMVeTVe3UFYb81kV2QqN+KKp6y9NZH9QvFa2u1tAbD2acRfeXrHTRzt+kAn3/djAu4rAli21TCZZAxqkXSS4buFBJpA6Fw22EvgEJPaXeKiO7nEMo6M1abzvQJQQPHOnOEfIGmwNayrjmQvj8AVP9ywML9v3NYrawcR0bdn7Fr00jyW8s7D3zD1pjRjvUKbdJGSQHbjSIGq+Cq20fk3DoorbKVK7bAWPohXJ6prLkuYath2Khaim9oiFV4DjaYOjMKOzsqytHPZfSTD5+6xGPizHmX4pdL2Jmaz9jvo+v4CMWVH8w6o3eJw+D/+bZQPm3Vs8x6Hpfyj+YYbSRAI1r1hpFElAH3/SnsGplus0Z+qgDGOKEhP4UWanLbs30lJtvBuzAXtJv6LfDnBZWopx5L/pqXZXGoHyf+G0X+NLwXzCIdqkJv+eKo6+e2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(54906003)(6916009)(478600001)(316002)(66476007)(122000001)(9686003)(66946007)(8936002)(6512007)(66556008)(66446008)(76116006)(8676002)(41300700001)(4326008)(44832011)(64756008)(4744005)(6506007)(5660300002)(26005)(91956017)(186003)(1076003)(83380400001)(71200400001)(86362001)(38100700002)(38070700005)(6486002)(33716001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WT9xLdt0KVHEshbV8XjXctR3B64XpbSUuSndId80GOg5cNlRDt4u6wmBABQg?=
 =?us-ascii?Q?9kFLoMAiwHqZSsCyKyF7k/kE+M5cEwi9GqrYt0o54CROc3oV5BL5GzeDE6x2?=
 =?us-ascii?Q?TXI1kJeCeX9/KC7oxFD2dKTQSruXgKSXc/pB7BQLp16k7ucN+KuQfvSjbDkg?=
 =?us-ascii?Q?USDrY9EtA6/sTgHopjxzh0Jkl1zBgKtVxKscq3EEE1K+YPNJswttF0bX8nav?=
 =?us-ascii?Q?+tcWz/N1q7wAqHT8o/9hgu8i2Wfehw4/RtCNWmAmHz2LOw7aYDgSu1aAvD9a?=
 =?us-ascii?Q?s4fQ8UvbGnYYidC0YnMAZ7N3VNFN7Cehc0RiloXSV92qGGDayYKYmOkuaVIK?=
 =?us-ascii?Q?JzyPacFNFk90eFnqQr61/YZfIL4i/fIJk2nBNuMtKqOBT7EXbd3kc0hx/C1E?=
 =?us-ascii?Q?aQNw0Be4SsfkmGCe0nnYdbjigaYQRZOVaVt6zqHeLs4m6xnUskEgkarP01c6?=
 =?us-ascii?Q?xNwQ2iDhVEWzP++PDoL/iVY58n2VMxkGPWNOvL6uFZ+VBLj4xuZml1buI6RP?=
 =?us-ascii?Q?Quf6ms7aHjC3cehtxa01+W+a8EiOjQwDU4tPXM9k0BC3XrYoZqFqPqkg4vpW?=
 =?us-ascii?Q?2iIGEHmqeLKl0DdMZiYrdc9Ej1fsm8ZOLdauT7VMXYpNvNp853AdgxGf5Iuz?=
 =?us-ascii?Q?JX3WV8jtZytK3XfihNROrD9oRkRIZvVn0VniwaRo3CcPYGzJC5+LKK4dC28Q?=
 =?us-ascii?Q?rmFz/mep7u6ILlvZ+ws4Kcm8InEuSYinC9ViIYmuafrgqdMF9Q7WNOlAHNlk?=
 =?us-ascii?Q?bhcDNb1vLBuZczlsUIBfRFM9SgMFWTBnd052NTCv6hkqSRdq0/Ay3NgyvoWD?=
 =?us-ascii?Q?IPohqk61TFtO8y45N9EC1TkPTjIIScoFGsJ0dgrX8wUtVbUb0HnwgiL7eCvO?=
 =?us-ascii?Q?sTTLudibhf7sY6NBZs7y7ZYqZIgrSPTBZnVuGQehQo3/idti7uGLx62Djqx+?=
 =?us-ascii?Q?sOHxDbLPQOlaN7u0CJ3e24556EgCrw7rfciMPoTnnTTQMLvPNConr5RDB0l4?=
 =?us-ascii?Q?NZjWfLqU0Fz08bLGJMLC2DBHown0QDH/bFYiG53lj4Vg8jv5RJGL7HCcZNxS?=
 =?us-ascii?Q?9/MBI3CoW4JTiRgj4A1W6AH+qUYYW2Z71LB1frK29UlK9Vp2a2i4SNKIYqmv?=
 =?us-ascii?Q?+i/DxnMLDmNXtQ1VyV+ZPKo8eKwwQQAZvaG/dfvgN30k0aZVW74QJVTJHFIX?=
 =?us-ascii?Q?JJsnlK52eUIGNg61DQHDNo86Uc7v7tO92iyedSMyD6SmT52YyoMpKzcOTAF2?=
 =?us-ascii?Q?JlpaKkIdR+pDVX4jeAmq3DuLLT8hDvWcphjLwMMxz+XDUbyUr5ETV2XWtT2J?=
 =?us-ascii?Q?49ltAUYfaR6q4ERY9oZEQPTBMGX72Ofvw6JD8vcJsXBIlQUBcZ+1c4May3wb?=
 =?us-ascii?Q?jyQGPEt+DCpnI+3zaQXMH++CKSLs+rBamKhXQIudFBQ73wBmGqFOdtKh+trV?=
 =?us-ascii?Q?QX7A+VkZjelK18O/Sv0aGHoaGCQwmwJ9YzYw2Dd2wqgyZ9G3yHbi/jq41lzc?=
 =?us-ascii?Q?/fd3dmWs9N0mPRcP/cs22nAfd81r8qZCHmGL1Sxqgm2Z7D+eD7HJ5NmFLKNB?=
 =?us-ascii?Q?AYZDs7wfOeX5gRgo0UdUuNZLLR/5GX64+MKiR4bp1uP5AhNBJXaMHnczx1C8?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A07D689A5E69646B15F46C4F4BB5C9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kv5X4klQsFt+ML/oZ9bL6oDLdj3gm+yTNNSX9Ou0yUfScoYPGDxDYzaH1m8c7O6K54fpXyAIv4BxM9iVQ5TXsD85o1l8hmbttUJO/nX9LqNZPYqNuzkdbXTu/BZhJPuUZ19orP03dwGWxCEcTQygjPqaEy6uQ69c9Oyxb8JntYhwzsBP6EDpxEfbVRi6XStnRsWsFufKmZIVNOBsWgZvxkNiqj3fu8SiP3yp/NHxtNmIiIoOhYtOeq5pdAKLiUgrwGk2Chz5KjE5JOw0U4MhI+ifIUizvWts4jTz0LmuW/Rq32gkyhQGj+7CM0XcHjkiuTp/hV9H8VDnY1Ic8aAL2nRuVOj2crkv5xzl8KhDG36519rQSjqvJy1owVtw+ADl5PQ4+eoF2Pd1+X8sah/N4ojcHjBbbEUIHsVCExxwyKqWW0mIdqyU3GYqLcN0X5jfbMRuSeBzOE7HGZot09eWBqSB/IwwpVCSGKATWYTaEnIj1xWxtlSza+Mzg0dSi415rhfcMREFQNa3WuZY+JSud4mrckoOU80vvCmog/pDB9dtyhC/5Mdfyh04noaxq3UJUtCMPFyfJ631RTvj/eEd90hac9IqXyANrfbuQgJdvNLJ7MB83L2wkBIroHLcrNyR5jt0Xxri5BTuNv0gts3Dq5EgZZJKYZDM3omN4UdyLXmRvt55kxW6m+WK+4VJsr+YPtuTCnVCX1jBF/0wUx8Jrs9ztotFvPUQesAEvZG/gbz3bqeZ+PTyFjCVKUo/i+2FBU1dVF58LZuJRfAEjV04vk8MkLXnihwabPcJNjJ0kfISOFDMkYu+pe6IosZ629PH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9288eab5-cdea-45a3-8c17-08dac4080bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 17:13:26.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glEMegEjfblCa7cZjumlSvMrIv20EYBEw6YG6+5BjyDqTQHNzNdZCrO3/76V2jW9UKeavcx6cEuMCRSyFLJvyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=975 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110117
X-Proofpoint-ORIG-GUID: y7PY2bmvScMPP0UVKTnxOMAhMy0QXWM6
X-Proofpoint-GUID: y7PY2bmvScMPP0UVKTnxOMAhMy0QXWM6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wei Yang <richard.weiyang@gmail.com> [221110 21:20]:
> On Thu, Nov 10, 2022 at 04:14:31PM +0000, Liam Howlett wrote:
> >* Wei Yang <richard.weiyang@gmail.com> [221110 02:25]:
> >> If my understanding is correct, we should get pivots boundary by type.
> >>=20
> >
> >Thank you, yes - you are correct.  This is a bug, and should have:
>=20
> Thanks. I am curious why this doesn't trigger a problem yet?
>=20
> From code, it seems we may access the out of boundary array.

yes, it would likely access the array out of bounds.  This code is not
used by the mm code right now.

>=20
> >
> >Fixes: 54a611b60590 (Maple Tree: add new data structure)
> >
> >Please fix your commit message and add the fixes line and resend.
> >
> >Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >
>=20
> --=20
> Wei Yang
> Help you, Help me=
