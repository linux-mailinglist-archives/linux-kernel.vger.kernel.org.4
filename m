Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBCF6C6C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjCWPkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCWPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:40:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BA1BAF1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:40:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCxAAx009914;
        Thu, 23 Mar 2023 15:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nbZl8NVP45z+psW4ftfS4MaHMaQEpKgLCC3o45q2QiA=;
 b=ZNLZMwET14VnzyNcE8o/UG9u3P9MDXyu6TwjlE+clMXjsCDRUlib1rskNPsHaBq8edXs
 YHnfkL2WR6RYB72l084pi8FyMkhb6OXdu1OxQjr1xANYKbjTKcSDK/otBfFYQJbPjS8G
 FK9AWIEeWIA4wvHvtVOICItVTJLAEZ6QaHzdUrnhPIMdSxUyAeYoFdMNbr+qxrHOFtd9
 w3nHXVgXeGoIgKmxTN9J7pOj5IOYB/NbzJ4aB56cfU27y9tghousM0eQ05Up2HOPy0fF
 bJn91RchQNxcWGQvPoiTbc5hgug8WBksWuC58Yn4GPttaBmt5N93qEox+0FR8gSe2JEk 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b41pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 15:40:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NFbBsw002853;
        Thu, 23 Mar 2023 15:40:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgrgc3p72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 15:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgWgO+KFegdMg+LJq7bx1ql2B5b7r+Fsziaut9+c5zUMBXQv1sgo14Pn95p+zDwPJK+cA70kQBbt3UF3VhID2WXyFF+gEtPu1fqvGMZq51eQ1fZZfkLnWnUrG5w+mZMOdyhFqL771SW36smxGQCjHvJpj5J1TyLHQ++RVToCPkTrS0D09oNRLTJvtrN3JzF1eIlEqRIAtXemfizBoCnv9PpwvOoANfhVjlv/6Z4dFPzplstFY/38SWP6yC0LkBHRO2GO/YoA/OKbGOoiQ8qJ3Zm5SW4bg8z1iz49moJxEYmBq5J5iZoEfN6WSys8xWrXZd7fd8YVcditLwPWK985BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbZl8NVP45z+psW4ftfS4MaHMaQEpKgLCC3o45q2QiA=;
 b=nyklVXdx08dMkq7GEV46/bX9o/FKspZqWvRBL3KUdRPFaHL4VK/JJ0LF3e69vdp40b+KS3g+o4lBvbiSxIqfl946wHWn/+wow8HDcJWO7tf/wOTYDmCT6aubCx3bNkhcaybFB/ryZclZOhrOtRFcEIt2vZQe5se6XrHvqUb/pieiGKu6luNwAnDTopCuTyfMvp5/U9R8C5bDx3qY9jMc8d6WAiLxFhHN8EDdoXqHSyn1XJyl4DSSX9dKcsINF4Iw4fEazbLMleSv+TqGfCxY5gIH+DZVAauprw+YXou2+TwIZk2KWUhxO4QpSpeKTvA4N0gppNLIFvmGE0Yw+wbtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbZl8NVP45z+psW4ftfS4MaHMaQEpKgLCC3o45q2QiA=;
 b=sFqzmYqniQOqAzNJJfetHeW8dXnv7XLiWR85Wmcv1qE7kysihaoOV+b1o9KH0cQprNgMjr7COuKhG5uMAZrmTsyIDC2wGaGbuvgLMxy3Vt8TRxBF4odpMArCNQWBQVidjjxcLG+3eJq3EbiuUMxgnmZ5LypYLQ2gn+02d1BZ210=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 15:40:06 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 15:40:06 +0000
