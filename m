Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF717070B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEQSXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEQSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:22:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28BAD26
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:22:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGT6Y006338;
        Wed, 17 May 2023 18:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kI7aP++5flwjImaEjKm+0bY8rUGrjAmwxhvFqu5byVw=;
 b=fzu8ngaqQkZ30rHP5GaqSwU+hMMDWcQK4DJtPy78AfSbuFtasgHAfXDNtuMiEQYXUVoT
 jroLQ8cweyZxsC4Ou5P2HEVLLEkUo2jEH9Of3D1HYJQr+o/ox4hLcbVYVCTFQxU3zDfr
 nb531JWikFUSiHFsyQ+2UuBmPqoe+cO7J+my+apgUyX/VLTSDDwqMStBx6Qfd39hXeoN
 +w9HVBP18B9x2tMbvvS0L8xCckYL2nvIZmyI1ZT2AMhzP0tG1TCZ3XHelu+YDPSVLP++
 IbA8T04bwpTGtckMvxt8e4dUGPyrZMRW0+Y1LAH6asSltb0t76h2iBAakZqAK9I+fhvP 8A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdpm2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:22:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HI2K8g033857;
        Wed, 17 May 2023 18:22:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106973j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 18:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StM6D5Qk5ghxZRjLEdvd/7NyiZS6RZ+zQWbg8w9eNUIutLZ0CcyfhSnnvnHFNJjgvQW/w5hh5Dyf+w8oo+HX9hLHrew2xjIce+mCCE4HzGZXqd0IMmTKOkk/J7iX3PWIMOQycUHwBAmPPAjy0s4j/AqQcLOGQrRRdV3iGb2OjO8vPXwHMVlA8mJ2w/pv5ucUcp/gP1p/M0MHTzVWrm6er0AyuHR97jSFWvC9wjvUD8qkvPuExsrr2gDAWudlJic/da9Pggi4hyDpxpYZ0NuO5suI98ssLvVOaWl+GQAPvFBVg6BVbsoQDadq+INW4baaNtIIcCgNK0jKxJh30T4ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI7aP++5flwjImaEjKm+0bY8rUGrjAmwxhvFqu5byVw=;
 b=U8cOZoIvzWdOO+KqgajOigl45jAveHS75g5U+P+WWSxN/nAkZTcHxHyu66XraA8uedMMpF+Jo3WzOKZHq05hxcDc10J+Px2qREnTee8EwvmymlpJvVb0ib4lYNSbDI/NXVEr+oagDJYUiqI5KLLMRP5YplrC3L8WYeXceNwin0W10LJAHgjF0OC1IuaLHp5YMbpKUenwKLERKl81oZOBYzmbGLGE+vWwWdYMYd+aC5x3Qzfts9naXw93Li1XXHNEyh4MbNXlG3uFkns95hLWltenE4/7juIWanAwR53hxgPaxUUBn2vCUWQfbamDzO9sUdivqr9yc/KFUlspa8Nkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI7aP++5flwjImaEjKm+0bY8rUGrjAmwxhvFqu5byVw=;
 b=EEWvhb3UXYCLnd9Pk5ecSkC+IoQ6WQnqvMaPE/vg+Rf6CvRRm1b+Sa52oca+A/84ERFGXRt2Ih4WiqT6gfNuNfdxK04O+ONQiQdYTAtIolqC2ovqRnLNe6NKuEpWidKsc2GpTTLTySB0ba7rg/Fdd1P22xcXpXN0xNj0MPJ+wmE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB6611.namprd10.prod.outlook.com (2603:10b6:930:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 18:22:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:22:20 +0000
Message-ID: <abab1eaf-267f-d61a-a52a-be131cce5f8a@oracle.com>
Date:   Wed, 17 May 2023 13:22:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 <87cz30s20y.fsf@email.froward.int.ebiederm.org>
 <20230516183757.GA1286@redhat.com>
 <87mt24ox2d.fsf@email.froward.int.ebiederm.org>
 <20230517170917.GA17016@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230517170917.GA17016@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:5:134::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e19de66-afe6-4b97-d114-08db5703a6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRET6cEIFXJ4YTca5LCoGV7J/IBMIm/LXW/s+C4VoBIHjgZbLzgg7Tj91XE65vs7S2FxtxwY/RNRA5lZGS7CRYnNnxIPm4aE7zPc2++84fZPWDgO2UtB+qsi2nGWdKJCluQUi/wzH6c9lcK3VFY/juXfIBlXGAIIa1IEgqY2ebqb4D6Cl0ZSmfDlY73InRjgIrOebBFZx0yfBrbcZFwzwl2HPmt1DrkYf3JQqwXRQtK8aJ0F+dbf8PN4OBYqYtiS3iexvZ5O1Iw0xfpHvwaj8/QnIxTlBbKSFLUOH5W9yk8J/PYd7boM6uJEdMv+7pnME9R+5Up8GjpbQ8s2r2jSu+ky5C/fqED96novnxE86pFvYDAVAS0TxYJhKqEqal10dikSz9q2HWIBBDYPJ1Spg3CkK0xs0vuhHDejueONgDemAe7JRVAvzADaj5qtfbZz7euWrtArbkVXhxOhuJZaP7H7VJoHteTrqHLQViCUaI9NvAdmcXj5Fs/mCjSNHF/I5g86EiJYicgdQfmeEb0u9klMNawLTgkZMiROIjZEiuGWenKbg+YWqBFFf404TXKbMQ600MHfcinB6UizooXaUIZ+iIgM2vwX8aXaIAnXoxnOODbF4is6IFHxkFf5GcMF8aHdSKYdPGlpTCMOu2qMcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(66476007)(86362001)(110136005)(66946007)(66556008)(6666004)(6486002)(53546011)(478600001)(4326008)(316002)(31686004)(54906003)(41300700001)(2616005)(5660300002)(6512007)(6506007)(186003)(558084003)(26005)(8676002)(7416002)(8936002)(2906002)(36756003)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXJSNXZZY1RRWkRrR0YwNC9nMnU2bVFwNWNGNmNPbkl1WDVIZllNenZ4aHJr?=
 =?utf-8?B?ZWx4SDdaYlk3Y2hKd2hQOW0vb2VtODZTU1diVCtsUXpQajltQWROSHpMY0Ev?=
 =?utf-8?B?MzNOV1ZSOVpmU2h4djVUUC9pbDBmRFluZ3lmMWUydTNGMW9kZVVnVnJKdWIw?=
 =?utf-8?B?dUlYNWVNTHJEOUMxSUxkUkM0UERCREc1S2pKWFNmeHRIZDJSWE5QUzRQRDJy?=
 =?utf-8?B?MWtTQU03NmlLZEJOdllSYVJXYWY0MHJNRlQ0U1d4Q2RKUmdXKzJ0c3B3c2Uz?=
 =?utf-8?B?alRWU1daVDF3Z3NieHREcStMaERwZkpTaytGUmhIeGhIUVFXNXpNbm9lSmk0?=
 =?utf-8?B?RENXYW9kbm1HVVMzQWpYb29FUW1ldWowdXVaWWN6YWRKTUtWVHYzbWRqdG4w?=
 =?utf-8?B?N25zQ3BBbkxUcEViUDM1UzhKSkVGc2RWZjlHWFRvSkgrclpwMHFQVjNuQWVW?=
 =?utf-8?B?YUFoZC9CSUdGNzhIa0x2RXhOSHZIMlViUkJQQnl1cDAyRWZhbkFuY2JRTWZK?=
 =?utf-8?B?OVhXdnhrZWRMcTF4Qlh5Q3lnRlNPbkZENGhFT1BvMVRBL2RaZ3FkMnZXTHAr?=
 =?utf-8?B?NHVJa0NkWDN0RWVDazZFbnMyTytxQjVHdzdOWjdvTnlNT3JHMkFXS0VXdlpZ?=
 =?utf-8?B?S1pXbXAwVlVURmJQRlhldGc3b0tXbStxbEJWSTFTQXA0Q00wN0l1RGVYTHhz?=
 =?utf-8?B?LzdLOFFIbk54Q3FvbnA1TDVnNUNNL1RKcG1heFlyTHRYN1VBY0tiZE5CUUFN?=
 =?utf-8?B?ODNWT08xRWJUZ2V5WGRra1lYRW9WVGdqKzhCUjI0ODZ0UWNxUllMcmNGNzAy?=
 =?utf-8?B?ME9JQi9yM3lOR2kyaURBY1JoS2hNR1hVOENReS9VR1hmM1pHdTNpNWFuUGVD?=
 =?utf-8?B?ZHE2QVdaais0bFdEd0RQUHNjRmdlTDRiRDE2U2FCQTFXQVFkZnlYQ3h3cEMx?=
 =?utf-8?B?cEFsamdxblZqQjFzT1NiZmFocnVjSTdTVEtzdWZVZ3dYUEJKaUprNnVWZVVJ?=
 =?utf-8?B?ZkxkK0JpMDk4dzVpK2p1UjJ2QjRVZlhFK0k2MWRVaHBXN0dpVlU1a1NXRlVF?=
 =?utf-8?B?WFpYejFWNEZWUFo0Q3kvSUpubXhNVzN3MFBjS1FnSS81WU5FZ2hzY0FlZjF6?=
 =?utf-8?B?bFdRVEpnT0R4ZDN5Vi9JRFV2d0Zvb3JPR3lVYnZ4R1pwVzZ3bTFUKzl5OFVW?=
 =?utf-8?B?VlFKbnpFRTBVUnVYb0ZsNFArTjc1Mm04azVqUlhVNnN2QlQ5MkNncjAxd1Mv?=
 =?utf-8?B?ZHk2QmpkUWZuUFpVdGdDeEdFaWpzZ1FuVXU4aXQzSEhaWUdscEFPcDMrd1g4?=
 =?utf-8?B?YmhSZ3Rzd1JUWVhJeEk4Yis0SVNzTUhLZjZSMElzQ3UxUjZRU1BrVzVmVzVH?=
 =?utf-8?B?T1lDc3Jpd21CMzRsOWk3aHFhZGlKU1ZqVDh5VnBmZ2dXU3NySVZ1c1ZjYzc5?=
 =?utf-8?B?WjJqbWgxRVFrd1pEQlNJLzNYcTBXR3RPUmRDU1VNdVY4YjUyNHRwZ2JNSkZm?=
 =?utf-8?B?M29CcTlUeitzRldCZWlQcmdsZ0pwQlFzNWdUSkprTzVmWXZtNkF6Y3o2ZU9a?=
 =?utf-8?B?SXh5ZjRTSzJ1TGU5NEpaMGp5WUFrL1c3MFZUNzFzWUhPbnpBVXJkaEYybkNi?=
 =?utf-8?B?MHExTjFGdzh5MHF4b1VpdXlZL01WdjJkY1k1ZGhxb3JuaVVxV2R0N1I4K3ZF?=
 =?utf-8?B?dDVQYWFWNitFc2s0K3BvcFJVWUdPT3NiRnpsM0NuK3V5WHRiQlQyWGgyTjFN?=
 =?utf-8?B?RTZFTTlrZFdlb1FKaG5kWjgvVUdtT29KNEpNcTBpWm1xZXkrMHN4RkZnN0VJ?=
 =?utf-8?B?V3JYRUh3M0g0TFJoUzJVWGdMekQvb2xKOENlZEZaSWxKMWMyekg1ekpQTVo0?=
 =?utf-8?B?V3g0bWRnTkEvaUg0VVNJV1JqOTNTblRKUE9YTkx5RjBVOVVTZFNaTlcwRS8w?=
 =?utf-8?B?cU0wWXJvdHBpNDg1cUF4dkYvalRtaU9ZNWQydFloOHBuT0hSOWJSY3ZGcmxR?=
 =?utf-8?B?bWJpcTlBY0JuQkR5bC9BR3YxMEMzdVQrcHVmWStxTXVLTGZPY1VrSzJ2cGU1?=
 =?utf-8?B?TTlacVJOOHBYZTdkdk16cnk5SkJ4WjV6RkgrcS9IOFZTclZGcXQ0cTg0Y1JX?=
 =?utf-8?B?YzNQR041WnNtbEpYaVdqajY4aXNCY1JJSW1Ga1h5YkVsY0lLc05YVjk4QjJW?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OEl5bUJwSDNFRWZzUnJGMnZKTEtBL1ZBNHdrV3ViMThkNXMyemdUb0RZaGd6?=
 =?utf-8?B?dUt4ZmhwRkxxNjNIeXcvTlFQazdZOHQxVDFEUE1aQVJLcFAxOER1OXlHRG1a?=
 =?utf-8?B?V0ZrN2JISEdzZFBKVGN0ei9JN1JaWkk5Z0NrVisvK0tuRDlOdnM3aWtaS0sx?=
 =?utf-8?B?b2VUbk4ybUdyMUJaQ1NVMzd5SmFERUNOSzRCQjg3RHc1SlNOZ1Y0aEVIZmpx?=
 =?utf-8?B?K1h1TDAwYjYwSUZnN2JIY1RtbnV6cVowWjVNOE1vcTF1OWpqaDczS3NZRG93?=
 =?utf-8?B?UUo3bDlISCtCWitIb1BpeUYySThFZkFHYklCUHBWUjV6cWplUnhSNGJFVGw2?=
 =?utf-8?B?UWx2Vlg1ZXBOUE8vT3J5RXI1aUpGOVRYR3gyRWlQVHlTY050VVp3enFMa1l6?=
 =?utf-8?B?VXo5VVpLYndOaDdITlBYYVRLZFV6byt4RmFNYW41L25ibWV2VzZkTmNrajBk?=
 =?utf-8?B?NWdEL2VEMFpoOHZTS091RHFIUUkvTFhrK2xQQTREQisyeklVcTVFUkNIWWti?=
 =?utf-8?B?RGRmd0M1NHBxaURpcDJnbFBjenJGbk51Z2NqUDAvTkR4QjRnNVl0MWNIOWNk?=
 =?utf-8?B?VDB4YXNGNWRmMkt5RlY2OGZ3NE8zbWZUVjF6UE85RGMySVY4MnBxeDcyWHRX?=
 =?utf-8?B?bGhkQXlOQ3FjMGZLdm9DUGsvcGRtcDQ2WjFXQTFuVVI4OUUwR2VmeGxsNHZP?=
 =?utf-8?B?SFJQT0dWL2Z3Z1plUDZkdEhhYVFXcVMzTkZiRmFkaDZLaGJEa1d1Y2J0czZi?=
 =?utf-8?B?SEppRXpCd0pCZDBXYTN2VVFqYVZMOXFFcTNnRlRhQU9VYW16Ulc3ZXlHUmZT?=
 =?utf-8?B?QmRjWndiUDR6cXpmTG9NdkVzUVI3Z1ZoTGNFcEFhM21hNEU0NldmT0xHY0Zk?=
 =?utf-8?B?bnd1THU5WFE0bmIwRUZ4UXdpN0E1MWx1Z0tqbndmRUJsNnh0ZzRBL3RQZGt0?=
 =?utf-8?B?Z09oMkJWQlhIU1Fjc3ppM1ZNOGRrKzdjRzVnWUdGaVdPUi9YZUVwcDdJVzFk?=
 =?utf-8?B?ckJtNWlBOEl3U3lxYUYwVnZITmpTNVptMVd3aDVlaENVY0k0N3ZjSHBnVmFP?=
 =?utf-8?B?NWh2aFg2bmpsbDFIV3E4bHhWZFdMTDVTMFo2ZjRjYktneE4zNWdEdy80UlIz?=
 =?utf-8?B?TlZ5N1NCUDRmT1haS08yQklkdHNFU2p1T1p1N0xKeGhzSEVKc29tazVvUUM3?=
 =?utf-8?B?UkFpYXFuN2xwNlVmdUY0b0R2MHU0NUluSWE5MVZHdnBudWgyak1FbTF5aTRS?=
 =?utf-8?B?UjRYZGIvb1FUd0FYdHJhOXpNOU9MZEVkVVN6bjZ3bDBUTks3VFdDblpCbkFy?=
 =?utf-8?B?NkxraE1KeWwyTTltbk40UlhjT21qdTg5eGd5M3FWWHN0Rm43OXlvL2wyUkNB?=
 =?utf-8?B?cGZvK21sNVlQVnRXbkxzYlBWdSt1Q2R6SlEvL3hkZnVORGdqaUNvWThSODBM?=
 =?utf-8?B?blNGbGJPcUkvUEVHaGtBMHZaVFpBSmZ4TnAwcVA5VndXalA2Q3pYS3RLWW1h?=
 =?utf-8?B?QzhpY2Foci91ZjgwQlNpZmJvUWdsbUxjRkFPNGdoellpbG1LL0NPUzVQekpX?=
 =?utf-8?B?VXViZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e19de66-afe6-4b97-d114-08db5703a6f7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:22:20.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11K3+87DPOLD/6EcS4ZYbVNPVcIsRMFAOK7ISJDQcdxYdiWCm7A0HxEtLnwZ/ACBe+Q0FfN3lsY33xN/pkI1TQuoJCmGwPPkajAKPqjI2bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=909 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170151
X-Proofpoint-GUID: cS_I0ta3ovh4YMCPDdQWKtukHIM70xcL
X-Proofpoint-ORIG-GUID: cS_I0ta3ovh4YMCPDdQWKtukHIM70xcL
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 12:09 PM, Oleg Nesterov wrote:
> IIUC, Mike is going to send the next version? So I think we can delay
> the further discussions until then.

Yeah, I'm working on a version that supports signals so it will be easier
to discuss with the vhost devs and you, Christian and Eric.
