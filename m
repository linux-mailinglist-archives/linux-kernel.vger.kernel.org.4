Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62611624D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiKJVrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKJVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:47:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E748765
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:47:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AALN6Tm016397;
        Thu, 10 Nov 2022 21:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nTgkSqOHkNS8LdBankkBfTstU8/thj7YkWCz2lJ/CA8=;
 b=Y1F9pAo1S+EtpsjRIl4MGte0YIBxqVh1wedXl9OYABG2sW64k2UiA0LaFR0FhfwBkC3a
 aiEvD2ao2XXrN3Yx/7+B/OQXwcf0aa2WuGuQaXbRbsPhIhQg56Wnq5daqAxvK4Mx3sNW
 93Hozb3B1vPK9YTqOL9hPZEPI5zT3tzvvr/dp1hXPqiBWnJ/+KfH5gZfUr4Qo05BySSb
 h2xJzpfrE7TcuhEMmHEKF330Al4WWLL5qHQnbvcuuU4I/7VDJncRjwbzBInNvbwazA2y
 rRTFmCfe/5fHP8Uh5lSDkJ/pBVO/iud8x9Qjm5a4DqYGm8chcIPViuxZIaolDQkcMIw4 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks95nr2ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 21:47:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAKjVgM023068;
        Thu, 10 Nov 2022 21:47:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcysg4qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 21:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJzvYNddhosBOOmddl3zwdRurU6aq8FWp0n//V8nKIDsNlEhEjKxqRLe6s3AdVOI4EOP8LQ+85sWdJp0zxVV4v7rmE7jSgYb1oil4vgsU6fsOhClP1KLCmeb0w/6m9JDff5qIpOZiCxsIMOVQgkFtMg5r+1jjDdyQ16MbWaPcXhMUmDY1Rn2FP0gvvb2FwX5QjOgnxUVk7zwqAaO7RYigRVhm7HNIGJMyl+U8AjQbRupA1fLO3mpqi68erzE2CtdCnz8P9j7uIULXtXnGQbUhNpTXGNHwexLIhYUrPq2dqYwX0uo+DAKQLOy9kUN6jn2pD8LnvS7FlIrcofeudOr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTgkSqOHkNS8LdBankkBfTstU8/thj7YkWCz2lJ/CA8=;
 b=WuL1PZWmVYy/PTprSsHJMo9zJHow/E+tfENQoxLQk7KopreqjZGPK7GPLQ/rf6esHDJOdlWp5xMugDMfPvHnW964t/HcF9XEYlMQi2oP3m/hip8dyuLzrsTXQwsDBFGnNenWjRwmaVJDXT/tP6y+t9xCxhIgR65+91ifnVm9mumL5XSLxUCgXHy3i/1zt5sX52b/QuXjO0qcRE06FDRwlKdYu5XVA2w75Xe1qWGP/WzE1zj59ao/IxivkAmt65LVfJkpq0CeghxmdzIfc6854kqj58mYuLVEHn42kgl0FM8vJxeAmuHpSpnYSq/N8weNcsmwMlPKhvwnzVQ0DYHqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTgkSqOHkNS8LdBankkBfTstU8/thj7YkWCz2lJ/CA8=;
 b=vZ3JjGS21xgKeaDcJ9KPUgi9h0E4PN7h/WdWZe2iDEdL82Eiji2XrLgyoPAAxVI2m0pgCqYCH1Iy+aL9ERY5yQYaz2lYRCZGIC3yF3gKKpdQnSi54FpAMoDj31G6z+kLgnAvEw21caQwF1NUFsgsAdkBbVSZj7uzHol1i1/a07g=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 21:47:12 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8%6]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 21:47:12 +0000
