Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF376B5DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCKQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCKQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:11:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB712E810
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:11:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32BDOqr9007563;
        Sat, 11 Mar 2023 16:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Wi9yiwMBSxjtLy8cndYA8XiMrgB2QqG+hZf6Q8xu1I8=;
 b=cY7CHNF0vnBwHjoT2fI0UXS45fed8yZaOOL7ZiIisqVTQ1V/5V7PGy9Axb7/J1e42Ap4
 LeibHwZDTVEwR5A2ABCz6Oc6+vD7Cd0Tth8Kgr09PSXZA62OGwi1LN08DBF6O116iENs
 r9ThU9IuZiVdzmlnD+BqNdc8h45X60AcKt0nOtG7Km1Zq6aP2Ola/IzfcUw6si8ASTIz
 tsJ99M/E68QH1I/+m7vaQITq/KsA6JzJcoOyBLxrX93M9wwMEukgm4Gr9S0Oglfpk7VS
 jfO90NdzhY6jNqjBL+MF6pWgJEwrxUUdHBMl3HVe7RkujaBGiR7k8F8MSPQFxFO2eeLM KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u0g0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Mar 2023 16:11:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32BG1XnN008160;
        Sat, 11 Mar 2023 16:11:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g32xm6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Mar 2023 16:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP7YfymcnAwy8XK7i1LwjaNPLetfi7miKE46+X1CaX0qaV4zpu9aTAEhPKxm/NFvEQje7tyFzPgb1sfDajPOFNNrbb7nqq1lyXln27PpPChS+Zz5QOo6mD2jqww1qlZxclnUBkfNV113XPaygpioxnUJ/3y2au5gqTH67adfwyBKmlttBpsumF9FcBoWzOSJt8ABO+jqwgkAwxCK0KlpkSwf3siN/AfM7isZTxcIQ5Z5bxZ1l1YPAsd309UwtyfagnPagTd1fYi/dtTkAuuuOJqCNnAG0FFwtrQMxWwYa8KUh3iVddN6xm/U3iJbimdgzgVCp8MbQ+GP8DZTFt1TKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi9yiwMBSxjtLy8cndYA8XiMrgB2QqG+hZf6Q8xu1I8=;
 b=KTJt9DlYq5a78PeOQE9WLAR0RampktPMw8oREXhHg7EVz7N3E061XYOd/ClinOniK2/ua8bz5ZhA5bTq/EO+xRZN9y3WUjqVFXzoJyjX4kfJgo2NX6kwbIvmHtbMTIzer4KNYAxoKP4kP0ffvWlVcCGnra6OShPAg0salgTV0SVCIP/+Nhb4wRzmxcOIEQD9KWz4JG8qsq5K2EVbP/e9VNUZWTjObErf1gLIfs3/S7rJcHL5Pd4M3UWUw4qTHgyHLqBPqyQhTJaRv1TDcK8bXyxH0lcouW339E820769aOs06yCEQ0i6AROPM0G2O+FcrtFvJ1NrFJIACvDQR9y3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi9yiwMBSxjtLy8cndYA8XiMrgB2QqG+hZf6Q8xu1I8=;
 b=gWHff9DwW7S1pK2ZFzfWRoKqTNnx2r9cOACHUHkOv01EgocOK91Y7CC9n5yGh6ZGTALGrk60kkzsrKgs566DWwUaIIvG7Phsxg9u1l/zolQv0bQJ0yyOXdbGYjd989uTgKjMHLKcdZfQhRJnXMSpd1Tv2J+94QYx1SAzTkehxiE=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Sat, 11 Mar
 2023 16:11:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.022; Sat, 11 Mar 2023
 16:11:29 +0000
Message-ID: <74a17cb6-9dcd-749b-5d06-b2c364d36ae2@oracle.com>
Date:   Sat, 11 Mar 2023 10:11:26 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 03/11] kthread: Pass in the thread's name during creation
To:     Christian Brauner <brauner@kernel.org>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <20230310220332.5309-4-michael.christie@oracle.com>
 <20230311085326.m7aub5duy76hnnam@wittgenstein>
