Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2736F70CE24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjEVWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjEVWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:42:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77FF90;
        Mon, 22 May 2023 15:42:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKO0oY010849;
        Mon, 22 May 2023 22:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wVdoK8RdhKUhX7rSxWlfDUeZG/wS+yNSbzeF25LGNYc=;
 b=ZNAledNC32AkVVawmQApLLys51VDgcGLcZkcv6jSmhJN4K20bh5e5nU5j5+W5XTII9tA
 G46oW1+boxcXIhASBR7wnbd2Qr4wXOubAHz+kH10liZzHgmGgC9UCM7aW1L8pPtK5KQ7
 3Y4vf9/9YllF4uFTCRbQT7wm9X6wJ6Fkp1Gz2UiGA+bvdeCt6cInfwc1ieV4OlXVtSyX
 8KBhmpmYrIorRwde4X5X981zhoAHrKVjKqxF0anmDWZvcQTOPBG3z82WIFL+XiYYdtav
 u9pdH4dWAKdYhYwDYa0IjZtONAGYO+quijEmZHw3VY0TG81M2Dl6zA3xvV/QgKtxixzt xA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp7yutnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:42:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLJTGv029085;
        Mon, 22 May 2023 22:42:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2a2bwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:42:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkOMIdECaufFqbhkr8/CsmRQC5n+imAXGayL6aB1hCf5xCzE44SG62hIprzyVJomsrczJOHnROJuEr5Rku+4JNafKy07WnbGtL9TMsIfTJhjPtHT2Z0nD5X/JlZj2TzZK7IFZeeQfu2vRfDY7U6DINOv4iQxWQ94zBejw9oTNzUIpApv5QtiQzy7emPXxJoNNN5HyD3Nt3Dj+uHnV7FI4t1/9sndSTqLifXSEkUUeIUCf/eZP5mqRETINR3B6hFdkIem6+GcivNw7qlasfaRWHBcuIcK5ZuNPsqNjOdiMlmfUPnoaVAlkABhoScmn82YcVUMuTSJwnuffaeoMWU+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVdoK8RdhKUhX7rSxWlfDUeZG/wS+yNSbzeF25LGNYc=;
 b=Bv+L5H7LfeJmzKKqoqDiyBfwDKsWlyZyl/KjlB51sg/SjEapka/kV2d6aPVTTp6Zo0ZuDp/BD/C4uAC1BT2fErWmPJosa28D4++RCTWlb1L0oyw/D/VVq//9hZO8n6w4Wn9OFKcAVy2lPl/rLw2KfukVOJ2t5OFI8VQBkbqBb9hB1r/NaW0LrMu9nlO+wz4xv354d3OPMdSd4bbR1sNGq3huHeUwqG4uAq7caZpCnkF6TOToPbFxRUfJBw5tFq0BJ+5a+1tq1hcAnx5nyUYACxzU/m4xV2XhKFIPGYyVUOBVFFmYxs7+Z5gEP8wXaJ3AgQbaFQ6rkP8aXvSD0+q6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVdoK8RdhKUhX7rSxWlfDUeZG/wS+yNSbzeF25LGNYc=;
 b=IzeYoM5J3xS9T/ivEV19EsmKW0zXV6pdmuxMcXyPs2UyETQiO/KB2Lu7y9UFcyp7tPgOpn1k1ylCL/0HNYzB7urFRTsGzNDRDIg/1rmE44keSZYjgpx/MXLY/Y7C+TjOeEjuBmOug9Lx8qQ6hty0BMzy39GaJLn09MwLwuAEAqs=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:42:03 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b846:21bf:b5cf:67a4]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::b846:21bf:b5cf:67a4%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:42:01 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     azeemshaikh38@gmail.com, Adam Radford <aradford@gmail.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-9xxx: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rdgm1mo.fsf@ca-mkp.ca.oracle.com>
References: <20230517142955.1519572-1-azeemshaikh38@gmail.com>
        <168478437626.244538.8257051598276343700.b4-ty@chromium.org>
