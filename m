Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F010965D8E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjADQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjADQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:19:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68729167CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:19:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FO8Ri025769;
        Wed, 4 Jan 2023 16:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=N4hZ41BRRT0K3RKUPnen23ZLHJ2kkFzyh9xSOFFadAs=;
 b=pjZGX7kprmJQH41TpG+To2BgXTeVIClA5LOr94BgU0YJ2HtPC7UuU20YtvyjaXKcN3sE
 smfAd7GcIpTsW8v+65ddTXDXiRLvKNHLorAI3sGNnjmI6LaoQ1QRPZIUNN7Oy/H1Eua2
 ATUlr2jxNTO2o7y3OB9gm8HCLn6Br1WhegaMqrPoiIiJOu65SA4TD1QZ3dUduvA8A4OO
 pmtEReSIh6Q/zQIYMuZmAkoMrjBnfGhLnLNVYWWj3xFV64Ig/BVBpgzrTpydJ71s+gt+
 rZdRUxbEMMVZsmkfastZ2vqSnvOD9MmG+SZSFRWq4qM7QfxYJk3aQCTjAjUSTo1orZwH 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt6w7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 16:18:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304FrnTa002666;
        Wed, 4 Jan 2023 16:18:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwcghh340-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 16:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axbr8yO0UlwNQRdS7XAz5Jwlk/42A5w7HTNrJVMP0W5qkVqTHaveQe6oMQ/YwGwHZR91OyCVnyepohwfs4tTJ8Xbx1RQ27T/LrjoHwE/JqXc+1AQHYdZmf4lK7x29b+I7mUVAgserqxxirhlto6GkuyrKi9bcCimmqZf7xM8FDn3cg7O70cYYBeoCpTMICHdI89ZexmMxSYDhvkm1ESiQszGDapr+xMt7nG7KfvSF6SjZseHwdTPiswZ6QvyrTKHHHbyQSn4jK0t1+4H8Qcq/QlBOg/ZGlq/Xu9v/zYwx7yq34JvKrd0WlYbE+JTNXcharN2OHP10bHwT/Xiyin4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4hZ41BRRT0K3RKUPnen23ZLHJ2kkFzyh9xSOFFadAs=;
 b=Ec8cCF8QDi6bNWfG1DSACV37L2+ZjbiDEg8yhbJTfNiv05FyXaDjivq4Nr84MFsAKbZBdmFwPi6AQ2Sl5cwt8TaRmDbGGYmOvcSqcGA2oqNC8wDlH/5i799UCbzGtUyPS39C9RoYHtV86ImmoYR/Z/oMRGQ3YZluvVhCYazebSpY8FVDAf0pZ3nS/S1Q069C2LF0dPJ9ZZObSi0WLAu4NmJItFltguWKBGv3K4Aws8rFQZeqAsM15FrgbCon6G7MR9eF/CtdEQ/9Stvuh6/B1pKTL+vgLhjM5RFJn3/+DsZZeX+7Ha0Ny/rVISJbF8pQBwjmVZ+OcpVXUIgfe7Nd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4hZ41BRRT0K3RKUPnen23ZLHJ2kkFzyh9xSOFFadAs=;
 b=l9gZPrwIiT4BvPwXiidJSEYWoFLniC+bySo+nq1BFovE2H+Yeg+CH2N9+IQC6btPlL5ughw2ebmC8Sn8dY/DVTCOPqpTEzadY11fEnOl6F3oLfJEm88juLHYNwCCaHmDHI9aSZTY2lcVIWi7sv6a0uWPTf1/DMuHc1oZ4TYpW3U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:18:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:18:53 +0000
