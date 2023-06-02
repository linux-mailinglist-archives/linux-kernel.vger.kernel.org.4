Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F8720680
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjFBPsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjFBPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:48:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C76197;
        Fri,  2 Jun 2023 08:48:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Cqnw3003313;
        Fri, 2 Jun 2023 15:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sbYI22Lui/5TEKH4klgwISovMQAHtC3S7feEXPgapB8=;
 b=tKFUzGFgvU28K+QqrjD8HFqMyaMDgdU7NOR7YVDE+vpfbPGx0i1vGWMwCMzwdJP8IT0b
 HM02Gznd7m1yfRGfe2zryjXm+hSD/lOxJhzsVbzn0lzZKozvvIUdVeKXZVTFo4DcGFcA
 oFu8C2J2Za4xUqi+Y4LZw28vjCFXjJwKZMUq/+wuOZpULJTRmepzA2MGJjUYuPbcWM6H
 RvYrA3HYcEVDGe1tuJiQhPfukIChBBy9O5ua0XSQYjcDs1+E4LQEynjrF4Csx4Lp9y1t
 PO56+RDax9XdJsYnqEj9KeWBo2hSZ+/9dHYW9cAqCiDOCp93q+XS3AQlQlz1XUVPaaOE tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjua14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 15:47:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352E6hOh031802;
        Fri, 2 Jun 2023 15:47:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qd9rwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 15:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSEMf3NcC094p2X2Q6U9/Ax7CQFLX6o2gNjFPpTPMtRLIGlHyO8Gf4gY5as5BQ7UA7KOJuKFJgZBsgTu0EmUNYanoyYflu7Hx1XAwf+zw7V1ZRvHG1zhRapkGORwW/str6fkzUzW0WZ6C6kUBXL9ND/h2qKD/x11oB2OEIf4IB1axr6Ku6bpyIN6LfPmjEQDJvJ8b/Dj5DQc2hd9ISscweAMqc4sqo1Pjpoc/MIUx41s9lOsyclyncIClASfAKR3eEZZGNLcsWckBe6iSfceX0CIG2nVYvr6riuvVcneLce54f9tBgDNTlfIwXjkZkmHWO0oVH3Tj/CW7/KhM2pcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbYI22Lui/5TEKH4klgwISovMQAHtC3S7feEXPgapB8=;
 b=URbX78jjviV3ugwH+16g6voJqZkRnKmlW92+QUfSUtDhAtrDdBa9rGQ9l8ISqz8XPeBWJnTUksD0bufoCxEzlaMeoZEBwkeeb4fqGlBvpUORhjv2gIvdrrGyCRP8XPxPG+g33WjMUr5T9XmCLOXeWf1ly8OQMsnVL+0QymAB2bEBA//XyZk0QPCyGiMFZsRwcqcrfBjIMPNmLg9/6GhZR6mY9lBoMuHuEAwMdeorwjzLyxqJlM81McIrvgCFd5fNU4jH/DWBOdNWcIA9p40yFYkTwmCXUpyEqjcoApQM0uO4DJtyobY3gDJirPRwSgG7QHhEar/RzXMSfRdZQZ14/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbYI22Lui/5TEKH4klgwISovMQAHtC3S7feEXPgapB8=;
 b=VCUHHjgBsBXXO2BMXq5M+nn6EubsiEYVnf80D5oM4EIeQbtPO/ctoNcdDRmoxcz1/rIFhKsGQ98mom9tbWB5gu1iJ3IypGl0HdGYLFaeJI5vgxWk9yiIW8DivoZ4XXYdLQCnfo+frqmpxSNsHRe4vBVUzcWVD4Y3t69aSZD+XDg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 15:47:31 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 15:47:31 +0000
