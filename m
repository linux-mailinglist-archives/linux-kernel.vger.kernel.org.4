Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20FE6F83A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjEENQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjEENQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:16:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B981E986;
        Fri,  5 May 2023 06:16:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456XV4P003804;
        Fri, 5 May 2023 13:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=rgZ7m7Rkx5sY87xHlbb1WIP+exH9WYasRI0mxdZepTc=;
 b=duirPOmJ0jYlzRjKtUutIImJIbQ9/P1C/SsylkAUwkHQ7MKyPhW/AVKAnmS8tnDgJWJ/
 XC4uolco4hWJjTzlLnHVbEKitH7dJ21gE++07GPFkXVwTiWDEcbRYmkG1MoI/jXt+A36
 141iFnA1jnB/o18CSPj2Y5tGCEP4fzdtf+Rqbs3DXfgIIWow17LFIR0XaAaBonDAtR2K
 /5k4f2YvLj01s423C+pNFID/b+eCrGHkqs9aafUe9zzo5tmbkvSziPMA7x99UfS1A2ou
 49j9dhkqvsvPdonmXaGZlkMPAUtq6OWyrr06y0V/h6Hl/sQywtGNoxuVgfgDl/A045Dy Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1vs7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 13:16:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345BoB5m027440;
        Fri, 5 May 2023 13:16:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spg5j9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 13:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiWmsN1MOanxQ33gF00I3JlY7hGZ3RaVsc30lGRkPlJzLQc7Y+71YoXY41fa/lrYn/1teSAqeMN99/Z15jHbpvNRSlDMY64o+XysUqV720yxQ2OwW5SMJvsaNF7W2L4OB8/776dpoTqC4tVAEojq+VTEHdPdS0z0MSf3juy9w+5pz8ZoPEXs0vWMa59fNWyOmzn6J7NDN1arv/jOceTbdZXaetiZ/r8/wkXrdieAvSFurFWSbQqG1tIxK7PrOt9Yqw1JUdZH6ymyXTXAltkiP2vcFffUg54rTnlBIRIMGqq+BI20xaNat0pYhlo3S7RVr5nOsIiZc/NoNkWLn8yUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgZ7m7Rkx5sY87xHlbb1WIP+exH9WYasRI0mxdZepTc=;
 b=gy6mwpCsr7riGFmZbaydoZgYPRuVGSeDhxGVXhkqXL8WyvewKTg7DtgxtZrWBleTqC8L2WYxuoijJdPMk2wDhHAPTyCL90VKQhQesspp71Fz0rAFB4z0Nw5SCsw7xfmHjJmprhXNHA0WLxPnong6A+NtEoRPTqgcBQ7N3dpSoHMtxTXJKEaSDJE1W+MT2mN5nEmbh98bk7n1SuDoX7hEybozGs56RMPXCnzrv7PqZ3xvxHrJsxn5TlTDOakYF9lR6om5wn01E5IDw3Z+Fyo5JlI9iWRT90bm+hlWNAa54wNrDscZ7XW0k3/rnvhevbfrdXujW9YclOfgygbQN2Miug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgZ7m7Rkx5sY87xHlbb1WIP+exH9WYasRI0mxdZepTc=;
 b=DWf8JT8i32jQnuXcvA4VC4bOgDwcOY5FYiZvsiJ5ckRRFTOpdkpsT5ocNC4Tr/Eiti3D4UjuzYOofPAOpPPRQDOtzgESVNX2Jjb0HyrRGC73qt3F/kkPD10N+D9QxyUA+FyidFDjH8OUyr/NGkrvovg4HEkfKIFDb10h6bIR2Qk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 13:16:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 13:16:23 +0000
Date:   Fri, 5 May 2023 09:16:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Make maple state reusable after
 mas_empty_area()
