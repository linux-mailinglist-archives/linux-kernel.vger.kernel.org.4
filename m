Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470A65FCBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJLUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJLUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:20:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A454663
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:20:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKFgdl010273;
        Wed, 12 Oct 2022 20:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FYN/i14Ob5neKFN0zP31T0SVupN+sbzg4n6ewCpPMX8=;
 b=esnNlZCqCWA1GRY3fh+tO2MeNpHV8pi428NICp8FpwaXqmmXDdw5hoLIOLXkNXuQ5eXh
 ZAmRyJe+6lXOnMLr1MzuDTlu/CgpNF95LP6VpFkmm7QgWp4N0cKXeT6UYA5YbPn+cEIG
 I7smaf5OsQd/youaAk+hZVSe1P0/ne7A80EZLCNoqzsB+zMrRt9iE7f4G0AK8EAo6Qk5
 tZqKh0mkYFm27aJ+logYGYOQ1sTPOuc7lc+q8YEPfXvhh8Cazo7/U+saMyQXU/nlouYr
 J1H41FijFd9FFBDJ/7aGGeWDOP1QMF6RBCaOmvu6e+LzwORhdTYNedQEEqR85P7hy/zS mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1k91d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:19:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CHr83o039751;
        Wed, 12 Oct 2022 20:19:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynbsapr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se18jW0dyvbKsIa6VKCt1mFVtV2mhhlAEWfhH52uqX+1jv+NSkuh0/wOznh6LWp7Zx7d12H3pdmbM+CYvMPNiKKaf1mL5r7z7/e+SRcTD1awxYvwy4b9An7AkFX2jCrGvuZpOOG/ZYZTYGLS0AuDe9njgqXQ6k2xnzVpmCmk7xOtXMhxkadsxrVPf5Mf5fQ0SY6/8s05Xjy71yx8EpgTC7XpO1Xs6pKd0FoZjA5KZmNxl8pLW2yj/FavDztLzZoepg0elUG1FL2+bb5Uaqxa4tS2AaAxccO2UFBMgt2nsvheCeB8NYrMy8SbKR9LjEq3Sy9Wtn4KOrHcC66tG0qdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYN/i14Ob5neKFN0zP31T0SVupN+sbzg4n6ewCpPMX8=;
 b=UXRVPJcnGAC3mfbbAVfw5Mg6udG/Fqm7UGu/TFJwnrA4RmkqIMWCTIHSZ9Wcj9lXwT2cV9M4S6KMbifZDKzsoz006oUrg3etC8VTtkr2YzDQX6foK657ikSlEZ7EM6gJiyNES+JuabuSgV7QVy/eS3qbrKrazqs5lljK5Ax3UcocTzdqmolOfmJaT7jf/zPb48FEbtsb5be2Wz8SnOy9G+GZaLzlowddhfrHwq2E3CuDDM3T7wWLXKkWaFMCCUWtVBQ3pj/GEKk38xjrrDGU82L2doNnvHdosjWA17120PD8wQE3TwNPMx6AXv0fe6SVkqLwje9yzx0+6iUW2XEU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYN/i14Ob5neKFN0zP31T0SVupN+sbzg4n6ewCpPMX8=;
 b=X98qhWhUxaA7MYWQVaeKcmpdtl4RiMeN+9zORYSilQvvaK7puPa+2TMATv86ZJsNaGfiGdpZpgWOfiUGSLe23yNT4vb9e91XqtJN9Hbl7phKhdVSHaOSWN0MqJgCu/29uV/IagJFtZKkrt8cDFgy55vGnEKPjLQKJry/JHOkGzU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 20:19:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 20:19:26 +0000
