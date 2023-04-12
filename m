Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCB6DE8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDLBOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLBOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:14:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4A3594;
        Tue, 11 Apr 2023 18:14:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLIv5O018002;
        Wed, 12 Apr 2023 01:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=GLiej1A3XbL8mztJz5JY6+bUocqdktEYKTHUCj1fFSA=;
 b=cdFsE5Jde9NJ8OBRNreMJLwe1ET6spx4Yv54DvERYVOjVUVBiCk639ahr5HIarOTcSFn
 8VwFvvlOfY9Nz0NQZET0vVvYil3ad5K2P4pfIle5P7LfArNvnKUkUYF1VFFRe4gzQ1K0
 v2E9Uy45ewm2y0ZZa7rnzsAY4iarTrp2JcRYMCdMfPb0eBAFWCgGVa5wofVdFyx0HC16
 BH15L5e3mfOLiH0kAqvT9U0c6qNG4YwodKSp+kW8fdfU4JS0B/6BgZ5rBgsVvJ8L17HH
 VxwIxpsUadpZri+neVrQW8IwC1d7EULk3gduBz43igKUZrIlCCmpXycOsf6XsDk2SXqV zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etptqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:13:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNfUZX012173;
        Wed, 12 Apr 2023 01:13:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdptnh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D95g4GVvyfFFY+Ty7I8622v2V/Ecf1fb77hO2Rm+fFEEj3WP9qqxfKNqqm7/DW18/TT4rLLyBHNXsg5TxD6AE9+QpGyBc3Q7UlZic60dd0rqgX9gkoQYfm6XfL1ubW9IK7YoxYw4RfnZDVrZLbzSiobl6iYqVLYYGdGeokxPkXX2TVcUjW6myPOJXndmAXkKBf2oLfJiZYoxfVsgd0LwfiEHF5ICgNAKL8VduJBjSlhDL/yX1BKYkNKvfMP+5PIHWZu8pARvQpDj7v6zmc4FMmTLnEH6Q95jTMzfOQcaLZEVgcPUuDyqYUdymtvRIrCkplT0jqSgzpgswtqlPM8fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLiej1A3XbL8mztJz5JY6+bUocqdktEYKTHUCj1fFSA=;
 b=AWbVcj7QJkEpLwmKbhKwimdmoEsC9JeaRpxKPtZbxv/dwgA2q8SK2e8cZEvWBxiBf+BBDgBkX4QeJIgpz0j3J/l1p36C4R3YPeg1SH3NhrJyM0qIBjEoC89YyKlp4aR/Mq1efn7zhROH79j5luvkDgMPqlOsB+hcsUnioDfAPWY4NAsVkTCNNXVeISJLccrtgGh3NP9qYxDkmZ08tRYOZAqm4S+PZgqU5ViYlaLRt24+/egh7OaKX9s4RpzAR1U1pTFFgOW/XlkrK98oNdoKy2vh7RdJY2DiCrrPYB/sf8s5JW0rFlBvaAekEbZ499shLNrSF8Nwwv9tMWWarA+7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLiej1A3XbL8mztJz5JY6+bUocqdktEYKTHUCj1fFSA=;
 b=cpq+5Vrl4BRyWacm4zrzIV/wvBJv2vNM9xCVzrJoRBJ8F0e2GrLAyOCZCJgrBlGunGtVH/Ifz6zeO9+oszkFQB1UI7bfgSMMpRfEAnXbRkqVNRUFfh4FpnOXrPwbRPXyyg8mxP27jFowywbjXYKPK6IDYRqx24en1Dq7qZbSxzY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6655.namprd10.prod.outlook.com (2603:10b6:303:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 01:13:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:13:39 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yihang Li <liyihang9@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: work around build failure in suspend
 function
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs95oqbt.fsf@ca-mkp.ca.oracle.com>
References: <20230405083611.3376739-1-arnd@kernel.org>
Date:   Tue, 11 Apr 2023 21:13:36 -0400
In-Reply-To: <20230405083611.3376739-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Wed, 5 Apr 2023 10:36:04 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:806:127::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d908af6-14a6-472d-70dd-08db3af32601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7j4hKy7hHj5VsDXDZVSeYy9TAoKRL7cer3wVfYwdwkgRFRO0XoaVMciRs0tlfAAywtVCy+1fle6D09HktnZ7aImNcT1+J6dqsfv+etgd+d+nuMOPmfArJzvSd7iyAxTLpnaBm6BAudH5BuRFz9/jBJ3rdwgJjZSbq8Ge38uW8FPbfFgZIx210q2PZjgK1KryeGosRm9b1dDhj88jv7qbEFA+mmjJUnSNZ6psrc4MTh8tvqXXjUFTjENjdEaEPZtpBuAM2y/wiBbFzbK/qXhoZ5WQIMMCrtwfhVuCQFA2cO309By5fI4w3xPSaVLdb2zGT0tHdepiSvE7FsAjr2dKt2Z2H0/6P+E8xyPgXEa3bx0tElQKD5rPNJvPYHAGRy0CODaNkVb58vmTYX9T6ctK28c5ymuvo7ybTOmdCDLQrnW0RP95d2jnONRp5OCANqfgRYctWCulqte+4SeDu2v5v71cQzi3xEhLup6nnQKrFGcH11SJvmuJsnHi55uAo3NRj4XsvkfpudAZJqwDn3p4lYxUSc74RHY/PoCzIk9dejU3qPg2FuYh3L14YHHJW8v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(86362001)(558084003)(6916009)(316002)(41300700001)(15650500001)(8936002)(66946007)(66556008)(66476007)(83380400001)(8676002)(5660300002)(7416002)(6486002)(36916002)(6666004)(54906003)(26005)(186003)(478600001)(6506007)(6512007)(4326008)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeTXOlQXmLj0GcUpPg1hyycttRdONpgzfHEusNXgRO/htzRxQxjYkFU9PuVl?=
 =?us-ascii?Q?/Ux4sIktW67aZZHIaeUFvF6vjEzDXjoV35S2I8qKK+d3cSBbH07FWwfMkEpy?=
 =?us-ascii?Q?Z0Mjv+xuvlrUCpIK0aqOKML9kr0iKA0cTiVbVuAYAdnHJbz1WNnLHLzs6Yr1?=
 =?us-ascii?Q?1UVf9rA0cKN+xzDd9upkq7mIwJgmSOfSxUF084kI4iDg192MAwCLx+Ogrhrb?=
 =?us-ascii?Q?4xCeWmAVeO5TAvtopxUvv2yEWjMAUBwzNpf0uKoDoYys9NJJ5L+bBUmmPcIp?=
 =?us-ascii?Q?pBG/E2yWL8X0QR4qpyuyUEW0yKhKwc4+p1mL+5R/Zie+v6FsRQbW9xmQcq14?=
 =?us-ascii?Q?5m6H3EvpKaL1gV1QPcB8oMdf0J+dRHGHAOt5+DOi/AcpMBmWoIVyyI1nBkLK?=
 =?us-ascii?Q?/QOM2iva2uhBpXlBvy25sAtr5CcNbEJhNadh+31GUqlj96BPjJpbIhrbyLER?=
 =?us-ascii?Q?XrsbDYNoAkr1r/cRzu57q89efEUs8IFzkAJusEQ3fyxG9QZqC3S6fd1IW+YV?=
 =?us-ascii?Q?VJaRN9++rdFpffk0sQWAigDHddDYWnXzVpOK9Jpz81OyLwQo0eEpmzyWGpdj?=
 =?us-ascii?Q?5dhMHKXSie+YgFWHo6yhAYmslN2jDqbB9OmYix+mOW0LRFku+eRf1oG/c06V?=
 =?us-ascii?Q?q6iSEhOZ6oU6C0biehjxhzPil+gTxPG0fGgHSOK6KT6TNCCG27cIXY7nEnbr?=
 =?us-ascii?Q?r7MA6XG9A/oWJsvii2/+oaf9SZX65h6CNjb7gfRLZi0CGQa7xPK7Lt9CF0ep?=
 =?us-ascii?Q?qKtABbHM6mRWT9C8sznFbqoTBNA93Bx2xi+hzB4W5Dr/O3k15lkN3KS8feBm?=
 =?us-ascii?Q?b0Gsne6770+3CQR8cigi2gv2sy2Yv6NEFTaV6nuSM49tMdH/D6qqzZyywrSA?=
 =?us-ascii?Q?C5Kg7ab7GCuFf7W9kLcDEErFZrSaHchweWaI84LJzgndNNDEh4e03uropxNP?=
 =?us-ascii?Q?cIXkFPzG2vq+J/cXq6+i9vam9HiP5GIluLldfyjZAT9EWVNf5v98lt+U3PfK?=
 =?us-ascii?Q?cTn3zoraB+B+4RP+9bmtXPpS61ZeqHrfQsx0+Q4ikCZvCwr2HUb6rJNLJpv4?=
 =?us-ascii?Q?6L+kcJAbiqA0/fN9TdKhwEnmq+OL8NEWaoFZNO1IT5h4ImCYDR7TXlCgCUuc?=
 =?us-ascii?Q?XNyqRGTqNPRO6YsuNR7Nu1SLymWe+BlloforiKLGZZ/RizchoSpHUz1Af98p?=
 =?us-ascii?Q?LCtUJigsrpqUcZ6rUzKYYRs5OGKKklZeAaDNQA2wIIyuAKZHJrgt7l0W9YNK?=
 =?us-ascii?Q?8rLIHKrdTAB1drclozR6PaXVu46ApxjVBUeTLMkreXUVonguDYmzsmcPs8Vb?=
 =?us-ascii?Q?5O5aA3kbCCjHaCAXqYigFtJ7+gJ76dMiGGFje3nuMf/j8Q9AC5p+l/AWaTHa?=
 =?us-ascii?Q?KULLBHu08TW5pADuY8evc0vbEaEMZhZpoQRd/TicVNuHjmY7MWt/kSjfpeNa?=
 =?us-ascii?Q?i07HeES8/urXknhNmlDGsjmvwG+0RPr93IpNYGw/VDZmu2JFPTEDUjJBBily?=
 =?us-ascii?Q?ITRCocP3eAMveGFxy83RAOlzIdPV3+M9Ze46bq/TKgi34YLexoIraRFCQp7n?=
 =?us-ascii?Q?MjMmHSgRmKoV5s/DAlEHZhLgGpcJAB0LfXWI8W+go2Zcyp37EIgLOnDFZwQ5?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YzZK3TOVtHIhuMgnefNmHh9T52e/qrAM85yIdtgC4nmcZfDx748xw/3Aamct?=
 =?us-ascii?Q?PnuD7fo6tkniPmoFtIga6H0Av41yE5iOr61xlul0PeNjvgKfGGrZ2Eze+UFl?=
 =?us-ascii?Q?zoU5cQSE6udu7Df5xeqQ25cj1ZHL0PKvDESN6MJ3E/aF1eV2U2J1LfA/7Dge?=
 =?us-ascii?Q?//jHGxhX3jfpbOpI5eHImNcRfeEXck+Qrdljcba+rhpP2H5Vj41NBXsqzCGu?=
 =?us-ascii?Q?+OuOR6mZTACJ1+WZPtC9eWf/axnm+aREPx9GMF0WR1AH8nB8aWUwnCim/p3b?=
 =?us-ascii?Q?Wj5sOt/D7zwXdsdTitSthLjZKGktVuhoddIzHy9kzs1bZmEfyaH3ytns//b8?=
 =?us-ascii?Q?zmbWizdwxi122j/9h5nH/mmPqY8Lrg6ES+obhK18hD94RHhyXrFytWrTdJ8O?=
 =?us-ascii?Q?f5Swz6NyUNqayt30Xel9F3OGHNM2ngBzZs9FZgoq42BCxXAiund+paWRhSKf?=
 =?us-ascii?Q?MYIRs37+jEk2T+9x0SYe7dsLVIN9dnjMlw3YrA3D8ISg0/C8eS7ytgr5xECT?=
 =?us-ascii?Q?lKDMd6pxOC2cJKvw3P7Ls29sjHyxEgOc4OhftNdQVPhOmmiMoeY2Ofd0+U7i?=
 =?us-ascii?Q?hItcelDLFR0TWQx7sGRkp7ZiS2cD6XPH8IlSyswAc+GTgkmATfUXi3Xqieql?=
 =?us-ascii?Q?YfsY73wXRsmNzGLNSjQnblZ2PK/SQeEHkrLsMeW7dccs7VPzK/tmU/7kglL1?=
 =?us-ascii?Q?FWLrAOopS9hnWI1ErAG8wtT610VNjNj/xewB74tYBNrdfhmKDPRywIG10oQ/?=
 =?us-ascii?Q?mFVDELEk3fs8SafDWjsggHYV3nJh35GNB6qRGKqeMrsvwWaIkSj91BgtUBbT?=
 =?us-ascii?Q?KEHA5Z1YFJVp3M/WbrlKVNf2kGLsPIXLPxzgb5njOeNSwebdVm2R1YvDhUg0?=
 =?us-ascii?Q?eagb/3fgPwCUzj5xMtzS7mo5r2QkPI7+8J4fKKzcETgaBPKVqU+CTyyFFAh/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d908af6-14a6-472d-70dd-08db3af32601
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:13:39.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxuE30Cz8GNUDehNpYAWlf2+eL5pcqaWO0W2fXBztq1Jy3qZsY8yHfT5f7rzlmd0k1V9CDZ/9n6uOZaOw9x1GGSJvaDHhKSr+bpzjYxI/gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=560 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120009
X-Proofpoint-GUID: eor1pvsxJUf6si6ncr6RIZ4-Squ208vS
X-Proofpoint-ORIG-GUID: eor1pvsxJUf6si6ncr6RIZ4-Squ208vS
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

> The suspend/resume functions in this driver seem to have multiple
> problems, the latest one just got introduced by a bugfix:

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
