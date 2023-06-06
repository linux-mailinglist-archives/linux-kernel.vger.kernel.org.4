Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900267235A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjFFDOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:14:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E511B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:13:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355HioRY028821;
        Tue, 6 Jun 2023 03:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2WnTYgJPSq34YPBK5yDShiqDde959lZsyWSRbwlFlhI=;
 b=qBsu16EdpNiQMJzyxNyYNun26FJ1cuHZgPbD12ZthVHNEK3HfISPCZGYNzY6bVOjylx2
 sKD0Dp2YarVn2F9t/tkgF8y0DeZxK/jYPa69GGGWP5h7wFG16vW8FianKoRBGxeZtOoR
 ljdTD/MHbtPXUNbszpmfs4JVENTCcLAbE9Ruys9SqWFLIWZFim21Fk8A777mRj8WXjev
 AxY1dh2zBqthYDnG3BVSt4Mc1naB2iJ7ocamn/7MBtbv6PhB+4lb620Op3lqhKPzIxa6
 /CekvWft+FncICgAM4oaiOIIfEsU9R5EpTHhf5f8Kvy9tPs9q4+FufnbsiPZleaCjrj7 vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx8s4bbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 03:13:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35632dAE020384;
        Tue, 6 Jun 2023 03:12:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tsx1r6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 03:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPvQrcDZn1T/5MBySZi2C8MPMkrO1dfgTTquBEokVgLv22sILAW9uuU2YnSupLgdT1KCV6CL4H5na6JfZmdKF146fMmMPy1EYKX1jVfIrZ5pct87Ej460KEjW3hjzdz0mrssusxmihh1br3zNEUM7io2B+A5DHIg+XhflhFpONzwP+lapg6cwcL8A67WYQyQsHSh86IIhz/FxQdRafo9XQW890iyJrYhzN1DZyLkIwdkEgz1Jk7Cu4hhlNFxaG5TWjCBO4mRdIH6cEoDatp3rHC+OORoLi1nUbKdmg1ZoRfMd3ASSIzpiwe8Jy9BNmKbE2INMY/gTHulGFlLdvyfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WnTYgJPSq34YPBK5yDShiqDde959lZsyWSRbwlFlhI=;
 b=IC8i30Gc1JFoVQvkdSiaAGGy+uaSlH7VWd0uh9+OcbVXEdr2jUcQfkFkLB1qiFGBZBQd1152HR6LgMrT6MmOJMthWm4Okn7I/1vvqaqlV/PfvH0kFEooIh5Z7cYEXokYPAlr3PcmH4IXkdwdzQmsMnBDO4tvVCXtIsV3cWF+ljqBG8D1kKfVm3ZmlAgz/+VLpKXYnaYhF/27wGH0QVSP6H3X9At3jk2eyNNi5OaC49c4wd2KQ/d7YZq0wy9uRsMXTvfI2cVE4vs61n14rSu0h3Lqq05NrncK8ZKFXjn//dxe6aRh5NxjCF1JAcKi/HGI/3xoya9/vIfq9zPRCh6Euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WnTYgJPSq34YPBK5yDShiqDde959lZsyWSRbwlFlhI=;
 b=ONYQqrnT8cuiIKzVKiZMShbRdx623HWWklv36413xTPp5KtTNdvoVxXCafLFegUM+SX/TfYTv180+yFfDaVB2D0oiQTY4reJcMsMrVLpIu6Oblz6iS8cV0FlXYcV7Dl2K+/lA8xtWZCXP8+VUpLNMb9rvc1MK5G5KNcMsZdmts4=
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 03:12:56 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::df1e:af95:f443:470f%2]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 03:12:56 +0000
Message-ID: <5f4f6b35-767e-0b27-555c-5e0282477eff@oracle.com>
Date:   Mon, 5 Jun 2023 20:12:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
 <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
 <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
 <aee5eximmv33ke26xrodm7tlqwwojalf2lz3zrgkt75bxeuupe@y3t2sfgdcy7k>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <aee5eximmv33ke26xrodm7tlqwwojalf2lz3zrgkt75bxeuupe@y3t2sfgdcy7k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:510:f::30) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2438:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 925e4228-83f0-451a-aea2-08db663bec72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHz+NKeArwho0s5qC4Iv6QronsFihRCvnThrNcQK8ctL689aNZYSwhpffETQ4d8swCNUgeUbNnCwqAPan7QTbXJ06ZOF6NHipao323omrcJLqM+S5HCghJ+B4rgZ6txohHD/ttCetMgL2fcDanYpty8/60qrzOfz4pmfPGq9JmZj/RjJI38KLQ5sf8NP/dk+9y8U4jn+svZw7N6FynT6dxFEhGLDjsapwSInMXwRTr9uWsPD7ah2h8taSJDBg3eNnbjbSn1JIQKsltfnzbq9c8IW0F2Ws/d1bR7SVxmfvFDtn5gCs+1AmLAzPZgbdSuQgFvIFtwkFvpV3aoUrxmSZvCzLdOwV+AUma6jjQ1IQxB9xQfFxAj6aHLhYtVpoirsQhpP/AGXY/NSduD3CcMWEkR/v0JvePnJXApk3rJb5CY5WwYI2yux9FQTAKqVVy6/7UOArfElxTquE2ujqgIiCWP9j0H3DYoRrZG8vs9qgzhD16LTTowq8xJX0zkx8/sCEXzIU2iE9tLH+5AZA13e8XeoccC6KRktUbAYpL2BAxWpsUpz0InD7If5TcsCmFACYhHaMJL9fWzMTjWU0LbwOYBFN5uYZbaPbf4qy8G3W4hGs++8aPk+rFMsw0aV20tQjfXlARvglcBPBB1X9sDNG+ox5Y8QB3dsq9KjWHaUX9VEHOA75jmuvyjKwZHafPkV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(83380400001)(7416002)(966005)(44832011)(478600001)(8936002)(8676002)(41300700001)(316002)(66946007)(66476007)(66556008)(31696002)(6916009)(5660300002)(19273905006)(38100700002)(4326008)(86362001)(6486002)(6666004)(36756003)(2906002)(6512007)(26005)(186003)(6506007)(31686004)(53546011)(2616005)(45980500001)(43740500002)(563064011)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNDaHlTZnRaNjZrbXFSUVZlRk9xU1hMME1GdEtMekNmQ25hUjRhaG9HbjZ6?=
 =?utf-8?B?eDcvenFoTXA1MFVGeVBDaDlpMEJWWDVKeGtDS0ZUdWFCWVBXdUptcmE4dDh2?=
 =?utf-8?B?TWY0dzZpK1o2eW0xWHR1emQ3UTRjdTJPODkrMVFkQjE2aFNBSlUzdjhvN0lO?=
 =?utf-8?B?ZCs5UnZuekNQNEpCbVFMZTRvbDRMR2VqcXRJNVlrTUpTNC9hOER2TXlyT09N?=
 =?utf-8?B?S2YvMExEb1VBTE8yWjkza3FocFNpM0pXelIvYVI4OTdnZWFDcWxlVUxxZDlF?=
 =?utf-8?B?UGh5dVdMVlZQU0h1R3BYbkVpaS9BR2lUc2hLczJpSWtMc296REJjN0k1Tm10?=
 =?utf-8?B?NWFubTFDc1NWYkZzZk8xdGNvNktvQ3EyQ01pdlAvL09NMGQ2T2tJWUdoVTRH?=
 =?utf-8?B?SzNlTFgwVmljM1ZOLzBSTlVkbmJScktQcDlRVDlCYkhDM1FmU2pjbUI2M01w?=
 =?utf-8?B?eHFEQXlRU2dQMXlRdUZHSkUweXN5RW1NK1F2Y01oc3ZJbTUzSHhLNTd6Rito?=
 =?utf-8?B?S2RyVi96aXpad251TVBpMyt2R1N1Ui9qOWxoR0NBdE5hUkw4cVRGdWhJcWpC?=
 =?utf-8?B?aTNrMElqaytEaWtQZ0QvWUhYWmwxYjVBZ1lVMEVKV1FpeGVBcGw1dXRWVVA0?=
 =?utf-8?B?QnkxOUwwbFMyTm1ydVl2U3R5L0lFcDRPUklKZGlIVVMrSjUzR2V5RlNsZVdM?=
 =?utf-8?B?cjg5WEpmS2E4SGNJZ0Z0VGVMN05tckRqZzFZczFlUDhwczlzSzJlSXVJL1I3?=
 =?utf-8?B?cXZEWHVyS3JONVpoS2o0Q25PQkQveHZlYzA4YWcvQ0prWVJvK0tScVNXYmll?=
 =?utf-8?B?UmZKNnk4S1E2Rnh4ZDQxOFNzTmVzbUVuaGhYR3VsaTI4WlNVZm5XOG5Ia0Yv?=
 =?utf-8?B?eUZnZXVBVjFoNTdxU1FVc1AyNVBrVElDUGg2VmVzWDlyVHhEYkp2MFcwVFBa?=
 =?utf-8?B?eENlYys1SU82ZWk5L1BHNitKbkVNVjRBd3lUQUJSUGdmblh2T213azYvaGNu?=
 =?utf-8?B?Ynd1ekJCRjh0enNKcStSYU5JeitQWEFOOHJWc1VYak9ZUDVrWkdBVGNIb3Bq?=
 =?utf-8?B?L2I1RG11U0FyVTQxbCs3UEJCYzF5Uk43OXd4NDRzYW1tWmlrc1JORDBneTJB?=
 =?utf-8?B?bTIrSlphdDNQYjgrS1laLzNML2ZoMXRrYW9NMHBrbmhKenZQV3lWQThnRCtB?=
 =?utf-8?B?cnlLN0hrY3ZSSHpNYVJSd1h2OFRsWXBMeXA5V0RZOEJOZzJueHQxaFNDV3hX?=
 =?utf-8?B?Y1hWcjNpa1RGSWsxRFNnOHVCSmFiaDJ2LzJyRm9kdjBBREgvSDVSL1JrNTlj?=
 =?utf-8?B?WGhidWZPVkt5TkppcjdQN1M0OUQ5QW9BbTBqenJkZVdFOEF5SVdjUDlSeDJS?=
 =?utf-8?B?cnJvSVpmNjZCK1hRN1ZxWnVqamJiVmJmcm1GV1lLUXFoK1B3U2lpK1grS0Vm?=
 =?utf-8?B?M3FZNU1tRUhya1REUTlRNnU0RlUxRzE0SWJSelJkMi9McS9wcm12MkhlZ1hZ?=
 =?utf-8?B?V1ozT00xazNqU0RXSnpqNmt0WXJQYlYyblN3MjRDRFJmS0w4QkdmSHhZVllw?=
 =?utf-8?B?WiswWURCTmEwK3E3U1o3RXJ6OGYza0VXNWowdzhWWWM4c2dENlBDSGtMcEtH?=
 =?utf-8?B?Z1B0MTE5MVRRV0hTcGRFOHliYWZWTy8vQVByd3ZLZTE3dFBDOWZtTFlUV25o?=
 =?utf-8?B?VzhON0JaU2NLREoyQVNWaEpuTnJjbGtZekwwaWgyYnYrY0pPM1JmNDFxSyt5?=
 =?utf-8?B?djRGZHIrZGtqTWYzNWxhaWZ3bnZvb1JjQ0M3QURPOVlacHZYeVhjU3VFL3FH?=
 =?utf-8?B?UUozUDk0a2c5MmNjT29ZN1c1MURTYjN0UDdzOW9LVVBUazJJOW4wQzRBTmlQ?=
 =?utf-8?B?ZTJSQTdmWjJsTkhRSFBNWFNjUU5MOHV2SU9sUGdsanFOcndlcHNmdU1iM3Bj?=
 =?utf-8?B?NkFRbXhxTTdBV1JLcklqak40WUttRHR5TjB4bHpSOWFOK1dKajV2cjV4dmlR?=
 =?utf-8?B?b2F1akNtR21nNGg5d1FyY1d5dGtBcnZQaE54Yk5MTFZPK0NUVGg0SGJHanBJ?=
 =?utf-8?B?c3lWN2RuT3VFQUhIWTJ2aWlxd3hWUW9BcDVjWVdhRjdteGxjLzJlOE5pN2tF?=
 =?utf-8?B?dFVKang4dkVLeDZ2amhOUjY5L1VGTmliRi9PcVdXZm94V0s5YitUWlB1VnJV?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amlCUDJqZ3UvMDI4d3A1QVlwVUY5cDY5YmlLc0VNVXNYbnpqd2ZQVnhjZU5u?=
 =?utf-8?B?V1ZkUEQ0dUVJZTUyRC9PempSYkRNR0M3d2tmbzZjcGxNMDZISG5sK0Vld1Ez?=
 =?utf-8?B?TVI3VDZ6eG1VSk5mNHdoQ1NYWC9NMG1hK0hZK2NicG03dUtxUjlLZDRBek45?=
 =?utf-8?B?MjdyVFhldDZlNjI5aXNYS1dUVDdFclVvdTQ4R0VDMHhtSFoycVlNTU1oM1g2?=
 =?utf-8?B?SGlKakduYjR6eGxOd1ZWMzE2SmtXem5GNG5Pc0xVUS9ITU9QbVpsbmdVNGMz?=
 =?utf-8?B?YndKd1VGQmYyNWZYKzdGVHVzUmRyZFBjdFFhN0pyMkNvUWtmU3owbmpJaE9o?=
 =?utf-8?B?U3F0Rk9ObE93ekk5eHFrYlJYR0pLeWhXdnNLZk1lcUpKU2Q0ZDNrK1JWN1ZZ?=
 =?utf-8?B?T1VxeG0rWGxkQXdCSCtzWG1zUUxkV2dIZTRvVGFUYTcxSkNBcGtqWDRFMG9z?=
 =?utf-8?B?d0JNa2tPSnZUT3BreVp3T2M2bm5aaForVDc1OTA3M2MrZzN6YURzMTRERzhy?=
 =?utf-8?B?ajRwbzk3bFVvODZBUzM4UTVzZnUveTNyVTJTVnQrcC9UK0l2aUxEb3FPUFhI?=
 =?utf-8?B?NXpuTUcrKy85UDhqK09zV0VqbHdsdXJ4STNmVjV2cllGc0NCUjRKcGoyK2ZB?=
 =?utf-8?B?NWRiMGY0b3l3WTZIQ245cnJJWVFmMlV3RnVxU1VnaXdzTEF1dDBFRkJzQnBt?=
 =?utf-8?B?dkFWUngxRis5Vkkvby9JRFNya0NkbnZuTDRDclZXYU9BNkF0OEdnQXIyZzBW?=
 =?utf-8?B?bVZHbDQ4SmhMaTB0MTdCam1GTTN1WEpiaXFkVm9IdE9BSkYzN2xZTmVaVkRx?=
 =?utf-8?B?cDJ5THppL3pLbzNwWVF6QnNNRWs0elp3UTBmOEdmVjhaeGVPSzBpNlI2ZW1P?=
 =?utf-8?B?UmpSc2xDVmNidXJwNk1DajJTNDN1d00yTlppVDNJc1p4NXdXWjR2bEFjVGFm?=
 =?utf-8?B?cnl3Z2w1M0hEaUFGOXdpVTlKWjlDYWxiL2pBQzVROG4yeDE5cWZZY1dHYU9V?=
 =?utf-8?B?b1JmSUNUYTFCOTZ5VXc5Y0krUDlpWXFvUzZCTFBBUGRWaWhXLzFjUksrU1NF?=
 =?utf-8?B?R1pFTDV2bnhTK3hEYjNkTDlncXhoRVpCaU1xZFFpbjV1M3NCYnZpdlN1VWFz?=
 =?utf-8?B?aG9SZ3d6dUgxOEN3WmJqUUx4UUgxWk9tZ1VPWWMvS1JGKzJ4VnI0SC9HajQ3?=
 =?utf-8?B?SnpmOEwzK1VZRzJzbzcyNy9jbzFSNndQN3hMNkMySWRPanFLeTVRTUhoeUNu?=
 =?utf-8?B?Uk5kek9lZ242MUdrcEg2bmRaalVnMFg5MHdCYlFzRlp3WGNqRWNaRFJyazdp?=
 =?utf-8?B?N0dXSVFwS3VhS2hCdWxVcno0T2trVmpKSFVzL2VqTnFUWjlNbThiOFdiaVZ6?=
 =?utf-8?B?OTB5NFlWUUM5T1h0RFYybjcwN3Rqck9wWU9jN3Roa2RJUVBRRUdWdENNamYv?=
 =?utf-8?B?VkRNUnhxVkpsSXBxY2Y4cUFhRnRvckpWeHdwVjVLQzNZUUMyblcvTTJOeGN0?=
 =?utf-8?B?akR2QXBmNEJMUTRjdWFBVFFyajhRNWVzNzQrZnVQSC9WcHE4Z3FUMFJ5em1T?=
 =?utf-8?B?VE1wbTRHN1BaWnR5Ym5UektSeHgvSkxRVHlnd3R4U1lnb3d6Y1hFNnJ5QzdS?=
 =?utf-8?B?cy84a1p6TUhxVXc5UmpaRUdVRGJwRXdodC9PNmlvcVc4bDMrVjMyYnlaekZt?=
 =?utf-8?B?RWF5YzhwdjVzWFhjVmV0cWdsTCtjeHQyRFNWSFpOWkpRMisybTFLUG55Qkg0?=
 =?utf-8?Q?SDmSnEipWi1JOxbT9Lwqf9ezPqfkorvZwpGISyz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925e4228-83f0-451a-aea2-08db663bec72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 03:12:56.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2DqbSv0WOs9KXCjMvd7UmZJJ+UkJ3InyMDkMgAc1FNKOSbruD+OVGUEKP+lKx8hDJvN4g5noJVX+nX4HSWBowRgkzPhzVmGYxIsHEtM9ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060027
