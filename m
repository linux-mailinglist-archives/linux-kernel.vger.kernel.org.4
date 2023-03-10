Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8996B53C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCJWFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCJWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A6105F20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:01 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALiNKS028939;
        Fri, 10 Mar 2023 22:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=W7qRwBDMfTUla5lm/y0u5ByOA0UDUIrnm8QJPHPM1EE=;
 b=XhaVqjMqnMXSnAUilagBqN/oHoUaiumPWxOVca2cLMtkKjEJxXwBeHEayN2QOvtJaWTI
 UyIehB2b8yzI7dhgoJJqMWdG7Xx4I/4HvylSJQ0OqC0D40MA/WnyEP8G3Lir1ehz4W64
 XY7M3JGd+hkmJUn/ojMB6IBxvEWd4/UlQTy3VFuU/9qKE/Ja10JeWeE3xvYvl0njxfdh
 4jYjdvQFxOy5sc8JMPG2Vq6zVb4WXgnN5g2zUDnkrL8rAcVpCnwerqsYD1UNJUEIpGlC
 FMk3tSTfticDFaG7Ci+bRVgGEAE68F/7IxIqhpumTKgBJDrO1qqrltNBk7LQgn6LMjSs Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cp8yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ALm9c7035033;
        Fri, 10 Mar 2023 22:03:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fubfdqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh96zIhjU8ad/kzKm0tAfLIBHLCFZAAZh/DOWJ5R+ub6pEUPRjBBfhMrykD136KhTFsMHei2+3nbEoYMzWAIPKadkG15GEmjbDKxeshMO3DvZyHujWt+pyNAhMcGs6WSMcLGxZUT+AuFrqGRlJwewZKXpn9bmJozH0rkJlFV86cx3dODx2R1i3gk1qzG+ThxKfm4JTDhLRGSg2xrKPGlCf/5/2YEL44nzp3FQa7pmoqiyA9AQWtwY+wcxxfKjrsnmel/QvaZxoiE5msSe77s7HiA6uvhLWjTsvQz3aXTQTf8ZxBw6E95LikdAB0LXx7ON6xx5JzRdIYWnZyt4gzeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7qRwBDMfTUla5lm/y0u5ByOA0UDUIrnm8QJPHPM1EE=;
 b=U9B1ew8HNBkaL+NLvAurGOmT7YuKPsycB/G1pfni1Gzut8KosaGLRxCTSksA2gBFN038/o0+r4+OOlg62A3F9ksjxMItolPFWSp49M08Z6orj0wgitny3kVt+0F49VIBecSM9WC4kJlX81mY3xBb3LZ7zxL/fSs+UuGtKCtSuxjIlRzQxoR82q3kTbWVdLh/ogxJMkZm/d582/dkwmIESnuF7oUdG791zUJSCBMaHtgbO1DtKDwU2Ce7wOLdpnqoGhjAi0oKkUz+eobddAS5TbemdrPEpU8Q4E/pPaAwjvouT6rt9gJBHoCuAcSXlNuFYnCoAYwCXT1r8B4yri9uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7qRwBDMfTUla5lm/y0u5ByOA0UDUIrnm8QJPHPM1EE=;
 b=Je/GP+kRIQjoc60l4Pp2HBoLFrr8jsgtapMQIWBjJQIJq2lZfipaUeHoVdmtQzwqSfo4ZMd5wsuHjHBsbTrFYLyCwT1ZTIb47uly0OzafrW5y4RTVOJAv7TzF6bUNJ/SXaFt2X2YZc2xDjGBSSpksdwJKz7PojehPGRxRLsd6KI=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:41 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:41 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 04/11] kernel: Make io_thread and kthread bit fields