Message-ID: <cd0eaff5-d0b0-aa61-af30-d23f48c40aa2@oracle.com>
Date:   Wed, 4 Jan 2023 10:18:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 3/7] crash: add generic infrastructure for crash
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
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-4-eric.devolder@oracle.com>
 <Y7U6HsF/vtFOyFmF@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y7U6HsF/vtFOyFmF@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8c29b9-9541-4839-0e54-08daee6f5f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHopYjnmnQkNONKdaFMTbncpJShe3ClhICGHmsil/IpACtIoB3KSN/vBZzmodEoJcHShkbNtd+xwZtZp3IzTT8S42eIOgKv87LCfOX1FEMV7dNn4XF/A9gbiELB7wzvzHYRQ0RyVMHVmwcJXC4PQpvksKf8gioGuEw1Z4SrMdAoM+LUu5Znj+PqA7JfslMvvykI1KWxz/6/HHG1rv8FLfoVuPJ8pKAFrrwaOpI2b6f8q9Av8QA96ZML2PPEQOQHJxHXrS722l9K81Bt4pWrg6hJCRTm4hixO0hwu+CcXe6D+lJmfs6N3pmU4poTne4GtKdU0yJ4TLrtJk4wZCf89ZDZlulxn4ynCnDQNMlOovPb6xQch+BLknRVmOcuo58SInKVKvhc2MnggZTBxvrKFQo0oH6N4jxO7sOL6FUpeaY2lyzZw0qjlFtMipLZgv4bCd98iftMacHrGFXmgUbCLJ3gBlBWCOkNfmiKb4UswWRBQs7Tb8eMqd3JvAWYXBSH/qOYjJhgGrMWG1XntxJX2LE+YJAQDFJzwPKYi6AbnW9sZwMeWem1w5JMomBJPz6D1pdlc60HCE+C350qM9KUM/hxCmUX2AbOuo5+2ZjEF2ceE+HnWcMxkToAHf4fF41cKX0GlSEsFregPlz4U5CDOcPAri3Ka8LZ+IgdPI8ZR/+4cdcaPcwC1ks5obUMk43TR1kUWwK3VDy9ISVW6IEixZ7/GAZ5dV8+BnQk/C8Bu2lpAUAylKX09OPQqX6CLovbJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(41300700001)(8936002)(66946007)(5660300002)(8676002)(7416002)(316002)(2906002)(6916009)(66556008)(31686004)(4326008)(53546011)(6486002)(6506007)(107886003)(6666004)(478600001)(66476007)(2616005)(86362001)(31696002)(83380400001)(186003)(6512007)(38100700002)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JueFpsZWhFVExwQVZvR2hGQkZxRkNUdjRNWnNndjBNRFUwVlgrUjdTZE44?=
 =?utf-8?B?aHVsSUhReWc1cDFMQkN6WlZ6QUFzOWNIenoxQVJ4cm5DRUdkVXVrSUV4QjJp?=
 =?utf-8?B?V0hxUDFJdkpvS1JVMERUdXdzKytnOHFtYlRuSEJ5cVUrVjVwd2Q0bTgyMWFo?=
 =?utf-8?B?VTQvZDFXL3AvZUNnSTQ5MyswdGpRTHRIZ1RzSFVEQ3dhakJVQnpyMUlVOG5u?=
 =?utf-8?B?elRQK0VFY0dwaThodjNFNmc4cldXME1iUDhkUTN3dndPUEw5bmR4RGxITUhl?=
 =?utf-8?B?b2QrTWxIYTVzNFJFMFVvZGNQS0xjbGFrNG5LZnVMdWpGN2ZMcnpxcjhuU09p?=
 =?utf-8?B?dWhmSnRGZU1RNWVpNkJaNmRrSFgrSGl1akZrQVByamhqMVAxTVpFOUZUT3ZS?=
 =?utf-8?B?TUNyMDhqSWRENkdqYTdvMUVlbmxOVkx0MHRjbkRmRHcxR05Gc3Nwb2U3eWcr?=
 =?utf-8?B?eWl5QzhGM3FEcDU4Z1NIbnU4Qi9iSzdQZzc1WGhzWGlUdjZ5clIzRUVpVzRr?=
 =?utf-8?B?b2JkYmFJbXVsSWNmQlMzM0ppOFM4bFdFZ01zQVlJWkhycEUwcnltSlhoQlV3?=
 =?utf-8?B?RjZTamVHSmpRcGdpYzJmQ3FXcW1HdHAvNXY3SzVYYXZBNE03NnJMVTdyQTdM?=
 =?utf-8?B?a2xwRmlZczFkV1FPV2xpMllNTnZ1TkxuUHJPTUZMK2MrV3pmTzMyL0srczRX?=
 =?utf-8?B?bFBIMVVnU0N2VDN2ZTkwMXVBUVQ4dklob3kvcGM0S25RcmRXb3pZRGlCYWda?=
 =?utf-8?B?LzlBRlNsV20yQjh1cTNjNU9qOEkwVUcyN1hORVNsWHZITCttcTVYVnU2Vzdn?=
 =?utf-8?B?T2h2K2lVczh0eTY2NEtCcjZiTGdHUGFTWVorYllXRDhLMldPdU4vbkk2elRm?=
 =?utf-8?B?blVvR2RrY3lpYmRSdXhnN2NVUnVKeE5xTWUraHZkblFqaTc2aWVwcmYvOE1J?=
 =?utf-8?B?V0tLOW9KVHZyUnlmR0xjMTB2QTYwQmRsVFM5MEZnNnJIZ3ZkRzR2cUF6dFpw?=
 =?utf-8?B?dDNDMGVkNDVkajk5Y1ZFdSt3SFJKYnJBVE9mTjVkSmQyTU9ZZzY1Rk11dVJD?=
 =?utf-8?B?aVhzYjl1U2RmVFNtUDRkcTlCUjhXaTFWeGNhS1hnOVBJRUZFS2dQaHBVTE9Y?=
 =?utf-8?B?bFEvclRVMzlueE1SSzZleHNDZ2tSRlRFb3FEYTBEUnA0Y1A5bFZ3V2xUemV3?=
 =?utf-8?B?VEpPNm9UWFdJR29ZWU9KK0pyRHhjVXI3RXMxa29acVBRemdJTWNNWXNYVXZo?=
 =?utf-8?B?aVNqZXZ1ZURVM0xsZzBJdXBpelEreTFmUmF6SC9tenVxbHI1d3ZRVjNSMktV?=
 =?utf-8?B?RTRPWm1rb2tramRVQ3o0YkJkSnhVZVkyeWpHeUZ3QWpqRkN0RUxVZkp1UlFx?=
 =?utf-8?B?MUtOWVNoV3lLazVacWtmaHFJZlFPTU10cnZhU0ZDcHhPQmlIWHEwQlY5L1dT?=
 =?utf-8?B?aHk3RVArQXl4bU5DR3VUVVdKaHdNazM5dy9lWUp4UTl3K1V0YUhDek5RT3Bx?=
 =?utf-8?B?S2VSS242bVhBVGxuNEcveUhlVEtYVmZFMHdVcU9PNUJadDlRclNKRzVUbDZ2?=
 =?utf-8?B?NEN3L2V6bFc2OENZbGM5c3Z0STZoUGpoenJvUFNQeGtONVRNTEdQYkl5cWpr?=
 =?utf-8?B?bXpwckJFQ3NpLzZ6THVqd0ZUc2lhVXFCU0FlTVpydnYxc09RTWNRSFpKZW5N?=
 =?utf-8?B?NUJtcG1ycTk3L1NRVHl2VWFxRFRsaFlhekJZNnM4blltMWt4eGNlQVBXL3lE?=
 =?utf-8?B?KzVRa1Nkc29OeFFSZVczZVRiNnB3YXpISlU1M3ZlamgzZERTOE51MzJBZ2Uv?=
 =?utf-8?B?Y3crbUx4Qmx3S0RkbnA3TlE0SGlXUVNWWGxPNWNzSEtOcHc5NTN0YVlvT0Zj?=
 =?utf-8?B?NG1ZWGJUQnNlT3BaY1BMYzI3L2UwSFZ3M3RqcXBxeW9tYXE0Z3B4bGlia205?=
 =?utf-8?B?YVpHQjJncFBPbW1BNGNhb0E3ekxQQzlNckV1YlViZEFXQ1NqSEtJMmlsb0dC?=
 =?utf-8?B?clUvdjBiV29tUCtOeWhPSFB5NnJBdE95MWFjbERLdWV1OVd6dmg1NjEvdHlB?=
 =?utf-8?B?c0JzTyt0VU91T09qRFl2QWxFcjVnWmZGczJZczdLbXR3S1FYc2swNXFKcTYz?=
 =?utf-8?B?d3JZZTBvaGY0VE5EakJ0U3owN3NpZW54aTBOa3hBQWI1RnBPa3I1MDFvNWoy?=
 =?utf-8?Q?MyLiqBTUhsHy/d3IS/nQYyg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZkJhdHhwWVlVOVVzNTdJQ1luYTNRM2YrSGJuUGNWdlQ4MlVVZjJVV1B0dkNx?=
 =?utf-8?B?NlluZU5wNllNSVJ3Vk9xZEx0NEp4dnFZdWNQZmduQTkxdHhEZVluZi9rdTBU?=
 =?utf-8?B?NjJKVkRQNzh4MHd0S1MzNkptNkE1TFQyTE15VkdOL1A5dVc3QVVPYThOeFVX?=
 =?utf-8?B?eFY5ck5ib1UrNXhwYXlFZnJHSlRGMlNUMFRMa2dOZm40QjlkeDdUNHRnM2dh?=
 =?utf-8?B?WWhPak01L1ZqeXB6bi9PY3orZDhqQ2lPVWs2QzR4RHRQV2k4UTQwc0FycDUw?=
 =?utf-8?B?dkpVbXo0OHpzM3RKdUg4SmJOM1ovc3VkM21yRmVhdE9GM05uRWJwQ3FOMWph?=
 =?utf-8?B?VTF5K09KMmYxL0doU3V6RzN0aTV0OXA0Z3NKZ1RWQ0VMNExLaUdUVHZWdW92?=
 =?utf-8?B?WjkwRGlhR0tQSlhIbGJiWkdPYU1WNzE0a2YyTVd3Wi9JTUJXNXMwL0ZFeW51?=
 =?utf-8?B?ZWlaNGRwV3NNVkptZ2V6emUxNXQ3bEVONGdwMm1WMTJ5M25SUXFiNjJxaGZK?=
 =?utf-8?B?cFdQZXk3SzZkcWZBcVpCSUpYTytQOGkxVjFsaGFOdUlYU3R5cllRVEUwY3B6?=
 =?utf-8?B?M1hmVGN5dGhWVTNaTjkrVlF0OFY0U2FRVytGMko3RTlScUszUTdjeVc1aWp0?=
 =?utf-8?B?RVYxaUZaV2dqc0FvWnU5M1JlQzNmbEltaWVQMjBpWnRqSHQ0MC94R2VybkVD?=
 =?utf-8?B?YWpJSzhUa05acmhLeHR1a1F1a3V3ZEN5bTY2S3g4cEMvcEQwZDNWeTNHb0xS?=
 =?utf-8?B?RjhBRmlLVnE5ZitDa0tJOUhGcEtQcjJtdUNkNjYxSGpnSFFSNWpERTJwYlNz?=
 =?utf-8?B?dUxCUk5Ec3BGanUrdi9NS0Z5RUxFbHRLaEV3NHVMMXRsT3RaZS9HNkF2a2pI?=
 =?utf-8?B?ODYvRDJxWUlOOGNYejdxQmpJOC95S3cvWGpFQ0Fma1hVRUY4Tm1uSjEwT0cr?=
 =?utf-8?B?NnFIV2JobjRNYU1GYnAyZkZtQTVCSWJJb1h2ZlZSTk0zcXlVQ1hLS2FIV3RL?=
 =?utf-8?B?cmJwSGxCckxMWW5xQ2hhdUo5eFg2SnVUZ1h2cjA5aVNoWXhPc3J4Zm9RM3g3?=
 =?utf-8?B?TjJOd1NuTnVJNGFGN1l4WUU0V1F3aHo1SS9CbHZqb3ZEb2p0bEVRRVFjTHdB?=
 =?utf-8?B?bVdsVVJvZmM4cEJGTGZvek03WW0zenMvck9VSWRwWUU4U05SdWk0M29zaHRC?=
 =?utf-8?B?ajlQaWt2U0wreUtDOTY5RDZNWkkzNDhQeVJybkhyTVg5VlN2R3F6Z2JTSzV6?=
 =?utf-8?B?RHNjMEJlTHY5UGNLajRlK1lXMlZwUnZSUHJlKzduM0V2ZU9PRnR1RnFwQmNQ?=
 =?utf-8?B?N0l5S05nL080eXlFQTVNelFBQ0xHN2M4eHRobkJTT0FWN3luUEZOLzN3eVNT?=
 =?utf-8?B?d0p0N0Y3V2xKTTNUSVg4cUZXOGRadHpvS1h5ckYyU3duWEN4RjR6ejVCeW91?=
 =?utf-8?B?S0Z2SlZMRlVlU0luaGVVTkR4NTNUTFVWeHB1emdBZ2puY01IRFdTUEk0aGdn?=
 =?utf-8?B?MkJxTFk1cEVINXdkZXV6VWJZU2FiUGhVV0xXVnRIRGtQQUpzZDdWTmh4eng1?=
 =?utf-8?B?QmhIblBicVI5YVdXY05yWVhudTM3OHlHSTdNWkR1ejlyUFFCNi8xdlptSy84?=
 =?utf-8?B?SnNIWm02TkhTMEJja1RGNjl5RUNiUDQ0MElmS2doaHFJU29JT0FJbmhxN3hn?=
 =?utf-8?B?S09OeHRob3Q1eHptWWJ6c2xtc25oRkQ2Sm5PMlEvbDdLaEFCaW1PQkxvMGNh?=
 =?utf-8?B?Nk8vQjBXMy9iOVh2dUwreWlvd0F5Y2pBZFFQWWJ3TEJMbmdzWW5kSGJJclNE?=
 =?utf-8?B?UDJ6VFVQaHdNdmhyUTBZUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8c29b9-9541-4839-0e54-08daee6f5f62
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:18:53.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INvicvwMmBMY2qp7EbAM8PkIwTBf7iaG4KbdDbjCwBWtwwy168ReuWJAZ+uoaxOYPyRyjfJdvMO+ei8eAHl336J1aclj3GQky7lAbey4Qt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040136
X-Proofpoint-ORIG-GUID: 1oee5eA7ZXAzZZBrkxG7tfGyViQeTOtx
X-Proofpoint-GUID: 1oee5eA7ZXAzZZBrkxG7tfGyViQeTOtx
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 02:34, Baoquan He wrote:
> On 12/09/22 at 10:36am, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event(). During the
>> process, the kexec_lock is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> This looks good to me, thx.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
Thank you!
eric

