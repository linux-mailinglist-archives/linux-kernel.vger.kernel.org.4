Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C132718DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjEaV7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEaV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:59:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A28A121;
        Wed, 31 May 2023 14:59:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKT43R016257;
        Wed, 31 May 2023 21:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=fgEsX/q0QgkPpeT8YOXi07LQr+hVPXGgRv0Rows4c3u/NjgFlHYbtP7w+QLCs+yvdOD4
 pCjKTbxxbYAYBYxY5vjTss9RYI+zJ/Iq5B7OPEjTvISRrBm7t1exGFgu1vBvG/VdSuPu
 jQgucm9UZudt6aahKNxKHTf0CFE80wr75sdUUix7JsVq7WHRSA+PsF0iq6QmZ95uN1/o
 lwB35fzuEmPmEvpz1UkoYoBX20xE3A/A+gxANV7M9JWkBtT+FE2kjTYq8WRbbDb9XtZO
 OTLmJoLwmZM8Jln3SYjK3UgUEXYdLvYLvVlqPJWyZb1GQVYKpv39+KNpUMApQo4QglvA sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmeq57m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 21:59:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK73Dn019797;
        Wed, 31 May 2023 21:59:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6h6cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 21:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G48e3BBXqUOhPe7eOzZ8W6D8RgsiBwen7REt36yNHjrC0ql7NUoysgh/CkjBlo+Zfr4cxM4z+n27K9caM1C99m0qWwPGWAHRWM5rKKHee/XQnyTUyhtYl6++bSBR4X3syW+xxKBmId38k0+jnykNi2ImM60YEypZCtGF81ysIL7J47WaQI7JKlcdgDkjdQyzIrDBYPibpp/8KS9JgQrbiM0/2vwd9eWc6kkR4cSzPgtKbpnXX7+kqzx7UAKyDYirCECQ4eFdMMNrz4lnOnefX0nE4wEWbVflC28kdPCudaKcb9wG5Nfn+EOdTqotmUUwuKmwp4qY5TIkxHqAixrhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=aCr7437bFOpLyO8BSNXkSSZNV7KiS1O8zAHTONBowuVATZkYx6K2TnwlTSmPiRDKaqQDg2/hXyfmczE3f952KHJ0YKh59m2E7exfl2gY838HXY+SQTwHqodW6loC4SNllT6H+0Z6GxK/+ZQjavZ6jvTMqWD7fEO2agiqwKE5tjSllYo2sHJWW/5Pnnt/mMQayBgvNGg8ArQlCSoMnk0hJ/1yM5vfoMyxtRkdwtvyWIHQ7cwjV+JVTtYiAl8OjMKHI6+we6fb7iI433bdzfoL8rM+2aKkCLVuACA2D63s+PLWYS8I1FCKSd3dZeLBZhnciCZq8pz8o265RjO2MpSVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=HUpH1mMQfd4oJrp3DJ57D6PfUyezPOtDaAt42DR/X+1xwh4AcYTpXHs4VlIqMhoS6sr6ifAg8K8O53KRe8Vl5H2Rp2i/pqzurIwmg4hk6xSvSR+sIQzpdeA3/9Wo+DfWCNJLD1gyskcBsWPUdiTOiANQIZiQIgxNHHBN0fWXIKw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 21:59:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 21:59:32 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: lpfc: Replace all non-returning strlcpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y88dux4.fsf@ca-mkp.ca.oracle.com>
