Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D955474B5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjGGReq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjGGReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:34:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA51FE5;
        Fri,  7 Jul 2023 10:34:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367GTXc4005620;
        Fri, 7 Jul 2023 17:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DwwIY1xaUqg4/mPaUbCCoXdST/0r65RVdwtjAXUd0uY=;
 b=0DnXciJdZE2O5Ap8txGs8RXXTt/tBFu/rmCesoBLjShz9uisFak6zR7klZ87zzWzYknP
 Thf7Ig+0zdOivHw9LMi7uTOwKOS4zMyoMyMpLnheTDZLoFBwW230lAVFtj/TKBtSKdB9
 9dTEItgfqe5kPyDEYiaW9H2ptWjDo5nQ44/YmZhpMXO1CLrtu4a7qUPEgXmyb1AzIt0v
 V75rxJe2WGUTcuEfeIoQ4R5fkb3qFPAEIUILNPyBprhvHwN5BcowYHy7PWEydefvymEU
 vqpQClsUDS+hkzTbXZzXzYHdj+IWM7F15k9UuA5WoaXSR//ECUz7EFc0lZqRjx+n6/1l gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpnwbr63q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 17:34:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367GpZZs001653;
        Fri, 7 Jul 2023 17:34:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakeqctm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 17:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvn5+mcV1/lrKeo3l1HeR/gUQMMYQPwyp3xGBXVqOp4ju7jwjQI5KxG+w0x+pcXzVlLD18v4C01GnGahnBavOjZ2qz/tqiudFR4IFqAjK+UtHyTFKp5fik6fS3mepE9b6O6LA8idhCyExg0lcVPd52YZTrrgVpvFUbVcmlPywb4mOHgOZbABzGUMxJtM0AuEopv5suIfr3b0KeQ8yJIjQNIzR7z1e1/u6i53Eeqhov/OwBCH/t8grhzM74JZdE/x3nM0W8qW48jiOEqDEMdklO5skFCXoj03t7hQQb69G/zjTMMFiqWk5YC7o2a5jhYvsJfL7hWK7fulXFfAy/1f+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwwIY1xaUqg4/mPaUbCCoXdST/0r65RVdwtjAXUd0uY=;
 b=L6Yrvd6LTa0Dhbo7vLg5s4v5dLep0YAWcOHxAdwZmE/0k+MeWoCeziI7xhRW0sncKNyJOfydffQODHQEWKdQU7NYKYLI8tVhwvK4VXm1nsTzR6bpYckDjrBKyhz02D+RKD/clRYZuMV21JPUsiK5Y8QklGN8tbYhdP9DyznKxK6vs3zmPIlvoQgON2k5FgUhfjVHU6sIUWgivrwoQ0eNAIG9BMmcetxvOohBFp788MTNCVmP4N5rpVu/TAJ5V3oo4cm8G8/VH+WHiu5EPXB1+os4sBb1OAwbL9fYtrJRjXgjNzs8cGjGaZ6j23SLcDCMI8mFFIY4racW15iHiKFazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwwIY1xaUqg4/mPaUbCCoXdST/0r65RVdwtjAXUd0uY=;
 b=miNdlzDu5tUt+RY6+6an8Aq7v7bR9QfV43boxUgy2b48QHJUcE5mJuRiNibyPuNe74J9nA3+ZJ00SC2JIQU75fBiY6oM3GDpoZGVoy1KDuJd8FZvORLzgNcPx3mCS7+gA5Zib7WOrGdhjzWG30xPw3LVwbYKPPMxWrmrJmqEwbU=
