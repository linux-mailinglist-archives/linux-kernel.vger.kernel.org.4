Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7812069F441
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjBVMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjBVMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:16:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580793A874;
        Wed, 22 Feb 2023 04:15:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x71v004011;
        Wed, 22 Feb 2023 12:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=einJNSaaRE9UiqjO6wclI/53/W+AQ/UPoWK/8Ldb7fM=;
 b=YyM5rQ4krN7dp4BjBZdYhLKMPb6DDWDlo+AGFKFJRDGKuQu2y6ffpEhanr90HOmZZ9PA
 X8YDXA049ppsryrFWxXKi8BjK5pKmAqwYLOpdt7YpVoUpky7lzLNKErrmka2mBXHYI5Y
 sJZ0fMmRfBgzGzBa6soF+/OiDeCdjw9obYaWwwBILGiIRrsWPcaXTjcZ4fcJe1kj/PM5
 cxccjowbdxjKsjJTeO6C9grRFaZOylhfalXXSAjq99Mvbldlxct8EncbvERxodX8uHgi
 doeWPqF/6xynnR4bE1nsvwy30Nr/B5DNml/F27G/MVbu8vCWUmP54LLIphgKvJaZr578 /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tqqxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MACWuV040932;
        Wed, 22 Feb 2023 12:15:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBXaIONDCPOKBBsoaR6+KZMRpqKWZc/oQHswjYY3rgUSaWpJWslfGbLxjo1dgDI6N57LM1qUx+kAXrtuzP0FmNaJHQbMJHy1027BVHq8o+w1VIlyeRWl2AgiXYt2548y3gjRmZx9BLJAcHa5G0jH46YeZBM0xFrPvd2sDafwfHAGVHkikBzPGj5j0UKBtZvuQ3qs//ePzuewvYx/XhD3iP3RhvX3l4BKWaBUxY4scLmV2qcjeLOb+LhbvxSw7JZBwqAdi3VilvBHo1iw5Q5Mf4o4DtENkisuO/foatTED+T5h/radcyT/UgQAIyRwLkkUIbhZi+i/+bX8IETc9hOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=einJNSaaRE9UiqjO6wclI/53/W+AQ/UPoWK/8Ldb7fM=;
 b=IQ+VUJQHj5qnNRWO2j3t6tCMfSc85d8ABP/P7QBveEvQzRcFHRu6jaemIyiAt6kDbqwIgDioCqPVcLIiiSdXdvci6X0k8ysguDUCLKbUyOiQqbX5zqdK815nf2a63Li5or2wRy5XXZv8iVInd/XQUyvgrDqwNjIwi7NJ3J4rFuJh+UFQPcZ7mJcuaY4QUvP1Mfe0t6HCcJ6cPtunjtxb58aptDbyySevPE5UlFnC+MrrpR/vx+HWZVq+1F4Qq9koMR+RejzFsKaGqJJ+pzN5kBfPDRQiiu6uQYo/G8ttRP6pXQGZ5uvpsNVMKZlrnZHlgAVWOllnky3Y08jxNecdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=einJNSaaRE9UiqjO6wclI/53/W+AQ/UPoWK/8Ldb7fM=;
 b=DspOByqnnJIuvKSM2rogQFvmMAX6qo+W9eg7AScsR318aEWzNseeGxlvt8tiX2mz9R8tTCZEXoRB8FGtN/14Ho/sK9um0K+BsdhW633EgSy5wfs9FnWn6cdPLWzrk93kzMz1ndbdxgT56GS9dXuXmbqyROKfOvlxwq3yR0K3Czw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:15:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:37 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org