Date:   Mon, 22 May 2023 18:41:58 -0400
In-Reply-To: <168478437626.244538.8257051598276343700.b4-ty@chromium.org>
        (Kees Cook's message of "Mon, 22 May 2023 12:39:37 -0700")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:5:190::25) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: d57f6c22-edee-4a1c-aff5-08db5b15c25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4OxYnkdaTLy831enW2KgYfmeWW9uVIXUS7MJDbIhS1g8nwLZwDJYaj6ypDMI709fGgA6KIbjkDQ91c6hpwpCEXSB2LhaobEmQMtF5RiFAb9NRKIp2NkSYf213dsC4cqZQJoETvmRqF3odVgm8W7dh69DklgRmewq/vMkRPIKhA9O8n516thZZ3hCoClTQnYAObWJWBAYYhGOumRE2IAOny9GvQ3OT6rBhKFJMh+QgUe2V3TfhcihHSDIVL+VOPOIOZvwoxX8GU2Y6hnIR39BNTG/NWfefHetJ3BBHZiIvTxOoy9H/nJH7bwF/quan7peam3mPVNHT8rkINX1rGsemrTFtU8Exos4sq1NLzyBwbX35W0fq2nzVGeH70eAn8QnppPGynLMj7NkAgjVRehr3xwwYEF2A1A0CUSkVNLC685ZEtVoikgxSHAq5AhhIDAMXZlOtRhW4QWVJrO6YRGS25fuAUvchX0lu9f6UPurbhXoxlZF9XZ4FSM9ReZ5JSGrXes/nixGZXL3YmuquTYgGU8oGijRD+8MYI3BzMWDSf+jPTuBt8+oo5lgFfqKR6Km0YZBNRu8wwB6TBVdxWBHltCzGRGHgy7p0vdRGjC1Xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(8676002)(8936002)(5660300002)(83380400001)(6512007)(186003)(6506007)(26005)(86362001)(38100700002)(6666004)(478600001)(36916002)(41300700001)(966005)(4326008)(6916009)(66476007)(6486002)(66946007)(66556008)(316002)(4744005)(2906002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+sR52LbuVtN5hAi2AE3ZEC/bLM9ocGTigR2qt5LSq99YnTJY3zyVTYzF0y8?=
 =?us-ascii?Q?Jm17efd/DqDWZsEouZqYefnRvrNZUg38rJ/z4idnEACUmy/rus7q7iyFa/nu?=
 =?us-ascii?Q?xFUyzzWbhVRawrC0db5Ezqmrmwskh0tPS4f1MXOIcVRH7/Y+QmExizecLv5Q?=
 =?us-ascii?Q?sjxIy6RSMGGhA7nJPgRLOs9+1awLMFKCm3l7F/rfhFUGKtoxf+DHPF9b9sXE?=
 =?us-ascii?Q?FYcTa3M0D7W9PO+IZrOr22ffBzodIFEQs/TK+s5S2zLYhcik7noR3VVxmZKZ?=
 =?us-ascii?Q?yjzDA5EUdEpj9nMU3dFlrwG9F8FkqBFi3wWdRxRei+X/x0vUtDhqo58KS310?=
 =?us-ascii?Q?u/97rXr9gSn9PWA9jbjXl38MOEaKzLbklzcbwAgPNFS+8sm1qn5kfA21NBBL?=
 =?us-ascii?Q?HweDR/GH2ITh3OZKzDG3gU3pK4QakRjTRmyCAOAt7d+6WjPrtwH/PUwKYMA5?=
 =?us-ascii?Q?f0Z+YV1INfs+6+k3g/IHpphpbX7l8gsnAZbJTCV7CdQoT7K9IEnNFYgkkkKj?=
 =?us-ascii?Q?EbTK+qryQuGNC2aK6DyN4ZF5zBZ++nwdpL4SdSxyoe8ZnamjNbm/2jpHnWu8?=
 =?us-ascii?Q?/D0nZBm5BMzfAwF1vYSgHtkPUqug5EVoXJQmJ+yme9DJpOvAVtzW0BSHaO7M?=
 =?us-ascii?Q?Yaiy36K9/uXVjW8MsOOBU4yeRjFHv4RAlosxge3C/wsh3cNpgZ1YRoUZqcqh?=
 =?us-ascii?Q?fVs/fysZl9QOC6tVdzlvjLQ6CB83pOAf3m6ogg22kp52HZNcxKsoyIElAM5k?=
 =?us-ascii?Q?n0rBqviu/Z2Nl9UZojat+wTgM4TayjmwtaudeZKm3TRK+TwGESE/yp1A0+g7?=
 =?us-ascii?Q?Hyr1sK3nyUF/yJP4BoypYg+xwST88S7VIAOfIeTDTM6jda1HuLjxIcyUO3vN?=
 =?us-ascii?Q?iR2YGXLaPegntKrqm5xqOV59zmSKEsGmlfXJDY5rTF+vFdNBHMLSLWq8KXab?=
 =?us-ascii?Q?ihYyQp11kAxN7P/LPmWUHE8lnebiTMIgzJF9sfZ/AXB14aR4buh07OtaidEp?=
 =?us-ascii?Q?oSzUdoCe1gZuPoKm19DAXFnBs036LrXhQHko0S5iCy4jdb4aPGb2UEOmu2JG?=
 =?us-ascii?Q?jPp8aPb7GbgIqSuLdA8kRoVPvteWDhgYOfp9xWkiv35RbZ2dpryfmRtHdyKa?=
 =?us-ascii?Q?CYPZhEDQH7d44fGZ/SB7ZpnGjKXLFTDsYvWmcrm8AsvQj3rqlEoB+nMyGIVZ?=
 =?us-ascii?Q?A2ihB42vG4KVKFnFmwWeLWdQx3p249uQaffOAtM0ug+2m44UgUowq12HyyWM?=
 =?us-ascii?Q?Km6JtyhF5LHg/J5bRxy/QcNQ4UN4+rnXWe1PaCEx+MlvU3XHXUlX50DxC5ar?=
 =?us-ascii?Q?H/ZVgalbZ9w45za+D/mi2puIQ0tmlZ9jUberNea/98t6XFkVCIscnr9I/Uev?=
 =?us-ascii?Q?k07nFZIYPzUk0Kv1rap9xVcSrL9uQuHaD/Z4S2QFzQblKbcrva0QTh0ScE3B?=
 =?us-ascii?Q?6u9N9H+Y6gCsc+jypCdIoheUZ2kxAJLNpM4FxaS8L3mz3xuoXJUz4fxyFzRb?=
 =?us-ascii?Q?4sdpgU3SVQJ3YjRH1OwbakkoKj9P0/ATO0+OEuPKfGpbmEZJLpjC4DIj51uz?=
 =?us-ascii?Q?/o/yZuqUK0hjD0jlf3/yJR5pHNlmdOkcdMmPOLHlF6eGnk7eIz0DiuzH8uCZ?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qgk9p8+bZ+fIb8lW+xhlZ0b2SJEJHLCAvEV2SZCFDG57xJfBODRZXJjYWbeXM/ALBiO/P6nOGSwusLhYV3bXdPJ3Dh0apAFbyfWudZf72Fc9n1hoaLyw6t2Zs1m0tW/htbaYPkMTTu5K90AxUIIWV7xB6LkT/GOiueeCdRmoKDaagzvhGUys+wt9GpcHQEMQVtsAf5tV3n4qSZNY0ZSEJW5eSf74q0RGxoqh7CkQXXXryKlHGnt7p/DCral0tjflOObKTN0yXrSB1UKs9Cau3LFsmGSFXudabd5NzFXFeHpPZuIZctae709KNnXpaK+feK7MPxSDs7CNGLzxkZQqcAqWwGRGsr0X+x7b7h4iYQBO0f/UseRrV5C0RiMewtOJbEUAS1uU2WLH2OtDyQJluZXPYtVkzW8fr3CPFJqqWzj4BEmpg2BEZBoTOxRe6Rx2seJXszTLmVVfJV4jKLN6E/tNar0EdHQ0BYEl+MCGahl1c9gya61QoEiYX2roOBspP+8L2wwWEbJl5ycNv8JxM/Wng7jdjizRqytnf386vbPhOvObm/4Zxr160B4kG7i5A0lwbiikoqCaEJt7rCeel2hy6dVyZd74Ex2MxKvOAhAhQ4rStjAho7j1m2xhLXXnyAzaUdHx+Q/aECDvYmBqw5e6V0paQBix4dU/bHo7B3ehzjmUQb2txBkFuZ1uN+/take6KEh4zqpuWNpwqOEJmpIrn0RDGWIG+mDLSLgMDJJDVUkYto4CyD2hKrCf7oqm5fgTG9CWin+CzNmmNfzVLWA5x79OUPrbeu+drmejZuxZnIA2lHlP0ZmJBZZXt6tXfT8kyRIqDSJjSclPt/6asWkRg8kWeg9mX/fIdSG5pYs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57f6c22-edee-4a1c-aff5-08db5b15c25c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:42:01.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqZd1kmI49HoK+dPrjhPdpaESo4yPuXyc9I+YkqogIalNFojMq/VKwaBSGUz/NZIYnciCqy2lOi/C5kReoJDI2860GeY5Vr8UfHnrITVO6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=991 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220192
X-Proofpoint-ORIG-GUID: Cikgj8Pg-nbuF6ycwB79YcjnnCvT88qy
X-Proofpoint-GUID: Cikgj8Pg-nbuF6ycwB79YcjnnCvT88qy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> On Wed, 17 May 2023 14:29:55 +0000, Azeem Shaikh wrote:
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy() here with strscpy().
>> No return values were used, so direct replacement is safe.
>> 
>> [...]
>
> Applied to for-next/hardening, thanks!
>
> [1/1] scsi: 3w-9xxx: Replace all non-returning strlcpy with strscpy
>       https://git.kernel.org/kees/c/fa36c95739ab

Are you planning on sending these? That's fine with me, just need to
know if I should close them in patchwork...

-- 
Martin K. Petersen	Oracle Linux Engineering
