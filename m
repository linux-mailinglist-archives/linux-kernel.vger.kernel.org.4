Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C467084D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjERP1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjERP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:27:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3596118
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:27:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFMlZe012456;
        Thu, 18 May 2023 15:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R0SI8ujouNbBdTZeaEZcbl/VWRxGrU9ah0sayal95Vg=;
 b=EDXg2GurJW80pHqRlXDtRsjQVceMq+Iqq4lXwToelvznVd73MbgfF+2dYQIT6xFjhXiC
 1iggv2hpdhlV7W4uh6+Y7gWusZ/rt8oAyACFm587JWbtHYwZjTLjDOcqjkJUu77AfBj9
 0bGvUSBu0/PGl081G83iP3l3qMFcShjfR8UkyiTKnVJGcoTHZuzv5ZxnlW+H2wuUeSsI
 pVLHt9y3aiKG3SyBld1HkYeK09QYR5SEfFvB+bbN/UqfC3szCN1cLRBXIqAz3bw1BGM6
 tDX8dTF6OtWRBxLuZrC3qixdxX7sIeaYPYdnn/20rnKD8zNVs1Z42pw85MTTECfcQg8/ NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdrkb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:27:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE8hGm040063;
        Thu, 18 May 2023 15:27:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106p1r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 15:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k137XBBBCVrWpuPe6sGD+u2YiehYTHn9HcpiDMQoTO8Fyx82d1KXg7bioaPvPzXjduG9FrleHXi/wbSYJySAdZTmu4tz49asTr15EEqHoQCbEVwBk3mIX9BX3rbWqWIBtBPe9A+piq69GjU9i3nqJGYVQei0VurtBmmiQDchbyFqN1K315Gg4BWOOOkVKUhpR1vu9v8ZNXZSdwVqNJmmzP/7/tnL/h/pfiEZ6vpafkVy9dK/zFP5cG/DSD0cAThLC+7fg5qX/3q9CVu4sUEM6FhIiJBPk/OuvWXU5MISBd0vanvUsotHgKqU+WIOXi2cWu9Wh5LoKKbpNeomadDYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0SI8ujouNbBdTZeaEZcbl/VWRxGrU9ah0sayal95Vg=;
 b=bwhkZBLl5wCo5tsbtpvuRpxAfXrZCvXSwqsc/BPgVHd4aFrhUj1ZlCmcMh/7fZ9DxnpHGrXaY5u6f6vBIKSAxlaceEVjxJshD3i2+tUDMZhjiq4JQc1ycU1JtWeTn09NDtmNWfCgBzyjSKZtvkrjUIPTCmj/HOIchiNhWa6i7eQeubP/TmMvCEGG4iOGqUoDyFpZe+W0f8zZtFaSvRWZA954rvvV2jrQoKWWaXVEuD5fd/bwVPt+fzMcoEXTL6AwO2qnUewO0dLg3lAFBKq2Bwry1BUbWslWzwmrndUJK9GOFeHr//57Hyan9t2Wqo13u8Dn8885c8LTqBEpBUK6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0SI8ujouNbBdTZeaEZcbl/VWRxGrU9ah0sayal95Vg=;
 b=sc2IXwPqcoWei/ZseZcUtLb1gDyoyZK32ACKqOFaIG8IhYl1j5cn0fteUTXEndE7BOpw2kKEvliFMOlaMH1/ltc8gwJcWeLuAWPy6FkM7DikeLtWtYdlwWhdoJDPXIpxuqWEjmwOYLa1dFiLZLTBIqQsK/vEs6n85XUtJzqzCN8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 15:27:14 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 15:27:13 +0000
