Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81276D3B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDCBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCBPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:15:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC35BB2;
        Sun,  2 Apr 2023 18:15:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332N04OM029775;
        Mon, 3 Apr 2023 01:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Mq1OcRDx2A1kl8D+qsZbfHAg+lZsrFH1ojkVCMYo1o0=;
 b=TIVArQycS1UyNB5z6Sbnvu0zOR4+N5kpO+0Nf/n7lIZJNR6nv0r2OwhliGWPyP7UmdzU
 0m+vee2+FdDSHhZm6rrZh4ecJg3H+h25heCvuqRVymqDGqUVkylkHrMJ36YNo+6IJlSe
 TI+Xan3pUS5ptOWEvtGRrxHHKaCMPrHbxbc/6KYbn6+T30TBYtsi5ebd7aAkLCD2ne5G
 MlbxAgINjPDoIlR4ooWyxgybC2YkNlpDzdH46MdNJDV47MoZNm63yTNbKwQR4aPA9U4E
 6nFi5kmCQXhvbw2R0i/sujeii4IH7WhO0/RQzaoGKbd2KXqSUoivyBjQ0jvYqBK+q1tD KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tsw65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:15:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332Kesrc017226;
        Mon, 3 Apr 2023 01:15:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp4kb7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZC6eN3tOpZUWvUbqLCBgeRBRMicbYSy2CeOctBusqLjjTAmGLN3u1hu/840f26QHnaPEWewzqoclA1yeZb8SljKOYOxcXuJN9YWpbNWvpmV4p5vEcZVhdlmPOUtopdp9pp8oemqF5Eb0QO4Qwofe7UBrNKKaRD6O49qUvK1sSRllJNmmJnDw0d44tqDAe+On75keFpalbWwD1JJFIm4elqE7TXawkrxSNngZDMlogxddF8bsohsNOoOzTaEuFIXdDcNUPduxbpylRsw+dSZxCiDkWdaFonvgdBFb1Wv6OxVMdvE/WcGDRTdEPAEkuzMik8o0K08Wk0KNBGcnnEBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mq1OcRDx2A1kl8D+qsZbfHAg+lZsrFH1ojkVCMYo1o0=;
 b=aLaO1vTQpZIeUto7vNBMKmgfcLK8A07pi4MgXrlDQfiNFY+6F05aJJ2E8N3dv0XJDWzOCGlFaVsJbzZy7GqtsUrMXR35nd9QAuLYsrRuoMoat1USJO1Aj3qZmDDtncTfiVld4oTemM1FCkmkG+dt2TF4FNuujgC3RPE1Wokuk5yQRDwVjAgGU+3kRHeVEYcAhu9naa4YnJYpmQGdD1bltjEAQ9/dZF0HAL4YbYTCR0FX6YitMWezDDz760oMPzchbt2xqhaTOpYBKiov/qa4AGvw3S2Iv0SXSxMF9rTL2vAh/5NyJk27hzoWE6f9fMhLDKuqE1+O/DKm10KqseN7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mq1OcRDx2A1kl8D+qsZbfHAg+lZsrFH1ojkVCMYo1o0=;
 b=AkaSGoJaPMhSFwXSlZDykr07Hb4m6mS79MhJ+rjNvJ5LlRT7t256qeUEOrbOeixw3m9D3OTpPIB/lS7yCSvPsjHvxF4w86y1du8FxD0WN6fCi2c4koD/YvwMmif3smUvLzdsB9cqsAETGDBGtpCB5hfugloURYn5BKimeJX+exE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5371.namprd10.prod.outlook.com (2603:10b6:610:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 01:15:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 01:15:25 +0000
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
Subject: Re: [PATCH v1] scsi: core: Cleanup struct ufs_saved_pwr_info
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs9hydel.fsf@ca-mkp.ca.oracle.com>
References: <20230330012918.13748-1-stanley.chu@mediatek.com>
Date:   Sun, 02 Apr 2023 21:15:22 -0400
In-Reply-To: <20230330012918.13748-1-stanley.chu@mediatek.com> (Stanley Chu's
        message of "Thu, 30 Mar 2023 09:29:18 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: 56aa47a9-8f2a-4629-5278-08db33e0e772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +20AaM8GgPE/jTr5q3Gw4lOa37/gTXZGO84UvTuBJOah0U0CQ109GVUbVdbcfwxdoSuGu45Wpp18NTr6sNeXfAtXoP1gI5B4JvcK4lZ7JkzFPwl2S838NpH66GTXPlXJkEVjVFIMCCqxNscN0szZXxqDZdZxCvZ4OhKY+CHW2bC9vY0nVxMq45y57iGx1c7vHKIQheAT7q0DLF3wh6/mLooqX6NtoGGGJHUG0prqeEmwNd0LuOvzxA1iXAMIbpGC4WAXCO7N2aZmmd9kJJDAgW6IrakBouQbzw2/8O0lZRpWd/f+QH9LF86zTaWYrgud5IxzgrHZRRQ95R7T0UjMlMlRr4fST11yuAOL6Ve6u0t4msOqCYr2UluleSlMmtwZARAbw7mrNKEXtC0BGB5n3n0TRhMaFzFru7vWPafPRK13oiv2yZiQsk9CN6n1YRD0sDpSdca6iW47hxdJlEuSIcdeOz626Hm5hGxUzzwvZGILaAaiivIg66nXIzl08F4sa2z9nO9rKdENSjfQ6CWO2r8o4MltjTQKjQI5U6e9wYNtO2OlgNACsXlzJJQQKR1k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(86362001)(558084003)(2906002)(36916002)(186003)(6512007)(6506007)(26005)(6486002)(6666004)(4326008)(6916009)(8676002)(478600001)(66556008)(66946007)(66476007)(41300700001)(5660300002)(38100700002)(54906003)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OrcfgiygoDWNzoX3iJ8Q2fFCBYZby73lgk0DLbjeZutDzmPXFkmYNqXz2Dh?=
 =?us-ascii?Q?40L5NXDycl9DijXlSz8uZYuRiAsq6jBrv2N4TUpxCI6ncs8I/ZUjDk0obeB8?=
 =?us-ascii?Q?Ot7G8GdvcdiLK5oMY20NKla7sLAd53bVfJNTGfAYzrzwCL75cMOHf1EsrFD9?=
 =?us-ascii?Q?H8YiXXG/HuaqB4ZOWV0FzzZkg60AdVrujUr7qo01gQdFbDYyADXjOUUvamHr?=
 =?us-ascii?Q?EtTY2KGIHDABJ7xfFDgrMUV8kiaMi9RRvwWN0aBtMhwLmTEtk07I1g53w5U5?=
 =?us-ascii?Q?s5v9Cqxl3MsackzlYLa2gOFL+fwY5U4KknwS095nQU0ksZXOXygtbLWN85Ch?=
 =?us-ascii?Q?79S6cEsTPWS6rM5Uwl2fdVM5vCarIzUGYHwk5JCvL7GJgk4Q9uCZItX7tgWb?=
 =?us-ascii?Q?rah5H6qMewQ3GFLf+4S6UkXsONw6P82B3HUrkiL5elyF3bxErRDoQG8kRg8k?=
 =?us-ascii?Q?HeUANNvASb3XTRlg+qdl2pphnra0tISF8DsnjgAgoO6XvhimLEIESPMIZprn?=
 =?us-ascii?Q?61OfWssboynkvbAp6B87i8X+nzfPPw7HA3r5SdQMOoa5oK0BRgRoNm9bbfmT?=
 =?us-ascii?Q?JRKxyenr4wwXomvHF3WZLlNMqNb4uU15FDlSX8t49CcG8iu0FWxnPDOam4XV?=
 =?us-ascii?Q?bbh7cGfxH5LftX4mUAY7AaZjcwBZF49FWrrgsczEDd/WI1vOgQLj4mXgkyaA?=
 =?us-ascii?Q?NdKE0WvaQOs8417YtezQNbwfj0eJ/G+3WwddfO+7EXkEgrefiuR1QiQvdpRT?=
 =?us-ascii?Q?a8ZCsFxWqN8dwsVnKodHksWpWoiEhz+8swzgNTbk2NvBkYKHdJuvrtqun/Sj?=
 =?us-ascii?Q?Ujh/axjDIGI+IjdEuvtXP/sfK/hwA9eMs1FLV2N/gf4o/jYJbd5vBZ5+EKk4?=
 =?us-ascii?Q?WHt64bSnYOF5K+XNbq4gGjYO7ZKOyr/j0j2I00bHu/ncy97HFZodwPU+8d8g?=
 =?us-ascii?Q?VTRuEgVhssSyJU/5W6HIqk/MVV0IWAkAcUCvM2YfmXFni+sa0le7kc7ofi9K?=
 =?us-ascii?Q?q5dxyqTOBEFrZBlOlZS25JnCflSP9JpnslURajIB0F74NxAGhh+eAQLy4gSF?=
 =?us-ascii?Q?qkMyStAN4l01zn1VDNfOcR1hvj+uNen3C765EIcF8eGilqcy7ZQN/wKGnBTl?=
 =?us-ascii?Q?n90THMRwdgOG2rm749/hnCOyI6H6TGkpKLseKPfRdMA56Z62MzHS5TmmO+R8?=
 =?us-ascii?Q?r+2e1BhEIu2/TAeHXUsgCMU6yUj/DaCxkXeyxpWmC15ssD7Y+cZeC1Jpuba1?=
 =?us-ascii?Q?7WLjCwrWQWFi7t09meaSO5ft2eCuuEQGyrUkNbUKtXX6jBBL0NmzdjeHVMwx?=
 =?us-ascii?Q?X6Gv+I5t4V6iyK7krCEF+IVXGipjzBOQp47GqWkiGtSpM8TBVs/vAhMofShI?=
 =?us-ascii?Q?WNLn/R+q9gIfdHRepnKsRrw1wzzvvIZjUrsneQsHo6PEdZeQX5dQnpLU6mXq?=
 =?us-ascii?Q?TB3eIoKpIPfNMvjy8/E/PPuDGo35BwyE418AYZk3Y3qbPSjTKHiflpbHxukE?=
 =?us-ascii?Q?h3Bp5Guo6tcttm27mvZEmA5pgohkGlseWCDSweTcE8bNDgayljNk4R0yiPrr?=
 =?us-ascii?Q?jK6XjBLejg1D3MTlQSxvJbVxydIiRuJ6tOYyWb9gzSx2aJVbwQviNKhkkjzT?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NUq+NfbxWVqoiq5gl3lIcJcg3ePs7tEvTQJhPWnnnJ+EWF5f3RbC/XdVRlWicWxqDjsfoNXnIACzOt8a5jgBzvqrE4ugoG50W0Zh0HOXxCbABAGvqXT5gmHWi3YNfnLdCdu8hrABDeHQDJJc5Gftl1l0OITHB2Hx3hvq49sqse8Mf3F29e3y1k/AsFcP8PjyadcKDr9gIdAPMy44jV3PiuwbYEl4d9ZzBpbXyDv4CQrbLLdL6+bbtvBkIvCE1wZsBjKClySalUyeCtGyCQPb2zGxrOTzZ7+JGLjGCsvRtxAPLewb0BSL0gE7hcohOvT/3fyUN7NGLo9BnOYkrZ7NKETC18JNLoytCt3o1nsicdOfrnspV1qjgFWi2KoBkRhamLE9sueMQ/hVZH0Yyewng1WhMIRLVlG9QKMrTL4vtEFZ22yQf6ZGD5cZ/btSqLv8tLDlk/fc/u71XtVzmNhO3KoYZhavk/ezTSmDRb7zMz9vkx5I+HHRyi+iy4n4yPABa/pfvK6b8eMRCJbbsiiCxmuSp6DqRJv9GHpawi8C/9qgt3ZVkAmeIM8eeSJfpvNsTeF2uxn4Qys8x59hroHtIZHYHlTbgPZhiOGjyJztcUMdOb/izp9kPzRA4PsYIV6bysOSPQagKH2W7mAT9XhRsGHhYZY6mQFfdckyetc5eITWTWqQef+3TogEgumK3EMo++RfLqiciWqpBhbwvsTMH9qYMDtWtE4xZhU1tfNnLLkeQWiDOaI7Jgt42rZwl9aWmGGrKEMO4hNGYovO0h9xjSWv9Y1jqhc+6GMm3VjFYY+D+E5Vo25DYf8jeAzguscEcjmt1VinGnI/AKJS6mfDGHoi63naCOVCi5DdLA3FIMWTfNU6ce4UtDdtTeWPeX4qa3b/od465jWWNwvD4jR7dg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aa47a9-8f2a-4629-5278-08db33e0e772
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 01:15:25.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfVHj58jboOdfsswjR4XHHW7KtJpJJm3tu/qlQp2V/m3t9Yjblun/ZrVdGSCG0Qji8pBvvs/LEso8h5739S/iu4PKl+wuNksw+Y6xyjInmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=722 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030007
X-Proofpoint-ORIG-GUID: 86pr207AW5ENIMhgmSGq4rhe48u8piVV
X-Proofpoint-GUID: 86pr207AW5ENIMhgmSGq4rhe48u8piVV
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stanley,

> The "is_valid" field of the struct ufs_saved_pwr_info is no longer
> used, and this struct can be replaced by struct ufs_pa_layer_attr,
> without any changes to the functionality.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
