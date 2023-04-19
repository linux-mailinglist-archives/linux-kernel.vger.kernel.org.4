Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071BA6E854D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjDSWyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjDSWyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:54:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9804B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:54:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL4AUN012830;
        Wed, 19 Apr 2023 22:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=n0o73PNaUslJGqQZmMGWz9weKyUrdxugtoWpl9B/1mc=;
 b=OL2zGLCsT197xF481BPje++7lQrdX/D7+PP1Qb9PrV/LuwbhKdqgUfYfEx6hUdnQmvyo
 3oZ5P9BCyPqxk9o3TGDfikGhtjiUKAj0cv9P/MggJxRJwhdOFh/r8INO32O92cIbt74v
 H1Msgx3OKgtDqRGVCoVprKLBZhnk4doMdYgPSYCKD6nemrXGLuV5WxNFa+pBkTGw6KIe
 DHw9B1UCwQTuGFOTNsDpDgAZo4Kvq8r68g6/6QpKzNZpS0eMPVDq2OxqTxhu4fv7r/S7
 nKYnXesmqfJmReVuJYtPmgjv/gddN06+H/N17lirefn/T5UQ65TvE3/NVHQM/ApRfBWP 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q07690hqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 22:54:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JKuqNv011102;
        Wed, 19 Apr 2023 22:54:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc72998-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 22:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y83kD3nhCSej+m75AIXH0ju+eSQA/vfBhvpJb7uMR8VlBuBCbfHlSS848TLAzy5/UpebXg1NQZkqxA0qTGa+JDQooQaKTJvtQRcNjGEjEaBP+Ptr6Z6Cye3wOFRvJa2abuP1VV2Od9XohzUx9iYnEr6w+uIECuGWozOD3kdoBTHImU08rKePJHOujHKCKGUXFI4gQekNAB917RpC771ofVe1az6TjFmtxAaHW9v9qznOJT4amJa+nYm/4fA0W7Wd8LokN24CJw9eWOFz8a9myRAu+4EYSCh+Zpqj/KV04vtrvEtIshDOkmwBSI5Vt0bNTU5/iQGNP80uQqiCfflzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0o73PNaUslJGqQZmMGWz9weKyUrdxugtoWpl9B/1mc=;
 b=lh5kXvNTQrZeptFUFpMl0z4JpzXMfBixYX+/gkF7HCLt/vriqjGRYmOP1h/ALoeImeWR3OnfCAPwlWtjI1gHQ5AQl7WAkvv31PEfDEMsoQzkHD6DW9RUm1OZcyohru+WNr245DhG+ZKkfDaO99rHPWLUpvEHgQvarRW9Oh7/NdldnqxArUyMO/oBXUkOtaqrRRO6bdp9JX8JCY7hcDqyaHHZaCAhJ9Orul18JLUO8qQTBV6tzr7s+QpHvGfva52imOB2GzWy9fERxFRduomZ2atkR4dkc+SR5h7IP5TxsLxip7k27KD4gEmQ1wvw3RzHfiBOdFHtehF/55vO4pWoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0o73PNaUslJGqQZmMGWz9weKyUrdxugtoWpl9B/1mc=;
 b=PSHG15PbCOq7vXNTNoPgeZXtgoDtn+3G4SpC9ZNm+1yEtFiMdX1LNoeak2+sLCs9erFORHIyaJwNkE3XHVuckB+Uh3SFjwzsgS0jme6/TRQx14TCGPtVdbe2KmcAIV+wKszUNkff+ve2JNSM4++uR81CMHzOjzqHBk87BSJ09P0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7416.namprd10.prod.outlook.com (2603:10b6:610:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 22:54:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 22:54:23 +0000
Date:   Wed, 19 Apr 2023 18:54:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] maple_tree: Make maple state reusable after
 mas_empty_area_rev()
