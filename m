Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B137076C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjERAJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B4E40
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGutg018208;
        Thu, 18 May 2023 00:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=87egIbAQCeeUb4SNW57wBw4NAeWxptsRTfRNI5cZnvs=;
 b=hsY3PrT0eTQGftmepuL5WoOy8V3Ca4/8/EL/0kld4uhRJJeTNyB1iS2yjhULIjvyjDbS
 WXlw0yDvw9Y70Ak7kyafHRbjQGQwMybdlF76+xA4zoFrdEkak6H4VQZ7TsP08EMEgwzA
 7xrfMEpt8OrSHa/CGvhqjoUE8ivQxcJCPeQzDiJuZg4DZ2pKIIGEmuySh9pS5uNfI6QM
 GtYsNOo5kKYAL/3BUfXwgAD/EEIEW6V7KYWUFclfiema5W93OFg08COEjSNKadUoWkaX
 fvE4NSIuoi5fQdE/G7Oxk2kuJ5qKsNIhMyXB/d0ZzyH7BzH42Oz4RCZ72blwjM4/Q8jh 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye6r3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HNdPMS033964;
        Thu, 18 May 2023 00:09:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106kbwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLYALz6yIwu1BjQTsfnUDtjEb+0eYtQo9OVvqwUfm8KOyiotEChob1IcHjBgUSYVxr5qvk3WPJ686FQoDDAfSIvAcP27l7FPIIdsNjLDWD3DjcH0rRVh7aChuaWIP8Ub/UyM+q/JzyFXAbgExI2CbWnjTpo94TzdZFQbZFDyXqrRQ43qoJIjewj9R8Cik6zodz06/eAkOOVbg2IfuaBgdJHXsdNVP8KiiI1rrpTDQ3hwvVKOUnU7TSM8yER6nUq1R91b7N9N0daLpPbJvpeX0UjP/ZbSxIXxUDIf9FFu4HsuDeL1CCHeg165Yr7TGCTccxqKIBvSqlLvAMxJK1BHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87egIbAQCeeUb4SNW57wBw4NAeWxptsRTfRNI5cZnvs=;
 b=aQkgSA0D9mXK5v8MkWx8K+N8UrBVY9S9AUgEC/gMR9S98L8pjJYRG7E47T4ErybzfvcP9nmcyUx0Js2XOWQsg2SDFcNvsGzVjYDPRCOLA4W42Yx7yAdpfu7LZHMkoGexilCdcpADT0H+A/EQcOuvHwqYXHee0ken3Mi+noiETLJIufCbyqGhJf4gFveGqQZiROe6WCBB/msgi1nxPxLn4xPCpXKWsXxg6cPe3Hd1gZfSjfXJMmhTvflwJMn3LrxAJCfOV3qsKEoD8oXWxbW/KEklaKqabX3wTZxhuT+WTQEc0NxRjIsThwlgJZ/BOQY4AtsdlUI5FeYCHJ4fbgs36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87egIbAQCeeUb4SNW57wBw4NAeWxptsRTfRNI5cZnvs=;
 b=J0tfjBQ1KPylfH8NLdOhAAtAUYd9N0wExSrht9cqjMc0QPR9yKNk/LKCv1o+6ZF1201pbiz3g0Jb+eeF2O+Nqt2c152DtikBzNN66TduhOAV5NdTWtXU9YMky6kSpXVtT87Vvwh9G/PEUBM6O+uX9+zL8I0vdOhqEYtYyiLEjQ4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5332.namprd10.prod.outlook.com (2603:10b6:208:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:28 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:28 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 3/8] fork/vhost_task: Switch to CLONE_THREAD and CLONE_SIGHAND