> 
>> ---
>>   include/linux/crash_core.h |   8 +++
>>   include/linux/kexec.h      |  12 ++++
>>   kernel/crash_core.c        | 138 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 158 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..a270f8660538 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>   		unsigned long long *crash_size, unsigned long long *crash_base);
>>   
>> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
>> +#define KEXEC_CRASH_HP_ADD_CPU			1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY		2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
>> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index ebf46c3b8f8b..389444cb03cc 100644
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
>> +	bool hotplug_event;
>> +	unsigned int offlinecpu;
>> +	bool elfcorehdr_index_valid;
>> +	int elfcorehdr_index;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>   	/* Virtual address of IMA measurement buffer for kexec syscall */
>>   	void *ima_buffer;
>> @@ -503,6 +511,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>>   
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>> +#endif
>> +
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 8c648fd5897a..fcb642a03d7b 100644
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
>> @@ -612,3 +615,138 @@ static int __init crash_save_vmcoreinfo_init(void)
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
>> +				unsigned long mem;
>> +				unsigned char *ptr;
>> +				unsigned int n;
>> +
>> +				for (n = 0; n < image->nr_segments; n++) {
>> +					mem = image->segment[n].mem;
>> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +					if (ptr) {
>> +						/* The segment containing elfcorehdr */
>> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +							image->elfcorehdr_index = (int)n;
>> +							image->elfcorehdr_index_valid = true;
>> +						}
>> +						kunmap_local(ptr);
>> +					}
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
