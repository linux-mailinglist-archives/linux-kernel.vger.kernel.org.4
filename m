Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8962A064
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKORa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKORaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:30:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1049FFD;
        Tue, 15 Nov 2022 09:30:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFHSObL016540;
        Tue, 15 Nov 2022 17:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7nY0wHlPEAZjge4863R9UUDbYH/6V1oGT2Vijp/SqO8=;
 b=iQnpZKH9pjSGJIeyN2/aR5A2NjwugttZPAWIIdtghm8szMjddeBTvrOj2QwNhBAJgsBs
 ZBtQDmJXYzi2lrkGSg5EQFUvZfQXeiuI388tGS3EzzxewP3V6Nu+EgvnxUdbqls84UlM
 5BmQB+1PYV6KXvDvTAitVfp1Yj0C3TE4hFXeFwGoNHqBJQ7IDiQWd0oVF6JE+ktwOWhg
 AOwKRTUdnX0YT4a7kNLnQf5kPKMuvaPI0gSRATQvMZi6XSVpBPUxFJPKfcdPUpDFdiDh
 qAJnt5o2bIeq6bW3TX2xf48fgHlBsGQQkl3rCBv34J3IUDsgle3Pxwoc/stzOqoTOl/L JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykhegw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 17:30:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFH1RLU004839;
        Tue, 15 Nov 2022 17:30:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k6w1eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 17:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCjVPkl6XTqx2jCGE2D05ht5SdOINIdExuGPb/6pNxKrA6kiUHd2OFgePvItLDYPkE2looCtUL/4R19I1vBObiUrRRrOJE6STXDqOVOcxsF0/xHa32f/aOPR0sFzivLWKcie69wczZ3sK0+GB1iv7IrsnT4iU0HwcxjcYxobPoBzaumvwjfWAQIR8Um600Pj/nNQaeBo56wNL7d6Zo7P3BPuKtsKtoGKkdw3ezuxPT8kmmXFh9KGwgOqMdwtypkOX7fIOjiaw8DeXfJmvVkhMcugRDcZI3P/hlVKZEvf/q9vrGTwq7VOVmW+puVIZjtyrz8m6wwhkI0uMau0N6J69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nY0wHlPEAZjge4863R9UUDbYH/6V1oGT2Vijp/SqO8=;
 b=nvBn96fIJgWTlinKtoK1797IvCe/nKsmBzGH8nMeTeAIFwFnL84km0jg9sJQgaJnV32s17ADKspL1U9IDliaZCO6RmWM8kjJNM/fZeNTBmG5mVJ46lUkukILUsQNv1EhwumK8FHO8LtsXSEUDp3zlJsK3GE4+EVu/wwbXoWJF/GybWukXtBfGrxW2rmKn5t45Rj2LHs623qC76OycvYs//ZETq4YvpowDuux3807+s88DPZBpTf3ztfntGb7+wjIu+g7oAsYAi4P5q/gL5VktSkw8IjD0Bgb+7P9FxOCqRp99Rn/aDoyS3VcC6jEm3b6ExIKhoHGdwPIhZbXliV91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nY0wHlPEAZjge4863R9UUDbYH/6V1oGT2Vijp/SqO8=;
 b=K0Sto6+hcd4YwRR9GRSM2IPi21FRg05kJGQXc6rJaMAiDmo8k2aMGmLm873e/LnzDgTOOI7+108czHgAh5XVhAsbECUL/A90NK8BqOA0Swu9K5XlHqagq89uNyfdgN7TaeirVtNNFlTUxftsxGphRz+7m/I4ErJ4fIKbWVM17vQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 17:30:05 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:30:05 +0000
