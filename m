Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81055F778F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJGLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:39:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8C53A64;
        Fri,  7 Oct 2022 04:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8zF5t7zlPQj7jSUQEch5GkWhNiQ05q3zEgKb+BZ6+QqjeJNdv9ORtluj+o0BidodMajqRKw7HkwkkIDx+0YGeGWAp7uKAjBC+9ERXlY1Q4vik0L8Ghd6FgHl8ddiiFWNWXVTny1hZH0ZkWBh5GhzZAfhH9tjJ4vhl3loHf+RVP6xR6GiwoajDCCzHyblCN+wDb8cpg/cnf/vtCGd7RPOIL1JBggBgxr114/++Ojv2ug8WJpeiPM8dk0nS2Ts2QhDi6fNwtTFwODH/8Cb1heP9WWnZeSwez4oXMlKHiPXEM5WzfRj8J/AbhgyzLf+Udd648+oOZOmI3DcADKaDRSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBLs5vwak3NjfENvDnAYvLsTnccP+BRHdV2Te+rhT2w=;
 b=Z+65HF3TGHm3vC0YVPy9Fsm7XrB0LAVHkeoKlcCslZdwb3TXLIZZWGaMLZS7sxKVhGLqKMe3rAvFGC8RevgAu10Q8zzXb1Bc9QMr9Kr9Bdg5icJqp74nXNpbaxK10foYi9cpjznaqfv2isLgNtrLjd6jzAmrG3lz0+LHOHg2c7m7+Zc/O9WovfZAW23GXQy/51NEWszq7+Sar8MDl93Pk6ZIlcK9DcDDxGM6M8WAZ98q4Eq4rV4OZBs6CUIh1vjetpF2axNVpuloZ0NfavSPWiGkeghHrenZYtOafq3X9LKSIAphc9ETdRKSSNLkVDc7C+cRCLZA7fhaRRHGV1cqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBLs5vwak3NjfENvDnAYvLsTnccP+BRHdV2Te+rhT2w=;
 b=USFpzqaSypqjviyph88EhY+4uqmpEFOsEjLq9OBbPbWwIhbypMOICnJMEvGlt07CT6zStH3dWTXz8Ua5JITLLgVJCYaQmCM5AyvUTlbAWJm8kbOCj38eYgKAQrjBbvu18P9Up+WHSH9OG/8g9iKTTANs88f5mUBQqW/MkgpSTVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.39; Fri, 7 Oct
 2022 11:39:28 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::21c0:915e:4429:33fe]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::21c0:915e:4429:33fe%3]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 11:39:28 +0000
