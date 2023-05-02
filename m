Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE536F3D7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjEBGca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:32:27 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705726A8;
        Mon,  1 May 2023 23:32:25 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3423MBqr001490;
        Tue, 2 May 2023 02:32:21 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3qatj88w4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 02:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcBi3kM+o5Cf3F74fUFcpVQpXBpqQzmMr5mOlTjMKg8RBtIJSQa2f8H8ZQUs0fJ+nkJQqKFehioFb9VMonxv8BZ9GptplrTO4UYOxZxXfPOO0+jrS6a6YOyOLi/cu3C6hXqUdV8XM33DMRWtOi/FgTvGsSvp3+ywxUS4JmhGHJJte0QIhC1njiUvML2FlPFXKqXLSKPFkECq/oTbyHZnWFQZm5+hVR8A44fEcdKDfEVExwxuWzCZ5hn+SkYsPTX5PisO+VZQQ4iu1cU1CC8fSIJgruK1WfuZegzgrfGG7SHJC0aSwR3e5XQ+jC27VnXjfWPcFGo2b/dFuTdgcURJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+I5qQrw+BYUShxEbN2ULiZPH95GvVRBGkrGCWjHg1k=;
 b=nYOWVxKDjOGxGollikW8vrNMFGemjAxTzeE+2bTcH97Q6VkxzDmo4bTdY4YUpWuOJiro8hbSQcPCG+GDw3LiEHhJ4d+CwSNCfTLK2Anj+fCew1f1zPGScrnnQd48WJLjL8FmcBTG9Ue5YSVz5yRg5fnwGlCYNZyFQ1mRRgOK1KUxURqlKfXItsrtJKSqE4HI6nrXDb1qS2jcl/W3NvBxJUbo7HSLnPp4YGvpp47wn/PmWNtDXWVF3UXmFgMspoygs1vMDFTFD1510U5UkNaGrPfrSx72T6aFtWie55H8iY7u0NK/GpKmIxQL3UWG3f7xG1m61qqC9rR0bbxLQNc3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+I5qQrw+BYUShxEbN2ULiZPH95GvVRBGkrGCWjHg1k=;
 b=R2oRok3YN81T3UhfIVI+xJFPA4O2UBaVLPkyhfspdbEh0qUI4nJIA9MwZwDVc7gWKjavpHCkMdj9R+jyXEibqmxYBEhSFThZOMmEQ0GuvQh0rwWxXdAUCOXcoC0kpY0yk678sHxjLNQ75TrMqnNoJZvkfOpg/bbYByTTCGiMq2g=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by SA3PR03MB7234.namprd03.prod.outlook.com (2603:10b6:806:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 06:32:18 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b%5]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 06:32:18 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Thread-Topic: [PATCH v2 2/8] regulator: max77658: Add ADI MAX77643/54/58/59
 Regulator Support
Thread-Index: AQHZXIM8C51C6TXz5Ua0Sg7/OZuyM68Gdq+AgEBJ7aA=
Date:   Tue, 2 May 2023 06:32:18 +0000
Message-ID: <MN2PR03MB5197DF4EEA50D6CB5DF311098B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-3-Zeynep.Arslanbenzer@analog.com>
 <ce89857a-53b3-d63b-c1ad-5d28fd7d8f80@linaro.org>
In-Reply-To: <ce89857a-53b3-d63b-c1ad-5d28fd7d8f80@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFRFek9UUm1NRGt5TFdVNFlqTXRNVEZs?=
 =?utf-8?B?WkMxaVpqUmpMVGcwWVRrek9HRXhPRE16Tmx4aGJXVXRkR1Z6ZEZ3eE16azBa?=
 =?utf-8?B?akE1TkMxbE9HSXpMVEV4WldRdFltWTBZeTA0TkdFNU16aGhNVGd6TXpaaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJakl5TnpnaUlIUTlJakV6TXpJM05EZ3lOek0xTkRJ?=
 =?utf-8?B?ek5EWTNNaUlnYUQwaVZ6aDVSSGhrYUZGdlkyWkVkbTlIZVc5bGEyRnNjWEIx?=
 =?utf-8?B?WmxwUlBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQmQxZ3ZVRloyTTNwYVFW?=
 =?utf-8?B?UjVSV05KV1dzMFlrUlZVRWxTZDJocFZHaHpUbEZFUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2Fr?=
 =?utf-8?B?RklWVUZqWjBKc1FVWTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZ?=
 =?utf-8?B?NFFWcG5RbWhCUjNkQlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRC?=
 =?utf-8?B?WkdkQ2JFRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0?=
 =?utf-8?B?UVdOM1FteEJSMDFCWkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJX?=
 =?utf-8?B?WGRDTUVGSVRVRllkMEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldW?=
 =?utf-8?B?RkNhMEZIYTBGWWQwSjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBK?=
 =?utf-8?B?MlFVZHZRVnBSUW1wQlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZC?=
 =?utf-8?Q?QUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|SA3PR03MB7234:EE_