X-Proofpoint-ORIG-GUID: qfteWWESaB-HRxVFy9-Cvi8lt-akjpLX
X-Proofpoint-GUID: qfteWWESaB-HRxVFy9-Cvi8lt-akjpLX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/23 7:55 PM, Coiby Xu wrote:
> On Mon, Jun 05, 2023 at 07:01:56PM -0700, Anthony Yznaga wrote:
>> Hi Coiby,
>>
>> On 6/4/23 7:40 PM, Coiby Xu wrote:
>>> Hi Anthony,
>>>
>>> On Wed, Apr 26, 2023 at 05:08:43PM -0700, Anthony Yznaga wrote:
>>>> The PKRAM super block is the starting point for restoring preserved
>>>> memory. By providing the super block to the new kernel at boot time,
>>>> preserved memory can be reserved and made available to be restored.
>>>> To point the kernel to the location of the super block, one passes
>>>> its pfn via the 'pkram' boot param.
>>>
>>> I'm curious to ask how will the 'pkram' boot param be passed. It 
>>> seems I
>>> can't find the answer in this patch set.
>>
>> The pfn of the super block read from /sys/kernel/pkram is passed to
>>
>> the next kernel by adding the boot parameter, pkram=<super block pfn>.
>>
>> The next kernel picks it up through the early_param("pkram", 
>> parse_pkram_sb_pfn)
>>
>> in this patch below.
>
> Thanks for the explanation! Sorry I didn't make my question clear. I
> should have asked who is going to read /sys/kernel/pkram how this pkram
> boot parameter will be added for the next kernel.

