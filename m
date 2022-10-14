Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6EF5FF23B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJNQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJNQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:26:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157131ADA6;
        Fri, 14 Oct 2022 09:26:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EGOGEk007206;
        Fri, 14 Oct 2022 16:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EnRdAC8u+m8MWRbd0SghDUbzYut0OfygUQ7aT7Wbiys=;
 b=dXpcBjn8W/6kFy5xaW7GoKURe35qRhVUoKkFCvWzGyRvxsbsiNWOPwPbTbttCH0fI1yH
 ukBTpfUJ3mR9duHPOVL8f89TbxbBjsW+0KNtPye7ib121za/uWedjAb6eXWG6cPrbtjC
 1UdSIz7BxaVn9wK6TM05XfjkZs+8btamSGofJMwGMFBfB40HA6+KOigMQxIx7f5Z+8LW
 MK4D1pVEvXMF35xSKlZiY2d08+rX41ECepQX/FsWHgxZXD1Q3A45OMAbwPN3yzfxuHTS
 mLSxnvOgChtxb+9Je1+Y1rAK1xNrsPABp0tcQBdCFnG7Qp0BBzXjjkADvU17zyuwnGvI Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k795k0f3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 16:25:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29EGEUXi005884;
        Fri, 14 Oct 2022 16:25:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn7gst0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 16:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNbdrAfMOWI6mlKyti2eb3aZnLD2BkA/B8EUN3xRYQv/TMz2CHJ34fTIhLUrLDOa+vWQqbnofCkG3LBGgYPW6xTOhtSNhjFAd3Yfzft6uz4garA8T8/cdyrchE/lYLBxHOs5gRSW+ZDBcN3Ed5pCtU+Njl8/oyLGuycWixr9lLPeDbYoNTBIim9KoJwqLEhCYN7aw0uppDnd4xrb+E7SALQZbodQYVY5IhAnUoTCv2WrhxGZzj6NFRvGRAyLDY9AzerjW8GfOAfKF0HyiAgRv2YCTFplQb/CPFx1Yp0v6MAShF7tQ4ZEvzs+fbAb31ubGMcp9+Fwmfr4UCRmuYeE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnRdAC8u+m8MWRbd0SghDUbzYut0OfygUQ7aT7Wbiys=;
 b=Db/RySLpjlIlAUBP+STUoK054wl8gNqGr2AT0IfUUxq1ZJr2wSGNg8KcKWOcCa7x2oNFiGyfo3EUwAZiY/n9tml8F6C11E+QtIcBrQdYvDhuIdAFITT0QWY/N0v+LHxdhCtaDOxf5R3GAsR3tl21SNE3A1YzA4zpmOUFrX+EXsfhLZy2HCcp1RIUmkQI+80Vc7xTCr29H8gHZZKS7a5CaWK1fU+ugbjJ+a5+9cYYTQAE8X8YjOTNA0U/GFA+YdRwUHcuD0B+U2ULN12nwfX8gr0OnUkbEDG9zwsU9r4lY6zsTO8eFWV1lxR0RUwFhP59f65z71SKvpUJjCNIhuMXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnRdAC8u+m8MWRbd0SghDUbzYut0OfygUQ7aT7Wbiys=;
 b=PEiO6glJVgQfwpkVwn4gPRDiC0qM58/EqCi0SwTWnlh7Puv2hb31B+GlaQ+jK7YAMy8C8WTtHz6pd3abYdXEvqsVcX8dhDNl7s4VNxYFQjUY6CuayF4C+jOlDzX0ULgz2hYyl9VVjuUkRqVD0BXfO/I0qd0KLKeOpbCln7Fh7Io=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Fri, 14 Oct
 2022 16:25:38 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4cb8:f380:67:fe9e]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4cb8:f380:67:fe9e%4]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 16:25:38 +0000