x-ms-office365-filtering-correlation-id: 73df19ea-2d4e-43c9-444c-08db4ad6fa3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ml8E+wJdu0NeuEruxzyLXn21+0ydcuUvChjN1pjJIcWyX9Itk7VRYsr1z4NqFwEGzcqnkM2Nc2DhR/PDw7RcwuQhfuNzT+PMRkRQPNpgB8NcxpyAVKaYl9/vCEDnScVRJ+np6tQIxpwGzlypR0tEQuJyjTfazLIkUclfmrURPjsLNWoNNyeKFIfF5S+sm/tpamBq6bkpDEcYP3SyG+tTeXznfGSP2acCERwZjwwJwmZew9KvViDOHgYuL6g7ogo4P0KNokLxuknGVnzKRNaDdDAYFLuxFjs1dikYACsVPARHXfgzBsMX5cVtDX9lr6BYVkf4LMi3/k0eYN5leac7wI6ijHf/NyivXtLsuarn+LPhyEDslSncL0WeIBs/CS66RaLBCE9QNAQSwhieDuOUu7NL4A4TYNrR4BowkSJSDZnyNFcsYXtvA2WMPKSjR8bbfOJYOY1R0uUJvjyEdG9UGrfCnK99jHVIPAky+nbMbUQUB07zEXjHXGEndyT5AR2enfQohAKO0lcpyiu/UKXg3NzNYKRsJNiaLPB0KJf2DHl6OGvxkgqGgDweITGhjsOPWst9p+rPP+DHxwz8mS6HGyPP3VQoK6lLS80XAew9ubw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(478600001)(186003)(4326008)(54906003)(6916009)(66946007)(64756008)(66476007)(76116006)(71200400001)(7696005)(9686003)(6506007)(26005)(66446008)(316002)(7416002)(8936002)(52536014)(66556008)(5660300002)(41300700001)(2906002)(4744005)(55016003)(122000001)(38100700002)(8676002)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjMyVmFlZ1N6ckRqNFd1YWFoTXhQOXI4YzJSOUdGSGFJYUFteXdGcVRUZkRR?=
 =?utf-8?B?MHY3ajdFWGhJU1pVRWFiQjU3RTFjcy9yYWs5NU1ac01hMjlQZXMvb21WZzNt?=
 =?utf-8?B?UnNmeDBsbzl3dVhwbjVkUkZHWXN6a2p2YmJyTDJmTWw3NTQvVld4WnZSM2Vu?=
 =?utf-8?B?c2hnSFRXS3YySi9lcHFYUEVCdWhTb1NwRDQ5L01IaVFlLzkvNm0wWWhscFha?=
 =?utf-8?B?MnZ5RWNrZ0JwS2IwWUdFQnEvcWpiakp6b2V3Vk5INmh0Kzc2d0NNb0ExcUFV?=
 =?utf-8?B?UGhRT1JTSGtNc3Y1NFRUcHl5a3FJblhSNjhJRCs4b1BISVRVMXJtbWhGZmYr?=
 =?utf-8?B?eEJOcTdnakovTjdseVBhZFdGYUw1TmdKVkQ2ZlkyeFlLZlZmbURPd1R4cnhm?=
 =?utf-8?B?eUVtL1VmZmdTUjltWmE4V1dBWnhxOWducWFOMksydmdoZHcwSDZyR2NYVW54?=
 =?utf-8?B?OC9uVWxEYXh5Z1hNYTNMdkJ4QjRSVnRHYlpCZjZPcTl1Zk0xeUxoOEsralY5?=
 =?utf-8?B?RW1FN2svZWlGWDN1RytWaElmWllEUWRJZmRySGJlUzdTSXFYeXg2eTlhaDR4?=
 =?utf-8?B?VkJ4RmtRWmJkYisrNWduMytxa0ZUR0h0UVRDNTM4TUczeE1BMHhnNnE2VUUv?=
 =?utf-8?B?MTk5TmtRMDFyUjhnSWpoQnZqd3ZhZlRWNDdDZnAzMVkrczJ3Q3JHN1dQNk9Y?=
 =?utf-8?B?M3FsMXQ3cnhjVUFNYWF4L2dmaHNPODY4UmNhVkpwV0VIOWxzcld3SFNlR0F6?=
 =?utf-8?B?Vno0ZExnMDVqUWFKT1dwWE9MVldaZDd5NTQ3VUcwWE9mditDQ1ppS0R0eVd6?=
 =?utf-8?B?S1BFVFNRYXBWODFnYXRMRDI2My9JU2t2MjlKZE9JQnlYRE0wYjBVTFQ0dHNF?=
 =?utf-8?B?dTd0aklqYzFXblFQRHVZWGIwTUtIL0cxMk41NUEzNHNuRlptRVdiemlyUTZW?=
 =?utf-8?B?eE5MMUtONDc0eEVYdll1ZmdIMjF3WUxOOUFnREFnTmlWK0JLem1ydnp0cHU4?=
 =?utf-8?B?dzE1TWxCT1JIR0I3WDZ1eWpCU2JObUhkVEV3UFAyY3lXQ0ZYOEhSc3I0SE8x?=
 =?utf-8?B?czd2b2VCcHV0VEZmcEMyTHEzTmxpcTl0RHNlQi8xelRWbm1UWmxCVUc3QURl?=
 =?utf-8?B?NndWbVcvNjhJS3hNVWZDc0t0Q1BuQ3IvRkcxdjdHR2pwZnNITndDeExKVTVn?=
 =?utf-8?B?KzFNYUhZaHhiTDVkWDNReGVYVXZVVzd0TTdWOVJTMHd3blV0a3JpdTR3L25P?=
 =?utf-8?B?OG9GM3Z1dHdNUWt4RDFVRXVaR3VjdFZrTFcwRmFwZkFwckNHQ0FiZ2xrTk5L?=
 =?utf-8?B?ZGJQL3NVS3MyN2tUMktKbDl1RzhEWThNa1BsZ0psU08vZWc2d2d5MUpGK3RY?=
 =?utf-8?B?TithKzRqdlIvRlFNa2RLUzBlUWNpVTlNK1pNQ2ZiQ3U4Ui9JZUU2ME1Gb2l3?=
 =?utf-8?B?N3c2WWIrNDlVTDkrcG1OYy9SYzZzMk8yRXMxYTQrenAwaE1GTkdlNDNocXJL?=
 =?utf-8?B?TEVEOUIxN3dBQXJuZ0xzNFUwRnlkQnJPSm9nV3dDUUhGSmZGMWtSMEVJaGRa?=
 =?utf-8?B?Tm9yWWtuN0tTeWpPLzBLbk9VcjE0Q3lMd25DT29jcXdSc3N2dHlGZGhyZUlQ?=
 =?utf-8?B?V3ArNlVjcC9jY3I2UFhrcGNNcHIwZ3hLZTMvczVTbnNRcmNvcnF2WEswQ3JH?=
 =?utf-8?B?ZjVTczVRVkl2V3dtREE5SEJnVytOUUx3UFE2V3R4V2ZTVXlCdnh3eDhmTE0y?=
 =?utf-8?B?SHJnUFhGQlZ1eWtiZy9yZUhDM1Y4U1FGbitvcEZ3SDNUK1lkbGpodzR4alNG?=
 =?utf-8?B?bjhkTkphS09pQ01qS3V3bmFjMzRRY1JaaVFTT2l3WEVxY2tiaTNONTNNdDZk?=
 =?utf-8?B?cDBEOTR1ck1kWjVSaENWc1hXUU9ubHphdmwxVTNkSlBEYjN3SWZRMmI4NHlS?=
 =?utf-8?B?YnNwVDRmVWZHNVFvekJSMVRTU2FjM0JXRGlTK1A0THByVDBDMXdsQTBTSWE2?=
 =?utf-8?B?VWliaGlkQ0N3K3NHUWV1eUQyRmZ3Y0NtQldQMmcxVlI4a1N3czhCTFJNYjh0?=
 =?utf-8?B?WXFsdzJBVUhCWmd1UTlxaVcvSFBWV1hhNXFocG9qelhPaDM0UkdGYkFoSk5K?=
 =?utf-8?B?V1ZKWGdHSzIwbG9BcEtJZEJEc3plZnp1RC9YOU1RSWh3RjNJTTV3YVpQNkR5?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73df19ea-2d4e-43c9-444c-08db4ad6fa3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 06:32:18.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLpC8xSP35kIgC8wKODeuuQ2ncl8UE2+FpurY6uSkdZlwI1WgxaFkaNzwJWePsCG54+isWoBiwR1XsBCbqFP8DxpEW3DBzeZGl/k1qPPZoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7234
