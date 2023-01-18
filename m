Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD7B672CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjARXf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjARXfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:35:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43F62D15;
        Wed, 18 Jan 2023 15:35:21 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmivp013616;
        Wed, 18 Jan 2023 23:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=DObZPSa2mSp0xWegu9vEzeXCZ//7R9mMxCG41Mqj2RI=;
 b=j+E0dCogx8eEybSTs9VNHS00NWo1BlQKw8TtMqgOLBQ8za1Wt7GT4vK4vn8hBblowP7R
 YjRk24MVj5SIxNmsUQD6GDKie6nPGu9x46aWkvPVWaJC/6XgFHf95dOil4SSPpoP2IPn
 Mepe3A9RnNBAU7VGRub/0JhCMaa8uhdMgAkt9WGdhKBze22e6oQZwbXS0vqQ/Ja+X4jZ
 kdV8+6MzVWPlBLhcYS1StxybSHvIOwU47MsAy2k2YmbqK1BYa+p1E3ipl6Zmcb05pr7S
 h4Vej0XipSvq/MDOkmDV/+y2xrQCMezVd/DdRy1/YiknC8k41CpQdIdPP3cKL9Q438Zi aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medh179-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:35:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IM51p8030110;
        Wed, 18 Jan 2023 23:35:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quawtab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcQDv8RDn9ZWTWsSTpY7pl5PKNovIeMUftdCOleHAMTDiEzuDCYcrBhGNfKCQ+KE0BkHdBDUiH1yyuHV2zRonM/Dbq+5wegOfy74gDLI3+wgbZMrf8oRg5LApWPoMqpNd2kXbVnDu9g2P8JVfmTNjFUvYXLdfMuWeUC3Bnp7sYoAbUMww/KqDd4noIrbtpOwWxxIE5JDQnOtPt/eGbKR3+/5uVqGOuIocMRoD3oIDI9DHS2Mg1KZqFcmwPeH7SrSSTA8nzRy4wV+4nhIQuozJ1/aPaVNpM52VDmQnT2QF1ofb5Yjv9xn1r4YsghDllTmhL22Fee0YjGBerVgj/ZqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DObZPSa2mSp0xWegu9vEzeXCZ//7R9mMxCG41Mqj2RI=;
 b=gM8tSoVMHlwe+5Xub6aKesehrqTE6JrbwanSQd9ZL9lEnlW7xExp1PKdA5wqcMQkzF2AAwck7TdQvTcDgHziy0nm5cKYFjBUGvu29pO/mcmuXHK0L37sQwJwYkaZErt5QFrPNJuJ3g0GrEoRSTDVSElZ0/n2IGp9kgXFEuz6BYnSEjl8X7GiGtUilS6Ih4tPXDfAVGYFYy6H+fSnLjSKrKIq0ikOS2sekK1Jy3O1z7M8lfqA62Uxek8F7O62g7Fx80Kl/pYOpHt94CY82/ubCrxz0V+3TZyDIyAe+LO6pRXcjCNH5sD6KrSGdRpdeh6JKiWt7kZhDBHeqKuioULCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DObZPSa2mSp0xWegu9vEzeXCZ//7R9mMxCG41Mqj2RI=;
 b=fEEUmO7yK+DiAEAEs/EgUlDjpvrUsA0kSRssnrpR3q/y0BlzGbreQhfpFEIDHcVlXDp7/qchM+9nQFfAoLvl9GRr02iwKpSED4B3bzKlOZgj3+k7WEmq1pWti6N3VNN4Ni4Nc3TMY2xY4rsmkBexoqwWCL7vErB1Zc+mWf2kJOw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO6PR10MB5555.namprd10.prod.outlook.com (2603:10b6:303:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 23:35:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:35:09 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>, Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: fix printk format string
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1k01jpgbi.fsf@ca-mkp.ca.oracle.com>
References: <20230117170029.2387516-1-arnd@kernel.org>
Date:   Wed, 18 Jan 2023 18:35:06 -0500
In-Reply-To: <20230117170029.2387516-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Tue, 17 Jan 2023 18:00:15 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO6PR10MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: a29c0695-df0e-4c82-70cb-08daf9aca2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OerfiVpwhBtT/ilFgCoxKZ16F1+6zWIEUpO212rONhwm3Jx4wcvOjs2yKamB7FD7srp/BPZbxGfM8pHrY5nVL3x56Omthk45Oua8FdbzKYigA2KnscASnaJEHpXiKAY4VCe97C/YXTCuQg9ah9YSPMNBdO/Xno9auZ/qWxid3XhwuOIws8siYaMDJNt+zyETbF2bmboGz9ztSKf2sowpAYSy/ZVer8gPtdXv8DPnOIxRVCJvqJ0EbWRcIqMlcQNp9KoEVpjp2VTUTSLVBEEnHWlW1wHB0XC1F4CIIJYfxfFB/wbf8eGlCCTzgTqWxah2pbOTJbArXMSRlbpqaSOvZ8BAyglKZ+PBt1WQ0KokpeSp4XGIuvR0ESsygP6H/fkD0oX+/oDgNFl90INdEq9Fbba1xFJ5CVtVbwtLj/laEPNnWoZUwytcX+68LgjVlZWlRXEkuVZREuWo17o3V7MuriHIIsBdSrEvlJBhm+QPz7208NeZ2JuagMXhGFKB4AMvUtr1ZG3iYUBOgc+4qsBEwvtz9qc+13GLSNpC+HzoqJUy+FkUY+toNi4qlgiQ1Jj401PJtQNigOtCAt1CiMKRNtuOWLHJICJZI1Dqnorjzgr4RJpc8/3q1f1CqlbLEJgyDlNd3zdZWjqW9KHQD2Obg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(558084003)(478600001)(54906003)(6512007)(6486002)(36916002)(186003)(6506007)(6666004)(2906002)(26005)(4326008)(66946007)(8936002)(316002)(66556008)(5660300002)(41300700001)(7416002)(66476007)(6916009)(8676002)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mh4C9BOMJIbUgziremffv0mi8+95LhM1I16VS9/b9YDmviGMkd4I09QHAoST?=
 =?us-ascii?Q?ML6fQdqePTVppB987Xr+QuMz5Vf9hZuvPy/dmX/ES7zQUxozouKVsRFm0TKX?=
 =?us-ascii?Q?IzEuaaSJcPp+bKzKsGiyBbcWi0OkDWCwhGvZonasdp+lQIm+bJ/EKIN/2TZG?=
 =?us-ascii?Q?QXBAKgAwsVBkyJcpJd7BXPCpGKTUXVd7hpwlKatF8Sf/yxx5AjKj1nnbvLK6?=
 =?us-ascii?Q?HjLEZdX8EVTHZ5GIcwxZU9HDV0B1Tq5QlOXit/YKl2PHbH9KRCIXUkV/Avsu?=
 =?us-ascii?Q?lyWH4kyP0zNdqtOuMg8/ZtrvWaVRyoVTfbM4uOcW9jhTlVxDSJ0MI+EWnOIZ?=
 =?us-ascii?Q?MTN7HQVz0cD5Q7zlSOYg1pnb6UxlI2inBeoynPEoZs9dBiCXvMJ2c/0DbANF?=
 =?us-ascii?Q?6DIkqaD2iLXVDDfdSBSVdQxYvd4BkvLJ+s0fTX9JjpeMtQm58UiJdjcMkfFQ?=
 =?us-ascii?Q?zKhnw0Sa6eibWx4c3nB7XIHCd+Mq+DAET4OYu4S+1WEtiOKlF+HQxVI57C0w?=
 =?us-ascii?Q?SxyC06sgN2EnrNzF2Q3v96ajmxyaTqULDKEzMgCeytKIBkHy9To6LY2zFpt3?=
 =?us-ascii?Q?a3st+J7om+PPb1y1j5kVej2wiGK+SKIPAXDwd7XruJlufNAKVcINVR6v/WC7?=
 =?us-ascii?Q?VF5GgwbBEn3l1UThu4kTFvf5Df0nsCkw1e5SGSNKdJkE4pLtC95lTuOV9ucG?=
 =?us-ascii?Q?HbWzLdQ5kvW7TIPFOl2C+Wx520nrIT4IZjwq8zj+VHTpGm1FLIFT2h+Qa8rW?=
 =?us-ascii?Q?FEEmh7yI2QBEhmQdxnAQqmW+vm4MV6ruGV8I2luAz0xhGy4eE/+qjgecxRBI?=
 =?us-ascii?Q?NKZsQ0yERBrzrLlINdDaZal2IzWynGQYCNH2Z+o9QtSrKksRyEhpHzp49Daf?=
 =?us-ascii?Q?X4XydwkA6941njMwxQrg9Umg2Fyul1ytFKulzq3by1+F2C3X03csq0gliSv6?=
 =?us-ascii?Q?67D08qIu0+Hd3i5oZC+x2GvTN1jxyCn5z/fFyTobagGMLjuNiTpDtvPdl3pX?=
 =?us-ascii?Q?6uLR59l5OKTRxNblaqqyhlRQjCsrCPx4TTlzfT+7vMuhPNv9TzZ28LS4qGH6?=
 =?us-ascii?Q?ECszZTz6sWYedneE1VRZAEl6jAkflp6Xh83fmv3REWk2pLH21HpP5q7rtJNS?=
 =?us-ascii?Q?KcOBxaCYFfqSGPNhMY28LGEg/qswsPnRTbAyvWV07FIorhT7Y2SlliJLGVva?=
 =?us-ascii?Q?rLm0aWaQ/eXP+pKBq7t358oaKwL9s45DMxl4tnrbNChhP1U19dzOg0Wbmxsb?=
 =?us-ascii?Q?YmO9k8+wrVYmqEn2B8k3xh5mGY0E02Ju2w770NtMUzhBAsnOMvNKeWuwRdWI?=
 =?us-ascii?Q?bmxXHIDgCY29+CK5j1wgMTH8xG2q3VmZNETHbKy3KLycwKipmk6jlL8WAN4B?=
 =?us-ascii?Q?zIhUmz2RibshHXXyxPZ2Eo3QU2xlZF+YrY67Sn0bq3w4CKTbKY8Jsd/WncYs?=
 =?us-ascii?Q?W0778HqxNlkB2//rcULZq6e3HcQNHDZZBU5Pinn3L17sP3YKEKtJSCd6rHer?=
 =?us-ascii?Q?9GunZFS9varZ/c4OCn1dBI5Q9F6lF5xZo6+UyhCbB0pIdq4wvFLwDAnXQamW?=
 =?us-ascii?Q?oYPGSgWZz6kN9z5shGRMDkDtdDoL93e2xXzKHlziCj+q6y0RJrgrw2g6ryTK?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AFuN0DgBz2+s/ZIkRPIq+4y1q+MzN9+Xh1WUstHGQlamwTjwUsbC8KgpDlI9AjC5hBoVJdBv7LKR0ljZk6ShxlhLCg9O1LFjjl6ndlaGjh5UOBfzVd1qF6tmuUhoO4R9CaRBEQTZ8EkcqeZUjLRYsaAJPUxeqgKx2fvO5BLyXw4QRIjo1TBj7beThMbieC36ggnkzQMLygORJcOhLuQG29mMqHSihTsO2SL8JM7+810Xn96f7PAKHBUgrz1YqR7C5fSCPPWXTlxlvakuiQ1aFNKxcWLPMnU/nTCtotL8/c3oP2/1JFtF0pc+pkXV0wvvickDRi0+lM4WtMB9vvCTevt19Fg7iquh1JZlK18sZYz/TzdsJ24Az+paP7JOHGsF76SRQBpOTppnC8lRk+KX6w6FiIOAGvmYBUIeqED6jDKSj9Tu7O35h2RLVZ5hOWe1/koUReHrhG1t8J85ejAX4K58TjoxNN8FX3ZezCDscMusjPdkUbAu+f087B1M6LMpzKYSHVUmKO7VZDqIaeGQlfZW3YMg9DhQxBLANAddJUwOZs5U7Z6WlGh6KSrcRV1/Y2+Lv8xuzhLDbqw+XIJk6vKDX/eLdYfvZmnO1+c4uodbnv6UT6bYEtKzLL8b00I0DWL/3eYlGFwNV5AHOxRSTa0/4QSfeFycpOGZSeVujqdIa9a7JhF580bknwMHzN1jjLfiHPVY+GijaoicosU1wqnh7qqvl9NJR++yW3SEYyEQcURZbp0qrJ6Mutx6plO/gw1fXnjuTJw7IS2RANt9nVG8NaM4oGyyy5fdeUOk2B+1Ch+wWUMXYUM9J6vElQijRPyELVWyF2F0T2pi9CPHterpQQIYW7/Xb+vES9ad6LCRDmnzAZGpTeCdi++b1SomU62FHtHnyuCQ3e4mb4D5Kp7sdTHSkiarx3TPQY40YMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29c0695-df0e-4c82-70cb-08daf9aca2f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:35:09.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUwHrLIWQZt9YojQ6JCkyiDvdu3f5LRoxxUBECTo+eTS6efkc+gFv3UNA7/IKGGKvkq7nmxw/m0zJJDKVYNqOAd6+i7VzWRNlLDuBO9YcXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=644 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180195
X-Proofpoint-ORIG-GUID: xN1F3QCbr6jnwuxuNE5zM5nJATf3u1GN
X-Proofpoint-GUID: xN1F3QCbr6jnwuxuNE5zM5nJATf3u1GN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Printing a size_t value that is the result of the sizeof() operator
> requires using the %z format string modifier to avoid a warning on
> 32-bit architectures:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
