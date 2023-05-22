Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633370C2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjEVPyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjEVPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:54:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CED9E;
        Mon, 22 May 2023 08:54:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MFjM83008912;
        Mon, 22 May 2023 15:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XgqjpS/AngLM5cJ9vmqq6lCye9w7dVbsIqYVRyFtxig=;
 b=fpZsSFvMr66X0a2btT/9zbVTP4i93YzFjPHf78aZdh1HPpcNczNRiuzAVDqv/v4rzStI
 oP8moeX+pSudBGZ/NatbHJ9jNI8Uu9v+WT864hDebSenjqZeWNxGQ0n25mdCBnm7/f2P
 MpRxYTVaVkx1Q81dCfCW+7MROzpG0cH2qYyvhLn0fVj1nOStLarKVC3KVLWsIurb/023
 tSA7PaAPatJfoY58qIbEcqtVZ3p2ArKmWda5p58rg12BXimkG/YGCrT+r0w9Zvu2VzjQ
 EXDq+t6sGqBi+C+j70/jUsBx5yqFsigCHbjsZJSO+Nf9Gfc3RlP+7Wyb2z37tKJRUxQP lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp4232r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 15:54:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MEVZA6023566;
        Mon, 22 May 2023 15:54:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8t4xcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 15:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV/B3fgT+4vprg/3BfkxhZ5b32puFLXYJliPGTAvUJNr+gKxhAfgrjNHTgOu9OjItKzmc8/DJEkTPeAfONU1Y0XzHe5UsfM7wFF6lhIZAIxI3LHSvl17tng1BR06tsbN2pqpsTeGMP5eDIY/Jaw4jdF6VV3Y9VATmf/AV2QUQVXppHXpdIx73jeHlUyTNQQiGr+c04xSY6/banoke7r1MXjCOivmaJdODNEF/xGTri8/qtEV+ystEJw9KEPoIaJSSSgBYubwZs4a+NFr0gWX3DBV1z+TEbzRHBGRPOONf2FlGdIcLUTlgCNwB/In0/7Dg6H7xn3jK42+eayBOAKsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgqjpS/AngLM5cJ9vmqq6lCye9w7dVbsIqYVRyFtxig=;
 b=E1NmXbrvrOB0hjnvlmmpu0LmE34QQPuaxEINFecKul/FoKKoqlTc4gn78ysFe29nnfPMUC8juggLV3gAYMXnM0u4eodhO0VIF/pqdDO3iQrKBziFZAAyizl6uhTMPXzAenii/vMrKL8C2ftlBVsGHoFnw/90+DXRW+BzMNfjzWiKXjUhotjx11YEhis5ptDn7gK4qw2BLTPaYiyWqtzcwYVZ7ucrASX3E9mAHg5jtmCeiqJhF+ldpa1tw7k9TgPDSdmDKsD/izIUhIcNOshUM0kzKczwJDdn5hjCdjnckVmabaB4QuRpdhZLcAvxfhOvni8UBn4Qlowa6bnttSbQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgqjpS/AngLM5cJ9vmqq6lCye9w7dVbsIqYVRyFtxig=;
 b=xYd3DgrhimfQy+m9OZivuZmlPJJLeTyVGBzgjiqicoq+UyQ1AVlm17WG/1xaM2DT8dZ1qXODC+pOQ5Bz41f8RxvQ02D55PBJMbv0qGbavrHvC9Xh/rv3hABb+lx1tre9KNuOrkaXHgbtRflIaTiUeOlyH+thjGrqXSHA+yChhyU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:54:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:54:34 +0000
