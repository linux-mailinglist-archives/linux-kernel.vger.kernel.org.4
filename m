Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCA634372
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiKVSQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiKVSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:16:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B13C6E3;
        Tue, 22 Nov 2022 10:16:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMHoxqC023069;
        Tue, 22 Nov 2022 18:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JU79RDobFR/ZvLWHlkINpqhW10DCAMHBv2AN2Oqf+cE=;
 b=kHi6KlahMuCSbix3mueLTIBPh9nJzqo3sSUYNK8SHB5CEEmwII+W9NYyje8QNc9aLuEz
 gcYD9FgHqtKq8PrTkR8nER+1X0RPdGed75h76noHrOXxSOSCaHU4KpAWKkNQSd70jYfe
 3fTmjJ4mNL7fH5Vd1QdJ125/5PhM9f2bc8zm341u1dTUT6sN7hFVd/O7Xh6XqP/tdV4w
 FP5YTL7qoYxDObXEa7LLQK1Erq2MDUe4RsG+U4OTFZQg+iBOO9ol16VuN2AkiPR+KLLg
 KxmyY7EJZqu9GjKipLOnskOVn65Bv2Rtxvk6b66YQzvQ8XZeuVpP1SlPERSFA2cbhUaH aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0afr4gkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 18:15:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMGWwYa007455;
        Tue, 22 Nov 2022 18:15:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk60d5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 18:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2JmUH8RH5ZtJw1TXVvl5IoMW58fAecH6nFFliWPo6IKgAanyQRsQHdVjTVFhPWCN0J26onurvroL4HZ52hu6uvCdK4iMNFX5t1lcUknZhlqmwk4s02IPvWs5y7fy//vaocDwT1Bsls4Bk+gKvcnmNUMgWWmujbO3zTi6+KiUObe29nlS3aFdPjW0SrY8J419TGvtBJ+2TRk2KwIXKeJ95rzEywiS4iPhNqB4XfQcI2/WPb54xklkpxIOU4+0Ep1RPFGxIeaAS8PBNbZK+GUYLBA9ogT/3dLB3KrJSnHtQ5q9kvS1LNpHhEcJXZ8I2rPvsC/CDbDYmL1G88mhHYvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU79RDobFR/ZvLWHlkINpqhW10DCAMHBv2AN2Oqf+cE=;
 b=eOXRhU1Eo3KEITF3TBjczqRT0GfYl4iw+dURGDhopMjjNqQ+lU+oWPB3YJA1lU44pVF21UCuJ9aVWDe4thZsAdtDAHjy1Fti8hWNLOAvM5ddGrvICi/3glMn2LT29SzrcivXLtfUe085JKufShL5MmdkQWE4BQpBLaor73YqwtYrQYLM0lv4yk+IZ8PMgGOFVN3T0IjME5Lpu//CqnAM1/GhUFIPbxsMtma98tNHEsLdWyDiqIO4t63/JfEo+SipM5XPPksCT5ETfe08qEFL7f2DdpOCvxf1Wg9n+w//7TsIPCiFNauqyeyazVuuTqlLpq/AOh3gejvH6+jMZtB6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU79RDobFR/ZvLWHlkINpqhW10DCAMHBv2AN2Oqf+cE=;
 b=XkEZyOHE0n37+qPih4OJam/bDODEG9rbhBe82ywXwhY4/8yLH6A78kDrjD5mwZeulgGjkPh0/TfBlQXiWEF4IJ1he/YRyOJy6HfXDAix5dM+KUKx3hWzKj4Cz2unrJfSVNiIaoQ1NimL5AWdVUEidtZzOBePJ1Rvg5lB4KcGCNY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5294.namprd10.prod.outlook.com (2603:10b6:5:3b0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.11; Tue, 22 Nov 2022 18:15:47 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 18:15:47 +0000
Message-ID: <856ccad2-19a4-32b4-b41f-5a230a55ee30@oracle.com>
Date:   Tue, 22 Nov 2022 12:15:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
To:     Wenchao Hao <haowenchao22@gmail.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
References: <20221108014414.3510940-1-haowenchao@huawei.com>
 <ad54a5dc-b18f-e0e6-4391-1214e5729562@oracle.com>
 <89692b2b-90f7-e8e8-fa77-f14dbe996b72@huawei.com>
 <418c7f6f-0bc3-45bb-2abf-e866df6f4b62@oracle.com>
 <CAOptpSO6=sUPUwgj1og8088djiNA=Bw9um0p024L=0Gb=-ja5w@mail.gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAOptpSO6=sUPUwgj1og8088djiNA=Bw9um0p024L=0Gb=-ja5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:610:e7::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS7PR10MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 345885de-5bd6-45e3-8127-08daccb59406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeOTKU9YNt0xa6pbBZA/wxHNcSbgrpn3UsSYBHakee6tu02ccsflDTu6zn7YZe3m4c8gS6I2WNZreP1ik9blNH2edkMeJLNnzAuJJB3OgbNxEltgRV2rvySCwGc2ttUKy9ujwghsnh4y+SEl9oXGH4JViZTrjslmu/Jg9CbPpoKZsBDQkKWXKTEo1JRWBu7bTapDvS48JkG508lY3K36vhMN+I9l6SfzElDDjVCzbvwi09GCMuczu67iJ16xQElt1wVCcI0HIQ/UQvH+kcF0h0K8J3tcDZ64VkiDPLrOU6GybEO5WXh9OlS+P3oT2ko/VqU6GfefjdS1I9KAYdBcP+XqB2cJdS0RgAOJCBsN/QvTW1nW5p+hT+x7G5TdSynwEn5iWO0FQ/wTWfNOOArkR7LSD14favhGC48BKx2vJOxIABbEdW0DOnEppLwj71SSuQTzJ2pzDogxAU2oBjw7Gz7CNqnB+ePTatSJX9PUpw19xDJVYOQMcTq5vhnHGZS5iPmt8AvZ80aLCBgRjjoOGnZFm2n2F8JravATQYa0xnsCfUGazvabc/d35IahgReqDoXIxsEteYbhMmpvCwO+R/Lp2X45rFD78T9jagpGGU/hqM3ibR8datOjUj5zgxSwdlKDt+IIqlPcRxNhHmxW60ZuBtcJyk/zbnQkHg+i7JF7Pk3unAXz7D6Zixg2OR2ffS+zzkR9xvTABXzCBupacCuLBplc9RERVA6Pq5oDaGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(6916009)(31686004)(54906003)(6512007)(26005)(6506007)(53546011)(2906002)(316002)(2616005)(31696002)(83380400001)(86362001)(186003)(4326008)(38100700002)(36756003)(8676002)(66476007)(66946007)(8936002)(66556008)(478600001)(5660300002)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRkTy95WUs5anJPMlhDL1hjQWxQa0dLZkI2Skg2KzNVRVVYNlRmc0hFL0lq?=
 =?utf-8?B?UjVDNmU0ZkM2TmZYV3RudTYzZWd1K0FzaVRHekZqalVKNndoKzkwMjNWaE5D?=
 =?utf-8?B?SzFWQXpDZHJCdGViMVVHdm9PNnBOODd2ekIvWnE1ME9VclVZSVJVRkdZQjlr?=
 =?utf-8?B?MUdmOGkwdHFpT2V1dHgwTTd2by8xc3hSV29jZEl1UzdjZmN1U014S3Z0azJE?=
 =?utf-8?B?NTdtNzdINEZ2UElYSEpaSlZhVERVUzd5VTZBeldDQllMU3RBeGx2bGJGUEdz?=
 =?utf-8?B?N2M1ZTM3cmFhWXRKU0kwcGFsbVZvQnYxRWVoQTFsYUtiNmhsYVhENFJML3Bq?=
 =?utf-8?B?RkM1N2h0UDJVOVhyQkYrK0Q3QjJ3bW40UjdQUHFlMjFLbFFSczY0Qmwrak5V?=
 =?utf-8?B?ajRxdXlubmtyTTY5U3hYNWtnNHFsRWRzdEhla0NQaXo2MWVXQTg4dnFzOTJq?=
 =?utf-8?B?VjhXazBTZHRkUmxlTm9xckFzbGZjNmNzNHhvUFVKMmt6bExKelpNMXE0bnZT?=
 =?utf-8?B?YS9HVG1TSG05MkVwdGNqME5jYk96cVhJYjVBNkorTlMyWnAxYVY4K2YwSkI3?=
 =?utf-8?B?enEreG82SmpRejJqck9YVUJ0M0QvSDdJcG5GdlZXUnI2SFFWbmdIaUp6Vm80?=
 =?utf-8?B?WFVxUm5OeWcvV0ZtRGQ0VkE1MStHM1lHOFowRGNWNmVRMzFtaVAvRU9Ca0V5?=
 =?utf-8?B?RzlRUVE0dmdMUkE0QmVzNmpYMXVlY2lwVDZ3YThvaXM0ckxLRW5qUUhJYmQ3?=
 =?utf-8?B?UmUvT3NNQ25XMWJ2MVNoRzFsa0JGdVZpVmJSVGU0QlFCNzZFUmlOOUFWR0ZI?=
 =?utf-8?B?NEJGN1dEZXFabHFDNGVkWTdyMHVvTjBjc3Q3SUdKbWNWNTd0QmNtSlpEeWtK?=
 =?utf-8?B?UmZDaWYwOXcybnZ4bGlpNHY3ZncxMHhEM1k5K09STmZLS2FySGV6bDdDT0RQ?=
 =?utf-8?B?NktTMjZ5VXB0cC9NZjB0Vk10elRSdUx4bXFFeGgveWtxTzNRUlBkdTJ1SDQw?=
 =?utf-8?B?eEkzczNQWnhRQVc5Z0J5UDNLY3JLNzZMYTlMRFdmMHpvdEJGeXd2Z0hSOVp0?=
 =?utf-8?B?RzhNMndLRVhtd21CL2VaUVE0L0pqaHp5THV5RUxwUG1iWFl1MUpheXJPa2hM?=
 =?utf-8?B?TFRReDBHSnU1S0IzVFo1NTROazdzeS9BRmJJTGhJSGhVakFZQjhwYzAzTE9z?=
 =?utf-8?B?ZGM3KzBrZkNaRmhQUWthcnlpNzNHOFgrVmNuNUhGRGFyT0pRL1UzUXJyMDZ6?=
 =?utf-8?B?b1RtaXNHTTh0SFQ2ejQwS0VaRXhYbkZzb2N1K1ZuN3ZLSmRzbHoxLzhKY1Rk?=
 =?utf-8?B?elZOUVlPeW9mK3NReHVydjI3MEZydytqbEM5cDExS0xHMXNQUWJwMkphaU5v?=
 =?utf-8?B?TFl4MVlRTVFXMkVHRC9yb09HOWM3WUkrN1hkWUFYN1pVNDVraThUL1VqRWd4?=
 =?utf-8?B?ZENJdXBQazN2NVZKdXQwR1VuenFhUXhSQm9IYzQ4U3NIWnZsbExxNHRwY0hH?=
 =?utf-8?B?djNucWV0cHhDN1NKT2V5Z0Y4blJRdHJva2t4VURNRnVuenpGeGE5SXVuZFFO?=
 =?utf-8?B?NWllZmFOQkZSQWU5VnpaVFJHTkhZZVdiRWZ3THpGTnE4bW5PL2xPU084ZDBN?=
 =?utf-8?B?SXRHakp6Q2JSQlNPRUtaM0FIcGlaNFY0Ky83eExybDJXL2loUlc2cGxNeVJx?=
 =?utf-8?B?WE5QQnRJTE4waHU4WWtOT0NReTRtZjRybUYvOWF0Z3Z1SVV6TGhEWkNQSUVS?=
 =?utf-8?B?ejZMRFBDM2RwMWJ3NDJyVHl1T3ZUL0pYZURtRDFQR25URmRNSGxnMDliVkVW?=
 =?utf-8?B?K0tJUUtOTXlCcFhBNVpneTkrUEZvVzliNWtXSnY5UzdQMDAyTnVrV1NFZ296?=
 =?utf-8?B?Q2hhUG5RUWdYRUVaU1J6V3V5TlNaZWVSQklpWUdtREZ6UWxBK3h3V25ibmYx?=
 =?utf-8?B?ckN0Vzl0M2lyTzR3Rjc0NllsR2hyamZlT2VkODRnbnpHNjBUMWoxV3JuRGZn?=
 =?utf-8?B?akVHa2FWSzdXQk84MFBoRmVUdmlXdmFRdzRQZ1B3R2taeFZqVTVLQ3M0dThI?=
 =?utf-8?B?UzRDWXhwSXE2am4yNGNhS2pxVlFBU1VLcVBHQmljdXF1ZklQeFppcElTeG83?=
 =?utf-8?B?YmhJNHIyS3YrdUVDYTFsQ2haazRJdk81UmFPZGlZK3J2T0FRZ3BDNjVZS2Zx?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?azNidDI0K2RvRFNtR3Rjeks0L2paakN2K1h2c1F3QmhZVFloTm1sSTMyMjJT?=
 =?utf-8?B?SjBhYU85YTR5VVRjUjR0Nk1wUTY2MHV4RmJheHNEQUI5bWdpUkplc0J4ODBV?=
 =?utf-8?B?NG1rYXlOOGlaQ2QrL1g0bWpzdGJoODBqbld4UndCejZDMFI3OGExQjlNdU5N?=
 =?utf-8?B?NnMrK2xxUEtMT01LMjJzLzk4ckhzbW9rUUdIUG9qMnhOWlVEVk5NblNwMEhF?=
 =?utf-8?B?NCtueU8rajBQbkNMRDN1QzFTTlhyUTY5YysrL0x1bW5GSnhXNnQ1NFU2OGxX?=
 =?utf-8?B?MVkzeHdGZlNBM0pFTVdBYWV3Z2lQUUVsYW54dnFhVlJaSG0xWk12SEtjUkVE?=
 =?utf-8?B?MGM2RVJhVm9kUysvampaWVdtcGFTaFllKzVBWUE2dGMza1BBUEtEVktPM0pt?=
 =?utf-8?B?R0tSNGFwQW5KdzNNVWF5cnQzU3czT2o2V1A1NTVWZ1pFSXpsTGF0QjJQVHBR?=
 =?utf-8?B?S1FYY2lTQ0RMeFZLQWlHMHRpMGdpdHg2bGtKTHl1bzFJQS9HUGdDRGlSSXIr?=
 =?utf-8?B?anExWFFBVlFHOGhuTHdwSHcrb1MxMVp4Tm4wQTBCbm9NZm0rQS96amQwYjQ5?=
 =?utf-8?B?NVpvakFCNFRoMjdFbFgrQS9vMVJtMXBXRkFIV2daZW9DMStLNTQrcHNseVpl?=
 =?utf-8?B?YjVoblZaWDJNQ05MNWtGeWpLYS9Ja2lsa3F4blN5SVdlM0VORzlpSjJvK2xJ?=
 =?utf-8?B?a0JhWWw3Nm1RZ21lNEdueXM3ckw4aTNUdCs5dW1oYTBuVDAzK3dVMWZxMjQ0?=
 =?utf-8?B?OHpxSlg3SnVGUHlyQWpWNUp5amVQSGJ4SG9EU1BBSDcvZ3ZsTWxOd2tydU1s?=
 =?utf-8?B?dVUrNHhKQkJXOE1XVjE5MUxicnZKM1ZDTzN3dzdOaG5NL0o3aFB1N1huanFT?=
 =?utf-8?B?TDY3RW1ncmZJRk1weksyYlNqTnpNemk3Y3V5VzBUY1c4SGpYcDRHZjEweC9q?=
 =?utf-8?B?UTA3UWNRcXF1K0hEUTFHVDdRTzZQU2J1NmlYbjVKc3ZVTFBmcDRBazN0OVh3?=
 =?utf-8?B?Z3lTSUE0endUT1hUaHpHWGxtRU5UdlU1R0c2dWdad0g3YzdqcElDbkFPcC8z?=
 =?utf-8?B?ZDVUM21ScDRqOE5qOWJCb2wxcC8vT1FJdEJxNFdYZ1Y1bEI4QmlyOGhIN2pq?=
 =?utf-8?B?QSt3dFhzMUhnMGRTQWxQR1hkYUVrMm9zUk1XSVM5UEIvKzlodFpQcTBXV3pO?=
 =?utf-8?B?OVNTUlk4Wmh2YmZhSHFaczRJR2NqWk5SMVFpaFQzNndpQjhiME0xVDFJNnh5?=
 =?utf-8?B?K3lDUVdCc2JrcnZPMzRlV1dnQTFBY2FXNytodzAvdUtnT1lMZnhCRmtLWFJD?=
 =?utf-8?B?eERGeWo2N043emRIUGJtMURVRnU3U3M2UWkzTWg1VUlrS0ZMVC85MjA0WmdO?=
 =?utf-8?B?VHRzbVg3RkNOMXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345885de-5bd6-45e3-8127-08daccb59406
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 18:15:47.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P5VOQdv5gdYMagSzuBoGErheHh5naT6/3ZXLm56imLr8bY1bDlkkx9IwxwtxX6PUc+PhQiIgRp2DQSFsQFuuc/kOJJ01WHzKIyz5kOh40w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220140
X-Proofpoint-GUID: KY1FGqpu4MsprukYQwYZV7mJ9RztFHC_
X-Proofpoint-ORIG-GUID: KY1FGqpu4MsprukYQwYZV7mJ9RztFHC_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 11:29 AM, Wenchao Hao wrote:
> On Wed, Nov 23, 2022 at 1:04 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> On 11/21/22 8:17 AM, Wenchao Hao wrote:
>>> And the function looks like following after change:
>>>
>>> static void __iscsi_unbind_session(struct work_struct *work)
>>> {
>>>       struct iscsi_cls_session *session =
>>>                       container_of(work, struct iscsi_cls_session,
>>>                                    unbind_work);
>>>       struct Scsi_Host *shost = iscsi_session_to_shost(session);
>>>       struct iscsi_cls_host *ihost = shost->shost_data;
>>>       unsigned long flags;
>>>       unsigned int target_id;
>>>
>>>       ISCSI_DBG_TRANS_SESSION(session, "Unbinding session\n");
>>>
>>>       /* Prevent new scans and make sure scanning is not in progress */
>>>       mutex_lock(&ihost->mutex);
>>>       spin_lock_irqsave(&session->lock, flags);
>>>       if (session->target_state != ISCSI_SESSION_TARGET_SCANNED) {
>>
>> What was the reason for not checking for ALLOCATED and freeing the ida
>> in that case?
>>
> 
> target_state would be in "ALLOCATED" state if iscsid died after add
> session successfully.
> When iscsid restarted, if the session's target_state is "ALLOCATED",
> it should scan
> the session and the target_state would switch to "SCANNED".
> 
> So I think we would not call in __iscsi_unbind_session() with
> session's target_state
> is ALLOCATED.

Makes sense for the normal case.

The only issue is when __iscsi_unbind_session is called via
iscsi_remove_session for the cases where userspace didn't do
the  UNBIND event. Some tools don't do unbind or open-iscsi
sometimes doesn't if the session is down. We will leak the ida,
so you need some code to handle that.