Message-ID: <94a9621d-f526-cd70-64fd-1c519cf1bcf1@oracle.com>
Date:   Tue, 15 Nov 2022 11:30:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cxgb4i : Added pointer check
Content-Language: en-US
To:     Denis Arefev <arefev@swemel.ru>, Karen Xie <kxie@chelsio.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
References: <20221115094629.73591-1-arefev@swemel.ru>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221115094629.73591-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:610:119::15) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|MN2PR10MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: d4402aff-86c9-444e-4628-08dac72f08e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +e2vktObzlvb15q1Rytqee9I50PLGrizIxGjuiJqREyM81s2BgZuT6vwIzHSJcWvU5+CsNrKSV0YTCZX/pSZrcJ2f1B+lpw9SARGLY+/TiuGrUI4Y9bJUSQvenHC12mW/CLJcfDW++M7WKveN9oJ/wX6S4caNLdzPJvtNyEi5JMfSUDdpRAcwnb7Stb15vZQQx9Ihh9/e9vn0FOupAzmO7aD2F86Yf9mhuyg9ikhkZZ8se43sNdvEAIUTlABgjqaDQu/kl8G/goazZl8Wf5lP7KT1Ox+4KSL3Y8KPpr+yD+9iXBV0luQQANFTSgFVcZV/RJmpE7lwb+KbMcfsLPtWR2KOYnQEx8fZac2ehyxg2PytqmHVZ6Ao47jAuuSDw/c3eL/2b3J9NEeWRCsCjF3x36fxZd3xx2MICJoNkzcTVyPBB5/DLve54HtiNAM1TDg9hwitEKvTa8dXy4tthMx8mSHgeVtXc0d+UQLZrmcFQuwChcDo8yNiMP/Mm3tDm0/bATDb2vSGHe11C3OvO9jfeYEuhsZjDULseJvI17VMpC2qyBuw90+wxnIdy/Vg9ifudYkdlOViZtuNpg+bC9OyBkXQuHwF2U1qcqsLx0Dy1s/hNhpQ3/1chvSVIwyPPdvk+5MlTjhHN0EPj9NMLYyvWBv8nqtJJ0zA5pW3wmIdek6YCaXX2j6OkEDce6wPLmD7dnQX4+c8msVx9bRbx7t3lZ3+yR64lgiKAXs3Ja9kxbbPAyv2Mf4xy8DKv0YOxuHfhKEEKxXCb6ehWD/GxGi/LPuD9IMx5CzISPjLc2V5wVEyI/lrkUQcFZhc/YGULgakzBBvPT6MvBONgZbDPEDykXYvxXgmjhZfiTU4pCkVfEHlp+yMb+VWx0EtW1nvdWI3oUxuGrofm4YZvv1aaJkLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(478600001)(54906003)(110136005)(31686004)(6486002)(66556008)(5660300002)(8936002)(36756003)(6506007)(41300700001)(2616005)(4326008)(2906002)(66476007)(316002)(53546011)(26005)(6512007)(8676002)(66946007)(186003)(83380400001)(86362001)(31696002)(38100700002)(42413004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpSSFpOK0V4Z1RqOHZkUjR4azVQVzRUb2Fqb2o0N3NPclVtRVRRR0h2bHBu?=
 =?utf-8?B?MWZRbFlWSWFLTFFpOVZ6cUdGeWNDWGt2OXJFYnEzMk9RZ1hia1Qvd25XVWtT?=
 =?utf-8?B?RElVdE5OSVBhN0l5WGNzc1dZelhCa3lQdXNVSjI0NFRpY25qR3NkSEFMcmVB?=
 =?utf-8?B?RVZubXpneFdCVnp1ank2VG1EcXF5WDhLdlp6ZGZQL3VrenlJaUhRSGZjMFAv?=
 =?utf-8?B?SHVjbktEUmJ6c21NSThQSUJLSHBWZUhzMVFnbTRUbGtXRTM0cUR0NFBibDQ1?=
 =?utf-8?B?ditIV0pZWHpTZkhkK3Z6TkxHb0c2WkI5QWJsMElnOWpLS2VzeHJyTFdWRmYy?=
 =?utf-8?B?QjloVjgvQ2hhL0paYkRpeWhvMzgzWTdBdE8zZWR4eXJWeEtpdGdrb0YvSFNu?=
 =?utf-8?B?T09LK0U0TE9UU0lOZW9pUVBKZkd1RnZIc2IybFhBeWV1YUVjcVE0RXZEbGZ6?=
 =?utf-8?B?anhldUpoRFF5Q2VIb1dUazdwTW9xcGU4cmtXMDdudGNMZm01VmZ2d1BzWGJB?=
 =?utf-8?B?M081Z0Q4YlVhd0dPY28veXRDRjQxY1V1UTFsU2lLeVJ1bHo5Um5oTzdONFJC?=
 =?utf-8?B?R0pSaUI4NHorQ3BtRE8xSnhRSTh2WExxVFN5MGV3d1hDQXBXdE5jU3VWQ0pn?=
 =?utf-8?B?OGRzZ1BjcUpvWVNreEdERklqelRSNFdyM2hZSklxaHA5M3RJUjBaUzNZNlVp?=
 =?utf-8?B?bnVwbUNWclFNdzF3elNUNlV6ZENMRkd3RCtSMHp6c3lFM2JHWXBUMi9oc0Zv?=
 =?utf-8?B?S0MwN1pIZTFaa05QL2p2R3pzbUhBZHpaWjlqd0ViMG4zRTlzWHdCZTVwc3d4?=
 =?utf-8?B?eVRuMnYvdE01dnFLbURsaHFtQmdDVzQ0K2hVMEJBSmlpNlVUZVNtRVNRVzRP?=
 =?utf-8?B?WkdwTmduWm13cXhJa2IybVdPMWlmZm43N2tHL1NNMmV6MzVYaVp3WUVDcy9M?=
 =?utf-8?B?TE9nRFhtZ0RVbnhNcW5nVXJmOUpOMDBiMjd1ZnFqWEUvWXkxTmtpWDBjT28v?=
 =?utf-8?B?QTk3ZHNlc2JrSGlBTW42YmIwU0VvbmdmcWk0U0FsV21sOGVLdk9rYzJpSU00?=
 =?utf-8?B?N0pYUzc4Q1A2TlNtSkdLR3h1QldWdGFGUlh5Y0dnVHZKdnI0RkR4WnN0WXE4?=
 =?utf-8?B?aVV0Z0NRU2lnUVhKbVZnYVNWQnpsd2hBcW0ramtXMU8ycHZTeE1JYU8zWlRK?=
 =?utf-8?B?LzJ5cC9mWHNCbHFCOGRhU2l4U2pqbFIyVGM5TnFLd3k5UUdpa2xNc2lMVlYr?=
 =?utf-8?B?ei9hRktZVlFUWmNTVUdyb3BJRVNMSy9qS0oxRnV2TS9MNlp4ZkhRQnJXelBt?=
 =?utf-8?B?djhNVjhWY3R5cTBNOWE0WHk4blBnZ3pKcEdiQnFGalRQaytYTUVjUFhQbEtS?=
 =?utf-8?B?RHBNdnNZcHcwWVYxckZObGppLyt3ZVZoWDlZUTdvalkxUWxZMUJpYlpveEtS?=
 =?utf-8?B?L1NIdG5WbXpXcU4wNlR1bGNvcGlFOStZN3BSbUxTQ2ZYR3RoV0xMbktDRzRD?=
 =?utf-8?B?SFRrY0QwTFRhK2dWaGt0YXpPeTBNdjNCSzRMVXFtcnphdjQyK250TEViQ2t3?=
 =?utf-8?B?RXErQ1E1SlJ5Um9wZFIwWld1cXovVDF1a2xqbTRocHA0Z0h6b2JFcDBGRmpj?=
 =?utf-8?B?K3RDYzQ0VE4zMXE2bCtOWWsxVnpSQjJjQS9NYnhLUjN4K3lrZi8rY2VvV0d0?=
 =?utf-8?B?VmZHYWQ3aFgxM0gzOXk2SVorbVpkaS9IZ05aNWpYNW1lYUNxRGdBQU5yWnFm?=
 =?utf-8?B?T3FYUVVSbUJUQStlaWhpcGE0SGFZU2tUYjBidUk1QzhjNVZWVTdoRnhVN24x?=
 =?utf-8?B?bndLQTIzc0N6bkNRWGQxOTBEME9LZWlWeDR3b0Z3YVFjTGphSXNNclozc25R?=
 =?utf-8?B?UlN1Vk1RQVRFOFgzSXZPRm10RTJYSmUxZ29hVTNFb0lLR0VYa0xIYnh1cjl0?=
 =?utf-8?B?QlFiTGZkRVI5ZjFLbjhHdXJ6OVJ5cFM2d1ZZRlQvRm55M0RId3NYaFN4TDU1?=
 =?utf-8?B?dVVXZlVhTW1iV1FGVzkyQUc1YzVHS0ZlN1BLam1DTGFnaFdFRXVpaTZ4eHcx?=
 =?utf-8?B?cEYvck9qTGxwTkVleXQ1ZTFWeFVwM3lSeDVTRzFuVnpVRmhVdmxUSVl3R1V3?=
 =?utf-8?B?OC9hMVNacXVDbHpzTEFxeHk2TTB3a0pYVXVicW50WTAzWEhxZUc2UkF6VFJ4?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHlKUzFXU2JSMmVuYWFhZStEK3U4OWh2MEdlOGxaeVlleFFscmRUMThMRUR4?=
 =?utf-8?B?a1I3cWdBZVl4MTMxL29Ob05PRHM3bVFIM0dPNzZieUx3aGFIbXJWSlpsdUV6?=
 =?utf-8?B?S0JUSDJWVTJWdWFwRG5CcXNxd2Q5Um5JRU9pT0ZUMm42OGNDTmV1WWNiYzZz?=
 =?utf-8?B?ZlhtSXo0T2ZpQkxFWXR5dnJtQS9CQWorYzIzbSs5V1ViNUN6QnhVa3RoS0xB?=
 =?utf-8?B?VG52clBEMkM0cFd0dXRPNHRNakd1RW9NSFpoSVIvenNCU2lSbmVZeXpKUXBo?=
 =?utf-8?B?V0IyNjBhZmNuQUlCOUpyM29WRGJvWkVaVnJkYURSc3p1VEVIdjZqcy83VXhq?=
 =?utf-8?B?bnV5RW5Fb0FDcXRscTU5TmhqbzJhL3Y4Q2doaUZwV0l5ajRWcCs3ZHdlOEVQ?=
 =?utf-8?B?bnVxUG43dmxUbmRnYTB2RkRvWkhsamtjNUplTHVtRG81ZkFoT08weFVKYTNk?=
 =?utf-8?B?aUlWdzN4VU1PcVFpT0htSElta2hmTWY2T1gzSzdRZjlPQm14YVZ0WklYdVhM?=
 =?utf-8?B?RVllYmRUYWJtdCtCa1hCVXJSMUNvUUdpdGdmOUJRUDh3SHBMYzdieGRNdk41?=
 =?utf-8?B?ekU2Y21YbUNiaEtQZitsRmQ5SzB6djJGTVVmamZORkNWVTNiV0U4Nk9NQzdV?=
 =?utf-8?B?UGQrL1o1N0ZBZ3l6WWhGMHR4TnFrTVBHL2h4WFVFVmpZeWtteHBEL05NUDJ4?=
 =?utf-8?B?NmZ1WVd5UjdvS1BnS1E3dGpFVzJJZ1FRcFg2cTZyMncycXFlcWNvWndxN3BI?=
 =?utf-8?B?S0ZMUlRQQTB4bFJvOC9KUTFFamRReFJ0NnZvRExHMmRSUlgxV2E0L3NyZlBN?=
 =?utf-8?B?UThJNkhNNHFYTTFHWTNhVFF2QzFpSGt3TEw0NW5YMjhUSEh5WGhneWpQY2VN?=
 =?utf-8?B?SnFzdFNOZHJRSFZ1cFVoVHlueW1sY1d3cWFnekxJc1NSNVVxMHhsTnIrVllp?=
 =?utf-8?B?MC9FQ3Z3bGNEVnREdkEwdllJVTg2dTl1bkFEQXYydGNWR3ZTdDNWWHFla0J3?=
 =?utf-8?B?QnRSQjdSTDJhMThIVFJuZzZjVlNCSS9jNHRsTmhmZDNWekQvUVpiNzFBWCtB?=
 =?utf-8?B?OEdISFBIWjRTU3J4NThmZUxxQ1F5YTEydmFSWEhCN2ZjazdnQkZhb1p0bC82?=
 =?utf-8?B?TUpscXprTGY3UmNIcGN1bjYyUE43MGlSc1BZZGkyRXU0TERjdFdWeWJ4K0NR?=
 =?utf-8?B?Vi8zdHFpMG91aFdHNS8yNXdWLytTUjZPSFNjU2hjN21kVGllN0hJeTJyTGRh?=
 =?utf-8?B?bEl6a3diT2tWa2ltU2k4Ti9OVytoUkNTN0NtWWNidmpXWmxMZVRUTjkzcllZ?=
 =?utf-8?B?c0V2VTV6anJRdSswcnZHZkwxMjQ3Y25HdW5leXJETU5WTDZwUWJWWit2L0xP?=
 =?utf-8?B?TGNWeVlNVlVGckE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4402aff-86c9-444e-4628-08dac72f08e1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:30:05.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfQSOO+h8DHNeqGW/FewMAbc+7KuuOb4TWZGfzfzb8lIjIiVMjN7YrKAOaGtipf0OVhFSRUj84qUYcLxiytQXna2N2egCD98NwFcuepjl/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150118
X-Proofpoint-GUID: rXET04JJRehJRQ3dYxeqn0zpN1E_SVJ9
X-Proofpoint-ORIG-GUID: rXET04JJRehJRQ3dYxeqn0zpN1E_SVJ9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 3:46 AM, Denis Arefev wrote:
> Return value of a function 'alloc_wr' is dereferenced at cxgb4i.c:624
> without checking for null, but it is usually checked for this function
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
> index 2c3491528d42..40ed8e27945c 100644
> --- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
> +++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
> @@ -611,7 +611,7 @@ static inline int tx_flowc_wr_credits(int *nparamsp, int *flowclenp)
>  
>  static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
>  {
> -	struct sk_buff *skb;
> +	struct sk_buff *skb = NULL;

You can drop this part since it's set a little lower when we do the alloc.

>  	struct fw_flowc_wr *flowc;
>  	int nparams, flowclen16, flowclen;
>  
> @@ -620,6 +620,8 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
>  #endif
>  	flowclen16 = tx_flowc_wr_credits(&nparams, &flowclen);
>  	skb = alloc_wr(flowclen, 0, GFP_ATOMIC);
> +	if (!skb)
> +	 return -ENOMEM;

Your tabbing got messed up. Maybe you used a space where you wanted a tab.


>  	flowc = (struct fw_flowc_wr *)skb->head;
>  	flowc->op_to_nparams =
>  		htonl(FW_WR_OP_V(FW_FLOWC_WR) | FW_FLOWC_WR_NPARAMS_V(nparams));