Content-Language: en-US
From:   michael.christie@oracle.com
In-Reply-To: <20230311085326.m7aub5duy76hnnam@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:5a::29) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 89be88ee-70a8-4125-f97d-08db224b4599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LA9BRD2vDRrx6NNdMkeicB+83qr7jZpZmPCPoQcH4hDkzGylxnjXDclyeIryUgkdmV5bobD0Dhh7BIFRLJopt1oQXEjM1IkduPhWfwoYUfPrqQetHbDqct4cvUPeymDO5lx71/1fiTokgbPUrDONtBcZ/Zar1NssBjuCOVNHbx/6WeAGTS/48EMi6JPl2qdJ1bzHKGlzB92qCCuXHHQtXhV/ubGNyMsrJ+Qa0ERGDVGPYLVs/br6ovZkLgvoYsTpz99KGvBaCCmmUNq5AXQUVVhlUFPo/yHQhhV1wDHsjOPdgnzre6VKCL59HMVsMGYc8Rhs4VLJYqPq/SiIWR/HGWW4R00XysWDYNx8Y0f7FS6EGPAmkfoUYSfQXKFxXqx0GZlVzy77qwcEIz/cgkF6fyq1E9bASN1wAjY8s/ru5cdlQHqcIj956LGAVnyYbtXzMRWU8trZcZjwYke9xlRNIRq/sjmIwdxL9bN7gwOQP+yStSl+C9NLoONPInupscaLakO0kf72c2Vn9m1PY4L145Uf9ygWsPsvZEEXRw8pahGUh33Oag0fcEwyDp0itCVE/tlRJhZDYSoFbbgplCh5Td+HOmzJ0IAK+e7OcSubjZVqzRW0ieu0vFAv1oRTjD6dhYfWXPqaHsss4oIHtwjBp9sUYKxadrd/HpSmyFI5Lpx+a/zlihjHNFZPKqyL4heP8KMi4xuOb7t0C/ZM6UXhyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199018)(31686004)(7416002)(5660300002)(2906002)(41300700001)(86362001)(31696002)(36756003)(38100700002)(8936002)(66556008)(66476007)(8676002)(478600001)(6486002)(6666004)(6916009)(66946007)(4326008)(316002)(83380400001)(53546011)(186003)(2616005)(9686003)(26005)(6512007)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0k3WVlsOG5yOFhweFJ4MVA4MnZmbWRiVXdZR3daU2JyRTZZVjZNVzdOZU10?=
 =?utf-8?B?SHVHVjFoSFIvemlhK0h0ajE2MXVUMkgxSnpFSnZZZW5LTEovT1E3Z2tLSGF1?=
 =?utf-8?B?UHg5N3ZZMUdmTDRXaFJSUU8xUUNBemdteG9lTXhRVTFkVHhDQjg2QTJuNGlB?=
 =?utf-8?B?WjNEeHJudzhESS92Vkd0YnJPQUNIYmdyemxQQ3cvaGdjNlhKQ1k3aUZyZ2tM?=
 =?utf-8?B?c0VKTW80TjdMa1prOWNQZEJBeVZ4N01VemgrY3d3K0ducGRjR01pUUFOY3NM?=
 =?utf-8?B?VTBkcXZxYzJUb2R6bGp6V1VEQmUzREpldFk2MmFBaTQ5cTlMQ3ZKdWs2cHFy?=
 =?utf-8?B?NzNLVW0yYTJoclVBdE50ZlRIODd1UDJGZVVZU2FsZ0RrM0c0cnV2MjNEdThK?=
 =?utf-8?B?SzBXcE14Y082R2t0TGRmTlFaWG01OEZmYXQ0VExnbDRHZEkzVjJnUjArMjJX?=
 =?utf-8?B?MDJtTGppRnhERkxiY1F5dE9vdUZOMS9yY3IzTXZQL0htZCtRdmU4T3VXOTNV?=
 =?utf-8?B?M1Zaa1d3LzJXeUE5VSt1Zkk0TnBGaEZoNUZqL2kzaS82VE1TYUpBT3M3MGdR?=
 =?utf-8?B?QUlFcXJ0akdwZ2Z4UkkzU3o5aGg5MnNaUlVTaElGZUpyemQreFBKYUcxbk0w?=
 =?utf-8?B?bWFrQStScmU0T2owQ3BTbU5lMkpmQmhEcE1FRXhQRjdrZjlPak82T2pFaU8v?=
 =?utf-8?B?QUQxUU8vQnRVaTM5cnlJRU9sT0JMMHpCWHpPdTZkUjJmeC9OeUV2ZUUzK3ly?=
 =?utf-8?B?MjR1dnBVRkpTSUlMQ0x4emNoRFh6N2lPOFZXMWxZK0lKL0FkK2RmS3JjZkRq?=
 =?utf-8?B?NU9xWU1Xb0hySjJrYXE4enMyVXBGYlk5a3VVdEYrMTZEWm9UMnBYU2FOTE5Z?=
 =?utf-8?B?eFFrYUJ4Z3ZQRzR6YS8zSElzL1UrSFdGV1U0UzNDKzM3MWNuQTJOLzVZY3R3?=
 =?utf-8?B?UzJyeHRqQ0VnV0t5ZWZpS09rbnQvRXFqQnFwODlBcGlYMDFUQVFwRDJCTWt1?=
 =?utf-8?B?OFVCL3BsVVJXNHZkU3NCSnoxVkRUcm00eHJMdm1uWml6N1BKUEhUZlpGS2dP?=
 =?utf-8?B?NDBaU1hyY0d5VURDSVc0YjlTNnlqRXUwbE94elhUQ09MOFllaWs1NHNHZkhy?=
 =?utf-8?B?cGQvOTczWVh2SlRrZXB2cVQvb0MwUDlUUGJCRWRSS3ordjBUVzZQR0dSMDll?=
 =?utf-8?B?NFdpUGIyazlHVE43VHQwSmxCVCtseEpOZDhUdDNLZ2d3cmpJWGZ6VVNyeXVo?=
 =?utf-8?B?V0tVRkNJeFEwNExQamdHYVJSNE96OUNsaHVpZUpVVjF5WDdxRHQwWUN5MXls?=
 =?utf-8?B?WWVhVHZ3enZ1OE9ucjVVL1gzSW9veXBxSnkzbGRnRk5YQmhtT3d3M2ZGelhz?=
 =?utf-8?B?U3B5dDgwYWJHbEd6bGZGSkxPVGVjZkVnNGtrYk5ldTNLY0l5V0cvR0kwK2M1?=
 =?utf-8?B?enpGV2xwNUpBa0JuOFR2VktsTU13ME15TlNZWEZDTnR5ZzlUREtLL1pabW1S?=
 =?utf-8?B?ZE5lS05VaHZYSUlnbVc1dHlValpXZ2JzamgvL1dsQlhUQnNvMm1JT0RTWG1S?=
 =?utf-8?B?aHZqV3BWTVYrOWRPRVlZY3NVbDgyTzdKenplYlZwQ3Q2aTdyRHROMjRwTFJa?=
 =?utf-8?B?d29Pd0Z6VFdoVUo3L21KNVptNFprY1kzOWtjRk50eFJsZm83eS9lb2s5cTNm?=
 =?utf-8?B?RnBzR3ZsZzkyQnNEajg2R0hqY1NVZnJLeENTYm9SaFpVUHhqMUc4ampoVFF1?=
 =?utf-8?B?N3JiTjdDTWY4b2d5N1pPMlhFUHh0TU83ODZZY0lxNUJJOHVadDA3cFVORmR5?=
 =?utf-8?B?VjdaMktJUVMrZEY4dE5mZ2xtcFRLQWl5WXdsRytxVGFLU21nd0lVTHVlTmZu?=
 =?utf-8?B?bnBZeWdsUWFUUlUrUEk5QmxEcm1NUzhjc0hoQzNTMjVZQWdOZXQyZmhCejRr?=
 =?utf-8?B?ajByQzExTHRUMC8zc3pRVk5jUW1Qc2w3dkI1MVg2bzJ3RjIwUVpCY0ZCQkQ5?=
 =?utf-8?B?THZadGRRWTd4WVk0SkFpcC9EV3FwL2VoT3REYURWcDJvNUlkTk9IK2hKU3JU?=
 =?utf-8?B?UGIzbENkMTRjVWdXTnlSVXJjSjlxL055ZkUrTG9sRTk1OUdId0NDd2dGaVBC?=
 =?utf-8?B?U0xMNHNzdDk4RStjRHUwNnhnbVY1NFpCelBQWlk4YXZUYVd3ZGY4bGcxTEhy?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUZ4Q3haNkpLWkdvQzd3aWVJR21vTDNkNG9UMEQwQlRzWXQ3N1NRbWdibzFI?=
 =?utf-8?B?cFJxME85bGNZb0pSNmRhbk4vWHZLb1FRTjNwUkNWQ0dJNzhoRjBnYmZEelVr?=
 =?utf-8?B?bHNCVzFuV3gyczc2RXFiN25CNURBWHJUdHhIWStVY0tOQVh5eXZVWUFSaUJJ?=
 =?utf-8?B?RU8zdU9hK01nMFpCRnhOSzU0ZW1LNGIvcUFxc044eWhORmt5VkxiYTRRZWJ0?=
 =?utf-8?B?bUpkTENjNGJ5M1BxejhDSVJBbGtjeklKQnFCS2Z2V1IyQmNzYjMwdFRpdUN0?=
 =?utf-8?B?OXNLWTlVeGQvR2hUenVmbklkWnJDc0hKV2tGcWNPZ1g4QXE0Y0xucEhFUDJQ?=
 =?utf-8?B?djlxd3pqVEkwQks0UHUwSHNJeVdwN1YwQStrQ29BL0Fram5BZGY3Wk1aTE5i?=
 =?utf-8?B?SlBibDJBL0RuL21FWDVWMlhTZ3l5VHlxcDVZWnZveUtObm9aazkxTFBZeUV6?=
 =?utf-8?B?Vkpic3Z4YzBsb2Q2QTZLTUJkaU8yOTk5dW5lNCs3a1VPSWo4ZXQ0bDdueC9D?=
 =?utf-8?B?dFVlVlgzNkdOOUxtQ1RzMnpsckpFcGVSdXlEUU9kSzdudDR4Q3RmUW9Fb29R?=
 =?utf-8?B?VTJ6SFppNjl1N3c4ZklGeXhJWjhqVzYwdjBuUlF1YjRWNVl6UG4raFgwQ3BP?=
 =?utf-8?B?d3BkaStubmQrSkJVRkJ2Q2JYSFZtTkZBRmY1NmIrR0FBeXcxOGNueDJqSUd3?=
 =?utf-8?B?VUVoMFpHOFpkRlgwN1IwcW1aOU1QaGlONnhEOG5TMEJPV0tPMTFTN3lLU2Nz?=
 =?utf-8?B?N21pc2ZXNnBFcStYeEpHWndqK2c3dUpOSE5IWjA4UUpKOEgyKzJrcit2Zzh3?=
 =?utf-8?B?K25zdzFYQ1VMa2JvUnpkM0ozUTVmVi81RVNIb0Z3USs0b1hRenUraVV6V3VR?=
 =?utf-8?B?a01YT1FaMjZDa29ZTkpza2d6eGFQdS90MndQUnh5SnovbjBHTzhoM2NBNFN4?=
 =?utf-8?B?YWFFK2dzYU9GZEpKREE0MzJpYW5URmxMRHR2OWdVcnhVZGpWSUFvcTVXY1lW?=
 =?utf-8?B?ejRjbVpxN0h6MTRMWXVGbHZ0elkwNWxyNFhHenFWd1pUamZtUzJBV3U1TjYw?=
 =?utf-8?B?QmIwU0dsY0Y5eVJRZUMvQXBQOUdrREU0SmJyckovdUlKTEN6NFozNEZlSVcw?=
 =?utf-8?B?M2JsTTlwaVhidjRrRm4zdXNQVXpaZVpaVGR5VkptUnFCVkxOcUp2YmdHbEJs?=
 =?utf-8?B?cmRDSlhXc3VXeDFyUDlCa2VsSnFhZjhRMHRTRmwyQXkzVGZVRE94Z0sweTRR?=
 =?utf-8?B?cHBPS29uTFFXOGpJazBnTVBtRXE3cEVhKzhubzI5M0MwQWZSbG5mYjZZMDls?=
 =?utf-8?B?QmtkTnd1V1ZuUHhqbzlRWjFud3V2MS9EcjRaWG9JdldMcEIvQllkcXVEVTlk?=
 =?utf-8?B?aEJvVVo1eThNb2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89be88ee-70a8-4125-f97d-08db224b4599
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 16:11:29.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEW4tYvzumqPKe1YIBFZWpls3nd+nfumqv64MNhBax3XixT3b2GwUWHPldjAWbibRPY5xxx+TEFuywlVXBEI02kGcSnHEP0J93e8MjJkqRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-11_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303110146
X-Proofpoint-GUID: 0-tlBm7_auJbzo5ionK4l_WjflC8wIiy
X-Proofpoint-ORIG-GUID: 0-tlBm7_auJbzo5ionK4l_WjflC8wIiy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 2:53 AM, Christian Brauner wrote:
> On Fri, Mar 10, 2023 at 04:03:24PM -0600, Mike Christie wrote:
>> This has us pass in the thread's name during creation in kernel_thread.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  kernel/kthread.c | 35 ++++++++++++++---------------------
>>  1 file changed, 14 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 63574cee925e..831a55b406d8 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -38,6 +38,7 @@ struct task_struct *kthreadd_task;
>>  struct kthread_create_info
>>  {
>>  	/* Information passed to kthread() from kthreadd. */
>> +	char *full_name;
>>  	int (*threadfn)(void *data);
>>  	void *data;
>>  	int node;
>> @@ -343,10 +344,15 @@ static int kthread(void *_create)
>>  	/* Release the structure when caller killed by a fatal signal. */
>>  	done = xchg(&create->done, NULL);
>>  	if (!done) {
>> +		kfree(create->full_name);
>>  		kfree(create);
>>  		kthread_exit(-EINTR);
>>  	}
>>  
>> +	if (strlen(create->full_name) >= TASK_COMM_LEN)
>> +		self->full_name = create->full_name;
>> +	else
>> +		kfree(create->full_name);
> 
> This is monir but wwiw, this looks suspicious when reading it without
> more context. It took me a while to see that kthread->full_name is
> intended to store the untruncated name only if truncation actually needs
> to happen. So either we should always initialize this or we should add a
> comment. You can just send a tiny patch that I can fold into this one so
> you don't have to resend the whole series...
Ok. Thanks. I think always initializing it would make the code a lot easier
to understand and be nicer.

I don't think it would be too much extra memory used, and we don't have
to worry about some random userspace app breaking because it wanted to
configure the thread but the name got truncated.