Message-ID: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
Date:   Wed, 12 Oct 2022 15:19:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com> <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com> <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv> <Y0b9apyIs+RpSo1e@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y0b9apyIs+RpSo1e@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: f39b8fe3-d017-4026-68ad-08daac8f0f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee53uLdO5ecl028OA1oDzDx/+D6EidtxDh9YT81fgoHQ5JGYxdULKFRCq4RoWjp/eZX2xwDoBCkNOQIW5RVeV95qVB5CeRLT9+HLnr4SbeTDmPQTwPztpDV0t9F+YkCxRFu4EiNGLv+8PMjoBsJYXxytMjp0ExFUEZ12IMnc5KB8/wuiXQOSnu/89FYMq6Y3hb8qgUYPryRh+y4uvQ8TqnBQq6+PpeYrdCZxjI7cuHpEGZFPCN0TzhzSIjV8/ziFEv7YBOfiJkbvDCmHfrm9YfcqEyRaaZAoyJTTxy5Ob/G31NDJDx322CRCI+AwDf74bNhjNhrXcoNLLk6yNcDYsoth/hPrQ6oaWT8/zAWMdLABAgkEg4HNjxbxE3jG5TXiQh5Jq0NEdZx1/cLdKArpSXjTll740XhYuzwFlfvjDvISfrrJyqqBOJQHrTNXnkem2MxOBTpsSz3MEUi0VikWuJUSi83Y2NO05OTTFHFn5DJw/Xp2fB2exYM7FonZw+o/ErUtmkOVaJ099WrZT23wQ9MKfwO+Uumv6vg1GI5uM5YdzS4XX+K2SYfunam03/eeyiHtjDuKw0ZNxj4BMSEkfxUxMX+z/ig+JoQcDmnbk3EAfKHM7fy/1CX2gp5DptQl2pzS6PufCToKaU0PAIKb2eh0AJWtyElON0suc3JOkRfyprE/AIq6LPKmnz85vlBSXT0LJcjLqWnKlaupm7i0fza5M2fM6PXgguogjv0q2eOkwF+hlAnUNd1AzbpDvH4W38MDGYubLLwXWdo1ay/4SuaApdIdgjSb0fnRdBTV0ME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(54906003)(6666004)(41300700001)(66476007)(36756003)(316002)(478600001)(5660300002)(6486002)(66946007)(8676002)(7416002)(66556008)(8936002)(186003)(4326008)(38100700002)(83380400001)(53546011)(86362001)(6512007)(6506007)(110136005)(2616005)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdxZjFJdXBSZkh5UldIT2NURE9wZUo4T2Jyck9NQWFiaVN2cEFEMTJQM1Np?=
 =?utf-8?B?ekhyUmFpdld3cVFxNS9OTEhJbU1ZV3FEc3g2YTc0a0Q4amc1N3d6aWtwK0FM?=
 =?utf-8?B?OFB2cjRnS3FnQUhRREVDWHh4bVJCcnNtZ29wOXYyUVZuR1I1ME5KdmRtWGdi?=
 =?utf-8?B?N25SZm1sYUZJSTd2OXVrRWl4OHhBZWhSV0hIQW02L0dFMlRwZnJmTHlGSTJY?=
 =?utf-8?B?bVl0R0svT2ZhSVhRM0UvSXIzSDBsWndTdG41cUtmOVdhbUhkejhtbXpZZlJy?=
 =?utf-8?B?VnJFWmdCL1FLTHlIRnNIVURYSWV6TEt2ZFlZOG5MRzBZc3BFK1FmWVc0K3h3?=
 =?utf-8?B?d1F2ZDZEcndXRWJiUFdWQzRCQWVQWng2QllURURXT05qc3N0a21LNGo0Tk9I?=
 =?utf-8?B?L2wwN2p6THlYOU9BYUFzL1FYd0ZRNFhGdWh6RWJZTVljU3NiVkd6NVVUWS9L?=
 =?utf-8?B?bHBYakFTcVkwZll3dWNTTzBSbnkxT0JFRDhqbDZMRjRBaWJsdlZ2SW9JSlQy?=
 =?utf-8?B?TjI0cjJqUmxoZUVQTGVPTGU4NHRDcXFtbjVYcEZqenRnaUJEemNnSUd4UUFS?=
 =?utf-8?B?bVQzMkw1TEt0UUoxdXVqd2xlbkVyclh3QWlsNzZ4VExBbGhGZzBMdjI1dkg3?=
 =?utf-8?B?V2tFQmZEUlBja2VYK3NFeTQ4RFluRlZNSFN4UG5hSnlXc2hDL3hDQW1JUDJ1?=
 =?utf-8?B?aCtTU0pSY1VWVEVTVXliOFpkUk9tUDkwVG1qaGd0SE5rQitRQnBsY3BVVGhw?=
 =?utf-8?B?L0lSWTYzUEZtVkhwNDZrUnJWT3JKTzJaT2grc09ZbUdmKzI2dVpTRE1neGIx?=
 =?utf-8?B?MWZwNFhESmhObWlMV2hZRzVlbjJXY1VEWjNFeU82QlNxR05XMGM5U2d0SE4x?=
 =?utf-8?B?OEZwcGNVWGFJT0pCUkZPemFWa0xuZHBNMU4vY1pYY2NmQkpEWXJ1T3lQZFRs?=
 =?utf-8?B?anlDc0NXMzB5Ynd5d2lEVEtNMzFGdHBmaVE4WHc4QzRHeVlpNE9SOFhWV1ZH?=
 =?utf-8?B?RWZjaGEvZVQ3eDk5eC9OdlJkSHZndHEzL0pZSmMwbUpZRU1JdVVsZ2w2T09p?=
 =?utf-8?B?WlRKT29kbUM4VEdSU1JGbzQ0TGsxQmQrdUtma2FCc1NsZmFsc0s0TlJ0YzNo?=
 =?utf-8?B?MGF2TVg3WDdqS0JSZU9ucGlZSUdRUk5ocisyMUNzVk9QM21uUkdyNEVHNlZX?=
 =?utf-8?B?YXRkUXhyUlB0K2NlbXBsWW9zOHp3aTJhUy9VVTlnNXdiUjNwOTQrL1NsdkVM?=
 =?utf-8?B?R1haZVpMT1I1cUhFSXVidmlyV2lHZWRBLzdlajJKK3ZPdWRWeHphZGVxdE8z?=
 =?utf-8?B?OXdtbG5jN1R5N3FTamxrbDJHaTNqZTRsanZGZ0RRYU95eHBSYkFtVUgxSSsy?=
 =?utf-8?B?VFYxZ3piVTM2eWQzRXdub1JCRzhnT2R5MzVocFBrcmlWNUFkOTgzWHZiUVhu?=
 =?utf-8?B?eHc4STcyYzdBVklnaTUxL1k4VjZJeVN5OEIrbHVVNUhXSXF6dHdhWWRDdVRw?=
 =?utf-8?B?WmorK04wVFliTjZabXRUNUYvZVdKUStXcVVOajRPZmZ4cXU3aDZVRWZBZEhS?=
 =?utf-8?B?NmMxQkdieUtLMFdGdTlycjNzTnllVDY0bWo3dTQ3U2ZwTXVFQmtDeHQ0VG5n?=
 =?utf-8?B?SVNacDF5d0pUdktadE0xbkE0MGc1ZUx2WWxPZ1p2V2xHN2FqeFVqUkIzVEk4?=
 =?utf-8?B?aXd3N2hzRGV1SmJIKzd0ekZWbGZGVGdjRDMzc1ZZUHdvZ2xoZ1NwcWtxSEto?=
 =?utf-8?B?cnFlWUJ0b1pKRFpMRjJBYzVQcjczRUFwQXhDNnFwSkU3NU1qUTVOQkRDWmpi?=
 =?utf-8?B?SnhzTnBjZi9CR2Q0Ris4Sk85VXg1djJnTGdhT21iVndHV05sWDBRKzNWNTU2?=
 =?utf-8?B?aWErL3JaOGVHZktqaXc3c0ZMZXo3R1VxVjFUMlNqeS81L0xqNzZDU3lxOU5m?=
 =?utf-8?B?R1QzcFJUUWRhMVNFbFNNeUhZREhPT3luTW9mTVdTY0ZDeHVIVlhwVEEvNjhi?=
 =?utf-8?B?QTZPbmpnNVNsYlBlRkN2Um1wbHNJWFgyVndIcUJMQVpjT1FJcThHMkFJeGJU?=
 =?utf-8?B?SjdTNk8yOWxldm9GNW9RazFZQmtpU2h4NWtxT1dUR0ZubUJuUFl3T3p6dGNq?=
 =?utf-8?B?YzZmcG0xRlZqNW5uVnNWY1VXR0o5eEFLUmJSbmJNLzhkUEs3ZWFnVlFNUm1s?=
 =?utf-8?Q?ifupYMHfzy1vNDgzZQ8dViA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39b8fe3-d017-4026-68ad-08daac8f0f74
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 20:19:26.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuqgmvNBg34sdVTpHQkb4tGDtKWSmS6mjzsuIfdSs99DpTFKynyVZt6wdrsk98+xxeum9F3QMAbkHG5JN3MfUL3WS+TvWeR2zCk0Wt5ZRPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_10,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120130
X-Proofpoint-GUID: y_xyDX_hqxwHrzHk6g9SN5wd7ggFbW-z
X-Proofpoint-ORIG-GUID: y_xyDX_hqxwHrzHk6g9SN5wd7ggFbW-z
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/22 12:46, Borislav Petkov wrote:
> On Sat, Oct 08, 2022 at 10:35:14AM +0800, Baoquan He wrote:
>> Memory hptlug is not limited by a certin or a max number of memory
>> regions, but limited by how large of the linear mapping range which
>> physical can be mapped into.
> 
> Memory hotplug is not limited by some abstract range but by the *actual*
> possibility of how many DIMM slots on any motherboard can hotplug
> memory. Certainly not 32K.
> 
> So you can choose a sane default which covers *all* actual systems out
> there.


We run here QEMU with the ability for 1024 DIMM slots. A DIMM can be any
reasonable power of 2 size, and then that DIMM is further divided into memblocks,
typically 128MiB.

So, for example, 1TiB requires 1024 DIMMs of 1GiB each with 128MiB memblocks, that results
in 8K possible memory regions. So just going to 4TiB reaches 32K memory regions.

This I can attest for virtualized DIMMs, not sure about other memory hotplug technologies
like virtio-mem or DynamicMemory. But it seems reasonable that those technologies could
also easily reach into these number ranges.

Eric

> 
>> For the Kconfig CRASH_MAX_MEMORY_RANGES Eric added, it's meaningful to
>> me to set a fixed value which is enough in reality.
> 
> Yes, exactly.
> 
>> For extreme testing with special purpose, it could be broken easily,
>> people need decide by self whether the CONFIG_CRASH_MAX_MEMORY_RANGES
>> is enlarged or not.
> 
> I don't want for people to decide on one more thing where they have to
> go and read a bunch of specs just to know what is a good value. So we
> should set a sane, *practical* upper limit and simply go with it.
> 
> Everything else is testing stuff and if you test the kernel, then you
> can change limits and values and so on as you want to.
> 
> Thx.
> 
