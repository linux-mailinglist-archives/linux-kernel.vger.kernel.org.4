Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B061C6D0A80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjC3P4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjC3P4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:56:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D638E;
        Thu, 30 Mar 2023 08:56:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UEEECc023746;
        Thu, 30 Mar 2023 15:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uLaLE72Ju/dlDA8QgBVjKvg0UQltFMt/yfRdAn20LJ0=;
 b=F/cicpwncCHbQ4vwcCeQDGUcdXiQYsxe0Jf3fMQxLHSearpM/xZsY6CNB4xEwyV3EjYX
 0Ge0QH7H2v9zyf5r1vw3oQGeAeGmLsGd5ABZZozlCueoMMCAy6MjyGUChjni3YtVDlLc
 yyyvoWmc7wcc+5Eq9lfjQubbSTPE6DcxBbZuyVImeNpDQ+kA+TWYgcx4SgNgeBQ0pZrL
 OWCLmuv7wNIGKdm0M0mSoPq0HSIKoyC6v6KH8x9QmwptzvfI1Q/D0asZMuLDwPXEYj6E
 alhOqY+TniKf3toi9us9iECEQ2LanaaxFgbXqVQYpHOPYRsf8HOO/PZdUJL41fiezDpR ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqeajymh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:55:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UFCfRZ016287;
        Thu, 30 Mar 2023 15:55:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pmyvvj5f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 15:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcJUzhMXFbd0nCJVLRR1JulCgxUO4yCwNw0vse57wBI9jdxQy1oPaWvTfTi3HRCFL0NGqkm9DTbhyv8uL7RjJHxwy0m/ux4gCcFg6bn9ygU9DiT7qtROSJkcW9c4xJ1HvPAw2yqvRkjlLC+2gUC9nwGsy1w+zljHDnXsIWDLHCaWhLQ+OPu9nP8koGtix6nkqiXjwI7WmJgY9HN5Y6SvbQLqYrm2r1pd9dORlyczg/13H17/J6pL7fsqBbFdr6qV6DQ7Iw8J7+EoORKVmVnY/6sZyvObuRwbzyn4AqIWBTcJxlVQFRZcn0GVbig5Nsu2e1WF0vJxw/iIb6dN7GJUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLaLE72Ju/dlDA8QgBVjKvg0UQltFMt/yfRdAn20LJ0=;
 b=UGhHdz19pvAN6LzJoti9Z6FgEbjue0VEttxXc3utuYL8HiwhoLZSyKMZl1tDN1NXzH021vZMQU4h3aFQw1dstCXTfxkqySHQJ35B1XShIHdZdVxEQg3irvMDff3lZgg32iqLcIZev2/2Q4abdzswlHD/VZ/906ekshvj19DZTN+vXSzljojL4sQjgK+41oEPklfodKFAmEJa8qYwnEOzHUcWqL6EOtM5WyoFx7VnB6PD9V8qBpweAGblYxP9FfoXOZjXRwqkLQgVdQpQ/ElTC76F6B/dZ/OOCkdslSlvjCpcTGRRV2EKL+eKWGB0sDs+9nHbIUGKx0093Pi+f3mX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLaLE72Ju/dlDA8QgBVjKvg0UQltFMt/yfRdAn20LJ0=;
 b=ONe1V2gWh0i4VLMTGo2rUBe/zmBQx1YgcUcfcFOWQVZ5gZZC5ifXlZa6PHpR/z/ekbZSrMlBkQIbG5ws7s7Z+L7qUPYVDVBtu1nlWNCPpA35CPcO9JF5iITl7byQ2+deANyfGSNCqCUMG3oeqe6qW2mP6ZI+zpyFWRNhH8D7Clk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 15:55:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 15:55:41 +0000
