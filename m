Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE365C846
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjACUmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjACUlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:41:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CEEF0D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:41:49 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303Jn0ac005591;
        Tue, 3 Jan 2023 20:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PMWevr6d4J682B7tfyH8LkkhLNv+gcCfzKsdi7NhCZE=;
 b=nd2trsc4+12C7q/7zRvaNkXkPnx/0ejO8moafSoxlrAm2JhnHwYKptCG8WZMUlYBMGkJ
 pxEbyw6vmQnyNCmDT4soxD8NztIwcrjKHGSsxyVqI3M9HsOIvzkbJuvmeGIy/7hRcH/c
 l2kRPG9GKrKVpkwRBU6tVtrQf+qL1aYw8c9OdwNSvFmm4mhlpQcS3wXD0Dfavr+vRzjh
 b9byZryfdclBh238baG8UXgH1iIvEEDhDNP3GNbjTzPdSfbxMY51RvyIxZIrHJFF8qJx
 BIEaS/5BgzGF0B4EtLtm85lEMYq0mcX5Bvdl4hSJEdBFkKcrmGjw30HW59ZgWIj3Mei4 Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv2w4h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 20:41:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303KIn43023165;
        Tue, 3 Jan 2023 20:41:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mvu9s0wnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 20:41:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNQUo2+lB00qyENmtMdgCjwesqpzLgdLfIZBiYFqYnjLZOJlndHyNoEoOvYAK7I41OMuToLAXiQVrv/kdanCoV7F0gK6URYIc0lWFTyI2xWLDPY2hjEdkWfG8p7g56/naDnIMz9+vI/YBotIYTrQYhzxMO/84jLQl+QGTMyX8yRrRNZKBbEH5kllUVACWlXoo56DrwGFsWOTlBa+pX1isnUMtXxV4eaeWP2XXdNxDolv8bvdv2WZTgmSa3XaOIyO4wj3RU25NtZATerXUSYdaNX9bdRuYg2OZ6qqn1WkvtKXYjB8qS9yKdBQgNLJ2T5Fd1aq7mq1U0uEfVlsnrzdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMWevr6d4J682B7tfyH8LkkhLNv+gcCfzKsdi7NhCZE=;
 b=Z0Q4gUQQHKtkdngFWn+9/VbJ94XAGpXOrpPhC3H90MIYrDL3jrc6zRlVO2eu30WLk3uvILNU46AgR0YEQ0T7bwoAHnR8ZhJGqnJsXul/zrzfkOMURr2w70LHJ0mc1FPJc37tkW2QGRGEVc4+fBdsSlgHA0U1xqFIUhmeNa3AzRzu7UiTzTPFD73dT/oxUyJSYk+6T6kFHq4312tFa+8X5ScJY3cQ8PMLd9gX7/JXdZh6X/BsPqgXzY7v7eJEFfxYygdDiISnV0qPoZzfxcw/ZAUwYNykTXlMCo9jQ30Sluo3FQOxY8XfGAdFYkN67a/Gnlw65VmE5d/5gIOoWpG+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMWevr6d4J682B7tfyH8LkkhLNv+gcCfzKsdi7NhCZE=;
 b=MJU5uWrNBr8HQUmh81E3YXppBk7ko0cVsW46s3ESe3SPDj85WGg36WHRJePKk4hTgQWrtKFGFafnhdEi9gzeQrrzkEyUAuIROx3P79vjiRXw6ikSgOc+MzRmpYpsV5NqfUK11DJHsDDJYmrrHtm+CKck1wpfAPjij7Zu8nD1NSg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:36:09 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e21f:383b:e0bc:afb4]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e21f:383b:e0bc:afb4%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:36:08 +0000
