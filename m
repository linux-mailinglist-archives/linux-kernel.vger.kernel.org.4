Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895546EDA85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjDYDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjDYDNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:13:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B75A8;
        Mon, 24 Apr 2023 20:13:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P0i9kg016472;
        Tue, 25 Apr 2023 03:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wWQKbq5M9gabIqgrJVZiS2OSbzRaWngaStK4opC6fhU=;
 b=jWx2hOfJ8e/WW586QcaQabi6cQCtBJwLknZwP8GKFQ1iwVLKlK3eNFVS2nebgAPDY6b1
 xKBOVx/fmdFwnnIF4rHkQA/KAcbGr0l6dDMtU5yO5M34Gk5Y/1VqmkpW/LpZnRvgsbYX
 ig8KNAhZRp9WyCzdF84AIgeQWl7auhf0DGj90KBKHzMGjup4u682Y0Wh2o0VB0s3jeSa
 BxXyeRPrd+rfgdt5nkQoUzJlg8vLEqhfmcHkr2i70l8Wfut1vIdJ23WtiD7iGF58XTGD
 hQqnAwrKC6FLsUuTznsSt9/IrFoCcMFhx8U0Hkw5LHb+xT7AFQ7qKDKb14QND+t/u3lt bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47famb0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:13:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33P1gxnG008754;
        Tue, 25 Apr 2023 03:13:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461637b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 03:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCaEPz2/IbFm99DwqI5bqV51bdVONPZIN2mMi5NomWUCnVJCOC7L997oOcTtGpSrbHdWgiEtnlng38uSjRE2UzU7krBxOrjVqzE0GW2ZVYQK8Pb112smVy42EqjvpZBOndxOEB85JUxA4l+B/Cmqv5KmfGS0PXMFrkzOM7FWPQ1YDgPHwxdy07oZFwHc2dSYAZ28B0f1BSrLulzfsIkNvZrLaRERNxtLs5wEXzEhIvis7NmbAkC+6YTOaRw9mJzX7Kz3Y5gheRKzeGDrOWTRIIgCDhCySD69TtQ+cxS5kj1cFXqcT+hHwH2/xWUI8VRohsGzatlZtu2apW638IC5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWQKbq5M9gabIqgrJVZiS2OSbzRaWngaStK4opC6fhU=;
 b=DiQ5mNkPLzve6C9X1ZziUbrPrYQ3GmgdKGuZ9wBG4HdotKiz4ROsMyBEIM+UXPjUCGk737YQJqwf9AmSqV3dgiWWMrUvYPaNDBhhIYve30TYhYtlO+mHHYB0cOcOADJupxZoisXbxXqDRWV7BpQcNzrhdtCx83uiNAhMFUPMI73qp+H2pIkY6BKHaqRkcyFhTYnXpD91eP6e19pLF/cDaLJAuhXPloEOXN9a+PPozMZEVqQh1vHGxS33amXJ0WfZNyWAjj2PTVC6zVGAP6tlrcs4MA78jCyaAkeya73QNxyS+vx02rb0fdsLLYaxiN75EGm/5KsMfJ4aTGx/tCHr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWQKbq5M9gabIqgrJVZiS2OSbzRaWngaStK4opC6fhU=;
 b=EN1R8KmNaMdbN3wesMAQlPGTgpvkuGHCb8Z3V1GSdO5T+GKknE56P/DTgGlOoUMifSVeXOTi94iNPxFLJbSDTThoFgHbmGGY2rn8ZeR6WBX9xNETv6Cv8XDlzHO9Ntln25s5UovFq6I2APypxN3RxjegzNGDSABFB6fXW+DYacM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4152.namprd10.prod.outlook.com (2603:10b6:610:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 03:12:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 03:12:54 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     brking@us.ibm.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, dlemoal@kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ipr: remove several unused variables
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn20k638.fsf@ca-mkp.ca.oracle.com>
References: <20230420125035.3888188-1-trix@redhat.com>
Date:   Mon, 24 Apr 2023 23:12:52 -0400
In-Reply-To: <20230420125035.3888188-1-trix@redhat.com> (Tom Rix's message of
        "Thu, 20 Apr 2023 08:50:35 -0400")
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: ccabc4b4-bc06-475f-6e46-08db453af61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKHAXVzjN3LEQ0CfkKBFeGyQFhQwbCli0QyZI3pVNXi4Co+ft7Dmw9UODyhjlUL5SyDaAKMdzga0LmQKi/D7JbRFRExyEjHGtNJ1k2nfwKLLXzKC5maiIGHciAQ1XdXcRJkbWg+wKiMvV6nD+cTtYRJcnkI7B95D5IvDOogYD5XR02uUWLBYEhq8B57dCPgPKTj7kiFWw6e5n0vVurTesj8sP02+oKLYlMrbLLM9aElofBnGPtZ0gYcwkvHVe9jy/XOce8kc0C+FDjxXpXBGOYUtAIHpHGUhvq78S9gwSVqwV1Ik2A10BsC5GbyuKzuwUMvaVcZsiEWfHA08RTsMnX2EfIWitk5HDlV1e6Tic1810tWGxzYSDtspEqMkWjTG66xPJzh9PLC/dXqvZ13Ds+6PBupqQemKw0slNvH5IlA763MHLV6ac86unv1S/zo1LwfIvO9Gslid7b0y7vPTXNGOa3bBQxChyvCA74ld/UwvRchRHFfpxmKVMYGeP7Yc9oJfjA1aXn1ZAbCdHWGiJUJ6zvaCeK9zGVrXHAzrqCq4mYX2WPd1ViBz0+ipebTX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(38100700002)(6506007)(6512007)(26005)(186003)(8936002)(83380400001)(4744005)(2906002)(8676002)(5660300002)(478600001)(6486002)(36916002)(316002)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWN1dHVKd2dzTWsyb3hScjhQakZwbGJsNWVua255VGFjejR5VUlNQi9VZ2x2?=
 =?utf-8?B?bWVMbFBPZGh5TkFGTlZhVnQ3bFF6b2ZiR1lqcHdhZGdidG1zSU9MdGNvaERS?=
 =?utf-8?B?TWpMbWczR3d5dkh5UE5ZVmdXc1RxTFh4K1c3Q1pDVk9zTFVrd05OL0xESGp2?=
 =?utf-8?B?TElmOUc2Nm50RWF0Tm1wbmh3UUF6YTNSN2JLc0VWQXRZa3hVZzc0QTVpeXZL?=
 =?utf-8?B?TmpaU2E2WmNCcVp1Ymg0TUgxMm13bWE3a2oyNVFtdjFMa0VPWUo2QjdYRlZ0?=
 =?utf-8?B?YlhSNG1tL3JJckl1eWdPWktzU3BTOCtEU1pRd1FGM3k0cmxGQ21hR083MjA0?=
 =?utf-8?B?Ly84UUZha1A0VDZaVUx4VkI2dGRsazNPMm51Ni9kWExYMlAwbktRZ09wdmc0?=
 =?utf-8?B?Yzd0TUJtVFZIR3NRQ0cvSVRiTEJhYWlXcWZpUTNxdDVFYUdOQVJhb3FkaTlI?=
 =?utf-8?B?dDNuNXR5QkhVVi92WDhwODFHRUNwNnJwRTc5RHhqcmx3RUFzOWxjbG5xaElm?=
 =?utf-8?B?K0hxSEFOQ3AwNlhQaWpwUDB3RXRuUEQrc3RrRlAxUmpkYWFIN21FeUQzMzcx?=
 =?utf-8?B?ZTZIV0RhczlkTFlsVjF0VTNyS29ZN2Q4S0Y5WUlsMjdGMXVkbmRpdzBLVmh3?=
 =?utf-8?B?bEtZYWc2cFk4czlXVkUzY2lONm4rWkVoSzQxVnJiSUJLZ08yK3hhK0tSUTA3?=
 =?utf-8?B?REh1QXh4UnhIRkN3eThkSTR1d20wenNwWVJ2aUVnUU5MYWxnQnJWZ3VOZVlv?=
 =?utf-8?B?dUszU2EyM3JOSzB2RytWK1lzWEkvRzlyVHpSbDFDMDJMNGVFclZTRXl6YjRS?=
 =?utf-8?B?aVJqbHZ4YmlZalJFSDk2Z2xCU3JSemcxSmRPcXYrcnBUMGxOTGxkeC9qam9a?=
 =?utf-8?B?K2FRdlNVK2VlUXA1OW0zYWRHdnM0MHVJdy9rSlp5RUI1Ym5mSDN6TXpPSUR0?=
 =?utf-8?B?ZnErcDlEMkIrL08zM0dFRUNKTG0yMXZrcWh0cTRXZTNESVU0ajkxS0o5S216?=
 =?utf-8?B?RzdWdWVXc2JjRTgzYXUzK05hbGxmVTFhaEZmYXBRMVNjMklGNk91dk4rNzIx?=
 =?utf-8?B?VWlITXRPd0RrZEFiM0h3VE1Rdkdxa3VlL3BqNjg3SlZwbGVMdXNILzNWR0Z4?=
 =?utf-8?B?WlNYZCttVlhubDRxR1ZPTTBUVmdnRjNnczZXTHlleGNMeUhFd2hTQzdyOEJq?=
 =?utf-8?B?MnNySjJuYXRCU2hIQjdNN1FKd1dkejdGUjRoclNSR3hJTlFBU0l1UndUdEpw?=
 =?utf-8?B?eUt4VjU3MERrSDljeHBtck54dWVEUHl6WUgwWHFjSGlnWWRZNWhGYUNWdW55?=
 =?utf-8?B?RVFLeGQxRk9wUC8rYkFNSzJsNkowcFR1Rk5OejBzckRSZ1A3U2J3ZTBzZHNt?=
 =?utf-8?B?RVFiZjRya1pEbHVHZ1N4YjRmcndEVkFtKy9OM0FxNThIcjFwOTFick1BcFZQ?=
 =?utf-8?B?M3B5OWl6NlkwTDBKQ2lNK3hXSldkT1llSGpFemsyZG9zTjdFRGhNdFNmeGpj?=
 =?utf-8?B?a3hPM0pFTmlOVEI4ckhPRjBKS0ppSGt4UkVGcFFRa1prU0VRWmpBRFc2ZW5w?=
 =?utf-8?B?dHNrTThQOUY2dFVUaVBrU0FuTlVmVlU1b2Rmc1l3a1JpaTBOZUlhL0xLblFX?=
 =?utf-8?B?c2V5azBtZDMvRnpuRncvMFQ2NWd6ME9SRkI1dE9pdjJkQzFmVG12MkdzUzZC?=
 =?utf-8?B?NndVZGxuaFI5SjdIU3V3VURzQ1FvQTN5UHAyTEZ5cm92d2Z5bkxNUmQ5Tytw?=
 =?utf-8?B?dUdPcmJVVVlhNzgzWk5XSGtwNDVTbWdaQS8vVzZtamtNeWpvS2lveFdpV2ls?=
 =?utf-8?B?eVNac1pjWWlkSEFaWjN2bFRtTXJGc08xZEUvcTJPSmg3eVJRU3VRWVBlQ3RW?=
 =?utf-8?B?Y053NmxiMjlZSkZFM0s4dHhvbFQxUEhJMkt5K3pCZmdmMjFXRzBPSFcvZTdl?=
 =?utf-8?B?ckcvNTM0TzVVelV6Z28wZ0tHTEFWRCtlK0pPQzZMQ1ljVUMwZ2pDelpRWVVW?=
 =?utf-8?B?eWlPNTlGM0kxU1B5NzBzZDdZU2ZjZVdFNWFEZXNYL3ZHSC9QWVpyVm5RUmN0?=
 =?utf-8?B?Q2NkdTZTUk0xdFNybVd0SDdpR094NXMzSFczM3BzVEFUMGNsWm5DaW5Vc1V5?=
 =?utf-8?B?VXoyNHAxempzNUFWZmorRVppM1V2eU5XV2JBQ3kzanN2V0Vyays1QUZWempa?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fPz7Ikx22EcIZZjs4dnPc39ErNCuwzx5wE9a1ePZgyPxTVIOFyV80T9XoX81FW5CT5KhXED+7UxHz+ORr0sH3dfex0xumwvL5MZCyk078rQGpTuNcSWgBjUudNjhydyX79d0iUX8MTDKlGE7RHV/wxfpyIJXn18JXSwumR1Z6ezBvTGMmyTTLEaPV+3b4ja6rONgmlOK0ikDDJIEib1pRb93VGr28bhT23zC7CHvywpldXNNQkEAXBjsFc73is1NrXbnoOS/ma+rzbWRa+cc9dJuhsbKYMq75hpcpg+pFK6vyg+GrzVWd2i9UaKUXbVvUn4T3SOil+3C9omAwWvDXduuU2vAIDG48vdwnaqiLdmNBu8gwBGakAHFxoD6NNz+8ydA46k6R655uVsZrKJXZs15Gmm0jWUrh0UYkxPq5XU3OlR4dHB57JpaWXhLPjYy/2zbAHXMINugpRzpaYlaWPQe2kamrqXrJs9AcApeMOgTDnfUOd4xk5JM6AHx1dZWV2WZLDIgB7WgovRdunRfMA9zaEOTKoiTvxd7dcxgcUMAfNgCxgmSCOCxu88P9p96z77aH1ASyvnd/yPaDg+1kDVua3l4SkK6+HDOwLdGNkAjh/Bx/cR3cfhp/B3DzazJryc4slD5BFhTweuAoZPg+sbuNmaASoCY5MaIUclEBezsveKvsSpOqskUyzN4LcYAdtlJVw0vBQYHW3MPtSPnepifddE2JkgyNDjP7QKCuQ2fJ1sYz5ykC88KZpslswc1ZYsg6NZcfe7l/SZnV+vXySl523Npibc5jFDSgi9ehmWIbOMc83aKAQ1nNAlZJVwmTQ3y8oQGa6+zEb4FzKE/gRO6jIu0K7fD3wN4K5YfRVrqNNWi3xkNJ8miUNSO1MQj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccabc4b4-bc06-475f-6e46-08db453af61b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 03:12:54.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeKkSAlsbaGJj8q2oaN0wx7yfMaHz6g8FXbOp/Y2EodNFL4+DlhDEPoxIDrzVL8z29jqK3jibnX+EEvcsyNk9J2yL0i9RdU4UFAeaD8aWhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_02,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250028
X-Proofpoint-ORIG-GUID: K9XF2b1xAZURhNNeU0IVqE2GxdOAe1_t
X-Proofpoint-GUID: K9XF2b1xAZURhNNeU0IVqE2GxdOAe1_t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> gcc with W=3D1 reports
> drivers/scsi/ipr.c: In function =E2=80=98ipr_init_res_entry=E2=80=99:
> drivers/scsi/ipr.c:1104:22: error: variable =E2=80=98proto=E2=80=99
>   set but not used [-Werror=3Dunused-but-set-variable]
>  1104 |         unsigned int proto;
>       |                      ^~~~~
> drivers/scsi/ipr.c: In function =E2=80=98ipr_update_res_entry=E2=80=99:
> drivers/scsi/ipr.c:1261:22: error: variable =E2=80=98proto=E2=80=99
>   set but not used [-Werror=3Dunused-but-set-variable]
>  1261 |         unsigned int proto;
>       |                      ^~~~~
> drivers/scsi/ipr.c: In function =E2=80=98ipr_change_queue_depth=E2=80=99:
> drivers/scsi/ipr.c:4417:36: error: variable =E2=80=98res=E2=80=99
>   set but not used [-Werror=3Dunused-but-set-variable]
>  4417 |         struct ipr_resource_entry *res;
>       |                                    ^~~
>
> These variables are not used, so remove them.
> The lock around res is not needed so remove that.
> Which makes ioa_cfg and lock_flags unneeded so remove them.

Applied to 6.4/scsi-staging, thanks!

--=20
Martin K. Petersen	Oracle Linux Engineering
