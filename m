Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B56DCB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDJTUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDJTUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:20:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40551994;
        Mon, 10 Apr 2023 12:20:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACdb2I001929;
        Mon, 10 Apr 2023 19:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/KmRiVxZOVGx4LSAVQ3sovbdk4xn9xpZrrHsjVBB9Eo=;
 b=vSKnshLV1aAVDMG+q4NXMmgSmu+d8ZhFJ1z1guwVtHvenh286ttn6Fwcn5hta22Ena8U
 KMta3h7w6xMwDze3jNZUbkRdnAmxyfzK7nWWgSbCp6M3BfErfpVAgg3FG+WbCsEkvvym
 WQIZsDwasT0FuTlT/oydKiH8rHEcWSIBcpvTQjLItC+Y28VX3FaHPESm2Sex4p6ht0py
 rc4W0VMOB41U8Hg/vPOgf6hHPC1ZCn4OcMbnDqf85KyaSciPO7dBw0djYiVhJM5FJEkF
 uk+0fjK2flK7krNLSodHbOxV0sOw53e/uwwiaWcfdHuGfINBJsea1Da6dBB4sNIgfQNG ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hc3mpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 19:20:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33AI1V1N038991;
        Mon, 10 Apr 2023 19:20:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbkppa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 19:20:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7FZBJF395gXHRx90cZ63nvMwPMj9v1Ps1sZCvHEnUk7ZPpPI1l267dubDRShpv/blwzPDdEAQcN0C6ULQJ7q+pxGoTD6vzprk4oEYcKECe1uF+1GBV7FqBUlMuc4WRyajsvRiYATy0UMY2Mxx4gxy2HpUVsrAP6OXnytDm4J/KQFNbECWUksdfOMs6qXozX3sNI0oyZCM0CsgiO/axRz3GS0iIk7Zq0vAPSpSNVQPS0y3RN2HHk00azDOT8LkpJomc3IpfYznHfnUWnXwcwC8dLF5VFHE74xRhHpCk75h7YGl2jxs5APNYHvP0VSiVhjs5mLdXn7yPFB304uWPOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KmRiVxZOVGx4LSAVQ3sovbdk4xn9xpZrrHsjVBB9Eo=;
 b=goXXP/bpGDqJZX/1s1ppPZ/V+yz+cGXA3xWNlrUKPvbCwkMinbhUCzxBq+yNfr0zVHvz1HKnbwW9SihHl/jc5Pctjs3/Mdo/WrrotaLpNO1qpj+RcdH40EV7xAO3Vnxp5lCjkPMXvAgcc8bXdgx2kFTk+CpCnaTtmPsGeDP4YbIOxoqVcQx2tjaE8awx53oP2ue6J5opLY/CZbUPdz1Kh7kecCKto+58QZN15v/0s9rdBo+hYutwX3keQRH2CLosDJajkOTXgsMQzStGKViIJwTIaeCYnboYx5gQOQbIpp/gOpiGVAPoH0g0xMdirn/Peux/Vw1uwOE/uBSdm8i12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KmRiVxZOVGx4LSAVQ3sovbdk4xn9xpZrrHsjVBB9Eo=;
 b=MfjJwgseCtmglRF1aFAVLVnGmnv4Bo+LrDNf6qSU8N7+GNWKRWu+cXt7ZfQNGc9IdXewxp8Fpy4Scf3sUDsjY3tGquS5aiVO5kNexs/yVrNlPExyOicBJgIt8cbskfUChJgDTUzd+1r4aR0bU2gxqFFdgLjXssujTmHcRvGsGjA=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Mon, 10 Apr
 2023 19:19:59 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%8]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 19:19:59 +0000
