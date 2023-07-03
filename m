Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052E5745FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGCPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGCPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:22:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427DE41;
        Mon,  3 Jul 2023 08:22:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363EnZcx005876;
        Mon, 3 Jul 2023 15:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YYmGu07j22eOV0UQQN624hZKaI0TboN6c3dVAaC/o3w=;
 b=W7XbCnygV8SPS+dSkJ7UlVDvEJwVwixmCH/fC3THAamtPkWr4wYEsQ2dZwplYUarac+a
 rdJh7DANtoJ8ocupIBJW5HcqQu0xsVu9EUiqw2HTc3kghjn2ufnJ/SOvCLoUILOO8vYx
 YxwlufPJnFe0ELY3WCgGNNkysi20YWTiVb0Tsu+uP2TwWTv+XesHLQscV5cUL1AEQMVb
 1XUn+nBrbn9tSKzdLxjjQ3HsXAfvdXaWc0S/a7F4o34VYLfn0WiYNGs5HuZIrOP9nJZd
 l5tYZS4RpCRhUlKsSfzs5NkrMTV4h0zZwwpz58vCskc4Ubt/s2OHzNGj1rhpuj72vzrB WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajdayjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 15:20:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363E0UeV020735;
        Mon, 3 Jul 2023 15:20:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak37ye5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 15:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBhA9z0sOqjoey/HGjBmw+7H2PsRW8BC5dhz+LcWY1FkpA31nS9xbn+cnUDyvgFRw9R/JaA8jMhd5uboxnHfT2oGBk6d6KQcuCHnbPAhpOkAzGspyeQcOShzBJhPq+IihIOaCy5fgiRhth4iJtmUBLB9bv35vWCgCKrog68x8h134xT2XzMHoxHPoJVGnst4/FlzxrUszdu4QNak5JpelURsNqI35fgWO74cXS+pSAtCtG/NA6mJbmXybvaNU/en0tPBl+wHoio+9Q09e1uwyPv0yA+WC5bXVrnmiAZkr6ryCDrciPOKd6T2TUrYFlQqMsXjHpYwRGZ0vaPoaXv3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYmGu07j22eOV0UQQN624hZKaI0TboN6c3dVAaC/o3w=;
 b=Wn1riEG0mMfpYrSLcWwVrkzXfje2e1todEXv0LX4oI4tT/gb8NDiT+jr7yrv3LhiTXMurY09EMo5HV92Lpin9KoWOGO9wwZIPNeX+mArQIkTlcAQkK8iKL7jhlaYGKaJSuaJ0Mw4qvRv3w3F1lYUqmz4fg8LC2rRmV53HhrGxZ+g+yx9nO4nuloesBR+wKTQkzM6/beJGvCBhI5trTwYq3F4yAJpmYHsfr2tx6BH3niM9QsZpDYjXE/KgACOeqifFzVro+2fjiB8WI518C36W8iDPFcU020ZYBZwSq8mL8RLK8qn8CmKPFAFuVnB3T9SfA+ZdHc8/UQN7uHA/e9Frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYmGu07j22eOV0UQQN624hZKaI0TboN6c3dVAaC/o3w=;
 b=dxNe56sXB7fJ5Ifx5iThvd55DiI/b04G99ukKvpjFrrWkXysEVO1mroeZ6Y9I2owFeUUxj7PT3YYFaBurXZad98BfQV9Q8hQzM2WDOBjPh05dEJeZCySPrhj1yxlRcM0o0kI3ejQxPZQleXBq6cF8Nz01mrDO6yZ9w74ukLRS1w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6587.namprd10.prod.outlook.com (2603:10b6:930:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:20:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Mon, 3 Jul 2023
 15:20:39 +0000
Message-ID: <c167a8db-d644-3f65-1bde-4635853cab92@oracle.com>
Date:   Mon, 3 Jul 2023 16:20:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC 3/9] perf metrics: Pass cpu and sys tables to
 metricgroup__add_metric()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-4-john.g.garry@oracle.com>
 <CAP-5=fVS5Y2VxSDNdcXjc0Y90J7XpCXtxXU_=_Fjn6MJkuz3nA@mail.gmail.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fVS5Y2VxSDNdcXjc0Y90J7XpCXtxXU_=_Fjn6MJkuz3nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0025.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::13)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: edefcb74-327e-496e-cdb2-08db7bd90edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bur4K+ouPcwTYjaDvm2EkeR8Wcw325dSCGyiQK7PuPXhiTp1LMrfLeaM3NOPkhaRx0R/Z0il7n2/B24BqH5PQCBhzyHM7aPUoj9SIGC7LQdjof/rGM5UoIIRyixnt+0G1ZStZvLhbIHH9g2eOwQxQF+0W6qOa1PXpzGboPyQcisbVDEpV0p6rIGh+mC8Hls0knzU6SozZqBMzZp25xwa41Mh+v7uI/okVlH7bn/g+y9Pc7wloReo8U5vkWDhDR9mqNEPmT63R/OemtTf8Z+MkL6yk1xH9giuHkVkApaM7o2BR9IiENzpIj1JJQ4tOPLHtqAatW7axhgKgTIReFQLt+6MHnHxRdfwvCvFfvrS/oMp7Vf4FY66wjCXW9ptlXfVHp52SLKXcaKbZmAX1Zu9vtOG/bbf8LS0ITeHKpnnje0oS/6RmrSnLIJO8X6yB1Jg/61mTwZYVdxAyn9O9PORt5VbJftCz/EU7CVcl8NejZWXLpAlFgLLPvmQ5j8ZcrN0c2ZDdjyW4g2XRrlkvQtlROEcPeWWnmsxZxV27A2yw2XomxrglvyBU4kZOvfaYtdViVmwEb7omldhxbkUU4dbOsRbTd+dK0NDtnmdV0Xe4CP+53st/mPj6OY5pVyTg0n8Cs6OWfvc22ZGD7jujJtFIINHeZtzqZ0bGqjOJ99ZW+3q0nXCYLfqQgUTNOWJYvHP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(6506007)(66556008)(6916009)(66946007)(4326008)(66476007)(478600001)(41300700001)(38100700002)(316002)(2616005)(83380400001)(186003)(53546011)(6512007)(26005)(2906002)(7416002)(5660300002)(31686004)(6486002)(30864003)(86362001)(36916002)(31696002)(8936002)(36756003)(6666004)(8676002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUd6cDdoYWJNSUx6emRjVE1vLzZxZXkrS25oMHFONXRBVVVxMStPNkl6cHRQ?=
 =?utf-8?B?bC9SbnlmREFYVmZKdzBMTnpnVU1sangzSEJXYkNSb21hYUhXZk5jQXo1TDd6?=
 =?utf-8?B?b280RVNmaWRESUNkN1dkLzhjMXlIMXZKQ0Zkc0hjL2xVL1hWUlBremZRNXNx?=
 =?utf-8?B?amxLUHpRMGpDY3poaDc5Z0Qwb3V2RHNXcG1pZDdwQ3FwU01lVTVoWklralZP?=
 =?utf-8?B?WEZ1YWRvZ0pVY3l4MVlRazBGU21Fb0trZDEwTlZ4RzJlWWZoaC92TjV2cnZV?=
 =?utf-8?B?SVR0TlBWWXNwMmp6SmhGZEJGaW9sWmhpVm1nL2FDdGNZakhUM213anQ5YjRw?=
 =?utf-8?B?UXFxQVR6NDRkV0FZN0pYTnBEVFBqeEdlUW05SFRoRGNxTUdnQzJxU3hsY3Na?=
 =?utf-8?B?T2tNTjVsek5RT0pQaG0vbk9MbVpQTUZOY0EzK2Y5czVaNkVkTlY2b05Ba3hO?=
 =?utf-8?B?bklYOEpKaDI3UkhqQjJiditBYmsyai9UZUxiNVQ2NW1XTzY2ZzFnTUZqcm9Y?=
 =?utf-8?B?VUpVbndhZE1uUXVyNm9GV1MweVNYSnZpTjByancxRllRSVlMMzdHcU11eDVW?=
 =?utf-8?B?d2lCSHNYQ3EzNkw5Z2ZrckNzUWxUZzFjVmUzaUJCZS9Rb0c3cUx3a1Q4YW5x?=
 =?utf-8?B?SjZJMlJIbHZ3TUkyQVVsN2FSV3Ftc20wQ1k1cTMwbHpRZzFmMFF1ckRLKzU1?=
 =?utf-8?B?LytSU1FDTTZydHJCQW9kVUdLZ3pzT2xFdVRPMlMzblY5TFhQbHRSdzhtNTZ0?=
 =?utf-8?B?STdVbHNiNGtqT2s3dU9rY21wRElTRnBZSFhLUUN0WjRIUGdHRkt2ZFlSbHhx?=
 =?utf-8?B?T1JaUlpUd3BaekNZSE4rVGJXVkRyNkplL2NSRFlMd2VuTC9UV2YzcHYvaFl0?=
 =?utf-8?B?b3Q5UE4vcURzeUkzZUtCbGFZMVQwVXdBZHFoN21JL1B5UVVKQSttbDJESTYy?=
 =?utf-8?B?YXpxRzlPYVU0a2dDbUc5ajc3b2N0SFpIV0pNbExYVWdmMUdiMkY2bUIxZDVZ?=
 =?utf-8?B?NStCbW5zclREeFhXMXNZTzA1MlBHck5uNGN6RkxGdm1mZmpxQVRNZ2pMazcv?=
 =?utf-8?B?RlBHNk9IT09mcHBzeFdyNnNmQzdaRGVVUUxyc3phNTU3N25XTDNLOUd3WjdH?=
 =?utf-8?B?aFNpNDRWRUtCSUdaTjF6WURVSWVlbFBVcW9seC9DcXF4OXlaVHRnWlgxWGda?=
 =?utf-8?B?Z2Y5MVZ0OUF5UFdRK0tqOXNEbWV2WXpHT21LeGV2RFozWHNxY2kwUVFZWGQ2?=
 =?utf-8?B?bExLZFBQT2NTNlcrTkV4QnU3NmhZMmJ2bDR2c0tHTzhIaHp4OFBNcEt3UGNo?=
 =?utf-8?B?SUxDbnZ0a3VzRmJmaDVzdVh6bjdaTVB3eWFoUWNoMzJ4K2VCQU56cENoVGNm?=
 =?utf-8?B?TDdmRmJLOVRRZjc0Y2N2US9aSGY1d0pzNnV5NmZ3ckdSOUVaMUlIR3lLSzU1?=
 =?utf-8?B?ZlhZMys4eEpiekc3Y2llZEhFUGlrSU5uVHozWCs0ZWM3SVo5ZmRJdE9udTYr?=
 =?utf-8?B?ZTNadi9FcTd1c2pkOE95QkxGdlVhSDllbW5KYmF3RW5WNGl0a25RTTFpRmcx?=
 =?utf-8?B?c0U1RVhwKzFuWWNJVkNRRm5WRTdodXpwWnhEVXRDaTlYMUxGaWd5VTRleVp6?=
 =?utf-8?B?cTBNNkgwRnBLTkFxQ0NrRUdsd2tEQzNUNE5hWVp5YWI0N1Y4dFg3elQvZUtX?=
 =?utf-8?B?QSticFRlSUtaaVo2dXJ0dW95YlRUaUN5cmp4cUpCSnJXNHhLZFpGRGpXcVFT?=
 =?utf-8?B?TUJUaDZGK2doa096bmFQRjlTZmRCYXZQb3c2SUVoZ01NRkpQYTdrMVkySkE5?=
 =?utf-8?B?K3BsRkhNSUc0U3d5d1M3RXBlUlNyam8ydUdWWWRrZW1La1RVSk1PMlFLeStP?=
 =?utf-8?B?cENoTVZJQjBMdWJTV0N4MHJrTFoyT05XRnBaSmtmWVUrZVZIdW5tUHZRNzVY?=
 =?utf-8?B?eWRsZTJkR2RPNzAzamZ4VGliOFNoUXBOUXh1ci9qQ3Q5Q0RnYUpwbXFVZEZh?=
 =?utf-8?B?UzhjNlFXb0FMTGcwWk9JbGFTSUpPR3E1WWg0ejFXMlVDSnNUbHROamxjQ2sw?=
 =?utf-8?B?MktzdWVZRGx4WnVxZ3FROGFvV2YrSDdTd3pOZnhwdGt3L2txVE5CL09zZkVp?=
 =?utf-8?B?K2lFOHU2RkgvbDQyNS8vZEMySmN6Q0lyeFk1NUpRS1RzeDBMYVNlVm51M1VO?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OGZCalJlR2p1SkphT1pkSENyaGJRNkFmdVZHYmJFbnBDSG1oeFRseXFYakxz?=
 =?utf-8?B?SXZ2LzN4QmVOQ05TZm1EU3JIQXl5V1NYS2Zia3FPY0tUQzJNbE9NL2ROaE5k?=
 =?utf-8?B?Z3BRazZEVDI1cEdyUk1GVjhTQlBGTEloa21JOXdoYkVaL3pvTFpWTUVnY1Vk?=
 =?utf-8?B?Uy9OSWQ5alVxRGRjR2NadGRqS29mRHlBSms1UHlPR2RyUW5uYjMxR1k4cGtR?=
 =?utf-8?B?WGYybGVRMjIvMFFwbkhrcmIxc2FoTlMzTHljdXZyS2xha0tOS3gyejNkK3BM?=
 =?utf-8?B?MHduZEorZDhIc1lPWkI1RWFnNHlFdHNaZURoOFdYaVA5aldUWnI3Q3pLQlQ0?=
 =?utf-8?B?ZHhHY3l6WWpEKzgzRm1ZdTFxcS9nUkdla2psVXVTeTUxUEJYYmRWdWtqUHBu?=
 =?utf-8?B?eFpEUGtQcHh5OTNIc2kvdEJFK2tDbThuejlLOHNIZlhXOVFRVlpzTCsxM3Uv?=
 =?utf-8?B?d3lQUndKQm80RXhpTTlhWTBhS01CYmMvcFZxd2ZxRjJ1Z21kREJPT1E0SGl1?=
 =?utf-8?B?WmcyRkRQQnBMN1JnaDE1SEJYSmZsTUFEemdWOXg3dFBMbXdmL1NPQ3UwOFls?=
 =?utf-8?B?VHRsbkNIdW5iU0FLdVp3V1VoTEg1VHlzdFlzQzBYNUJEdjhIeDUyc0sxTFN0?=
 =?utf-8?B?TUxXUTZQQ25Nc0MzQWN4WkUvYWlOdEVlczJyOGN0NnhOeCttMVd4bXY0aU9o?=
 =?utf-8?B?cE1yOFYxazBpVUs3cEYwNm1HUWs3Uml6N296cmtsNWtPTWpucVJpek0wK2xR?=
 =?utf-8?B?QktUWDFCKzRuUmwzcE1WYW8veVRxTEhLL1NpR2J3REJKN3EvdUJDRHVUUnZ4?=
 =?utf-8?B?eDZmZWx6dTNRQWUxSEJ5OHVaclFQdW1UTmkvQ0hjKzJyVlNKSTArWFZPM1NE?=
 =?utf-8?B?cDV2L0x3bTJPOHBTemFIM0dpaGVLcyt2QjRhSVZxZEZuOWxNMzhYR1JKYlJN?=
 =?utf-8?B?S0RjSExJZWV5UE5ETFJlNEg3ZElWQ3lMc1E2VU14akw0eE9oWXN2aDZ0RXdN?=
 =?utf-8?B?eXRpZmYyWjJjUm1tMmxrS0s3dW9oSGtDak1tS2pCTGYrTlozdFBmUDJ3Rlkz?=
 =?utf-8?B?dkFWL2xWaTVob0tzUVlvNVZnNjd6WnZKQ05LMWJ1Z2ZBVFQyYWhuWXNBSDI0?=
 =?utf-8?B?cHRQZHRtYisrK2NXNmlrN2ZVdFBvMGlJZTVHOFdTSVRlMytDMlJ1bnNSV3Br?=
 =?utf-8?B?anRmdk9vMGtzWUx6SEJkK2JJVjBBVW1aYjBsSHBiMVVxSjlXcW81eUl6Rm9s?=
 =?utf-8?B?Zll5N0RNMk85TFFaR0dodkVkNmVoeTdaOEtwVUk0QTQrcGNvdEN0Z0s1Wmk2?=
 =?utf-8?B?N3JMRjUzQ2pnV2g1dS9JRElJNGZUYnNhaW5HL250bEgyMys3ZDJnWEVxbWRm?=
 =?utf-8?B?WmJuYVNJdWZRV1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edefcb74-327e-496e-cdb2-08db7bd90edd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:20:39.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XndCwT491OVT6sJWSOu6RuRWoEMpDz7tl+h22Q4RiKMPW8YP/02eMpWqp091lvy/sWetZR9WXBAJejUlXjTfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030139
X-Proofpoint-ORIG-GUID: KCXe96qklEVQpL8VzuBtEXEG2Qne4aF9
X-Proofpoint-GUID: KCXe96qklEVQpL8VzuBtEXEG2Qne4aF9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 19:39, Ian Rogers wrote:
> On Wed, Jun 28, 2023 at 3:30 AM John Garry <john.g.garry@oracle.com> wrote:
>>
>> The current @table arg may be a CPU metric table or a sys metric table.
>> There is no point in searching the CPU metric table for a sys metric, and
>> vice versa, so pass separate pointers
>>
>> When sys metric table is passed, this would mean that we are in self-test
>> mode. In this mode, the host system cannot match events in the metric
>> expression as the associated PMUs may not be present. As such, just try
>> add the metric, see metricgroup__add_metric_sys_event_iter().
> 
> Thanks John, I'm not opposed to this change. My understanding is it
> will give greater testing coverage. As previously mentioned I'd like
> longer term we have a sysfs like abstraction for the json events. For
> CPUs this could be like:
> 
> <cpuid>/cpu/events/inst_retired.any
> <cpuid>/cpu/events/inst_retired.any.scale
> <cpuid>/cpu/events/inst_retired.any.unit
> <cpuid>/cpu/events/inst_retired.any.desc
> ...
> <cpuid>/cpu/metrics/ipc
> <cpuid>/cpu/metrics/ipc.scale
> <cpuid>/cpu/metrics/ipc.unit
> ...
> <cpuid>/uncore_imc_free_running_0/events/unc_mc0_rdcas_count_freerun
> ...
> 
> Where <cpuid> comes from mapfile.csv. I'd like to union the in memory
> json event generated sysfs, with the kernel sysfs. There needs to be
> some kind of wildcard mechanism for all the uncore counters. Such a
> union-ing could allow on an disk sysfs, and this could be a route for
> testing.
> 
> For sys metrics I guess we'd so something like:
> 
> sys/hisi_sicl/events/cpa_cycles
> sys/hisi_sicl/events/cpa_cycles.desc
> ...
> sys/cpa/events/cpa_cycles
> sys/cpa/cpa_cycles.desc
> ...
> 
> or perhaps have some kind of wildcard matching syntax:
> 
> sys/(hisi_sicl|cpa)/events/cpa_cycles
> sys/(hisi_sicl|cpa)/events/cpa_cycles.desc
> ...
> 
> So ultimately I can imagine the distinction of sys and cpu are going
> to become less, and we just test properties of PMUs. The ideas of
> tables should be hidden, but we could have a boolean on a PMU to say
> whether it is a sys or cpu type.

Hi Ian,

I am not too hung up on my change in this patch really. It was more a 
prep change for better test coverage, but the test coverage was not 
added yet.

Ideas on testing would be helpful, but that can be once the changes in 
patches 4-6 are agreed.

Thanks,
John

> 
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   tools/perf/tests/expand-cgroup.c |  2 +-
>>   tools/perf/tests/parse-metric.c  |  2 +-
>>   tools/perf/tests/pmu-events.c    | 29 +++++++++++++++-----
>>   tools/perf/util/metricgroup.c    | 45 +++++++++++++++++++++++---------
>>   tools/perf/util/metricgroup.h    |  3 ++-
>>   5 files changed, 59 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
>> index 9c1a1f18db75..50e128ddb474 100644
>> --- a/tools/perf/tests/expand-cgroup.c
>> +++ b/tools/perf/tests/expand-cgroup.c
>> @@ -187,7 +187,7 @@ static int expand_metric_events(void)
>>
>>          rblist__init(&metric_events);
>>          pme_test = find_core_metrics_table("testarch", "testcpu");
>> -       ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str, &metric_events);
>> +       ret = metricgroup__parse_groups_test(evlist, pme_test, NULL, metric_str, &metric_events);
> 
> nit: Here and below. Could we name the argument here, so:
> ret = metricgroup__parse_groups_test(evlist, pme_test,
> /*sys_table=*/NULL, metric_str, &metric_events);
> for clarity it would be nice if pme_test were cpu_table.
> 
> Thanks,
> Ian
> 
> 
>>          if (ret < 0) {
>>                  pr_debug("failed to parse '%s' metric\n", metric_str);
>>                  goto out;
>> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
>> index 2c28fb50dc24..e146f1193294 100644
>> --- a/tools/perf/tests/parse-metric.c
>> +++ b/tools/perf/tests/parse-metric.c
>> @@ -95,7 +95,7 @@ static int __compute_metric(const char *name, struct value *vals,
>>
>>          /* Parse the metric into metric_events list. */
>>          pme_test = find_core_metrics_table("testarch", "testcpu");
>> -       err = metricgroup__parse_groups_test(evlist, pme_test, name,
>> +       err = metricgroup__parse_groups_test(evlist, pme_test, NULL, name,
>>                                               &metric_events);
>>          if (err)
>>                  goto out;
>> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
>> index 64383fc34ef1..de571fd11cd7 100644
>> --- a/tools/perf/tests/pmu-events.c
>> +++ b/tools/perf/tests/pmu-events.c
>> @@ -798,9 +798,9 @@ struct metric {
>>          struct metric_ref metric_ref;
>>   };
>>
>> -static int test__parsing_callback(const struct pmu_metric *pm,
>> +static int _test__parsing_callback(const struct pmu_metric *pm,
>>                                    const struct pmu_metrics_table *table,
>> -                                 void *data)
>> +                                 void *data, bool is_cpu_table)
>>   {
>>          int *failures = data;
>>          int k;
>> @@ -811,6 +811,8 @@ static int test__parsing_callback(const struct pmu_metric *pm,
>>                  .nr_entries = 0,
>>          };
>>          int err = 0;
>> +       const struct pmu_metrics_table *cpu_table = is_cpu_table ? table : NULL;
>> +       const struct pmu_metrics_table *sys_table = is_cpu_table ? NULL : table;
>>
>>          if (!pm->metric_expr)
>>                  return 0;
>> @@ -834,7 +836,8 @@ static int test__parsing_callback(const struct pmu_metric *pm,
>>
>>          perf_evlist__set_maps(&evlist->core, cpus, NULL);
>>
>> -       err = metricgroup__parse_groups_test(evlist, table, pm->metric_name, &metric_events);
>> +       err = metricgroup__parse_groups_test(evlist, cpu_table, sys_table,
>> +                                            pm->metric_name, &metric_events);
>>          if (err) {
>>                  if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
>>                      !strcmp(pm->metric_name, "M3")) {
>> @@ -890,13 +893,27 @@ static int test__parsing_callback(const struct pmu_metric *pm,
>>          return err;
>>   }
>>
>> -static int test__parsing(struct test_suite *test __maybe_unused,
>> +static int test__parsing_callback_cpu(const struct pmu_metric *pm,
>> +                                 const struct pmu_metrics_table *table,
>> +                                 void *data)
>> +{
>> +       return _test__parsing_callback(pm, table, data, true);
>> +}
>> +
>> +static int test__parsing_callback_sys(const struct pmu_metric *pm,
>> +                                 const struct pmu_metrics_table *table,
>> +                                 void *data)
>> +{
>> +       return _test__parsing_callback(pm, table, data, false);
>> +}
>> +
>> +static __maybe_unused int test__parsing(struct test_suite *test __maybe_unused,
>>                           int subtest __maybe_unused)
>>   {
>>          int failures = 0;
>>
>> -       pmu_for_each_core_metric(test__parsing_callback, &failures);
>> -       pmu_for_each_sys_metric(test__parsing_callback, &failures);
>> +       pmu_for_each_core_metric(test__parsing_callback_cpu, &failures);
>> +       pmu_for_each_sys_metric(test__parsing_callback_sys, &failures);
>>
>>          return failures == 0 ? TEST_OK : TEST_FAIL;
>>   }
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 8d2ac2513530..520436fbe99d 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -1232,13 +1232,14 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>>                                     const char *user_requested_cpu_list,
>>                                     bool system_wide,
>>                                     struct list_head *metric_list,
>> -                                  const struct pmu_metrics_table *table)
>> +                                  const struct pmu_metrics_table *cpu_table,
>> +                                  const struct pmu_metrics_table *sys_table)
>>   {
>>          LIST_HEAD(list);
>>          int ret;
>>          bool has_match = false;
>>
>> -       {
>> +       if (cpu_table) {
>>                  struct metricgroup__add_metric_data data = {
>>                          .list = &list,
>>                          .pmu = pmu,
>> @@ -1254,7 +1255,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>>                   * Iterate over all metrics seeing if metric matches either the
>>                   * name or group. When it does add the metric to the list.
>>                   */
>> -               ret = pmu_metrics_table_for_each_metric(table, metricgroup__add_metric_callback,
>> +               ret = pmu_metrics_table_for_each_metric(cpu_table, metricgroup__add_metric_callback,
>>                                                         &data);
>>                  if (ret)
>>                          goto out;
>> @@ -1267,7 +1268,21 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
>>                  goto out;
>>          }
>>
>> -       {
>> +       if (sys_table) {
>> +               struct metricgroup_add_iter_data data = {
>> +                       .metric_list = &list,
>> +                       .pmu = pmu,
>> +                       .metric_name = metric_name,
>> +                       .modifier = modifier,
>> +                       .metric_no_group = metric_no_group,
>> +                       .user_requested_cpu_list = user_requested_cpu_list,
>> +                       .system_wide = system_wide,
>> +                       .has_match = &has_match,
>> +                       .ret = &ret,
>> +               };
>> +               pmu_metrics_table_for_each_metric(sys_table,
>> +                       metricgroup__add_metric_sys_event_iter, &data);
>> +       } else {
>>                  struct metricgroup_iter_data data = {
>>                          .fn = metricgroup__add_metric_sys_event_iter,
>>                          .data = (void *) &(struct metricgroup_add_iter_data) {
>> @@ -1320,7 +1335,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
>>                                          bool metric_no_threshold,
>>                                          const char *user_requested_cpu_list,
>>                                          bool system_wide, struct list_head *metric_list,
>> -                                       const struct pmu_metrics_table *table)
>> +                                       const struct pmu_metrics_table *cpu_table,
>> +                                       const struct pmu_metrics_table *sys_table)
>>   {
>>          char *list_itr, *list_copy, *metric_name, *modifier;
>>          int ret, count = 0;
>> @@ -1338,7 +1354,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
>>                  ret = metricgroup__add_metric(pmu, metric_name, modifier,
>>                                                metric_no_group, metric_no_threshold,
>>                                                user_requested_cpu_list,
>> -                                             system_wide, metric_list, table);
>> +                                             system_wide, metric_list, cpu_table,
>> +                                             sys_table);
>>                  if (ret == -EINVAL)
>>                          pr_err("Cannot find metric or group `%s'\n", metric_name);
>>
>> @@ -1534,7 +1551,8 @@ static int parse_groups(struct evlist *perf_evlist,
>>                          bool system_wide,
>>                          struct perf_pmu *fake_pmu,
>>                          struct rblist *metric_events_list,
>> -                       const struct pmu_metrics_table *table)
>> +                       const struct pmu_metrics_table *cpu_table,
>> +                       const struct pmu_metrics_table *sys_table)
>>   {
>>          struct evlist *combined_evlist = NULL;
>>          LIST_HEAD(metric_list);
>> @@ -1547,7 +1565,7 @@ static int parse_groups(struct evlist *perf_evlist,
>>                  metricgroup__rblist_init(metric_events_list);
>>          ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
>>                                             user_requested_cpu_list,
>> -                                          system_wide, &metric_list, table);
>> +                                          system_wide, &metric_list, cpu_table, sys_table);
>>          if (ret)
>>                  goto out;
>>
>> @@ -1697,18 +1715,19 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>>                                bool system_wide,
>>                                struct rblist *metric_events)
>>   {
>> -       const struct pmu_metrics_table *table = pmu_metrics_table__find();
>> +       const struct pmu_metrics_table *cpu_table = pmu_metrics_table__find();
>>
>> -       if (!table)
>> +       if (!cpu_table)
>>                  return -EINVAL;
>>
>>          return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
>>                              metric_no_threshold, user_requested_cpu_list, system_wide,
>> -                           /*fake_pmu=*/NULL, metric_events, table);
>> +                           /*fake_pmu=*/NULL, metric_events, cpu_table, NULL);
>>   }
>>
>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>> -                                  const struct pmu_metrics_table *table,
>> +                                  const struct pmu_metrics_table *cpu_table,
>> +                                  const struct pmu_metrics_table *sys_table,
>>                                     const char *str,
>>                                     struct rblist *metric_events)
>>   {
>> @@ -1718,7 +1737,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
>>                              /*metric_no_threshold=*/false,
>>                              /*user_requested_cpu_list=*/NULL,
>>                              /*system_wide=*/false,
>> -                           &perf_pmu__fake, metric_events, table);
>> +                           &perf_pmu__fake, metric_events, cpu_table, sys_table);
>>   }
>>
>>   struct metricgroup__has_metric_data {
>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>> index d5325c6ec8e1..b5f0d598eaec 100644
>> --- a/tools/perf/util/metricgroup.h
>> +++ b/tools/perf/util/metricgroup.h
>> @@ -79,7 +79,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>>                                bool system_wide,
>>                                struct rblist *metric_events);
>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>> -                                  const struct pmu_metrics_table *table,
>> +                                  const struct pmu_metrics_table *cpu_table,
>> +                                  const struct pmu_metrics_table *sys_table,
>>                                     const char *str,
>>                                     struct rblist *metric_events);
>>
>> --
>> 2.35.3
>>