I have not specified this in the patches. One way would be to write a script

as wrapper around kexec that determines and appends the appropriate boot

parameter.


Anthony

>
>>
>>
>> Anthony
>>
>>
>>>
>>>
>>>> For that purpose, the pkram super
>>>> block pfn is exported via /sys/kernel/pkram. If none is passed, any
>>>> preserved memory will not be kept, and a new super block will be
>>>> allocated.
>>>>
>>>> Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>>>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>>> ---
>>>> mm/pkram.c | 102 
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>> 1 file changed, 100 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/pkram.c b/mm/pkram.c
>>>> index da166cb6afb7..c66b2ae4d520 100644
>>>> --- a/mm/pkram.c
>>>> +++ b/mm/pkram.c
>>>> @@ -5,15 +5,18 @@
>>>> #include <linux/init.h>
>>>> #include <linux/io.h>
>>>> #include <linux/kernel.h>
>>>> +#include <linux/kobject.h>
>>>> #include <linux/list.h>
>>>> #include <linux/mm.h>
>>>> #include <linux/module.h>
>>>> #include <linux/mutex.h>
>>>> #include <linux/notifier.h>
>>>> +#include <linux/pfn.h>
>>>> #include <linux/pkram.h>
>>>> #include <linux/reboot.h>
>>>> #include <linux/sched.h>
>>>> #include <linux/string.h>
>>>> +#include <linux/sysfs.h>
>>>> #include <linux/types.h>
>>>>
>>>> #include "internal.h"
>>>> @@ -82,12 +85,38 @@ struct pkram_node {
>>>> #define PKRAM_ACCMODE_MASK    3
>>>>
>>>> /*
>>>> + * The PKRAM super block contains data needed to restore the 
>>>> preserved memory
>>>> + * structure on boot. The pointer to it (pfn) should be passed via 
>>>> the 'pkram'
>>>> + * boot param if one wants to restore preserved data saved by the 
>>>> previously
>>>> + * executing kernel. For that purpose the kernel exports the pfn via
>>>> + * /sys/kernel/pkram. If none is passed, preserved memory if any 
>>>> will not be
>>>> + * preserved and a new clean page will be allocated for the super 
>>>> block.
>>>> + *
>>>> + * The structure occupies a memory page.
>>>> + */
>>>> +struct pkram_super_block {
>>>> +    __u64    node_pfn;        /* first element of the node list */
>>>> +};
>>>> +
>>>> +static unsigned long pkram_sb_pfn __initdata;
>>>> +static struct pkram_super_block *pkram_sb;
>>>> +
>>>> +/*
>>>>  * For convenience sake PKRAM nodes are kept in an auxiliary 
>>>> doubly-linked list
>>>>  * connected through the lru field of the page struct.
>>>>  */
>>>> static LIST_HEAD(pkram_nodes);            /* linked through 
>>>> page::lru */
>>>> static DEFINE_MUTEX(pkram_mutex);        /* serializes open/close */
>>>>
>>>> +/*
>>>> + * The PKRAM super block pfn, see above.
>>>> + */
>>>> +static int __init parse_pkram_sb_pfn(char *arg)
>>>> +{
>>>> +    return kstrtoul(arg, 16, &pkram_sb_pfn);
>>>> +}
>>>> +early_param("pkram", parse_pkram_sb_pfn);
>>>> +
>>>> static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
>>>> {
>>>>     return alloc_page(gfp_mask);
>>>> @@ -270,6 +299,7 @@ static void pkram_stream_init(struct 
>>>> pkram_stream *ps,
>>>>  * @gfp_mask specifies the memory allocation mask to be used when 
>>>> saving data.
>>>>  *
>>>>  * Error values:
>>>> + *    %ENODEV: PKRAM not available
>>>>  *    %ENAMETOOLONG: name len >= PKRAM_NAME_MAX
>>>>  *    %ENOMEM: insufficient memory available
>>>>  *    %EEXIST: node with specified name already exists
>>>> @@ -285,6 +315,9 @@ int pkram_prepare_save(struct pkram_stream *ps, 
>>>> const char *name, gfp_t gfp_mask
>>>>     struct pkram_node *node;
>>>>     int err = 0;
>>>>
>>>> +    if (!pkram_sb)
>>>> +        return -ENODEV;
>>>> +
>>>>     if (strlen(name) >= PKRAM_NAME_MAX)
>>>>         return -ENAMETOOLONG;
>>>>
>>>> @@ -404,6 +437,7 @@ void pkram_discard_save(struct pkram_stream *ps)
>>>>  * Returns 0 on success, -errno on failure.
>>>>  *
>>>>  * Error values:
>>>> + *    %ENODEV: PKRAM not available
>>>>  *    %ENOENT: node with specified name does not exist
>>>>  *    %EBUSY: save to required node has not finished yet
>>>>  *
>>>> @@ -414,6 +448,9 @@ int pkram_prepare_load(struct pkram_stream *ps, 
>>>> const char *name)
>>>>     struct pkram_node *node;
>>>>     int err = 0;
>>>>
>>>> +    if (!pkram_sb)
>>>> +        return -ENODEV;
>>>> +
>>>>     mutex_lock(&pkram_mutex);
>>>>     node = pkram_find_node(name);
>>>>     if (!node) {
>>>> @@ -825,6 +862,13 @@ static void __pkram_reboot(void)
>>>>         node->node_pfn = node_pfn;
>>>>         node_pfn = page_to_pfn(page);
>>>>     }
>>>> +
>>>> +    /*
>>>> +     * Zero out pkram_sb completely since it may have been passed 
>>>> from
>>>> +     * the previous boot.
>>>> +     */
>>>> +    memset(pkram_sb, 0, PAGE_SIZE);
>>>> +    pkram_sb->node_pfn = node_pfn;
>>>> }
>>>>
>>>> static int pkram_reboot(struct notifier_block *notifier,
>>>> @@ -832,7 +876,8 @@ static int pkram_reboot(struct notifier_block 
>>>> *notifier,
>>>> {
>>>>     if (val != SYS_RESTART)
>>>>         return NOTIFY_DONE;
>>>> -    __pkram_reboot();
>>>> +    if (pkram_sb)
>>>> +        __pkram_reboot();
>>>>     return NOTIFY_OK;
>>>> }
>>>>
>>>> @@ -840,9 +885,62 @@ static int pkram_reboot(struct notifier_block 
>>>> *notifier,
>>>>     .notifier_call = pkram_reboot,
>>>> };
>>>>
>>>> +static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
>>>> +        struct kobj_attribute *attr, char *buf)
>>>> +{
>>>> +    unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
>>>> +
>>>> +    return sprintf(buf, "%lx\n", pfn);
>>>> +}
>>>> +
>>>> +static struct kobj_attribute pkram_sb_pfn_attr =
>>>> +    __ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
>>>> +
>>>> +static struct attribute *pkram_attrs[] = {
>>>> +    &pkram_sb_pfn_attr.attr,
>>>> +    NULL,
>>>> +};
>>>> +
>>>> +static struct attribute_group pkram_attr_group = {
>>>> +    .attrs = pkram_attrs,
>>>> +};
>>>> +
>>>> +/* returns non-zero on success */
>>>> +static int __init pkram_init_sb(void)
>>>> +{
>>>> +    unsigned long pfn;
>>>> +    struct pkram_node *node;
>>>> +
>>>> +    if (!pkram_sb) {
>>>> +        struct page *page;
>>>> +
>>>> +        page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
>>>> +        if (!page) {
>>>> +            pr_err("PKRAM: Failed to allocate super block\n");
>>>> +            return 0;
>>>> +        }
>>>> +        pkram_sb = page_address(page);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Build auxiliary doubly-linked list of nodes connected through
>>>> +     * page::lru for convenience sake.
>>>> +     */
>>>> +    pfn = pkram_sb->node_pfn;
>>>> +    while (pfn) {
>>>> +        node = pfn_to_kaddr(pfn);
>>>> +        pkram_insert_node(node);
>>>> +        pfn = node->node_pfn;
>>>> +    }
>>>> +    return 1;
>>>> +}
>>>> +
>>>> static int __init pkram_init(void)
>>>> {
>>>> -    register_reboot_notifier(&pkram_reboot_notifier);
>>>> +    if (pkram_init_sb()) {
>>>> + register_reboot_notifier(&pkram_reboot_notifier);
>>>> +        sysfs_update_group(kernel_kobj, &pkram_attr_group);
>>>> +    }
>>>>     return 0;
>>>> }
>>>> module_init(pkram_init);
>>>> -- 
>>>> 1.9.4
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>>
>>>
>>
>
