Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FB65F0BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjAEQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjAEQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:04:17 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C917052;
        Thu,  5 Jan 2023 08:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaTjzeLVdk8XS6kgLZfHp4m6bxiIIv0Ixn5GvypNateZocBcDjE8DT68htw4+sqKRgNXAxQvXzHPAfOQEOS/AZplAmqqE9rW1pMnVg3WF0rBNLVtWqSWpgZgzza1yzNXlFu0nS/eODLG4ZGX6XJr6j8gqvi+aRH6CWSEU2L3xpvOd+JfLxBVgbGNomSzoSAQTNX0AHntqgeaB16oD4CqBT4fwlPRWuMO8SqLWCSNLPKnPV77SakE7fgbgz5n1jxGISZhdVMnAWrbr/y6qYybqsAZ0dcJ5F53SJkwpWAcBi+X5PRjMtADoS2njUR4jz2meYQObx00P8J3xYWdXGLq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sXZ9j6BQI+GxdItsd66aovwCWm6WG/V+cFH8A7E0NM=;
 b=NPQsFxEJ+Sak8HdZYrMCxmLJYISqEoheiW/8B+tmCIK5vQk+3Kn99LEqGb7w/p6up/N2OqakmWmlnc8tO9Fk3ThHORRwVqqMtq2NrLZPIHtC/cZFmWSED1XSfBqrgl3fE/pTr+rpDKeAI+9GgMcJ/ycZAb0IhAgfYe6WORkAm937aXebEzeyTwb0N9jmsTCFThrexAEnsRjtJ9wJcIWM96b92HuPI8mF5Sa/YBDJD5Suy6A+cJD2pLjIGhQVrcB110Jus0ddsnWYWb+DClIiN2lG1e/OP9n2nmMdb3cpsyaTnmFRjFdrK7kq0i5Avl6/MKIWNcb1lfxnMKVzhp4oSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sXZ9j6BQI+GxdItsd66aovwCWm6WG/V+cFH8A7E0NM=;
 b=MbuLa2ZX+jXgJz2pnF+Wgx/8PyTpSsSTWH8qL/fSSHsGv+IkSNZsNrw0lWDf6/W8R+2KC70VCdWEGpr0GUT/otYXKuZVPalW9I7P8XA/Li0wl29eJzHGPoO17LpXAt73DTJtt9ddg/i2ymiIO+RIBH8oITfJa1Z12krH59JouHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:04:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:04:14 +0000
