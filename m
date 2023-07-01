Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5637445EC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGABnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:43:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1453C3F;
        Fri, 30 Jun 2023 18:43:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3611W1kh013899;
        Sat, 1 Jul 2023 01:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=u3d0RLuY5t11jjOUQtz5NVD6b53mEQdYeMRvEfuKv+w=;
 b=NWQzU2vNXgdBVv2zcRUWwxy8+X5Dr+VHQTV5JDg79YDR3evw1wOao/BtClhL208JJWN1
 V9/7gXsFvW0zKkiuVBdSgRzO8dp3F+ciLDz/wqBGtufGw1SNVnSFtMKRhP/TbZHrf6Tv
 H2p/l10D67K9EYFCCk5+Fovkglz9Q6frSglTpeiZkP6ZRrJIqUgKalbkTFDxOfH8VrC2
 SZRWDm/D1cG0E7JJy8yslZjrRtzirp+0n7OqesiWTX0DN/HBuVsUGA+5bqxm82uUD7No
 YvFbjoJAS424TOSv413zOndUiMXTkvNYILnGOIYBrZ1K2Y5FJ6jFbk9LzLlf4vxUmdl4 6Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajd809m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Jul 2023 01:43:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3611XivD009603;
        Sat, 1 Jul 2023 01:43:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6r5du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Jul 2023 01:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5dp5b1EW8kJDJooSMYj2v0+hp5uurBsLetwIFfIaWlZUekA37xbZINykXQuXxNaut1XLPrR0Ylf0FxtLSIZZskw+x35PGj84korDdX2k+CtoGq8HR112T60aLA7vvHqTUGSYcgYLc3BJ+W3SD7Orz1ku//v4aFENpYEEEqw4qHjTNZGXvrrRkZht6PN9prmnq5iAlI52/NwXL/dr5l09aFJZG+eYqpXkI2phc27E0mAUP2qh71GqIkhUa9lYPtlAKPK2VIW7B8M5pd3DlEJQWyI0nUj0rIApl9MnIXankr1hkRt8qU72WvKX4jn08MeDp8hxDFoj6zMJ2Mh/NESjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3d0RLuY5t11jjOUQtz5NVD6b53mEQdYeMRvEfuKv+w=;
 b=aSdu6ydmlQxl4PxGeCHlQDTua3Lpx7dMSzrN9RN2VfiKQREyDis3SuA9wQIEvgj5Vk4D451FgaO8vXCRMHubPTu/gq9uc5oTTKFcuLMieSAty6Mbt99KVf2QhDTS5T7U6vnbaxfx3wbv6oeSW8mKajBht3eBtLieNA8116fHlt3he0SruVgdmVZdhrsBi08GSeda8rgCwikx6psqDA7TVdQTJn40uGLsaJJroJMOg0zNUf0rSxZ6PdhYoywfUGFxlIBE+PNtlQgRZ8iCEnZHlSpNMKQJnUuPt/hmoa7O9PCC7fP11umrHoEXXs4XoJE3ZMe4e1kRZfjZRP4BA+zarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3d0RLuY5t11jjOUQtz5NVD6b53mEQdYeMRvEfuKv+w=;
 b=fB/1c6U7feUQYCEZAm6BD7WPEX2hT7PbRFUPZyyjNNHriPKVdxbjar3kK1bQ02ua8GRkJK1CVYjbX49bCKi0B6VCsxpurKG+Y+38NvxbwcWfociE9khq5lHeyYJmjSV/Sxt6+r49yXdustVLMDm+7xafjokm8XoPhgZ/Gmg4DAs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4383.namprd10.prod.outlook.com (2603:10b6:208:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 01:43:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 01:43:10 +0000
Date:   Fri, 30 Jun 2023 21:43:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v6 6/6] connector/cn_proc: Selftest for proc connector
Message-ID: <20230701014307.fs6tb7m5pyt6huga@revolver>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-7-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614234129.3264175-7-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: c90e12e2-ad8f-4f1a-5115-08db79d48689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUL5/CNMB7sw7NZj1yRezTwgUKoxABkMdBgixPeZT9uu3axso2Pu13UH8yLrOd9AR2e3A4m3JAAWD08wyAtqGTSTCzh55IYA+UGJmUKi8kL4po4nzDipYwkJPBjb0f000BE+mVHVH6fTPocYRQWXIV1EaLxff1HniW9j9qhCIgngtQaJF09dZkVIps/8ThUx3CWAQSXBUu8ZdbgWk1+ujdZcevUDY/Z7BxdFR+9LqxPCA8G4aSmlAvDCWLrGJ8kViBScv1fpGNo19E/PCwU6H1zamjFhBRRhIPc2wTrayFFAEkbzl3LLzqeAb5M//1bXzG4HVokvbtceEgyp6PdNS3DtPuCf7ynZNcW2uuDVZmudfgEX1JTXy4VrHNDlrlV0fBBVRkjEErTUD6uZCQGPkLXLrgS9yodMzw1Tqqb6IfrCCikXPxflFxVt+bAu4VaUeEtEspSxkUNuGJdd3zuXGck2nrckVXzMgtVQApT9a0EdMFstnr7UtQTbDOc63kwAmGAm4Y7yBAfnSblby30c9yjutNhHMe5j6UTcAbr7Dppk3OIT//NH0ddXTBYy+h9+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(1076003)(6506007)(316002)(66556008)(66476007)(66946007)(38100700002)(6636002)(4326008)(6512007)(33716001)(83380400001)(186003)(26005)(9686003)(478600001)(8676002)(8936002)(6862004)(5660300002)(2906002)(86362001)(6486002)(7416002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBz10w9nJtxnkz7Po/ajIObBM+WHUtQIca9MUr2DOqGQxCpaEKQR0FtlmwcL?=
 =?us-ascii?Q?TiGJs8vu3tulKbl/YPGgcYyL7RVkTQw+ZXu3i/h7LKlwMLofRsNNKNL8V/vy?=
 =?us-ascii?Q?uMjL/owp7fWcfAv6LWXjWyz5Uwg2jgFv+4EtqYV+0jH8LGGkjKbQyv9F1nno?=
 =?us-ascii?Q?navKwOJ79pIrl6kWjBmZ0T4dVfcnfYeyCcyzVv9g6PV4GkXRETaaywDyqak6?=
 =?us-ascii?Q?vHtM1Uh6orqw+Q/15Z4RxT0NZ+0AVLf0ocOe+BTdx76gsWml0Jb1/kW0m8eK?=
 =?us-ascii?Q?T1/sOhfoidGFAl2bM2D2LxNQ4ATCYqE5MlBmKm9jmSGlPcYRBq6ouI6FZAGK?=
 =?us-ascii?Q?wBclk3mzEBJE+eSTjxPyaIVvmGw2E8oja3chMu+dCovElBg+lNheTrAqRS0R?=
 =?us-ascii?Q?YFSyEmTgvD0SAhOtvIMEuwwFMudmQ0WK2i90JkJXqEsueu/n7IDqRC363fFR?=
 =?us-ascii?Q?i5bNbsiUmPD3MmvQkDBU5tyxQlWojzRlA/4++akQTcnQo3m6OkFunikXz75P?=
 =?us-ascii?Q?TBRx3zWuBDr69SQjkM6qy7I4JfXw4K/FQRnJF6wYiIsmnKlU47vKYWOD6Gmi?=
 =?us-ascii?Q?pYw3YKEwulzhKSaY9gqgGSCSVHEVyoVCqVgxGH/E46r3A4VIIAEGGTZX5O6q?=
 =?us-ascii?Q?oDEOUbsIEV5YuTVRy6u7VhJZ5y/BpEAWU7RVFbZ+MvXakwD5PZJa1OWUUBWy?=
 =?us-ascii?Q?r9Xd7kUp8f27jngpAgVxGEXptZ4AyS+wXOQ3zUgLkzs4hTeVZSu3jIyDVKOr?=
 =?us-ascii?Q?A2YMNZEQ2g+EbXECqbMLvoTJtXisdhadRYaeD4N5RBz68uHue2zSJUOCraRj?=
 =?us-ascii?Q?/76wSbjUvTCX9kYhVToGBnU3aEuk8buL24Q+RVoJLXQXZX77lYeO68hZcb7W?=
 =?us-ascii?Q?ajbN1HPNf5Tdks31YvBQK00QTd79iFQ71Ioaull2TNPnVH/zFPnqro1/K8tS?=
 =?us-ascii?Q?0mHZSMDdnqQvWoF/ro10ncFDknFie22EA42njPHRW9tvmhljPYBSImOHtLFh?=
 =?us-ascii?Q?b4Eegm18fxB5QKpuEYZFHxCthiNmk+joUAa+DeQ/xApGbH7wqkU/W8vh+Ccw?=
 =?us-ascii?Q?nsW5j3E0x9od47QlMVTHAsKg0qe+4Zl3UpxZaZzCUkWmHPRZSJ+VLM3iOg4j?=
 =?us-ascii?Q?KVIoQOpopahPIx+Npgp+uILpWyy8E3f8HPtJStWywIIh/FVid1XAo2VWwytn?=
 =?us-ascii?Q?iDvGORrreKSMcZj8EvnIa1xnwoTfR35KFx/cSt0rNsp+/7yjf5ZQIulZcXz3?=
 =?us-ascii?Q?Ic4nMi738y4PNvOITp9ztwT4DGdPEAbbfVnyCh5UlBjWTIb9K/kX22kGBFe+?=
 =?us-ascii?Q?+Ud6yv0/NDzMjgxUhW+fxU2EbS9u2E5xQr1Ux5gBYOTtJQSxm6aBOZH4hN4A?=
 =?us-ascii?Q?7MPPFxVaRtrp+QvDfNXMukl9B/Spjg+QM91cefSxnM1T8Tjh7iiN5MtdrTgn?=
 =?us-ascii?Q?8rh1LjySx56OJu0sNBEpvw/kWDLmMl8o5TQv40fn5M2bXImL8XKCy207REh1?=
 =?us-ascii?Q?inP7pmT5zrVQjCW1TG+m5vMqWl/Ao0wXNbfjM++zg8e/F1slGOL2am+Vy+jp?=
 =?us-ascii?Q?gyEEDF9+rsrqkvCEAXtrtcJD/dilVY1bAzTLJRRnY91eUuK9G7piBxg12NKX?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nUVkTATff8n5tVqFLHBJynRRy3oiZtG9d0BLaDoAf79gA8kYZGqybAZ9TWZt?=
 =?us-ascii?Q?w8Ex3h7EuS3aATZaQdgRe0gHMOlsuIT28Yfu+Xv8HM6igv/yvXm9VafwLRAT?=
 =?us-ascii?Q?TURV3lGPsPRcw7AgblDDC9DbYp4e3zHg9EzQDohaELYJEndXuP8gHDDU2HmU?=
 =?us-ascii?Q?EqcrXKmm9AgbS53JQc9fdHN0gD3jB06MJrzhkzR3W7q/WD3oaN2w+1dCkcYe?=
 =?us-ascii?Q?D6TkScrLfHbDs0/j4vyzWps4WyWApgP8wh2gCYnD0qLNyNUg/MOppEwIUSHM?=
 =?us-ascii?Q?UrRIaUYSpoUNS9fpCjrAwucTJwcl2GgZS1ijlATEN2OwQE/2hFLKLHCb6hPQ?=
 =?us-ascii?Q?SvbzuCJ9LvVOrYjmGcaNqXQa9CeEK4GEWmXtffSh0md1nRyrzB77uG0jf9xw?=
 =?us-ascii?Q?6sEtGDnLrzYXFo3HhHOOmrwuxtp1xHGf3DPaX/mAqlM4XJi44g0IzBM2Ny7k?=
 =?us-ascii?Q?QkIuppWMcpaZ4Pn3I2qcwgDPJOhjVDOFFsTBRJ7fp21vdThv4Kxlj/QNUcrr?=
 =?us-ascii?Q?VKOk6lPNiPnHIiPl3mZnKX1Ru6dwrgztAQnyy8ZV9Rtm0dh3yCvlqUo9/6I8?=
 =?us-ascii?Q?dMsOfkFhKvlcBNwKWecV+ZkDWMXUG+UgWt3+XdOWpVCcfEmBm7OQoPvn34Xb?=
 =?us-ascii?Q?tGZabQXKpJqlIsM8DLm1ivpNHr7vV7EihCdFx/PWVjgUSFdqVdRrLWC4GQy8?=
 =?us-ascii?Q?SWZyz030N4yyMTHQJivomUKMLM9ro/r4Ix8UAtXp8r7sASgFer5PNOLMaUhJ?=
 =?us-ascii?Q?u7vO+Ftnijy+ToMFZvPpoEnu06X4QvD+yYgt5rAA2Gr9szMrVYQjot2F9W+p?=
 =?us-ascii?Q?Gb0p3cGZXfX8a8bZBu7XvVHl5L5CD0wZbLWuO/eSzcZX/CS0lXIKpyQ8PliW?=
 =?us-ascii?Q?u3RFXsIRfPmze/1M5EUn444pWrETftyLuqBn/YkWA454SPgg04CIFSZvsTX8?=
 =?us-ascii?Q?KMqZ1wNRbuYC76B54nGZGau/N6+lskEdam6WnHaU2lBrqYTMBFn+oEEPuVSm?=
 =?us-ascii?Q?VvHfss/HVntkJc+ETydo4Y1ANJTXDdNPomL5FWjZ9X2to7QB7njWQxpgrdFh?=
 =?us-ascii?Q?XDaXTlAnsSrut+797JzjDKmiwhU3Zb1bxDcF09mhEoD33DODAW/osoRZ9UdY?=
 =?us-ascii?Q?RnH66hfxRbm4KAHCSPIK56vfOngAqw3huUTO5K/zqxOzR1Hi+rBdCuc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90e12e2-ad8f-4f1a-5115-08db79d48689
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 01:43:10.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpZXx4Aqe93tuy/Aqpl41oYL9EabDORgjo7TU2fVowu0l9COFxchSyu4UHhygcHDuausIyLJCD8GaxYq/vnohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-01_01,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307010015
X-Proofpoint-ORIG-GUID: 9f1H8NqYx_7FmeLWO96MPnZn38X1lq5i
X-Proofpoint-GUID: 9f1H8NqYx_7FmeLWO96MPnZn38X1lq5i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
> Run as ./proc_filter -f to run new filter code. Run without "-f" to run
> usual proc connector code without the new filtering code.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/connector/Makefile    |   6 +
>  .../testing/selftests/connector/proc_filter.c | 308 ++++++++++++++++++
>  3 files changed, 315 insertions(+)
>  create mode 100644 tools/testing/selftests/connector/Makefile
>  create mode 100644 tools/testing/selftests/connector/proc_filter.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 90a62cf75008..7c9673951f9a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -7,6 +7,7 @@ TARGETS += breakpoints
>  TARGETS += capabilities
>  TARGETS += cgroup
>  TARGETS += clone3
> +TARGETS += connector
>  TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
> diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
> new file mode 100644
> index 000000000000..21c9f3a973a0
> --- /dev/null
> +++ b/tools/testing/selftests/connector/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall
> +
> +TEST_GEN_PROGS = proc_filter
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
> new file mode 100644
> index 000000000000..99a382ea2544
> --- /dev/null
> +++ b/tools/testing/selftests/connector/proc_filter.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <sys/types.h>
> +#include <sys/epoll.h>
> +#include <sys/socket.h>
> +#include <linux/netlink.h>
> +#include <linux/connector.h>
> +#include <linux/cn_proc.h>
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <strings.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <string.h>
> +
> +#include "../kselftest.h"
> +
> +#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
> +			 sizeof(struct proc_input))
> +#define NL_MESSAGE_SIZE_NF (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
> +			 sizeof(int))
> +
> +#define MAX_EVENTS 1
> +
> +volatile static int interrupted;
> +static int nl_sock, ret_errno, tcount;
> +static struct epoll_event evn;
> +
> +static int filter;
> +
> +#ifdef ENABLE_PRINTS
> +#define Printf printf
> +#else
> +#define Printf ksft_print_msg
> +#endif
> +
> +int send_message(void *pinp)
> +{
> +	char buff[NL_MESSAGE_SIZE];
> +	struct nlmsghdr *hdr;
> +	struct cn_msg *msg;
> +
> +	hdr = (struct nlmsghdr *)buff;
> +	if (filter)
> +		hdr->nlmsg_len = NL_MESSAGE_SIZE;
> +	else
> +		hdr->nlmsg_len = NL_MESSAGE_SIZE_NF;
> +	hdr->nlmsg_type = NLMSG_DONE;
> +	hdr->nlmsg_flags = 0;
> +	hdr->nlmsg_seq = 0;
> +	hdr->nlmsg_pid = getpid();
> +
> +	msg = (struct cn_msg *)NLMSG_DATA(hdr);
> +	msg->id.idx = CN_IDX_PROC;
> +	msg->id.val = CN_VAL_PROC;
> +	msg->seq = 0;
> +	msg->ack = 0;
> +	msg->flags = 0;
> +
> +	if (filter) {
> +		msg->len = sizeof(struct proc_input);
> +		((struct proc_input *)msg->data)->mcast_op = ((struct proc_input *)pinp)->mcast_op;
> +		((struct proc_input *)msg->data)->event_type = ((struct proc_input *)pinp)->event_type;

These lines exceed 80 characters.

> +	} else {
> +		msg->len = sizeof(int);
> +		*(int *)msg->data = *(enum proc_cn_mcast_op *)pinp;
> +	}
> +
> +	if (send(nl_sock, hdr, hdr->nlmsg_len, 0) == -1) {
> +		ret_errno = errno;
> +		perror("send failed");
> +		return -3;
> +	}
> +	return 0;
> +}
> +
> +int register_proc_netlink(int *efd, void *input)
> +{
> +	struct sockaddr_nl sa_nl;
> +	int err = 0, epoll_fd;
> +
> +	nl_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
> +
> +	if (nl_sock == -1) {
> +		ret_errno = errno;
> +		perror("socket failed");
> +		return -1;
> +	}
> +
> +	bzero(&sa_nl, sizeof(sa_nl));
> +	sa_nl.nl_family = AF_NETLINK;
> +	sa_nl.nl_groups = CN_IDX_PROC;
> +	sa_nl.nl_pid    = getpid();
> +
> +	if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) == -1) {
> +		ret_errno = errno;
> +		perror("bind failed");
> +		return -2;
> +	}
> +
> +	epoll_fd = epoll_create1(EPOLL_CLOEXEC);
> +	if (epoll_fd < 0) {
> +		ret_errno = errno;
> +		perror("epoll_create1 failed");
> +		return -2;
> +	}
> +
> +	err = send_message(input);
> +
> +	if (err < 0)
> +		return err;
> +
> +	evn.events = EPOLLIN;
> +	evn.data.fd = nl_sock;
> +	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, nl_sock, &evn) < 0) {
> +		ret_errno = errno;
> +		perror("epoll_ctl failed");
> +		return -3;
> +	}
> +	*efd = epoll_fd;
> +	return 0;
> +}
> +
> +static void sigint(int sig)
> +{
> +	interrupted = 1;
> +}
> +
> +int handle_packet(char *buff, int fd, struct proc_event *event)
> +{
> +	struct nlmsghdr *hdr;
> +
> +	hdr = (struct nlmsghdr *)buff;
> +
> +	if (hdr->nlmsg_type == NLMSG_ERROR) {
> +		perror("NLMSG_ERROR error\n");
> +		return -3;
> +	} else if (hdr->nlmsg_type == NLMSG_DONE) {
> +		event = (struct proc_event *)
> +			((struct cn_msg *)NLMSG_DATA(hdr))->data;
> +		tcount++;
> +		switch (event->what) {
> +		case PROC_EVENT_EXIT:
> +			Printf("Exit process %d (tgid %d) with code %d, signal %d\n",
> +			       event->event_data.exit.process_pid,
> +			       event->event_data.exit.process_tgid,
> +			       event->event_data.exit.exit_code,
> +			       event->event_data.exit.exit_signal);
> +			break;
> +		case PROC_EVENT_FORK:
> +			Printf("Fork process %d (tgid %d), parent %d (tgid %d)\n",
> +			       event->event_data.fork.child_pid,
> +			       event->event_data.fork.child_tgid,
> +			       event->event_data.fork.parent_pid,
> +			       event->event_data.fork.parent_tgid);
> +			break;
> +		case PROC_EVENT_EXEC:
> +			Printf("Exec process %d (tgid %d)\n",
> +			       event->event_data.exec.process_pid,
> +			       event->event_data.exec.process_tgid);
> +			break;
> +		case PROC_EVENT_UID:
> +			Printf("UID process %d (tgid %d) uid %d euid %d\n",
> +			       event->event_data.id.process_pid,
> +			       event->event_data.id.process_tgid,
> +			       event->event_data.id.r.ruid,
> +			       event->event_data.id.e.euid);
> +			break;
> +		case PROC_EVENT_GID:
> +			Printf("GID process %d (tgid %d) gid %d egid %d\n",
> +			       event->event_data.id.process_pid,
> +			       event->event_data.id.process_tgid,
> +			       event->event_data.id.r.rgid,
> +			       event->event_data.id.e.egid);
> +			break;
> +		case PROC_EVENT_SID:
> +			Printf("SID process %d (tgid %d)\n",
> +			       event->event_data.sid.process_pid,
> +			       event->event_data.sid.process_tgid);
> +			break;
> +		case PROC_EVENT_PTRACE:
> +			Printf("Ptrace process %d (tgid %d), Tracer %d (tgid %d)\n",
> +			       event->event_data.ptrace.process_pid,
> +			       event->event_data.ptrace.process_tgid,
> +			       event->event_data.ptrace.tracer_pid,
> +			       event->event_data.ptrace.tracer_tgid);
> +			break;
> +		case PROC_EVENT_COMM:
> +			Printf("Comm process %d (tgid %d) comm %s\n",
> +			       event->event_data.comm.process_pid,
> +			       event->event_data.comm.process_tgid,
> +			       event->event_data.comm.comm);
> +			break;
> +		case PROC_EVENT_COREDUMP:
> +			Printf("Coredump process %d (tgid %d) parent %d, (tgid %d)\n",
> +			       event->event_data.coredump.process_pid,
> +			       event->event_data.coredump.process_tgid,
> +			       event->event_data.coredump.parent_pid,
> +			       event->event_data.coredump.parent_tgid);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int handle_events(int epoll_fd, struct proc_event *pev)
> +{
> +	char buff[CONNECTOR_MAX_MSG_SIZE];
> +	struct epoll_event ev[MAX_EVENTS];
> +	int i, event_count = 0, err = 0;
> +
> +	event_count = epoll_wait(epoll_fd, ev, MAX_EVENTS, -1);
> +	if (event_count < 0) {
> +		ret_errno = errno;
> +		if (ret_errno != EINTR)
> +			perror("epoll_wait failed");
> +		return -3;
> +	}
> +	for (i = 0; i < event_count; i++) {
> +		if (!(ev[i].events & EPOLLIN))
> +			continue;
> +		if (recv(ev[i].data.fd, buff, sizeof(buff), 0) == -1) {
> +			ret_errno = errno;
> +			perror("recv failed");
> +			return -3;
> +		}
> +		err = handle_packet(buff, ev[i].data.fd, pev);
> +		if (err < 0)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int epoll_fd, err;
> +	struct proc_event proc_ev;
> +	struct proc_input input;
> +
> +	signal(SIGINT, sigint);
> +
> +	if (argc > 2) {
> +		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
> +		exit(1);
> +	}
> +
> +	if (argc == 2) {
> +		if (strcmp(argv[1], "-f") == 0) {
> +			filter = 1;
> +		} else {
> +			printf("Valid option : -f (for filter feature)\n");
> +			exit(1);
> +		}
> +	}
> +
> +	if (filter) {
> +		input.event_type = PROC_EVENT_NONZERO_EXIT;
> +		input.mcast_op = PROC_CN_MCAST_LISTEN;
> +		err = register_proc_netlink(&epoll_fd, (void*)&input);
> +	} else {
> +		enum proc_cn_mcast_op op = PROC_CN_MCAST_LISTEN;
> +		err = register_proc_netlink(&epoll_fd, (void*)&op);
> +	}
> +
> +	if (err < 0) {
 
 -2 is ENOENT, -3 is ESRCH (no such process), so I think you won't have
 collisions with the send_message() returns.  Ah, but this is test code
 so it's probably fine.

> +		if (err == -2)
> +			close(nl_sock);
> +		if (err == -3) {
> +			close(nl_sock);
> +			close(epoll_fd);
> +		}
> +		exit(1);
> +	}
> +
> +	while (!interrupted) {
> +		err = handle_events(epoll_fd, &proc_ev);
> +		if (err < 0) {
> +			if (ret_errno == EINTR)
> +				continue;
> +			if (err == -2)
> +				close(nl_sock);
> +			if (err == -3) {
> +				close(nl_sock);
> +				close(epoll_fd);
> +			}
> +			exit(1);
> +		}
> +	}
> +
> +	if (filter) {
> +		input.mcast_op = PROC_CN_MCAST_IGNORE;
> +		send_message((void*)&input);
> +	} else {
> +		enum proc_cn_mcast_op op = PROC_CN_MCAST_IGNORE;
> +		send_message((void*)&op);
> +	}
> +
> +	close(epoll_fd);
> +	close(nl_sock);
> +
> +	printf("Done total count: %d\n", tcount);
> +	exit(0);
> +}
> -- 
> 2.41.0
> 