Message-ID: <ffb8237c-bd38-e323-0179-4313d9ef0a75@oracle.com>
Date:   Mon, 22 May 2023 16:54:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     Bart Van Assche <bvanassche@acm.org>,
        Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
 <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
 <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
 <611e1210-d89b-9046-ac3f-68a89af6159e@oracle.com>
 <ff04d098-17cc-42c5-cf72-2128fb43114e@acm.org>
 <73e3da3d-ed90-6c38-3c8c-13653bd89944@oracle.com>
 <191c7661-c47f-5aba-97b9-ff698bda4bc7@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <191c7661-c47f-5aba-97b9-ff698bda4bc7@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8918e5-42c3-4e42-cb95-08db5adcd6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmFs0nVms9UzU4SyLynMpurk7fOY3WYFhXZ5yK/SQyZamDjjwljscC9j79N/iVd6fJEPmQk1mFbJfTVokV2eeTgDBHEiIzEDo7u/k72KbxZgSIlIBrfNowNXdy+mTAopqOCVX6g39BawUzCdkOh1MGSazNxtCPH1vHmvuNrQeHRrOKTM47kME8fVjlqE7eEyEHlUcDEmS4TVN1RBIAZk4uNTSn6lEbrkuTxET0tHHi2wFYU8nEbqfd6LhL3kS28V7wCiDSgBZlKZD0Tdz5wdZKOJ5M7VL/xw31GsU4V8N7cACkh1/wvuhpjujy9QX7r0OiugATJRbtDGDgkU69AmDgbwWcMQDtcw09j746uj8f4AJVOu6CeYiBqsrHh+KohFyMgn/WPP0aTv94GtfduUisnvuYd2XjWC4DLj+/zpWNNXsNw/lNP7D2vGtkDqrnTU+RulU9Fr6YNvrJZIZHjxJUWGjE1sP23lyNTjM4Jzs4VWixuBZZfYfY6CKAxAllsnPJudJrjgO1X2rG/1yEDXXKzTGJ/EB5d0rzsO/6Tw7KbCHKlBoJuoe/vCSwZJ2deYaFBR66IxkQDi+2MEVeUPpwOQbFoOgdRQpHWM2GyKO7DIuTELQnTxmxe4ibVnLto3hqIEgod91bgoz+NU2m/ovw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(5660300002)(8676002)(8936002)(4744005)(2906002)(186003)(36756003)(2616005)(38100700002)(86362001)(31696002)(6512007)(6506007)(26005)(53546011)(110136005)(316002)(31686004)(6666004)(478600001)(66556008)(66476007)(6636002)(4326008)(66946007)(6486002)(41300700001)(36916002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDYrSEIyY0FXYWpWYWQ1ditsRm4yM2plVnNlTHdyL2VYcWF1WWVUanVlMlRU?=
 =?utf-8?B?MmZkcEJsY2VqMXhaZFpMNjFaQ2tnaVpRZVVQMnZLdUZwTlV5dXpBZEtXK0hZ?=
 =?utf-8?B?MkRRbC9uWjduZlp3MHNGODlkankySGoyM3RvYTJwU29qUHVhL0Vma2hhbGJM?=
 =?utf-8?B?V0JWc1NHUWk4WjZPVWM0RDFtQlhDT0wydjVoUnE3SFhMdTFqanNiSDBBbEM4?=
 =?utf-8?B?NkV6czUrMXBnUlR4VkM5a0d2WkNIS3dDUzFxdEw2dnFTbmtxSnAyL3E1cFVX?=
 =?utf-8?B?VVhsakhPd29KMW15QnQyOXNFblRBRkdmUm1SMUd5d3dydzN3Y1d6dnBtV1VT?=
 =?utf-8?B?d3FQYjJNWlg1WEhkdGU4WkpiZkNuMWRGZWUycGR5V2VTNnRmTlQvLzlpWG4y?=
 =?utf-8?B?ZHlnZ0lYc3ZFMlBQd1lOWS9SWHZaaXBqU25aNTh2a3ZyU2JyWjBrV29zMkxG?=
 =?utf-8?B?UXo3azZ2L2VqNTJVVXI0M1ZSakxkdW9aU2J4Tlg4VDJBUWNOamxSNy9iRTM3?=
 =?utf-8?B?REdXK1o4UHA1R1FTUDJIYjdxZmF3LzRnUmJFY0pEWS9KY2ZTZHNMY2dJVEkx?=
 =?utf-8?B?R0FRZyt5LzM5TnRJWkNJa0NIQkwwMS9KenJxUFhaVHpaSndaWVFmeHkrZklm?=
 =?utf-8?B?cllZQnJtUU5YVGJFbnRBRXkxeGtVeE5DSXk1eUR4V2FFSCsrZUN0N090cm5U?=
 =?utf-8?B?dERSRThQeGxQa3pxZkRsNzhOLzkxTFBGNUw4U1cyWHlUT1I1OCt3Mm1jQTdY?=
 =?utf-8?B?bmdWeHFRemt1cnkyUVZCa3ZPQnR1VjV0RnpEQStjcURlczh3Sk90N0pRR1ZS?=
 =?utf-8?B?RmpNNDUzWVQrVkh2cWdzOXNja0VTN0RJckgwWVkwSmpoWnduT1lCRFdvbFpH?=
 =?utf-8?B?NjhnVWMrbGQ5L3JyTmdwblZsdWRnQ1JYMmx2eEJ6OUllQkdIMFlTbGVvWVQ1?=
 =?utf-8?B?YWJHY244WTBTZ3p4NWEvbHM2ZlVrczNYWTNOR2JwYVRGMlZ2MFY3aDZZUGlB?=
 =?utf-8?B?TWZ1ZzNmSnlOYWxORVVDTEVEMVUrdmpYVTY4ZWZENXpsYWFtSVBFTW5zR2Rw?=
 =?utf-8?B?ZXZjbjhoMDhuQzF4TXh0b2QvMFU3Ty9MUCtOV0NxUXR6SittYVJJTnBlc0t4?=
 =?utf-8?B?VjhZazVMMXVJUkVxMElNdFZIbk4rR283RnB5NmFSdGtLdnM4Z3VEWU1Mbm03?=
 =?utf-8?B?ay9oa3R3allMVGpoWVgzQk9iS284SWtCTkF6aGxjeDJQTVQzYkpjSVVsZWF6?=
 =?utf-8?B?ODhkNVE2c2dTK2kzcFRadGVsbHMzeTlKQzJWQXVibUhCa3ZXZHh3UDRxVXI1?=
 =?utf-8?B?YUoySTJHbkl3NnBhNW5OaERwOUswUUg2aE5lcG5EMTRmck12YW55RHdsVjg1?=
 =?utf-8?B?eGovK1hZd3dpWTZqdERzMmRBc0taeEttam93ZG0yUGN3bkx1RGpxZTY2TnN3?=
 =?utf-8?B?Q0E2RitjditnM1BOemU0emtnOEtJNDMwS2dDOGNTK1AwNmtLbGgzeWNmMmxL?=
 =?utf-8?B?dXBWWkh5TGxIN2ROQkMyWncwRlNlMUdydlkvc2tUMEUrSktOOVMwTE03bFlX?=
 =?utf-8?B?S2RiUmI4L3NsblBlWUY5NUFIUzc5Ti9melFLRnB6eWFKVTM4akRtTXBLbG93?=
 =?utf-8?B?MkpXczRKbitkNm9HN1hucEw2WC9DYytZVWJQeG1oYU0wS2NBSGVNSS9sY0Nu?=
 =?utf-8?B?OTFCYmtiK2gvMCs4eXdTMXNrd1l0SHVvMEFHVVIzWllkc1NTcDl6OVFWSlVr?=
 =?utf-8?B?LzQ1N0ZGU3NjVm9hYjFoTWVkSU1FYTJFd0NKanhlaTFvc2pEbXRLVVJXbG42?=
 =?utf-8?B?VXlyaEZTYXRSaEtwbzZwT09NdVlrOC9Wdy9waDNlQjFkcnEvUlNacW8rWmJL?=
 =?utf-8?B?Y0NNZTF6eXB3dkZaaDd1SHR2cGZaTkNkQXBmdDZpdDhCTmVsZFkvUjBvd3lr?=
 =?utf-8?B?TnhYSENRd3h5K3I5RERYVlpzR0did1c3QlVucER2Mm12TWM0V0h2dUNHN3NC?=
 =?utf-8?B?V2dsZFdiUlhwUktDYks1b2NLMDRIT1IxZHdKcDVTRG5LdnU5TzFTYUJOVkhh?=
 =?utf-8?B?bVhFdXlvcGdQcEVCamZ4RFd5UDhmMVVraVQxNnpsSXErMzZpOElsYzE2Um1Y?=
 =?utf-8?B?WHFZOTRtUSsvM2xPMVRabEpXQzF1ajYzb2dWdHdzZmNEQTd0L01WTTk5TGl2?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QESsue3DjGDaAkyMSid1zn5+UjlVE0oiFhkN62dQm5UKZHQ8ZFb4dz08hV57XzJpZVXCKbFD1PEy+HlMX6YIzjaQHr/ZlY/49s5aG1bu3hl2/pj4CxFss1cQ81iZDXY4qZh6aIDEqb3LRfm36mIYp+Dz9sXP+g/AQVcB4JmunI0I3/w8FguN3hnE0pxGg0r6aZnJtXJJ1Vd6yZFH0h3x9PphUVsdkKB7Xl80iW8uTNrj2ediISrdAsvar9YTwhitAscl2gOFZhW0PG+VidvYl6FXQpnJOuxp023GHFFtcAziI19MofMTT/H2ZnR4d/IwZQh569mYCin7jvo5rUV7bsxAetMCD47EGW+NGHCNMXo5ReX4yRQsf3mw4jiwiwiBrXsXvM18x0WTRFmlc+sdQBHQBxX9lwFFg56PqKKsjQPptto9LbzxgtvOashsjypZm/5xQaZ5xEBtwx+nemqkn6MS/Wwz2Ew5aeUCcu9nsZKLAK1p2xnUuCQz4davDZbtda1DoM80mk2ix+xeCXAPi/9eX5FXKG/V+2LS/OoZJBSyP9vg2F+fG9AF4tjFJ9b9k35mhBdAS6/UPnB0SJw2hlRNAi5gmlfL6FDpJySVAcwY+TCy8YTZTisWbvzj5CeQ+f4EOMOty7SZjw5q174KiLsPdMVjgBGmJvKrGa48hS8Fmb1F7QvqyUo/iUIvzQq6sad+4oDnhDHt3/2mzs8J6fGk0sk+1hFbqWnTeXMMFrmFOXL/8vCbHohTvatA/Yh4WEK0+FtaMsfm9aGMchleY/3yPDw67pV+1pOuZA+7Z2gu0DmvUop5H5TDkJh7QbYqddZqs8mPy//oS0ZBVeDj2g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8918e5-42c3-4e42-cb95-08db5adcd6ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:54:34.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8Nr6tdn5moZkSg/PUGqZGmUfT3xHxv+aJfQB10bn+xH6FYg26+3YDGbm0sPt/4WvIIEAKoZ59z8zN2qsZ4ZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_11,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220133
X-Proofpoint-ORIG-GUID: ubvjQ9kut1_7LbUwMo8-xGaoRmhbsvjE
X-Proofpoint-GUID: ubvjQ9kut1_7LbUwMo8-xGaoRmhbsvjE
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 14:31, Bart Van Assche wrote:
> On 5/22/23 02:55, John Garry wrote:
>> On 19/05/2023 18:39, Bart Van Assche wrote:
>>>        *args->resid = scmd->resid_len;
>>> -    if (args->sense)
>>> -        memcpy(args->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
>>> +    if (args->sense) {
>>> +        *args->sense = scmd->sense_buffer;
>>> +        scmd->sense_buffer = NULL;
>>
>> I think that you will agree that this is not a good pattern to follow. 
>> We cannot have SCSI core allocating the sense buffer but a driver 
>> freeing it.
> 
> Why not? Something similar can happen anywhere in the kernel anywhere 
> reference counting is used.

Sure, but you are not using ref counting. If you could use ref counting 
then it would be better.

Thanks,
John