Message-ID: <93ef5db7-fb4d-bf3f-9456-3fb6e7d5ca29@oracle.com>
Date:   Mon, 10 Apr 2023 12:19:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
 <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <ZC8eZ/RTX//0urV/@char.us.oracle.com>
 <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhR06pa2mDwW26XFqiry11Ubz2_3YKj+ayftu0JdYx9m9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::24) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 334ef3be-818b-4ee3-a17b-08db39f89320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlDVgFBq8EjzL+anfgXzoctbcb1zQG7DWCtqoBKwnsnrM6xa877uc/SfnF4SOHFxsdp/HEPBZWtoPyi8EC7I2zpm2ZdRc5kcI5L3XMlfurbWCEAfI6P5COnJMrhW+Uz742l1OxX+Wftf/tBU20ZRTXtRinjFz0bhidRIOj+surqyjzkUjH2ZKGycNOm4fwsOCDD6okTBxr8N5SF40l2/MAMR7BZ417e+fijAMFm8VfOYJ33kORM4Tt/nSTERLrNTHWjyHleA1so0C8JvDz7PD/PeKhuCt65J3yNCmRQoZnxGBPGpDmxkRAax/QkA0bVmvWtj1wqGRxJGSYOZmc5tslRZr3uAoLrFyHQmOWSv+vW+ptxi7iDiGg7bDlPAqh5dItmFFwklxL35a8WRN8+BIx3ZtiKlx/CpphyDUD7l1P3j3NZSns+yXPEJLMvCpnSgYsg76mjpkYKe5oj22vuUW1cmfI0ee0lo7mKSoEq46HNDF4eKR8se1hXN7l51O5kqlCfMwv8fD6E/bcMjwWyudD6PNkMWMceGRQ6/Dy8rYvOV0jo5x/aU6A4p+O9wkZkaJFcXegYoOiSJLi6nkKYokN1mx34wKsxgkasrnpGF7QGew+GL8Vk9ApBC+1tkZ9H3mr/UjlotS2g4raQcvQjrhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(41300700001)(83380400001)(2906002)(5660300002)(31686004)(2616005)(44832011)(8936002)(8676002)(53546011)(6506007)(26005)(6512007)(186003)(38100700002)(36756003)(6666004)(6486002)(66556008)(66476007)(6636002)(86362001)(316002)(66946007)(110136005)(4326008)(54906003)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldIOUliYXNTZ2NHdHErMmxaQml2SXVvUkN3Nk9HOXB2d3h0UzVBQkxBV29h?=
 =?utf-8?B?RGxwZ3l4Lzk5RWJEYnFlRU9DbEM2bThQM2ZSZU5oemQ5UHVzNGdGN1EweE03?=
 =?utf-8?B?bkpyZUtkaktyb0NNeUs2Y3d3RUYxWGM1Qm5BQ1VYWUs4M2d6d3NvYlVGQ3dp?=
 =?utf-8?B?YmVKMnc1aDV0NFRoMkgvWjRlVlh5aEVqU0JocjM0TzlidFpQN0hLL1ZXNUpq?=
 =?utf-8?B?YVF5NDBRUGRSUjZydXFBeDdRbTh4WXlEVFdCQlQzbjV2YkZmWDhJdXBieHJN?=
 =?utf-8?B?L2creFdsMC9BQm5aYm9HMENZejl5dXNzZnIxY2l4NnprQ3QwcWpEd0ZtMy8x?=
 =?utf-8?B?RXBXMUpRMElTVm5wVGwxMHdEQlUvODZvYnl3NHNaK1Uyc2dwQk1UcEpSNHBz?=
 =?utf-8?B?QS9lQTdQK3habkdlVHV5aUxKcFVUOGp3a1BOdFFaVFZacFFYbFdYQkpIbEZ3?=
 =?utf-8?B?d2hKc0RCcUpOeGxEdENnWU1lNzByODFnU0tCSjZ3VnliZFJhVEVSUENpRnQv?=
 =?utf-8?B?eXZVK1RpRC9lNURjUkdYMWh0dXhzK0VFTzBzdmRPZHdrakFXSDZRR043SjlE?=
 =?utf-8?B?Ti9XR0VTRmtWWVdHQytHd2pTWXlETlNLc041S0trSjZ0SUZ3T2M2cWc5dzJq?=
 =?utf-8?B?MHlnYlRmM0VJSXpOcFc3RWhDcWxiVkJyejl4MldlTVJUOURhdncxeVFLZFVJ?=
 =?utf-8?B?SWFTcVNQaWhiQmcwT1pTR0VrRzFkRXRUOHRJZ3pBOG4rNWFlV2tvUm1FU0tr?=
 =?utf-8?B?MjBrMGJadU5qOGVUWjEyYWtFZ2s4THdXYXo5b05ieVZKUlljZU9lMXpySzl4?=
 =?utf-8?B?T3ZvWlB5aVBydTlwWkxFWTd1S2FIN1dqR044VGg5aWtVQ1RLVVdhQzYxNWQ2?=
 =?utf-8?B?UnlkVUd1dEZPTlQ3SjZPOWYzdXU4UnVtZ2Jhc1ZhT1ZqdmUxWE50cVFGVVV6?=
 =?utf-8?B?VlpzRDlHREZZOVNsVkVLZy80MkNVc3ZhbTArSmk3UmRyVFg5T21ReVVSUThZ?=
 =?utf-8?B?SHVXUzM1aFo0ZlY5TE5hZkxUV3lSSThobWR5ZXlGRXlnMjFpZ1NDNW82VCtj?=
 =?utf-8?B?cW9oRFNuZktNZytVV0dBZzhQajYwQy91dzhSMktieXFjYTVYdUhtYUI4WEpv?=
 =?utf-8?B?TndOK05Sb09CbEpzK0NKUTQrMWVwbm5JeUIyek8wbFpUS0JSdXlvT0ZWRlEw?=
 =?utf-8?B?VGdTYVpNNTB5OEorV1FYK0ZNWFZ2UkVvbitpa014K2p6ZzFtZ0M1VUg3azFK?=
 =?utf-8?B?QkRWK2laZmVVY1QzYUJJbGFVdzArNUsreXFOcmFRcGUvamFXUVphUXUrOVVa?=
 =?utf-8?B?UXZQRkZjVXJPNGVTWjlUSG8yaHc2cmdNWmhXOGxVK3gybUFGU1l4TE02NlVo?=
 =?utf-8?B?cXZJL0xrZW51N3NhZTRuYUYyS3RIYXpzR2hmek0zdUU0U29NYWFLSDNMbmVZ?=
 =?utf-8?B?WWdmV3JXOWYrclJMYXRaSndvcURhOUN2cDVMT3VkZHdBd0hFcnlpejRQTEVT?=
 =?utf-8?B?Tmtjak12WGpHRUw4bDd1TExBRVVCMWE5QXdsN2RZT2NRZE9ZV1I4NGxHajNK?=
 =?utf-8?B?RjJBVWRVRkg1ZisxdC9vU0pqQVpEb0ZDNGE5Q2tRa2IxcGl3d3RLUnlKRGlt?=
 =?utf-8?B?WVg3UU15NU5kNEZBVVlQZmtFUGxWL1NnYm9EMGZMSkhuZVVpNnpFbFF6VGdF?=
 =?utf-8?B?RWhUcEdkaGhUS2xzemE3MVJSY05WUGlWUXN5T2hjWlBCM3JuQjRBcHVESDRG?=
 =?utf-8?B?UkZpazRhaFMwK1VkS1NPM2ZqeEhkR2xEbnhqUFBYeWdHS2FienBnS09JWEFO?=
 =?utf-8?B?SzM5Z0N3Y1Y4a1NuYllHSWE3YWh6QnhGblpEajJHK3Z3dHU2NWhiZXNNNm8y?=
 =?utf-8?B?SHZzMW9KVXdsNFl2UitDUEc1c0FqUkxjNXRBUDhvSDRic1RXOFNJdndJWW4v?=
 =?utf-8?B?ZHBTQmt5OEdmMm8zVlU2cm01NHVoQWJ1U1FndGJqVVVlcGNPd1VUTWp1Nm1s?=
 =?utf-8?B?OHpCUDdKR1R4amxoTzA3dEQ3MEsvZ2NJVkExaS9zWTV3SVdweGlPNis3dnFR?=
 =?utf-8?B?NmlWWVcxSFFFM3lPajBUUTdUaitRZnljVjNXcG1nTnBRUkV5b0xVejNJd3ln?=
 =?utf-8?Q?vetal62FpQL+m8sR/aT0PEnpb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yi2cyLu0FQ95i7BS5sbwtmlopeD5Kdyf5OK4Rz5dYyGT3sGs9MRmdxNC4M5wOz+pYslBC6EDnLWlHivXg6Ons3kkNxkwHP0yAqGPasJwtixhL2sUgkBvRamIAdD9IL9Yu+4xKXvITshkya10z5QWBu9BfmZvvtYSdXhHJEauFEtFPlpJ9TsVxXGDFvRNC7dE3IkX7OYy+5X71NXSMQt0mxVxGXkbWiCck5EuY+9/1i4j22J4CokYEGP7w2LCBsaAT1sXTzz4JYFnWRBtJad+NhWBnI0AgfefReUFzVAN5BN39/QZ/26B8xHcPT2hJ23hvfIY7UuT/LeBvujMGaTa053A2hNmBG0uN2SZ3j1+9wWHtyHPZVdkSI/3wRou6N9aEZdfN2L2+3joQXp7c0PSTGGGWFCQJFn/7B3832/68OefszMrDivopiu+EBQ6MG4dN3yGWkStbRKs6anoFi3Fnv/XQenqMHRAZu/4Z2loStf6bbc5owTvHbPygCQW3aWa0EhXF22BD6oEiDH4rRs8NJbFb34fGwgWV/sRXmhPfLoY/L/1QoltF3NSrFN7JodFAn0ZpfjqZ8123gK1uP2Ox3P9XAumbr+uqLbiAlDVjmpRtNAMcNRgy7WgGPFIlOsgRtpYSHlbdCf2AVFJ61AAERXqcFuSJpPmLaueD6TrieLBoBi5dKmWXKLOLwkdRFwy0yW4BUxw5bS8leFrfM8Zl+aWySwBLv7ISU/5ruesuhrdxEe8VGOnioPDQ/6b2C5VJP2t04tVZnAWijiNtHT+JYAWTkTNTQb1r4RXdjvO2Pwy3deB9D5CxsW9aM0hGJm3cvP6g4IQe9ud4Mmi+xafY4aKQ2l+igHap4o+h7PZFR2fDVbNAaPZTaox2zXb+vBZhgFOD3luyDc2cWAR4u9RpZT+5oDAOVS5T81CvuT+SuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334ef3be-818b-4ee3-a17b-08db39f89320
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 19:19:58.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DYyGMb0WsY+OB+dRcy0AoItAkMMb7YPka/Dcjmm3n1bE5Kc7DI9CxPK9Ju+AAWw8lMmdViqxNjIDdp4Sc2JvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100167
X-Proofpoint-GUID: FaLvYIySXSjCXNxgl9dy-dF7f9cR7Ncp
X-Proofpoint-ORIG-GUID: FaLvYIySXSjCXNxgl9dy-dF7f9cR7Ncp
X-Spam-Status: No, score=-4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 2:43 PM, Paul Moore wrote:

