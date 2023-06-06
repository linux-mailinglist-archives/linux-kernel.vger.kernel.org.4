Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04116724AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjFFSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFFSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:13:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526DE43;
        Tue,  6 Jun 2023 11:13:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DDsP6022042;
        Tue, 6 Jun 2023 18:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rLbYlpzeM+w77x/KrQxj6kkLuK+nTPW9fbuOvhzi/bU=;
 b=gbp7P1u/57jmff5iRvD4Ac5O5jtGVGquxRw9qhvg7CUQs1LTFYkrB+IyWpAKnwwsm7Zj
 GAp+grP+hoYdS14zmBun/tpXulcmAX/mM/Vhg4BdnSV25Kc52oZAqN4mQCEhQHCipREJ
 PZ+M8bTller7PHKDkfO734vLaZlFjhOLGaiA/ypkBe3lipssNTgXxKd/nXRG4veENMHP
 PqcsbW5FwYGrxo+7zuu/Ubfngp9Vm80bMLFcqHcl3urarVnJeo3M6tJUJAXJyfY668WP
 aUjH45DnxGBLhLsz2OelsSIA0OS96EODGTExrsE3763sL0NM6jvYjlcnodX54Z96gvSk Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2n5y4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:13:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356I0FTx010502;
        Tue, 6 Jun 2023 18:13:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tqdaa15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifhtDYtv85y2jJBLFVgVQf+4xy2SIuPnjBXgV41zxKyqa20lcPxkuIU/OtXR2Efb1i8ooy7LoeHNZunGCTwtLS+aVd4GSuAXiP40qdDy0AQLCQ6yOPRPfIqxFQOUUiOyxCRQcUq6H8GfTobw2vxXyNCrgWCoP3MImM4W1MVGsuSLHQNxaH/DQTM8+ElNuWwdoKfFRMoPcZdujD41kmKQ8K7n/TKApVqn3483+g69ljgnBYipogVySLslS1ImWv9dX+UgdWTanAH5TgmG0SiPmNkpB3K2jodYZYSUmBqegJNisGP8iyIy16tSPyr2vfcKEdQMmU9W1t7YFc7/9dSV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLbYlpzeM+w77x/KrQxj6kkLuK+nTPW9fbuOvhzi/bU=;
 b=K0QCLO+nHv5/5WoaB+5uhKQ9dt+ensjKOCf7iCNOKeNVuHwFdSkHQJmtcC50wHPTbndJI7YB+O4JPUjq1JceCSggYeX/iu0pCvfBs7QXhwRy68/CJE3A/I8pY6QFZtW3k/ihWLfZ03dsO4GeeHEPL5I4nS9nNSYpgY4Kcl1oGmxngKd09nds4Fh8Pq2y3f6qOMF8FtmRGuFxMRmc6RbFX425iaVLaNFsXLoePy9z8xyzED+EAogqkoxvjd28AZbVa/WkE6cQKfaVY82hRtyo8subXaaDSVmm3ZgTWSobqwuDbUbxmJaAqDYtOhUA8PhVel0ng/yVNT07VB3p/90Oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLbYlpzeM+w77x/KrQxj6kkLuK+nTPW9fbuOvhzi/bU=;
 b=xmwF3XPG1fflbtU3JE3pYsK0wZhC/vA9AgwUIiXv0jvlZZBDdB3EskrmeZX5bYM7TSTRVFJpJsi+FPRNJsNkJeQDQRzHEfTDZQr7BK1rk/6W2BhTWrK5vpWD699IDxkbPBCIK5V0bbuTdET8gX9tqbSbyThzouwSxh2inhBf5So=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6753.namprd10.prod.outlook.com (2603:10b6:930:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 18:13:09 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:13:08 +0000
Message-ID: <c6ead868-3523-f25c-3f04-119da28a50ff@oracle.com>
Date:   Tue, 6 Jun 2023 11:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Ackerley Tng <ackerleytng@google.com>
References: <20230606172022.128441-1-sidhartha.kumar@oracle.com>
 <2023060650-overlying-skiing-191d@gregkh>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <2023060650-overlying-skiing-191d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f2a02a-2053-43c2-394b-08db66b9ae6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF+rO8AL3lTfcFx5DlvvKtP5MNhjqI78u5FmJVwzy8jelwlXq/DRRakPpMxNC4kT3SjjBwTtyQP3q6rxAhiFI0DMg9bcCgYwGZitUNsSZDv0Jn6mufu2XVOc6CZJAjyVuldm7G9itIkIQm2nTqaKITEb/zM+uSgvabCVc/3CTmwyvn7ew3e+qnTx3D+iaFoeQObO0EHW4KyvWiTxH3PXmWWn6TmzkOh4p0w9WNJsvzt4Q5sXBd+AppHMobjiY3w1RVRgRZ/A6UsuDZj8RPJdm6oMnf6vSWGNzu6ocJthoB3BxMy1OdLjQDVWg0g97E/MyBdEpr7ejcuoWabZuT08xr6XPgLVrB3ExQaEgYxj8NrbBMi6mLH91G2GkcjbKm8spX17YELb68w+emKih7G1dtAQpIJsMYJ5t6zNzFckV7BYC1YvZea0A1VDri/ou5gUWpAGecpD4wIrPC8B9oV/V1yui1vwhGy2qr8Jc2aw7DB/pXb0okdHdUW7maj3PAdru1M4nO9n3sNZzOXohyGow3psa/rp9iMIUNE1rwKGAaTCKjl8udJFuetiiP+asPXa56O1eF/+mXvPJgzS/k99XxQfZEaaaq8249ZY/bn2ji+MC6gLKvl++cnb/FYZWoZEuCJ8DBoqs3bamtJZ+VD9XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(186003)(2906002)(2616005)(31696002)(86362001)(36756003)(38100700002)(966005)(6486002)(316002)(41300700001)(6666004)(6506007)(5660300002)(8676002)(8936002)(478600001)(66476007)(6916009)(66556008)(66946007)(31686004)(4326008)(53546011)(6512007)(26005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFB2SmpIYUpQTk16dFBZTlRpaTllMkN6amxTNFNoV001RHAwUEpLdk92L0Z2?=
 =?utf-8?B?bVB3MFprdHJaN0h4VmRPL2d6c1IxdkxtYWFzSXJsNUJmYVNYS0tLZlhzOThQ?=
 =?utf-8?B?NEsvV24zNnFhQXV2ZTJIZGtNWmRIaWIzRUQ5T3d6cGpja2dLOUE1b3YvMDJW?=
 =?utf-8?B?bXJrQUZsaWdNYW5EVTlDNHNnUXE3cUN1WHd4aWhBK2Q1TW83UURLSUM3RklY?=
 =?utf-8?B?ZlRZQTVEcHVCTEFHbHMzSDBzY1Fpc2s3QkY0K1JPSUdOMjhaTWlxc2NmL2tF?=
 =?utf-8?B?eS9yMHVDWWp5S1BwVlN2QW1SKzBJNHppcHVHS3M3RWpsUW9SZWlNazZIakRv?=
 =?utf-8?B?VTlUSDgwbTlQVjYvQ0g0VTB1N1hIcWVjMkF4SjRDVGNSeHQyRzIrRzhEK3M0?=
 =?utf-8?B?cHord1lLbVpEeGh0bEhWeno3VFJCeTg1b253aGZwek1pb3A3bFBRRG1zbEVn?=
 =?utf-8?B?eE5EaFlDSDJocFRwVUtxcWhHNFU0cS9rVHl3L1lWU3BETm9adFNvaUpPaVBF?=
 =?utf-8?B?dlBJR3Zzd3E3anFVY3I2RU9FckxraVBiSzNuUXhXR0YzNUc3MDF2VHVZWnB5?=
 =?utf-8?B?ZkU3VmxuSnNEZ2hLZitXcVFzaXVMTTViQ3FRRlFIVXJYN2VHNmlBUTBKZEEz?=
 =?utf-8?B?Q05jYTlQYmpTdkNYblNMd2hQeEg1ZzZkTFJmWkl4VkttSUhITEpvWTJNcEg5?=
 =?utf-8?B?cnU0OWxwZHJ2QVZwaE91dlZ6SGtkN2ZLUWlTbmhKZ1dQNnhIWVhZYkl5WEhZ?=
 =?utf-8?B?M1poQk9JNWdUbGtpWnBMMDA3VTdDOUkyWWNaRUEyMzlFU04rb2NIaXhtNWVs?=
 =?utf-8?B?M0JNL2dPRnRXQzBZbHdBK2RCUHE3TmFnZU9OOTIrb2dvZVRXSG02VGhEK1BR?=
 =?utf-8?B?VnUyRDJKQmM1Ty9pOVNubTkzV3d1OGg4a09KSE4zeWZaM1ZJOVExVmQ5cFd1?=
 =?utf-8?B?UUphNkRINVFvVVNaNDVqVUp5Q2hMajhvdzd0WGp3d2ZncW91d1NBQ2FzTHJY?=
 =?utf-8?B?L3pQYVZ1SG8rZmNDcGtzMTdPd2ZaSjFyRmkrejRQb1FjRW1tWHYyVU5JMjZX?=
 =?utf-8?B?YmNuaG9IUTRCM0VXNTRtM2pidVBqWHk4S0o0Q3hRMW5YOTEra3lHUWd3TmZG?=
 =?utf-8?B?ZVpCQnBZU0RtTFdPZVplMy9WVzR5d0NPN3EzbVl1UVFYVG96UkNxKzhQZVB6?=
 =?utf-8?B?d1RFSU9la3V3aCt3aXh6VUwrOTFMK0lBL1hSbkxIYTRYTmF2NW53WGs4VGZ4?=
 =?utf-8?B?V0dOR1c1V2lLV2lnOVM0QmRYWEVhTnlEOTJOaFZYNkczZW11eDZsd3VoRmhw?=
 =?utf-8?B?bmUrRzJLWEhvVXQzS0F1N01YbExXeGY4VHFJWFhiWmE3bHhSVTdyY3Z0OTdu?=
 =?utf-8?B?cVZvdi9hbVRVU1VhY3FzdWcvSEdxZTN1RXhqSkQyTllPTy9pNWJNUWV2RFFx?=
 =?utf-8?B?WUVJYzNxMFRvWDI3cUV6SDJyazR6WXhNNG9kTDRuOEdoU1l6Z2NqUG5TQWdX?=
 =?utf-8?B?OFd0OG1qMXRMRDVHakZSU3ZjNDBNOHFCdEJpSHBmcDRVNTA3TVd3VEl3TjZ2?=
 =?utf-8?B?c0xjSko0NUFaSElEVXJXcHEzbjFkdnF0K2puaEtzSGJ1NlFVNXJmUU8yQlF0?=
 =?utf-8?B?L0Y3RWV4OTZTRnF3RGZ5TjJPVFNMY0U5dk1XWW1JTHFlN0o1MDVPeHVyUzJp?=
 =?utf-8?B?LzNHK0FJNm5VS2xuRDJoakZSelJlS04rV1BMVW1LQ1hxSm10T1VjcWNyOXpL?=
 =?utf-8?B?eVMzeFhVU0h4bG1WL2RGTWxyRkYyaEFaZUVuWnd5UEtoUVFIUU9pa25hcTNw?=
 =?utf-8?B?UU9rVU9tYzAzM0xIbUdLMnpKWUowc0NULzNucUxVU0JXMDU0TmtRNlR3Y3p3?=
 =?utf-8?B?WU1kdDhsVWg2b3MxN2F2cG9BamVJTGdxOWJWWGRvWmtGUDNneW1nUzViZkVY?=
 =?utf-8?B?RkhXZTN1UUcrZFhoR2xobkZhcEpxbkl5dFRnNnpGSGR2cEtLMzR2YU15R1hU?=
 =?utf-8?B?Vy94UDN6OWU2Rm1jbTdPY0dOTlg5T3NoSXVzNGZVWng5ZkxaU25iN2N5RWVU?=
 =?utf-8?B?VnJIbjY3Mkw5UUJMN2M1UFdXMGZEbHNwaE52OFY0OUpzY0hJY0N3MlhNaGZM?=
 =?utf-8?B?Q1pTdHhadHQweU9zYkdqTzh6S3hna2xRTW5PbWs4YXltODNUNjdmNVZ2WGd1?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uhDFeniWCkxtNu9HSAkPxHytRO6p5bTIu1C4GYiFOF+G5nGZzqUbdku30yB0Vcga2chVx+hwXthf6aqcfISuAu/aJp1c6aO8DGunSxgrt8EtIaqepTWvQvVdiN338feGlVlZV7dOvj7R8b3V/jLy9dXbdWdiJtfXdxMI6kpLTaVOseRewMhy503utnXdzmn9bquN30OCqXH+Md4k+ele2bZxzBqbJ1QALStGntM1ECo0/r/qBX/M2t6EtR5rQJQ4f/CMZ+WrSmlVQF1QtMO/VTi8zFkHJA7uO7TpXFo6cKt//91URtEfFYTzbq+U1zGB/XsmsUZ7HA8VMycjwAtUK2Iz3ryVML4rtQeP7xphb6VTHzO/PiYqbmRxVFENCtednfYf41wArK8mghsgCtfz0xiX1AQdneWNcqJIbeczERGh4M4yElpjtfHQhhGMHew3SIxt6qoJMpmdH3gr0BWM345or+jBHHTmrtQCUYJcGV7bmEgb8M9Fb1d1eP7nKgm4ZT5UPbePUWpqNRkecF3v2/EAgfv2QcDf+/DlxEAHB3sTr4xLURa78w3JigdKQXrhMCCBGaW1LAFDx6KhJsn80XUtN4GOSN/K8xmm4XCD4RcENDVnpjlKZIwEe5mBChKEassljVRHNTyfKaGeS5swJAEMz8BxeqL+Sc2oXePzlTku42KHER4skqnxzVKo+0IZQzNyl/MqDMa5axl1N51RjmjzNFBSAJc8WHS0p9yjcEAhc5KMB59KQHe9lrE+1Oou+x4FNEjEdeEUrK2rlk6S9LfHVamoIOGziE6f0/1amdzp6xGcfXprOCAlLrkGTbt3VAWQome4NeGivXb8Vx+GIKQsqMKqtqjJhwKMklOBUx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f2a02a-2053-43c2-394b-08db66b9ae6c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 18:13:08.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKJzFMEw9ho7n4jC8F475abnth7IHYya3E6WPA5RvfjxrY+nFaY37SjZshD2sVZkzW/6jpy4Qtg236slaQZZx8RK0Kb4g9i5JQ/RoTmBp9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_13,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060156
X-Proofpoint-GUID: 8HDdJ0i-UhehNs9EirqiAu7IYersV76l
X-Proofpoint-ORIG-GUID: 8HDdJ0i-UhehNs9EirqiAu7IYersV76l
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 10:38 AM, Greg KH wrote:
> On Tue, Jun 06, 2023 at 10:20:22AM -0700, Sidhartha Kumar wrote:
>> As reported by Ackerley[1], the use of page_cache_next_miss() in
>> hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
>> same offset fails with -EEXIST. Revert this change and go back to the
>> previous method of using get from the page cache and then dropping the
>> reference on success.
>>
>> hugetlbfs_pagecache_present() was also refactored to use
>> page_cache_next_miss(), revert the usage there as well.
>>
>> User visible impacts include hugetlb fallocate incorrectly returning
>> EEXIST if pages are already present in the file. In addition, hugetlb
>> pages will not be included in core dumps if they need to be brought in via
>> GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
>> already present in the cache. It may try to allocate a new page and
>> potentially return ENOMEM as opposed to EEXIST.
>>
>> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
>> Cc: <stable@vger.kernel.org> #v6.3
>> Reported-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
>> ---
>>
>> This revert is the safest way to fix 6.3. The upstream fix will either
>> fix page_cache_next_miss() itself or use Ackerley's patch to introduce a
>> new function to check if a page is present in the page cache. Both
>> directions are currently under review so we can use this safe and simple
>> fix for 6.3
> 
> Is there any specific reason why we don't just wait for the fix for
> Linus's tree before applying this one, or applying the real fix instead?

I missed Andrew's message stating he would prefer the real fix[1].

Sorry for the noise,
Sidhartha Kumar

[1] 
https://lore.kernel.org/lkml/20230603022209.GA114055@monkey/T/#mea6c8a015dbea5f9c2be88b9791996f4be6c2de8
> 
> thanks,
> 
> greg k-h

