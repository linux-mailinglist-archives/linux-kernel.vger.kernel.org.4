Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9C632C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKUS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:28:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D656DCC174
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:28:50 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALHeC5t003025;
        Mon, 21 Nov 2022 18:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dI/sWxdfkvOZisWKmGTpQ05Cb5PcTYgwEs8HyQd6zV0=;
 b=n+4YN9Xhlo43LSZgoONjmzy2jO3OkUC77Ppp/bAwg3x3i7FmM3vQ3dIiu4MrSTwmy+iP
 8RbIRnUT0MChtoOfCzhMQmIfEQ9prN8BxzZJqj4uVhFMaBKP3xYc9DQ3jZ/FsGWPLQu1
 CPEMG482YToNUtUMtBoM+ZePpDbg2zx/5uXNnYwQlZvfEzq+aMg0NGNJDqlyqLyDcTKU
 kQs72DNwRiO0m4T3Ymix80DrqGDGUTZFl1HJzIWIBNVi6/pyyzI3qPqiOHuELBE3NIys
 Rr2xujddgRWu93/OylHIS2QQXPwTMcUfy5sGp6vs/FpcdRJoZKUAKWDeFun7i6S7BE3U NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrfawe0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 18:28:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALI7dFt007431;
        Mon, 21 Nov 2022 18:28:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk4cc5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 18:28:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjVQOi1QsP362GlJ5yK/VP7VgMBYvblHTzIeZbVlDfJ3jJWM6bYwa3OBxdZaU/Pn5Se/2c5GA/GCpWMmGgwSq16WweYsIVGXysZaJa1CRFCtzj01m0a1lHV2o0tSt4pQo0Bl3QcZ/ONXjw3WlqPqn+FQqQrvmGNM+OyulELjBS6Mj2sNx5dAuizlSOI7zvq5ALUaN7DopMtCfAeLkMxOn1hR9iNQahxAux8B/Fxwmd2N0Bl6YtfTw7U+82gWhVGtv/EyUwGbJcIlWKnGP+FWSOoqv6U/F3OokXQT+ObcyJLYB0aFZsVxildZMpbQCqFzuuaPtYefcY+NSwsFvG/4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI/sWxdfkvOZisWKmGTpQ05Cb5PcTYgwEs8HyQd6zV0=;
 b=gdXWQdYtIDypUXAINtASrov90YIBUYn2FHPQlVRy6BtBt2zT7KxxXMFlm5jLFoouvg7eDW9QPRQm5IQx/ud4rpR0OahyzWvVwavDKe/5L+ryrQdENywWlSnnY1XeGryGs7OfwzkzKLFScmB5ukCwtKWTpXZ/1bPAxRTn/xSZrMxTDY8sFwSruPUHf4pVeTYt3X0tY+/NX+hDrh+A5yHBCgBgpRQzlSHlrc5ch/yqA0H/qHLUxRJvrAUhHGLy4LX9ggRiXQcg+BQo/3Xwupw4x+93b5ibbapTkASCXLkuLJNrt7gksKvWP3DqNKwluGufb28opyiXmNesvIqHCG2fBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI/sWxdfkvOZisWKmGTpQ05Cb5PcTYgwEs8HyQd6zV0=;
 b=PGduE83YLuX4gth0k6BNMaIuUBDH1ItIF4CnbAgUtPW4j0Sa5F60nX/xG4H4kR24djgNRyt+76oPVEJWj3EzkVE/Y357/vb/EQwBQjiVt5/uM3kh49zJagrSqNLWkeplXz/RJL1mvIX4Sj0xa+aYkyFLubQgUiuMR3jrj0IEHDQ=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SA2PR10MB4443.namprd10.prod.outlook.com (2603:10b6:806:11b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 18:28:40 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::76e8:e14a:3720:b01b]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::76e8:e14a:3720:b01b%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 18:28:40 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Add a new generic system call which has better performance,
 to get /proc data, than existing mechanisms
Thread-Topic: [RFC] Add a new generic system call which has better
 performance, to get /proc data, than existing mechanisms
Thread-Index: AQHY+4GmP5NllLDqPECTxLaw13LSZK5F8KIAgACWrUOAAPPsgIACO2aH
Date:   Mon, 21 Nov 2022 18:28:40 +0000
Message-ID: <BY5PR10MB4129F1DF7593EE8936714521C40A9@BY5PR10MB4129.namprd10.prod.outlook.com>
References: <20221118191202.2357801-1-anjali.k.kulkarni@oracle.com>
 <Y3iYlLmxvIqn/ETF@kroah.com>
 <MN2PR10MB414411D0E29F20412E6DF0C0C4089@MN2PR10MB4144.namprd10.prod.outlook.com>
 <Y3njl8c0Azfq6QKm@kroah.com>