Subject: [PATCH 07/27] kbuild, MIPS: BCM47XX: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:33 +0000
Message-Id: <20230222121453.91915-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2f6b85-b572-4724-65f6-08db14ce81df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFdRSpcaCb/qk+7sUwsLpTrB8EmtdFMeHKH6+XpG3Q6JMOICyjLnFOtcBwp6Y1aOU37gke1TzoOwG+qpSwSE6YJKZ+l4C83EHidmIWdYllY0gHmOW4c1BcspqI1LVOJRbREUSArA60txtPm8C/ZLAJJmL/+yNsgkWKNxeagJLXEV62KWOaVMyc93Za9BU4yqKjgeyvtzNq6Ha1I6Up/4N+YZSEnFeX3WIh2OfPa0JtAM8P1Aq/hTtu0OgfLxxWhh3NeIZ53m9V6vHNbH8Teo2j3/YuqV82sfGZtLU4ALGq1w1o5oJbUk+dJW4mnTPIwONXYELAN5VtM6SoU0QDgprHMOQMfoOL0fW8h7pTZprLSeSTq2vqyuGWr8yvbUGDbSf88lxRTPRyLTw3Vc4dE6xyLQZg0YBxe6SuWBgwNHORP06vVlKMp2E0hzyxuTEvyivamXSfcd5TSNY7vcPlOG5BVLQCbB8b1ufvriLx6s/PMsUVfcl/fyriopIqN6/lsVSlQ75Go6Epw1BGRQrBiJJ9rZz0BmT8CWJAY0aG//vi5okGBDcCETPgYpSsvD58YDPvbbleV/t3emi/tFAU30kp+NsaZU47HctX8qahAVFVFgNA5VhK711zBz/X/E6Ci0sqFz1OuXwhy/tYLOV08qyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFlTbm1tTDFNSG5Ed2V5TjJJaWk4ZSs4TEdjTFUyQTFJSUdzMDB6dVh6ZzhP?=
 =?utf-8?B?S1dTcGtYV0ZyNWtSeFhMM0hxcmJiUEp6SlVaOWl1TUtOZ3FWUkhuYUlQWndm?=
 =?utf-8?B?bkxsOFE3cGF5QzJaYTBUMDhtSmQ5Z0Vjb2JYdDYwU0FES200YzMrcWVHak5v?=
 =?utf-8?B?WHhCRTlyOWNCRkdSNzdEa3pLc0VoVnFuU2RYZ201TkZjalFwMHNzbEhYUWpi?=
 =?utf-8?B?cENWWjFtOHZpZVF2MWNMYVpueWhNbmVZVUNMc3FQV3AyN1VuK1VnckdZSjc5?=
 =?utf-8?B?UW1CTHpTaFpZQ3NJYnpvdktzZE85a2E4TXBLTE56MFM3eUZEUEJWeTlYemo1?=
 =?utf-8?B?cTQxaHV4enFaaTJqbWhTbDZLVXFIMWNJdmxpNE5VRWF4NHRwZno5VTQrTWdz?=
 =?utf-8?B?eGRUV2FUYVBTLzVQWTU5RzhNQXk1WEw4Y2FyOVZSc0RiM05EdTR3UStTak9E?=
 =?utf-8?B?SGx0QlVEdmoyVjU0a1l1QjhGQ2V4SHpkdS9NNkV1eFpieGIxQzloWndObnpm?=
 =?utf-8?B?WWRsRnFiTU4va2ZJY3IwTlVDdnJlTVBBOE5lYnhvbUtWKzExZWtramE5VDAx?=
 =?utf-8?B?TkNlSDFsa09NZThISU51bkp5WEJveW1TdDkvV3BPWG9YYzhXbEdpZ3N5NUZy?=
 =?utf-8?B?RHZHQzVYR2N1bDFHTkYveE5HZWY4R0EvM0J2YTRsUm5MVXdlL1pLWVhVRVUw?=
 =?utf-8?B?cnE2NGVUZTZLcCtyMDRhaEtHV2x4M3hrOE43Sm1iTVNhQ3phOEZ6V0VqOUdh?=
 =?utf-8?B?YWduRE1oMzNCUDRIMlN3VFM4ZE41UXJsVFFlR2dlNlhNcFRrVCszamdVaXFs?=
 =?utf-8?B?VjZtb1pnaE13c2xTelhEc0QzT2VZdXFNQnhpWUh6RHMrcmJTMTk3cTBKTnc4?=
 =?utf-8?B?V1IyMWJOdUVwUHNPeDhLeG5oa1FlWjdNcGtraGp6Y0dRK3htTiswR0Y5aEd4?=
 =?utf-8?B?VTd3MHRROXJDQXRWTXhGSTFHVjdTRVBRL2VGMFRVam1FVkZadEN0Wnd0UCtt?=
 =?utf-8?B?L29UYS9SSGI1aVJrdkExelI2b3dxYXlhQUoraCttMlg3T014eDQxY1E5aEdx?=
 =?utf-8?B?czFRSDU4WFJQYW5md3Z4SXlHbkJRcE9TNFAvWlZMMzVUN2hQSEJTTlEyMDUz?=
 =?utf-8?B?cEVITE5jY1BxSzErbjBMSDU0aldEemxTNXVwNW1Ic1pGa1dUL3AwWlhDWFFs?=
 =?utf-8?B?U0pMZVdaL1dPWVc4anZESWsyVTZXNS9UZWg0QjFENzFycUl0ZWY0end1M21F?=
 =?utf-8?B?SzZqcXFVWkNxcUFzR2p4dk01Nmh2K0JxTXpTOHRNdW4rcmQ3TGZORGZhVVRh?=
 =?utf-8?B?Q21CbUhjYzhkQllYT0R2akVmalk3dUJxWGJGSHFqUnUxQk1pZ2JPVURNd212?=
 =?utf-8?B?alc4MExINmdvcUJlSWJJWW1DUWRXajV4dmQwd2NFaE9IR0xWUjN0REF0Njhw?=
 =?utf-8?B?Nk1YWHJpNERIYXRCYXFCQkh5aWhvdTVDUTc3aG1IZHBYQm9oN0EraHozMVNU?=
 =?utf-8?B?d0t4Zi9XRVVOc2ZnQXZ0cC9SalFJYWVsdTNKQ2lrT1FrL0pXYlltL3VSaWV4?=
 =?utf-8?B?L3FMS0ZsQkMwOUFtL2RWdG9KVzNYNXpLWS9uK2ZRR1U2dGtzR1QvWENtWlEr?=
 =?utf-8?B?dkltRmUxVlV4OXJoeHJwUENzanNiU2RRYzArSWtHWDdFZGRpdTI3d3BSQ2I4?=
 =?utf-8?B?Z3RvSS9XWld4ZXlST1NWRWN4V2tHWDdhaDloWXNwNW9zWTBMRVVuSHFjUm0x?=
 =?utf-8?B?R2wxMGFkS2FSSG1yamNKS0dzQUtVOU9tL2xDRllrUHpVbHU4MjdwMWRPeS96?=
 =?utf-8?B?bXgzM1hZQWNtdkhERDRweVFKQUEvZVpEV1R5UGxpL2E3N1BSZ0VJNVNvRytm?=
 =?utf-8?B?aVZvR1N0aHFWVE5ybktOaGVYRzVrOU5iNE1wbnRaZEoySDdaZ05yVjgrSXhz?=
 =?utf-8?B?Q1oyUnVFYXdTdFQ5aFlQU2RGZzZqOGRYdU5oVUp5ZEVQWDhaZjI1VnJLT0Va?=
 =?utf-8?B?em5WMGtjeU5ndHc1aHNwRHpLWlVGTk1tclZrcGY0RElUU3RwQ3pFRzhUMzJr?=
 =?utf-8?B?cGo4WXY0c1dqQ1QzRHJicStmb1hGMm1wYThHRm9uVWh2OWticWY0WFMwVUZl?=
 =?utf-8?B?MmwrTFhra2orOE5pVng1S2Q4R3hGU0pMWDNVRUpFdE9RT1ZGOEY3MGFPd0o1?=
 =?utf-8?Q?eG/7koJ7V4NZY6z9cdrdZvU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ks2aeJgqkT+j6UwolajuBsmmyqFrc96BoZVRGyGtEV2DR1N6eJ04/YyWyb9l+DZIBCZnG3VkbqlpGjOUnjXQVUR4iZZ81iOkQ3iINei9lhhEWwSl6w4rz1OOShaVyBjKYJGZr+pxYvLPWdtejMcGJjAQozfZPHHFNk76W/FCQUk7zRMo9ekR+IWiC98tn3o/Dg2tassPMMsU6v8z+E6NIt6h3TdcFVFL5t1+fgr3L7USJFb3n4zFIgT95eMCYzTRyet1KWdeJwWuAn24MTCfI0COft7I/ZcSJXhxEAHfU9n01YbK2Hp22TCRh3kP5tWxCYd03S/P920JHVyxphABhiMtYV5hug/6nRaw7ehj5b2IiWG36F37lUazTtJegdxISU1xbo8ZgVI6dJfEcceLK8LGIzJWfygywZ5SP1BCZZ2jSsuNIn2RWQaUJ/A653L0r1yDfHrrkc0qoDcdTb+A7yq7XjYb+7JJ3AX2ptmIyoyGtuFiWONOwdsnHOCuykE+aC0SjSM+N6q/uc+Ez0QSh3a69L9JWQmI0YfBCbNuaofKRPICPhLPTv1mPkEM+lqGNTJx5BBZ/se0yCAnMmXrS2MUJfSOD5n0yTlD7t6dylpHNSJAkC3n7QrDbpo4+UgiMvQO7oI1qLaOSEsg69E1tHHoOuyP3WebCvxdfhun1qg8DXILnS2y0cSmjdiFq1vGBZNQhifYNuCFDj+t0A/qlLOPpJGGwqpExMBIOK6lTW0EXubFgu7zHOliAjUxs5RG7Y6ui0KJPx8y7oU9SfNOH8/GrG5LygOqCUAGoU/IBhntnXHfhcOBYV+M2Ty+98epQwgQal2GBiupa648vhc4ik/nUpto50AVWdFh4hoEIB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2f6b85-b572-4724-65f6-08db14ce81df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:37.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZHDeFoHST72XWHnDOOxTh3f22kDEkAWqna3s0qUn20N2hZNwCTw0ir8ND7xfWU4NmwCfAhJ3IJxLokegJn6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: tzRgBJQ5qvzCe_pJQM6I3JepKsOaabgv
X-Proofpoint-ORIG-GUID: tzRgBJQ5qvzCe_pJQM6I3JepKsOaabgv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: "Rafał Miłecki" <zajec5@gmail.com>
Cc: linux-mips@vger.kernel.org
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 5f47dbf4889a..0ea5206be4c9 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -255,4 +255,3 @@ char *bcm47xx_nvram_get_contents(size_t *nvram_size)
 }
 EXPORT_SYMBOL(bcm47xx_nvram_get_contents);
 
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

