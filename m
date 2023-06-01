Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB171EE5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjFAQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFAQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:12:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AB134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:11:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351E46tt030617;
        Thu, 1 Jun 2023 16:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RtwBzr/iKfHvXce0VIFmH/gyvi3nig12Zy8/f1O36eE=;
 b=0dGP5EVFvyvddaZfV/0Tqi64+mSfPXYlRECgkubqUG8bPP6P3W4bPkWvHiVwxDiTQhQY
 sy/rXV34qev0E040abk7/4fJp7WCvg37B2vUbjUa9U2spPfAABKQVnhJ3I+r7SeaV1U8
 rq90qeJB7A2FxX4IgMD26GqYma0d27zdoINLWNf7k8jJg87o3DPzO3BF+wO+5DHOfgeh
 9rKorJdVEHyRylltKBP1VpMkwL0ZRpUGDCWDxbBu+B0qPG1DoP4gJwoxWmkvlz1+hLEC
 1s3/0OrO7t2ex6QGFfk2gvQQ//SZ/FFBYccNHr8jMKqrydHx6olhBb5dl4CJX6W/RYE0 aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmes5uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 16:10:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 351FTCXV014719;
        Thu, 1 Jun 2023 16:10:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a7dd4u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 16:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irJ8DgGiZ1L++iJQM2I81UlQmPskONxIo3tPLoDLbY457zuWWszsgxrxYyg1gBUE+K8xcWrR6MAreVYMfcZHrz/PajoolvDn0Y68MxSiEW7dwVtMw4jgiOqibGBhHfViKLZtxOj3x0YWEIXMhgb/06im0XFKSjqeyKtnXSIGkfc2xYHPw37C9ahupPjQbNWfV29ilsslmTlIiZ7I3be+VjnQaPMxBiE/XBkPfX/nusXm9NVX83/W0iWlxDx6GixIuLrH8UqCk+v79KA+Je9L2xMGljeJqzRS0URwHWalbrRH/oT/3NfCT6/d6kVY03UwrS85oonmpcPyCwQCPCI34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtwBzr/iKfHvXce0VIFmH/gyvi3nig12Zy8/f1O36eE=;
 b=HT2m+0NMdkqHnpLqHAghsvX2y0uns+OworfTg7r/EnEfWumgv1xOygmjXbV3bUsDQ2AQSjTtexEtAwHwe2gPdZtL1DZrIPZQMSQuL56XApAY3se77xCCl76mJWG/vKCaLIwZwz+vRnH034Oo0T745yTRcVqH8O/6NEDjHpOpy9SqaMlPmFw3OCl0PcnzTM7Xud9IpzzuAKSDbMd798V0m9jv9MWiyGX1dMuIETVyCVDXo2dvKw1PkUR9kKBxA3uhFzEjpUXi3zjUEk1+9ozaHvbJMRhFIDVSvyeBdJnNIYYuLIIRdd+3PBuA54lLmKkPPf74NYiXkUSUxVVOchht4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtwBzr/iKfHvXce0VIFmH/gyvi3nig12Zy8/f1O36eE=;
 b=S33QLx9jxi8uefn/mWjjjDIC4zvnG0iafoSk8uQ/wrFBqA35aB63kaBks3NM6wkKaELGdIlk+IlLyZlSXKYe9zA0YPvldUsTg75/d61RB7stoU66mR9bk1uOS5BCouy+X5nFw1m2dqRyEmOiCp7drMJlEkTwU8jTo0TGpcjR+rE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 16:10:54 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 16:10:54 +0000
