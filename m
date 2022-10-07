Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C85F7B25
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJGQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:03:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2CFC1DC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:03:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297Eqan7003431;
        Fri, 7 Oct 2022 16:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Jx1SSBrCclrfp4k6ArbkhpRZCSiSFaEy6PrCFHLF604=;
 b=g9n/Nk3ff3k02ypMZOC3W+NF2VRWbFJSbqnjAaqITDez0vst3+tosxNh0AfoseLeUrcb
 ZIppAEYFvhOQW8dNjUVgNfdwt40Q/rIZNZdMXZTzjv2YYXMY4KsXNdo5ZhK02FBSOHJm
 8JNfuwZZmjJPlo91qg+T2KK6vowgJgtDITj2KHlHLu6K2AAt8B2Z4CzZOKzrZhFJk9CY
 YyuZaBYrH9DmlWFawcgx5jE3qNOIvEbySW22wayHJtA6LWey65GOFbxVR6tcbejZRrEl
 H6OBGWywQ5yIQ3CWgjXc792Oa4criPT7KavNUxsGae/tUhawpVtG2Y1apo8i2YyXPFBo pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k15up6ve5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 16:01:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297Db18L000583;
        Fri, 7 Oct 2022 16:01:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc06ydhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 16:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cewVJtbWWdHTdd8AN1ERxsPRoLT6iDc85Lnpify1mUAlGRBRxp4Blyg8FPuG7x7m6z6+psiGifkUJazne8IHZXZOty5iWLwT1/fYKpBUQpBcLvw56FcjVXkM7XaDy2lC/JON4NxBCWcfHKJrhCkucgHlQKiE4qd9uhLbm+SRkT1INYYezUGIN6InVYQyorypvMUNAfQqBnhse75kFFoa5qkeh9p787jOo3bpM19qhDlGuE9Xt8WbNSg0SbPDpcbImITgOhwCqoFVwi67M0ZS9R0CGJDqM7aVL9gxd12Bnb2DLF10hTlmEZ6PK6KIG5Tw/Gf/GKBHuiivM3ufUsIEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx1SSBrCclrfp4k6ArbkhpRZCSiSFaEy6PrCFHLF604=;
 b=OPnv78Y/IQuIigX0mpt1jhs7LfpKuT5B1+MDuvP+794xhAkX09hZgQmwRSgPJISmxn2eDEdDDwsmAubVZepgQG3K9eO2smQe4TXBrlRIOokDLDjUjVzPSwPcbWuv5rQSAPzdRgGzJtb4r8w2Y2hcca0iYaoGWq4ZIN80hogSJK15Dr+jUXNUI2FvcihFDDNf2EligczpYFrtlfYrzFqnPF03RaEpBhLQDnG1QSGZtiz9337cZWo5swgg3dP95ZFjWjPpuSkV+J1hUJPWL2rQr7UAhddLF/clynOmmNNc/HkL+OG5qnKQg4MplDUVt4TvO2T3mb/q2sTgJCrRP/g+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx1SSBrCclrfp4k6ArbkhpRZCSiSFaEy6PrCFHLF604=;
 b=PObYio3J5eLOj8WAVQy+coqVPyoaLJI+I/TRqFxwf0zOewDAWa3CueYxbNsC45f5gem1Ld9h0YtKqlOb2HD2NXQyetThE0SG7e9f04oCJwjLmYzEPEv1XKKx5GRci1K0cjUJAPR5V6qslQHQcMjefz+A7oWSSm7JK8ctDaZrU+Y=
Received: from CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22)
 by SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 16:01:42 +0000
