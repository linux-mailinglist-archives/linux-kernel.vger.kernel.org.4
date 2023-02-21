Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96569E14F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjBUNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjBUNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:31:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64829146;
        Tue, 21 Feb 2023 05:31:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L3i9qm016148;
        Tue, 21 Feb 2023 13:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UMSk8FLN/rqDcQLxEOBa9os5zBEgNgq0k1v8NO/sJ+U=;
 b=YO2pvSB4jGWZDJ7LnkveklQ7TaMsYofpUPcJSFnJoD4Qm2OeFyT+Mb6OYrztCeqcLlM5
 jx89xLWfk9U/9X1yXBSy/LknPYRgHLUZttLVJML+uFP89Ne+o1Y7JQMZ96uXPM6wu6x3
 b/5TjjqQXMk4tD43LjwUNyaKTQpKxTG7T2U3LKE51PcuCs/sRrpQGkGl4Y+Lzh6pKPWV
 n4B9oyOxtodoVLOtHey5XUhU0vXHATZwRJS+95CYfzt5+iXkGXG1d5uT+OJT3InYGC1M
 PUkcQ9pHJih8xr449c0Zx34RJ8CY2CQA14dLphX/yAIKK2nWPDyjcjyx/awyGohbn4e2 mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tn5jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 13:31:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LD66D9027367;
        Tue, 21 Feb 2023 13:31:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45b8tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 13:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pti2YJEfyBknmKRzoqc4jk0EISeSEz6STV6MOVVPpIcW9+wM34oqyNvXbva84qFMbGO9pEre3qElPqScxYWnLaBkIgFksZxGI+vJSHDvQFm+yqd2y4MqVxu8epQWI7ibTnXmX+FvGDDl1YTTJMSduSIbNilhwsy4AzKiUZOQ/cDrXP9jIjVWDq9wFYxQDQuKWA8BsD+RJZzqil7Uq9ArFn/5TDGxurfvi+XCrbPeRx9JWEUm3fLUmXCDQunUy51fZoMDfoxaNd+jlqFJqn2AIgIApzNLFJbX4w79rj6q82uxxA1fWdmAWVDcKAOBGdYI1WXOPUOdq5xOqJhGClZIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMSk8FLN/rqDcQLxEOBa9os5zBEgNgq0k1v8NO/sJ+U=;
 b=cenWrGb4a2kbPWvXm6ChlxpzUymw3YqSr79IOBY/ATBPWLdw7CmANfWr4azVM20ANGOO8b0L7YKv536VMJrr/vtkq5LY16LUGTTZI6Vds+ADmn3AObaDQ/dojPLRrD2q1JQ0FZzagx9raQH3sSh4NhkuusFKbtseSHiU2R6rD30Lmym5P9G7LYDRJs0Gdc3bZJUZkhIYstjYBNikDqhaJq49WZsIcRDZnYCZ5Y74RWwx55yiYTBrmRAmrCXUNacNxMamh88I1Z/di7wcaKu545WFErYamooE62S7sBc5PdAEdvd/sz7Z326g3yMtz3TQ02VWPdHbil94BUJKGk5yjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMSk8FLN/rqDcQLxEOBa9os5zBEgNgq0k1v8NO/sJ+U=;
 b=hAXbvHr+K4nFczmpQ4CykXgfZlbf+a1xl5l05Pvx3oqCgJhHFPWtqHkWKTmgSgl8PxXU0ehhDw1XCQk/E40sbglp/71Tl3udE5Z0PIspt2LtUa3jPjZJymOVsRPDnAJWQNsEJ5PwxmfydnRoRy7pW6z9X6KXNJVkU1nZ+zIUtr8=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 13:31:00 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::73f4:c35a:74ee:4b5d]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::73f4:c35a:74ee:4b5d%3]) with mapi id 15.20.6134.016; Tue, 21 Feb 2023
 13:31:00 +0000
Message-ID: <2941c2b9-5fa5-e25c-dcd0-ab9c9c0f143e@oracle.com>
Date:   Tue, 21 Feb 2023 08:30:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Storm Dragon <stormdragon2976@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-serial@vger.kernel.org
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <dcaaf7d5-b2d5-dbb9-f3fe-2232ee525cc8@kernel.org>
 <2094ecec-f63c-4e8a-ba97-da77c5266da1@t-8ch.de>