Message-ID: <85b67cd9-2d00-f2f2-1335-efab7240d65d@oracle.com>
Date:   Thu, 10 Nov 2022 15:47:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] jfs: makes diUnmount/diMount in jfs_mount_rw atomic
Content-Language: en-US
To:     Oleg Kanatov <okanatov@gmail.com>
Cc:     Oleg Kanatov <okanatov@astralinux.ru>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20221028122254.21081-1-okanatov@astralinux.ru>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221028122254.21081-1-okanatov@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:610:cd::19) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3874df-e348-458d-56a1-08dac3652013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2O+ybZs1NriwFBGQXjRDculx1oWxv/CHvYTazElfBzO+iP2yfEn3XSz4d7o9FQhgYi7O99+h45aZ02G24wtvURTgQCAG3iq6LRvLOEWnrlgFHn26BqzxpxG81de5KxNsQrSTD9FYPGarEH2Lhcc5UDedHAbKGd58gHEc8pmPap9dBQ0cn+vrJCalbLYMSPGX8VdqM5CGAtrlSuY2nARHoCG9UK+J2/gWP/a/oUr5gO7DpahWI1laz+tyyaYk68PiCDP2gWLPLCAJgw4SNv73B/pkSFFtbFMT2ufgDTscRBF4mRnEmwnzB9aJt0EcGMD19tNL5jpEGcwTXocE4jLu/ZmMEppfg9ab6MAwoUVX9iEVQ6kXkpIqAsC0/7TPFHx1hBx4g+O2YN5zWnCSSNsXo+U20u/kd/tdQauUAvWH3nrelC7uaXB71c6ft+/lYuzDbPgpr0hHnhz+04YLHqt13Eu/m4WTTA60OES6OxjJ7MUQY5R+Ov8zZxSIxt7VgI6Wv5sm8WUGOr2tcwGMoTOmWYBKXmsV8n2hn9EjEd4ewC9SnbfXZ2Vq2oWqp1V78MLFYaVkfGrmhlN6tb/iZyW3XAgtPYt9ryOVdOpkF35+K12mk209d9cp44HdkZ/wlWMGovzjaaFHuRBuB/JKRZWEWYbiTOzSvfvaq0H0n+znr7HfVTuAs38bhlGGQKW82nvxwhhJEYHZFHAiU1uPXZhWkT9TzuSjHSjqlm+Wt+Fi3KnY100KgFruqvGFIGVswwrEwL5lh5ExwFGJIU+z5fUFLmiJ3d1BTqWQpiCGcb0Jy64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(6916009)(31686004)(6486002)(316002)(36756003)(41300700001)(44832011)(6506007)(478600001)(4326008)(8676002)(66946007)(66476007)(8936002)(66556008)(26005)(6512007)(2906002)(5660300002)(31696002)(186003)(83380400001)(2616005)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkpzUTRYbWNpL3ZEVHFmTmNvV2U5M0lVTVhldGh1ZFVDM2VMOEp1eC85Q1Fl?=
 =?utf-8?B?WXBJM09QZ2p5SXJ6NW5pWWN3a1hpQkZ5ZkUvelpwcGplRFNhYlNCL2F2RjJD?=
 =?utf-8?B?YUpIcXFrb2o4bEp2UXJ4OHdaakppV29uVlR5YmZ3b2U0MzVJM2hnSVNLTkJY?=
 =?utf-8?B?ZXdlb2NySGtOek9hYVBzRHVTZytOWm9lM28reXZ3YmlqVVN3S1E4elRucTJk?=
 =?utf-8?B?YUZWMlQvUkRzaVlNQlI1VDAvMy82UEZYM0FlUHlWaC9EYURYbUg0UGFLT0pp?=
 =?utf-8?B?WE1DNnZZbkE5Y2ppWHhNaEhPSmtpRmo5LzY0Q2F1ck5qK2JDc3V1ZmNhNHFQ?=
 =?utf-8?B?V2NLSEg5SEdtT0hBOW1naGNNS09ZeWNrQUhpQVo5ampnbFdKV3pJUG1oT3VZ?=
 =?utf-8?B?aEVoaW1DdXNQdE05Tm54TzBIM1RzRzhLMGlKeE9pcDlNd0o1MTVQVFhQVFRi?=
 =?utf-8?B?QnhaMHR4LzJ2RlFqeFAvc2FCR3hOTGVUV0xxV1ZTMlF2M3hFaVJZcm1kVU1u?=
 =?utf-8?B?VmtUd29xazNwcUxORTB5WFl6WEZjYy8rZ0czNEVYUGt0dzVlNUlzRFI5cUYx?=
 =?utf-8?B?ODczd3N5TUYvaCt1QlRScENSUXBkTTBUUWdlMEVNVml3eHVwQ1MwNXphWVR2?=
 =?utf-8?B?akViV3JkdmZjbkxpTmNWOFRqZmJKU2lFcE1uWTlyQjRHbVJpZm9FUGVkOGRa?=
 =?utf-8?B?WVAyQVBPVkl2bTVONmtaZ1FhMjk3MWpBam84N2xTcWJiWFVDbWh6Tm9Rendr?=
 =?utf-8?B?UnVwaFZiekszdkxhQ3V4Z0tQUmJyTnp3MzBRVUl1TjVwWk5ldjcxOEs1NXpH?=
 =?utf-8?B?c2FvK2kvUURxVzNONmFrV3NuS1RYN3NyNXdCVmx6RVplbTJUS2FuVDArZHN6?=
 =?utf-8?B?TnZldWp0bGJPLzlWSTFEVGN5T3N0elZXUkFHNnVvTjVyN0RKREdDb05RZzRG?=
 =?utf-8?B?cG1pVkZQVHlLLzVoK25USVhmdGRubEJvZEZvNmwvNHVURWdTUGV4dEpjZ1hs?=
 =?utf-8?B?Z0huVU4rSkxMV05GOEswZllXN0dlbHBHdjcrbGhxOEhVaTQzbmREVkZJc0RU?=
 =?utf-8?B?MjZNTmh6Y3NHWmIwdk1SSTl3WE12VE0wdTF4c1E3dENXb1dwKzFmYXpaRlpo?=
 =?utf-8?B?MVBLbGZxMGUwd2l3aWVNWEtwdm4yNXBqd2dPV042dncyRjZ6Vkl2Y1hyQTJl?=
 =?utf-8?B?TlJVK3UzRnplT3dpWEM1N3FjVnYxMEs2RlAyK24wcmxwakorcnFFSzhJbVJ2?=
 =?utf-8?B?MGFneTRLNDljWEtSdGRIdGtYQXRCNHhlMU5PQ3dvQkQ4bGNvSmR5RDVuWlNH?=
 =?utf-8?B?ek1kRjM1c05WZ3NacFhxRTNDRm85UWFKK3RvaUFZYmYzL2R2emhyWmU5ZlpM?=
 =?utf-8?B?bXF3NDZEV1RBN3VmRXNsdmV3MkNIdUdta2Z0L0JFUjg0bS80K2k0R3htMEI5?=
 =?utf-8?B?U0tmUlJPVzNla2xiNkE5dlBQdzVLQ0d3QmdMdXJtbGhUeUlKMk1OWGFCSHVl?=
 =?utf-8?B?QXFTUWpmY0d3czViMk9PUkNSVTd0RnpDOVRHTUR3aHpYNU02RlROYkh6QUtB?=
 =?utf-8?B?bXBMRkY1SW1iQWRlWHFDb20xLzJmd3JGd0RDZ0hwT3d5V2w0TUdHckFwTkU3?=
 =?utf-8?B?WTVLN3YzZ3NYUm1rSmQvakYrckhQTWJVL1MxNndybXBUak9SNTZEcVIzdTRv?=
 =?utf-8?B?dHdiTU9BY0QxWldrQ29lUFVoeDg2eFRZeHpNMGtRcVZBY1FjdGRIMkJYb0FN?=
 =?utf-8?B?ZDJWajBxRVBtOWhDbGRSdFp2cWtrcGFOVzZXMHlWNXlORmhwaEZiZFQvSlN1?=
 =?utf-8?B?bDJ5bVViSUlldWNQbkRGQlZGTzR6NkhuWlhGSlIxZG5Bc1BKMVNXaVdZdlVR?=
 =?utf-8?B?RXNmUzNxWHczV1k1MmU2NEVuTWEyMXFiRkpRY2FSa3VpTTc2dUxTVXlSbndN?=
 =?utf-8?B?VDZmMXJiUjkrTWRGYU5VSVlnakw3amVhN2lVdExOTGFNOVRIYzQ1ZE1hemVq?=
 =?utf-8?B?b25YODF2ZUlEY2hlN01oTXRicGZxUDd0RWVZaGR6em9XVnA4RnpJTnNDSlZV?=
 =?utf-8?B?V29NUzBjN0poSFlpR1dEUXEvVGdIWTJBK1V3RFpOdHlCUTFYbldBSXg1eVkv?=
 =?utf-8?B?L0pJbDF6TGFJL0V6MjZLR1RCcHltcHFaL0x2V21QZmxlS2J6ZnpUVEFxWmo0?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3874df-e348-458d-56a1-08dac3652013
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 21:47:12.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCJKDiCGa7h8ktWdPvl3SJN3nw8t/E6hPZdyxB02acMlN5jXzr9PeOgyjeQ2o8SHKcDvtnrmdiB8XgQNNeLHyORQHokxWITBto8575GG8/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100153
X-Proofpoint-GUID: eLDWsRW_o5_IRJCzCOVLCqNGjJPwAgIn
X-Proofpoint-ORIG-GUID: eLDWsRW_o5_IRJCzCOVLCqNGjJPwAgIn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with trivial changes. I cleaned up the commit message a little 
and removed a couple blank lines.

