Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0640E6DA140
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDFTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDFTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:30:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD140DC;
        Thu,  6 Apr 2023 12:30:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Eaf9N015404;
        Thu, 6 Apr 2023 19:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ofef/kijfCjZomx4nmoKPGn5Z665kcwlesKTKRN5Yys=;
 b=ROvMLlmemRu4egKaYB1gyESoJZGy4d1I9Jg6aCjiCzxLJk3n75y42nk372MWGgRJ6L2Q
 KYwZ40tlFvadFE7U1+47oZXDUlTQu2flxbiCgERrT1x2J1NI1NfU2W+FxpeFGeM8YXoo
 RxRkclq9wFrhgnCzZmO2yqdEB0jfrppbRsYNhHJ2SxfQlwrzC0eD6B+vzia1kngIPSsZ
 69EIH5gQfhngFXh9/LaQUPkOehENZnWPvzKtduupXPMXgAxnkxTEotJXm1NybBu7Vc51
 VUSTlHUT0PLW1Rgo4pYTJAgYyFlsT3epncvNdga7qYELx4v1ELGz0EZkwesX8LyjfZdU XQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7u3nr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:30:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336IooOu018565;
        Thu, 6 Apr 2023 19:30:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt29yj7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 19:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leMOx0JvjeirX3UeqZi3qTWtPDSrji71ArRqEIyUTlk+Kaf1lTGWKRwa+nu+wxcYoyBn1WpbzHuPgudql+WazPiJVn8ICDcSjYkeZyHT+GJkEU4q5efFdAXfa4qbGz5JjGRLyMbJH28AjE9bXXeai1xXzW/oaflGfr52NceKii6QvepJbRtAF6GSy3f4xunug9YhkM7xsLy5ofJONfi2y1ihxPYIJ//QN7tm4jarXXwZzsuzeKROKaoJWIixedZA6KqlkSX90xVoUJ5sXZwQzhQq/VlehfP7QSW4wSUtv8KgDMaUWB95/4ckVUfwT0zAj0dsX+Jf1e5puvXd1ELQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofef/kijfCjZomx4nmoKPGn5Z665kcwlesKTKRN5Yys=;
 b=OgeVMP7LEFhjd7v8nwJiyvXwGuZ81Flk6YzKDvPbirNJtRpl/MHisSbhRhUggnW5q87BNXcWuoM8gaN6abMOdaaPKuU2L5CnFvqKyBesQzG2SHk9csweaSyOfCM7ONMqpCklsyxGjltPqX86TwNWHmb87g3lDBifRhHp+xAQ1aDTzOGclreJqrPPddd/O3+GYTQ0G0uEfkdWeRI3yfiZChBEIrHJQia3yZwaLop5zVLtgO7jEiePSLLnYmk8cHNhBoYb8TY+b/tgrcV0yRLG5j8Gmaw8SKsOcLmz5DgtgJqExxtpuO6kcYmgoXd+20cwVJpSXZ47EV6DJS2vu4Ni7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofef/kijfCjZomx4nmoKPGn5Z665kcwlesKTKRN5Yys=;
 b=tgH59cXtCq7HSrwJ+c2J4cMEwpN+h7q52Tvd/Xg4/xc3jTFmOPivaQRzbi1QPbLjaMDiKQulq/huxQXqp1fmXNDuUd1si5SdJU1oX/LOe5ojuzMKBhDWiU5mzWzoGxrUD4uLFJp3IBARpGQ4kCx3uvIMOEDLhbIt8iyvH6CRfh4=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:30:30 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::b3a1:e02e:37d0:afa1%7]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 19:30:30 +0000
