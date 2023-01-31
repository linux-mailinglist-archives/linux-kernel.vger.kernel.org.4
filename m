Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC672683A76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjAaX0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAaX0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:26:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F6367C7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:26:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiPp9004272;
        Tue, 31 Jan 2023 23:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kkUrjw3sL6pZL8YRAXsAxfm9pYxGNc+cKBhAbOAMSBo=;
 b=Rnu5wXtbx0cT7Z+CSY5/P61GACXVQZxciZcUfsz3o+Nom6AQD5H1N4sPN19G0mSE6GTA
 nuM4ePNhZ0Wq2JhIJmxf9+0Ot3RKDIkBtYkl6UlBZRoLnktJhebkmy+RZGXsaB+9SdHj
 aAxtn9ZVqNYWuIcWlE0h8VqqbiUzPB7lzp6Jc6H43P9+VerbYQVi25gGIKBrGywyLWt9
 ppC7x+rzGdWNBGuxlBa6fqTig2eaIAEorS6W1DND/BSkQIGvi6XzFVmQVuW026ClFCzx
 rgrZG7xHizP7zsBzMkduJv/xT4LM0P/5gfv8SpCcN7HDOrDAjPrnlrikVSy41tGx25SC sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhq0p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:25:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VN30EL012959;
        Tue, 31 Jan 2023 23:25:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d98ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMF8MCIy/u/itqCEr6YrG7niouIsf+vaVZP7CnXFmEzq3k2DtVv5K7GP9rJV8iAhQAJMByQDUXHQnpqAkczMX9r+e5IWrEqfDjzsy6ClFfzMkGrbykJ6XNjl7rclX99oF8DF0IfLsGkRiVLYgayc17SfxyGHxeegzh7VizWt8ccZlzgzuzmwiOiP/ihYHQxI0w20k0myxX01Ssr4NgQ5ilWQ6GrXXozVl1OurVAcErNO6Uub26VXjpljJriCRL+T9XcLfr19VUaocZxhCr3MZKnHewfwTfs1DrSbNKVMiZXC3Et2jn5Nrf3Ns5L2nDS1MCKM36m7KFuTDP695zhdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkUrjw3sL6pZL8YRAXsAxfm9pYxGNc+cKBhAbOAMSBo=;
 b=Jr3769/qcnxdK2ChYskCeDgp7jEgEhEdyQTZ0qygCM7hLQt4oAEpo+tyHmImTn/WmGRW6UpSSzcfK1AEmt7eZYBKckgpYgf96xnw2/qXResn1Ah6kgZy/tJBoH1f8cRTcYqowatEtRRYOcYW9c10sMNdVvHaCW1zHA9Q9dlXjwtvgjhdpQYKIS++/TuiscLZfq1teWfiISFauaNe5Skgc3w6FYj8/geg4x81FfWB3ROVqU5PpruwVf9FWYJKZyzfju92wlWwwYbgJ6SLc02aLb1PT6iA+q6AWo3UH/fHYx9uaXPryMIIVuDxKn2s6c+jORsKxDyfn5DH7Lsf8kiXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkUrjw3sL6pZL8YRAXsAxfm9pYxGNc+cKBhAbOAMSBo=;
 b=uilhLJY9dMW3IeLC/Fg1YeKcNoR6e41RG6jN+iriPnfrKNDtf1nRimZI8iP1fGItonfO9Im7Dn+8sLbMvbTU0npo803USV82T6vHczw/IO5xLoBL0hxWSY6PtbTcfPWOvSUXVZemr4R+ZC6wFSJyXNoeQkfOajg+/qYl4EPrg0M=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 23:25:48 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%7]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 23:25:48 +0000