Message-ID: <20230419225419.czzwbdgys367fax2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
 <90fd5cfa-5ed9-495f-fdef-0130adaf591b@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <90fd5cfa-5ed9-495f-fdef-0130adaf591b@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 840d6ae4-9d8d-421c-67d2-08db412904ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFqaqIJQCrdgpVsQgGlXqUc3tKlKKeQFoSrU7b+znDS7iuioWfrZSjL0K/XHTbiBqbwodbVY8Ztvx/RfrxLTnYfFco7Fs/Ozji5ANbB/GvLoSdTaSS9EmRAsVSLshCnf+Ej8JnUhSHglsrVQDPS2y1RQtvxcMSxRL34rey/bUm6uxk9oaE7Do06hgS3ij9OTYnjI90E7YGg4t6HoCO5Vx8sQyhSCfrwluRCNtD6myYaZ1Juh9+yxBEq7lDfdFW52tedJ4efMdACJvkfR7VzDzr0G1/ACuwrbNcT5RPBYzwe7POHmzR/TF4BA8XoTDlaSLiTqtwkhE6OvKr6ICMe2iPObfgxBWWW/Kj9gYcVv0NDgAWg1nm6gKRTRvCOYjYldsoyMBRligJOiAK68l+Y0DR3uGEGS7DkLvENsUVotLI+wiwA9S8PU5NrFDM8sresX+yqr05/kWC7Xj4E/FSlBvsxbleAEoJWwQogDI7goT68PHLqd0PCTI0s/k9YIGhboj1CHztKfCsB5hKqF3n6xCRc7q++7nSYiYIXWPgW0bC3IHqL7xyiJ7yVFLHGIHW6h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(66476007)(478600001)(6666004)(8936002)(66899021)(8676002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(54906003)(38100700002)(186003)(2906002)(6512007)(26005)(83380400001)(1076003)(86362001)(9686003)(6506007)(33716001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkM5Q3FleGVRY3YyVFVwYmNQMThNaVVEb3RyWE40UkhEM2ppNWZXcG5VbHhR?=
 =?utf-8?B?K0xjWDNlNG55OVYwMm5raVR1QXd6cSt6SkpTK3lTTVRVVjFVWG9DdzM1SEts?=
 =?utf-8?B?aTE2QnFRenFsS21HMis0S3dQeTFCUk94NEJRTFFZcmg1M0tQalpOMnJ0SURI?=
 =?utf-8?B?eFBFaWxYZUtUMW9jRTlsUFJtY1hDK01yU2plY0ptUTk5Wm15S3hIUjIwSlAr?=
 =?utf-8?B?UUc5OEcvb1p3b0tuYm9tNzVtcFNJWEdSVnRiTkxlYUc5dC9ZeHVVdzNXL296?=
 =?utf-8?B?UHJ0UVNhNy9kQW1Nell1VnVscXExNmh5WGF3MWl1ZnpOSkZwekxUUVlrZDNm?=
 =?utf-8?B?WXk2U2VDVUdqSVhWMS9DRHY0R0NwVUd1Lzl0TVQralJXWWFwdk9iUVJUd1k0?=
 =?utf-8?B?SnFHU2tseWxhQi9oK0xlMldFZ0o1aDd5alFrekp6ZVF0Q1lteStZcDF0Z2tI?=
 =?utf-8?B?ajhJQUJ5b1ZRSzc5ZGdFdU5VckxEOUFCbUtta082U1IzMWdJMnRZbVlPQ29z?=
 =?utf-8?B?bEJYcEI0YUE5NkJVT0EzOVFqNGdVQ25jQklsMFdsSUVqQ1lnUFRCRy9MTUp6?=
 =?utf-8?B?cm1zTkN0ekxjU1JSdUZWMmQyNysrclo0T3grVzRGdTVJaytpd2I3RkVVelFM?=
 =?utf-8?B?azFyeE5UVHNoMWlQeTI4cHB4UlJYOUZJaTlESk9tQXh3dTZTeGpOWmhnaWxR?=
 =?utf-8?B?MG9zaDlWakFQV0xua2ZhdXkyTTYrUHR6SUhBd2JidjZwbVZJQTBXcmQzZ0xa?=
 =?utf-8?B?dVdoWE44aVFaRUdmbXFMNWxyVUdSRUszc3dMT01xRDFXZHN0ZUdTOHFtTUZW?=
 =?utf-8?B?TGU2NFBtUHFhdXFaUm00Vk9rTHFubTlBU0xRQm1iZWtzYmdrMkVQMXUwdlFu?=
 =?utf-8?B?NFFCSXFEa2pFcEQ4VXlsVFFlZjFRczIxanFOcWtVQ2pHT1hzckxEY1RlNUo5?=
 =?utf-8?B?dklJQjlLYW9mOHFQVE9GbStQWm5vOUtOK3ZDSC9rMEl5cUdEeG1sZjdORWdD?=
 =?utf-8?B?RXQrdjd2eGt1bStMbFBINnhIbzJ2S3BrYVNTV3NRNkwvbUEwZWNSMGdXbW1W?=
 =?utf-8?B?NW9iNnpxSkRVK2tWd0dzWHpJNmV2RlYvaFlkalpkaUdvSVlWQ0FDWGozcnpu?=
 =?utf-8?B?a3JkRk1yaWVJczFsR2xhQUtrUkNGZ2tlR2hLc2hoL1lmSGdsZzJ4c3dROVNo?=
 =?utf-8?B?bEFmTGhNMUdoUUdOOUVnWW40WHRXZXJpNXB1aThZbkQzSUJOc0swamtQQ2gw?=
 =?utf-8?B?TC8yR01LWnlab0V1N01WM2MyUWNqUERSZDhtVkZuK21rTGpDUGZYNVdlYVZ4?=
 =?utf-8?B?UGpCaFZLa3BjTWV6a0VxaEFPUXRWSDhFenRSUHU1c0l5eExuclpYbjE1Z05T?=
 =?utf-8?B?M1hpdDNoRE9GZ1Z6TWxqaitka096bWRwa0pONVVrL1p3UDBlbDNhTGdNWGlZ?=
 =?utf-8?B?WDdVRzdVbnVKZzQwNm9JRTNlY0NKZHdoanR4UkxqS0VXaVFCZmpKQ2xDZ3Uv?=
 =?utf-8?B?Ymhrb2NZanVjaVJQQVYzTVBGY2pmK0VEaFlEK2ZwL1pyNXNBZUh3TzFMckt5?=
 =?utf-8?B?Rm9OaVl2blZ0RVozRDk0TS9obE1TREZkRnhkc1VaZjB4R240NzJPODgzaWU3?=
 =?utf-8?B?ajkyNDk5a2dWNm93emJ4VkZzRlVGT3RWemZSM3pxclIzZ0dLRWRWY1ZWMzVn?=
 =?utf-8?B?WFptM29WQjJtVDR0K3U3NU9kQVl1YWdjRHVBczcyNzkyTytnZW0xdXRGbng3?=
 =?utf-8?B?MjFXS0VURlErOFhESkFkcnFIcjltdzBXajJxR2RwNTc2ZUZRcHBzdE1jdFBG?=
 =?utf-8?B?aHpiM3cwbm9COFVjOXpQTWJFT1g4c2QrYXlUOFpTMjEzeEtZUksrbGFDOWJQ?=
 =?utf-8?B?THNKQmFpKzJtdHFUbmZKSFBQbDJOTWEwemxyNGd2cWFRSldwMjNoQnZVaTBi?=
 =?utf-8?B?dHAvUXlObURYTDliMk9rckc2ZndaWVN4TWN0L0tudkptczArWFZUUDJvaGJj?=
 =?utf-8?B?MnFzOVlnWEdsT0VpaFJjNytzR0VPSjBEUUgyTzJxYkRKaTJWNUtPQTdMYjFy?=
 =?utf-8?B?Q1BZaEUzMjhJakE2aDdRUjJ0djEzb3NNUGorZ25tdEFKZFR4dDB5ZHNKaFd1?=
 =?utf-8?B?T1hvcXZNYmEzODZTM3l4RmR3cktZNkhPZmNiQ2ptdTJaUDFQTHNRZndVOHJP?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qr1wAmf4GISk/V1GWufbntjllmdUTEnqx+LbApTjQ5mLa7id91zboSbN3xIR7stNKA7zfJVhzYP+7ch9/gIqJ0r1F+06efYxdAPAfKfcfCOHsZLKJNoIYuownKaVl++6Eq/pa6zaJe6uZnsImVABcBikzaG8GDDzJLE/ai2j3hMqyC77ExYoGhQKiy72w8/RWd4aMBxWuYd3RX9AcbyyQG64fpDfgaSukdg2trq8JWZxK5xt76i0pvnPinKd6HHy7z7iWPVRgvuR88QnkwcgMBzNtg/kkVxGkkcMIaaIRl7MSaoVFUvNH7A42/fSdmZpQnOx8tJuLJBPSh1KmNN3FUiBifdjcFQ7BApFIZYdjAy4i+PCohWSkMqZpz6OtSHiSBa4S2TmAY7CHUKtriLwTjUqLV7ArgZI4fT/q1bsaso8mZSMaCKHm3dtszplH+pH4MjjuTfQAMj0z1v63f6duIKM4Dbt6A8lSFmG2OorWut51MdlG2SJYTQL/Mq7f+cR5FFr2h48NmbZov/cjrwW9iCOH4EH7q2gpnPZ4Sm7CEmuZjL0KxBopr+GH1VTQVo398/f4OO184q8awkkH2b3/q/RuVQ+3wvnAI4hLvjEpDjF2k8CyQagn4pYL+lw57Nr4/z6BDH8GC5/wYBadsNedYXclWK9pZ4tcmbWHJU69TlxyPfpwgMU5FryXnbZnsQ664Yszj5n5PZ85Mv5zLCbwmZ/yaHkJq9CBCIkxfnw2kTdS6wzuz1ot2ovcvuR+bTeWPSMlWz9AaLvw7pVZmafnQU2/OjeHDPnJWfEixXGD7yofJUX4ogIPVuI+bH03rV3I024165IlRhlTIkE7/1YFX7mnVw/FIgDV20XeJ7sUCOH8t63oI+8wIOwD4DPi+RcrNZ/CZWY1tQovZ3Ogbo8VO3A7Xvdpa7375/gScYtWQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840d6ae4-9d8d-421c-67d2-08db412904ae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 22:54:23.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oL6Sg8ATzR1FLDV2DiIctamO/ujUtJ6BRe8qPaGxa/v6gwJFTH2FVg+9pjAyQVsyJvRDgrxOQvCf/91yIqILw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_14,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190198
X-Proofpoint-ORIG-GUID: sPuXjNbFrF8QqAjp38J5OvF0tA8A4uEA
X-Proofpoint-GUID: sPuXjNbFrF8QqAjp38J5OvF0tA8A4uEA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230419 05:02]:
>=20
> =E5=9C=A8 2023/4/14 22:57, Liam R. Howlett =E5=86=99=E9=81=93:
> > Stop using maple state min/max for the range by passing through pointer=
s
> > for those values.  This will allow the maple state to be reused without
> > resetting.
> >=20
> > Also add some logic to fail out early on searching with invalid
> > arguments.
> >=20
> > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 27 +++++++++++++--------------
> >   1 file changed, 13 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 4df6a0ce1c1b..ed350aa293b2 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4938,7 +4938,8 @@ static inline void *mas_prev_entry(struct ma_stat=
e *mas, unsigned long min)
> >    * Return: True if found in a leaf, false otherwise.
> >    *
> >    */
> > -static bool mas_rev_awalk(struct ma_state *mas, unsigned long size)
> > +static bool mas_rev_awalk(struct ma_state *mas, unsigned long size,
> > +		unsigned long *gap_min, unsigned long *gap_max)
> >   {
> >   	enum maple_type type =3D mte_node_type(mas->node);
> >   	struct maple_node *node =3D mas_mn(mas);
> > @@ -5003,8 +5004,8 @@ static bool mas_rev_awalk(struct ma_state *mas, u=
nsigned long size)
> >   	if (unlikely(ma_is_leaf(type))) {
> >   		mas->offset =3D offset;
> > -		mas->min =3D min;
> > -		mas->max =3D min + gap - 1;
> > +		*gap_min =3D min;
> > +		*gap_max =3D min + gap - 1;
> >   		return true;
> >   	}
> > @@ -5280,6 +5281,9 @@ int mas_empty_area(struct ma_state *mas, unsigned=
 long min,
> >   	unsigned long *pivots;
> >   	enum maple_type mt;
> > +	if (min >=3D max)
> This can lead to errors, min =3D=3D max is valid.
> I think it's better to change it to this:
> if (min > max || size =3D=3D 0 || max - min < size - 1)

I am not sure what it means to search within a range of one.  I guess
you would expect it to just return that value if it's empty?

In any case, since we are dealing with pages of data for the VMAs,
having min =3D=3D max really makes no sense, even with the subtraction of
one in the caller to reduce the max, the min and max should be at least
PAGE_SIZE - 1 apart here.

I think you are right, and I think this needs to be looked at for the
tree on its own, but I don't think it's a problem for the VMA user. I'll
write a testcase and ensure a search for a single entry in a single
entry window works separately.  Thanks for pointing this out.

> > +		return -EINVAL;
> > +
> >   	if (mas_is_start(mas))
> >   		mas_start(mas);
> >   	else if (mas->offset >=3D 2)
> > @@ -5334,6 +5338,9 @@ int mas_empty_area_rev(struct ma_state *mas, unsi=
gned long min,
> >   {
> >   	struct maple_enode *last =3D mas->node;
> > +	if (min >=3D max)
> ditto.

I'll do the search in both directions.

> > +		return -EINVAL;
> > +
> >   	if (mas_is_start(mas)) {
> >   		mas_start(mas);
> >   		mas->offset =3D mas_data_end(mas);
> > @@ -5353,7 +5360,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsi=
gned long min,
> >   	mas->index =3D min;
> >   	mas->last =3D max;
> > -	while (!mas_rev_awalk(mas, size)) {
> > +	while (!mas_rev_awalk(mas, size, &min, &max)) {
> >   		if (last =3D=3D mas->node) {
> >   			if (!mas_rewind_node(mas))
> >   				return -EBUSY;
> > @@ -5368,17 +5375,9 @@ int mas_empty_area_rev(struct ma_state *mas, uns=
igned long min,
> >   	if (unlikely(mas->offset =3D=3D MAPLE_NODE_SLOTS))
> >   		return -EBUSY;
> > -	/*
> > -	 * mas_rev_awalk() has set mas->min and mas->max to the gap values.  =
If
> > -	 * the maximum is outside the window we are searching, then use the l=
ast
> > -	 * location in the search.
> > -	 * mas->max and mas->min is the range of the gap.
> > -	 * mas->index and mas->last are currently set to the search range.
> > -	 */
> > -
> >   	/* Trim the upper limit to the max. */
> > -	if (mas->max <=3D mas->last)
> > -		mas->last =3D mas->max;
> > +	if (max <=3D mas->last)
> > +		mas->last =3D max;
>=20
> We can get max as follows, without using pointers to track min, max in
> mas_rev_awalk().
>=20
> mt =3D mte_node_type(mas->node); pivots =3D ma_pivots(mas_mn(mas), mt); m=
ax =3D
> mas_logical_pivot(mas, pivots, mas->offset, mt);

Yes, but why would we do this?  We have done all this work already in
mas_rev_awalk(), and we have to do it there to get the offset in the
first place.

> 	if (max < mas->last) /* The equal sign here can be removed */

Thanks.  I'll keep this in mind when I revisit the function.  I don't
want to re-spin the patch for this alone.

> 		mas->last =3D max;
>=20
> >   	mas->index =3D mas->last - size + 1;
> >   	return 0;