In-Reply-To: <Y3njl8c0Azfq6QKm@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SA2PR10MB4443:EE_
x-ms-office365-filtering-correlation-id: 013ae3ea-a40e-4bf9-8be6-08dacbee3688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hD32q49HDREqRWQefotwIFAhCJZ5HaFrkDcg28uBR+vcpxd7V4lQKdgukYv1lczp4j8r20+qVtoTH9Pmf3Ln1GU0w5hxznXINr8mplE+Aqqp7f03dXDvoP9v0XxjjnGrofF1PJx8OPtINvMo7dH+AXx8QdUoWOgCsprguZR57koadVqGp5SUm9Xlkh3c8YqyUjjwT3ULeU7CXgFbKsIonVj7KFDRFhN63cc/34HcXtmacHpNkZ+0MTcOqE/xks21WCBdZwJ7wAnpV52AW6qlIEit8Ytolao1RkXggD+DG5dTCVR+8UCWYJ7CdQrWnlYCHPRdgmJHILxSW6o+Fk6POKDg51oO0kQqG1z6BltxuyCXFd+xHvS3rBtOX/wh5zL5B2ITQDTvZxOZH60B1VO3F7y02DJdx593o8MdNwaYcBmKVub9edZ+Dc9yySNRe9lTU8SJ4tRSuJrhkVuloPrpSVKYqGiXi94Rg/MQT9aXMrbIpluayHQrs6FbSqROVge+HKecGtvKfn1J0nGwliiHoVhCU7FamWdt5xyVpjiebj2mGNYFNzxcexCczt3ROzE2bXog9Ms/zHnCwsgaTROfUBM1G9XWiA5HFLPfTjJm2nr8399Ylr9CVVmj/P6pm8hEokOw3yinIcBJq8EnsSU0D9rH0jOxSgIe3OHeXseZb+i2dJoGbFdLi6VjQwV0BdixHc00WgANiy+iOqekUGMupCMoIJf8PwCJAkoAvbxQSzo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(76116006)(66946007)(66556008)(8676002)(64756008)(66446008)(6506007)(7696005)(9686003)(66476007)(316002)(41300700001)(4326008)(6916009)(55016003)(71200400001)(33656002)(52536014)(478600001)(4744005)(38100700002)(2906002)(122000001)(8936002)(186003)(5660300002)(38070700005)(86362001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jww6zW6XtulOuLHAvSTFykEIm+588VAsggt8jn8cPAdGzPufrfbdJxfE3J?=
 =?iso-8859-1?Q?IucZKVg8MlroVGY/K+Hrj7w4/6LP2BoRO56h2ygHkfFnU8KGRijIVX5CJM?=
 =?iso-8859-1?Q?MGMgEr2Wii63m+gy4voMy19DlCj8QtVqu7XwSYKNF/Yb1yIwxQoxd6McS8?=
 =?iso-8859-1?Q?fsGy0SZIbLJDdocvMs6dYmiaY/5gCd/oKkkKZzoBD47G2emkqt8mOgR+dO?=
 =?iso-8859-1?Q?PZlL2cJAZo+RsWHBibW+Cqx8R/VbmtYPCxrDDqr79Ga0Oz3Nmadp9iLcNh?=
 =?iso-8859-1?Q?/FvcNPWfdiAOlnGmNURQyQfpcAwHNGCj4dzxCFlvqq4DXMJO4fwiCVhIMr?=
 =?iso-8859-1?Q?yh5WiQ2bH10hLb9Onc11iMMvYX4c4LSGxgSIDwS2HXzQtRupY4f2AavVdi?=
 =?iso-8859-1?Q?E3HyZMkPJtqhCsZababj/nPSWHeohC96gnHEyzcy9GSVw9GIxZMN3ozkY6?=
 =?iso-8859-1?Q?DGB/dmBnVHkwrBYhByErn35LCKMX3Ju9fa4eogtsyy3MuogwyBqmS0n8sm?=
 =?iso-8859-1?Q?JKixuWpUqOZ+oVXQgTprvx0hLc4JWRHmiCWEorx6xLgn8aaOAyyBoARB1m?=
 =?iso-8859-1?Q?kOOt5hOO+0ADY/TvzMMFEmVR4wsskOeNbI6wtdDdHj+MMZPqp2XxpWsLGa?=
 =?iso-8859-1?Q?YUR1wA5xDbPk7+aMS/Pk6i1FQ+nlI/osCYtusTj/6tGL2M+q+ZRiGPqKEw?=
 =?iso-8859-1?Q?AAajBsJ/bxJIKzMWbeO9Dih7gsTpv6HVGH53wyTkChDUXFt9wXuGaR31LF?=
 =?iso-8859-1?Q?OcydI1uhSoY3nZN47NqIWOXOoi82raREDcqNqIHbeLnDhd9eJ7BksY3vn4?=
 =?iso-8859-1?Q?r0EmhsmkEoitc6/uZl3WDDBKry+sLMz6GuKdty6iw/PlxBa6NsSdOWSpiJ?=
 =?iso-8859-1?Q?Q/B2WJXCC+fIMCJLzonOBMc62XGsZ6FQrwIeN/1FIAhQJHlqG5nO/wegLl?=
 =?iso-8859-1?Q?O1I2+KIhBE2/OYhjmQz0KgPZqRvM0KphNeKdi7eDekkEBKUJIpa0tS++YW?=
 =?iso-8859-1?Q?Tzd9L/RLjj09MpHBpu6V955LfCJneTrBqDaNMulX5LIgVv/X5lTRtp9Tki?=
 =?iso-8859-1?Q?J0PjDOtptn1fNY2IcPa42EuScW/+LRF4OcVpTqazZbl0csC0+3gOIlIouT?=
 =?iso-8859-1?Q?JNEg6txgno0JKb+ywYmSD+6yb2c/Nye3EWAAx7Rey3wNredZ49kd+63/O/?=
 =?iso-8859-1?Q?i0qf7w5k9UCCwulkWUJS4+iRf6e7LEImYkojqwXP0/wv+nA8OcmswvAtfj?=
 =?iso-8859-1?Q?YK+t36iEu73geRS1TG5aAnRLQSopaellbT/DrCrjinl1KeEYtH8C2YMLyN?=
 =?iso-8859-1?Q?7xrJihqI9CtFYrn1IJul65RBDtFRFW23huLoWvsIWGyjSi6oRS970Bwv3w?=
 =?iso-8859-1?Q?bGAjx3G5htaxKitOHkws/3N57nKfXKiJH1ceqeC4nTOys94409MBt8gqUk?=
 =?iso-8859-1?Q?smHGjTu5q9I9sLTQSBM4QWKT6MRYx9PkRKtzYbdQFCFuD1TrA4R9pDzO4o?=
 =?iso-8859-1?Q?kEN3fqKqLyBhXWz6gnnPu2xPNa+U3IiN2PGjzdU6FOll3pdzpNHSFXfQgZ?=
 =?iso-8859-1?Q?YkyQ+NQs8r1Lc7FGfpXL1iqJ58dgT4zY1qJFgAIQDRvid14KQv9cJBnnHX?=
 =?iso-8859-1?Q?SE5HNNvaYq7rCS2+uEJmdGe0q4kuLQbhSZUOretlHGu9IXmad5a6a6keRk?=
 =?iso-8859-1?Q?EfJJ687i2yqGjRZzOOI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l7UHGAJvaq3PSb/k4x/V9RWVCUZumPd4z5+9ZJqr0FNZQlbzUQs/TnaXETcMxggy4NUfaZlxaPgTlXAuktgCSUIX6H00MeCqThGKdtIVTiaSasqvCLWLaBIEBJxTv1YSHAV58nVZl8Vkc138XMZ9ZSni8j4Zp7rmTMCIafy882ILgUwGX1XfLUYXYTSuPpfduSLMKTT2NYBRAO/z9w6au6nlDfHcxzjs/2tF2SAsZ2fZQpwz3FcOZ7KX3TI1yNkQ/dMpryIsu9Nbpv/7RgT855TU3F8CuKSVFXgvRgmOHSxrylqJb47axhrwZXb6oAcxs2Ncrf+1XJcT+Iib1OLjnoxNpZ0jWLr34SuEU7AeaXFkZQvHPD5EpT+5oAkWrMmQON5hJPykWHyIFEstZhgWFm1qeTwiDCEQ5rUSfTOI3BQ32AmAppysbMfyfW1bQBu9Wy7S30qtH9RsdW70hAvOldn0BjysYOFPkoq+eKRlBqm8z8ekRudnNIkUhBXq40ZnZOgKkQ7ycVlvNfCWXUXj1k6wiMIeb4oB0kYZRwytX3+ItZYsP9yOlksySoSbwoe5BJp2A4FbZuHeqjSUmI6ajpT/NglOqGvY4CHMMqFRJGhIZ5srEPgbao4k3xspDOkM3TckcFcKRyd21RcbAnUEXYl/1KZYnhSwIaBmBWChPsInjOCCY0C42kzljyArjyA64TDqW01SXIZYBNi3Ag8/Qybpr2b28mNv1/yDWmb0pInozL4MXEd2eAjQgOB3gB0r5DLv4cQ7adzF2q1ErYbSfEdTde+m5BGJlYmLsvSC5s3DLUHvMsCCkt0NZrQVwOyw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013ae3ea-a40e-4bf9-8be6-08dacbee3688
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 18:28:40.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD5vdecRiEs7L3i8YZsRdGrocnBGifzzM6dUit7d/YobPioBkWC2fSElmoxzPsBnnESywTvTHkSvrEfnyIiW69XGIdSGzniW4dobano8O6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=933 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210141
X-Proofpoint-GUID: NpHs-WJ900tXwqAZciMYFJWfyiZu6LCz
X-Proofpoint-ORIG-GUID: NpHs-WJ900tXwqAZciMYFJWfyiZu6LCz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
And there might be ways to convert binary to strings, perhaps look into=0A=
doing that?=0A=
ANJALI> I am not sure what you mean by that? =0A=
Could I create a new /proc node which is not strings, but rather dumps a st=
ruct? That is what will help us the most. Not sure it will be acceptable so=
lution to upstream.=0A=
=0A=
Thanks=0A=
Anjali=0A=