References: <20230530155745.343032-1-azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 17:59:29 -0400
In-Reply-To: <20230530155745.343032-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 30 May 2023 15:57:45 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba6ec30-16c3-45de-cdd8-08db62225089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LtPop3qZFPZC/BJ/SJKOsKkPWpHh1JZQZasoZtfDTdD3mryN0GfcINhQHjFS8hu1GysSb0mB6GQpsHVxLbQZPvjsYFHHDmKhp3uY7hO4e/M3NFdAWK4SH3inoS0SUXxqTSAPuKSIgFUkPBfLX4BoOrc4rdBE35EHrWrgjoYn26f/rWXQRtDHm194TTOFNhKUbsVvxNhpdL/ZipvGmgYuuTzSmnF+J8YDYdNv5ywsIyFZAFNB/ZVziOI59N98YusXNhO5QARY/cTQkCKuUhMzJtGr2IQWLdePv9nyGq0D+JqN+FZVGA38QNbkFPaMU7NFHXRGzo/U5IYbV8KWipwsrS6RNthJEPlfZMmXvpnFpoJPH4hatcq7qm7FjlsT0uxtwKudBtjAs40AZx3abQw91tFTs4NuLd9GCrKcGXtUJqOL9eSdsZkDFp84N3+PnYKCdLyCkGEi2kA9OY/2rR3iPaIEFvrRRZ+NEZNg0C3ID0p8yXqztg0Ni/O1eoNL0kQZfSSafNWZzZTcVVfGFmUtmXdv2Gp9XeBE3thHim+GwR9/za/CSjmTYAF1kBnVjZWqmubI1g2VKvcuBGZ2BrbQYTCz8NFRVnU8M31wSabM5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(83380400001)(38100700002)(86362001)(6666004)(36916002)(6486002)(478600001)(5660300002)(4744005)(316002)(4326008)(2906002)(6916009)(8936002)(41300700001)(54906003)(66476007)(66556008)(8676002)(66946007)(186003)(26005)(107886003)(6506007)(6512007)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSfMAXa5NH4WiEczcHIGANDL+X7I+z9HIwq8UUqphDYBtCp5f3vL2A/WX4q+?=
 =?us-ascii?Q?CEtyntT7Wjvm1CsMEANjzcpM7f2uUvym3snsWRf3P8MdVapeMsFtB8OalaNM?=
 =?us-ascii?Q?iTVdS+FY5xVwDz7Iv/MYLhOJExKkHFWv2iwU8r2etC/RVjZj5Kf/otwy18K7?=
 =?us-ascii?Q?uduCI1w6/WASAxnKHQMia0mmXaWr6cw6lLA9sOCPRYP2+pP90zJn4RKdB0CR?=
 =?us-ascii?Q?z07PWAFn2HfT8XgKhubbm0zJb7TQDIXauH2Wqv0dz1UHw4UqYhM+StIRJepy?=
 =?us-ascii?Q?pa87XwzVs5Z1Oc0F/xexo6II7447aasYZawy7dTtV+RSFqY0KHO9DRB8teIE?=
 =?us-ascii?Q?Baz+XkSgpKSVbGYJX4CtFXCr4ajzHiQabH4/FUO0C/5sry0ZWTCVY2c4Dfaq?=
 =?us-ascii?Q?bgIM9QX7oPq2/1PjQ/8iejO1O8vIJUHNY3wQXP1pY3bzu0fs/qjuTED/ST0b?=
 =?us-ascii?Q?p3E+JUxGZCLln56ea4Lba6vhKUk+6PWy+Lh63Em+VE8JOeC7F1D1bmQufJ3p?=
 =?us-ascii?Q?nxazI8ooDDqwi1IVhanitBq8ZuGtuRXNcDEwI7SQ4JGzRiqxOy9ds0Y5tMUm?=
 =?us-ascii?Q?QgP4Kf5lSSQK9gET0KlyOLfbT9s00rPaeQMhTPOLgINKvG5Wr649U/ZOzm2g?=
 =?us-ascii?Q?HzYbI0sgULpQkvHqpFtW+sMjDtCUDRGRjcL0HzQ2/PaqjD6D8/LSMmjuiVz3?=
 =?us-ascii?Q?X21RmsQDO3StYga5WOkIBDw/X1Z3J0TOFUBPCgDsuKsNpKprL1vkRBA+vKZ+?=
 =?us-ascii?Q?gT/H/PMoeF6D4N4QzE4EIG6zuRIZBajMSwrWYfOoDBgmvs676ryqoz/h7VBJ?=
 =?us-ascii?Q?X0Ft+t+b5+ujc+aChz3usUsQ1s+/SVK+RNVUM7NhorTCDac103Nie4qo5rh7?=
 =?us-ascii?Q?ocW5+xR74n40JzkwxC85zPBeEvrWwe5sapuI8wbzzH1GiU7nf94whNHrzKBN?=
 =?us-ascii?Q?unaEQTdtDUqTEpu7RcG+KvwR7tfWgOCFdtNizGqIcdX3QjSXm7U782bc1f1s?=
 =?us-ascii?Q?Y0DJ02retTHfmxfLYR7Q3SyKLf/BLv4skV/iWTGtBoxqVx+28sBxdP5pIaNO?=
 =?us-ascii?Q?YyS63pJDt5f/KNuVgDcnjMOIVPvJLTVM/Q2J4Sk8up75ckhStWbybDC8CAcW?=
 =?us-ascii?Q?OUbG313WBtjlNwMD7mqxXCaWo4qxfMvHbn2dIvUbK1xRBIPbi7kEk319Zdbe?=
 =?us-ascii?Q?O0j6bq74jGeUeQhiKVscSH+QBB3Ps4HfGG1aEoluQBMIn8z1t6r4psp50rwi?=
 =?us-ascii?Q?eig74JW4tTZvsSUJ2WkOgFcmXmImMZCECVqxPo6MbXHD6QsKCE7yoBiqfSHB?=
 =?us-ascii?Q?/BP4okMJBkEl/D6/oiekKZAZPUftmHyb/kqlIpuXiDJ49vAJwPaOOZsz8XeC?=
 =?us-ascii?Q?nf8qKGrCMrfi0B6dGwMYvTcATidok1qVuFVQdCKPvm2zesMJErTd6uQ4JtG7?=
 =?us-ascii?Q?Db9+aeAT304QoLSMkDIYDizBZe7EjoRinK8F0ufNczYYQ+rcvHT9WXDGONNA?=
 =?us-ascii?Q?WkJta/mRe57bwgi5QZ5KVcpfiWaF47D+rtW6k3kZfQS/4jbVz9guQlaiExCG?=
 =?us-ascii?Q?o9fPsefxjzIZrf57MYv09RxxRtHrLd/76PKzT3mG+pfw0sLr+Ez38/sRPVCj?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8V9GGB8a4eHr3ZS9Es5CGox+6TmY8VyToqAAtLl3jmBHHdzQ2uHfhM9LSoeYYrVZYx/oyWxjkIcHTQEXsYCXDWD7FehRHfPVbO+gAQQS3zk8ZJw864sQa229p7E5q2KXzrCTYgrn6dVYEJ83Gg9FppX++wIJniGXCEzvUC6VKAZz12wJ9UuRMhejLS+wymkRQY3jC21jKBM00dOZroFw7hepUGnq2YEyh0/43+3M0VOrNtoqKo3uz4+dyN6OVhoJZwxwspiYowTw6uVy5JTiE7gBHdM/NxPPwnb/A9uXj8uLtuTJuVWm0e1Dqrk5T8hDP82xna8MbNcSHNbUfeGRJvRp0ZkOENuOtsUosPrRXffq6I2r1MQKv9O9Os4FRzdhCyq0iGRJ32QRZDKGetNzdItDl96gYx4x/GHO/tDmu731H5txVobTGucEyP6kmUyVsy3jR2I2a7pKhSBD1W2dcxiKgnMun7VNb6hnagkYwZtufEUk38txhqLV70ws/qW7m6xu9XeYEpbtAndcQ0vP1pT60M6K7yl+ZDaX97BW72Uqvs5mrdcTgKMPCj9eFbmlU8wp3XN7B0IrGV3fwzqY9i69GnhGRJAncycIW49FwE2WV+1agsCx5lMLQmR3xFMjsHqmNQV03zLqrnvwUzYTlDZ9bOzJYCG+vzvr/UXmpVyfg9MNxLe6p9Ska59BzvLfLFk8xvERo6U6wr9itZ3MndADtZJCkMn2Lzfv3UWGcPmZqN1BwdbEdvFuUdGsx7HqpgtOTnJ7nT1L2aSESeBjbX4XEv0alatAb3gt5+tK3kOHn1pJOmZ+Q7EG+Zb1vPc4vUb087r9hnn+aiwwU/5jsNNeG1EqpCeNnTAveX2rn70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba6ec30-16c3-45de-cdd8-08db62225089
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 21:59:32.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES7+3xWoTEztH/fjxuxPaTlU+fb2uLFgdml4tIkaVzfxxKI8is7UGsYQxWfvm8XlyFtvuNr42vEwWws2+qVu4+2iF89OQUYbnEuvMgPMTBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=966
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310185
X-Proofpoint-ORIG-GUID: xvGh3TxDGXMJlFCrVtB6tGFHdVmf69yM
X-Proofpoint-GUID: xvGh3TxDGXMJlFCrVtB6tGFHdVmf69yM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
