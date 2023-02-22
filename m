Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E61969EC11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBVAs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBVAs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:48:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B61C590;
        Tue, 21 Feb 2023 16:48:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMi9w1003903;
        Wed, 22 Feb 2023 00:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3pBkF6ZUSuYShEdLT98/YYBm1oFtzXHvLO0XNhOoYqs=;
 b=aWMxtDqHfdceA7AMq1HAWG1YkyUMrHUcFpXuT+n7Dm6IN+Du6uuiT108lg6nIBJNL35O
 QSrMfVdoFk9RV2D2V8xUvuHG8IxfEND11CfNaarp9LEPlKHuGgiXUthW+o5dW4RZpLIX
 b5vRXL4CFkOAjMxcPqiq3bBgbhK306LRG1bqTlHpnktZH0h3eNeva81S8TqemulNsJCD
 r9VFNlTw6D5q+bzyl0eZe3JXGn4rrK/MnWm88Zp4oPNfoCDb6dKGMlz6Ft3sDssV4fSQ
 7tbzo6Y4qQGAKD/kYcA3mzBxJmCKJtEAk5hBptHQR+3yKRQIZ/ElH+BnsCmMEXZwwV0I xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja6pab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 00:48:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M0K9UR027273;
        Wed, 22 Feb 2023 00:48:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn465d6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 00:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvdFpLFSF3whzvc5O39NC9/Q0JIP0YKfJvMvn9LzUEabh5ptjZ3rOcA/EaTWbkOcZMGkeS0vpZIvM2SfWLaokmBbzVQ8RQjn9ubgYmv+CNAV02g47v1JDfDYaRmDmmzb4bnnpJ6QBXtr+Hrgdr3+R3QBNoXIopPQiNWf7r8SKf/2HYIm0Nb3NQHyxTUmbZCxGIzMQ6ORRns3arMXky3CpRDflry8R7/5okibRHsn/Sv5w97KfhaKSaH+Wdq1y3yoRGg9jmwR4PTmWU3X4WtWMpXlRkHQrohB078kV2PVccWjdoPIIgJSzKnu5b6HLjAu1RwJlikDV/z4M4DgmnPCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pBkF6ZUSuYShEdLT98/YYBm1oFtzXHvLO0XNhOoYqs=;
 b=CmyelfMT7GVMC39GW8yBC/LYrB1NeSQ7KrSaAmBlR2FGHuIm0MZdvHfupPDo3CDYOdQUBmL9yZRu6hZWJN0x9SlNjG49rHj0UloJvdq/Zm90ukfAaaCMRMTdRW5iDCQtGii5Qe4kl7SXBYx/KXNbU/Sf71nA3S2poLNCLdtLtz4fUe8j/AX/Y4n6Su8crJOvboravqABCyKc49tSL9pwwFKLZ6/xQygRolpOtYT+I9N0h//U36uK6BFeUFHURXUYI59EcNblSnm4ebo9JRJ85MVJ5ImZLgyOeri645S9rKjnQfFuN9xZiAaqVw5h/8b/0tLs+kQy9dEEHKKirjlKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pBkF6ZUSuYShEdLT98/YYBm1oFtzXHvLO0XNhOoYqs=;
 b=kSOJDOS04i23WmNhTPl9ETrouohWe44QkcBiNKayDm5XfRJch/QqlbasFMTU+ehSykgEj14iVXLxZjQUy7ruk2yUY2No5OnGZRFFkLyeyHkLKC+OUeSAEOcgS8X9lHPS4ySc7u/SHKNslc2txnjFpR50Cw+eeozhGObPvI0m3lc=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 00:48:04 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::768a:9658:9df:701]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::768a:9658:9df:701%5]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 00:48:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: mpi3mr: Replace 1-element array with flex-array
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bklmr0fg.fsf@ca-mkp.ca.oracle.com>
References: <20230204183715.never.937-kees@kernel.org>
Date:   Tue, 21 Feb 2023 19:47:23 -0500
In-Reply-To: <20230204183715.never.937-kees@kernel.org> (Kees Cook's message
        of "Sat, 4 Feb 2023 10:37:16 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 655b7e66-206d-406f-07aa-08db146e5ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnMP/tqgQtrGeKnUH2Df4wUh/dcm1fiteNAsYwUyDxGPDU4pvVDJQbJ3UwFQWejogo8W1GtkGRu9w1YvYLy8bGBI286WrVolU0yNeANeC8s1KGWX0FF0bbvWu3pyP7Ls7fhsNAe/J3r0BxCvll6apA8uma3U6RmQx7mFLwXUXZ6KeHQOaU+uyAZl9uxEPkPWiVF5ngK4n0AiQkkQ7LoC48kHjB1M/VHGNy3a4bH6ZYPOzWW5qLfyGoAfN6R8AoJI5qbpUblJysdcJ2M3771uAfXzsMSv3Kmb3ChOvPvwY83WTaEARJytd5kqJqsErBhe3hiYlM4iZRx74SnRzelLoF1dnCozI0ZIQNTxnUk3na+E/rlIOTo2ZspOuhsPdVniRgwcF2JUNamsRZG0vY9UF6cPbjW7kHK63wLdhDubWYXST/SCyV3077fxiwYDtKneUczBOpRIh0612vbRp4x22U2m2szpHJ8nk1aUGo9bWlh91yuilA8Kx1CROGWo6A28aXAPibDnsulYctKNqaKdmW9XlOX8g7UeEOo/XfZLXFaHBeQHG7yBgKYvkZbaUOCuXyuEz7MW4O/nx5Bo6SqZEQ+w6yedlckWwdxKnvUwwdCrHZ4W/i0NbdJZl92BA87DMlW0V379nxUetL2NomxT0QoiGy6Y5rQ6FLbdUX2+LmUicYr8nmNbeKMXZ4jX6ZIP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(83380400001)(66476007)(66556008)(26005)(66946007)(8676002)(478600001)(316002)(4326008)(6916009)(6506007)(6666004)(6512007)(186003)(38100700002)(86362001)(2906002)(41300700001)(4744005)(8936002)(5660300002)(54906003)(6486002)(36916002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxorbiMFUYnpQ90fP2InWw70kUTq5q2lUySgHuI4tdRg/PgBrYzhcVMi0zVh?=
 =?us-ascii?Q?s8PT8tmRYN4o9qAAhLD6kVgqsM2f+1E6IjgSkp6Yi6c42IJELT+K/UpZEoRY?=
 =?us-ascii?Q?c8KZ5P0qIDsTeJgVhJBjWANq18mBsGiSwiA45SeMJrVGn08/mYfmhgYigkHo?=
 =?us-ascii?Q?eOo0Sgj1rJJGDidEL+6TFY++3EACGBNo5DWc0O2cmsgoTUfzehqWOOd5qnWQ?=
 =?us-ascii?Q?9tgRYn86qAB5xjdpNrjlKJNJNJAGpNET0lCajTEeDGg0H1Er1ZFRa66dfM3c?=
 =?us-ascii?Q?5I79O48bBW/ma+4pmDHRoX5LrNsYyM/bvxx/xhgX0EEjblK19wcx3qEQUrnR?=
 =?us-ascii?Q?QbE3pEV7wB0Q4D1R/4xJKEur31yDce8HqOR10s2hi9DgC//WvfZSkO4Hm2h5?=
 =?us-ascii?Q?ytvIOWbEFg339lAikMIf0S/LCf2w8BDolssEpYK05wSMyZpAN4GKekn72S64?=
 =?us-ascii?Q?gQkEM+EBXrE6Jm85niYcUPHzrvkaOryypQ3XT85O/5YGiSQHxXDUwVblPduP?=
 =?us-ascii?Q?OLKFsGYCrRDO7IJvuv7mafwFk5u5FQmyULieBFqpQXWgDJEEINYMJ5Ir3/3+?=
 =?us-ascii?Q?1mAFdAPeo/rftkxj3bSkQxXv4etMu/6i3lsr77Bba7iZfssa4XkMtwhcPKjC?=
 =?us-ascii?Q?SpZNG9e5SciW3jKptRR4hB+I18UkihR44NTEO7O9lck9Ti8rWL6BVjWlc/ve?=
 =?us-ascii?Q?POE69W4r0BfiK60d/Pxk+C2iO5rCiKApWv7jCt+Fvhp65f58ui/Btc0quKGf?=
 =?us-ascii?Q?5EousNuRdbJqq7u0fATXcasHrotcSrFxnYjEqirkuvC2CxwbNFxcRZ3vf8oQ?=
 =?us-ascii?Q?8ptm5nj+9JVnXHs2MP5dc4VWI4S0q8lZBsHF65Xr2ffHQVqoF92DiBriKI3l?=
 =?us-ascii?Q?1piXAHXMTgo22KXe8ena4MILeZftsPUM6MliDh5kCgwq9OaHJOkF7vYBA1h9?=
 =?us-ascii?Q?2/gn+eYnwgq3PGZXetDMUsnjsFGfFAgj7Usaim+ywlIf7kLrcJx5vtJaOWQl?=
 =?us-ascii?Q?FwfTvr2hZI7iWULc7S8wDUc/Bz1Xs9dAAquHZqqIoFEyTXW1eUn1UkgaBUdG?=
 =?us-ascii?Q?qxZ49EhiJ3vt/NXymi+PCb3viVALEo1DRhd0nv01H3dvIfJCRjUC7Erixol9?=
 =?us-ascii?Q?SosZpmyY2Br7q8UHeOQvtIUTaPN+HJSEV0L4v/Ylq286cPUXAV1WJN+xrw8m?=
 =?us-ascii?Q?sbOvu0JudQzNzYujyocy2rgnNG2H8v7kV3nptDrH3riF6t1FeGppXyPcMb3m?=
 =?us-ascii?Q?k9qiID5UqJkS32PVR7yWpV2+WIU+pskxFXrMV4LkCjc4VX+Hk9lNar7vmgqT?=
 =?us-ascii?Q?WAy3RgPIK1IfXRruFHW7Z3ZsiFAJitYxU2IKCqVcT8iwk/Hc4/LbMFklNzQT?=
 =?us-ascii?Q?C/fipm4ntKqCMrnA4ZPS5zNrFK46x9ZNr80HZ6Z2IneDgymd4z1FOlWoFnvD?=
 =?us-ascii?Q?2TDXgYFUEC5ZgJ3XWfG3vgQBHtEjrIkh3HComjOLma8APy3tO3myMskr34FI?=
 =?us-ascii?Q?/t5aTPjmu4hUGfIcW8T+zWf0AZUGsjU0ZGlXmOK9NlCJCpFqNYtn8OId9TFN?=
 =?us-ascii?Q?SolPIqSaU/c9tV6yignva3azZPruR2pUSEqqIq6EW13EJFFxlQUpvV4XMLaG?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YYqD/CsGHWKxvVysJMGhCsaOMURWXVe8eSFz/Uc6rvvSZ5LrD5bvd4fJFoBU+Md2R1TlZnrGtBo1oaWDYMoxP2hfV/mkyR1GdYtCGZeLw6tDiacJ8dbbxHcZPwSRXdsyhPfHKOSvNHCRIFVxYZkOr6phdY1+7t81yPUxYk91UqUu8oWG9cduCgQtw0ou6OieTui8NurcXadA9t2OQmwQEO5UW3o3ikOUvQKfSZbTDNglBLkYJqyYOcB9lG0mWxfuos1EmLlQj4MFx7Hnp/ZSOGC+AJvHH0gWdmHapU2rxeSxuaNkNAvoW+s02hPKVfFAN3p9Io/xtr/VGu92T5oaVz43s4UFYWqOnmCHgGm55TVw5goOxGs8gtqrgtar2ZZ6cP/K+FBmN0KDTwmWdS9JbhBIjKSUWtFT3lI9X//Zi1ZrB0HskBYkDa1Hmp2fXfxy56Lz/EdjoKRPiMYMPNUNG+TMk82FNajEdBTVlQwd9hmxYYYSOMOjbVEuKv2v3ms4kcZtu9yOFAbjnH8WkqY2kBdi7LcVJhnL8cLp7gcdH3AGKnheRvJLGN9lfnO6LHvTyUNNStSeySwLRIh/nBzZdpdUNNbZBsXzc2nQWgK+xniAO1o+IZl5KwU5MoDtfl4cCOxVF6I7jN0xMxnRReuGTdRhkiCMAW3FO0HdH2aonmf18Tj8NT7A/XjctL5J1LLi8kwToTGgXLg7QypfTqzyNRqxz2RY9rasUnG5XRebx4p897mC1jKoaCRPR3uwBPv4+O5Oj0VAHaYykstNemZlN9e4d/Jc7Wsa7mM1NIXIvNwJfNjDzNsPh0HA5dPZcIFH/pkYPkm5I0PbCLOYBqZQHvZ2uIaoOXgPZauiTR8dsDynhIx58PY5pp7VexQ56o3emGexCFi8LSWLEpboVpXZ3Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655b7e66-206d-406f-07aa-08db146e5ddd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 00:48:04.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9RBC+BnKc/kTObYAyYJMydN7w64XlA88EaUD8oOTlVlKjwC7CPCOoCHG/Cy7UzdiLCmPAcx4COyh99a3QpmSHvppRlblURMwqvSHAFMwKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_14,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=613 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220004
X-Proofpoint-ORIG-GUID: Vy2n-xa4O6p4FiwWTozeDfS6VxBpyUJv
X-Proofpoint-GUID: Vy2n-xa4O6p4FiwWTozeDfS6VxBpyUJv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> Nothing else defined MPI3_NVME_ENCAP_CMD_MAX, so the "command" buffer
> was being defined as a fake flexible array of size 1. Replace this
> with a proper flex array. Avoids this GCC 13 warning under
> -fstrict-flex-arrays=3:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