Message-ID: <2119e210-a272-6ef9-c364-8c8cd9f28d5e@oracle.com>
Date:   Tue, 31 Jan 2023 15:25:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/6] features provisioning fixes and mlx5_vdpa support
Content-Language: en-US
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0150.namprd02.prod.outlook.com
 (2603:10b6:5:332::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe16f97-59b4-44fe-2302-08db03e27c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li1EdU5KYcBxeaJOdtitOnWISL/Nw4mOhG8Jtwd3oWvNXy6pOwS/K4gjmEKmspwjrSgx3WERAJ2/opyd4OgfasIN93aq1iFxHFz0uTkLNoVe753gM1Yp4b1wx51kiYF0SlfZe9WMIgOe6n07+KjAfRj+fYA9j6G3DRfae/LULTzKPht6zh33s4KgstIPJEmeD35sCvHig6p7iBoeES4HITOzCcM60Dl/lO91tCtgfV+B/0oRBlVCJGO367qzJUdMDfp1r/+y605AKxJORqWfj3uQRvLDmE/Pzs/2F6jz2T7IZu2pe89TVtvzKOBTP8G2bAr51eelTCqeSYbII62CH20sBJXa3jwZSwUynwubkKA139yyYi8LrGlGL5sckmfqUkZSCdVYgElBZmg5KZNnf5DPH3hKVW3uHbaEN60u91Bs0GV5TQWle7xXsOKcNf4+OHhtMeFdAaMg9PIDLT7yyO9qM9s0GvnMdYPMx4vOqB9IsW7JadRE2HmFCtxixw7Shqhc+atemyHLcsuzXxtdDB/rOKsSFCZkQr+vEQDSxGBzwdzz7aqug1PoKofFEj5RJKAjfwgqtdP/z4eYcvPBRgdVWa4UTmD0AdoCToeRdkUNmOs6l1i9+a5CbJimxbvfFA7SnAnR1fOK+ljpt7JBj83ALfWpPl3h4vlh1KTelOVUpZeF6YP6WKXC6hAi3inUmb+lFFrFPrUCpR5GyPaepAP6Nm5p8VlZtpJNZhMXBTsQbaSvOgYOEZS1afKoItkGjstMFaeT2aVppfVAVqGLz9e8JMyiNREmzoELfYFpLXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(366004)(39860400002)(84040400005)(451199018)(36756003)(478600001)(8676002)(4326008)(38100700002)(83380400001)(66946007)(66556008)(66476007)(316002)(6512007)(186003)(5660300002)(26005)(966005)(6486002)(36916002)(6666004)(41300700001)(86362001)(2616005)(6506007)(53546011)(31696002)(31686004)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNZLzV0bXI4TUdqbmhEVHJxR3J4c2x2eXNPZXd2dDh6VVBCWHBqY2F2VGta?=
 =?utf-8?B?UzZsblRtUEZuZkhYcUZ1Slc2MWJtNUdObnpUSjNuNUprK1pEUm1hL0Zqa3dQ?=
 =?utf-8?B?SGFqOEpBeGdxVFc1L2ZBUDhlY21IV0Jkb1RubkpTZnNYeUo5NXV3bllIZzBX?=
 =?utf-8?B?TkNCNExYdk5zTkF1TDFXL0Z3cXFpaFZSK3ZUU2RXOWZUMXh4WFNTRDNOcHFm?=
 =?utf-8?B?NmMvM2F6RjRVcXVaRnpneXpGczZ3dHdZS3huSDVIMUhLSE14ckZrZHZobEFm?=
 =?utf-8?B?aWZrdHZKMXgzSnRHK3dRTU8xV0lBbDJVS0xwRk12WmZ4eitMK1owblAreTZ5?=
 =?utf-8?B?N1lySXkyQmV2NWlaL1dHR25LWFQ2YW5TMVQ1enBId0c1U2FSUm1iMGJXaGRX?=
 =?utf-8?B?ZjQ4c05wNDlGQUNCTnRDdVBNcEJNbjNsVUE5NHJKUE9NdzVERndhZ3M1VU01?=
 =?utf-8?B?eGxEd2xXdXpubXZmb0l0TmhZOElzakRQZlpKUG4yWmdsQXNSWm8wUnh6OVIx?=
 =?utf-8?B?Z05MRnp6WjR2U2NWM21MM1QwaHR4Vm9EczF4L2VwS2o3YzZTSWZNSkNUbGFE?=
 =?utf-8?B?L1dZSTJUeUZaT0k0Z0k0R203ZjVVcU9qYlp5Sm52SDhBdGpMb0dTZjFyalFu?=
 =?utf-8?B?THNVaS9wMTI0aURrSDNtVWMrVkMrTExGbng1OG1SdzNhSm4vSG5QV3RzdHJY?=
 =?utf-8?B?N2laMU9BaVdheGtLaTJ2NnRTdjFGZGROZitEUVo0TTAvZEtwYnNScEFuQ3dO?=
 =?utf-8?B?cTRTT1RxckJ1ZmhwM3J6U1l3V1h3Qlo2Ris4L0cxQTl6K2pmRzZ6VFdPYzZK?=
 =?utf-8?B?aDI2cWlNT0RSYyt3SVR1T3lRZlkzV0htMS81YUU5dm1hQ3pIMzZaWGVkdUk0?=
 =?utf-8?B?Q2JkMS9rWVdDdjZIWVRFSCs0eGpjT0N0SkIrUW9FalFRc29pL3BtcDZGZ0Yy?=
 =?utf-8?B?MlBCNDc5UThxUVcwUHFvampVdS9yMW85WGcrb2Nxd0JheVYwTnFwTTVkdnJs?=
 =?utf-8?B?UTF2YmVXRld3US9MUGEvSGNEd1VSdnlZZDYrUWVIWXpXOC9IRDMwVVl6cVVB?=
 =?utf-8?B?a2kwSFFGMWEzQWgzWm5kNzlCbkkvVFhwWkFMMzhqSDdwd1RPbGc5ajNhbVVG?=
 =?utf-8?B?cm10L1liY1JwWkxWRk9wSTV4MEt4aUFYUDZaRWpNM1drZXVtUzh4cEp0VEQ3?=
 =?utf-8?B?UlB5OXN0aWRvNkRmWm1XZDIvYzRVQm5TMmR3cm00WkZaR3BadTE2M1c2MU1a?=
 =?utf-8?B?Zm9vTHhHVlhiN05kZVhlQzZQZHFka0lBa1BYZFZLaEpkQkJjYzZuQ2xyZnJn?=
 =?utf-8?B?THc3Qk9Edzd2ZGtlSHBaYjB6ckVOdkZIZW02WlZUcHVtQ2l2NjBxQ2lTVlF0?=
 =?utf-8?B?aXFDVDYycktwcldTZlYyMVEvVGdsWkZjRXRWUDk0cnA2SVA0U2tWbEhiTndW?=
 =?utf-8?B?cTVzS0dsUFlOamd3eGtvZ0lxOG5POW11dXczZkloODlpK3ozb2dPVXVqbWdR?=
 =?utf-8?B?Sk82c1o1NE1vdEIyUWxIRjRLZVBoaWoyc2Z6LzZGTlRyS0diQXFiQUo1SVhV?=
 =?utf-8?B?STQyUi9IUTFsOWRWTytaK1AxenI0d0ZjTTN5M1BFakRnYk0xcE10WGwrSnU0?=
 =?utf-8?B?ZlFXUDNCbmZNbE5meHVMRWR2ZTVUb3BsdnpWckNUTWhubVJ6ZEpBOGt0Z1U5?=
 =?utf-8?B?cWtkNEthbzFlRjV5ek5rWjRWVjZJeTVkRUpJVmdCby9OMnNCeFp0NERjbkpV?=
 =?utf-8?B?dWJVTWwwa2RjWExaN0hSU0NuSXZ4a090REVZU0FqKzh4NFBUaHJ5UVlPdjFU?=
 =?utf-8?B?WGJ1azFxazUza290c2ptcTNRSWF1ME1XQ0JnOGFPdEQ2R2NzYWZMR3J6b0Zx?=
 =?utf-8?B?dHpYZi9ZTlNJWUtKYWk5bWoyTmdLWnhCOUpPZGkwWnF0ckQwZTVnSXdieUlD?=
 =?utf-8?B?NHNORmlFUHI5am9EWTdCek5KNElFVHhrc1B4NDNwMmtkN3ZkeGRRcEZaSHBl?=
 =?utf-8?B?bkJXUWNRMXRXNDlKQTdqUFAwM0U1MUllb3hvTGRMRUV2QlJYV0JFLzM0QUJU?=
 =?utf-8?B?N2dLaTNaYlAxays3emtyeWxRcnZsRUZBUjdJeHVsL2g5TS8wZkYvTkxDZTA0?=
 =?utf-8?Q?BSBCsXmWQ+mOMewUILk3YHRvB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: deyS1dsqpVTdMBKs8roFgaBvmeuKAihIgRadE9+XhVziNtglNuFOM5KvjlcxuJZU/Q7EotPybnMKURo0ZrsOLt91q42Yqy+E92mYJl2HGDI3ZTK/DJg3l8KSajEseYF3CjzMdG0NDnZ76Vqs5hrnZtJYDHHDbnmF+AYSU2f4WtyjeXSarLPoc5e511LQPsvrCPrCrU4iGxeTalYjZAY9Bx4jQg57FdRF5hplPyycD5Xq4BvgpPnB2bZiSxaNmaT8AgR9VNcaLe5Fwsp6fShhf9H/fglZTz0CaSXHsudMm/MMh2o0Zfozw8MGnP8B+/TqZOacM8cXR7BQQJ+KaQYLCcDCEh4t4QBRlWdyIVgVXF7KsOlpknBCUJnGHPlZgmqSvuJZ7rALpeE9Dx7FjugHgMT5bEWois4YcNppXeHEkdP5pNXQPiv4v67i7YvHLfc4EI4eoNnYEw9qQ4tJUe8xPCvU7lL80P9hidOcUO+xUM4+q0PgUAAETeDzsGQEFoRo+O6rT3AQ8JoiBDjFvrxHqP6E04Qg/9Vd48HgN9EsbWSaysA5D6nhhdMXWgP8lvDgQo43uKQ00OAMXoBaR8iPhryAAUBn1rYJSDrvaVp5Hk0ZTy+iz/A/+InVQ7quwDXjeZZ7i7CQ8WqXZsPA1S6fnm1mo2mJDqylezdw9cjM0xVdNZevUZGrpfOS2UdH+YEvGyN+SQq0yQI/KzhYBeVYLVFYFn/8bbkCQQD6R0EDBPHwz5AsPNP3TG+VkhTGTHwAJ0bh+tjqaG9q8uW2SnMDJL/dLDCpgko1Cr3nByB/sBjzTnHyMou46vgS72df4c4W63+PgcZ/28/HsMrPO2oWmqb4scn6YxHMwJfYAMq6DA/kLnP+uMXbLG40Od0t5+YWj/RkFzQ7fZqb+CbbFz8lNA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe16f97-59b4-44fe-2302-08db03e27c18
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 23:25:48.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jmfecsJHE2inV4Qu54fRGl9aTyjQzg3OBpYPr6NbjSBIYktdzsV+1cw+ThlEpKXJqheSMxB9jS2jCT7XuJjWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310202
X-Proofpoint-ORIG-GUID: PmEkaM3OjHeGNh-9un7Rx-EVbygKbRW_
X-Proofpoint-GUID: PmEkaM3OjHeGNh-9un7Rx-EVbygKbRW_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this series for v1, please refer to the v2 at:

Message-ID: 1675207345-22328-1-git-send-email-si-wei.liu@oracle.com

Apologies I accidentally got v1 resent at the same time when v2 was sent.

-Siwei

On 1/31/2023 3:22 PM, Si-Wei Liu wrote:
> You are currently receiving this informational message with the original email attached. We need your help in notifying the team or sender responsible for this mail flow to ensure future email is delivered properly.
>
> The host that sent this message is not compliant with Oracle's email security policy (DMARC). Please notify the person(s) responsible for this message and share the content below so they can take actions to resolve their issue.
>
> If you have no idea who is responsible, then please address the #ww-oracle-dmarc slack channel for assistance.
>
> Deadlines
> 	• We plan to move to quarantine non-compliant messages early 2023 (date to be determined).  After this date, if the issues are not fixed, messages will be held in a folder on our email gateway and will not be delivered to you.
> 	• We will then move to reject early 2023 (date to be determined).  After this date, messages will be rejected.
>
> For more technical resources and information, see:
> https://confluence.oci.oraclecorp.com/display/EMAIL/DMARC+for+Oracle+IT+and+Email+Delivery+Frequently+Asked+Questions
> https://confluence.oraclecorp.com/confluence/display/OITGLOBAL/DMARC+Global+FAQ
>
> Thank you in advance for your attention to this matter.
>
> ----------------------------------------------------------------------
> This patchset is pre-requisite to export and provision device
> config attributes and features for vdpa live migration, in a way
> backward and forward compatibility can be retained. The follow up
> work [1] will need to be built around the new feature provisioning
> uAPI, with which it's easier to formalize migration compatibility
> support at the driver level.
>
> Thanks,
> -Siwei
>
> [1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
> https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/
>
> ---
>
> Si-Wei Liu (6):
>    vdpa: fix improper error message when adding vdpa dev
>    vdpa: conditionally read STATUS in config space
>    vdpa: validate provisioned device features against specified attribute
>    virtio: VIRTIO_DEVICE_F_MASK for all per-device features
>    vdpa: validate device feature provisioning against supported class
>    vdpa/mlx5: support device features provisioning
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 72 ++++++++++++++++++++++------
>   drivers/vdpa/vdpa.c                | 98 ++++++++++++++++++++++++++++++++------
>   include/uapi/linux/virtio_config.h |  8 ++++
>   3 files changed, 149 insertions(+), 29 deletions(-)
>

