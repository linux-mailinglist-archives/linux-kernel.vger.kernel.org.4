Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97663ACE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiK1Prm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiK1Pra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:47:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02CF24097
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:47:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASEfhsg018398;
        Mon, 28 Nov 2022 15:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/x4TrwZITHbeDPlR73tbZvInNxMYZHMtPr+oSKsS1zk=;
 b=ExtQ/zLqmlA246HZXjruUETJirmdrnUIm4cAjRTQkqR9HrxoISfnz0pc4LCKjVzwxvgo
 /bzRcfwmBoXmE1ObjdHkt9LaL1vxTzlQohUnHaxNu5yoMkwq1nbJx34A5KZA0Vr47OeD
 gCSlkS9djAjUU57ejEtHf0NLOQyXuWXJmPwfatAJMG7hB3TuCdpsp9tmbGG6SeGRe7hY
 xmeAiLZI8H0vNFXUESsoJBM5KQ3QDyrKI0u3dnEtNiv2PYkJtFrTTeEbO9Esop2n4RZP
 tCFFw/JPwNlukljca46xmKO9weRo3Hrf9b33kL7Z199NI1nEIa8SaNVqDmZIziKG9n6b kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht2x65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 15:46:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASFCoC4019421;
        Mon, 28 Nov 2022 15:46:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398bp62k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 15:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB5wT7/fOtXyitY4enl57mJM80H8KdCo/HjE42wWJvDp4ltuQyw0Sqp9EPiQK2thSMwGjvtNe0jyGl03G5MEicW/oAOdTTwrL4o904fBS9dKdmJgemZSUkN1ojBV3mO5n4xw6CYd30BTFH1PIJG1g8Gd0IWO7BbIZgDqimToJNpKVRNsCsNqKVWG41T22fK5LSqPpWLH6EI+S4epn08hvPsq0IJCq++V6ISQDQU18R7xuUkzvRvZU5aP05M/i1FkEdjUwWfJhdeW2d9ek8zWkq3C8/LSZibfWFMQ6uXbH+yxmjr1XFSlEadmXQeRD+B5j6aFwbhfroqtAXXO6gIL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x4TrwZITHbeDPlR73tbZvInNxMYZHMtPr+oSKsS1zk=;
 b=QfIFT4W9Lk8pJXuIE3CXeCywleiaKacgqblbc0jDm4dMfM7IJ2A7PKjh4XM+Ip1FBCpOq9nekvp00YhiggtDj9URBtopfG4Es3Cqhph+EjLRXrbgnFnzikZs3MZYTIpJdQf9m1uAAT7IWRExF2uZusE3cAVvCr7/Cgf4eOhLpak8CszkI7jZmC3lLG2RyCr28k1B82Mp5H4WLq1tsgdnZCGCmspc+fAjUG5MdEYxNfTSQ80luEvT5wOEcqNjIb1a+ofoTswcmFatmKX0I9EPCxMgoO1TKNdmOvOYuS6wPegh4ziomo6ZZWwKvZv7uq6Yp5waKgKDsnCOumd9ZMh5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x4TrwZITHbeDPlR73tbZvInNxMYZHMtPr+oSKsS1zk=;
 b=HCMiZZey58E4aajSiZ26/pB+xKr88RQJVXOFJQZxhp6uvJOaZw7VVCoElwn8Ezhocwtm66eTXeqq7/dMhmIrE7mXC0dYvkeyZi/0se8wl3sMMY45vYfa+jMpDTwqWb1FvgQD6jvSqelskLEVyCNhdvGNecja5fJohn2LqlfvvMc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM8PR10MB5398.namprd10.prod.outlook.com (2603:10b6:8:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Mon, 28 Nov 2022 15:46:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 15:46:41 +0000
Message-ID: <248486ff-5f9d-bffd-ab6e-131c54f31bd8@oracle.com>
Date:   Mon, 28 Nov 2022 09:46:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0009.namprd05.prod.outlook.com
 (2603:10b6:803:40::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM8PR10MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eb5a35-1bcc-4389-492a-08dad157be99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tic09Je78NlN4Bszcgdor75eB4ElVsp/clUy5HfdKFRsPan/lLRdKOPvdlR1aBuuK7wGXtmkXcsAwf3N/6/+xgpN3utYq3s3rgxcXQ7fJt4huN9kDG7cVOAHf4srtqkv+nF3oDsG5Vsh2EOB/HXgq6YOy+ThDOVMuhuB3m8I51HSwsQG3zWU4S50ikN406tNs2Vz6DVTUQeB8LUK1KpFgSGflpKQld1KqvQHH6BsM1I5gdAQ4vHv84U0gCaHgSflQczFIe9DwQTe/dtUd7rS6PTWIP9iqZREz9Ny3uEYU61cvjW/j+0eO28j/kzKoUmxNaLIGlJeCqKjdWV79ff5Bjnql4x0MJ3SO6iL3ym9BMcGsLmmcPeofJ4LCjSnaum5J3AUcxdVzT3rBzYnMTdQvMHyvqmodcF1jK+RiDScsAhvcgacalmELvXfm/154qVpgmgErjiNY7Wgeliub7Psuz+uX0YZWmiaQZqebSPVJyDqNESrCadSI9X1vFh3/wj8emvK/9vCdGQCTj2RJKHGjL/TZDvPIXrkLxBVDDFXwLmq8WnAgMrhMX5Nw7Ko8i/M0iig3a+7hodGmpLhFi9edMIf27g33BlVnctxZ4+skkv5X9T3/yRO9w4ZVxRU9F89h4foCWysBSmx9BqveZn0bxS01XEUmGevx+8hHFRdEreUQQgksLZTHNrD6cMR7mVK6n6DmUMpuFDWyvpicDApRAWSDK5nqFzI78/JTJ2s/JyuWUq4aJWa11vU65aGEIEZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(53546011)(478600001)(38100700002)(6512007)(6506007)(6666004)(41300700001)(66946007)(66476007)(66556008)(8676002)(86362001)(31696002)(4326008)(7416002)(316002)(6916009)(5660300002)(8936002)(186003)(2616005)(31686004)(83380400001)(107886003)(2906002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVl0bjVzeGhMWnRON0xnMXFoQ2hWU3lCOWwxQURpQkNURzVCeVFLL09HN1pB?=
 =?utf-8?B?MHFSc0o4U2ZoMml1ZWlFcktlajh1OFJYbjNSdjI5WUliMy9RSUFzZXVzRlpF?=
 =?utf-8?B?TmhHdWFRQ25WSmV2eVdOMTM1MzdOQTVUekNSZ1V3QVkxU0ViSDc5RFRqanpk?=
 =?utf-8?B?NzhFVU1pdHhHM3d2YjdoaVZROVVoc3BHMVNmckQ0Z1NSWEdMZndLb1hycW16?=
 =?utf-8?B?Z1EzS0U2MmVBcGxvNGVvSzhVb0lLRE1KS2xrRlVoS1NUcUFIUmVDWHVqbFdn?=
 =?utf-8?B?REpZK3pZNlU5SEFxRDlSSnA2U3lRUGVrRXJvZVhMUW1hd3R1K29PcGcyRHFX?=
 =?utf-8?B?M1dTNnRBUXllV1I0T1BJWktoOXFLZzV3ZHg5UXhFeE1NMjcwREx6VXo4blJS?=
 =?utf-8?B?SkJpMXBydXRWN2VveWZXdnljbmRCMTNHbGVTck82Y3JZd2tzRmpMdWpPbDkv?=
 =?utf-8?B?NjVGL0g3dFRxb3JPNit4TmtENDdUazJsRU83OFZwR1YrL1cxT0YxWDRMQ0VP?=
 =?utf-8?B?TUIwRk1uVFlQSEZBU0JnUXFucE9EVklxUXZpS1BnYWVLN3lPU0pzbFFzWHg4?=
 =?utf-8?B?Q0FXenNtazZCTHRKaTR3RDh3TFJRMWM0L1ExQjRkVUVpTENkZG5qcjZFakd5?=
 =?utf-8?B?RUpWaDl2WVZPdzkydXV5OFVUdDNZZzJUdnJONnRqc2E5b2I5QmF3OWJ5ZjhI?=
 =?utf-8?B?YnZGNEJzY3M3VjBPMjIvTDhDbGJhTHM3cjVFWGRtUzdCczdocXR0MDFOc1Nu?=
 =?utf-8?B?WExKbFpRMXhMZ253M1d1OGN5VUhLeDI2ejMwRmhzMkE0blNwblpzUXc3WlFk?=
 =?utf-8?B?UHVDR0tscWRvREFIZHhLU2tLajZOWXdEK1pVSWo2T1BZdW12RDJvRWp3SEh5?=
 =?utf-8?B?cWhnNmFWZ0swL290bjBmVHdTVWN1TUp4VDRFOWhWWG9ldHYyaWc4bzVkMUtQ?=
 =?utf-8?B?QlBXdUVHNWlCcVZIYTVNbUFWOHQrNFNqOHE0bUFWS2FqSzdiaFRZa2dweEo4?=
 =?utf-8?B?YUZ4RXdnOHdXRjNPZzFvNDBXTnpyU2xrd3pFc2RhblBVbTBrNWc5NTdUVGRu?=
 =?utf-8?B?aW9VRDZabVdIdGg5dHVEZjN6eXBVS0ZEQzN5bnhqSURhMjhpNm43R0MzTm1R?=
 =?utf-8?B?N2VUOGVuUnhUUit4K1VNU0ZSdXRvbXNUVXlRNTVFdEhtNFI1UGNaMHMrNnND?=
 =?utf-8?B?TzE2eEFRSG5YL0ZuQitGR2U2Z2wzbkNPMGZ6b0NjY3pXc1dJK0h6R2NRdk0v?=
 =?utf-8?B?OXAyZUlPeVl6SGZFa1hjWUd0MWlzK2RSaEdKY1hraldDQUt6dGo2Zm1KWTE0?=
 =?utf-8?B?T2M0Y05TbkdoTUFSR3BMbHR4cERhM0M1eHAvS1ZLcmkySEY3ajZTbkQvY0lB?=
 =?utf-8?B?dnZZcWRuZGJOTXpYVHlROU90UXdHOXpuaEJjSHIzN0g1Z1I0SzEvaG9UampX?=
 =?utf-8?B?UVRLTUxObmlJWUl1YmpsTW1hbWU4SFlZbUJDRTF2RVREZkpwRnU2UmJmVXYy?=
 =?utf-8?B?UDA2eXdjNkh1TEF3UlZ0UGxvY1NyR3hpU1pma2VjcEo5VGxnclJMN0s5UG82?=
 =?utf-8?B?WmZYNitweWNXWlVQbW1hZEFidDd6Vm1Gbmo2K01DZzZNZSt5Y2NZTzNKVTNt?=
 =?utf-8?B?bzhSTS9XRHJpa0xaYVNKUEhZT01kQlNlTjQ4UXNSbEdTSm9xRUVHRWY0TDg0?=
 =?utf-8?B?ci8wNFpXZDF6OTJqKzNtZGpSenk5Qm5KUmxjbDFxS0t1cGNJeVhzY2RYUThV?=
 =?utf-8?B?U1dXd3o2Vy8wSGZqRGM5Rmw0R2RxU1Q4N3RCWTJQMUlNN0FyWU50TVBaOTJ1?=
 =?utf-8?B?dXk0L2VqYlJHam9lR2k4T2kzbjlUT3JzQUNPcEFRZjF3ZGJ0UlZZSmhLUDVX?=
 =?utf-8?B?eFUzMTFLQ2FXbjM3ZHM2M3ZDNS9vdTRxYXk0LzlMbCs2SXNwZGcwMXlpK21Y?=
 =?utf-8?B?bnh2Y21HN0ppdDdTVW1UdXVFaDhFTHZ1ODdITnd2bW0yVXNnTmp4Z2FweDRP?=
 =?utf-8?B?QTF2OUtNajVqNUJPRlVhc3JQL2lSazlVZkdZbHU0ODRna2VGNEtIbHJ6dXhE?=
 =?utf-8?B?MFBVZG0ybEVTU3RuTEVsdXVBNnRsNVU1WkszcHR6Ty9JUlRjN2wxY1hHTDlF?=
 =?utf-8?B?Tm1GcDA0OEFabmx4RjRxL3JreG85V0lIQ0tlNFo3OWhOZGJ5L3Brak11M2Nt?=
 =?utf-8?Q?wWh5hXtyhJ4Mjd2g2sm2QxI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cVhqK0lJdE9VL29NbEJEcHh5WnVYblhEdVpOdk1LTGE1UEZnWTFYUkdqRFNK?=
 =?utf-8?B?OGF0QklqYmxpVUpRQ0N5RVFFeW5BTzgvT3RmVUdvSlVLVnora3ZSV2gwYnVy?=
 =?utf-8?B?ak1naGtuZEV3eS96bEU3bkUwWFRiOXlpSHVzbkR3bEZzMlY1RytwSXIyeGNw?=
 =?utf-8?B?VlprOVQ1R2xhd0x0RFJBY2pTUkxleUZkekIyVitKTjZGd01JQkQ3TEUzT0Vh?=
 =?utf-8?B?TS9wdS9lWlh0VUt0Z2VHbHRHUFdVQTVLTytzaE9HdHBGTFU4OVlmQWM2S1kr?=
 =?utf-8?B?WDFOWmQxQklDRjFLVy9xck5qR1QzNDhjYUVpdklsZDhUazdKdFJPbU5BQmR2?=
 =?utf-8?B?YlRmNnFVUEZDVlFPVU9wbHk4SEJZV2NiVy95UFFQVm9YeU1PWUlucmZBY0Fn?=
 =?utf-8?B?UVhmK3crR2V1dTVDalc5TTZ3NmY0bTlLMXk2WkxURTNkOTA0dnlkMU5VVXlM?=
 =?utf-8?B?MDlPQ2hoOUFEOUNWZWRDNGFESXBEeHh3K1huVUozWE1XNkQ1ZzFNaGVMUTl0?=
 =?utf-8?B?VG1OMzZtZWtrektRdjJVczNQZ2ppWXVDWUE0N2toWDhRZ3crS0JIV251Kzh6?=
 =?utf-8?B?MnYzN1N5Z3RvOUYxeWNjT3VNOXRvdFA3OW9nU2ZSTy93NnFuMXB4OHV2ODlx?=
 =?utf-8?B?WDZSbVJpaVNhODIrMnZMOXhEd2pHcUFqeXIyeUIwWVRSZ0Y2SlVxMWgzL00y?=
 =?utf-8?B?QXhkMERlS05qbnNadHFuY0Vab3ZRZFZPK01CT1RaNE40ZDFBbFRUVHdWOU1t?=
 =?utf-8?B?Z0U1dDI5bmN0dnFuMGRKaUliNDhDbk8yb0JwaE0xc0dtbm5oOEs2dEVLTklJ?=
 =?utf-8?B?NVhpVGJpU2c3anlxbTMwMG0vYnNEQUNNL2lCeFQ0N0laV3BzUlRNNlVIMFdz?=
 =?utf-8?B?TVYyNC90dzljVllXQ3ZSRmdneWR5SkhpZDNHYnBpVlFBemozT2l3aFBMekkw?=
 =?utf-8?B?V08wOEcrOUc2dWVnYVgrb1RnUlVMVEhRZ1lNWWFVTmlyLzFlOUZ2dUdjOGY0?=
 =?utf-8?B?TUc1RUN1Tnp3b3lQWTNRb3FaL2V6a25qYU9kN3VkajVMODhoK3VwVXdqVVJY?=
 =?utf-8?B?ampiRnFadUJJbmp0V21qZU1yay9hTVF2b1ZQVnp4RHlFK0xUcFp6NUNIZU1o?=
 =?utf-8?B?RDBwOW9yb0hsTTdpYVNvSWx0Unp3ZG5TK1BMZjZxbys1SkZvU2g5M1FsUjBq?=
 =?utf-8?B?Y091UEE1RUV6YUFLU0Y3TGVlTjQrbUNja3lSM2JjWGhuWkRQdHZjRGlJZnVu?=
 =?utf-8?B?a1FDN3lBQS9zRFJCWDNKQ0VQcitHMkpNb2xaTlZmOWlBdFRyZis1U0hOTGto?=
 =?utf-8?B?R2RjeWhNdlJvTUpHSHdJQXVrM2trdExzUVVFTmhobHM2ZFY5STRWeGRLcnI3?=
 =?utf-8?B?eGhXazdqNW9nMmVHbjlUQVNOWWR3NU1KR1lXTmJtVjJBNmVhSXJvbXNkV1Ix?=
 =?utf-8?B?VUFnVElhc3hrYUpQeEkvdmhEaFFkT2tWWit0bXVrb0dpQUZzV2s2S0FqZW16?=
 =?utf-8?B?TjVVL09KS25PMzFJMGUrQ3FTOUp0alN3aXBOeWFPaXRKemcxUTRNeHVZLzZD?=
 =?utf-8?B?VDYxM0NhclZGVW43SXBwcldHMHFYVnVIbzFBUWRrODZ5VmJwWG9QQ25QUjY3?=
 =?utf-8?B?MUNsSUsvTFBlZ0s0ZmpmMDJxKzJVZzUybyt0a2NmU2dzaDlzbGk5L09ZODh2?=
 =?utf-8?B?ZlFOcVI3QlAzTlh3U3R2Z3g1dHU1US9UbWkzcnVRbVE5ODVvMlFwZjJVSFAy?=
 =?utf-8?B?T0JNZmxnQjRldldWSlNIRFJyd1FKSU5ra2RLNUlVVGhobnBZN3VRUHpzVjFV?=
 =?utf-8?B?SHdtUlF5VjNoQk4yZ3N3dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eb5a35-1bcc-4389-492a-08dad157be99
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 15:46:41.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHqPIAwO+ec+04VLLjGuUXwF0sur9trUNGaX3yOBR/3ozQj15OECh3lzQCI2oCXZbQt8jzZlDuw9MhaPmS4aUgAVVBRlXAMVDX25dy58s5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_13,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280117
X-Proofpoint-GUID: U7lce6upQm4-x76LsWevuNEC2ZGXTrJ7
X-Proofpoint-ORIG-GUID: U7lce6upQm4-x76LsWevuNEC2ZGXTrJ7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/22 21:26, Baoquan He wrote:
> On 11/16/22 at 04:46pm, Eric DeVolder wrote:
> ......
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index ebf46c3b8f8b..b4dbc21f9081 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -32,6 +32,7 @@ extern note_buf_t __percpu *crash_notes;
>>   #include <linux/compat.h>
>>   #include <linux/ioport.h>
>>   #include <linux/module.h>
>> +#include <linux/highmem.h>
>>   #include <asm/kexec.h>
>>   
>>   /* Verify architecture specific macros are defined */
>> @@ -374,6 +375,13 @@ struct kimage {
>>   	struct purgatory_info purgatory_info;
>>   #endif
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
> 
> This kernel config CRASH_HOTPLUG is added in patch 7, but we have used
> it in the previous patch, not sure if this is acceptable.
> 
I wasn't sure what to do here either. Patch 7 is the x86 arch-specific support patch, and 
CRASH_HOTPLUG is introduced in arch/x86/Kconfig. I did look at introducing CRASH_HOTPLUG as a 
generic/non-arch-specific option, but no location seemed appropriate given HOTPLUG_CPU is 
arch-specific and MEMORY_HOTPLUG is in mm/Kconfig.

This doesn't break bisect, but as you point out, not sure if the location in patch 7 is acceptable.
I'm not really sure how to resolve the question.

eric

>> +	bool hotplug_event;
>> +	unsigned int offlinecpu;
>> +	bool elfcorehdr_index_valid;
>> +	int elfcorehdr_index;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>   	/* Virtual address of IMA measurement buffer for kexec syscall */
>>   	void *ima_buffer;
>> @@ -503,6 +511,34 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>>   
>> +#ifndef arch_map_crash_pages
>> +/*
>> + * NOTE: The addresses and sizes passed to this routine have
>> + * already been fully aligned on page boundaries. There is no
>> + * need for massaging the address or size.
>> + */
>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>> +					unsigned long size)
>> +{
>> +	if (size > 0)
>> +		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
>> +	else
>> +		return NULL;
>> +}
>> +#endif
>> +
>> +#ifndef arch_unmap_crash_pages
>> +static inline void arch_unmap_crash_pages(void *ptr)
>> +{
>> +	if (ptr)
>> +		kunmap_local(ptr);
>> +}
>> +#endif
>> +
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>> +#endif
>> +
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 8c648fd5897a..4e7221226976 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>>   #include <linux/kexec.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -18,6 +20,7 @@
>>   #include <crypto/sha1.h>
>>   
>>   #include "kallsyms_internal.h"
>> +#include "kexec_internal.h"
>>   
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>> @@ -612,3 +615,139 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "crash hp: " fmt
>> +/*
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources; the elfcorehdr memory size
>> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (kexec_trylock()) {
>> +
>> +		/* Check kdump is loaded */
>> +		if (kexec_crash_image) {
>> +			struct kimage *image = kexec_crash_image;
>> +
>> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> +			else
>> +				pr_debug("hp_action %u\n", hp_action);
>> +
>> +			/*
>> +			 * When the struct kimage is allocated, it is wiped to zero, so
>> +			 * the elfcorehdr_index_valid defaults to false. Find the
>> +			 * segment containing the elfcorehdr, if not already found.
>> +			 * This works for both the kexec_load and kexec_file_load paths.
>> +			 */
>> +			if (!image->elfcorehdr_index_valid) {
>> +				unsigned long mem, memsz;
>> +				unsigned char *ptr;
>> +				unsigned int n;
>> +
>> +				for (n = 0; n < image->nr_segments; n++) {
>> +					mem = image->segment[n].mem;
>> +					memsz = image->segment[n].memsz;
>> +					ptr = arch_map_crash_pages(mem, memsz);
>> +					if (ptr) {
>> +						/* The segment containing elfcorehdr */
>> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +							image->elfcorehdr_index = (int)n;
>> +							image->elfcorehdr_index_valid = true;
>> +						}
>> +					}
>> +					arch_unmap_crash_pages((void *)ptr);
>> +				}
>> +			}
>> +
>> +			if (!image->elfcorehdr_index_valid) {
>> +				pr_err("unable to locate elfcorehdr segment");
>> +				goto out;
>> +			}
>> +
>> +			/* Needed in order for the segments to be updated */
>> +			arch_kexec_unprotect_crashkres();
>> +
>> +			/* Flag to differentiate between normal load and hotplug */
>> +			image->hotplug_event = true;
>> +
>> +			/* Now invoke arch-specific update handler */
>> +			arch_crash_handle_hotplug_event(image);
>> +
>> +			/* No longer handling a hotplug event */
>> +			image->hotplug_event = false;
>> +
>> +			/* Change back to read-only */
>> +			arch_kexec_protect_crashkres();
>> +		}
>> +
>> +out:
>> +		/* Release lock now that update complete */
>> +		kexec_unlock();
>> +	}
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			KEXEC_CRASH_HP_INVALID_CPU);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			KEXEC_CRASH_HP_INVALID_CPU);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +						   "crash/cpuhp",
>> +						   crash_cpuhp_online,
>> +						   crash_cpuhp_offline);
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> -- 
>> 2.31.1
>>
> 