From:   George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <2094ecec-f63c-4e8a-ba97-da77c5266da1@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::19) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|CH0PR10MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e5ca1e-9bf4-43ea-112c-08db140fded8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ispfuqlwOgO7WaULx+1WIpo1NnH4mU3Quul11xdSUG4xJnCyCotMdHnrO4HTfGC9Wy1+VoaxNOrt1L3KFc2xDsDe9Y1AIUHs6f53isPMsOQa9mN8pQd3dJL/BVVgYoIb0GEg13piSUAdq+JqigUw8vDw01h0Q+6kC8+f+ajPrvp96Sj21bEVCptI3b+Y30AOcycSikjjV0PYNz9vKdjJb7lVUsXNbBOyiQj4p6L9G2cUpo24THrwt0ZqWAJ3s3YLMg3iiBto0OozWrmAY7R2kk2BoznKOcbAzoqPzvYGT9U9RjbILs1TXjGLktEmuvvMqE30NP/1BkjMp2+FKZ153JYoNfZX2Ewr6plgtBWhg/B4VC9rfW4LiD/kkHcp9ohoD/+oY3AYRd4ohkSnJD2kPEMzXWco7x3cuHs6qInCz/Ph/NtF4gXcx8jaH9qUCtGnqT8XNk4ct8LS6k5GwI/lLtyfV6dxLLvmbfdxvfc2psRNwEEE0WP8Hy1jSZ+pzCK9jRECGkHMHLD4BmU4zRvtkdD+NSyxFo8do7EZe3KRxMAY6MQ/flS8kgnr4B73FnUbLMWZNGLRopxP4/N4EJ+fAU6Te34kXdPRnRpgaOXtbDWQk/nFDYwhBM36th4usI2IqKDBtlbbiTMJ+BZGmmF5VLqiaWLeTzfRqc+P1gzMnh7NA4sEMMMD6WwKfS95oeEM2TEYBtpqWdEwhWYmY+je87i6C3STc9QfP8KmOfKLe7OLAlvVjgCq4ohycd871XS1dFfM05cfajFxVilUgopJ3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199018)(2616005)(45080400002)(478600001)(86362001)(54906003)(31696002)(110136005)(316002)(6512007)(6666004)(66574015)(26005)(53546011)(6506007)(186003)(6486002)(966005)(44832011)(7416002)(38100700002)(36756003)(2906002)(5660300002)(4326008)(41300700001)(8676002)(66476007)(66556008)(66946007)(83380400001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnIrM3NPNlVWaG5PVWFmS3RNcFExR2g5VXdXYmJKVHhiSWx1R1VlaHBESWM3?=
 =?utf-8?B?UGg1cGdheHIycFg0SGJYSElvK0pYUmRyVVZHZ2h2YUhPVEVsdlNWTlpmVzQx?=
 =?utf-8?B?bDRJZVk0cHovSlBhNTlRMmdrY3VubjJiYVlCNnVKY2lQdWxoM0xxU3ErTGN1?=
 =?utf-8?B?OUlhWGI3QWUxRjR2M1dqemZ0ZVlUSnBRdkg3dnF4TmR6MitPME43MllFWVRJ?=
 =?utf-8?B?OFNNSHREaXN3TVBpUEs3M1FxWDJVSG1WQkNtS2FEeUY5Y0E3MEJWNmpGSGVh?=
 =?utf-8?B?VWZvbnp0R09Bbi9Vc1ZTVVV3L041eGw5KzR6cXdlczdSemY2RkRlWFpBNnJU?=
 =?utf-8?B?SlVSdTArTWpHYnU4UmxaeWJMaWU4Q2hYbXJpN0IrdTVnQmIwK1BPMmRKeTdU?=
 =?utf-8?B?UDE2bVFESFI2UTg5d0hGYTBqOWhLRnV1NnRNM0xNZ3pmbkRhTmlydGZNeUI0?=
 =?utf-8?B?U0JzL2VVWGU0b2pqYXpwZUIrRXhlT1NqVFh3Ly83SWhUb01VZzJKT0tXRStV?=
 =?utf-8?B?MWNOaDVqZ2ZUYytDUEhzWWJudXpvRVdkbXNFMWlLN212YnBsd29qZmdMUEtK?=
 =?utf-8?B?NnhZY3M5WUNQUDd2RFljVkxWTG42OFRqSzZQM0wzbkdEczhEYi9jampYSzh2?=
 =?utf-8?B?L3kxblB6aDhkOUdpQ1RGbEJlelhBaVYvSzNjWDE0WVdtbk1xV0dSWXdwSXJX?=
 =?utf-8?B?VTZRQXhyeUtOQlhnaDZoOHpFVC9laXdQU3Q4NWFmei9WbmhldGQxSUhZRC8z?=
 =?utf-8?B?L2I1UUJUOTZHTlU5a0NuUHhqQ0o0cE9qdkFXZ09BK1R4Y2ljOHQ2TGl0RFVP?=
 =?utf-8?B?NUJhWmVEbUt6OXZEWVNxcTdsT1REc0ZZQUJvY3ZzQVFKNjJZTHRRcmlTa1lD?=
 =?utf-8?B?TFk4elFMWFZocitGRHVNdHNEdUhGcnBRTkpMa08yNTFHWDJMNDFzbWRNaUcx?=
 =?utf-8?B?blk5dUtVQ0Y2aCtTNU5QenNhR3JSWUhlcnhlQ2hPYWV1Vk5GYi9MbEdjc01X?=
 =?utf-8?B?NEw1aVBydDBtYm4yTjFnTjJQa3IxSHhMbnBjQU1WUlIwdkUrbUtQUUhzLytZ?=
 =?utf-8?B?YVFtKzVkbEgrTXVZdmZ4cmpmSDhwQjcxVE0xb0lDdVQ1R243dytXZ0ttaVor?=
 =?utf-8?B?RzVlNDJVSWk3M0RaV2hNMmJHWEg5L0wvZEdUY0s3a08xakJMalFLRDQwS1F0?=
 =?utf-8?B?K3AwYXJRZGlVT3VLekJ0Wi9yZmtTOXdUWkswUXlnS0dkMFRLRkMzaERYeG9B?=
 =?utf-8?B?TVhldGs1M3JHVkJCUVNnK3V1dnZ4aitDckoydmFrVUlGZnhQQ3ZDeEVYSmpj?=
 =?utf-8?B?cUZMOVh1a3FYWHVSN0RuMWpnZzFMSkxXU3dsTVZ6MU0zYm12N3lTMUdFQ1FC?=
 =?utf-8?B?ci9EZmVZcEU0blBuTnNWaVhKczZmd0RsTXlGZTZwNmR3TTV6aFlnRndVSWZu?=
 =?utf-8?B?UkdRWXBJSUJyanAwU3R6ZGx6amNaOFAydUszRythai9IdWxGSENEbCtxWWM4?=
 =?utf-8?B?aEQwL0ljZXdaOXpHT2Fhc3B4OFJSSVpldldkL0hGSjZOeWh4Q1ljOUZJRnpl?=
 =?utf-8?B?WjZCQWhuK2xTVWpBQ3BoRlZZamZmZlZ0TUZjK0RGck5PRTlsKzBpcmRRSXFM?=
 =?utf-8?B?S0ZRSG1QWVZjOGF3dlhJc0I5a2pYelVocFRUV21jMERPLzRQUU5GRnpPcHRs?=
 =?utf-8?B?Ym5sTStSdFl3bnU0V2xCV0VDZk0wVTRCVnpldERNZkVTMUtJZlZialhUNkdW?=
 =?utf-8?B?ZnV5cnNpRlJmL0UyMVBKQ0FXZ2dPVXd5Zjl5VHl1VDJpUkQrcEVsRzA1S0Fn?=
 =?utf-8?B?UmkwZG0zREdSR1lEdGozZW1wbjJhblVPR2s4cHE4Ly9TN3VGOUZCU213SjFn?=
 =?utf-8?B?SnVzeDNkdG90eTZZT3lyREQ1S2FmK2wydStXeDI0ekU3eUt6NHJMOWxaNzlC?=
 =?utf-8?B?Q2VOd2YvYytvcGE5VnhlSmNTa2FmTDVYMUEvREZYb1ZISUpzbUV2SFJJYTFj?=
 =?utf-8?B?S3RRTzgwZEJybGloTCtGcHdZZkZ1Z3kzMnJSYWVHclI3T2JyZGNDUE1BOUh2?=
 =?utf-8?B?MTdjeVdNU2pUQ2Y2ZUo4UG8vdFI5U3lzMXN3NWZhRGRJYmQ2VUlDcGU5blNZ?=
 =?utf-8?B?clZkWEVqWS9xaDN6UUVmZmhUalJBYkZGSmtLN0tvcUF2aU41bmVmc0dtVmVE?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzlzNU1ZUk9EaFpFbTBTaDlQcnc0UXpOQ1U4d0JQNThMSVlQM0xnbnhVVzJK?=
 =?utf-8?B?di83YlFEdjNUODN4eGRUT3BZak5nd2FTR2hzcHk1VjJjN3B0UHM2d2I4Vk9Z?=
 =?utf-8?B?VjdtakNoTlRvRE85QmQ1WEE3MXpvSjF2VDdnRE5nVlBtMWFhaFhXRmU0QVk2?=
 =?utf-8?B?TXNCZmRKN1ZiVHhRNFRXY0hwREkrS0E4a01Zc0UzU29RdnhTRXlHVXZMRzVt?=
 =?utf-8?B?UEhkaTJ5U0tUcnRRRDZ5NldZS3VGM01yK1laN0xhTWlZUDJQcDhjVVVmWk9G?=
 =?utf-8?B?ZXhRZmRZOHJWVThtdGxxTHJxcWx6eVg5YTJJQWxYaXpRUGNVMHloeHR1Qmxy?=
 =?utf-8?B?L2pEcE5FMnhWU2h0MXM4d20zblhMQ3RLbFMzWlpyempPMzZMd2pkdW1MK09V?=
 =?utf-8?B?aE96Nzh2RWZYVFlpZlBSYUFOZjVPSmR5M0cvVS9CNHQzblRJcHhqeGdseTY2?=
 =?utf-8?B?ZzFpMkxtd1Vlend1RGVZR2wwdGlOZFdnT29kc0tkS0l6NENpb1BJWmI1cGYy?=
 =?utf-8?B?Y0hqTkNkVi95TU5ySVZ0cFF0KzlBZWp1VDdGUDlVWGZqUmg4TEpBNWVBMEZl?=
 =?utf-8?B?RURGWXBQdityWmFzdHUrZC9ocTJqSGtvUTNBT1JqM1MraFhBakhhNTl5STQz?=
 =?utf-8?B?TnN4SEtpSXB5L1BxY0J5aFNHeGZpbEVWQ0dGdlp4MXpQOXBrYlVXdGNrTGZm?=
 =?utf-8?B?SmlYQW0vZVBnbk1qTFB6MkhmcDNXUWNIdTcrWEJrTW4zQXJrWllhQXFYeUtN?=
 =?utf-8?B?WkNhaGtUUTRHTndTRW5xclJSaTkvUFhPd29md2dpTURZcmIzeGpLVmVSNnMy?=
 =?utf-8?B?R3hkellkdFNaMXRJYktsSStvZEVKUjloR3VVek4rOSs2bXFLWEtrcmVodVFi?=
 =?utf-8?B?ZmlSSHJNRXI2eEJyeFpKY1dHOEJrRmdHRnQ1TkxJQ3h4eUszSFpxRDN0Qlly?=
 =?utf-8?B?UnhYR1BicXJuWXFyU3ExVFVCbll6ZzN6OG9KWkEvcFdpa0VZYktoc083Nm1l?=
 =?utf-8?B?MndLS1NZbWlmeEh2bC9JTitTUE81bmtxRlErdFg0N0lXeHBCMkVidG93UEM3?=
 =?utf-8?B?QUY5V09BQUsrL2Z5T3Q4YjhSeHRXWVpSTnpoWDlRd0RJN2FZeVhEM2crM1Mr?=
 =?utf-8?B?M2dHQklhbzhRN0Y3dmNQU2ozaEJwNE5GdVNSVkFhcUw2TTFWb1pnV1dqL3ZO?=
 =?utf-8?B?VlhFTFU2cTJQOC9wMkZJenVzdzFtZGl4STlwWUlkc3BacG1UZm1PUHBFS2pE?=
 =?utf-8?B?TTd6a1d4aElqOGhOc0o3L3VCME11Ni9LeGI3ZmQ1V2cwNEVBc1ZLeE9TR0J0?=
 =?utf-8?B?MENMbGUvVzBJS0NocWcxVC9OVEp0VWlXbWNvWGJRV01MeG1HWEg0Q3JUank4?=
 =?utf-8?Q?hQABhPUa2TngqkcOc+hn/WD0lATSKnzs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e5ca1e-9bf4-43ea-112c-08db140fded8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:31:00.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtQLUJDGZ1zQ2F4wORbNX5RM0qc4lS3YAbC/RShsQJ3Enej0SIK+6gZGPz0fH731JR5bGhAldeA5O3lMKgcGCgAZ2TXMCMz8h3+cOS15IPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210115
X-Proofpoint-GUID: ljSmHjBvHjMrKnqx045zvwR8iiuHofoD
X-Proofpoint-ORIG-GUID: ljSmHjBvHjMrKnqx045zvwR8iiuHofoD
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2023 11:34 AM, Thomas Weißschuh wrote:
> +Cc people who were involved in the original thread.
>
> On Mon, Feb 20, 2023 at 12:48:59PM +0100, Jiri Slaby wrote:
>> On 20. 02. 23, 7:46, linux@weissschuh.net wrote:
>>> From: Thomas Weißschuh <linux@weissschuh.net>
>>>
>>> Commit 226fae124b2d
>>> ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
>>> moved the call to vcs_vc() into the loop.
>>> While doing this it also moved the unconditional assignment of
>>> "ret = -ENXIO".
>>> This unconditional assignment was valid outside the loop but within it
>>> it clobbers the actual value of ret.
>>>
>>> To avoid this only assign "ret = -ENXIO" when actually needed.
>> Not sure -- I cannot find it -- but hasn't George fixed this yet?
> Indeed there was a proposed fix at
> https://lore.kernel.org/lkml/1675704844-17228-1-git-send-email-george.kennedy@oracle.com/
>
> Linus had some suggestions so it was not applied as is.
>
> I'm not sure what the current state is.
> George, do you have something in the pipeline?

Yes, that is in the pipeline:
https://lore.kernel.org/lkml/1675774098-17722-1-git-send-email-george.kennedy@oracle.com/

Linus suggested the fix, which was tested and submitted.

Jiri commented on the patch, which I believe was directed at Linus as he 
suggested the fix.

George
>
> I also tested the patch proposed by Linus as attachment and that works.
> (The small inline patch snippet doesn't)
>
>>> Reported-by: Storm Dragon <stormdragon2976@gmail.com>
>>> Link: https://lore.kernel.org/lkml/Y%2FKS6vdql2pIsCiI@hotmail.com/
>>> Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>
>>> ---
>>>
>>> @Storm Could you validate this patch?
>>> ---
>>>    drivers/tty/vt/vc_screen.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
>>> index f566eb1839dc..2ef519a40a87 100644
>>> --- a/drivers/tty/vt/vc_screen.c
>>> +++ b/drivers/tty/vt/vc_screen.c
>>> @@ -403,10 +403,11 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>>    		unsigned int this_round, skip = 0;
>>>    		int size;
>>> -		ret = -ENXIO;
>>>    		vc = vcs_vc(inode, &viewed);
>>> -		if (!vc)
>>> +		if (!vc) {
>>> +			ret = -ENXIO;
>>>    			goto unlock_out;
>>> +		}
>>>    		/* Check whether we are above size each round,
>>>    		 * as copy_to_user at the end of this loop
>>>
>>> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
>> -- 
>> js
>> suse labs
>>