> On Thu, Apr 6, 2023 at 3:33 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> On Thu, Apr 06, 2023 at 02:39:57PM -0400, Paul Moore wrote:
> ...
>
>>> Before we go any further, can you please verify that your issue is
>>> reproducible on a supported, upstream tree (preferably Linus')?
>> Yes. Very much so.
> Okay, in that case I suspect the issue is due to the somewhat limited
> granularity in the lockdown LSM.  While there are a number of
> different lockdown "levels", the reality is that the admin has to
> choose from either NONE, INTEGRITY, or CONFIDENTIALITY.  Without
> digging to deep into the code path that you would be hitting, we can
> see that TRACEFS is blocked by the CONFIDENTIALITY (and therefore
> INTEGRITY too) setting and DEBUGFS is blocked by the INTEGRITY
> setting.  With DEBUGFS blocked by INTEGRITY, the only lockdown option
> that would allow DEBUGFS is NONE.
>
> Without knowing too much about blktrace beyond the manpage, it looks
> like it has the ability to trace/snoop on the block device operations
> so I don't think this is something we would want to allow in a
> "locked" system.

blktrace depends on tracepoint in block layer to trace io events of 
block devices,

through the test with mainline, those tracepoints were not blocked by 
lockdown.

If snoop block devices operations is a security concern in lock down, these

tracepoints should be disabled?

[root@jubi-ol8 tracecmd]# uname -a
Linux jubi-ol8 6.3.0-rc6.master.20230410.ol8.x86_64 #1 SMP 
PREEMPT_DYNAMIC Mon Apr 10 03:33:56 PDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@jubi-ol8 tracecmd]# cat /sys/kernel/security/lockdown
none [integrity] confidentiality
[root@jubi-ol8 tracecmd]# trace-cmd record -e block:block_rq_issue -e 
block:block_rq_complete
Hit Ctrl^C to stop recording
^CCPU0 data recorded at offset=0x9fa000
     4096 bytes in size
CPU1 data recorded at offset=0x9fb000
     4096 bytes in size
CPU2 data recorded at offset=0x9fc000
     53248 bytes in size
CPU3 data recorded at offset=0xa09000
     12288 bytes in size

Thanks,

Junxiao.

>
> Sorry.
>