Received: from CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::1aa:5a18:ec58:7c2]) by CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::1aa:5a18:ec58:7c2%3]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 16:01:42 +0000
Message-ID: <79358304-de2e-3025-f147-cba2f76f22d2@oracle.com>
Date:   Fri, 7 Oct 2022 12:01:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/3] xen/virtio: enable grant based virtio on x86
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20221007064143.10049-1-jgross@suse.com>
 <20221007064143.10049-4-jgross@suse.com>
 <67c9ec7d-a67d-ca28-4354-68e38aa27e13@epam.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <67c9ec7d-a67d-ca28-4354-68e38aa27e13@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:806:a7::15) To CH0PR10MB5020.namprd10.prod.outlook.com
 (2603:10b6:610:c0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5020:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9f0bff-3f50-426c-35c5-08daa87d39bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbKhnVGKJi3Lz4raZmo7Npk9tU9joXdNNQv0lMAKEAiU28RZg1Rwm/MCc4XxVOpBLWUPUH+aNmgFA/rawRWGB6hxZjJ2cRgn5v+ZOi85TqNng8JKODACKOf5R1CaphCJxF8tNlh3iZgq9OXeTHJG0tMR0KM+CjY975EtZrWCSqWdikuSv8ac6TTv5BIrJKnbITnwTTjE1N1ob5l1J6ssLuiIoE5cyZEuE7pGEmCg0sOsQxf7uzMn2ttSfYJgwQGAQGgw+SIZEjpVwD0XhTY+Ekj+2q7r29mPAdejLwGf98LGLXnZs64pPbffgE9dp8dHXTCOiGz9KaZs/9MCUqYFo6iXPcst1WrWDdWnKYfAKJoDdSagMFv6rWQwK8bAhKRv9MSZmYgb5Ut29vj+WZfdPmODaoDZmFNB5v5taq8WrnYiN2ghwAWs5pFQNlW1+LdroAj3v34m17EoYyeB4LEO/6a5u3HQLABRCV6dG6ITxmC3WX1GnEuinfuFr/mFSigdbqsC+G6EeYGP62zouo0gpLhhHIrPvAxEB6aJycOm1OabQLCPej4YxJXh8lNEu5kbfu7quZKj2lsr6AE/Z5/GZQ3cveIS+OlK9dzEnMI494/tuNnxUIvas8WBx95NWW5J2RB5kXm11B4px97ahd11C8nSKwIY2GZT4bM+W3aZByhhVuPKlySLXUVTxLKnXMI2MWMuvUOW0k4t3+YrcBqwnLnD2HjF46GTBdXpXshTTqlFyGS5n9P5On3vLEduKMnvQx9pdZJDY0KpYF8bp1vhD539ppxKOHPVAyrJCMSiprE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5020.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(36756003)(2906002)(31696002)(5660300002)(4744005)(44832011)(7416002)(186003)(83380400001)(4326008)(38100700002)(26005)(2616005)(6666004)(6512007)(66946007)(478600001)(6486002)(316002)(8676002)(53546011)(66476007)(86362001)(66556008)(6506007)(54906003)(41300700001)(8936002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW0rRFlRdXpZUi84SzB1ZU9QMGx1WlJSeXJMS2tUMmZ2ODIydFJqMnI1WGJL?=
 =?utf-8?B?d2pnMThaOXZYaUViMEE0ZWZJajB0SHp1cjltZVI4Nzg0L0FtMnZRbXNzeFlE?=
 =?utf-8?B?SFpVcDJZL2t1N3MyUHc5ME5LaWRmVmxOd1hRZnNEeWFtaUVtRmJsUVFKSGFM?=
 =?utf-8?B?MnlKNlJHS2JrREtmQW5jU2JFVml5VHBBZEtzYXVnRTV6NVRXZStCWnQ5NjEw?=
 =?utf-8?B?bzFWU3lPNEpuSWd6VFplbUVPaVo1YkhaVHd2Y0VJVUswNlpLK1VLVkxGS2d4?=
 =?utf-8?B?UFpMMURaNmVZQTNFekhXL2hsYlVLaWNjbHk2SEoxSjdXUUZ0MnN2NHhnZ2oy?=
 =?utf-8?B?UlNRRlU5UGthVWYrbWl1WnNsN3JQU3YzTVN3REZOQkk2eXZpRVp0UWVVNG80?=
 =?utf-8?B?YkNNdGpIU0pOM2ZkTFNRN2dJZEZYVFFvbzQrMFloRzBUUlVScTJzOGxFNTV0?=
 =?utf-8?B?RHdQdVBhdUxDMDhHQ1ZVMHZ4Vy9sbyt2NThuTE1BT3hsSE4wREI0T2pRRzl3?=
 =?utf-8?B?YTVXbGlPUENhT3hUa0JwQzRsOHhFc1VaSU5SeHNFYVRQL2NTT3ZIcCtrSkZh?=
 =?utf-8?B?RmxCb1U2UFJRQm1iQWxxWmpWRVc1RXB2QTB6eFBxSUMvUndSUndaeFgzSlVj?=
 =?utf-8?B?YmxNOVMreW5PZnlJZlI4WjIrd2ZDaU1FN29yY1VFcWdGbHdHUDcrQi9Bc1du?=
 =?utf-8?B?YWdYRzhZQWFxbzZCZjhhT3lFaU84eWFKdzBab2RQNENoOWg0U1FQaG1jSVFP?=
 =?utf-8?B?MHpCdUNqUVZqL0RUUDkweHQvcWJraW94UitaOExYUUxlRHdUdHBuUE9Oam1G?=
 =?utf-8?B?Ym5IdEU5bTNwT3Rtcks4NEl6TFF6cDlSbmhiWFEzTlcvVFVBdHhva2ZLQ0Jm?=
 =?utf-8?B?TjRZa0JFL1dzbGZVaWFZOUhQNXZ0SlRJajhwTWg0LzZNaFBWMTE0dktmMGpM?=
 =?utf-8?B?SkN3Q3J0eW43OEc5dnpweDA4Y0lRTThkNzlBQUNmM3BUVDFTZTdwbHNkSWVp?=
 =?utf-8?B?ZnBQY2poR1VDalBIQ3UvS3NYVWpHdWsramVhL1g3QWQrcnZXc2ZKZDRHRlNj?=
 =?utf-8?B?QXo2dnd4dnFtV0JyL2wvMkZ3eEpabXZ4RlM0VXROMFhMbGRjcEU1dEtLaHZT?=
 =?utf-8?B?NlZKelpaNjE2K2sxZEplZG9jMXRUZmVYZmlrajQvU0ZNNGhkZGszSk55eUx1?=
 =?utf-8?B?OEtndHdEZThXQWpUVkVNenBRbkFCQTkxSHJNNXk1ai84RzlXaFFFR1dkQUl2?=
 =?utf-8?B?SUljRjZhYmVQN1VibEVyREdnc1VabDhpSkJJQ1YrMVg2OXhmRmgrYWs1citH?=
 =?utf-8?B?MnVkb214VE9vY2wzNk9FR2g0NWN2YWdYTFFXanpRdzdGYVJZdGtkQVJGQitT?=
 =?utf-8?B?b0dnOEZyWmF0UVd1akhENngrd1Zya0tkWW9pVWZOcWNLeG10bGdEWit4OHlG?=
 =?utf-8?B?SHFGb280MUJneEJlQm9KVEpPME44RmttMWFGZENOUUNHbWpWbGRDWllIaXhq?=
 =?utf-8?B?dURjOXo0YnZwSFY3NmhZT2JrSm5SaldHUVp5QnBDUVlhL3phdC80RVB2M1pj?=
 =?utf-8?B?TWhCdm95SHNrM0R0MjVkRE43SUQ2T2dkSDBMWm95dml6T1lXVVkxOGpkS0FB?=
 =?utf-8?B?Y0NocTV4amxVNkJPMnFhL3czaXl5NWczTC84QnNYVCtxMUkvSTl0akgvTTRX?=
 =?utf-8?B?U0VxNlh0dlQySzJ4bitneUhRV3JsWnk2Qi9Gd2pDSTJpWjh2cncyYm4xT3J5?=
 =?utf-8?B?M0lUQWd3VHd5MkxUWWljOHkxVHdXK2U0Ykcva0lhc2RBTmZtSlJVWVIrVjl2?=
 =?utf-8?B?TEhwcE5LcG5WWWk0WldsY2hzZnhQSlEvNE1ROWw2cDlXa2w5Z3FyczViVmZK?=
 =?utf-8?B?OElsVE9vb0tXazdlcWNQVC8yZ1pOMkxha01qRHdEYkMyOUxjT21RNXk5bk01?=
 =?utf-8?B?TGRMaVhzMUkxWWg4Y3RMVWYyWnd5cDh1QjYyOFU3S0V0SWM3VWtVVzlFdHZO?=
 =?utf-8?B?Tmx2NitXMERYbjZ2ZzNRWHZkeHV4UFRlWXFxK0swTHlPUjR2M1UreTZkN3FK?=
 =?utf-8?B?cUxxeGdyZ0M4RzBKbm9UM2J4WFpvUTRCNVJPMzJMbFVzR3hldFo4d0FSMXZy?=
 =?utf-8?B?Ukhwcmh5YVlkdVNNZThXY2w3T3lGREVQSkpRczA1VnpJT3NyU1A4eEFiTjN2?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9f0bff-3f50-426c-35c5-08daa87d39bf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5020.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:01:42.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqprQsVq+F2/PmUTr9U14IKYRFFe0fg9Kd6uAvNvbABL9oOJ001Hep2xngBrEiM8BmNNQF+MvWEzCJow68sLbF+OjwYdwbKlfiVjmN2L1DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070096
X-Proofpoint-GUID: 0pNU2b0sWDMhD8X8wifFbKp150WptGju
X-Proofpoint-ORIG-GUID: 0pNU2b0sWDMhD8X8wifFbKp150WptGju
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/22 10:00 AM, Oleksandr Tyshchenko wrote:
> On 07.10.22 09:41, Juergen Gross wrote:
>
> Hello Juergen
>
>> Use an x86-specific virtio_check_mem_acc_cb() for Xen in order to setup
>> the correct DMA ops.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V2:
>> - add missing PV check in xen_virtio_mem_acc() (Oleksandr Tyshchenko)
>> - add xen_virtio_restricted_mem_acc() stub (Oleksandr Tyshchenko)
>
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> #
> common code



Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