Message-ID: <425858dc-59fe-2311-61ae-3b6dc77a2576@nxp.com>
Date:   Fri, 7 Oct 2022 17:09:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 1/2] dt-bindings: uwb: Device tree
 information for Nxp SR1XX SOCs
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-2-manjunatha.venkatesh@nxp.com>
 <78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com>
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|AM7PR04MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc897be-f7e2-4922-410c-08daa8589774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPh9GxI+igUFQ2DcUjQ7Cz+aRRI0QkqTGU2NiTLYvQkmmbFFQ2TdSJ2CCXiZYKv0IY1wK31k6Biavy/TO+Rbh7dau61kPI8ZdzHmPXOZNiFPLn5RYg89WIpxcTw3kNOfuPrgf37rV2u5/Gzmn5+oeVBEFbBwRtI1JxvEos+IvaTrcl1AVtj28qM+4WYsieiAvWavPWi0zr8sNlby1hKF5DbwdHlkyZgvuCJy45LuPY6CE5y/sd85SZUzGh91wOkaWt7L6GnTlqF1XglpRIzIkoHxViMVb09AvFOsRX/7FxenAmqWMZOe5n0lhJpzFBfyXXln/LDBbY5rM9xEjA+euQ6xEnoyZFsIAfaAGiwzcRNO1lLVMInrBdqRi8TqfnDZQVfm8aKL9SZRA3AwQVlo5Q3Ft4EcM5u45Ry9ySmrbYsQSneDYeYlcpl1KfnF8fOUibNoOSgos+yp0fkocgBU8LLl7imhTqv6BphAtj0zr4BRMU2/31wgzubss2egUzWm5ffEYqmCxeqR8HycfmoVZtC5gdGb0v6ujd/ChoDqfJ8R1Eg6nqQrM787kgfCmD2NAb1eX3AM/o4OfAI+EiW1zc2FYvcj0pvXy/hdNVhzg1hezax/EqbOWKdBaUUYWo7iNHWENxIpTIov9jl132Pq+iYd2DKPrmBdiI7nEGYvKUUQ4uMfOgGB1y8N7atiI7OHPR9t19dWGewbIp4/5gpp25Dgu7XSzwY+37KB1O1v21oXxYUnavDnYniW7hRpambf/RxXjrQU8Wm0WFdJIWOp5qbjBto2z+SXoaGJ2hdX2KlmRm7T/EpRE08ys63MfuLf5wJOwjcH7QSS5WmYsvQtFKhDdZvkR05GzoaL42DhwK0hRziu2iKaNXQla16N2+a8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(478600001)(316002)(8676002)(6506007)(4326008)(6666004)(53546011)(66556008)(52116002)(110136005)(55236004)(66476007)(66946007)(36756003)(6486002)(86362001)(31696002)(186003)(38350700002)(38100700002)(2616005)(26005)(6512007)(41300700001)(31686004)(2906002)(5660300002)(8936002)(7416002)(4744005)(44832011)(32563001)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZvZkRpbEM4cXJNUU1qY3lZNE5qcWdxN2V6YnRGOTN0Z3Q0WC9wZSt1ZUtD?=
 =?utf-8?B?cy9odHgrOGlzMktqMHY2WTRXWWl6elVUTkhZb2tQUTE3aWlwRFRzOVlibzUy?=
 =?utf-8?B?aXpLNDR2NzdITUFLOXdoT1RKVU1YYUVQcXR4NGEzVGJkejUvNmVPU0UzbW4v?=
 =?utf-8?B?YUpYOVdaZkhxMVY2eENMaklmSnlQMUxkYzdvSVlTS21JdjEva2czWG9xb0Qw?=
 =?utf-8?B?OWVQM2g0blo2ZmtlZWF0Z0daS2tyMmdDVE9MNUR0SnRhNkt6VTVlaEl4VnJD?=
 =?utf-8?B?NFhqb05lelFCTDZTQ1JVbkJEL2hFVzZ2SFh2VitZYVZBcGd0Q0g1ZWpNbERR?=
 =?utf-8?B?aFFlYTJUcVk0T1pzOEIvTnljVzlTdGxDbTBvRGtWRUlKRlp5WmttbTlmeENh?=
 =?utf-8?B?NWpBcGt6cFFVMnFxYmRZK0Q0dmVHL1ZaU0d4b1loSUVXZm8vTk42bllpZmRJ?=
 =?utf-8?B?TTdCK1JOSVFzU1hRNkxxSDVHNWlWbUxZL084S3M1RzBkTkRrZ3NYblk0aEpj?=
 =?utf-8?B?ZnlRVjF0S3lDVjB0dlFWRzgzWGw3b3RCTUtVeDlJUFkrem14SUpoYkRFREdz?=
 =?utf-8?B?MG1PVHZZeHkwd29ZN0pLdS9wS0ZDcVJ0QXluUDBjek1tTnBsM3pKN2FjdFVW?=
 =?utf-8?B?bzBEUEFOQWkrRG1GR1hJOTNPQW1FN0thNGZnNEJYUUlnNXpBNFMwTE4zWUd2?=
 =?utf-8?B?REhMOFZCM1BLUG9XOVJ6SnhjWjhySnlYakd3SU5wcFdzSXQ3Y2pRQjhLb2tv?=
 =?utf-8?B?cW5GTVFVZlZiWU1nK1VMRERFU1lNLzFvaWRzZnpMWSsxV0hHUXV5SGNrek91?=
 =?utf-8?B?NGlTMU9sTmlBR3dwM3NjQWt3QjluQkl0QVI0eXZENVgrd1doUnA1dUNlbS9F?=
 =?utf-8?B?bTFyRkdEbkdTMnhxNk5aeFBvTXM2VWJtaWhkWk9QZCtnWmw1TjhLMnRPYjVo?=
 =?utf-8?B?d01ycndQakJtblNEWVgyK3BpdWdFbjZuZU14d2JWT3NwMngxK01HaC8rQnBC?=
 =?utf-8?B?VllETVJsby8xZnNncm4vbEx0VUROODAyUVhPbXFyOTBUbGowNXFxTmlzV2xv?=
 =?utf-8?B?dXdTVHFHcWUzbkdPMkhPaDJwSW5YNkp2bldmazVhUFYydnpuSG44bnIySDZv?=
 =?utf-8?B?NzIrREZRa1FFQk5Dc3gwN2MzbTBzSjlUek9YVG9pWHNiTnZnY2xtc0JRTHly?=
 =?utf-8?B?cjcwcVliWjJMMUpacmxINGw0WDlRVU1TeHFFWm1TU2ZxT0ZvbWthVDlNRHNP?=
 =?utf-8?B?alYzUzhTRWd1bmtvaTZnbXhvL240VDU4bTdCdEk0NmlGTnJyNGJIV0l1eUpw?=
 =?utf-8?B?QnMzbnFlS0V1ZDNBS1lYWHhiU3BubWZRN09DcnF6SkRIN2pRd3gvYWRJN09Q?=
 =?utf-8?B?S2VHYzVlRWEvWmRxRmdTRjlWMjBrbGlYcUg4REkrQmJmdE1XajJkMFlmN2hn?=
 =?utf-8?B?NE56dVJuRFltZ1FKclNkS0NVQXNUS3JwS3hacWw2RjlZS1NSWDVHN1h3dFJh?=
 =?utf-8?B?cFhucVFvOEhoeEdtNHBRS3FvWWR1elJ2Q2tvZTlOU2llTmNTcnhPMHJ3dWQ2?=
 =?utf-8?B?VWliV3o3M3drTERKR0F2c2J0RERQQWx0QmZ2czFjL2hzVVdld1BVYjhtdm5w?=
 =?utf-8?B?LzBYeWJzbG8vRHJvRytNYnJqd0xUZ1hXMm04Z3ZFenRvTVRFTGg5UFhaQXhR?=
 =?utf-8?B?R2V3Vk44MDdaWW5hU1hxbE1Mcm1Uak11Mmp6UG5KUC8zRVVBMUFsZlNtdkhC?=
 =?utf-8?B?NnhiYk5aOE1jNWN6SXVvMmZqR0pBZTBXbzA4K0YzdTBMSnIwKzU1RGVKOTBs?=
 =?utf-8?B?T1Z0V29DdEVLeFVPcEdEL2h1blhsalYwUU1ERWs3dHk3MzdXaWFaM3NrSkph?=
 =?utf-8?B?bVJxb2pnczE0Q3ZHbXpFUG53RTJFdVRqajhUNFl2WE5ubktGcEZMV1REemw2?=
 =?utf-8?B?aTlBT09jdXRxQ3Y0Y3RuNUUvREJEdk94VEFvcHBKdWZsOGZhNHBhUWsvcmJL?=
 =?utf-8?B?dkRPdmxBMUhrSWZRMkxhWFlVaFBNRWJtai9XVU9LVHdXaUJwcGVxa0dwNnYx?=
 =?utf-8?B?TVZtTUdDK280d0V5WkRxRzNnWkhOM3ZhdDFKN242amowTlQ0bk1ZRlhCbGFO?=
 =?utf-8?B?N014Y3lnN1cyTUFjYXd5NVlQcDNNWnlHR3I5LzZCS2N6ai9nb3pWQ0wzQW53?=
 =?utf-8?Q?9uMARycFuj0cCJlGV+0L5SU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc897be-f7e2-4922-410c-08daa8589774
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 11:39:28.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0eV4NCsvFY2lzVrm8rXFQD51ZBx0Qe3PiTgwO8nmlvIu4v0KsuYOsTMGHl4EivQTcH5grLzB2Unp/wSqSsR4tznZtaV9cAQtp+/H0phGWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 8:06 PM, Arnd Bergmann wrote:
> Caution: EXT Email
>
> On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nxp,sr1xx
>> +
> You should not have wildcard names in the compatible string.
> Make this a specific model number without 'xx', and
> have the devices list their own name along with the oldest
> one they are compatible with.
>
>       Arnd
This driver is common for both sr100 and sr150,so we have used sr1xx
naming convention or can we use name with highest version(sr150)?