Message-ID: <73f7918d-9893-7895-3cee-fef0202d5ea6@oracle.com>
Date:   Thu, 23 Mar 2023 10:40:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
 <20230323073918-mutt-send-email-mst@kernel.org>
 <20230323115049.vsrnufcaqstpxik3@wittgenstein>
 <20230323084648-mutt-send-email-mst@kernel.org>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230323084648-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::27) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: b577ea87-67b7-41e9-5eb8-08db2bb4e083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pezg6J8vbp6OrvVRrc21hGZFezZFqIiRVzwWjDn6B4jETj+HW0Ll7oSZZrFJuiR+tL1uJ6na2yArDPg5BE8aXoyPljGPoqXAc5VYeZYxeuky+S/+V5shgTkzp3Erw7GL0LTSAFuEts3+VdN9gk5ZpNKMobo1TLbb0g4nl4ft/ge16aXACxb8nmRfexBmFUTCl6RwK8JMlZsJkxc8Zr46u4wNT/5FVCs1kmOqeTjBxyOg6K5t5QghL9t+GBgf7v9OVL/Tfz6696iDrd0YuITW2XOMp+uycev3nGC7JQEYi0OQao7JMV8ExTZG27BPUETDq9cpMeD0v9YHVGtT2pEdU3sRjerdIBvBI4FKyo2hQs1NtFcahWId+Je0GfAchl+Ms+0S2jhFuSOuvYQ4zAaGT22D5CLp01o945J2hsNKMq/Hv3IPdezicPW5OOm+DFKsz9UZCTD/yBJ1svA3MStHA2nJXO4wbc0LJ7pawpkNDKPTIo0mrR+Elc1o5/3t9X9IBKj/JZ1k+3vKZ1/T2ItpdnCehpeojK6ddIfgAraW/wU+8+73NK+EXkAIfWpJIh4Vx5VhYAr56Bsm/zNAjMuX/frN0sA0bvgpPGWSThFaqh0Ipic+KraMA4oelAhP16VCkJ+XvBgM4W/I25g3PWUTm6nDgKS6QSDsmA84L5tNUb06cr8LfDQOkpsBQnlGQbQD3+hvPznKzDE6p3N2yWBIFgidM/duzJY+KsTzwGUIciU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199018)(2906002)(8936002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(38100700002)(6486002)(110136005)(83380400001)(2616005)(186003)(26005)(478600001)(53546011)(6512007)(6506007)(31686004)(66946007)(4326008)(8676002)(66556008)(66476007)(66899018)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRKK2xBdWlRVzFwL2hWY2t0UW9oaFc1Z0R2QTRUcjlGSWFmazN1N0l1WVB2?=
 =?utf-8?B?YnAxLyt6ay96MTlmNnFpZy9IZGFmeEphRjdyb2o4OU4rRDlXT3haZWRxY29h?=
 =?utf-8?B?dkg1T1NhUzNjWTRNc1RiejVDK1VrM0lXK0ZOQWFobmFua1BpUnZCdEhZa05y?=
 =?utf-8?B?aTlLZG9qd084SWdDVHJyM2ROdEROY2NlNllRdC9BY3pyVGtnYkVhWnJKVnZs?=
 =?utf-8?B?QUlJTHBhVVp4RXhRQk1kVUhSMUxhWXRFZzduMWh4dkRyQ1o1NUdhZjl4MGlE?=
 =?utf-8?B?SngyQVhCR0NNUndMSWV4d242RWsySUtQQWhrNDFkR0p4N3d5dWlTYW5ONk1o?=
 =?utf-8?B?elU5bUJ6RXZZTXNCanYrTHZmeHpvWncrT0swdEZwdWFBci9DYTlsampQazEr?=
 =?utf-8?B?aFJ1WGVzL0IraitpRlJxcFhXUkwydGdGc2tjVkFteWNXRUIvRnBTNE9wQWsw?=
 =?utf-8?B?b2dHclREV2ZaUFZLVzZiVG1VcVFFZXl4RnVycGlQNVBvZFhUQlgwMHZWWXlw?=
 =?utf-8?B?cWMyRWxUTzFXTjhpMThPcFJSZC80YnZtK0R5TUFONDRPTFRqN1B5YlYwckRG?=
 =?utf-8?B?NC9Ea1lxOWF0blZXeVRuMHJXM21XWkxwSmkyQ3F4MEJFRDhBbVR3THQ0MHFR?=
 =?utf-8?B?bGZCS3laRmRmS1lqbkVJY0lTQURGdjRoMCtLS0RIMDZYaTJETjU5R2V1Smgr?=
 =?utf-8?B?UFREWTBRNlFaMkh3Y05FdlhocDVzNVJScTNuVmxneUs0QXQ2WHFFc1pDQzBu?=
 =?utf-8?B?c0lYenJYSmdVdEl4aExGV0xHOE9VK3A2R1FJa3l2MDV4YjYySGU0MVRJaFR5?=
 =?utf-8?B?SVM2SVVIMDlZZzBOVGVoN09xL0dUVy9zQWNPekp1YW1iT1gyZFJjT3lSckc4?=
 =?utf-8?B?TUgrWkxsUi9sVG9CaStkZnJhb3JyeVhFaW5aYjZtNEZoWVdrWmZpM1o2V2lN?=
 =?utf-8?B?cG9wcFdUazBNWlNGemlHQll3MlQvV3VveGYyOGxRM1lub1JNckVQZnl4RFZS?=
 =?utf-8?B?VmxKa3hkYkVXYzdEQzBuWkFNcGNPMkZUY3VsRDlrR3BNeE12ZXBiUmNQaHJl?=
 =?utf-8?B?ZnMwcFR1SUhNeDljT3lXRWpqSHpqZTZmNHB6REI3QThZWWJlVERkd3gwa1hq?=
 =?utf-8?B?MkN0MEF3aGQ4bzhGcDh0OE1SSmswa1JjVmxuSjVFL3RTR3NnK3c1K1gzWjhl?=
 =?utf-8?B?eG5aa1VyTnd1Z0JpS1JjbENKeVdCRFdjakYyaE5laFYxdFlOankvdGVaWkRC?=
 =?utf-8?B?RERyQXNpd0ZsZy9QMzBHd21pVlVuOTFadGZIanhSZjlvODZrTHVxNElYUTNp?=
 =?utf-8?B?TVc2OEU4TzcrV1JIOUtna092SHlZUlZVT1UvYmhDQXlldkFYN3U3dmRzYWx2?=
 =?utf-8?B?bWx5VjhjcTFGMEVyUkdpOWRhQ0gyYlBsNTRaU0pKTmZkR3VidmF4Wnl5Tk1J?=
 =?utf-8?B?MzArVmt1VTRabVlzZ3Y5Z0l5dDRGUnM1ZWZVMndCQzJUSmJ1NjQ1OVNNTXo3?=
 =?utf-8?B?MmVSMVJMQ01hK1lyZXZtYXpsMmZLYlEvMUhXYUgyMEpjYUQ2aEdaNWxvTzc3?=
 =?utf-8?B?ejUyTktONjkzczFtYmZHNkFKZGZLNWdVdDEyNGhHZEZJQUFvRmhOMjkxc2xr?=
 =?utf-8?B?UlFmbTVSZDgvTlNaT2RJVW95YmNVT1Yvdyt1Zk51dFpBTk5ROXc5bUZtUUti?=
 =?utf-8?B?Y082SE1sRUhIOFpOZHlIZGZ3bmxGZ01qUFNDWXV5WnpjRmNTK0F6TVhQQXJN?=
 =?utf-8?B?YnYrRWYxWlZ1Rkp4LzBhOFkvSGVFeWh4bHJ0eUNvd3RDejI4aDZRaVBKVDNZ?=
 =?utf-8?B?S2Vnc1lBc3EyUitORFJkVDRaNUR2R25FZ1VDL0oyTytnMEpGbXdqcE1TMnFt?=
 =?utf-8?B?TndBam12RE9MSERWQlhXVlZwS2xMSENxL1VBU01LamJkbndRczYxL3lQMGtk?=
 =?utf-8?B?d29BUS9VNkU3QnJiNUwvY0NFVlpMNGlCZDlrOWxCYUhHeVZrbGVzZ08wMkFC?=
 =?utf-8?B?UG4yU1ArbEZKYTE4WGhHVnl3TmRjWXNnTHlEZlpHVmxLODdsY05BR0gzelhu?=
 =?utf-8?B?SFBMSEhFVTYwalZKdktkOXNIL3ltb3JVZTZtVklFbUtTWHE0cFlZd1BOWW1F?=
 =?utf-8?B?RG1FNGV0ZUt6V0VCMW91dUVoOU1xclRDT2EzNHp2S2ttdUxteSt1NnA0ZktG?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ejhmdlJsWGxHVFFkZms1NG1XYVA5OUpGT3dLd1FYYUp0RnJBUUZTNmRHTDQz?=
 =?utf-8?B?UXZ3RGhZSUlyWStSVzhmTk54ZFpVWGxyMWJqdnFRcTVFbHczTHpubGNxdHVH?=
 =?utf-8?B?SFBzcEUzMjBkODEyOGo3b0ZoYlpUS0c5QUE5bEFBUFh5MEk0Y3prTlIzNzVN?=
 =?utf-8?B?a0FyV1JnQVZtZnhicmg1SVQxSGRhMlkxL2ZoblVjWVNkUTJOZm1iSTdUS1BT?=
 =?utf-8?B?R3phMEpNQmRMQTAxMzhMZVFsUURMcXkraVZmTWEyZVFDN1NEdy9TRHJuSHlU?=
 =?utf-8?B?K1Y0eXp1TDBBWFFScFpzeDgrcUFHZkgvMTFkbm84RjBlNEZKMitLMUN4RGNH?=
 =?utf-8?B?S3JxODNOMEJpb05aSjNZb0tMaHlNKzYxMjlBTGhGejRhTWcyQUgrbjdEeXJt?=
 =?utf-8?B?elVNNjAzNGdkbWxQZUg5YWhzc21lT1JZb2dsRlpsM2QzQlRnWUxHcnhLcjNX?=
 =?utf-8?B?SG84S1c5L2N4a0hVTWIxSmpNZU5ObXUyV0FCTG83QzFGUXZPZjA3RzhxdXhE?=
 =?utf-8?B?OGRmR2ZkRW5NaDg4M2o0VkxGeGhZa0w5dytxVFlvQnhGeW5YZC9yK1hkb2tr?=
 =?utf-8?B?ek85cDdTYnlXL3BVOHpxZGlES1NEZ3hCTXZCRnYrYjB0R0xsRDE5YzlwVS83?=
 =?utf-8?B?SHdPK211SjB5U0hLVmRKdVpaVlFFMjZabVJOQnpFVXNwQURUbC9VTzlmQ3My?=
 =?utf-8?B?N0Ixang2MWhPRWVCZzBPTzl2dVVWeEpPQXhxVFN2NnZTclE1NFhackdVajZq?=
 =?utf-8?B?S3J6SnI0RzZ6Yk5oQjNTdWFUVk42cWR4dEhCazdPY09VSWhPd2UwM3ZwRGdy?=
 =?utf-8?B?VVJwZE9LL2FuTFg3Z0t4a2tQWGx6U3dwakhYeGM5bTV3RGFlWHVyL3FxZk9h?=
 =?utf-8?B?ZWhHc0FSZGYzVVFPaTkwU0ZIc0RtOUVyandzYnZTQ05nK2xqZkkwVzlrVm1z?=
 =?utf-8?B?Y1BBcUVhZEJkTEdBdXJXNE9VbTB5VXR0QjFvUUU5K1d5VEZHNWhwdkZuVXd4?=
 =?utf-8?B?K0I1WGRtZWJNQmFsN2pkVlBEbzBnOWF1a3JUOHp3bk8rRmZvMENhSHphSmhO?=
 =?utf-8?B?SkMxQXIzYW90eUVPRVpwM2c1WmNlMGlRZUQweU5yVENkcUprcXR2M2c2cUxn?=
 =?utf-8?B?UktOU3A3RVNIUTNLWENSSDVMTUtScUkzaG4xczFlY29ydjR1ZWY3VjhkcmVV?=
 =?utf-8?B?dnFqaEdoRDRwSldVd0hGNjVMSlB5UEpHdW5nSEwrcTNXWlFBekJoR0RuOXJB?=
 =?utf-8?B?NGVQbGxNS3ZtT2JqSmpWSHlid2RBMWhjQ0hORWdTbGFQWUNsZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b577ea87-67b7-41e9-5eb8-08db2bb4e083
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:40:06.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDZAIH4rtZr5Bf3uE4h4GI+ucdVV8gU5ioLFMNQBw731Yn8NX8tr2G7t9b9qUyTO3pllf0lm2LYpAX0HICOk0uvqSAPVXcF6ROM5JijBD+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230114
X-Proofpoint-ORIG-GUID: 7vw9-NTiZ6Hg87D7n_fBUCk0hMJok1Xd
X-Proofpoint-GUID: 7vw9-NTiZ6Hg87D7n_fBUCk0hMJok1Xd
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 7:47 AM, Michael S. Tsirkin wrote:
> On Thu, Mar 23, 2023 at 12:50:49PM +0100, Christian Brauner wrote:
>> On Thu, Mar 23, 2023 at 07:43:04AM -0400, Michael S. Tsirkin wrote:
>>> On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
>>>> On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
>>>>> On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
>>>>>> vhost_task_create is supposed to return the vhost_task or NULL on
>>>>>> failure. This fixes it to return the correct value when the allocation
>>>>>> of the struct fails.
>>>>>>
>>>>>> Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
>>>>>> Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
>>>>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>>>>
>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> The affected patch is not upstream yet, right?
>>>>> I don't know if the tree in question allows rebases - linux-next
>>>>> does. So ideally it would be squashed to avoid issues during bisect.
>>>>> Still it's error path so I guess not a tragedy even without squashing.
>>>>
>>>> I tend to not rebase once stuff has been in linux-next but I make
>>>> exceptions as long as it's before -rc4. For now I've put the patch on
>>>> top (see the other mail I sent) but if it's really important I can
>>>> squash it after the weekend (I'll be mostly afk until then.).
>>>
>>> Hard to say how important, but I'd prefer that, yes.
>>
>> Ok, fold the fixup into
>>
>> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
>>
>> the series is now at:
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
>> branch: kernel.user_worker
>>
>> 1a5f8090c6de vhost: move worker thread fields to new struct
>> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
>> 89c8e98d8cfb fork: allow kernel code to call copy_process
>> 094717586bf7 fork: Add kernel_clone_args flag to ignore signals
>> 11f3f500ec8a fork: add kernel_clone_args flag to not dup/clone files
>> 54e6842d0775 fork/vm: Move common PF_IO_WORKER behavior to new flag
>> c81cc5819faf kernel: Make io_thread and kthread bit fields
>> 73e0c116594d kthread: Pass in the thread's name during creation
>> cf587db2ee02 kernel: Allow a kernel thread's name to be set in copy_process
>> e0a98139c162 csky: Remove kernel_thread declaration
> 
> Thanks a lot! Mike could you give it a spin to make sure all is well?

Yeah, I'll review and retest over the weekend. If I hit any issues
I'll let you guys know by monday.