Message-ID: <d0b15b1b-cf12-9da9-24f7-1fa0f4ee3757@oracle.com>
Date:   Fri, 14 Oct 2022 11:25:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        "samasth.norway.ananda" <samasth.norway.ananda@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
 <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
 <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
 <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv>
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcd8eee-2224-49df-f233-08daae00baca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75aBMcgZCF9h7WQZQNNMpctUwwH2diPNqX3UNrwYYT3eusO2DqT/hivsCmQ86FpY69gMBa7ILtVg4ZpZVIzxKngFoiUnZT3OusPQiJBnz/whMC0r5TDTnmMZ71IHLSukX9wD/JtDCApHlVtWJMFY6WwN0YATHLbSaLXxFuWU2sd+EWugASnLfnQkGOpBuOcJ02mFxJXlj2RHUNT/U2e5jDtdhxnsgvgHLXp6AuIdWX6ikbGcyk4KmcKy5yeaTQUXdWC5WqUWiyoSdeB5Hs9MoSujUkhCW+T0zTSgSSWdGtw2Hw1WH3S3zc9kw7Gc9DdaF0S6kPzFXErjdxdI40p8+LyBaNYD84USa/oKtDU3VkhIIhSRS8noy7ev4srXBgJ3KqJxZiLzCnXQ6apvs5Vq+mP62G5JfAWtoKsJKAaeu+vz1wzbs+XxHDQ/vNFyAHAEv4xU7pVq7f9B30KcO7D6fgl0jKUQkn7Jt+podUtAzuUixfK0diUdWyYRoxWoiwd74KMH3wORQmglwKFFJ9NUrPLxrdhHVMq8JhFKaHvKwXUwjRUzw0KLLcN08ZRuGN01vscKeUK6YaEZ5761b8TKuK9L9XqxL2DLRXer6PFEgEWCdK8JZCDL3BY1/d9gHg3g7GwVUu3LElikZDatBuyX5YsBhYceK0kG02p1oGafuLHypcab2waOToWqwKd5T4sg613iifIxwWylwnsrzoD/1opIDabDlvEyImWerF2FW1EYWivhK68Pz8W2/pYVu+wRqA3SMzgX/zbkZaU2PXUuOfs/A4k5BxCtE2CmA+MeiGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(6486002)(86362001)(31696002)(36756003)(186003)(83380400001)(478600001)(31686004)(2616005)(38100700002)(107886003)(53546011)(6512007)(316002)(110136005)(54906003)(66946007)(6666004)(66476007)(8676002)(7416002)(5660300002)(66556008)(26005)(41300700001)(2906002)(4326008)(8936002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NWOVpCeDlGVy9HbFdKMUR5bkNmQVVVS0xBTWFUWGNUbEhLZ1lVK1AwNWZ2?=
 =?utf-8?B?RTZmbENRbXlDaU05OWtkbThoN1E2OUkrQUQ5RHMzQk5jQURCY2VQcGtDZ0hY?=
 =?utf-8?B?K0l0SmVxeVd4NTNZVE01QWxOYXR3U3NoOEZURXhaWTJTeWlEVFZxemhnNlJa?=
 =?utf-8?B?VFExTS9FcWVxUSsxeHFWMmU4dFo3UXpEM01oVGxNdUtlWlQ3SEpLZDJNdGs0?=
 =?utf-8?B?b0l4eEZmczVTSjBRd0dpZllwbFd4N3ozM29ORmZmSWNaWFBuWFNaQk1WRFBO?=
 =?utf-8?B?VmZNQmZ2VmRKS0hQNG1mRkVFUklSNng3aGZUT0I1WGtJTVdsblJxR2F5VTdC?=
 =?utf-8?B?aFF6MXhIcXd1cUFQRVZPQW9UOTdvdldnNHZYNUtpZUszSUtqRzRxNU9ISk83?=
 =?utf-8?B?TVB4aHlXbitoTjBGTVdhYkNLVFlIZG5yYjhXd2lUV2RQTk1EbVVlbGVPNmwv?=
 =?utf-8?B?TElZS2pndjN6MHN1Uk8wK2RIZWR1ZU5Rc294aUlmSlZ6UDRzZ3FETFdmUXVC?=
 =?utf-8?B?aitPOXg3cXZWTnhBd2pWUGhxblY5ZmlIT1RvbzNkSFRTdXdKUmdBQlN1OHZO?=
 =?utf-8?B?aThxbHMrSldpTkxTTU1LUkNpdnlnUk5jQ0tBNENSU3dPdERYOS9yS09vOUpp?=
 =?utf-8?B?VGFjL2FLQWx3dXZOZ1pUVEtPeFRzcUEzQk9jVkZ2TldEMHFqNTcwbGgrTncz?=
 =?utf-8?B?Y3I1eEdaRXR6VDlSTTE5SzRwZkd0aUNkR2xXN1Vpa1haeitVZXJGd0NtSWdw?=
 =?utf-8?B?S2Mxbk8wQkJ5MmJXUEJUWWZrVlNtSVlJQ0lLRVBYeityNExKL2dORnFlRGRj?=
 =?utf-8?B?ci9Cc0dwTWY1TFhycDlHTkhJdHV1Yi9MVlM0KzhqRHRYWTVtcUZleXZ1cGtQ?=
 =?utf-8?B?SXZzRlV3YWNQUXV3MXZXZENpdU1HSENFQm5wSXFDTlAzcW16S3FDZEJPeEFD?=
 =?utf-8?B?djhjeVBvUU5oSlJXb1VHSUl5aHpBSEFPNHJ4WGtHekRwK3lCSFpXL2FXczht?=
 =?utf-8?B?NEtQNjZNdGNvVnErN2s0dnZuL05qeDRlNURxNVBZckh0QTE2R3l3azkzdzJW?=
 =?utf-8?B?TllmYitHUmJJWTVvaFBTdHVqaFpEWnJnb3lrTm02N0lzQXdwU1Y4eE5JOFF6?=
 =?utf-8?B?Ty9OclZLTkdxZ2RHdC80MmpCL0o4elRIUGZla3ZWdUNiMGVjaGl5eFNXWm9y?=
 =?utf-8?B?c0o5ZkM3Ymk3S3BxaWlST0lzVmdJY0VNeTlueXFiZWJnSGNiWjBzNkZ6dkpj?=
 =?utf-8?B?dFR3ZFZvZjVpN2RTYWRHRitSa1NzdkRaKzgzY2tSNHRKSTNqajhDNVArcHF3?=
 =?utf-8?B?ZjBFeUVwS2lzTmtIUkFQeGk2NGZtN2R2R1FBZHlrRGJVbGZlYTc3bEJrYTdz?=
 =?utf-8?B?SE9FUUpHYUFRUnVEN3U5YmtUdjduV2ttYW90aEtEYnNMY3d5NkFlZFhLeXZx?=
 =?utf-8?B?eTdESUlKRHRBaGFMR21ubkVaM1VveW9naVBzY01ISWpvVDhSb2JGb2MzSmRi?=
 =?utf-8?B?N0RJWWJLL2tLMGZMNXJpMk5VNlZId0UzRjU3WjBCNURJbUpXWkZBeXVYU2Nv?=
 =?utf-8?B?S3pzZXQ0YmZueUdLdWJaYjVmTU1XSGZ0REdmdjl2UkxiYVVYYTlKWVpSTWQ2?=
 =?utf-8?B?WTBGZTRJWEFEaGRrR3hJRkQ0RDhpVDhUYjhrdHJMekNiVStuMlNOaGdCWVla?=
 =?utf-8?B?enMwKzBjMzJXc1ZtTDNDNmo0cERic0ZuanF6UDZ4RVRqV205eHY3eVpmTXJH?=
 =?utf-8?B?VXdnUlRGZHd6dUUwYmZqZDRhbm9oa2dJcVNUeWw2RFh3SmQ3S1lORGJyRk45?=
 =?utf-8?B?WVliZ0FLZGl1VUNUSUVPY0g4TXZybVdCWUF3bEJJc3ZXcmJ5QlIrWFpuMmQ3?=
 =?utf-8?B?MUNQYmhoQlV5TDVUUjBNU3ptNXRlUnBrWGI2NFp4VmtOeFRCbHVmSVJHY2cy?=
 =?utf-8?B?RTFKRkR4UDMzNlFORG5mZHRzNXdPNXdSemhSeitGakFEYjJVNkxrS2dNVkNV?=
 =?utf-8?B?Z04wYTZyaURoQkpLRWt6YzlsMjlJWFpnMm5FS2VlaFpidVJMRDRJTzlNdTVH?=
 =?utf-8?B?Y0FETmsvbmpDa1lCZGpjQW1hL2NYbitxcGN5dE8zc1NITkFpUkFST01xMDJW?=
 =?utf-8?B?VzVCRjJXb2V0WEduTk5GRFAvSkRtSS9YWm92VnNzZVFwUjVJY1hqYmQva1M2?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcd8eee-2224-49df-f233-08daae00baca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 16:25:38.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMt+wAaLbMnJpCRV5z4t+Xl953I+dPGoyQgukC+kTtdazVsae0N5AKqGhf8cjqEUOAZu8pOoN0pJ4Yk/6WBH547U7lI34jCX1TZ/cl9PKHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210140090
X-Proofpoint-GUID: 6wEC0QiL3TjbftbBZXCWt-pQg9wAtw8z
X-Proofpoint-ORIG-GUID: 6wEC0QiL3TjbftbBZXCWt-pQg9wAtw8z
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 05:46, Baoquan He wrote:
> On 10/06/22 at 09:55am, john.p.donnelly@oracle.com wrote:
>> On 8/1/22 9:47 PM, Leizhen (ThunderTown) wrote:
> ......
>>>> Do you have plan to pick this series so that it can be taken into 5.20
>>>> rc-1~3?
>>>
>>> Hi, Catalin:
>>>     Only function reserve_crashkernel() is modified in these two patches. The core
>>> process of the arm64 architecture is not affected. I remember you suggested that
>>> arm64 and x86 share the same kdump code, so these two subfeatures are needed.
>>> Maybe we can lay the foundation first for the people who build the road. Unifying
>>> the external interfaces of kdump on arm64 and x86 does not seem to hurt.
>>>
>>>
>>>>
>>>> We have back ported the basic crashkernel=high, low, support into our
>>>> distros and have taken wide testing on arm64 servers, need this patchset
>>>> to back port for more testing.
>>>>
>>>
>> Hi ,
>>
>> What is the progress of this series ?
>>
>> Without this patch set we are seeing  larger crashkernel=896M failures on
>> Arm  with Linux-6.0.rc7.  This larger value is needed for
>> iSCSI booted systems with certain network adapters.
> 
> This change is located in arch/arm64 folder, I have pinged arm64
> maintainer to consider merging this patchset. Not sure if they are
> still thinking, or ignore this.
> 
> Hi Catalin, Will,
> 
> Ping again!
> 
> Do you have plan to accept this patchset? It's very important fo
> crashkernel setting on arm64 with a simple and default syntax.
> 
> Thanks
> Baoquan
> 
Hi,

We have pulled this into our Linux 6.0.0 QA test kernels for now. We 
would like it added too.

Thank you,

John