Message-ID: <2ccdf297-0998-d1a8-5a66-0abdc6e37c1b@oracle.com>
Date:   Thu, 1 Jun 2023 11:10:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     oleg@redhat.com, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, konrad.wilk@oracle.com
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
 <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
 <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ0PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4373a65b-c45b-48b2-94ad-08db62bac68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlcxUm+IKOZARjc8PZydaHAJYeXQ72y+MFDNfBLYBfoEpbqtT3rZcBBVeILXrUsRIEuiMAcpv+S+CdW8+G/1wAUAEalQROH9yMdyoJm8PS5N29mjZYfDSNWt3YTXKkVb1yYkFc7GHdRnr2KDX+RgVNE9jzMLoKRzBaDzxXurMI5WIGi/f5pC0+JdzGZ/4xlssoGBQ0oQSbXt3vupzmtfPS0SAurlR4HK6+wikzyDFZiIS5Wea4NMrSsdwXKySgxmwFCeSFoxOJVO8ZQ8pvdPg7hghlcUW9cc7dbppF0AbuhqCGy7yqEX4enAN+UArX7m93QIoyQ0YjSU01ZK3k5MPXvtj9dgirhZ5ulYj5JW2ZpEqmzZOVEkPbaQZolgAK41wzGsukj2IHHWgeTlHTv8mv3pMGYWzyXeGHIcV1akVqcUTfyFNGIztPjQk+k73rI8W38/sgfdRIj5eHDfH1Ze8HVLs4ugSCO7fWWV2+hhtx7k2DrnncG81+9wxX8tKwlHpLHWMdiHCFbinBeXbVBpmtweW8HqWw3t7KazkShM23nyCywGzD5ICfMP+iPJPNqir95HA6knRJycIsSnixCKRAcyBi5nW5yIn6ystyoSTqboSWBQ3IsNgtx145pGRLGdZMTKyadgRGUL3K6HIMzR6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(478600001)(8936002)(110136005)(4326008)(41300700001)(8676002)(86362001)(5660300002)(6666004)(6486002)(316002)(66946007)(7416002)(107886003)(31686004)(53546011)(66476007)(6512007)(6506007)(66556008)(26005)(31696002)(186003)(83380400001)(2906002)(2616005)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdSU2FhWU85dzJVZnNtWEc5U3E1N29vemh1UWhMMWs0Y0ZOMEJQQ1V1QURq?=
 =?utf-8?B?MFdpaFAxaXE4NGJOcnAzNVhJTHRwUy9hWmtmSGVkN1pSdFovRysvcGRHek5Y?=
 =?utf-8?B?SWtSakpDaVpDckZ2bXNPemJkWkxvSHI1bEF3WXVmT3RXdk9NL1NRZW1Kd21q?=
 =?utf-8?B?R1NBQzg3Tm1aSUpyRUtNUm8vQUluei9RZkdpNmlTRFgvS2lldldKSWxKTGYw?=
 =?utf-8?B?Yy9jUEcxaWsyNFI2MnZ6dHBsdVVld2tja2pyNlVKOGRpZ1k1UTl4VnNCL3cx?=
 =?utf-8?B?SE1kNDdnZjVoTmYrd1U5eFJURERDUnhkMG9oekVNc3o4N3BiV2RLTWEvM3E1?=
 =?utf-8?B?RkswOXdDUndzang1d0lnTmI0dS9TL0tGWEViZ0dVb1NlWklXU1JCTUluYjcy?=
 =?utf-8?B?R3hpQno2VVdSbkpkd1QxSTk2anF1bFZVMDB6RzAvTEJKNnVXY3JuNk5WZzZQ?=
 =?utf-8?B?RjQwa3BTbGhvT2pxY296cDNTT2lLb0dPcVVrL1ZSTXdNNEdsUTRXdTlzL0VK?=
 =?utf-8?B?T3JKSkl5WDBKSkpMeXZyWGlNZ3hvTnczeUl1SFk5VFFBLyt2ZkhIRVowRDh2?=
 =?utf-8?B?d1lraVZDNFBkOFpxdTh5emJCbmJBQ1RpR2RORWVkRW1NY3prcmRBYkhST3Yy?=
 =?utf-8?B?YS9WQkdKc1BQMnU1aW9VN29rMmVpRDk0aHk1L2F1Y1JsOWJLNTdpT0RiTmhM?=
 =?utf-8?B?NHZ3MEtyRnQ0elVwTEF5MVZNZGFBeDIvL2NZeEdmc1FOQkt5UlFzUVIxWHJC?=
 =?utf-8?B?TmpiSUlVOG0zVjZpMTJpQzVTTTY1bVErNWJsSEtHaHRic1MrcU5aVG1YTzls?=
 =?utf-8?B?Yy9ldTNGWEdXZkFpM2ROQTU5UU4rS3kySlU4blV6amlIVXdpakRjaW5nSGdK?=
 =?utf-8?B?cGszTnJTcnV3UDRQdXBLU1c4V25sdVRaQ0hlK01uZVNlaC9UckJIVFBqdzg0?=
 =?utf-8?B?TGExUG9vbEY4dGFMb3B6OWk4R2IyOEtVV3k4a085Z2xDY0dudWM2QlduM2pM?=
 =?utf-8?B?ZG5qL2pNRm1YRTlOQ3JxNVpvNmNiNWdEdngxRkFJVmJRVXFFRk51UVNZZEE4?=
 =?utf-8?B?N3pUeTJFMFBxVjYxSEtzZWZhQ09JcmEyU0dJY1ZiWTdqM0RNd0U2cjNqQ3Ux?=
 =?utf-8?B?VU52MHFIaml3SnZkRXBlVGFjM1hsUjRvY3hSbU1iTlllR0RYZkcwcG5oeHBX?=
 =?utf-8?B?Qk1ZbnZPemVQSmI4VUhNRXh2ZE1vM1NEN3F3ZTdSZkJLbU5LTzZpb0NTanIw?=
 =?utf-8?B?MmJwV01xVzZHb08yekU5TnJ3TEFDZVpvaEJaUUNYYnpxZ2ZsWkhjNWNqd2pJ?=
 =?utf-8?B?Vm5MWmQyL1o0MnVzUVRNSk5KZ2FVbERsRmhwdkM3N3RXemE0Z1EwRExIYnMw?=
 =?utf-8?B?U0laUWp2V1VxZU5pOHJZOEJHT2JKd1E0dDhyb0ZBUExMYnMrZDE0R2duMFU2?=
 =?utf-8?B?emVFV2xhcmw0b0xIa2FiSDJlSHRDQjA2Q2tzNDVOdlFtMTV1K1c1SGNPY3A4?=
 =?utf-8?B?Mm1oTWhQbm5wNDBReFNpU25iWU90LzdmRTV1bHBKdVE1R0RVd1RldG84M2Uy?=
 =?utf-8?B?RlMwbE1UWkI0R01Ndm5TSkNCZFFlMmVhQlZ6dTY4ejU3c0RNbE9EZ2NNYm1R?=
 =?utf-8?B?WEt4NkMxREdwdjZXdTA4VkxWcXJEUUFVbk4ySEhIeHhCbHYwdldZSHNrLzJQ?=
 =?utf-8?B?NURNK1NSTVNCdStsWlQ0ZW1FdlRNSUNrUDJxemRJdGNMUHdJWmNMTnAyek9E?=
 =?utf-8?B?QllxR1BjNERqRDh1RG5ZR2NxamU4TmZIVEdXR3BPQVNYemdhT1BxanNBc2s1?=
 =?utf-8?B?M1doNHJVd21jd0l4b2NnNjNsekxIaGU4ZGZoTVhwQ0hlc2sxZ056Tzg0V0pB?=
 =?utf-8?B?Q1ZsWEVocWI3UEhqSWN1Qnh1ZUlxRUo1WDR4cUdDM0E2dWRYaXF3ZTZ2d3pR?=
 =?utf-8?B?UE1HSWVtamRHNVUxSHJMYlAzemtVUC82QnVPZmV1aW1TWEZKSlZQeTI5cll5?=
 =?utf-8?B?VThpWndYc09mb1FlRUtjV2pKWVZ2cmRMTysvYXpzWkdtRzBOdkVKM2FOYUNO?=
 =?utf-8?B?aXE3VUVoOXVCeHJEZHVkM1ZqNTlqaG9YeWhBNnRJd0Q5bkZ5WUNZbWJyNC9S?=
 =?utf-8?B?OXpVWXNQMnAxMlNaczVOWEcvcEdjd2pDNTVCWUJvMDAwZGFSYTNWUWZBdE1F?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dWlWZ0ZlT1E0d0FLZWY2RDMyVm5Rd3V2UWVrTjhvL3dPUDc3a2lXNmgrSXVL?=
 =?utf-8?B?M0VrKzV2WnZLd1NNM3JSWTB5cU0xcUJWK1ZKR3RQZlFpZytRb0ViOFRtc3Vy?=
 =?utf-8?B?bHRoNFRsbi9Zb3JBWkM0YzVHMXlscjdPTkpDVVJzbmpQQTcvVHF2OHRIM1RW?=
 =?utf-8?B?Y3MzbTFiRS9IemxpRjJ3WEl1WFZvZENjRFlrcjlDN2h0TERQVlNGak1PS3gw?=
 =?utf-8?B?MkQrR0QvTzNiQnF0cjAvRTd0WUw4T3d4ajFtWkx6djR5MXJLVlUrYVIrd2VK?=
 =?utf-8?B?V2h2bU9mMm5XY2FPMmpxdVh0M0dzMnBNN3VzR0VRYk11MXlRdEFKejY0V2lz?=
 =?utf-8?B?YkowcGMzMVBJOGI3ODVWVFdpc2ZYaC9pMWp3YzFsT01uTTRiSEFJS0xBR1pZ?=
 =?utf-8?B?TEh5RUNMUFEySUM0N0RhcUFRV05nSk02b1JJd25lSFNpbmNlUmJsRStJWXg1?=
 =?utf-8?B?eTY4ZE9YT0lGaG9Cd2RUV3hvV2YvYlpuc0ZLSGY2SEplcnJwSGpHZ0d6L0xn?=
 =?utf-8?B?RmsyRmpjN0h6WWNoS0J0S3ZMS1l6Slpackx4a0c1VHMwYnlMU1hOWEdxWUU4?=
 =?utf-8?B?NmozdVpndVprMGNUUkJEcWZ3UVJEdHcraWhhaitrN2lIWTVrTDVScjU1TldR?=
 =?utf-8?B?WmNWb0JLNHRMVDU0WFBGNGJNalZMclpjKzhzdmJKWEg0K2ZqQkYwNWFVMjVP?=
 =?utf-8?B?RGtxQ3dRalhMSzlnVHE5aUZIaWV6dlRIbGttREdGeVlqOHVwbnNDK05YSE11?=
 =?utf-8?B?SWlnb3JJTG5MNVFrdjhoVUNsOHdHb2QyQTVURFZnSVUrRmxON3hGUFE5ek1k?=
 =?utf-8?B?QUcxd2tQVEFtbThwTHJsN2JWRFFjTUpMR2NDSG9DekJtS0k1QngrK1EzcHFS?=
 =?utf-8?B?OEY0L3FLSFBkL0JackN0UU5mY2FHUjhtYUxpdjBNTnVMOU1lTURJcDVDWkQ3?=
 =?utf-8?B?MEdiN05KZjFqdmZxYXlQaVh4MUVpQXlFV00zKzEwdjFmN1huQUVjQjhqZTlT?=
 =?utf-8?B?VWtnM1pjaEhBeG9sTWZ3NXBpcGNIWGJUY0ZhMmxGN0lwOTlPeHpBdnhaS01I?=
 =?utf-8?B?dStVYjdhZmJVWW1YSndXQUJUb0ZselJRdVNDaUxTODRRQldHQUhiT1U4QTQy?=
 =?utf-8?B?UEVtWHFtVk1wNjVsbjVWaDZ6dXhKRG04aXQxMTAvbVprZVhxWER3dHRxb280?=
 =?utf-8?B?ZUxjcEwyREx6ell5ZVBZSzZ2aFZ0V25NQWRyVnlXY0ZzQ05YSjlVa0djQUxH?=
 =?utf-8?B?T2NxRS82OTBlMGVDU0ZkMys3d2NSY3YrYVcxdXB0QXh6TzNzcjZtM25NYXgx?=
 =?utf-8?B?NDdmdHowYmtybVhPMlFUMm12c2RFVS8wWDdueGc5SVFBcTZ5Rnd1cnJjNWd5?=
 =?utf-8?B?QUJpYW1JOHlFL29MaU1TVkRob2QxMmpCSlhtcE1UTmFQWTFkR0NHNDdydm5R?=
 =?utf-8?B?bkxZajJ5Z1NadWJNWXA3NVhyNWQxaVYwWFpUNXZqQ1lxelNmVVoyNnpuUU5i?=
 =?utf-8?B?ejRUT0ZPZ0sxUk9GcnJtcWlJR0VpcWFQVDZuaW50aTFPTFY2cUlsYUR3RVdY?=
 =?utf-8?B?WXhhQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4373a65b-c45b-48b2-94ad-08db62bac68f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 16:10:53.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3cpzMdj5lJ/IJDarrBDoAL0hKFO8yYB6u3a+rTKLaG4vH1L1mp+/L885MQLd7qC42p8AnHjQIpyEItUs+cFedkURFWp630Wjk3vwhWAN14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010140