Date:   Fri, 10 Mar 2023 16:03:25 -0600
Message-Id: <20230310220332.5309-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:8:57::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 180ae6e4-a9a9-4c0c-8032-08db21b34f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5/NQIzJ271WyPDGk7pQEv+UbqwOov64EzZIjiJTfDFQfXHzFo7UnPQxwQG6C0gXyzUAuoG/fJq2jfhgUktFseuudeB9+7GP4sH1zQqi9z92o90vWg0kUe2gZ2HdpZzXZ4Ph+3RlzEJYWJHscUtYtwbFZtbC6HqplginFXZ24/47n2hY1IdeYr9orIzFw7cwJ3WOsl9g3Gulv/EMSyiDMonbPg9wIj6KFniYFCjL0rhP6FabvvwmGgYqh63l/V5+eggzMKzAKHrBiFa61Bm76IIF+QMfikXtaRDuJb3eKKcBXFDlb/hlcW5xBYpcCCmohniPeMKcIxp9v8DYu9MdBNmAMW+YR6SlvnV1rV/b5zVperutrgOk2MfRICyafYhGxWS4eMBFUqI5aRYDw+IriCLTBJzJGI76tbUzXvtehyaXG39uDNkVR1NkzWF5QcVe5xDi01XbhenU0DlMKtsrFE1vowZlrHTVIgNJhoY4K1YA7UJHafRnJKPY/1ujzH3Y9l19XMOWHK14OOUTlSVr/05Ec9lCyrXqROQ6oXyvCzmSPEp7t/U8oNRshi86Zl8hS8qcQ7v5j4NOuey3qVHGBUeUdMzs5ycEg3EcAvozDPkHJuIB04D72Q2ZEaeEwt9CExrmhLYJVWu8LKasA7QPuWZS8jTCV6dkVpudNRhk/yV8zvpBeEr7lqvMhx0ZvCJG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(6486002)(186003)(6512007)(66556008)(6666004)(2616005)(107886003)(1076003)(7416002)(83380400001)(26005)(8676002)(66946007)(4326008)(41300700001)(5660300002)(4744005)(2906002)(66476007)(8936002)(478600001)(6506007)(86362001)(316002)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTQOfoiPTA07BqVvTuNcnhoV70Mm+9kTMKnOlzT/72o8a2vKSlOcUbIhR7eq?=
 =?us-ascii?Q?GiBJ27xDKNrmbk+R0yDhKp89TtFDhvPtIH3uPMRkb+l35AFcmkfX6dTCwBHf?=
 =?us-ascii?Q?vRr5l+O/6llfM0+buUz5EK+g6fjGrs04yrMCoPVuyxkBBAWfWBGAUMxeTK+v?=
 =?us-ascii?Q?dY8lHZI0v94REzp5wUgGcLfPhrkp2I/MbjgbZgqgpWWe6fF8YUQIi+sXEmKs?=
 =?us-ascii?Q?gMSojP95Gwf88BENdj5R+fXaPFT9RxHeJnhwc2yAVNciEx18Nb4rR3RNnqBA?=
 =?us-ascii?Q?OC3FVZOB08mn/MYAGQwEXCHPxybA0m/vapgmBqWQpjXy9seIoLt9qtDhy1xF?=
 =?us-ascii?Q?cyf9/y2d7OyQdfwCZ09wbbuKe33GsgfslYQsHotzDh/NhYcB63TKaneCWRTL?=
 =?us-ascii?Q?ZFYGupgIip2S5ZOb56WBHU5nmy29TdQpPTCNbkBEIgd9VTvZJcD7O9TqwmZX?=
 =?us-ascii?Q?e1fP/Z+0sCGO1ogp2y/Kgrzm8bCp9qbVSanWLi3Y+nIz3fXoiB2O71TeT7/O?=
 =?us-ascii?Q?E/qXzggSXypw9RWvQc4IOtHFC18+duCK+sP7MAljZEjGgA8W62p9s933Olak?=
 =?us-ascii?Q?Y3VSlYei3Z/EWVnKXJNtX8U/lwM/c2QzYIF3/8m++jAogGFHUAnyi1n0gejl?=
 =?us-ascii?Q?ybKWx7a7WkNeRPsEMpUcL1K1XQ/KYEPEuwmLwSkdF1+knNHJE0iyMwh93eGU?=
 =?us-ascii?Q?64TGQqPQMhlaHRdFy6ODWTD1csxdREnQfoPqHybd2qKaVPvVqAIzEW/iG3MW?=
 =?us-ascii?Q?FybMZ5K6tnk2mYan8uveUj6WjyzS4qBtD65DDnKA2XqHoav7QaSJZvp9lg2d?=
 =?us-ascii?Q?OspTcKHzrIUepokmTzATfmjcIs8YsdIb+R5fbfN9XA/9HO/iJVRm2haGEe5k?=
 =?us-ascii?Q?YgqIMM4gYEfApa8xNWIKaTfVZm8j7l3shggFPgaFrFiOiarBg6lYG/t5/phu?=
 =?us-ascii?Q?bwuuTUbSmhrN0mIwj/fHkpZNrwdOwkBfPlcmMVH6r1+nW4Th5P31a09yPrch?=
 =?us-ascii?Q?9INw5AgmEaArt6FuyD0rt0oDAYCobEx5O8CacrUeUGOkI3c00AhaRIjFCvsy?=
 =?us-ascii?Q?8JAIyH59J1uZRlTnir1POsgZqftfJ1LfDxrYIDLcsUmZB6hFxHFMdrrz02YA?=
 =?us-ascii?Q?1lrl54UDfh+qycBggjySCVTNvA1PC/rETvD9qC/sWX6Oqc1Vngkal1lToQaE?=
 =?us-ascii?Q?Vc2MfFIUNGbEkKezEIOQkzatLL082Jk2JJnRN7czx2DCm7UXNGVhnRieQh/O?=
 =?us-ascii?Q?HllYMSOAyi5Cv5VnQLhN1XYidC9lBGiXQ6OS/Ld/6dMHpDxzJ77IJXeiAeQ7?=
 =?us-ascii?Q?krUG13CHd2iX+tKup4wWrEvjiktrhzz6mOkidbqJFH3O9EXDHK5rCk+LFKuS?=
 =?us-ascii?Q?uigU3sXQdStAEaQ+hZwpl/m7Pt76tb0DRihLmS3yCB4hPuPVTNtwHDNwRrs9?=
 =?us-ascii?Q?vYI7w2umCXKQ05X0X/sCO3UHH0YnIFAkAreiY+HxM8bQViEGADDt9qdDEMgN?=
 =?us-ascii?Q?iR2pUDsewqkYnYjnk3qkdO4ukLKiKgmYdLJpLaP6SlGfpYN6Jy5A3CiTpTNJ?=
 =?us-ascii?Q?xAQmOqiu/TIiugAcAAhihDYx2GPv/7K9k08lr/nDpkGd0UAvicvYeyO0jmZg?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bJlUhsC3FjgcTvjhpuhgF4wNXgalwbB6WS08d/RGtoI+w7TU7708sLQBoDHn?=
 =?us-ascii?Q?OOcmkQIjupYymb8QZeL2Jy/d70f/aU2ZV7+ppG/gNsG3v/fQUIFL758pecyZ?=
 =?us-ascii?Q?iSYj9nV4LnXMRL7tGWzDKUS4mRDVJR/tA0KQoolzkPGQVQhN66c/4VTbf9O6?=
 =?us-ascii?Q?XxIMowk19r9/DQgWU0B4hf26wnTHSVNhRduXOsvZS8sWV8zeVc1kSl+Ciux5?=
 =?us-ascii?Q?GSJqCv0zlwgp1iNEVEyrHl2Jvwb+t6YMjfw/GLlch9Ou5l0PRuYahiJhiSNU?=
 =?us-ascii?Q?xhoDQzWyjKUNYrInqTn7ggljXe9GtRgKGbqo3Tm5J/v8HkJfcSdfMyXcOqEE?=
 =?us-ascii?Q?A5ss33At0oAwkM9EpAeCyAmEpUcy2vdhHjQqTfreysPeOj21P3NC7uVQaWLo?=
 =?us-ascii?Q?79HUxSaxqMvlN2ydAwXGzincigyp+l2EhfdMTSeaf98p9ucSedJEqCr8soc4?=
 =?us-ascii?Q?VifUCUN8QHM4t27rDFd6dRBGVXMLEIN3mnWSYJ8h8Ed/Pe0KawWjMlqfhYBz?=
 =?us-ascii?Q?mrATjy8oVZ5RmFuvWnwYzBY97gUYhDO/yh4rKjtZp3Vz9RYDtUjhQOgyTwhw?=
 =?us-ascii?Q?RdPdvGQ5OBrhcCelAPW5URN1BiuPQRidCEFhnCMY0wviQ8E00nrsgAJOZNS2?=
 =?us-ascii?Q?zBxP7x2iYx1fpohRQyhRsXP9tvc/oKZmpWgRaPzxuijVECeSpltDUPjCgeeq?=
 =?us-ascii?Q?YAg8Ys9VIqMhTy4WZ2jzyGVpzlMG9DsWisrKruXRWAUqWEoLMvOxGXEwJaQD?=
 =?us-ascii?Q?VRXR00yddf1GT4VmuNgPWiEWTS9/k8HzuYNaFe780R8Y0TIDC1rd4XPu3QRi?=
 =?us-ascii?Q?8K/ZU97q/tXTBrbVihu019J8BF4oHUh2k8mgUispTAgCDNB1uaTnQwMNWxal?=
 =?us-ascii?Q?WEatSU5QudTblGHvnI/wPrqH/Ur9vEbgCToeUh/hpFO+dcPUq4Ucwh1lngou?=
 =?us-ascii?Q?Iw4+pWGM4NmueVvAUnbUH7pGJa9qLlGha+8vMmRd/QiqUk236UlttoVmCYfI?=
 =?us-ascii?Q?MWUUwsnjfHTPym3FLTLaKQ+4lA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180ae6e4-a9a9-4c0c-8032-08db21b34f33
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:41.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kmKECQMMTbmIqVar/0bhRe1S877a9VI3jSRRlijpheWU2+6T6DIpWvcRJqYLH3zXhM3beTSNcLMwCnQr9d9rK90nPwuoOGMhgKHA+2prfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100176
X-Proofpoint-GUID: cF9ZAoR8K1iNw4Xm-XKGy4xmOL5P8Aoq
X-Proofpoint-ORIG-GUID: cF9ZAoR8K1iNw4Xm-XKGy4xmOL5P8Aoq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only set args->io_thread/kthread to 0 or 1 then test if they are set,
so make them bit fields.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 32c9f01af0a6..268c77a42155 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -25,6 +25,8 @@ struct kernel_clone_args {
 	int __user *parent_tid;
 	const char *name;
 	int exit_signal;
+	u32 kthread:1;
+	u32 io_thread:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
@@ -32,8 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
-	int kthread;
 	int idle;
 	int (*fn)(void *);
 	void *fn_arg;
-- 
2.25.1