X-Proofpoint-GUID: oanmR6ajKv090vsOyzcNbh4u1fiUjSOp
X-Proofpoint-ORIG-GUID: oanmR6ajKv090vsOyzcNbh4u1fiUjSOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=906
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMiBNYXIgMjAyMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj5PbiAyMi8w
My8yMDIzIDA2OjU2LCBaZXluZXAgQXJzbGFuYmVuemVyIHdyb3RlOg0KPj4gUmVndWxhdG9yIGRy
aXZlciBmb3IgQURJIE1BWDc3NjQzL01BWDc3NjU0L01BWDc3NjU4L01BWDc3NjU5Lg0KPj4gDQo+
PiBNQVg3NzY0My9NQVg3NzY1OSBoYXMgMSBMRE8gcmVndWxhdG9yLg0KPj4gTUFYNzc2NTQvTUFY
Nzc2NTggaGFzIHR3byBMRE8gcmVndWxhdG9ycy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogTnVy
ZXR0aW4gQm9sdWN1IDxOdXJldHRpbi5Cb2x1Y3VAYW5hbG9nLmNvbT4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFpleW5lcCBBcnNsYW5iZW56ZXIgPFpleW5lcC5BcnNsYW5iZW56ZXJAYW5hbG9nLmNvbT4N
Cj4NCj4NCj4NCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIG1heDc3NjU4X3JlZ3VsYXRvcl9pZFtdID0g
ew0KPj4gKwl7ICJtYXg3NzY0My1yZWd1bGF0b3IiIH0sDQo+PiArCXsgIm1heDc3NjU0LXJlZ3Vs
YXRvciIgfSwNCj4+ICsJeyAibWF4Nzc2NTgtcmVndWxhdG9yIiB9LA0KPj4gKwl7ICJtYXg3NzY1
OS1yZWd1bGF0b3IiIH0sDQo+DQo+V2h5IGRvIHlvdSBuZWVkIHNvIG1hbnkgZW50cmllcz8gVGhl
eSBkbyBub3QgZGlmZmVyLg0KDQpUaGV5IGFyZSBzbGlnaHRseSBkaWZmZXJlbnQuIEp1c3QgTUFY
Nzc2NTkgYW5kIE1BWDc3NjQzIHJlZ3VsYXRvcnMgaGF2ZSBleGFjdGx5IHRoZSBzYW1lIGZlYXR1
cmVzLiBNQVg3NzY1OSBhbmQgTUFYNzc2NDMgaGF2ZSAxIExETyByZWd1bGF0b3IgYnV0IG90aGVy
cyBoYXZlIDIgYW5kIHRoZSB2b2x0YWdlIGJhc2Ugb2YgdGhlIE1BWDc3NjU0IHJlZ3VsYXRvcnMg
aXMgZGlmZmVyZW50IGZyb20gb3RoZXJzLiBTaG91bGQgSSB1c2UgdGhlIHNhbWUgZW50cnkgZm9y
IHRoZSBNQVg3NzY0MyBhbmQgTUFYNzc2NTk/DQoNCkJlc3QgcmVnYXJkcywNClpleW5lcA0K