X-Proofpoint-ORIG-GUID: hS4XglQpkapDkPyPNgFGuML9ritvmoIs
X-Proofpoint-GUID: hS4XglQpkapDkPyPNgFGuML9ritvmoIs
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 5:47 AM, Christian Brauner wrote:
> On Thu, Jun 01, 2023 at 09:58:38AM +0200, Thorsten Leemhuis wrote:
>> On 19.05.23 14:15, Christian Brauner wrote:
>>> On Thu, May 18, 2023 at 10:25:11AM +0200, Christian Brauner wrote:
>>>> On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
>>>>> This patch allows the vhost and vhost_task code to use CLONE_THREAD,
>>>>> CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
>>>>> normal testing, haven't coverted vsock and vdpa, and I know you guys
>>>>> will not like the first patch. However, I think it better shows what
>>>> Just to summarize the core idea behind my proposal is that no signal
>>>> handling changes are needed unless there's a bug in the current way
>>>> io_uring workers already work. All that should be needed is
>>>> s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.
>> [...]
>>>> So it feels like this should be achievable by adding a callback to
>>>> struct vhost_worker that get's called when vhost_worker() gets SIGKILL
>>>> and that all the users of vhost workers are forced to implement.
>>>>
>>>> Yes, it is more work but I think that's the right thing to do and not to
>>>> complicate our signal handling.
>>>>
>>>> Worst case if this can't be done fast enough we'll have to revert the
>>>> vhost parts. I think the user worker parts are mostly sane and are
>>> As mentioned, if we can't settle this cleanly before -rc4 we should
>>> revert the vhost parts unless Linus wants to have it earlier.
>> Meanwhile -rc5 is just a few days away and there are still a lot of
>> discussions in the patch-set proposed to address the issues[1]. Which is
>> kinda great (albeit also why I haven't given it a spin yet), but on the
>> other hand makes we wonder:
> You might've missed it in the thread but it seems everyone is currently
> operating under the assumption that the preferred way is to fix this is
> rather than revert. See the mail in [1]:
> 
> "So I'd really like to finish this. Even if we end up with a hack or
> two in signal handling that we can hopefully fix up later by having
> vhost fix up some of its current assumptions."
> 
> which is why no revert was send for -rc4. And there's a temporary fix we
> seem to have converged on.
> 
> @Mike, do you want to prepare an updated version of the temporary fix.
> If @Linus prefers to just apply it directly he can just grab it from the
> list rather than delaying it. Make sure to grab a Co-developed-by line
> on this, @Mike.

Yes, I'll send it within a couple hours.
