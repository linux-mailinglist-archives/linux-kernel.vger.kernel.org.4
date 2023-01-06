Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B665F9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjAFCyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAFCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:54:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159471B1CE;
        Thu,  5 Jan 2023 18:54:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3061Z4dF031473;
        Fri, 6 Jan 2023 02:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=P+9sXquTAOln9S6fwoUtaBSSFPEAbKEDn6gM+ZiByv0=;
 b=SzIN0IwKPiVJLxUpoIe2PU0zOXGVdNTQv/ncK+nysbMUey8uI8ZRa07IgKI3tA3k4OgY
 KCrX0434PGAPAA4f/yj3Xy1axDglA4Ed58lbuSESSkCkBIUb7bRHJysrWr1FoZkocXcd
 smnPmbM2XeVkLJr2wDgUpgT7/Pujvg4SAdS5mpaFTGmQgMjRZGwWQOkQn61DMaCLSTqe
 UFvuY1yYz33zNwJ209e6HcrmPNzTBwdHLu5H9SioIG4a5jecb0OulCqeOF0fB32dfuy3
 dUOGpx7e0mFeZbVspwJoCXmMxsLtHkjHGcsXPVoKPOJeZZkY/aH4OLyuQqwkJnltS9rl rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp12car-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 02:54:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30610RTg007489;
        Fri, 6 Jan 2023 02:54:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft0gupk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 02:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiKN/BNkXsznKMSN5TVXYGcK+DqByXs6K6AIMupKBwmggP7Z9ZPZrVC+lpRPNAVUB3Pi7JHSce4rqLphndNILHuLcK26YGGOkKsqIZ5hp8HL29U9XF4tVDh5UMEki0bk3t83u7P7C8SFGmgWWK9mWl9Hix2c55uHhhhQI6ECXIR/Gxo1ZOz9naB8reqE+H1qVe9VIYAf3StuKPbVsQdr1A179DIt3Mw9XSl2ez8buPgoGXtdSaFe+53aD4GAhmjR2KG8FQ2q17BsIpOb7kd2NliH07Vs5oM6VgGoJCRjGnc/yTHH0973wQqywjjaamP52l9ldfQznhrBnbA0vlZRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+9sXquTAOln9S6fwoUtaBSSFPEAbKEDn6gM+ZiByv0=;
 b=mdIOPB3K49ViLT9rnXr0wlfAiujSIT1dPioboGr1QkjmFt0VDZtjBLwtMkmGlMgGB1mvJdChULHdMDVcfyCDo3eHxO2rjPdNRxoaOHHh4TG4IHg0F6JlkjhoL/j1OqmHfW1wDNc1pT25pEakBslTYN3J7DgF9BpoXwBTtJfOF6JD6GuCK50H5xY93lwul2YuUun33tSZDE9dSZXC7lYDJ16lzbnAHzLhBlSYtWUDSmEx8cibEVFGmmgjk4flt7Zi8YIupWUZmoLVMvJOH4eaetGAnFr+C9NoP29oIgYkSZpF79GcQ4eCSiMfiLTIGaXD7JxihPX6AtDn2K0tHxsBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+9sXquTAOln9S6fwoUtaBSSFPEAbKEDn6gM+ZiByv0=;
 b=Dl82+dwjcs35iAfr8TsI9CP3jIdpLw5wLAY/lxEF1HG5yI93O7jBJfaMVDmWebuc09SiT6RHlu9YTlohfZow71uDOuEks98st2yXShPSxB/41Dh9naxaAhUt1+IWpL+GyxDg1QaoukNWcfJJuj7cqhap3Xd9VyvCtoSO1THgVjk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 02:54:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 02:54:13 +0000
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the block tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsco1ii3.fsf@ca-mkp.ca.oracle.com>
References: <20230106111913.660c8983@canb.auug.org.au>
Date:   Thu, 05 Jan 2023 21:53:58 -0500
In-Reply-To: <20230106111913.660c8983@canb.auug.org.au> (Stephen Rothwell's
        message of "Fri, 6 Jan 2023 11:19:13 +1100")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4fc2c9-15fe-4f4f-4fdf-08daef914ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ige5OqxZRUBRmgTvF+t7gS/ommBR1v4/9VdkjNU6BS6MHuftATnl6DkQzVnIEZKCG4WWfkSWTQOfl3XG8g5rH1o77tJwg8DcKS87++NComGmU1eR6I+crneLYQ4T3wO+5z34tiYEIHbZUY3/GEkTjITIT5uQbNY9XjpDumaqg288xQ83HQvhoZkIIELWJ1luER/Sw7B6u7G4hV0OqOo6O68GEYeAn0yw4S/DCvVi0f1fW/Z3Jj+/qHrl2KeHViAhcxFQW3Ukx92aUrHA9lQVM5qBpR2Yq1rOKzUfmiZ5O81Z45nkdMjOq3QmWHcedml9h5+KiPAOs94NJqN0Xs7o4odQGeNeSvLkv21yXR7V81R+qp+oZ6AMCXi5LtrM/OTMTb78ldtDPIFoBP+4+F4shUMBSYgUvMs4K41vbhsGHvgQJY4PFK79a/FvoMdmafKKHorJTZf2i//Wdjjv3VKScWnLuStD0mZfbp6l0ZmiWOS694OnkAZcfBcw0HABDFhLTFZFt+n60tVIQXQrW/43RLEbkLJwl5S7pC7USMq2zF5dKeuZ43+eN402AC/5fzAgFR1jTfl8I32tUHfXORCvuWG2r3/R6q5ljGqIxIoy+hUpkr97blLGQHTjotGAu0Y4by6hIn+GypSFLvxl+MltkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(316002)(478600001)(6486002)(26005)(558084003)(36916002)(86362001)(6506007)(186003)(54906003)(6916009)(6666004)(8936002)(41300700001)(2906002)(5660300002)(66556008)(8676002)(66476007)(66946007)(6512007)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BC8Zh6YjeMoW2qdEMOF7KYypl5b+awky9/7yvh3MOIPTcFMahSR4eKgCkUYm?=
 =?us-ascii?Q?52TBOmi8t0Cf+7butcBl1QnZBgdg3WQpAsLnnwlgDMHTaqaUNx/ty2uOB4Td?=
 =?us-ascii?Q?pyFThznhhohzI5vELw3w6IixNkLeN81C0t0AyTDHfXkKOnQkLCxg47obml4K?=
 =?us-ascii?Q?hAxloPbziVk2pvHY+k3I7vTH+zk35srxiHNOV17r7VX9bD2w2KSjVLOsQQ2T?=
 =?us-ascii?Q?CWB4TNx2a7tZBBAt0VMjp4aYdnF1o/uIRTcF6ZAvlMAfo9ArOkYgri++p39q?=
 =?us-ascii?Q?8ioMMzYj5FbBMZ5164iGYKWUCp2fYqq45yxXjl4SvzviOPNt3oQxQepdTEsl?=
 =?us-ascii?Q?IKrwXfpVc2k9TSETxN4v2tSiYyDjELmnHB0wNk32YOZJJynwix9GVWCDfC25?=
 =?us-ascii?Q?jlUHk+kSvD7tHArNipCu8dLjJLW+uayn65GOKF2hnLiLr0MbDh2ENLHDXL98?=
 =?us-ascii?Q?wFMYzhEHGoxKrP/ax9d/G5SHcagJf0yMCFq43eKF0W0w6AwYR1TU+uv+KIW1?=
 =?us-ascii?Q?LV1CzuRDS9YpeOo1cUgQxZz/lv3uLQZKiDbTn2j73jt0V0cXN05DVxUo6dAl?=
 =?us-ascii?Q?etFwlZ423zZ+oiWZhFQmT+AwVMihXIMFLBu1a8VKXALg6cYyUtqAiZkcHmGK?=
 =?us-ascii?Q?JAOyPeROA+35Ks8lWH21xfm9TodWXhNPlML3o5/AT/J/4npPtkTYaa+NcShV?=
 =?us-ascii?Q?igT94467rcBOpLQ1esvXgDhom566Zb1QdkKRqcbyENxUrsJAsPF1YWzBhXbR?=
 =?us-ascii?Q?ZC6u8dpcXNWcx+vM4dpyZj86Qgbu7qfNCNFXAYS2ljilhipt+3u8hMBOae80?=
 =?us-ascii?Q?zIDekOeCREFuqfgU6Z4t3DGlmG6n6uKMe+WE8SPqbBMoBaoG8qBserjjWdSI?=
 =?us-ascii?Q?vqIBbdK6Hvg37OFqHrtA2we8xMImnYjJB9xyNr7FrQ/eP5p/e7/wjugvn8JA?=
 =?us-ascii?Q?sa1XizzigNpdb2sXrHsNeNhm62wUAvhH8Ol2u9s0/5rYaSXA/gSGhOiPZ887?=
 =?us-ascii?Q?l9IKIBguEW/AGIovU4+RwiQOhhjoxibe8J8qfZiVj9o/54nYWocGtvoE5hy5?=
 =?us-ascii?Q?ikbI4SPErujYADNKBfLMnKLEmvhCHmYQUox/oYs4kjrhRMpCSd1mXHW6p7g5?=
 =?us-ascii?Q?pWLAMSViwBPFkSxJXulbLB3cq/EIM/COyPdBi+P7EQvjeqKkBjlBuXowU/n1?=
 =?us-ascii?Q?kBEaqOn2u07PKWFySEZU9iffEVK9sfRqbkmURy9HhFt1tW7mIrWUkAb8b+U0?=
 =?us-ascii?Q?oYRCR1tyhyOUfQ/ZNWtDmUkpRCu8qvhLgJiumtAdHmm15U6fzXa3N+US5tbR?=
 =?us-ascii?Q?40XWeZ6moO18KTwRj2FgMHnzzKcHkgYQiI3j2l0jOzIDNoHvmUSvSpg0pxSb?=
 =?us-ascii?Q?Y7MuOJEcn23KtvZTS+j9UV1Y2uMOqF0znfewN3cjdSrL5oxerR+9s+huoId0?=
 =?us-ascii?Q?3V1LZo9nkRT3vWm2ZkdMB8FHxya7clBM+reXvtNEpELMD6HOTEAEhmt8n/Bf?=
 =?us-ascii?Q?GvdW/KFsSf8MvroFM0epc/Wfrob+Cj7+W0a7QQuAo974WFt40idofNthtooK?=
 =?us-ascii?Q?oVuaOBj3S+JI5Pg9rF402M+nZjE2Op85VkyJAbvdjHyB5Ydxlss1ndnFZ0TM?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bJ9bYEYAhn12qgRw0iQVZYUPc4E3qVYVe8PbeM4SwOK3HffxEgnapnjH7JhNMqFUe8rbWWNQSvahkId8c1opARA6aYgcypp6ASPhfhOImi6dMdLXdoi7rJMwVG26lsVbwovAP128XObiqIddDConkCfqd05qnU8laRURoLtB4qrNwcr0x1aM8ZxhXdOyD4JqA4IX+gT9HiFSqeOrxfEJwbKD7i/+0ekEOaDG8U9w3DKQRzBPKYqpP348nOJ0talweRxJ1hgrQC/s5Ot+ZEpwWyKPceOdZvnq8jW71sdgd5PATcd1B1lwaeXMbefxgxeVJ4pXB2hLMh6T8qumOu/1rwp9FKGKldd2mWwq/jtiFpm8hO24Mzkku4k5YOdcKwUG5eLOUmfkq3a+w/eXBhn5GvULuOBEcIdmipn4JIfUMDe9xyyoSBnlyhkmd9ljR4q8Sk09aJ2HjOrlt/9B1x/D7roG6XqmaJbFyjkCH7w3R/eS7y+bqaN1YYDJuPcgIIyjUuho5W+Vhvmr4d6nnvTm2SzQwvuAqosvZZWuYLre/4qXeoCgMvbh+XsgyChHBsAlzBbRAbWWCXUBlEz3txpHKYvcspUqnzMEvSItJwcOpFXsp1R3NUlXUl3OR92St6Ud0dqatQ7EMsYrupk6dZVfEJfg9C7fiGkDLwoBEypa/Vs5BQDI4OK9aSsAaHalekorjzCz7qjH1pKwgoL4B9Kd4NI7waUekrtAN7haWyyJE8bNImxpusvE0wGPBt3MnkL0DMcsR/QhjK9esf93ip6qjSb8oLF62EbPaxo7/bOHl2y32CvyjKqVRkVYjI/xeSHvjO6chdLpBN6DMDFXyLfqsm7fqncdQJwrvolFxCihhFviQcBiLST1lLOs/iVv4tiS1NtcWcWUUHAelyyRmE9Gig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4fc2c9-15fe-4f4f-4fdf-08daef914ac8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 02:54:13.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ6GhsCb+smFiqvUTl/M5yT64YdC6QNOlKPqTGp5x05uClmTLplGbRq1u24/yjaZM8Ibn38w9EMcC9MLHNSVZOnRX2MfxjOGyibrOxIMcfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=660 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060020
X-Proofpoint-GUID: ui3ytYDrpj0Zqp31HQt79TXHuso2YztK
X-Proofpoint-ORIG-GUID: ui3ytYDrpj0Zqp31HQt79TXHuso2YztK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

>   4b83e99ee709 ("Revert "pktcdvd: remove driver."")

Missed the revert, I'll drop the SCSI patch.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