Received: from MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 17:34:02 +0000
Received: from MN2PR10MB4144.namprd10.prod.outlook.com
 ([fe80::d60b:30ae:d017:d039]) by MN2PR10MB4144.namprd10.prod.outlook.com
 ([fe80::d60b:30ae:d017:d039%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 17:34:02 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Eric Dumazet <edumazet@google.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "david@fries.net" <david@fries.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "zbr@ioremap.net" <zbr@ioremap.net>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] netlink: Reverse the patch which removed filtering
Thread-Topic: [PATCH v7 1/6] netlink: Reverse the patch which removed
 filtering
Thread-Index: AQHZrgwbJdPip+eHGUuiOhCNOtaBYa+uYJYAgAA1voA=
Date:   Fri, 7 Jul 2023 17:34:01 +0000
Message-ID: <64A60112-4631-4136-8738-C5D7C08EBF8A@oracle.com>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
 <CANn89iLOGdFBJHe4L2Lk_iaNEvLYG5KYGxF=G9d_Lx9dU8Wv-Q@mail.gmail.com>
In-Reply-To: <CANn89iLOGdFBJHe4L2Lk_iaNEvLYG5KYGxF=G9d_Lx9dU8Wv-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4144:EE_|MW5PR10MB5740:EE_
x-ms-office365-filtering-correlation-id: dabd207c-47e6-4f54-829a-08db7f105aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpMC2bk/x53s2xetAsZ2lZT9WTyVyxYissNPcMiVcwsdK5ZxeHGR+KzSCepUL5PZA1R7kd0SIj46klktg46fIXWRugbKQk0ks72PUjgXReEY29iOIlb7V1hUGNnth20zgDXYanHhIbanBBK3G1l/11wOv9h3TCIDwMm5kCrTeEHViyaxZXNKvPCUtzh39edCnrV4LjKGGb6x3U2p8xw/yF/xy7RJ4CqSnIv7T7G9e5oq33UxZfpZAwIDXxoBER1sYfH+iniSE8s9aEMHsE11Pp0JZKQ+ZCy7+XtfoCk7al6JxZ1O9V6dSR9OfgS462CbTjRkmnHWGL7YczHO99D8amLqWcT1/vKgcy+tcSrv0ugUDjwMjQXGtkXyDSZu0x0PGKnEV29TWhqTRzVKtNpIvgloHq/vq+ZhkkKzFX5pUr7PmaFKOKvb0MLdbWlwrdLnAzxZKdMKPQ6SLrGT2GM1sT0qy4de2BRhFBYutWEwc4xOPgJLfXF0ImztaeI2/sKLz+2FOlNaWLv2LYtYF7MKzoEWyYGwp3Xz/sDm3ti5BK78N1SPj2CuW+DY0VUndoKG+AHrxKvdDluHusLApTlF8wKRR+tneNrFCd8Dlc7Zta5YRUSJ80pGbdTPcg1brjxeiAQUcz3lesem9pEWHH5t9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4144.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(64756008)(41300700001)(4744005)(6512007)(54906003)(86362001)(66476007)(38070700005)(71200400001)(122000001)(6486002)(91956017)(6916009)(66446008)(66556008)(316002)(66946007)(4326008)(33656002)(36756003)(38100700002)(478600001)(8676002)(8936002)(2906002)(2616005)(5660300002)(7416002)(186003)(53546011)(6506007)(26005)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yy9xbUhySGdRNzBWcUdIN2ZqRnFjR3lvN2FHcnRSZDhJNnB4dlFKUGFzSU4z?=
 =?utf-8?B?NUlZNjZXSEd3U1IvWmFFUVBtVXZWRG5raXRxK0lZNUNudS9GbDZkWlpFS05F?=
 =?utf-8?B?TVp6eGVUYmJuVEFzL2hGd3htVS9mRUF4eDloYnZZUUFwcnVMMnNYdzVXYUJZ?=
 =?utf-8?B?a2JGbllpRlZZM2VEREVmUG82bjYwMDNNU09yYVlvK2F1T2hwb2hWa3dMNFJo?=
 =?utf-8?B?MmRHcHowczQrSWlNempSTUZzV1RwQldiQ1FHa0xEOFRiQmx3UFRKam5tbVMz?=
 =?utf-8?B?dWw3ODFGNlh6TWZyVnRHU3hkdndNaVVmbE5LQ1lBMlZmdTNQUWdncEZ4a0px?=
 =?utf-8?B?UzFQdUhiUlZmWU5hbmF3SHhSamlSd3IwZ1I5bWhqS1Q2VWtvdC9PSTg0SG5z?=
 =?utf-8?B?R3dqejgvQzRPeUszM01jd3BzclJBbXdISnlsU2YrV1M0bVVHRVNVMFB1cDF2?=
 =?utf-8?B?YkY5aUlvVEZxd2lSOS9wZ3VTNkp4QlJJYURrRzlkMWc2YUdsTUxTZ0hQOThh?=
 =?utf-8?B?VmpVS3BMcml3eGZ0Vi8rQ0hndUtNOXJwTHBzejRWVXpGUWw1UGhlSzJoTjRv?=
 =?utf-8?B?cUxVc1lWMUtLOU5wRkdicjhNN3A0NGhiVnNYK1phZEpBbHJ2TWdJQ3NSS0Nr?=
 =?utf-8?B?MEd6VHZSUUx6KzBOV2xrWXVJaWdLbVg0eXN2a0g4WDV5NWRlQkpJQk13a0Qz?=
 =?utf-8?B?eTN1aUtXNEtWbDZsWGZ4bGdqMDVkTnpoaEg5b2h5Ly9ZMm1XRWsvVFA0OVgz?=
 =?utf-8?B?TVJtcGo1U1ErcVZ3L291Z0Y3M2MzZUJSaDBKSDhFVVFjYm9qNGlIMm5NUnZD?=
 =?utf-8?B?SnVCUW9EaEIwa2w1WnNRVG02bHJZSkhTZ0RoQy9wMGxaK2Zxb3FxUGtIdnF1?=
 =?utf-8?B?U0puZ0tjU3lYbUNmeUMxQkR4OFRvMWdLRC8xMDlWdjB0bjlzODRlYTZxUnMx?=
 =?utf-8?B?ZmZlbWxlU2ZnUGt1elFxb0FFRVRmWCtPSmJVTXRkRHVGejRUWkd0N1NyV0d5?=
 =?utf-8?B?SEZBRGl6OVZhK1JXSDE4UHRFY0g3VCt4S3JNVlB1ZG4yVDI5Z05qUVNXTXIy?=
 =?utf-8?B?Y1RzenZyaXJJckR0UGxVa25XUlEwM25idVpNQ3FoUzBpRmdDUDVhYUpLSXVM?=
 =?utf-8?B?RGQ3NjJPbEpYQ1o0N2ZPZnVIQ3hTRUNUakRNRzYwbUxwazJhczMzZFpncmxy?=
 =?utf-8?B?NTJ1b2NoUmJjQlFBODQzclpWWWRqckZzVGQyWWZ0TVR1SVRHeFhiSTZsQStY?=
 =?utf-8?B?eThmWWxhWW9XUWRNN21YZWVDZmRsNytYbGljMGJ0YVJBejFzemFJVzROMkNz?=
 =?utf-8?B?NkhPRm9LOTVqd25tRVl3YkFiSm52WjFaZDVLNU94MCtrR2ViTVZCMU9PalFZ?=
 =?utf-8?B?dVlXbE93emVPTjVKTXBRYnB0Mjk1QTFFMEIxbThIYXVuRXlISUVEaEdhYlRp?=
 =?utf-8?B?cWZTMi83emhvRFRiclNpY1l1aDc3b1QvNlFSWlBjSjRDeXA1Uzh1ZVBOc2Y2?=
 =?utf-8?B?VjVJNFdvVmVJc2RvSE1RekVZbE5BdzFMK1Z5NnZnUGN5aVUzK2xCNlRxWlgv?=
 =?utf-8?B?VjF2aFRqNHdtdVpsRVZDN0szVXdDeHkvYzA3aGxHMFNiYVVhdkVwR3pFbFdl?=
 =?utf-8?B?Z1JZVldiMmFyWWFEQmVGOWtQNEo5MVJ5RmJvaTZiT0RBZnNSTDVGTkJ0ZG5S?=
 =?utf-8?B?QlppVmo3TkNBM3VWamFHeUtSTVAwcEhZRHpZWEtOMmUxb2ZaYWJObXVsOXcx?=
 =?utf-8?B?K1RmQ1pFTGVsdkZrUm5PM09kQVM4aWNPRnNrWVlMaTRBa3JIREt3UXJuT3FK?=
 =?utf-8?B?V2xRV1Nvei9rY1h4WXE0eFF4dCtjQXVPR1RxVWs5cHpuUkZNeFQ3SEF3TUo5?=
 =?utf-8?B?WHE3VlB0NlhMa3o1UkhGaERKVG9iWFlCbUNEU0NtS3p1aElGK2VXeHFhaENL?=
 =?utf-8?B?a0lBZ1gwS1FmRHNLa1hSR1c4WVN6L2JNWGVrVjQ1dkZvc3dTditoMnkrM1BO?=
 =?utf-8?B?Uld3SzlxcVhEQmNJa3V2cXlYZWFLTTA0OG1OcnlIVWROV1hIWVJkRmtnRmEr?=
 =?utf-8?B?U2o0Zi9RaFF0MXV2bjBiNU4xMnVoVmNEQUtxeUg2NEdvejJiMnFKYWVSbkhv?=
 =?utf-8?B?YjJ2UUxGK3I4bFp5MjM4ektIdXJlNFEwZ1Y2b2JnMmRDdm1BbW0rQmVWQUxj?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0187D7DD55BCCE4393FD31D490D12F65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEhERTQ5YWdGcmtJQlI1SzJuSXJIdnhOcGpNZmhKYklSMk5KNVE3NDZnb09z?=
 =?utf-8?B?WGVic3FJaUViY3BlVXpBb2tHZlRmZE5pZG94b04wU2p2RThVMUhNVnAwRnd0?=
 =?utf-8?B?aDlrcmQydlVzRFM4dDltZ3czWTFKVDg3MGNLTlQxdVNYMlZNRnNIT0ZpWlVN?=
 =?utf-8?B?Z3RadFhiVVRTNjlKWVpGZTNjNGg3a1JXRGo5U0FRa3RIN01nbFFhRTEwa0Y5?=
 =?utf-8?B?cm1CaVh5Vnd4VndWSTFnam5DTzNRd0U5dFdXWUJtMnBHajUxZzQ0QjVOL3BN?=
 =?utf-8?B?NFFETWJ5UHR6a3lrL1FzS29tQ0JDQm5JTGc3enlhMWMvRnd6UkNNVllDbDNI?=
 =?utf-8?B?VSthVlF5ZHZ6RExwbkhjdHY1NTBobE9DR0hrSHZSQ3R3ZGU2WlQ2M3hBMGRJ?=
 =?utf-8?B?cVpBREErcDVIaXdsT0VPVXltQ1VtNSt2K1Q5VHBsRlBFTEtLODNxZ0h3czhS?=
 =?utf-8?B?TlhDcTN0SWhzUGVUNTRNTmwzNkcyRURxZ0p3K0J2RGpQbTEybzFaa0NObzh2?=
 =?utf-8?B?WlRTUlc2QUZHSDJrdUpQMElSaFJxaVNYblRWMTMvWDUrZnViYTE2eTVLRHBt?=
 =?utf-8?B?ZDh1MVVlVlV6MkZKVU15ZERnR2tIRGY3Zm0yNTVmQWRGc2V1WXhWMloxdzNt?=
 =?utf-8?B?R2pyNW1TQTA1OEVQQ3UvTzUyUmxYWjhnMjN0b1h3OFRnb1k2TWl1SitsNGlK?=
 =?utf-8?B?cXgzNUxlem1QZ3N6OHdUU0ZHd1V4M1BTMmxxQkJDNnlRWVVmaTJpcEdBUUYr?=
 =?utf-8?B?cEhWaldTdCtOU1dZZlZhNEs3NWJsL2FsV2VFa2xFNmxCS2hMeFRoT0RYYk1P?=
 =?utf-8?B?WS9GdmdvdFcwZFNpaWhxZHh0cWk5MTJUT0lWN2d2TVpqNG1tRjlFc3VHMEpE?=
 =?utf-8?B?dXNOM004SVRjTHRuQk5saThhSGtndnB2eDNHNjVBbVExM05IQjZaUlQrb3Ax?=
 =?utf-8?B?WXFKRG5aV3JWem54WDMwK09Oakh3U1hZUjdEN1NpbXhBb1J0NWJHSGR3NUh0?=
 =?utf-8?B?WGJLVVZBOVlsaHBkcTJ0YkhmZVhORXg4K2Qybk5taUlCTnFTZFB6R0tscTlV?=
 =?utf-8?B?eHJRVTQ4UnhnZ1E3Z0NZWlZwSEtVK2E4OUplOWZOajNJelRrWngyV1R0YTRX?=
 =?utf-8?B?WmtISWl5Ymw2aG9ITHhKU3hJbSs1UXN6Vnd4bnVhNW5CTjAxQytSNlFSbENB?=
 =?utf-8?B?UTc4dmZURDY5U0hFWHRXWWpQOGI0TjJyd2FxRklNbFE2YzM1WUdNT3ZEUFZs?=
 =?utf-8?B?WGhzRjdsY0U1K0tyVWhnaytYV1dFYVJXNjVyVDd0STVyanBNNWY0QS9lR0pn?=
 =?utf-8?B?KytuZ3B0Qk9BM1FsRDZpS3licnFIMmhYTlh0MXdtenhDUmNSVzBIZ09RZ01J?=
 =?utf-8?B?T01xbzc0VGthM2QyNzNCQzZ6M1dOZkU3MWYwOW1xejJmNGtGKzByTXUwaFMy?=
 =?utf-8?B?bjZPclpJTmFqYnloV3hHbGJjckhRZ05sd3NHQnpHcEtDcUM5VXFVNm5EdDB2?=
 =?utf-8?Q?YPpYJA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4144.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabd207c-47e6-4f54-829a-08db7f105aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 17:34:02.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VITTj7BislkHgUCtSJdZGv9kmufmmmtOampxLVBQMHSq9/6LlsUgpvOxekYceLWghztvbWsbfVmIovAgkpeDGilSGexwysT6QlU67ofUKgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=822 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070163
X-Proofpoint-ORIG-GUID: LQcdS6tmElPTpKf3fb6rLWIdAQqzZpqF
X-Proofpoint-GUID: LQcdS6tmElPTpKf3fb6rLWIdAQqzZpqF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDcsIDIwMjMsIGF0IDc6MjEgQU0sIEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRA
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEp1bCA0LCAyMDIzIGF0IDI6MTHigK9B
TSBBbmphbGkgS3Vsa2FybmkNCj4gPGFuamFsaS5rLmt1bGthcm5pQG9yYWNsZS5jb20+IHdyb3Rl
Og0KPj4gDQo+PiBUbyB1c2UgZmlsdGVyaW5nIGF0IHRoZSBjb25uZWN0b3IgJiBjbl9wcm9jIGxh
eWVycywgd2UgbmVlZCB0byBlbmFibGUNCj4+IGZpbHRlcmluZyBpbiB0aGUgbmV0bGluayBsYXll
ci4gVGhpcyByZXZlcnNlcyB0aGUgcGF0Y2ggd2hpY2ggcmVtb3ZlZA0KPj4gbmV0bGluayBmaWx0
ZXJpbmcuDQo+PiANCj4gDQo+ICIgdGhlIHBhdGNoIHdoaWNoIHJlbW92ZWQgbmV0bGluayBmaWx0
ZXJpbmcuIiBpcyB2YWd1ZS4uLg0KPiANCj4gQ29udmVudGlvbiBpcyB0byBuYW1lIHRoZSByZXZl
cnRlZCBjb21taXQgd2l0aCBzaGExICgidGl0bGUiKSwNCj4gdG8gZWFzZSByZXZpZXdlciB3b3Jr
IDspDQoNClRoYW5rcyBFcmljLCB3aWxsIGFkZCB0aGlzIGluIHY4Lg0KDQo=