Message-ID: <6dbb8c10-1c3d-2ad8-0491-049af8ccd89b@oracle.com>
Date:   Tue, 3 Jan 2023 15:36:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 0/2] x86: Check return values for early memory/IO remap
 calls
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, andrew.cooper3@citrix.com
References: <20221110154521.613472-1-ross.philipson@oracle.com>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20221110154521.613472-1-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0543.namprd03.prod.outlook.com
 (2603:10b6:408:138::8) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|BY5PR10MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: ed08d174-8445-49ac-e4cc-08daedca2493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHACh/TdwfV/ZHDhxnPq1AawOD0xs1skenzpmGR9AgUL/MnvZq11muFcrPVxs3GWvQYIy4ZIep2knTbkJPsyHBspFey3PboGUxUvrb1BCe4VRuvHFFZ947tEFKKJVtXcX1SB6WAFsVp/4nXhKoJF229iEJk2mlfxprYfONY1EXsrlyzX6HbaddGIG31yxztMXni8J4xaa4XMIPKADcXQt8SuqKxtWJNk34XABnho97OaRrKOpw9wapZDokp/qGkX+Hv/ZHWCoLLKJ0eDxOyjNqXYlUsPB4AE+rcz6WpMnXWQJk/s1P3hxaJ/PdnCcQllwjEEQ64HUCxqWlMhnY/GTqgBdd60X9txKXH8LODKBRSkVKuxV/5duKnC3GZSWtM8PMKbTUruSfAyUXkqyO+/ovimOgiS3E6cDS3hfQNzL5V+H5F6j+ULyrIEJIvj0jG6Bww+4XcOnohpzU94H6/a2sww4FwzJhgACuzwF0Kyv4Vp+nBe1kKEVXRoSUrXF7wXCkjxcseAn4DDTzuwBndEE6ywS7LwDpvtY96Bxz/7+SepYg2M5pR/v9mo4Dz0ZbuRBSWD9ZDA9uYALH9dLJestIZP66GrB46+D7dl8MH/o9eVxkuWJC+7JigIsDe8Pc76rVhIBakOVliYlYjiqKPV5JIlVW9l1CLCdOjb8L5obCjiQgl+rgfxK396TYzXjzashv1IgKRPwQoufuZ8LbJS9YyBPGvOTXj5sB9A3NwUtIraV7wcPp6nbVOsFnV/+Fo64IdRp5a5lTSXX0Y0EQCtnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(7416002)(5660300002)(2906002)(8936002)(44832011)(8676002)(4326008)(41300700001)(66476007)(66946007)(316002)(6486002)(478600001)(31686004)(66556008)(53546011)(6512007)(186003)(6506007)(6666004)(83380400001)(2616005)(38100700002)(31696002)(86362001)(36756003)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L084TUFxSkJFa0xXcUJ3dEZVcnh0S1lKUkh1SnZZUXMxTzlhYVV3b1FQQUtl?=
 =?utf-8?B?em1nSG84N0dHcWFuSHkxVGhieHpCdlZFSjRNKzNIZS9Jc1lyNHVhRnVuV3hP?=
 =?utf-8?B?QkZUWUc4dmJVN3ZYQU13Smg5bWtBNWNRbEdSR1lSMU9qQ1QwSEVXbDFUaHJt?=
 =?utf-8?B?cXNDTG51dXN0ZWlLbTFJY2FjcWFjZTdGRkx1Wk14ZWlPbUN6ZVByQ2ROTUNy?=
 =?utf-8?B?VUdwVjdVK2ZxWjhIMVR2alNkNm9yQVRENVdOWER0OEszMlRTYk0wOE8xMzFC?=
 =?utf-8?B?dmREUjlIUkZzYzRIWGJ0Nm52Y3pCVkFqbVQwNUUvUUVQRFh3d3poc01JbFh5?=
 =?utf-8?B?ODQrYlpKZEFyWGU3dVNOSjFvemlxMlV1VVJPc3lmVXQ4SDF1MVNwSk9EV3ZL?=
 =?utf-8?B?Z2NVZ1hYZXpJM0VyVytscUdNeVZqQm50em1MSEdkRE5objBKOFAwNkNVNTI3?=
 =?utf-8?B?QkMxRVBVY3FXN3J6MHdRd2o3aFprcWFkWXlHcW9RYlNJY1pTb0o3SE96VGJR?=
 =?utf-8?B?V3ZJQjVHV2I5UVllcnlUNi9IK3BNUlJnR0ZvSk5QbWdXSkxYdW5DYVlWOHUz?=
 =?utf-8?B?L2NXVlBVU1I5ZHcvbHMvM3V6S0tWelkzOXVxUUxxekVIUUkxWmIzOE9YdmZH?=
 =?utf-8?B?M2lIdE9XbTY1RHd5ZDFhWGF0dHhUb2h4V2hoNS9WUkRmSUlSUnZvU0hZeGhi?=
 =?utf-8?B?L0hDR0tlK3JFQzljZXkwZmFRRGxucXlWM0wycGVBWDQ4WkYxTHR2Q0c3QUVy?=
 =?utf-8?B?TXlJdDlEWXM5d1RKM2wvUkVNdjNZSkxTeWlENHdZQjdZemN1NVQ2bVZzbVBr?=
 =?utf-8?B?NEw5bUdRZENwdGoyMUI2WG84N1FWRDZYSmora0lvaXNzOFgxSFhLamd0d2p1?=
 =?utf-8?B?RlQrKzR0SlZCRWdTVWpSV0MzdXc2N3pwTGVTUmlVT3RqNFR2ZkFuSnZUUjRo?=
 =?utf-8?B?MXh0eVpXMjZ3a0tuQ3l1c1BVa1RzQ1Y4cFB0SytYRWZEdzduNWkvNHhaT1pV?=
 =?utf-8?B?QzdmUXpwd0xpdTM4NkwyeCtSdTgvYlFRQ1EyVUVrWnQ5ZWNqY0x2bEtFNlUv?=
 =?utf-8?B?d0s3YW9zTWZ2VG5sNEd1d1hid1AxazQ4N3MyNXpGR1d4cGdUMkkvaTBPWEZh?=
 =?utf-8?B?Z1NNcW5KaEZMOFlXNEl5bVRLQ0tqZWpVdkF1OVY0blVSb2ZhTVVVUUcxenlR?=
 =?utf-8?B?NFZqblAxMGRrQ3cxU1lzUDYwMHA5bVlRU1czYWhCU3UwanVwTnlMdFFsL0RX?=
 =?utf-8?B?NDNJQldLY1NGcVQ0UTVKR2tEWnVSeWlETHFYMzBVMEg0c0JMNEJQY2p5SUdF?=
 =?utf-8?B?d3dWWFFyTXFNN1kvakR1SW9CaTBpVzQ0MUd1UEgza1ZmblA2anJONG14N1Bt?=
 =?utf-8?B?R2J3NUtGdG1VRldteitGb3FJS01NaGxxbm1uYTc5S0NaVW14SUZGVmhtUlFD?=
 =?utf-8?B?TzJKSzh1aWUydVVkZ2d3a0kxOU81Vi92ek9WbXV4bmduQTUyem5YNnd5Z1ZP?=
 =?utf-8?B?SE5KdVJrL0FrNlIxa1pjMXVBak1kVFJidlJoQ2M4V1ZZaDhpWUE0b0ErMXNL?=
 =?utf-8?B?SzZFRGFaaW5LckNlWlpyVGdSNVZnSHo2UmE0UkdNOUMrVEFlU1lCRnJLM0pq?=
 =?utf-8?B?L3pPdGxuLzlsV05maGVPMkRZR0tmcjBjcWllNnpDNDk1MFpzTWJYbG5yWUlP?=
 =?utf-8?B?akZXemFkYS9tQzJmZjFuOWQzR0kzQWlCM0N2WE1qaElPWHI1OWdramw0RDln?=
 =?utf-8?B?blJUUEE1MXdpZWNpSVVmR1QyU0hZUFVPZlJLYWZrd1FvTys3dXZSQU5aWVJ0?=
 =?utf-8?B?dXBQRDAwTU9zOURQcjFWK2s1Y2R1aUhmQ3MwNXJlbW93am9zcnM3TDJOU2VM?=
 =?utf-8?B?L1FLQ3NwUitoQzBuTWIwMExuL0pYY3BTdlZDcHpET1pldWRGU1hyY0I5dGlJ?=
 =?utf-8?B?bjNYMGhEeE9FRmpSYzNCNTgzbldOUytHMVdyYTlqREtOMitiSDQ1eXEyNWRi?=
 =?utf-8?B?MEFyNzI5UVNFMkc0cHVIaWxaRzMyVzlFUFpzcnZCa3I2UDRxNU15VGxHSHFW?=
 =?utf-8?B?cDBmM3hxWjc1L2dOVkRQRjBVNDVZb3ppTFVOQVAzMm44VzFIMFZReE55UlpC?=
 =?utf-8?B?UlFBU1RaM1J0UmRaTmpFbEJOQVFqazBPYWtYbUlvd3F6bmprZjRTR3JOeHhl?=
 =?utf-8?Q?KLBqw4sBE+nwAH+DLZsPZ70=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U1dYc2FFRVZNbTBUbm9BUkV3M2tDOTJMbmJ3Nll5aEk3bVo3ZGRSM0l2VTll?=
 =?utf-8?B?eG9JNTErY0UzOS92bHpzdjRCM0JjeFI4WWxxaHZBZHVtUkpIbElJdFNpMVhI?=
 =?utf-8?B?VTAxRTNkWm1nZTFmMHFyVjBNN1dQVkVSY3dpU25oZHF6TUl6MkJYM3cycDZP?=
 =?utf-8?B?UU1rWlB4UjFlQ2liVFJSSVJPM201MjdPdmJ0USt2Z21sYk01L3M0eWJERXFq?=
 =?utf-8?B?dXpKaDJ2YXpiVE5CZUZJR2w4WUJNb0F5aEV1WTJRcTRhUjY3anpaeXVucnhZ?=
 =?utf-8?B?SlRUc3BqcHUwWHE5RFhrTnFzTjZZL0FlalNOczNmSFRSck8vNC92SkIrK2xM?=
 =?utf-8?B?Z3BPRTlGQkkvdFVGQXI5T2Q1RUQ2TWpvTnFZK1Bpd01SckxycGxjb2M4UDRJ?=
 =?utf-8?B?Q2ZXL0J6WTVRM2h5ZHczSGxocjVpYXZVSlQrNWR5eS9rYThJQUwrVGt5UnRR?=
 =?utf-8?B?K0xSMWwvc0JQcm5WZThlTU9TcEsrdW1UNHFBQWZzd21YTXdqVThXWXpyQkxH?=
 =?utf-8?B?YlZPdURQUkZUZTVXTVJ6ZmVvZlJFRmZ2ZG5mdlpaemtPZ0pGS0tSY2JkSnhL?=
 =?utf-8?B?SFVRV0pOMW82NTQvd3NFYTQ0YVpYRThLRTJCTjlsQlZqSnIvWTFHZVgxck9E?=
 =?utf-8?B?VjRKWitKK2Z2UGlVOUhidlQxbnVZNHN1R3JFUjE2NlN0aTk3MGVKK0lrK3hq?=
 =?utf-8?B?YWM3Nm9vcDR6Y3NjeE93L2NHdTlxNHp2VWl4VW5hRXo2RTVYNHIvVCtna1Rl?=
 =?utf-8?B?NFErRkNBMytIZW1yV1gxZUVLakpUTjAyMm5JQ2pVRDR4QmlTY1N5UlJHWTRy?=
 =?utf-8?B?NUNsZWlrcjZDaWR0SFE4R3hOakpqSk9XU1kzZU5xaE96SFZLa2sraEhzZGEr?=
 =?utf-8?B?blpIRkRXc3c1d0owL0M2U3JoRzBGWlVIMkJUTWV1YXVKSjgwVG1tK2VwUURs?=
 =?utf-8?B?R01uajIyR2Q2SW5TOTA3ZXZmSDhFc3VucU1Wd0VPVFZxQmFhd1dOMjlqVjQx?=
 =?utf-8?B?cjdjc3lRMjFvcnlzQXRkTWkzaFlTbk0ycjVEN3J4d1lMZVY1L3hZZmRxM3BM?=
 =?utf-8?B?dGFpSStTOFNTeWgvV1paS3lvSGhGc200TXRnWHd3RVN5VnBwSWUvdnk2YWlZ?=
 =?utf-8?B?L2tiTmU3R1dMaE11RFpiVFpkZDE0alhyb2x6SFhEQWI4M21pRVppQVNSb0Mx?=
 =?utf-8?B?SXNEQWFiMTlRQmNtbXNGSElxbHBmNGpKZnRKOXRYNC9jYlRqZGpxK0p2T3cy?=
 =?utf-8?B?RmxvM1Z1WDM2K0l6ejZ2OU8rRVVId2M4YjZCUWZCMXhzWHhjZzRTRzJCamFN?=
 =?utf-8?B?TU1QSjFwa082aEFYd2ZQVTczZGgxWWpNd0xqYkVpT1FKMUNKMDIyMXVrZUNG?=
 =?utf-8?B?aVpwazRQdmZjbnlkL3hwbVF1R1RROWZ4djZ0aDhxVzNwSHk1YzdSeVZ4UzdX?=
 =?utf-8?B?NXRJMmVIVjBUVlc3Z0pSZVhkWi96TmtkSXRmcXhkeDg2bS9WUjVWYWMyNnBh?=
 =?utf-8?B?MWErRGxHV3ZCbjI0V0oxaEFnKzc2UXdWamlwSG12U1BqTDJhRldqOFFJclY0?=
 =?utf-8?B?VS9tQWRFeVNPeUwzeUJSVi9Ec3cwNC9MMW5KY01FaXd3TUc0TkxGL284a3R4?=
 =?utf-8?B?Ry90amVmRmFFT2hHa3Bqd2Z0UEs3dFErODZGU1MvSGVSWHVUTkNFMlFIaEQ5?=
 =?utf-8?B?c3lyVUhvUmtFMjMrVlpzeXpqdFlDbXdsaUYrTUJYNlVzZHdCT0w4amVRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed08d174-8445-49ac-e4cc-08daedca2493
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:36:08.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wUYta/Sway5MJS5K1zPkGzSmHXn3y6PYL0T0pQkqNW5bBxQLCpYXQ6IKvf8+W2zrD7YJlBfI+yW6bHuNDSj8IEovoM5nmcxhKZuLKPQ9AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030175
X-Proofpoint-GUID: OcoREfwsY4SJgwNelb5L45jMWqgk5Nsj
X-Proofpoint-ORIG-GUID: OcoREfwsY4SJgwNelb5L45jMWqgk5Nsj
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 10:45, Ross Philipson wrote:
> While sending an earlier patch set it was discovered that there are a
> number of places in early x86 code were the functions early_memremap()
> and early_ioremap() are called but the returned pointer is not checked
> for NULL. Since NULL can be returned for a couple of reasons, the return
> value should be checked for NULL.
> 
> This set fixes the places where the checks were missing. It was not always
> clear what the best failure mode should be when NULL is detected. In modules
> where other places tended to pr_warn or panic e.g., the same was done for
> the checks. In other places it was based on how significantly fatal the
> failure would end up being. The review process may point out places where
> this should be changed.