Message-ID: <e6e6e508-bb41-d1c2-384f-1f723c7a36f7@oracle.com>
Date:   Thu, 30 Mar 2023 16:55:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 1/4] driver/perf: Add identifier sysfs file for CMN
To:     Robin Murphy <robin.murphy@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1679885172-95021-2-git-send-email-renyu.zj@linux.alibaba.com>
 <72246c5e-6ba5-098b-a979-e90738cc7509@oracle.com>
 <8ba831ae-4568-32af-3fd1-fd51a7c13dcd@linux.alibaba.com>
 <091d5b8d-6ea7-e6ff-3421-63612797ac60@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <091d5b8d-6ea7-e6ff-3421-63612797ac60@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c078fe1-42dd-486f-fbae-08db313736b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wz6nrAsu6DvK1lue1PDzwyBEKkmcAc6TNkG0AE4szUAYQ8j2T8+MbpNDTmIKaXwBvSZNCWGdL7sNcYcFBdWyi8PflZswu/nO2YmTU9teseB6/5tQCuQA5bjE6HO1XsGKsyVuVzv2viVLz6W07bOoYqn8FAvyPHts5UdLjSnTYd2Jx5KPVNYmd9ATRZMufEk2kYJsCaZYkPx5Ry783qIaVhJN6zPf4Khxbx/ElYj6emMQ7eUHlHypP6qUEu/VBQm2mme4mvMdZPFnqTlStkaUUI5+Kuefis8PW+3G+Ap1hX7Kjbh4P0eUjDLSE4r1xfpXnkMwGNF8Hl9B/ZEJLUdDsZHbl5LZ6aWPdiPKUl+1ATjeuf0sO6aFBdK40zSTgMhO/Dg4+XW+iW+1to2r51R0l32k7nTEx2jLAqHcVWNcmB8Jwz4Zpz0xO7mkwggLQFuNge6rhoPatM+2ypTI9B1Mmum/rF30ogQO7uVaSrDciVZgQk5lcMvC5Xk736LW5RnRPAfyaTt9zaNo/74Z9F5JB5TBk2maI1BvdsZrVMCjfAd6gjD79yMEgfg9Tq5HLU1/dNK5rP8j9GomyyOimEDaKwst2QAvjtpD25XIqoLs9jlvyEzoI76h9fYjh+tH5vv1YNXOaW95HsMH1JMFPRw5k4jfTJPTlqcv6FRX+fCMzY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(316002)(41300700001)(54906003)(110136005)(921005)(8936002)(66946007)(8676002)(66556008)(4326008)(66476007)(186003)(53546011)(6512007)(26005)(6506007)(6666004)(2616005)(83380400001)(31686004)(478600001)(36916002)(6486002)(36756003)(2906002)(5660300002)(38100700002)(31696002)(7416002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVhPOVVxVHd4YlF5UXdxQnRac0J0QmdhbGJzL1J5U09KY1g4M2lpelQ1QWtk?=
 =?utf-8?B?TTk2eWxZWVBiU0FDdzA0NERaakMzL25ZZ0hkbUx3K1BoMjV6Q0Rqdk9DOEJG?=
 =?utf-8?B?c1ljUFR2cXlMNXBickloRGxWM2VUZ3UwRFFackZmNDAzaDNGeTR6ZDRmeWUz?=
 =?utf-8?B?UGxoYVJ3M25EcDc0MUIwTTRCY1hTL3BibzZzY1BlWnBWWGp2aTZkTjBZZHBR?=
 =?utf-8?B?MGhxMDkydnhnTjc2enB5WnR0V0htM291U3RaVnRXT3ZQT2NUVUk1MFpTNVlP?=
 =?utf-8?B?OGZNOVN1di9TSUN4Wkg3TGhoOEZqR3V4Q3pudnFtTjdhVG1mYlhmRTRJWXFh?=
 =?utf-8?B?aHV2OXBna3ZpZHJXK2pIbG5OYWdjRjM3S0hFY051blJKb1dPTVNKS0FXYnEx?=
 =?utf-8?B?QnZZWHNlK0RFa2ZXR1Q2ZVg4SVJrMXFQNFo5UXBmNmxyMjA5bzN3ZTF0YzFi?=
 =?utf-8?B?TmxySEJ6MmlrNUZ2eG1RajIxWjRzdmlHTjRZdDVjSHNodDM5NFN6K3JLYnBx?=
 =?utf-8?B?UmVNTm0yd2pLVFdNQ1laQXBuNDNGeGFudGxoWURZRjlLMVpZb0FYUmh5TFNB?=
 =?utf-8?B?Y2dNWG9rN1NlUDNTaUYzWFdteTd2YXV5SnorK2U3dEV4ajdGRHpFQ0xNRlVU?=
 =?utf-8?B?OTdjOWt6cXRkZTRrOVVhSk5yV3J1bzU2T25UdkQxejFkcGtlTmFuV3VLam9P?=
 =?utf-8?B?MWJlZ1B2UVNPVGp1RUxzUlR1b2Fta3ZHKzJCOWlxWWpXNkFNcnVCVjlWbVAw?=
 =?utf-8?B?WUlqamYzZmo1RENxbm9PbTA1UVRaY2FPQ1hmVkJNZW8wcU5rSElaSmhDOTJr?=
 =?utf-8?B?ZWc4VDRWOGVrWlI5K2VLSjBHT3NlcmdBRHBVekk3N2p4VUN3S1ZGY1RSUGJK?=
 =?utf-8?B?WmtTUGhwRTNXaXJiZzMyb1NUUzlMdDE5bWliZzcyN1ZEWlpZdWhiQmo4ZmtU?=
 =?utf-8?B?N2pwMXNNbVRxQlAyWm1LeGxWelJlYlZpTXZ6czdPNUtXZ00xQ2gxb3ZQZ0ha?=
 =?utf-8?B?OVpneE95d3pLYW9iN0w5R1Bwdko3a2I5VlAyTitZZVpoSUt2TzlkT1N0S01T?=
 =?utf-8?B?RGNmZnVMNXhIaFVRbGhGeGJOZDQzSXNZek1DZ1dyMDBmQUpDcXdEbDhCaEg4?=
 =?utf-8?B?cFhWWjhHNkdHZTdDdXNzSTdIcmM0ejlwSG83cTdhUXM3TDU1WkwyVWFua3Z5?=
 =?utf-8?B?ZkdSL0xMOFk1T2ZLbmc0WWpyNFN6MHF2WHpWN2R2Mmt2b2UvTlNmMG9Xbkta?=
 =?utf-8?B?M24zL09xWCtsQ24xVU51c0ppQkJpVXZFcWNSeHpjMWkrWnBOeG9DV292NUh3?=
 =?utf-8?B?YlNwRXhZM1JPWWw5V1ZXZFNVay9hcUtHbzA4Z2NPcGJCS1Jac01EWkFrSkJT?=
 =?utf-8?B?TXB2dGlub3dZdHlXYjVhRnUxaTVTM0hmV3c4VVFHbTR5NHZyMFB3cDB5R3VV?=
 =?utf-8?B?dUlYVUZUbkNUZzdLV2JteGpUZFJIbCtMWDRwa2RuNlM3SVQ4WkdYdXViMGpM?=
 =?utf-8?B?c0RIMkdHaXNQZzZ3ZUhyeU4vOXovS2RoYjRqdU5Vd3FOS05DVXkvOWprZ1Rh?=
 =?utf-8?B?NnpXMkFvOEpoZmt3V2ZWZWQrb01LU1FjWDZHcWF1bkpWNlZnRHd1bG9FSU5G?=
 =?utf-8?B?UEhFSWZhUlA4MHgxRTRoUUFtczBTN3pqV3FhNEdqK3pDN015L2ZNaHBaVUND?=
 =?utf-8?B?OEVjZkxNell3WW44MmswTy83UkdEbFVXUldQV3FsUXNiM3cxVnhBckliUUVB?=
 =?utf-8?B?c3ZMNkxKdDdWSXVEb0o1cG9nMmpGWElQTHhkTWJHdkVNWWh5U1hUZ2lUTExu?=
 =?utf-8?B?dTBCUUFwdUY1VTBXcmh3S25zemdibFBMcldOZ1plazA5SXpWWnJnb3hHVG9j?=
 =?utf-8?B?MWpQM2h2amdGNHFMVENNb0ZLeDNuZVBOQU9Wd3l2RjJiaTlwMklEYzVTeGZm?=
 =?utf-8?B?byt3ZTVYY3N4VzBqczZISDU4TERHdCs3MVkrUDZPdU5peVNDMU5BQlUvOE8z?=
 =?utf-8?B?QVduVG9mSExEZGhaYXhldzYyYXBDWkxSSHkxb2syNGs2T2JreDVnWmxPQkZ0?=
 =?utf-8?B?bmtpY1JiMDR0bm1FTXZ1U1owYnZnblZ0Tk11bU1OTEFoZTFUdkRUK25VdnRE?=
 =?utf-8?Q?ZfU9XszKQvvEPEmrv2YLP7yua?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RGxpekFOdCt6OVRYK1dkR292MXkzaTRKOHRSNXJmazk5TkF2VWRBYVRUL2Vx?=
 =?utf-8?B?bFJzcGVSVXE5TDg4aDAwdzQxb3BsbXE3aStCTGhLUFZGb01GSkwzMU8vZ3h1?=
 =?utf-8?B?Mk54MU9MQUswTnI3UUNrWGVzMmEwd01BSUl0dHBMV09VTjlPVzJVbEJlKzM2?=
 =?utf-8?B?anovWlR4RW9sQ01VNVRhL3paL0lnWTVQYUZtZ2orS1MvQytzQTJvUDVRY0V1?=
 =?utf-8?B?UjdpU25HSkUyN3lZeENPaGxDcmRzV21QZHpzMWxTS0gzWktidVRlb011TkQw?=
 =?utf-8?B?MVV5SWJWbTVIWXJCU1FpUVRIWmt1SFFJNTBka3V3Rk1LSmM3MitQdnZ2Tmcr?=
 =?utf-8?B?dysyTllSUVdtUVVPVnB1dk11M0dvdHFURHR4OWxXTFEyQWp2dGVXaDVEZEN2?=
 =?utf-8?B?dHFNU1c1dDJ5YWRMQ3lZOFdyNDJxb2tXa3RRcXRlOXJ3SkFLYk1iVGtSeE5F?=
 =?utf-8?B?MC9GZUtRc2ZNWHBza05QR1VlcHBBWkpzQk9rUksvdkxZaU5BU1RxTEpDbzVZ?=
 =?utf-8?B?NmdBM1l5THJBbE5CQkFqbTdDZ2J2Wm11dkVVbDlqQzlxbGJHSkwrSFlIUUtq?=
 =?utf-8?B?WWNXSTI4dnVDMnJlcGF4R1NyZ2FkL1NkdTRJNkl6ZjVtcWZWT2VNZit6Yk1k?=
 =?utf-8?B?T3FBb0wwK1BuOCtmNW1UU2x4M2VNTGJUWXh4TFVESld2RlVKdDMxVkVFTEI4?=
 =?utf-8?B?NFpvaDhOTFJXRm8wRnNLeVNRQlBsbVFKZDFRNVVYWUJUTUh4MWhISUU2Ukg2?=
 =?utf-8?B?Y05RYXNldDdLS2dmYzA3YmRDVlJkcUtpb1ZaZ2dxMWNrSHZ1Q2YzM3RhMk83?=
 =?utf-8?B?MnJUeFhRakgvVEpPdHpyY1c0N2dVc0FTMWJVcEtYYUowM2NYbkRGaW5rQVl1?=
 =?utf-8?B?M2U1TURobEVQd2wrMDZwUDZ2R2UyemFxWkIzSHlPRjZEOWdPRDRkNW5FcXcr?=
 =?utf-8?B?WmprTU1SbDFrSFFSZzVHcVpaeE5BK1J1L3hoUEtpU2lYVENJY2tFVzh4R0xx?=
 =?utf-8?B?Q3pIUmpsM3F6RGpMTEJ1aldzQkxiRlpmQWlDR2hZMFBUZk1IYXhWWFhFV3hp?=
 =?utf-8?B?ZlFPaHJsOERUWjlkZ1ErYS91K3Y3TytzU1lWby9UaXhtVkp1eFlJUFh5eXhl?=
 =?utf-8?B?UjVJM1BadHpwSDhwTGR0Z3pnaWF5WHpnSVVqbUV1aVNObUdQNVFNUE84aTkr?=
 =?utf-8?B?MktNSUxidGVjc1Y2dUVJeXZySExaUUZSRXF3ZksvVzNqUTlFTFRqbDZMZkFq?=
 =?utf-8?B?bnF3eDBrTkFEYmRiQzdGOFRhOHhGRlVjd0RGbGd2VHBuZGJXbGtwOVhudlMx?=
 =?utf-8?B?T0hCckUxUTY1RzRoS2NBS1U0anZZQkc2SjhDanRUdFJmVVhkaFFNdGhwRjFK?=
 =?utf-8?B?SGVpcmJVUldISk9IVzU4R2IyMHBVeXd4a0kwd3VoSU0xZVRQTE11cTRCZHVW?=
 =?utf-8?B?NEl3OVNqTGdmSDdSK2JOd3J5VVp2dFJVQTF2VTFpZzJIRnRTM3Iwdnl2QzFq?=
 =?utf-8?Q?wcHaAI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c078fe1-42dd-486f-fbae-08db313736b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:55:41.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuG7sCjn8BqIAeTFcYJh9LIbMzEJTNdQ21BAHnNjgH7MvaxesivNRyGkB02kczKojSjWiS8DAeb54j3YwNEkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300126
X-Proofpoint-GUID: E0bF1e1MBMYFkIil6ZNVZLRulB4UygZK
X-Proofpoint-ORIG-GUID: E0bF1e1MBMYFkIil6ZNVZLRulB4UygZK
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 18:47, Robin Murphy wrote:
>> Do Illka and Robin know that there is such a register that can 
>> identify different CMN versions? Looking forward to your suggestions.
> 
> In principle the "part number" fields from CFGM_PERIPH_ID_0/1 are 
> supposed to identify the model, but for various reasons I'm suspicious 
> of that being unreliable (not least that no actual values are 
> documented, only "configuration-dependent"). That's why I went down the 
> route of making sure we have explicit ACPI/DT identifiers for every model.
> 
> However, the model alone seems either too specific or not specific 
> enough for a jevents identifier. The defined metrics are pretty trivial 
> and should have no real reason not to be common to *any* CMN PMU where 
> the underlying events are present. On the other hand, if we want to get 
> down to the level of specific events in JSON then we'd need to consider 
> the revision as well, since there are several events which only exist on 
> certain revisions of a given model (but often are also common to later 
> models).
> 
> This actually foreshadows a question I was planning to bring up in the 
> context of another driver I'm working on - for this one I would rather 
> like to try using jevents rather than have to maintain another sprawl of 
> event tables in a driver, but it's still going to have the same thing of 
> wanting model/revision matching along the lines of what 
> arm_cmn_event_attr_is_visible() is doing for CMN events. AFAICS this 
> would need jevents to grow a rather more flexible way of encoding and 
> matching identifiers, since having dozens of almost-identical copies of 
> event definitions for every exact identifier value is clearly 
> unworkable.

This sort of problem has not occurred yet as perf tool only supports 
"system" events for a handful of SoCs so far :)

> Does anyone happen to have any thoughts or preferences 
> around how that might be approached?
> 

Currently the perf tool will just match system events based on the exact 
HW identifier and PMU name.

However, if you consider PMCG PMU support as an example of possible area 
of improvement, it has a number of fixed events and a number of IMPDEF 
events. There should be no reason to need to describe in a separate JSON 
those fixed events for every instance of that PMU.

So a simple change would be to teach perf tool that for certain fixed 
events we only need to match based on the PMU name. For others we need 
to match based on some identifier.

If matching based on an identifier still leads to unwieldy amounts of 
tables, then maybe HW identifier wildcard matching may suit, like what 
is done for CPU events.

Thanks,
John