Message-ID: <d92fa6b3-227c-32f7-87c3-c267e052a824@amd.com>
Date:   Thu, 5 Jan 2023 10:04:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 11/13] x86/resctrl: Add interface to write
 mbm_total_bytes_config
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-12-babu.moger@amd.com>
 <3dc31a6d-5485-746d-3c49-df7dcd1827e3@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3dc31a6d-5485-746d-3c49-df7dcd1827e3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BN9PR12MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c2682e-85d4-41a7-e548-08daef367d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSzDxIFuNn/5loos9RAxaFhQGZtxD25BDXspYvhZontnrbhNwyDZlKG7dgnFQGbidamZWgtpYmjTU70lSVoUpPJEloqzo7kmiyEZxmjZNPe7HB9lgknQ6rFC5AyP3jMTbKaEe5uV030Ii8zslCZLX0AXNFBIFrnCjbBxomqc+wFUAyscXc96FReGiR1r918imwGpiiRd2uE9BzqHZ/1b+iyLaK678lEnWo/2k0a718l5ScXlM4XEVdw6sVN1uS/gSy7nxZ3Q8z6+tmFUA5ZE6NHLAv0jAnZ3cyJ3f/7UbIIiedoBZ756KxT7YdoWQwZKI3ltLiYa8RIYqE6ykhWSb0LyB6t72ER94WZQG1VHCzE0fLHX6crDV/P7MvuF7ZLZThSle1acvSDsguOPfXJph14pXJGY/GXRfvnfCMNIv3juDVKnR0sQKpDhM1e3/h7svQGkLbCw5hex0rQr6q8g+7ZZNrwBmLXXJ9gOJx/ttyrjFTm/Eco/RzCWce9VZYK/JV8//SAq/tX6zipjot00c5PIpVAsfvTqnsApQPwg+acap74ELyYi4ZpXhO5+2bu/kJqJbNyugSNg+9dhUeI2YwCUZsl/x/QKub/4bynkPWC6ywpEz07ctWF+aPFsPN+9t4E6RD4uwZF2Bojo4CDri7q+QwMZnVVpePMYrtEKvrYU4xcfvdBENIuwbIMF5qeZLYW/WT7JKIe2ujpIdBhGxkIWrKiBNbmKvM0x8F/bRJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(38100700002)(86362001)(31696002)(83380400001)(8936002)(7406005)(3450700001)(2906002)(4744005)(7416002)(5660300002)(8676002)(66476007)(66556008)(4326008)(66946007)(478600001)(41300700001)(6512007)(6506007)(26005)(186003)(53546011)(2616005)(316002)(6666004)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3VieXJVQjl1QUJZeEVNSXFabEZhS3kreGorcExoNU90SXp5K3JCUXhRNER1?=
 =?utf-8?B?aU5kK3FyRWdDc0lUUnB5Z3lpNllZQUJyZjZib0w3RjB3OFdhbk01MGhkN1My?=
 =?utf-8?B?UVZFektyZGNQWmtSN2xneXhYOUgvS0xreityTk1tZFByRTFkNk82dVBIbmhi?=
 =?utf-8?B?STRTZWRlYXVuK3RObWRlVndLeU1GN0UyRVBVTG0zbWx3blVtczc3ZndzMFdB?=
 =?utf-8?B?N3kxSzlQb3VzYkdvOVJJK0lxQ3B1a3hGT29NeGJzRUp4bWlnbkdmSzdKS1VJ?=
 =?utf-8?B?d0lyenVnNGp3ODBDb0h3d2lENjZWZGxqNmVldWg4WVpaeFUvcjRxS095bXZE?=
 =?utf-8?B?RmZsWVZCRXc1K0d6emwwRkJtK1dmeXhRZ2ZaN2dIeXV3ZVRvVHI3QVNIOEtQ?=
 =?utf-8?B?SG93bmtFL2k1MEt6WUlsZW9qbHFyNmhhem83OWtVMDF1c3dKbjdXZFdFcVJw?=
 =?utf-8?B?Nks5dXZVVFB6aGZpUFJHTDEzVDlpQlpQdlA3enlWL1J2aEtUOHdLeDh0TVFk?=
 =?utf-8?B?Z0ExdHBrUWpGRmVUbzVCOSt1WHpZbXo1b3BTWk5Pd2cxOG1Rd2hjWDBaWXB5?=
 =?utf-8?B?ekptKzVERjhYbFQ2NUk2VzR4WlJ0cm95TEpORjZ6YTdiZTd4c2JTQTE2alh2?=
 =?utf-8?B?OUJhc0Rid3gxaWpzUHFadXF4T3JnRGc5TFdYYjR0elFCNzRiMUVjY0VZWGJB?=
 =?utf-8?B?WTU0WVlOTVlIYnQvRkhnK2xvaGJvVUdpWGtHTlltVlB0aW9SbXM3ZkZkdjMr?=
 =?utf-8?B?MWJlQmxJUml0QmJ0UHBHa0wxNkhjdGVwbGNsRG44MmtlVkxKc3JRR0JGU2du?=
 =?utf-8?B?VStnVExHN0cwaWpXaVNaUWo1VW90eXpNSUtPckc1bkVmTG44SzNmTTk1bFho?=
 =?utf-8?B?elRRQWp5TWZ1Y0dNNmFvK3FOUm5nTGJRQ0pDZ2lkQ2pPWEhMWHZuTDVESDVV?=
 =?utf-8?B?UkR2TDNsT01CekpQUUxsYWd0TGJXSmt2ckc4SFkrUHNhUGwwU21BVWNWbXNN?=
 =?utf-8?B?V2ZBOFFDZm1UWkNvOCswTU56SHcrWWZXZ3lOUkFiVG9yekgvVGtQdG1nWllQ?=
 =?utf-8?B?ellqRkpqYk93RVdjVlo4anJqUXptNDE2cDV4eFpmUHh0dml2SnI3Und2S3o4?=
 =?utf-8?B?Unc4c29Bb3lCRGdvTEROOTc4MEdIMTRDdmlBYm1jM3dhUVFRRXZyK2JNUXFB?=
 =?utf-8?B?M1I0eTB1cWZBRy9DTC9GZ0ZMVXVGVEtzNVAxV3RodC9rakRXWlNsLzRUamh4?=
 =?utf-8?B?Wk9EanlDdm1LMjJCL1RzOFpZdm1wK011Vng4d0JTcFprdkQ3WjBYNXFjN2NE?=
 =?utf-8?B?M3M5b3hIS2pFd1hTU08vMGlEY3MraU1iZHBCUEpVMGVCMmN2UlpNZFQ0NGhk?=
 =?utf-8?B?dCt1QUFwNUg1ZU8xcGgzcGVXYXc2NEJPN1A5ZWw2WWFKbHRKbi84dENrODZi?=
 =?utf-8?B?eWx2eUVQUERIQkJ1TkMyTUNJWG1xZHRqMkJIeUY3aEd6ejJuWlVYVUdSeHo2?=
 =?utf-8?B?ZFkzYXVFZWFPMzVGcFdZRURmUWIycDk2RlRXcDJCTFpRUm9rZlc3UmpRU2du?=
 =?utf-8?B?TEdKV2h1ZlVTeUhnYTFFdG9GOEdWZ3NXM0ZJWnFza0JNMHp1Znlzd2R2MWFS?=
 =?utf-8?B?MThobHBTdm11VFYyWWNYQm1wcll1K0ZScXIxWC84MVcyL1ZvRHR5WktZUVNm?=
 =?utf-8?B?NTM0SVlGTTJ2L2RKd29ZaVFPL1piMnh2czNTbXdCbUZQbjUwbVV4R2RoR201?=
 =?utf-8?B?REdUa1pNekkyUkhGSDFKMkUvOWlrYlVhNTE3dEg3MUE3VzVhZlRqZ1NPZU16?=
 =?utf-8?B?ZGN1eVY3WU9ZWTVRaXUvVk4ydmV3Vm42WUJPYWQxam9QYkZwUHlBN1NaM1VX?=
 =?utf-8?B?OUFlcDZwa09aUVZUcmZIVytDOXVhOGtpZTNUWEdCQTg4bW5ZNnpURFJobEsz?=
 =?utf-8?B?bUljbDlyaEphRWx3TGllNUhUWU5tQjBqbjkzU093VVJyNGVFNUlSRUhMRXJS?=
 =?utf-8?B?dFpxWnNTMEMycC95UG5QaUJ1STNZSitpUk16NHdiS05PZ3dYWE11NnhIZXBk?=
 =?utf-8?B?OXpad09TWEhGRmxNU1Uvenp1YmhsZFdaUTV3NHJDZzMrWlc3eWg3M2VIRXQy?=
 =?utf-8?Q?u7H4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c2682e-85d4-41a7-e548-08daef367d7d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:04:14.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG/KkldkUXrY4ZO4LZ5Au/EiNiPQ1w2ZJ25TopNHuME2vYF9Ln9n2duZv8T54t3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/4/23 18:29, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/22/2022 3:31 PM, Babu Moger wrote:
>
> ...
>
>> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>> +					    char *buf, size_t nbytes,
>> +					    loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	int ret;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	cpus_read_lock();
> Could you please elaborate why this lock is needed here as
> well as in the following patch?

Holding the cpus_read_lock() make sure that this cpu is online while doing
this operation. This code eventually sends an IPI to write the MSR on one
of the CPUs using the cpumasks. My understanding is to make sure cpumask
is stable while handling this write.  Same thing is done in
rdtgroup_schemata_write.

Thanks

Babu


>
> Reinette
>
-- 
Thanks
Babu Moger