Message-ID: <20230505131620.2o2cv5bj6jxwlztz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <perlyzhang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
 <4912002a-4fa8-c1c0-a8c4-690b6dd76449@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4912002a-4fa8-c1c0-a8c4-690b6dd76449@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: eeecf0ab-b740-4302-13b1-08db4d6aec8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8HW5XbCjDcJdd/qxTIBfudDyqQvsdnT9uIwtE7SeD64m2LLNnKfvxZQCCarDHDkbRBk3VfqlQc+xcCJmn4fmWaSa8QpUdZ6NRToN00r4NrT0s+UFDLa3RyvgxYrq00vtaf0Kfus/4ZePx58V9FrChhtbqYg1SuVcNplLeThzwhEoWhtDagI1igB3WfN1j30kmzNSkHvGG8kJiEkqNpF6daDQZY0nbGDnoj9lIL4iatq2JCtKmdcXT2vEm97DcwF0bdcE3Fz2nPU05Kzg4p3DEDTW7LSM1y7PFQ7gP2xqQZZVDnmaeLvhUJTW2ICVh0ApRLF3Nfrf1jOoYrqPburPoUSV7cxGhHi8UhI5X0+/g9s/VkJmxGwHvSJtbZEbg9rNcfI3WF9vLt281GdOkDG/XL9c2Xpjk7NbaYQuPaxdFduflkC+HzgEuw4DQC9y3BhFPl0tRCjQodjDMIf4K7mNzioYOyDQ9XFoQJeVV4dgVuH7BkcmeI9GN3HZvN3kKbvkS2mUrFEsiFpQNZF2lEfdXXBTKk/n7RijRM55jvMj7pbDP35khPRld0P6o5GoS17fNEaN/vDwnxNhOmjDVm+aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(38100700002)(2906002)(4326008)(8676002)(316002)(8936002)(86362001)(41300700001)(66946007)(66476007)(66556008)(5660300002)(6916009)(83380400001)(966005)(6512007)(9686003)(186003)(1076003)(33716001)(6506007)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ROenREZWMzWGJlQkZEcXpzVE90YWZYOEhQN0dLZFFIWVZJZHIrcGlmNUk2?=
 =?utf-8?B?SEszVmhjTTJqV3o5WlE2RFovd210VWQraXRrY1I1bi93eThRbVdFUHdWdEhQ?=
 =?utf-8?B?bndYNkVSbGZ4SFpmdFFBS3RQMkJBZjYvQ0s0akhQeTZ5amVzMXpjZEFHOTdz?=
 =?utf-8?B?YW5FQi85V09yODJ6Smx5NmRkT2dobmgzaHYwalNITXM0d1FwT2VKaE4zQkZI?=
 =?utf-8?B?WGkyUktLZzR1ei9Nemt1NDJQOUY4YUdrVFJqUXB1eVhkVzg5SStMbjB3OEhw?=
 =?utf-8?B?OTN2eEVYY1Z5cEZzMXN1QTJobWNHR0FmY3ZZeUZtK0F5OGtwM0N3SnB1dS9t?=
 =?utf-8?B?Umo2WGxHeVRwMFF4WUhZdktJSlJlSDVDa0F0QXdDYVhpUDdnNGFOdWJodWNu?=
 =?utf-8?B?MGF3c0JNYm5TUmJLTkZjVlpVOVV3RTcxV0lFRjFhYTR1VzJIcFN2NmdIVUZL?=
 =?utf-8?B?TkZzMTVLUkZRc0laOEFKRmZmZ3dXWVh1NlFwQlhGRGY5S1ZVSmJyMjhtNXgy?=
 =?utf-8?B?LzdtWFpDTW9Rc2s0T1IybVdYQ0JmdkZmcXVnbTJJNjVnUkxrckpkYXMvajhF?=
 =?utf-8?B?S29IODBSbzFHZHg0ZnpwdVdsYjBsekV2eEZSd2tzUWZDMEc0VVFyVGQ5dWRW?=
 =?utf-8?B?Wlh0OVBNZEVhNnE2clBvVE83YWRhNWV1WURqdi9SRUFWSzRUd01DNzJaVWV2?=
 =?utf-8?B?c21Zby84Rmg0R00vVVNURTFTcjVSbHpLVkZOeXRoTFBVMmRxd3EwU05nN1JF?=
 =?utf-8?B?QmFOeTA5S0s0Q2gwSm52WEZONFF3U2Fqb2tDSlVHcU9Fd3NVZUE4b3NDT2Rx?=
 =?utf-8?B?SEc4YmQrbFVvV21zL0VIT1pvVFhSek5PbDdOYndKUVNWTHh5SXY4aVVGSXRh?=
 =?utf-8?B?UFovZ2VQL282eU5HWTIvMUVtdXRkTVdFaFk4eUFFUWZZWjhCYWkyUVJsaUVu?=
 =?utf-8?B?cWRTd3Yxc1pCd3lPYmtuQjVxQ3ZmYmFzRUxNMEtpUzBvd21kVVZFTXUwL0ha?=
 =?utf-8?B?Uk16WFdqZkYvS0JyWE9yYWJqSndEcGxjTWJ2aDF3TDBrcGp6ZllvK0hvWUdj?=
 =?utf-8?B?dGthMHRvNTI5MWNPNFZHQmdhQ2QzQURjZlU2SjRyMjRzZ1F0MkQxbE9KRmlB?=
 =?utf-8?B?NWM3MzVYTFBQaHAzV1REOUl4SVFOd0ovaTFBYkRRYXhvMThTRTVtZGZrWm9r?=
 =?utf-8?B?anUvVzNmVkhzRGFQOUJWWUpwNkdXaWZad1BadXZCTmEvRFljQ25IbHZZR1Y4?=
 =?utf-8?B?NlRzMU8vL1o4Z2FxMzdCYk9HWi9tcVZrSWkydGk1dzNDellENnNRSkR0Unpi?=
 =?utf-8?B?V1dUcEZhM1NWZkx2c3RyZ1Npd09wb09LSUFvMXVETE5vc1pFKzM0eGdpUVhy?=
 =?utf-8?B?MUk2QVFjcXVmZUtOcFNudHdSK1BxS3JXODNNUUQ0cXNSbHhoS2l0MjRtWE9r?=
 =?utf-8?B?ZjZkaGxlNGZkL0t3T1kzQmpRWGJ5TS9mcmFLY1FpRm93ZDdDeGRnQndNb01X?=
 =?utf-8?B?MUdNMkg4RjNUYWRuTEF0R0Y3aU00OGRIdnpoMjB6dEJHam0wd0RyTmNRdStv?=
 =?utf-8?B?RGg1RzdhUU5UWGdMU0V4clJZMGR1SnJOMGV4QXZUbG1sQVkvK096RmpuMFYy?=
 =?utf-8?B?amNEWVBIdUhRM0FTWW9hNDYranRJazZNYXBvc0dUUjZHMm03dHhlRVNFaCtN?=
 =?utf-8?B?MUlveDA3RHl5OTFnZDQvVm1rOFUyVEZVYVVMenREWjVaTTRtZnFKZVlqcDVW?=
 =?utf-8?B?TStpU3pybk5ROFZtZUtKdmxJYmNsZjFwVlBzMmVzZzBXYzlVWFE4c0ZYeDNH?=
 =?utf-8?B?VDVrN2lQYWZrMHFrUGZMbDNsbEgrRmF5dVNDYTVkMTRvZmFMUUkvRzBtbHFr?=
 =?utf-8?B?ZnZwRGVVdTA1UmNHU3pUTjdtQmF3NENqb1huV1lONnhZbkg4c3NHdDgyWDNs?=
 =?utf-8?B?UmNHUEhIdjA3UjhpWDZIemN0TVVhalZXTWRISjlBRkxld2FuaVB5WkFTcld2?=
 =?utf-8?B?bWt3cGxWaTFjVktuMmo5aWxhOHNEUzh3WW1GTnNEZi9lNGszeVpYUFVvWVNX?=
 =?utf-8?B?aDdoeG5EakNKR2ZXeTlHMGFqRDVBVEFoRkFVamlZdFRPVlpIejVpNzFDRC9K?=
 =?utf-8?B?VU1OSmMrdnVndTBQQW4rR0RWMEpacFhzUzZjdkZiNmlWUjdPWmoxNEpFTllP?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bnB3NzlwbGtFSkdob2tYN0pHZU12L0dZa2paZE53ZE4wQ3o2dll6bnR1Yzlz?=
 =?utf-8?B?R2c0R3Ywc3R3NnFuT1JhVld3dG9vdnM1QUdxZlcxWUJpRFZBM3Q1U0RCZTIy?=
 =?utf-8?B?Qm9oV3NCV1JKa29VbHZtcFo3OGlqVkpsV0xuV2NJaFlkQVJQRVFmS0taM1dX?=
 =?utf-8?B?citDQXo4N2kzZmdGbjVZWUNCOVRyWmxlSktPcUEraTl4bFNnQkYwcEFCaTBx?=
 =?utf-8?B?WXFtMGU0ZGNXSHl5aGxhV3JSckhGQzNCREJKY05YbjlBWlRwbjM4T3FDR1Z3?=
 =?utf-8?B?Nkl6YzRHem51M2haTnE5UDduYmpBajNjOTBhR3dEanBVQ0t5VzRBaER6dUFO?=
 =?utf-8?B?ZHZodzhudWtneUgyZWZFTElCcXdqOTA3Sk5SeDRnTEwxSVlIeWFDWUVHeXF6?=
 =?utf-8?B?a1lSRFpJc1BXNUxIaXlINm9Bd2xDMkM0d3hQOVA2ciszdVkwZ1ZJZHVOVmIy?=
 =?utf-8?B?ZjRrRG1BV3RuZ1dLUkxpcWo5WmpYL2VMNjBDK2dZcFNOV3pFN3ZmbFhuQ3dF?=
 =?utf-8?B?cVhzTEFHS3UvbGswcE8rZENvcXRxeTVYNzBhdUw2a2NsRU85T0xnZy9yMkNS?=
 =?utf-8?B?SEZDdVR5SXo3YVNSMUkwazhHZXh4UE1FTmRNbDNNdk9FS1NCTlNURDd6Q1J2?=
 =?utf-8?B?eGNJSFRmZXJKKzQ4UGlYTmlPT05ieDgwcTU5Nm9sWCtNR2w5WWdlNUw3WnMy?=
 =?utf-8?B?YitFUTdsTDEwUko5TGEzQUtYWUJrKzlhNU1nbGQxckpoM2VxTW9tMi9tUGVT?=
 =?utf-8?B?Q0s5emxmSEYwYURoVFQyL25yUklOV0JmMGc0em9RbXhheHdYc3lMUnp0Wnc3?=
 =?utf-8?B?Skp2akxqVGZGM2FNdmNBNDVkTTk3ZkJxNzNmMWI4UEFRVG82eFRRQ3c2djhD?=
 =?utf-8?B?SExHZDcwakRlVFQ2cXB2SDlSQyt1c1ZyUUxuTW16bkU0eXJPL1VjWG94QmZP?=
 =?utf-8?B?ekFpdUhIQjlwQWlZdE11cmNXeExSRXZRaDFQUHNEaXZpUTlQT3FoUkp4SHhT?=
 =?utf-8?B?UjJTNWNtUTV4MnFNSDdOYWFWVCtySXdFOUFqRmEzK09YVG95eEcvM1RnUWwy?=
 =?utf-8?B?V1FFSXJJYnUwbXg0WGduNzFZQVk2OFJnWWhheG4wanpHVG0vWWJ3a3ptRjBV?=
 =?utf-8?B?YU4vNEwxRjRvKzVuWm1wZ0J1Z3g1Uys5UDZ0emJEK0QxUTJhbkRKZ1pjWUVJ?=
 =?utf-8?B?Mlg1WDZJSTFTUHhRaVovcjFPenAxR3FwU0JHUVBnM1NWejJDc1dMM3NTUk5q?=
 =?utf-8?B?Z0hhSXlFM0ZGUG9wY2tVU25QRzRqS0pTd2FWcVZ3cTJKWXJxazJJQXFnSVVx?=
 =?utf-8?B?Y2h4dmZsVFhILzB1dE5rTGpzY2xlSHkvbTl5bytNMG1wazhVU3U3K2RncDhK?=
 =?utf-8?B?ZG55NEpBQzNCZ2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeecf0ab-b740-4302-13b1-08db4d6aec8c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 13:16:23.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHVIDsYeU43Z2+aU/7I90ivoQXkWNGdVprYbb3bYaYwMXbHMIOPXucUaskKCs43viZwKxoDMBOkcstNIvqjKMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_20,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050110