Message-ID: <0746dd23-5dcf-e858-e15b-159673266f2f@oracle.com>
Date:   Thu, 6 Apr 2023 12:30:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
 <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DM4PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 555d1bf6-ea5b-4cd3-7d63-08db36d561ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5nbM5dQD1zgF7WT6BkOl+WNQNNaoaOWgtgM1MMnKfURzF8LQaAkI6HE7gnj5m5fBXLS9oL9QUNo8pwALciF+nycG3hDZnE7nAj7iPqkLLnP+8l0tJ9iflrTCkB/aG4AYRMnX8TekFaLX6XuGoDcfGzZmPYh37jGEYxOqXPBDWVD4k3OpLZouOrVHgs5/4VX9gha5ouMQbeRDolykCX3XD7pOnY6GavwsvP+kQspRDWo1XVWmC2NqSWfL1tXtdd8ro2BU1WyFw0UiGCG9MFYFu6DI6NI6Wcok/w6KZ/ZJgtMmMp0WFURiOU0MCS1DoLhGR2dquJvLzdcxLG40UvI+XFioupo9ZBZ3JIsllr+dACU+iwIfBl2kK/vMOl7kHmFkEo/PAy6hIzjTJcr/niYg3NE+MQSUtOp2rtefSzets2a57cBmV+0bwfRgwNl0L6oMXyB5Rx4seiiHrlmICztLAWandczQP6rYUex0HizMGl2EcUcDH3mmcx4mMPkMbAydRSnlDeQ5R1xh0LiIq/eHBkXBQc4oPrIcu8BlC8Cz3PIyPph7/0Db8h/I5uZU8WqxyawVQLqJ5taHWZIRNiC9sG1X09aphCJ7Hs8ULqNcu3A/TAY0lzTpdSZyznm8FfziWEv1gH6BYHxaQrDeKfV4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199021)(38100700002)(186003)(44832011)(8936002)(110136005)(2906002)(2616005)(5660300002)(26005)(6512007)(53546011)(31686004)(6636002)(6506007)(54906003)(41300700001)(8676002)(66556008)(66476007)(6486002)(66946007)(316002)(86362001)(31696002)(478600001)(4326008)(6666004)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC84dVk2ZTFpclN3RDVPeFZDZWwrdnU0bVVib3ZCRTBqbStTbGIrR2c5VHJr?=
 =?utf-8?B?SnBZVjVjNkJjeEdROEU2RUZlTmFtbVlSVkJwZWpMY1lyeDZ5enhsWS8vK1Y4?=
 =?utf-8?B?MXJKM0tRUXEyYnhCS24yK21IQitsQkxETmhUTzhzWmR5bFg3UXNiSVViR0Jk?=
 =?utf-8?B?WkFaN1Nqa0h6QlFxT2lsZnlzWU1CQjlNMGtlSFp0WU5xOXFRT1RWcnVhOTdi?=
 =?utf-8?B?eTRHQnlNRWJpakpyUFFQZVFSbFZYUjFzVVlBYXJmY0FxTEcwNEhQcnVtMjVW?=
 =?utf-8?B?eWxUeEFBdDE3NWdWd3ExQ3NVUTB2RFRFUXlsMmtzS1U4czg2R24yUnBzd3Q1?=
 =?utf-8?B?Y0MwMlMvVzRLWUhFNE1iQWt3N25maGFoSG9lbXl6YnA5M01hVWFHeWwvUHQ5?=
 =?utf-8?B?WUNKWmFFZG9YZUFDZzNnL3MvUUU3OFB2S1VWN3dEWERLZGVaZGlETTVrOUhl?=
 =?utf-8?B?M0w2Mm1tL1RBYndaZkU3SWhRMGhsL3NhbTZhTXIyRS9aQTI5dmR2cXFZTFQ2?=
 =?utf-8?B?VXlQOElUUVVLcDEvbWN5V1NrWmt2V1JLVDdRcGhlaUNialVaZ2Fpb0hGLzFr?=
 =?utf-8?B?RGZwbldwdG0ycGhhNFB5RWgxeDJIRU9aNFlkSTdhd3lsTGFRaWhQTjBjbktq?=
 =?utf-8?B?dFVyOVFxTjlQam8rdWY2QXQ4MHF5eUxEeXFTK3hCZHRpL0NsTjVuenhWVVJR?=
 =?utf-8?B?VWN2V2ViYm9GamowQ2RBNWFpODZKVnB1b1gyRTQ2WDl0dHVMaWlQVkJIU21M?=
 =?utf-8?B?dmkrd0pENVZ3RktvbU1jTVpvNUtFQk82dFFCS1pOSHpuUW9BRXE0dXNUQ0Ns?=
 =?utf-8?B?WGRQUFRINHFoWTRyelZWbTBYSDcxbVJUa2diOEJYVVVEbWE2dzZXMTVJQ3pi?=
 =?utf-8?B?RER1VVFDL0dMWThsTDRwcjlON3cvSUo0T0VEYUVqaEJ1d0ltRTBsN2JuSlZC?=
 =?utf-8?B?Tk1vdGxoaStJOEFVZEdVVU02R3hVY3dmbXVlaUkzSGZaK0Y3UXZ4Yk5mRjhY?=
 =?utf-8?B?NzJvQVlRZk9ZbkptY1FUQnd2c3BERHUvcGRZN1liRm41Q3JENGtmQ0lIa2ZB?=
 =?utf-8?B?aHVzdjNLVDFBb24weURjdjFUTTlxV2VyUVZKbFVQWmhRV1Znbml2Tjljdys0?=
 =?utf-8?B?L2E3V0lXZXhHcWlNWGlweTY4d2RPaUkxV2ZIcWdrNS9ZRVNiK0JaV1k1bXpE?=
 =?utf-8?B?VzRSbXhuRnBFYml4YmFYU3Avb21EUzNVV21RTVV3ZmFYRkUxeFRUL2VaUXcy?=
 =?utf-8?B?eC91ZU9NVTIwNk5FVFo5b2lFdE16UVc3RURTaE50QlliVy9ZQnJQT1d4bzhn?=
 =?utf-8?B?SEJvK2cvc3VObXpHd05zMXBDNzhBbmFkOWpkVDNyS0Q4WW1uaEVCT2hHQVIx?=
 =?utf-8?B?ZTlMTEs5N3cwaDFBMjNBeUUxbFUreFV1V3NGSVcwbGlEeXNQVW01OWlra1Iv?=
 =?utf-8?B?dXc4L2VxRkNKN1czZXBLOFBDdzBEd2dDSnNDRmpYOS9BRGJTZXJBZUdoalBu?=
 =?utf-8?B?Sk9NL1JPYVVUZkZQZ0pXUW5iZ0hsSys1NFo3eUlzdDZGRnJCWlZWZXhPSTkr?=
 =?utf-8?B?MTZWcXJScTZNR3hmMHdOa09TYVZrcG5ub0hIYjlxaWJpNjQwd0xsd1ZJNXlM?=
 =?utf-8?B?WExhVlJzbkFUa25XL3hWNSswYUQ2a1dNS2NJelR1VHhhT21BTHRwVFZSdVow?=
 =?utf-8?B?OTh6NzZ3OFBjeXkwZElRNXlVOWtXbFhPemJha1BjSW5LNnhxdUdNUERpQW9q?=
 =?utf-8?B?UDVZMTRMVTdvTGVqejhSdXc3ZGRtV1BRVjdEa2tCRmF0ZWhiK2srL1hkcGsy?=
 =?utf-8?B?ZEFaWUh0SWJIa0xTdEZrQWtuUzdYL3FCbE1KT3h3ZVA5Q1Z5Mm1PUXUwOUZL?=
 =?utf-8?B?R0ZIMmdRWDhMTGFXVm43bE5qalVYQ2dPMVhHUWk4ZVRia3hJeHZzSXdmYVd0?=
 =?utf-8?B?TFd6YVlNaXc5MmN6NjJyb2swS3h0NFBVQzI1TzVqaVROYWcrUGF4eExjNGc2?=
 =?utf-8?B?VGpGTTNuR0pvdHNhQkV6RFcrcVMxQVFYTXp1RXVSK1RLOW9UdjZOV0VDVlJk?=
 =?utf-8?B?eGxJNG01bGpHUEg5Z1BKVEtFVXdLcThJKzg1dlBjYWVicGdsK3l6L1J1ZFR3?=
 =?utf-8?Q?e9258dZeE8BaCIQ+xcw1nVSa1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPgbzBRmd/jR0b/vn8x977M+p04w0kLRVElQvxLWjwivQW11t5cBKVWA0ld9oXeSq0oKCzZURPAPzm+4gJ/07XVgPPxhinvqjva9f5tTpNlR2er5A7/VyAYYkA2rvZK/yIs3W7vDaAIihdYuomM0SYg/bXlMGE15KshpJI0NJ9Imi4KFjR7nPqoqv2YHgUINeBIakzvgE4BFBVJRB/EyVKf9bITXQ+//xhVGvY/tfv4lyX6WI7/0y9taEv6K6qYSa1wkoZ/4nvLRDdvcMyTJrNGKa/bflwnvzSifDHQC58E4Qc1dKrwwIH19W818casZw1UPkp+iW+ePsvWVN0BWRypQ8s85yaWm4Tocv/8zEQNTlSt2qMend3Tfny4e1ctRkWxcBdeOkjB+32lTK/WPYyhXhwkLkL/uQ1wbowFcaCYi1cKBBPzKCVS5osQsUE+2Vn9y4e8OcID6H8Vs6ohSBv+SGiAFJPXnK76j79iG6G9SvldN8PoyGy6fCVIouveydpTOR2ftEiN72750/rLMPseq0KlS9tL3VDuy2Cavi9r67j3PixOvjkgLi7eArOr1+u/04WeyBpMyO2MvdL3HVjcBJzQI9CTBRsmbWgjxCW0Fe34h1f9L0wy35dzut/u+kARxOKQtiNP5FIs5+6T6pXA6rCUrIFr50OgE/2nThQ83Mv3Roteglo5fwTlZ475ApT2D6Q2eKl83f9TLRFtvYohPLw7Vsp/n5UnKyGwFE3tipQaQE9vgMOxGvVars22/vDDveGEfM2QOZmFL4LhKxkHoyjfd46qEHv1228y5Oaiy79sOBwezu0vK6xEV94+f26Yc+RGgTpPXGD6MX+6IQ4AeqmyXcpjJiW7bfEQbMva+HKCSOT51mylRKU1FYZ7LSMfYe8osbg3g6UeACj19HcLAUuHZa1NUCoFcJun6NfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555d1bf6-ea5b-4cd3-7d63-08db36d561ed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:30:30.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG02+nCMdcTGBx5IdFr3e+akuaGayzcly9A00aIRyZ+YqUqx87+68hESMtFqCPkhx5I7L9A4+lR2MVeX051F6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_11,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060172