Date:   Wed, 17 May 2023 19:09:15 -0500
Message-Id: <20230518000920.191583-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:8:2b::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 55083ccf-30c4-4c5c-062e-08db57342551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nezV1alWFrPdyEZAXxBdkV7YqJiBgdUjVKzVgy0hNLO1jbJreCbJ9UFobalQ0Pixk2jg3SAVJH6XYz6Y+f0jSwZ1qSDl8/ce4H6V6rkibRca/ObYEuSo8+qaa87QccvmxX5yBBzvQ/c/SnNlZOZhdnwisJjTZpl6WP6+ccdaKHUtG3AxmI/SxxPfJBgzJ1SkIMlRnN4bkFz12TJbXYDp1M4SGLeZiIJGLKLY5F41kffOuQNaWFUMz4I/YIwyzlaSMZTT4pSwqm33cqhxp+3c7c4xXB5Ypqb40jcypxT4pB2VTac6tvjf4xMwuK/zvDhjQF1UsrObFh7Fk1LF6VLxqYaUaTHhzWAMACIknC3zVNocayxIQZUV4s2AvwtfavMm+42suZK6GBmQg+Z0iNgEHPmzJ7jQ7DiREVfFqomK1534LIgXv2VVq/xvMjK5PPAmbucGRaO2Xq27daQEuG/6pcAdEXjiXGrhiPsEW4kp0oY9NOw8fldeg6ls1zAfUAs3JL53I2HIeWzN9w0rUn72OTu8SMrZrjril6XdG0EKzTHumT5FaxlGRzk1Zr85NTxP3tzoB0WAQx8dNepewLvTVhxJRSPkiPRBAlPpWoKAqDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(4326008)(6666004)(6486002)(107886003)(478600001)(66946007)(66556008)(66476007)(316002)(41300700001)(5660300002)(186003)(1076003)(8676002)(8936002)(26005)(7416002)(6512007)(6506007)(36756003)(83380400001)(2616005)(2906002)(38100700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UA8irs53wLUUc7SCmGQ/d5bI3cJQVme5PgXL89bcfR9xfG16xbf7HLA7ea3m?=
 =?us-ascii?Q?uQpYaZzYEubgkhSIzVN2yCyGD444rWaFsnwLgDbOSWJqt0J/Xkl/0k90hPo2?=
 =?us-ascii?Q?gw17GqGdHWGIs1Pj1HSPFPBPgW2q6L3HyWJZUt5Ho1LH3GtEAjeimOx3EQqy?=
 =?us-ascii?Q?hlX/R4nrOcYHP8mjErySjHXyzD4I8/wIHQH9ojJw03tQ61vyFnRlF7iJuMg+?=
 =?us-ascii?Q?fppbZLW7tGrQdLa6SUiGi2vY74s1gVv7FpTqRuVXPwCypm9rQnVAczU2MzCM?=
 =?us-ascii?Q?JL3dOryI3uo5XUu+4sRZ+puSXMNSGtvh+cFCLav/c5odAGc4OBpFzRz/mgSs?=
 =?us-ascii?Q?bvvT+CvmNsQjY1xGb4v0UATXUqtzFDFGyhvp+Rd8ZwsBNm6JERSd9dt5Myei?=
 =?us-ascii?Q?JcbuY9tRS7nBKNlXr+MgjyH+x9mliqzAMugBqkF8p/E+jAbev1DPMezg0Cgg?=
 =?us-ascii?Q?2SbaTYeLsMDF1hv43NnkAFHoTO25G/lCSzvuHfX8Njs2kYYpBkSRnzuChbYh?=
 =?us-ascii?Q?mpdTTJfXc/AFuiwxk/Mz8LKAzlvCykSJWn8zFS+rA2S+r+FA7u6Y8NuAA56X?=
 =?us-ascii?Q?ZCtVox/GAYGFmrLeaueNHPZ5EIkA6q1F3BtMcS3SL8jF053Tb+yCvwyPl+bl?=
 =?us-ascii?Q?w+UCBVWXxiIohuajb3Z03adkkAGr+8IS1QZXpoiNhr3TUMASRnuN8YwK3XSe?=
 =?us-ascii?Q?+W6PPx8Nfp7f7o8DtaQWwqdOxg+1QZ1HvX1i3UkdAEspD9tPAfmrVqO7frK1?=
 =?us-ascii?Q?Bo+TSdsGFmxRl62DheBX5b/m9bdP14mS2zhN/vV2yM+luhWow5ee1XzMp0bq?=
 =?us-ascii?Q?3gkFiykzDnjW7aECzFGupdfUfyzitpUjHYpY6Vt6Y0rBhPlH5X+rxc5HwCZO?=
 =?us-ascii?Q?AhF0eWg1jGmNS9rxXTDvxXqOxt0HIm+n4hLXe3VcOBF4ZsTGMa4s8HWo2C3c?=
 =?us-ascii?Q?pe3QQA4rfG5Sm4wGTCyAUIJ/4I7b3Dq0mh7R2+QUYJP/weaEdeqllfGK831e?=
 =?us-ascii?Q?JcjCwU0AWHZm78JiCwJaZnS/jSnWWPEmzkOynEUWZGx0Q3DUPlAvDlZlDtbg?=
 =?us-ascii?Q?CYL8aNFDkCDnMT+HGuBPamHvbw+zWb2wUbKQnFH+gVSmdrYT0bMjnxV2Lgj8?=
 =?us-ascii?Q?3n3toKLwSqU1LFyIdtqzO0V0kXJo3o7j/bjDj7q0KGHjWBdIFOFPyMYBQcO5?=
 =?us-ascii?Q?/Tftx5Y01C6kX25MoAsigfsuE1ku3QcTOCMhlHVakSxsY0VZ69mITvtb4gFG?=
 =?us-ascii?Q?zc0fl2XCWDxZXB06FIkVeYyVJ+yeP6ILP508LpmJUhGCTJxJtsxcqj6pWoU/?=
 =?us-ascii?Q?JNlwPYk2Rjo+ATB6eaL4+grVWp5bb5CXeRkv5AdXf3VDoGXq+NNYzwq80eMg?=
 =?us-ascii?Q?8B5RuIakZCComLFxaUtF3cqlyII6q4w2mviaewv0d9TiyrODGcOLKPT8pj5F?=
 =?us-ascii?Q?bq36SWzVkVoZSmrzL4LFhtNzqD5QjdSQ8IO2jFQSvozN8gSiEXQzmx5LukiG?=
 =?us-ascii?Q?5i8YdMTl2Mwy/HuihMhaStw1S+L3OLP1bGQ0W/fTiTMpScNiQUjcE/McseRk?=
 =?us-ascii?Q?BHo/WPJo4sKIhf97lQ63EwNJUtIM+tYTIKimSjj++NN7+GWMcDfrVGqPoTgI?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nN1tlzqJak5X+BRmB650nH3sHQpQZSubw7wZh3iPTBnk2OWZeEbu8QS3f7Mg?=
 =?us-ascii?Q?Iqoc5BrVaCFpElpUnlBbnbWtwu6ZvDuvc+8jzOHnkKsJnPuGnkCl48NxVw5Q?=
 =?us-ascii?Q?lDRYPoBbcO1EzjEcI0SVf2uuiA4J55WWqApOSBkglU0TjwIanPZm5sQurlYG?=
 =?us-ascii?Q?/E2WKN1ZtF2TpDg+AZfxv3WIhJO1S/+QAD3G3CuBrXDYyd+vfhuIR/YHKabg?=
 =?us-ascii?Q?BYhjCHDa7rJtKgxxWruvhCfh7xbTy8gdVEeoonMAc3j/ID/W+DXsKqvVwD7y?=
 =?us-ascii?Q?w8Oza/F6MOp2pQtqhVCOucCYyba5adJ2AXMOUNJujV+yO1DsRM24LXSiauY+?=
 =?us-ascii?Q?zcG1n8inQg/aLlwpA5RMs9YS2TQFQrfru5B3rQ+9ucvP78B8JE6Cp++8bKDQ?=
 =?us-ascii?Q?1tsRW1ZQeEPF1jlhrFX13Jw1pkv03fAIdYabXKrEt/FPMbLbr8tGh052dP8B?=
 =?us-ascii?Q?00CV1m2ncHK9NrTTWXTYXq3VQlH0rgs6JrbdJHCKwHOcuj74395El7OYpv5M?=
 =?us-ascii?Q?uXWj6BL44HIs3t9DpQGVV3mvEA2w2LQxzZ18GNctMUMAg3g96fED5NE7DA1j?=
 =?us-ascii?Q?thzAIvOOG/vaVdaQAm8J7He9Gq7wCHGg0rIuZTAFQQdtwJ4JHLZczITODVrK?=
 =?us-ascii?Q?hMQgkF0bW+bAXliYxdtCwYeQvCPhdniHbybCfhONePnfENYe8ZjkZaMTkDHT?=
 =?us-ascii?Q?UkG+5xjy6S9W02HQl/DyN+2LzVmJLZmKO/tc5VewwFQck28Uj7g9mJHy6e4F?=
 =?us-ascii?Q?knxd8O7/sEXU8N/ng8HkpXqW5Pqk33goCI6/i9/UyB8sUnyNmSScH8IaoSsL?=
 =?us-ascii?Q?vLgBZ4h4L2opluowesA8E5k1u7+Zpd3urk4/t+5x2Ktz3vlHF2S8bgoyKOa6?=
 =?us-ascii?Q?V20eRzxdjMa4kq3lT6wDpopXGsjYYkaovR7UpLNrtgGGNDoGDxDwDxRSTK4y?=
 =?us-ascii?Q?FqiDWpuGfNzB9xXHJ3RrMylrEJI3Jm/r8YYQZbqZIel0omv3KvsbSfASVWt+?=
 =?us-ascii?Q?LzuIyWlzPDyFWajKCvlVUgqbonzFjqCJjoYMp/Mlcey302GjLfXlNYORj0mF?=
 =?us-ascii?Q?QiQr6kug?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55083ccf-30c4-4c5c-062e-08db57342551
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:28.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi2TCtG4lno+0OIZRd6NF/KuBK6YT8Jmn5wkMWyU84VrM1+F3lKFZqrtmiFOJmvLnpdZJecUVwI6GAf/Es0wQVMUlFavfP85vK17IS/bbZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170199
X-Proofpoint-ORIG-GUID: vhSSBLgEJO_6bLnFTXOkIVmTp4ZyEzjy
X-Proofpoint-GUID: vhSSBLgEJO_6bLnFTXOkIVmTp4ZyEzjy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a modified version of Linus's patch which has vhost_task
use CLONE_THREAD and CLONE_SIGHAND and allow SIGKILL and SIGSTOP.

I renamed the ignore_signals to block_signals based on Linus's comment
where it aligns with what we are doing with the siginitsetinv
p->blocked use and no longer calling ignore_signals.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h |  2 +-
 kernel/fork.c              | 12 +++---------
 kernel/vhost_task.c        |  5 +++--
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..249a5ece9def 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
+	u32 block_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..9e04ab5c3946 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2338,14 +2338,10 @@ __latent_entropy struct task_struct *copy_process(
 		p->flags |= PF_KTHREAD;
 	if (args->user_worker)
 		p->flags |= PF_USER_WORKER;
-	if (args->io_thread) {
-		/*
-		 * Mark us an IO worker, and block any signal that isn't
-		 * fatal or STOP
-		 */
+	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;
+	if (args->block_signals)
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
-	}
 
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
@@ -2517,9 +2513,6 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
-
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
@@ -2861,6 +2854,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.fn_arg		= arg,
 		.io_thread	= 1,
 		.user_worker	= 1,
+		.block_signals	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index a661cfa32ba3..a11f036290cc 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -95,13 +95,14 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
+		.block_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
-- 
2.25.1