Borislav,

I just wanted to get your thoughts here since it was by your prompting 
that I sent this second patch set to make checking of return values from 
early_memremap() and early_ioremap() consistent. I have gotten 
Reviewed-by's from some of the maintainers in specific areas that they 
approve of the return handling. I also got two replies basically 
questioning the underlying approach. I replied that I basically did what 
you asked me to do. I have not heard back. How would you like me to proceed?

Thanks,

Ross Philipson

> 
> Changes in v2:
>   - Added notes in comments about why panic() was used in some cases and
> the fact that maintainers approved the usage.
>   - Added pr_fmt macros in changed files to allow proper usage of pr_*
> printing macros.
> 
> Ross Philipson (2):
>    x86: Check return values from early_memremap calls
>    x86: Check return values from early_ioremap calls
> 
>   arch/x86/kernel/apic/x2apic_uv_x.c |  2 ++
>   arch/x86/kernel/devicetree.c       | 13 ++++++++++
>   arch/x86/kernel/e820.c             | 12 +++++++--
>   arch/x86/kernel/early_printk.c     |  2 ++
>   arch/x86/kernel/jailhouse.c        |  6 +++++
>   arch/x86/kernel/mpparse.c          | 51 ++++++++++++++++++++++++++++----------
>   arch/x86/kernel/setup.c            | 19 +++++++++++---
>   arch/x86/kernel/vsmp_64.c          |  3 +++
>   arch/x86/xen/enlighten_hvm.c       |  2 ++
>   arch/x86/xen/mmu_pv.c              |  8 ++++++
>   arch/x86/xen/setup.c               |  2 ++
>   11 files changed, 102 insertions(+), 18 deletions(-)
> 