Thanks!

On 10/28/22 7:22AM, Oleg Kanatov wrote:
> jfs_mount_rw can call diUnmount and then diMount. These calls
> change the imap pointer.
> In case JFS filesystem is mounted on root (/), between these two
> calls there may be calls of function jfs_lookup().
> The jfs_lookup() function calls jfs_iget(), which, in its turn,
> calls diRead(). The latter references the imap pointer.
> That may cause diRead() to refer to a pointer "freed" in
> diUnmount().
> This commit makes calls diUnmount()/diMount() be atomic so that
> nothing will read the imap pointer until the whole remount is
> completed.
> 
> Signed-off-by: Oleg Kanatov <okanatov@gmail.com>
> ---
>   fs/jfs/jfs_imap.c  | 2 +-
>   fs/jfs/jfs_mount.c | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 799d3837e7c2..390cbfce391f 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -310,8 +310,8 @@ int diRead(struct inode *ip)
>   	iagno = INOTOIAG(ip->i_ino);
>   
>   	/* read the iag */
> -	imap = JFS_IP(ipimap)->i_imap;
>   	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
> +	imap = JFS_IP(ipimap)->i_imap;
>   	rc = diIAGRead(imap, iagno, &mp);
>   	IREAD_UNLOCK(ipimap);
>   	if (rc) {
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index 48d1f70f786c..972b9ff18723 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -234,12 +234,18 @@ int jfs_mount_rw(struct super_block *sb, int remount)
>   
>   		truncate_inode_pages(sbi->ipimap->i_mapping, 0);
>   		truncate_inode_pages(sbi->ipbmap->i_mapping, 0);
> +
> +		IWRITE_LOCK(sbi->ipimap, RDWRLOCK_IMAP);
> +
>   		diUnmount(sbi->ipimap, 1);
>   		if ((rc = diMount(sbi->ipimap))) {
> +			IWRITE_UNLOCK(sbi->ipimap);
>   			jfs_err("jfs_mount_rw: diMount failed!");
>   			return rc;
>   		}
>   
> +		IWRITE_UNLOCK(sbi->ipimap);
> +
>   		dbUnmount(sbi->ipbmap, 1);
>   		if ((rc = dbMount(sbi->ipbmap))) {
>   			jfs_err("jfs_mount_rw: dbMount failed!");