Message-ID: <7412912a-a470-bd3d-fb1c-54c094cc01ee@oracle.com>
Date:   Thu, 18 May 2023 10:27:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <20230518-kontakt-geduckt-25bab595f503@brauner>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230518-kontakt-geduckt-25bab595f503@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::12) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 37afd968-661e-4158-b2ae-08db57b45b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJfFEyJ+in42EHPFw6smGMmr+GrVQA7NaaY4VME/AAF7VCKw2otzkDsKaP0xtF9Bcq5OzCBFRzp4zEAlzdHZ8hhqNfaHt9ffco5siprbNx4uTjkX1/Vmgg8w7vrk26Pt63XCfRT7u/YvzUKQaWbGwnAP/2GUX2n7WtFwmpkqE6gTTcdufJuJZGBPdPqeXFl4DdiQhRSGGFiBwujc4yqIq4Fr76UswFbk92kiq4W9m35Q2lg0OsRX3xDFkNbeuMxGtkAv7UHmo5Lsiv2FfPFubwNl3W8/HDygf99lLVw9dmRMMSZ9psINkfPs5BCmAwhcdS8ERoNOngbvc3sCFOKBv2np21GWNMlcUoXKzxoeN+jmpc+aa4TcPcahqtT9+PV09IzvNbrNFH2dS0uOrAhjO3Fi/U1WKoH2h8MbcV1Yp/aE2RiAnk5CpW/p+SN3PKK6LNv8eI5mZv74Wqs4FtvwmzLHSZtGIqxZ3tpBBX8Jz8zmsxO5o1DelCTcUzABvO4GpSWzmEqTdb5T7UhYTkTnUNt6Lx6GHQpu1kBQnsVyAoETYSd4UR4HvDaAIWGQQrjczKr0uykvjw1NvPTeN/ciH7PbFm9A0LPLHEsThSvWsdoRn0b7XmUgZwusaqq89toB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(186003)(966005)(83380400001)(6486002)(478600001)(2616005)(26005)(6512007)(53546011)(6506007)(2906002)(5660300002)(8936002)(8676002)(4326008)(7416002)(31696002)(36756003)(38100700002)(6916009)(41300700001)(66556008)(66946007)(66476007)(316002)(86362001)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStYalp3STlLTjZNRnNxSm5nWHdaZldFVXFvTVJBWmpIKy9yNXZPUy9LS1c2?=
 =?utf-8?B?eWpielNwTzBMNXc0M1ZKR3ZIYmZqWTlrK2tEeVc2UkErKzFuV1JKdTA3SXAw?=
 =?utf-8?B?aElYNXVmMy91VjFmUUhEWm5UL1dWWTQ4ZGRSMnpFcWFyZEU1bHJCVVJDVnpj?=
 =?utf-8?B?RzRzTXErL3NBRGZ6RDBrN0JuR0xXMjNqczJWYng2VVZGSitpSmQ1dkFyZDF6?=
 =?utf-8?B?Zlk4TUNLUE5NUDNLTGxmMlBYeUhCZkxoWHB6MEZFbCtHVFphNzZRbFlxTEJD?=
 =?utf-8?B?QVlVTjg0Tmd2OWVubDAzOXQxLytYTHZ2YytGdTNUSlhJRUFPL3dUOXJTdERK?=
 =?utf-8?B?bEVnTXpwOEhuM3FkQlN1dTlHWWZUaUUzeGl5SUlXdWJiaXdGRFlsTEIxUDZD?=
 =?utf-8?B?a1I2YU1ybUt3Y29JTmVabTdwZ2RpNHVRV2FFblNxODVLTkk3UDdxYllJRGhu?=
 =?utf-8?B?bU1LOWszeEdZQ29lOElnRkt4ODBSajVGbldpdk1ER2hnSEtZYzAxKzh6Tmhz?=
 =?utf-8?B?dVI5bjRiSVJnU2ZzMTUrakg3K1Uvb244amFXaVVZaUJXbDZWRlNldzJTQlZN?=
 =?utf-8?B?SzVhSk5BYWdsekVDVFpUbnpVVXcwQndvaFJ3SThtMUZ1ZzJUbERBRGdRNjFv?=
 =?utf-8?B?K2FMWm9QZjgvalF3TktDV0R0VnB6blNjc3p0Y2t3Mk1GNWVCRno1VUlqQmxr?=
 =?utf-8?B?RWJETlgvMUp1YkFwSWpxR0FOS1lyYnZuVVF2RUU2T280YmJmUVJpN0ZSaXda?=
 =?utf-8?B?d2NIQ0R0QVBod2VYT0pBY0p4blVEanZGem1aZEQwb2FvSUlMWk45eDBHWll3?=
 =?utf-8?B?TE1Hc1QwcVdGSUw0ODRzZlB3cHpTV1BISnQ5cEN3K0ttRk9wUTk2b0Z3YXNB?=
 =?utf-8?B?eWwwUW84eW5menBkbHg5M2h5QnlMNDVwMjB1QXRsL1RtY2pRbXlCZUplY0l2?=
 =?utf-8?B?RkduNmJPNlN0WW02S2RWb3QzcnhMYjhEUWR0ZDF5R20xQml5Q2JUMTc5Unhx?=
 =?utf-8?B?eGM2a2swREdLYm15VnFpWjhXWXJUOFNxL2xZYUNnQTQ5UHd4VXBFSWZBTytr?=
 =?utf-8?B?dTQwOFFVbE5MVXhYaHZWUmZRQlhPR0pBN2N5UktOeHdTYmZxN3NUdEJjUFRH?=
 =?utf-8?B?Yk50UTZJemIrL2xZeGdweHRzTEpyK2hHbXdmbnI3Z0Ria1ZpVXNsZkk2bmtJ?=
 =?utf-8?B?YnVwelBnQmQxUzZIbWhkSWQ0MzQ0eWZmbkV0ODlaNllyT1dFSW5EcXU1Um8w?=
 =?utf-8?B?OWd1cjJJbmlFY3ZxNWo0QWg2MlBpVmhGWjRrbGIxcmZmRWJ2UlBPdldKNXpT?=
 =?utf-8?B?ZzNsTEt2QkdNL1dlQVdnaFZHREtkaEE3cVB5UkY4d3Nkc1ZsQm9uaW9nT1d5?=
 =?utf-8?B?UlNSZUovUk1ZTEUrM25MUXJGY1Q4Q3NsY3l1OG9IblJEMk1qOUNLTEQxTDNX?=
 =?utf-8?B?bWtSaUNqWUs4RXRsejVmV0pOQ1gvRk5Yc0JuR2JIMGtvQmkyS3NidG5lVXBl?=
 =?utf-8?B?aXFWK25SanFibXdmdDF3OHh1UjVBaVNKdWlnSFhKa28wQmFuZktWcnM1SVhk?=
 =?utf-8?B?ZDRqdlVOc2JxQW9uUDFVVkhPeW5SRWZrTjFRV29xeW1JNEV0VENFMEtiQWN4?=
 =?utf-8?B?NkRqWEdtbkRxZURNWTN0NzhQaC9Pd2I0YjZWWVBaMnp2MmtEVzQ4a3VwRmIy?=
 =?utf-8?B?QTgrUHRPZm81MDN2MHBEL21mNE1mQjFvTkExK0x2ZUJkYmo5Z0cyampNSWt4?=
 =?utf-8?B?VjQzT09MK25ldXFXVWFGSDF4TFhDRVBPRWJ6dUdsSEYxQ2I2TUtVOWY3KzJj?=
 =?utf-8?B?eUI3NklNNktYMDJiT1hiN2V1N1h6VW9PeG9OY25QV25wdUQ1N0FFMS9nRXZK?=
 =?utf-8?B?a0JzdVNZeGFRK0RmQjZkQTgyOFdsanFXNmg1YmhNOVZaRlFmTDZqMjRTQUpT?=
 =?utf-8?B?RXUxVDM5ZFdBSURZRklOa1lyRnUzdmtmbkFtSUJ0Z3EzMWtNTllIZUxkMkZF?=
 =?utf-8?B?aUlVNkY3UWVyTUdzcWpuZVMxY2xCV0RFSTY1WklpcDNSRTV6Ui9uOVp6TXgz?=
 =?utf-8?B?bW5OaDNZSjJkVzNIRTF3L2o5UGFQZVV3VThTQ1RuY2g3UHlQUVF5ODd5cjhk?=
 =?utf-8?B?bm83bnR3Z3lVSlU4cWFCYmRNMnVhM2VteUtWOGU1b3V1TkhqNXo1NDNpYlRt?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?akVjUmlLdVBITEZXN3BvRzNnZjhJR0dGalN5YWx6dW5nUGk3a2tCYStaYlVK?=
 =?utf-8?B?UkJlVG1WMFhMSXA1Z0x1MEF2Y2YxaWFtS0RSMkNjT3IxNkNGVlF2QkFNZjFh?=
 =?utf-8?B?N0xZNmQrME9WeW9BN1Fyb2lScmoraXB2S1FuRjhWMmw5WjR5UmpRUWFYaVF3?=
 =?utf-8?B?RzNxMWU3VndudENiRHVvK1V0L0NNS2h3TThnTXJrdzUrMDhvOEhRTHNsU1Rx?=
 =?utf-8?B?UFlwS0tPZ0FCZjliL1N1akNYWXY1VDd3dTNiTU5QaURVOGl3SCtwVE9OZFV0?=
 =?utf-8?B?RE02M0U4SE5OQXhEaVg4ek5PZUsxdjlWdWh4amdDcFl1UnlYRURQR0tlb2M3?=
 =?utf-8?B?bGY1K2ExaXZxekJYVTlGbXFaemJNQUFDZUYxcHREYkc3dDY1ZGl2TUFCSXFE?=
 =?utf-8?B?bS92OVl5M1NacjlSUzBCZkRMb1NQL3FpOFRQZ1pENlZsRmlYKys1c0xLTWd4?=
 =?utf-8?B?MzlUL3VmZHNQOWpHUm1XYnpGOWFEM3hqK1F5c0dXdmJ2eGpPZ2N6ZjY0dFg2?=
 =?utf-8?B?RFEzQ21BZ1l4V3BxOVRIMGN4b0hLbTN3UE9OckNuSFZFRmlLZWNCNjl6YnNT?=
 =?utf-8?B?Y0gydlBKSjBCR2hFcklCeGRIT3VJR2NWTWczTzUzMGNqSS8vZ1VLVml5cll6?=
 =?utf-8?B?bWp6WW1hSlVRNVRtempwcmZXeDcwWEtGeTZEaHNtQ3Bkc1pFcVYxemQ2UTBK?=
 =?utf-8?B?S3lENFozMURIc3ZkQ0NQWXlPaW9GUElrc09KQkI3Njlkd05DT2tJSE9tVDNP?=
 =?utf-8?B?b1diUmY1V2YvMXpjeE5IQ3NqVkFRT0dsdzZ6VEpqbGw0cGNXRWxaNVFpd25i?=
 =?utf-8?B?R3M0YnF0TzdMU1drZnB4Rnllb0REeXlzSm81RWFQajVZdldiVDBiM2lxQk1D?=
 =?utf-8?B?cVA0bjNaOXArVHc2Q01ySUtnTWh2cTR5dUswR2JTY2t5ZWZ1N2NjTzFHR0Fx?=
 =?utf-8?B?UkZDdkJjWlN5cGYvZGtacHRqZjRrTW1Hd2ZGaGh4blhPQ29zRHF5K2p1RHNx?=
 =?utf-8?B?YW1Cc0tkNGtHK28zWVU3Wm1pL3NSU1ovMEFZREE1SjQzWEVobVZmZkMyc2Jj?=
 =?utf-8?B?R1VMUzRzODk1VXdoRVV0ajlQV0xaWTExcUI4MnlrMFc0VXh2R2laRG4rSkI3?=
 =?utf-8?B?dGhzREdFWXB2SCtKYm55ZDB2UDFYeDRvdWU2YXhOVmxJTUlmK0s3L3ViUWFv?=
 =?utf-8?B?T0x6b3lSVERpMzZnOC9NSEJqMTdZMmZRSU9TdmNMRUtKOVlsRFZxUHJpQjBH?=
 =?utf-8?B?bW54YU9LYUE0c2h3cnhSNmlScFdPc3FTQVJnaVJKWWtkclFuRWV0L2dXNkZ4?=
 =?utf-8?B?VHRWMG9nVU8xSnh1cmJ0cmZqakFQUndFaWdOYjhremhuYWtZeXVhRlV5c001?=
 =?utf-8?B?MlNpT2ZiUHhtYTdtOHRaalBvcCtiM3Z0YXg2Zk5XcEZ1dGp2OHNrZHAzbkRM?=
 =?utf-8?Q?vm4XbkYN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37afd968-661e-4158-b2ae-08db57b45b1e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:27:13.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/ZI4mNbWNsqpm3RmE8Rh1p7vg2EsZiALQEoSBscBJsWTyoUhv1nZPvxlOsoG97+Q7uLeyy6K0yi3KiZxogw25paf5aPVmgyWFZWMBXAqh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180124