Message-ID: <690c8fd8-8716-0723-dbe1-65cda2908b06@oracle.com>
Date:   Fri, 2 Jun 2023 21:17:04 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.4 00/16] 5.4.245-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230601131931.947241286@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 732bdf3f-7ea7-4761-c864-08db6380ad28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXlc7oeXVKLBuatrnmMpiKiFbW3RrDNQVM2JVmp9KnfmRyAVi13ksaP0Lf3sy/bs0dKUvXSUsiNBxN00od0Fob+ANeKI/GUkjPjFHXfueiyjRSD9cfLFqs8wY46FZtpwl4QnsCR8Sv6sddSrTg+Do/aUWh9xu/73PdMs4cjIUst/Cm0cAedfw16t7mf8rpl0rt1meGcaDCnkovzIfRK7kiwtrUW8BGY2fIRiekWkwdtZeMX5Uvus8JZ7TtdSI+6Y0qMtIlbh1P9Wgsh5i45tq+QNeLUrffd4ghZwIbn8kIyLIk5ERZ8lAt8trDTzg0qKdfjNOHXe03/W4F4kva3OsCfe/VBgem+mwHV91lfXP1RQxEZ5kuHPQpSqGMuMv3Vst/8nlwXTAA5wdrdFzcxZo9PtU2FFo8iOll2A05iEvc3ckwIEu3z1FSdfZCNR0B73Jndhc1Cpr13mRxMOFwBN/sBN7R4ldVcbFt10UJhzScdAHRAV3hehTftU+D6ttgj09DQAiZNjWqnLbCipbzaXtKXKES83Btm2otmY1nQ4aNroNpNBGnqqSkAQWlCTWUekj0ZkAY/TZmFzQJOJPFhB9zA/bKM8bmR3yNGaaXnpa6FU+3jP5jg3/eIfGNd1iYNRaYCMvWyF7atluk9Zk1NxVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(4744005)(2906002)(2616005)(186003)(38100700002)(36756003)(8676002)(966005)(7416002)(8936002)(86362001)(478600001)(5660300002)(66946007)(66476007)(66556008)(4326008)(41300700001)(6486002)(31686004)(6666004)(6506007)(26005)(6512007)(53546011)(316002)(107886003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBKa1JhbUoveFoxblgrSG1LV2M0Qnd4cWJWeDc0OGtmRGVkTEFEOWM3Ymx4?=
 =?utf-8?B?ZW1EZjlZN0JLVHlTeHlISjBkN1p6aklaNFg0VUZscmYyV0NlTnhBTE9jeUsy?=
 =?utf-8?B?dDRUZGIydVZjcm0wV1hSeDVEY2xhU05jTkY4azNzcGFmWmw4YlIxR3VUZXZL?=
 =?utf-8?B?Qm9sKy9FSHBTbS9aMGZaOTg2WUthWkNwSkFTUXV5bS9jYW41cFVaOEo4T1pk?=
 =?utf-8?B?dXF6YUZSdVp5d0QvdUxkUGNWbUs1WXNDRlNKWFg1bDBoNUdpTTU2czhIN0F1?=
 =?utf-8?B?ZHpLT2hCUXRQUHlqSnZjM2ZOQy9uWXd0L25UTHk0WlV2YURqdXBFRnhGZnht?=
 =?utf-8?B?RkduREx6bk5hbVJxRmZrM2lDQmlDVjZBSmk0TEJoZmViV3ViNXg2VklMY1R6?=
 =?utf-8?B?RUJ4NnRNWWNzRVRieDlrcGt6RW9IVE1TZ3g1c1FNRWhsdjB3Y0lYTU1kMTFj?=
 =?utf-8?B?Ymt1NmxQKzhlRTN5cUZZalBkTEFEeTVWdlY4VWNrZGhobkdFTy9SdHN5aDY0?=
 =?utf-8?B?Mys5bzU3bWhjeEkzL1RPQ0dpWFU5WWdYbmVmSDdrVGZhK0M3aGRZdElTTGM1?=
 =?utf-8?B?dDQ4WkNXbC8zazFIaTUrYkdGVTNxQ3ZSZGsydy9qWlNuR3gyYkRCSzdnN1ps?=
 =?utf-8?B?VklqclBabjFiSGY4YTd6Q3N2amlzOS91Wk1MRnZMRnpBamZ2TENWYndmVEo5?=
 =?utf-8?B?cTI5UXMvTS9sZGpwNHNNWVNZbEd2a0dMODhCanVxMW5RWlBuMVpTNnhlbE5I?=
 =?utf-8?B?bXo0U29RM2pacUt4TjhwRkQ5Q01OR0tBSzQ4WW5sRy9qRzk0SWtiZDF4VFR4?=
 =?utf-8?B?WWR1dTF5dkRSYStJVVRoSVhSZER2SnRzNHRlZE5XKzc0ZnV1cXRuVXV5T09M?=
 =?utf-8?B?NkxiS0s4T1loTnQrZXp6YSs4dW1DMlFWTGRKZEluYWF5MGMwcVg1TDFEM2JX?=
 =?utf-8?B?K3NkYmpXMlcrVVpuQkRWclVmbXJFSVBkeklRcE8zeHFKWjVaaHRPTmVIYmVw?=
 =?utf-8?B?NXVENjhBalV2RWJYMUNKdFlyK1BNVWpyZHZaeTFCaDVla29PSVl3bTZBV1pw?=
 =?utf-8?B?R1BEUE9zTlhRMUtzbGI0MTYwMEVRMHFjQUE3NmVCS0U1THNPWHVYdVJLUnBa?=
 =?utf-8?B?czRUVlpiOEFpOVE2bkJZQUNITkZiTlVUbkR3TzRlMmpMWURpeDhtR3RGOUdz?=
 =?utf-8?B?TktWWXZ0WTZuQzBJS0lUMFZQTy9vaVBkTVMyL2NyZXdTUkUwL2ZUZHpMS09Z?=
 =?utf-8?B?NWhwdVVxQk5WdjdlWHpROVl5ZzlSWnVkenl3dWNIRzQ0bnVOc3ZUY2EyVG5u?=
 =?utf-8?B?Q1FpSnl4NEFxV09TMlF3MWZZMTdLdGpJbnZsM21KQ1B3VlcxRno3Nm9FdDJC?=
 =?utf-8?B?QTBMaW5TR2NUSkgzcU9zRkEvb05qWnk1aEhQMlBZOG96RnV5UzNKMHpURXJi?=
 =?utf-8?B?ejREeE8yREZHRFp6ZTR5Rk5lazA5TUhrbVZGa2NIWEdTWWxUU3B3b3JaemJh?=
 =?utf-8?B?VDAyTTg4d21rZlh1WEZSNEsrMXhET3hUUW5YOGgxZTNDYWFueTBKemNmQnlV?=
 =?utf-8?B?OEtrNTJGKzF0YjRlZUpKbFM4dWZYVkx3Vm1KRzdoNDV1Vmo1ekhRUm5xWGti?=
 =?utf-8?B?Zi9vL3VxZENaaWIvTXpkSEJud3VLVUx3K2k5YUZSYUt2NEVQQzB1dVY0dUM5?=
 =?utf-8?B?RmJoTVhkY0doSGtyRk56S0tUMytZZlNBUjNpc1Q3VXZDREhQcy83QVVjczdR?=
 =?utf-8?B?NVhsWlkxRFRLeTQzaTVOcDBVNjhmNzdMNEdGeVJOb0wzY1RkdkVVblFLQi9Z?=
 =?utf-8?B?R1ZUZXAyY2dtZEJ6ZTRObC9zVVVFbTJtVVIySDF4TEhRZHY3WlhNYTA1UnFY?=
 =?utf-8?B?REpnQjN4eFRPbUxON0U5eHZSaDRxYkF4RWlkSUw2dVgrOEZJRWxWRy9Ya2pD?=
 =?utf-8?B?OXF1ZlVIVzFHM2dlNndHTG1YNURSVm4zcjc2YS9qaWJ2Slh1NFFGaEZzOFhw?=
 =?utf-8?B?SUg0ekxjWitGdkpkR2JlZ3FRUmJ4NFlkcExZVWNHUEhGdjAvOW1FaVVNUmtE?=
 =?utf-8?B?Q2lvQnhLWFFLNmhKWnJTL3JzU0hRYzU5dFZQUjVUSFRLM2gwTVN4MGxCMW5p?=
 =?utf-8?B?cVYwM2xCemg3RWJ0MU40TnQwL0pmRXJZYU1NSmVqY29VakFxU25aa1Y4c2J5?=
 =?utf-8?Q?Zt8EwIp1zh3zKQcDr/azTdA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UDFmY3p3UTRWZXhpZXB4OE9McnhrNWdqS3JMdWc4Q3hYT2lrZGJaMlRkUGRK?=
 =?utf-8?B?dWh1N05WSHJRZkxtUmo0Z2xJaEowRnJoWTF3UkZBdldwTXlNRllLYjVsNnZv?=
 =?utf-8?B?d2FwNWM1cjNNTmtpNXNuQ2N4bXNtakhzOGJyeFhndE90dmNIR01OeEF5Q3hT?=
 =?utf-8?B?OVlNS09uU2MxR01vOXNKTTRMZHVEY2NQQmlRd201eDlheGRaL20zSHY5b1FB?=
 =?utf-8?B?bTB1alVjNlpFR0NmajY4SUxsdEsrUnRPSkFHdkc2U2I0c0VBdzlIMEJJWUFN?=
 =?utf-8?B?d1g0bHlrdVZlMzk3aUJKOTBvM2ViSnEvREZjZXRaWUdBK04wV2hHekdjcmZQ?=
 =?utf-8?B?QUp0ZEtZdEZTV1lzRG1vY25MMlY1TitIbGtZNmxLWC8xSWdBdXczWXVpci9E?=
 =?utf-8?B?K3VZN3lORFVVdElkb1ZCWUgvdXVNZWJaMDRZaTZEY0dwZ2FlcjdjTjFRSXJT?=
 =?utf-8?B?NWFFemhDSEZXbGVpRE1mWnZIbDdDMUJ0QlUxWGNQOWU5Z2pqdDBiWmRnNXV5?=
 =?utf-8?B?Vm94ekpUWGNMcmFIVXVhTG9pQzBnWjdDLzh6Wk5wTU9mVk8wRTBKNDlDTVli?=
 =?utf-8?B?a1pYMU5aa0lub3J4MnRDRmYyRU9PS09RN2FEbUdJVDRwN3kraVFZOXE3VEZQ?=
 =?utf-8?B?WlNrWUVqRUk5cmN0S2FhMG9Yd1hBRUx0empSTyt3Rjd1YlFUTG1oL1MzOHdO?=
 =?utf-8?B?QUhrNjRIUUY3Vy9lK2JhaW1WbDQwanVkZXFNUVlpdVNtTktodmZVanhJZEpB?=
 =?utf-8?B?cUxDWitiQ0Z4Sk0xQkl1cFBTZC9sa01CbTV2bHJSVFRVc2pkUURJVTJ3Smc2?=
 =?utf-8?B?bW5PT282TllzbWlRdE9jUzVQQytxa1VlRzQ0RHhWUDZJa1lNWWlJMjhBckYv?=
 =?utf-8?B?U0VJMWNHK0Fyd2VuM0puYmNmK29EcGkyemVSR1Q1eWxvNXVCRUVjb1I5WG1T?=
 =?utf-8?B?ckJYUUROekR6SlBrMVRRajVlVXU2NW5EYThXUjF0UmFsTmppOWpic05kLzR3?=
 =?utf-8?B?WFVXRkNSU0RmQWtzQXc3WlBYK0VBNGVmazdPNUtHQ05hQ3MreWRRSG1ibTZp?=
 =?utf-8?B?N3Y4MUpOTHppRVd2Q3FSMkRDZ2plY212OWZLTTAyZ2RMTzRVaFM2SUl6enB0?=
 =?utf-8?B?YmJTeFl3SWFMV2Y4M1pYZURHWXNOVDdhV2YwZ1JWVTNudjBDaWtWd1hXdytU?=
 =?utf-8?B?Y3ByMkJwWDM3R3BZTVc5c0VuQUpvSVRsdUlHWXAzZnJSY0ViZm5obXFaVE4w?=
 =?utf-8?B?ZXJLUE5vL29Nc2I5a1VhMVAwREF6eTJHeDllQkh5QlRkTkhSaGRXMGhhdmdU?=
 =?utf-8?B?ZndHenI3bUV0Skx6UWlJaEFGcnQ4SEFQd1ppZWRtVVJvVGxGRmJxTm1uYldl?=
 =?utf-8?B?YUVXZ1U3Zmh4OERkRnlETGNOblI2TEZVTE1pNTU4VHZuT0YvRjBBaXVYODNJ?=
 =?utf-8?B?bkd0bEczUlZZVFd1c2lpUkRnS1V5VUI3TVBjOGdVeWdtYUJPd2NxRzlXdjhP?=
 =?utf-8?B?ZEF5QmIwSjZ2R3kwU2FQN2wrenNFUzVKU3MxTTdIYjVON3hrc1l4N04wR21M?=
 =?utf-8?Q?4wwi25kmUGS7jv1L9c5Ff6T2LcizTs6vmptWpqsNx/eVMl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732bdf3f-7ea7-4761-c864-08db6380ad28
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:47:31.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbePb5wkAaXvpu1kiNChtvqPVlA1UAHST2aYCt5n1hxVDWEAkHTkoSexuzy+PrJbaXUhbWVoJXlUUmMiCePk61XQRVNcv9Q4OtgtKE5l+lzbuE8B74zHrl+BzRQKJ/Me
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020120
X-Proofpoint-ORIG-GUID: 5lxtGn_hcHvJl3iasNOrHCZA2c0ZagOp
X-Proofpoint-GUID: 5lxtGn_hcHvJl3iasNOrHCZA2c0ZagOp
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On 01/06/23 6:50 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