X-Proofpoint-GUID: UXeTJZ1EMtEflGaEP1MJ8af_elVIBZoH
X-Proofpoint-ORIG-GUID: UXeTJZ1EMtEflGaEP1MJ8af_elVIBZoH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <perlyzhang@gmail.com> [230504 23:23]:
>=20
>=20
> =E5=9C=A8 2023/5/5 01:55, Liam R. Howlett =E5=86=99=E9=81=93:
> > Do not update the min and max of the maple state to the slot of the lea=
f
> > node.  Leaving the min and max to the node entry allows for the maple
> > state to be used in other operations.
> >=20
> > Users would get unexpected results from other operations on the maple
> > state after calling the affected function.
> >=20
> > Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
> > Reported-by: Tad <support@spotco.us>
> > Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
> > Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc8436=
6608624d.camel@intel.com/
> > Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab989=
9f9bc6e9.camel@spotco.us/
> > Fixes: Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 15 +--------------
> >   1 file changed, 1 insertion(+), 14 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 110a36479dced..1c4bc7a988ed3 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5285,10 +5285,6 @@ static inline int mas_sparse_area(struct ma_stat=
e *mas, unsigned long min,
> >   int mas_empty_area(struct ma_state *mas, unsigned long min,
> >   		unsigned long max, unsigned long size)
> >   {
> > -	unsigned char offset;
> > -	unsigned long *pivots;
> > -	enum maple_type mt;
> > -
> >   	if (min >=3D max)
> >   		return -EINVAL;
> > @@ -5311,18 +5307,9 @@ int mas_empty_area(struct ma_state *mas, unsigne=
d long min,
> >   	if (unlikely(mas_is_err(mas)))
> >   		return xa_err(mas->node);
> > -	offset =3D mas->offset;
> > -	if (unlikely(offset =3D=3D MAPLE_NODE_SLOTS))
> > +	if (unlikely(mas->offset =3D=3D MAPLE_NODE_SLOTS))
> >   		return -EBUSY;
> > -	mt =3D mte_node_type(mas->node);
> > -	pivots =3D ma_pivots(mas_mn(mas), mt);
> > -	if (offset)
> > -		mas->min =3D pivots[offset - 1] + 1;
> > -
> > -	if (offset < mt_pivots[mt])
> > -		mas->max =3D pivots[offset];
> > -
> >   	if (mas->index < mas->min)
> >   		mas->index =3D mas->min;
> This will bring new bugs, mas->index should take the maximum
> value with mas->index and mas_safe_min(mas, pivots, offset),
> otherwise there will be overwriting allocation.

Yes, you are right.  Both mas->index and mas->last should be set when
the gap is found, but we aren't currently doing this.

>=20
> Maybe you have forgotten, I have posted a patch[1] with the same
> function last week. I didn't know of a place where mas was used
> after mas_empty_area() before. That patch does not introduce new
> bugs, but the code style has not been updated yet. If using this
> patch will bring more conflicts with my patch set, so what should
> I do? =F0=9F=98=81
>=20
> [1] https://lore.kernel.org/lkml/20230425110511.11680-3-zhangpeng.00@byte=
dance.com/

I did forget about that, my apologies.  I really wish I had remembered
instead of tracking down the same bug.

This has become an issue because the maple state is reused for the stack
guard checks.

We should use your patch as you sent it first and both need revisions.
We need this soon and it will need to be backported.

Can you please take it out of your series and make the necessary
adjustments and send v2?  It seems isolated enough that it won't be
difficult.  Be sure to Cc everyone I have on my patch and include the
fixes tag so it can be backported as necessary.

In the future, I'd like mas->index/mas->last to point to the gap located
to better align with mas_*_range() interface that will soon be added.
It makes more sense to record the entire gap found when returning from
the search.  I think this entire area needs modernisation/attention and
optimisation, but for now, we should fix the bug.

Thanks,
Liam