X-Proofpoint-GUID: LpVts9KG7pKHGxSveTl3GU-IaoTgtN_m
X-Proofpoint-ORIG-GUID: LpVts9KG7pKHGxSveTl3GU-IaoTgtN_m
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 3:08 AM, Christian Brauner wrote:
> On Wed, May 17, 2023 at 07:09:13PM -0500, Mike Christie wrote:
>> This has us deqeue SIGKILL even if SIGNAL_GROUP_EXIT/group_exec_task is
>> set when we are dealing with PF_USER_WORKER tasks.
>>
>> When a vhost_task gets a SIGKILL, we could have outstanding IO in flight.
>> We can easily stop new work/IO from being queued to the vhost_task, but
>> for IO that's already been sent to something like the block layer we
>> need to wait for the response then process it. These type of IO
>> completions use the vhost_task to process the completion so we can't
>> exit immediately.
>>
>> We need to handle wait for then handle those completions from the
>> vhost_task, but when we have a SIGKLL pending, functions like
>> schedule() return immediately so we can't wait like normal. Functions
>> like vhost_worker() degrade to just a while(1); loop.
>>
>> This patch has get_signal drop down to the normal code path when
>> SIGNAL_GROUP_EXIT/group_exec_task is set so the caller can still detect
>> there is a SIGKILL but still perform some blocking cleanup.
>>
>> Note that in that chunk I'm now bypassing that does:
>>
>> sigdelset(&current->pending.signal, SIGKILL);
>>
>> we look to be ok, because in the places we set SIGNAL_GROUP_EXIT/
>> group_exec_task we are already doing that on the threads in the
>> group.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
> 
> I think you just got confused by the original discussion that was split
> into two separate threads:
> 
> (1) The discussion based on your original proposal to adjust the signal
>     handling logic to accommodate vhost workers as they are right now.
>     That's where Oleg jumped in.
> (2) My request - which you did in this series - of rewriting vhost
>     workers to behave more like io_uring workers.
> 
> Both problems are orthogonal. The gist of my proposal is to avoid (1) by
> doing (2). So the only change that's needed is
> s/PF_IO_WORKER/PF_USER_WORKER/ which is pretty obvious as io_uring
> workers and vhost workers no almost fully collapse into the same
> concept.
> 
> So forget (1). If additional signal patches are needed as discussed in
> (1) then it must be because of a bug that would affect io_uring workers
> today.

I maybe didn't exactly misunderstand you. I did patch 1/8 to show issues I
hit when I'm doing 2-8. See my reply to Eric's question about what I'm
hitting and why the last part of the patch only did not work for me:

https://lore.kernel.org/lkml/20230518000920.191583-2-michael.christie@oracle.com/T/#mc6286d1a42c79761248ba55f1dd7a433379be6d1
