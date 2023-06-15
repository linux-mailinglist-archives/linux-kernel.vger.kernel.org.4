Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55F730CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFOBuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjFOBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:49:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE28DF;
        Wed, 14 Jun 2023 18:49:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK5jjZ018120;
        Thu, 15 Jun 2023 01:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=JDrJY6aHYZmQdbcWrElbvX00ReFGYL3paDSmsEREJmM=;
 b=2wBAkAMwQJSxPO5tCaW/9qxwtdyBEm3yfF7oES8a8ItaMtV0VVnzy6A3wxceSM2c6jgr
 Wl//Ksj12pj0JFl8alPNED1IEsEil2KD/+dyyOKY63hw9n8dxnBla+q2smQ9WX7nzAT1
 kjv2JMWhI6zvVIwIinbkXXhkFittUY9e0RK3i97ua5Si6RSjxLanHOzQh/Drfku3CWgY
 p23fVcVN3jL81ayy3uPNzQzES/U7XpKl2CfDatsyPKVHTIv7W591m/gSL0zZfLy9sg3Y
 nfjzACnSU9qtkOCXqE2cLANE7QvonhZ/CimvpzpDhxCs+XnaiVcUCD3ijacMStyUQG9P kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d8w16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:49:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EMv5sV021623;
        Thu, 15 Jun 2023 01:49:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6anvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfRstO/10GQmffT11+/hWrScjbwxzdxpgQUa2AEXLZec55QZuuuP2nfCycMH4XeHcgzy2gVPk0hxDFpaczlePiz8z6PwDiXGzytKBa1QMDAIb/TbC4hLp9SEoRllWBpeOkqkfpg8iplyNTUyCDGd56Xu89InEfZWpyzCgnmDurXy9EQlPROQaPi3mIGomJYUA1cEL/bQfstZ5edGodIgNe8Q02nXdUXFOcjFZwg6XKL6SAG6HCU11oXgetX6L8KzteiOuvPCnXgUG2AmpSn9tBhxi7PeTm1YNQm0+EgwXasH4V0qJbB8cT+n+XYuKH3jq+D2cqHhvNkny+rFiqhXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDrJY6aHYZmQdbcWrElbvX00ReFGYL3paDSmsEREJmM=;
 b=PL55Wt1krzyamEbGJ+262lOqQjLPmQiU2ox7VZRsgZIRTn8DoELkD+DEGtLgPjfBLCHcdaQ37fD+8B9O5ioJc5yveJ8uUfYal/M2usxIKQmhda+Rq30xt8am36m9lW/qa0PyY5TIol5zBPxe3aQ+PXm75pYk3LcKCSiGGkKNcfx36Bp2Wd0a7n7U4mU8qDuKbRQGr4kMbeg8cJrouRu5IAl/NQHJxFWFHwWQp+k52HCBrbXqNKhx349qh/rwyTddNpjAe37USckhUJ6FDmY7Pl9D1txhp5pm6jvTKnB531diVZ0aSqHxbnDI2kLqE4SuSXABW92bK9zLw+dgN4gofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDrJY6aHYZmQdbcWrElbvX00ReFGYL3paDSmsEREJmM=;
 b=N5uatdyeh3DsQ6biL0VJQdJDrx+YoruLgqUTVPBo/SAMAR5pfMo2Ry8BWKc8ut6mVMPF/zaqZUf00WmOE+Y1ensDRUOQ3BZ1XWo44yH9UKgKI74Ow6zvj/zPayjcYldUseXiuQtztesg4zuvNvX6LWlHnhZhlRI/XAZ227z2AiQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 15 Jun
 2023 01:49:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 01:49:30 +0000
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RESEND v7 0/3] Add dedicated Qcom ICE driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a5x1wl4g.fsf@ca-mkp.ca.oracle.com>
References: <20230612192847.1599416-1-abel.vesa@linaro.org>
Date:   Wed, 14 Jun 2023 21:49:27 -0400
In-Reply-To: <20230612192847.1599416-1-abel.vesa@linaro.org> (Abel Vesa's
        message of "Mon, 12 Jun 2023 22:28:44 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb35929-44f0-4c60-e210-08db6d42c28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vg38sL8Gpa0b0R5m1QAhgqA4fm7PQpjQFn5e2JHbHXGWvlResT4I2AVEKJJtTP4WhdItz7Bkm9pm43BdAO6BUmFfdFNV5/RZTZdWGm2vnW0roxvdXpTEpZimfrR8jLNM7JX2F0/zaPmv6R+xGHP6aHNutaOI5Z8RIacO9BRfRuwxvmXP+EXdMQecPzWTVPFfE78Jke67NMJd5LfAwmL4iT0fUV3R+C7ZXRaeuqIAor0ApQu9DQctefgrs/wzEWTmcmiJFfDLkFonUye7hHxKLTFEp07xVFvIlcpYWMBhxWxtdplsJJgAJJ03EkCPXUfxvHFwcOhDE0JQCzfPEy2iCEsl1WIkG3qaERYfbchYS/7oY5WEV2gw9tA8IiZ3kiKVjgQWrbChZq2KWz2QxMKcvLS6eotGtOPg8TzDyo+u9EjWaAn3HYBf7JBaVPhlJAe0BReVz19ssx473b/1vrCdaRgD9nZFE79osnGDazkDXC6wEEtzkHDUv9KfFAdkT6EkMiUA+kZKx/pktKu7kz4xmvk/g6CLDLxDjlLRtYqOxTxT+5t6Hjg1occqoF4xXRgF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(26005)(186003)(6512007)(41300700001)(6506007)(6486002)(83380400001)(7416002)(66476007)(6666004)(4326008)(66556008)(66946007)(54906003)(38100700002)(8676002)(8936002)(478600001)(2906002)(4744005)(6916009)(86362001)(316002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNWuUt3sKGT5DiHe3OVH0thbWqB6Qs+m6E0KVqXwUTLl/iATUGdjXJ2uYv2t?=
 =?us-ascii?Q?XeZdh+eYEyzRbzoKyVebivM7oMgIym5l6KcbPztu/5z+NSKVOQutUMKx2oEZ?=
 =?us-ascii?Q?BCqCA9Luct8leUShzeFCIscb6yl4l1Zu/G9gux/k0UJFJ8SjjHbSJoiKs7wG?=
 =?us-ascii?Q?RXguoguoZNpKk+cRnlWQOrVDT+zwgCaVbbETpph1Vzu7KCXSWclFx5Fgn7wW?=
 =?us-ascii?Q?TIKk9amvDthxt0X251hpOcj5/RbznMuoULnpWCm8KtGVyv0k66L3X2FSXYLd?=
 =?us-ascii?Q?yNJs3FLlL0pLZD0rnu4Ef5yJhERLFLa5UTrbCgFri6PVFWATCgYNi2VUkzTm?=
 =?us-ascii?Q?L+Kc6OeWDWMeg0lZCKOUB7gsEUcGP8RkczEUNCghcehugpikFLIgsNerpd4T?=
 =?us-ascii?Q?iSIhsfb5DwnTZi97S4SlNvNrTtdeISbMNzzo9KYHpOckspEYw6khyAeWYbti?=
 =?us-ascii?Q?AaOOpUQCqVr7HzHXdZYFdstYkyqqTpLPgnO/H3lsR/f/WUJTsxNuk3Ibv2Gi?=
 =?us-ascii?Q?qw/xtXSo18OHVZG6EiyH8pLn2GucAxFZ0joatpV/qBVffU7xC2Fo+Fihgu75?=
 =?us-ascii?Q?l9FFMC0DSQ37ExvyVkMJP5dstW0oV6wg5x0oLumOiOPOD3eqUQhl+SD11FWF?=
 =?us-ascii?Q?l8vSK8Yh4adez35MRUxfWeumD6LR0/Z019+FH3b+9GZR/MN2HHMcsnakxXJh?=
 =?us-ascii?Q?xyUTdNBXIa6wuP8kcSlx76yKDDiy8bOWBy7HQ1U5+TkL+v95zX5gFWJ6l0Yf?=
 =?us-ascii?Q?HPBFFYbqaLWWex+lsZDZRYNIpoeVcuquAmjV3GnJMYuKEJ/INeozutQxZyMG?=
 =?us-ascii?Q?/lLaWcl4G8CWoSgZPKykHmJjV5CGlBEvvkeIXWs1soxOCmwlYS1JrNz9wK+F?=
 =?us-ascii?Q?xiE8VRy+o/dopv/CxGjnm9G28Of0Zc3zvO/hCMxeQo+6GD8Wxw6OxdNw3iOC?=
 =?us-ascii?Q?lx1Iu0h3cTrK8akLJDIEa4FSjM83/b4wyDyWnNbpNgxmJ0zVXu33AKVfzDp7?=
 =?us-ascii?Q?GzrbCY0O4yaAqh/236EqZGfcpzzx4wT5u38d8Qo1yekUgRDPOwQyg7E85zAK?=
 =?us-ascii?Q?GuYqwKjpZIxpO8OgfxTaSlMt3oVBAzvoTB+DBdjPVRDiE2EZAaiZvioKc9GY?=
 =?us-ascii?Q?UQQ601+3mF5H2u63D+56npGLWxUNJH18uSYCXozGHF++BlslpNKc63i1hkx6?=
 =?us-ascii?Q?FR5PkkA2ArHup/w/3H3/BVRsZ6NZvXwhiZ+DmxI9md+nmWwM22H+AmnOvoLW?=
 =?us-ascii?Q?KHeIffTP7aTGRJsmaAqYgPhdkdoB5I4RxC5Zhk50nN84kD7lScpcCvN6B+rT?=
 =?us-ascii?Q?yG0rIdboCqmisHLCl4qNUJxOTNPjFelXyyYPUlKjsTgVmhXytJTPHx9ji5eE?=
 =?us-ascii?Q?pt4yZvcox3aGAfUHoqGV7hICUh75qnXSfwRUN6qfPWT0Jj4uZpxNF8N6ukdM?=
 =?us-ascii?Q?XMix/GvHGw2cCpKBALtMaxCkP5JLZLdCiJUsJRim0Hu4b1w+fLot58HKHy4m?=
 =?us-ascii?Q?Ou/JKN30GkZiLtFhfDK75De0CQj78WciE8pPmTfOFvGpXW2gceSVIFlhK3gt?=
 =?us-ascii?Q?MKda9QN52W2WryZW2o4xASMi+z6sKjY5aAcpAQhYZ9RmFtLjNqkpM5UCOkJq?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u7HAsCKY2w89FkPjXO1d+bwQG7thQmX/tzt2xyA1XZKlEFI6p4CHQ7NwxIvC?=
 =?us-ascii?Q?Q4Az08YvGnzjwAv9Gq67YI3R2k9q/UmacNUPoYU+BQ+8c/C2EOURXa/+a3vF?=
 =?us-ascii?Q?BIY7N+/Pm83tt5zzvsluMerAhNbsmLuQWepbY6EmLX1tuSyrIVWo0BxSBNs0?=
 =?us-ascii?Q?gEAUyGwMQnohLZnvN2EZtrPTeFczaNRPvOmX+1DpCXguEM+x14juc74ml9sR?=
 =?us-ascii?Q?t1KdBO9YGwAzrPeOJbnZAg9Rr1I/iC/5IUVOd28tWU/lbGpKiNQQB0F0xPpj?=
 =?us-ascii?Q?5VhERybywycz39HBnfQZCL/ILnyAZxn2spwb7/n3O/GOz8TOlhl243u1fsV8?=
 =?us-ascii?Q?1XFZ1y7Q83QnTDiPRTSiH7a+FcXCNUvoIzF9b7AiHC7Zx2Iwu3dbkSDH58Tm?=
 =?us-ascii?Q?ePaduJNmLcRpV199TE4/NpqHbHezz5yHNW5kPKrm000Icv8oik7wAg2VN9RV?=
 =?us-ascii?Q?Xc7UmSCYVEETQ/BfddKwMvMvwNf2ga/dd+aU8CIpf/dxijTgulZs1CJ1inYV?=
 =?us-ascii?Q?Q9ZQbDVOx5Os0SXFYBFsCmQPk0RUOlnCstsGfcdCD55L7ScV924xfQU2NW0z?=
 =?us-ascii?Q?LqpePpuo9SwieVqI53qu8r6uWIACFV9nBaO341QK2U6ghzthJXiFSeTH1ZKk?=
 =?us-ascii?Q?8vr5/eeHmTTLfbV7rzOCR1pWSF73EOc1Cyafi8N7E/cJt3FI22ZP3IDDTlXr?=
 =?us-ascii?Q?c0glf0yv5zjQCajpC2aH+QTD3V52FQRf+pZlLQcivu493NFhMKCWDidjEisk?=
 =?us-ascii?Q?ACOmVYs9GI8ECxcTlgRa0gkmLeaDP+fjbH4jmVbBbutzce/rLpOnqkCcuHvN?=
 =?us-ascii?Q?61pKPZPOn1TQ3vqOcMomLJO92h8zJg94W7GCsUEjkoFNU0ZP/MT/eTMlAvCf?=
 =?us-ascii?Q?ngjM8eWcPg9lFr6aeHG1VViLwHFMPhFN1ddu0UViCQlOnWF6Wcioy81XJNhK?=
 =?us-ascii?Q?MSKBLR/N8v2ATQ6nEIhT3GjNtu+SNS2kweYpQaC5rBGE+Jo/Us8ygD3ULqyT?=
 =?us-ascii?Q?Ca0Bm2IIsifBZfFu83fIS8C+y9IgiJlgXvpFLYYbpAeRZMw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb35929-44f0-4c60-e210-08db6d42c28e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 01:49:30.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yh0KijBgRpRLPrqyp4cZWfBgVBv5aJfz3O8Rzm57yVsjxhUJH7YP8FkfCXAlm8nGH0ctll4GW+rlHQyEx+D3phrDuYfz7WwUOYZKkGALZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=758 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150014
X-Proofpoint-ORIG-GUID: wWK41GV24OD2IwiloV6Nu_WzxuzCtX15
X-Proofpoint-GUID: wWK41GV24OD2IwiloV6Nu_WzxuzCtX15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Abel,

> As both SDCC and UFS drivers use the ICE with duplicated implementation,
> while none of the currently supported platforms make use concomitantly
> of the same ICE IP block instance, the new SM8550 allows both UFS and
> SDCC to do so. In order to support such scenario, there is a need for
> a unified implementation and a devicetree node to be shared between
> both types of storage devices. So lets drop the duplicate implementation
> of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.

Applied 1-2 to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