X-Proofpoint-ORIG-GUID: aNSHPlesCLFCzQcKuPCh0xJ_On4b9qh7
X-Proofpoint-GUID: aNSHPlesCLFCzQcKuPCh0xJ_On4b9qh7
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 11:39 AM, Paul Moore wrote:

> On Thu, Apr 6, 2023 at 1:38 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> Hey Jens, Paul, James, Nathan,
>>
>> We are trying to use blktrace with a kernel that has lockdown enabled and find that it cannot run.
>>
>> Specifically the issue is that we are trying to do is pretty simple:
>>
>> strace -f blktrace -d /dev/sda -w 60
>>
>> [pid 148882] <... mprotect resumed>)    = 0
>> [pid 148881] openat(AT_FDCWD, "/sys/kernel/debug/block/sda/trace0", O_RDONLY|O_NONBLOCK <unfinished ...>
>> [pid 148882] sched_setaffinity(0, 8, [1]) = 0
>> [pid 148881] <... openat resumed>)      = -1 EPERM (Operation not permitted)
>>
>> which fails. The analysis from Eric (CCed) is that
>>
>> All debugfs entries do not exist until blktrace is run.  It is opening
>> /sys/kernel/debug/block/sda/trace0 which isn’t there normally. While running the utility,
>> to place something in it, it must have the write permission set.  When exiting out of
>> blktrace, the entry is gone, both on a machine running with secure boot enabled
>> and one with it disabled.  Which also indicates the write permission was set,
>> otherwise the entry would still be there.
>>
>> The fix is simple enough (see attachment) but we are not sure about the semantics of what
>> lockdown has in mind.
>>
>> Looking at the include/linux/security.h the LOCKDOWN_TRACEFS exists which would
>> imply that it is expected that operations with tracefs *should* work with lockdown (integrity mode).
>>
>> But at the same point, debugfs writable attributes are a nono with lockdown.
>>
>> So what is the right way forward?
> What did you use as a basis for your changes?  I'm looking at the
> patch you sent and it appears to be making a change to a
> debugfs_lockdown_whitelisted() function defined in
> fs/debugfs/internal.h which does not exist in Linus' tree.  If I
> search through all of the archives on lore.kernel.org the only hit I
> get is your email, so it seems doubtful it is in a subsystem tree
> which hasn't made its way to Linus yet.
>
> Before we go any further, can you please verify that your issue is
> reproducible on a supported, upstream tree (preferably Linus')?

The patch attached is applied to oracle kernel which is just used to 
demo the idea of a possible fix.

Upstream will have the same issue because blktrace uses relay files from 
debugfs to transfer trace information from kernel to userspace. Those 
relay files are having permission 0400 which are good, but they support 
mmap (struct file_operations relay_file_operations), which are against 
the rule of lock down. Is there any security concern to whitelist these 
files in lockdown mode? Any idea how to fix this for upstream?

static int debugfs_locked_down(struct inode *inode,
                    struct file *filp,
                    const struct file_operations *real_fops)
{
     if ((inode->i_mode & 07777 & ~0444) == 0 &&
         !(filp->f_mode & FMODE_WRITE) &&
         !real_fops->unlocked_ioctl &&
         !real_fops->compat_ioctl &&
         !real_fops->mmap)
         return 0;

     if (security_locked_down(LOCKDOWN_DEBUGFS))
         return -EPERM;

     return 0;
}

Thanks,

Junxiao.

>
