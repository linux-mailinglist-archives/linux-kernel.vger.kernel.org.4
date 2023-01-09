Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097D662B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAIQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjAIQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:40:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20C1869E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:40:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309GLcmS026767;
        Mon, 9 Jan 2023 16:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zg5U0/2H9sgc7uA86VCayRY4sUzxrH67qaJ/a188P8s=;
 b=sLAewatjz2jZEiBy0lf/kutqpgWuJKyPPqxc62vkruB3pN3IHbkU1pkIm3iUjPEMbTyI
 X30K/7QSLi9DoGPjkPXUWlCVajZMK+r1vdm2ROeJoaRHuSQQX8nwsJCfhbUpq3vbXnBq
 P3eaL1PkyDjxQ23KM90daDcg3+/K8m4gib8u+MGO8S9kLYtWZjR2KP1AY8qlKBaGpLVC
 mJmddL/gupJJ3Cy5x65Vx+FMWaHPQzEB/oR9rVLnSJyTL/6zfeBWUsy+chvIhgxTemlB
 XNYxba59144on5dpWVBtqMVgWH12HT4aikIohKqmZRth0ReRSQWjOm5LSI8K/iKKXHkE sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mycxbakby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:38:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309FgbeV017505;
        Mon, 9 Jan 2023 16:38:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6af2rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqAnEnR+ZBnuVVLdqYQkHGHxv9hdpZsm6KrfgYPd1quSzF6sP/rshGh/1RM20ydEhSAkXfa6NP8WYWmhsyqdBHn1AOqJeVcSrSJppgbd63HcyZNSlMrjt2+cczCju6KR0kdEyrX1wqtSwfhzh60UQ86IcQ7oNO0qJywZa1tFZZMDr063zY1b1ibHObYE9ejg3bVZ+u+eZg57FtyFpEko73zsn6NxgfPedZMmozN3cRparXAmBfHUYEod5ClLHKzwIcUi3h9Tel0D5tfKi1s1gkipWkZ48PUGwE9Hb1jA+lbnjVKAsPDF3j1o7eOsrJaENntqvTM4a/D9MHxsX7/05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg5U0/2H9sgc7uA86VCayRY4sUzxrH67qaJ/a188P8s=;
 b=YTNdcXftViawZW62IPYTAmKs/y9zGp1MVUFoBm59X3UE7vIjBob5XavMl6A+/jHjT7xrvQUwYUcS5DCaEZ5WcJ4vmMqExTWp1Nar5+NZUXiX3thyTOt7AhAqFQRjrpM7L3ZOPSkMIGRkOunq4yAVJMS4xM75hZCKTooibRqFHalgwJQppLdSzMjtAD78Qsxtf7wsemTmtRiEpjTshQ3vm2bTKc5bfgOgpemO6U8WLe71DcPWzDagz1JyNAzjUBFGaOB/I4ceSBs92xHqltzILEchFNC+JrNcV0DejNPslOkrbG1dP/u6BIHe8bmCJ9vajJy55Igzix3Ligsp+Tt98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg5U0/2H9sgc7uA86VCayRY4sUzxrH67qaJ/a188P8s=;
 b=FqeTDIcLKMw58fVNGU/mxcN8Qgc/I+M33N23p1pRwpipyQuO0ZsmOdU+FcNmYzvWT733Bu27mCfk39yhZg7W94IGNC7BzYUoksABESVnEsolWDXNLim+GP5+h8PqkX5MVawblnvDPzho+qUoiJL9gULK0iJJeHSQgPOIyjkHo8M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 16:38:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 16:38:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 06/44] mm/mmap: convert brk to use vma iterator
Thread-Topic: [PATCH v2 06/44] mm/mmap: convert brk to use vma iterator
Thread-Index: AQHZIToh2YIFO4Pea0W8K6URlm/Qaa6WNm4AgAAYlYA=
Date:   Mon, 9 Jan 2023 16:38:10 +0000
Message-ID: <20230109163759.6dwusx6ellqumh4a@revolver>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
 <20230105191517.3099082-7-Liam.Howlett@oracle.com>
 <Y7wsE3wiD2FBJoaz@vernon-pc>
In-Reply-To: <Y7wsE3wiD2FBJoaz@vernon-pc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB7419:EE_
x-ms-office365-filtering-correlation-id: 43308756-be8e-4296-3a45-08daf25fe4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9tD5xeXjaaF6tdJVXuH2sYayjeowZts110W+llwpjM6n+xiGqlLtLliUrPieoPx3fwvEhIbMaahdurypvLvd0X2ogksGHcIYxtNodhV4Mv1pT2mYx5xmcAjY/g4aI3JC0heHmVNg6vKpSQjrZ/uCFyJp+KWyt+EuLUmWNRlUPBVQ1PsWKOktraILmIR8PTGcScLUPZExUXMauGs6IIVEdmHXKLStIIIPUXCsmG0aVACUoW2HdPmasxWat57F9nrfa35pni6eBiLM4B1Vq/6lf1tI5xzngtchK2OnpJsht/hQELMdffIObgB4fEio5G0/vJQN/HyH4BQZFU4f+swyLATRaORhEsXeVUGs9vyhyPYLTQ7dO8LxCNus3OU0c/Cy5o8JsUzsIOHBzRwjh8URlVwXeoNH23VZvKXkOS2tnbgZLjE+/GfObP5Q/vcaJ+WdGSFg+Vhb4E6KznlFS4Sf9h3bri7LTwj0jlAYdgPafHe2DnLv29Re6wkwwtavirDTAr2SobHIRsjDuRvFaad3MkfDbWwRPnzpueot2P4Y/OGsoSSRwMM6OP4WcGfm8v2lzzmqfEMXHjb0n0c1r0GWOFvK5WOoFuxrF2THnSckRRfiO0iqJEy8PHHFj6B41qNqlfUXqV5XjF6S4kzf0XIR7zIt/ZsJy95/9UBeyn3ENMWjLKKkiMiI+6RzRrNoyPOFXInDHAIryNOGjtfM9wMow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(38070700005)(86362001)(2906002)(76116006)(66556008)(8936002)(6916009)(66476007)(66946007)(66446008)(64756008)(4326008)(44832011)(5660300002)(8676002)(122000001)(83380400001)(38100700002)(478600001)(71200400001)(6486002)(54906003)(91956017)(316002)(33716001)(41300700001)(1076003)(26005)(6512007)(9686003)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEhNbFI5aE5DY2thVWtWNkdTcDJKV0ZSdVluUjdlR2tNb09GbXRvMUZjRXVu?=
 =?utf-8?B?Rk9VSXl2R1B6bVhEZDhYNDB2cFhEa1dSQnFNV3RiSlhBUE5zZzZoa0Q5K3Y5?=
 =?utf-8?B?b0FlMUJaKzRjcFRqUWtBYlgrZHFOTlRTRE5STEUvVHpBeVRBcGNUZ2kxTHZl?=
 =?utf-8?B?UWE2TDZwelZ4endkSnNLSkNsMHI0U0xKNEM2bTZRMExUdVJxUWdpOFQrVVZU?=
 =?utf-8?B?YTZYM01YUzF0cUR1ZnpaemYva3FYUVJIamNRNmNuTEFrdERReEQ2Z1JjR2lG?=
 =?utf-8?B?aHdmRmNoeHhsZUc3bnU0WC8xcWFsWmcvbVlLREZWcVRhN0pBOWpOcE8zenV4?=
 =?utf-8?B?M1l3RWtuNjR4MVJKTXQxbW5OOFZZcWxDTVJNTWgveUJKWXZDNHR3QXFMeWE1?=
 =?utf-8?B?dE5ESDIwY2c0K004bC85ZGZNYjk2OXhxVThQU3A0UXlDWlFDdDdPSCtLTTZw?=
 =?utf-8?B?WU5WclJEYUdSNVM5ZmRNcUV6czdscmpwM1ZQZENPNDlRbkhvdk1CK0ZiUktC?=
 =?utf-8?B?SWx5bEU1dzgvZnAzUHhDRmprYUJ0UnpORE00MHN6bm9oc055MVBwdS8xbHFO?=
 =?utf-8?B?UG5ZS1VlZkJPei9saFNTQmpQSHZOTFh4a0tBTVpMZlR6TjJmR1RHUWxNN0gr?=
 =?utf-8?B?VkdWOHhCcXQ3Z0tRQ1BnU1dMQVVRN29jRktHV3J3cGJUNG1qUGMvcUs0Yk5a?=
 =?utf-8?B?ODVyM1JmcjU5M2pzcThvaFM0Z1hnRnA0RWNaeTYrTVFxV3VxQWcyTVAwTGtF?=
 =?utf-8?B?Zy8xZjhUaWRoemJFMlF4d1A4UUFEbE5PRU9hT0o0NGhIYldBelI5cE1IejJh?=
 =?utf-8?B?aHZ3TDhlQVJFYlhXVU9iWkY5WC91bFhEQ0lGc0JMZExMNWJkUXZQUnJXNGpQ?=
 =?utf-8?B?SmRBNkdoMzkwNUJNS0pjbEwwYzJtTmdmMFhVVXUrNlRjT1R0M2hlOXZGdkVU?=
 =?utf-8?B?VHpaVTRoQW5laEVVNFQvREhRc2E1VHBkOUdJQ3hUYXMrbjBNRDVGMGVXQzY1?=
 =?utf-8?B?dERab1hKRmt4MDVaSnJGNG9hdWEvc3o1cFFjZ1VJRmdTOW0vVEk3cHF5TG56?=
 =?utf-8?B?dFErTzh0MkJFbm4wbEJLWEhaYTlrN2NuUWR2NUVSWHpqaEMrRTJBeS9VQUJY?=
 =?utf-8?B?blhsSkJKbzJIMU94ZGh6SjQ3YXRrSk9HZHBob0lNbVpiQVBIaVpjaktBQXN1?=
 =?utf-8?B?ektid25UTW5UV2czbTZLWGpVM21XcWxyMldyZ21FN1YxZjZBWWdmNE5sdjk4?=
 =?utf-8?B?c2ExS1F0bUlkdzJSQkJEYUxGNVJLbWNtclpkRFVwWjJ2czdWUmw1ZVAwb2JW?=
 =?utf-8?B?dFpkUVdHM0FQVzM0eGswRUR2bHg0SnFIMXo1QVNIc0gwbjdSaGluQlZVdHEw?=
 =?utf-8?B?R1JML1ErUFF0UXF0NEU2WVhuYkk0YXBuQ2dTVWhDYlBzUXJoVXExSHpGR1BT?=
 =?utf-8?B?KzFZNCtDbG96TjFlNVJQUjhxdUpSK0piNVdEVHA2Zlo5WUVndVZGZXhyRWt4?=
 =?utf-8?B?MVFmK3dtMVliaG96b25uMGMrOWZHd3FSVFVRckoxbWNhNE5HeTFZa1Q2RVVY?=
 =?utf-8?B?SW5lNFJQSkNZeUNpRTlpZE9VV2pQSWk1L3VzYmlKNGdSZFV1V0VDOGJnVEZ2?=
 =?utf-8?B?WldKbGNGaERkNEd6OU9IZjNsajNNOXM0biszOGFFWGozRi93azRET09rbHJS?=
 =?utf-8?B?ZXcySEhSSFY1VFVlcGhCZEVhenI2K2dJSlJFTnVzTHA1bDVidmdOUkdKNWIy?=
 =?utf-8?B?Tkh6bFNHVzVjTlJOTit3eGdsWHdaUWhNR0MvSTg5ZmZzNDl3SGJJMnduQk9R?=
 =?utf-8?B?OGNIQi9lUG1NRVRFSHRUVnRXdnE2TEE1WnZkWVIvaEFReU5DdWY0U2F1Nmhi?=
 =?utf-8?B?L2JoeVRXYVg3MnV0bDlzeCtMVUxZY1ZpZG1oazdBQmpqc3ppMEllSk5OUWhG?=
 =?utf-8?B?UGJDS2pId2tvbTB2NFRLT2I1SkcxUkJGOUdrUVNUQU02ejZOUEFyeEdFOE9a?=
 =?utf-8?B?SUFjNDFIM3M4S3RKOXprSEM0OFhRaUZ5Wi9sbXFqSTJCbEZIWXFtYm5DWlRL?=
 =?utf-8?B?Tll0N3V5aGxUWjJ0ZzNlakpXZUw0TlAzWWVGRW9HMDE2SXNJZno1ZXRNeGNF?=
 =?utf-8?B?ckp3Q1pEMmVxSS94U0V0ZW9yZU5YV1pxTUFwRWRKTXEzVmREU3VUMTlBVUha?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0C4EA2E727B8D4892BA865F2D8AC00D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oaAA95SFrX0PgE4Dc45R/VGd6o5vcds3JSAB/3ppAZ0TUJIHoDSVuvVgcZQ+WXsItGefVlv0gKw5yRmSh11Db7x0E118e/Eg1V3brpiX05Mp8IoZ3gQTI1YgWNRGimIG6LQAH2WfDHNnfAaGRJgetHYZ2g4eNiPL7z/AuXVWKSHtN6SffMRyL6p0/WKZ4XZWcdmMgbxGniXvxW6bc0NN2lXgaBhEXNCIX90wQ/x/rO24muZ6IrkRFzB+YlfJ7qFnDle0nw0Hr02OIe9V8ash5z2VxOvCbVPDOewYNFFaM8jBRh/DGW9sYpHVnl8ddElDQfr5rEaq81UWbF0X0Ye89bVbrjlOkj74RQx6Tzo380+p9S5d7F7cSWKYVsB2WVZ/ayN1DkXHfTG5AxxYteA6Ec1i+pDZ58gdFrgT5oOemznn3sT5cRr5ELHGfnd0Wdxm0vRWDo10qoHhtmUBuyavdgZvGpYo1i9b312BFCvSuZckZIsRn/ByasMkVb9rQ90Ld1jM2mqbKhPnn6yTtLq5OykoOlOo0Kpo2Bg0et8KsH/m1tK36kmsnFuR9+jUKlNSEHiV0pmeKjK2dfwni9Tm42l/3IgXdJ8tlnHVo0jWRRdN2FgcDC1VNyeejxMLSfniLzyaejVpANlyfRF/lexbmSCFPkNrPSB+YYnAQCaJfHFNxD/0W86xBSDv5USEMVv/McpYKW4z2gidBNg0buHDUthDugtk+v4wsXkiyrZ7M7eHwlbv/Gtxv3g+ZfqgYIskrBKmqqkyYdB8ipt+LB+mfrovS/xV4vwCITQ6hxXmayGnDKrqmUqOtuE6e3CFfIUM5Eeh3v7V5RzTgG73MEQTUQK7aQpwdvL3LyEHUP9sz7FQ8XXYdqiGYeXAC80CGmqAdzufHJc+QKVXO5XSknO2GJy4gXWHWkvQka27eo5+1tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43308756-be8e-4296-3a45-08daf25fe4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 16:38:10.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqjR6S6Tsdt5l6o/jvU1LBwLV6N3l9uVa8YU6g2GeCbFHXgpUjaQ6Nu3gATKhMP2wKHUbMFkKOk0EqTbATXoPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090120
X-Proofpoint-GUID: sxGm0idbu6L5HSwDZdDF_Z_C5XfTF3tM
X-Proofpoint-ORIG-GUID: sxGm0idbu6L5HSwDZdDF_Z_C5XfTF3tM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KiBWZXJub24gWWFuZyA8dmVybm9uMmdtQGdtYWlsLmNvbT4gWzIzMDEwOSAxMDoxOV06DQo+IEhl
bGxvIExpYW0sDQo+IA0KPiBPbiBUaHUsIEphbiAwNSwgMjAyMyBhdCAwNzoxNTo1NFBNICswMDAw
LCBMaWFtIEhvd2xldHQgd3JvdGU6DQo+ID4gRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0u
SG93bGV0dEBPcmFjbGUuY29tPg0KPiA+DQo+ID4gVXNlIHRoZSB2bWEgaXRlcmF0b3IgQVBJIGZv
ciB0aGUgYnJrKCkgc3lzdGVtIGNhbGwuICBUaGlzIHdpbGwgcHJvdmlkZQ0KPiA+IHR5cGUgc2Fm
ZXR5IGF0IGNvbXBpbGUgdGltZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93
bGV0dCA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL21tYXAuYyB8
IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMNCj4gPiBpbmRleCA5MzE4ZjJh
YzhhNmUuLjRhNmY0MmFiMzU2MCAxMDA2NDQNCj4gPiAtLS0gYS9tbS9tbWFwLmMNCj4gPiArKysg
Yi9tbS9tbWFwLmMNCg0KLi4uDQoNCj4gPiBAQCAtMjk5OCw3ICsyOTk4LDcgQEAgc3RhdGljIGlu
dCBkb19icmtfbXVubWFwKHN0cnVjdCBtYV9zdGF0ZSAqbWFzLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwNCj4gPiAgICogZG8gbm90IG1hdGNoIHRoZW4gY3JlYXRlIGEgbmV3IGFub255bW91
cyBWTUEuICBFdmVudHVhbGx5IHdlIG1heSBiZSBhYmxlIHRvDQo+ID4gICAqIGRvIHNvbWUgYnJr
LXNwZWNpZmljIGFjY291bnRpbmcgaGVyZS4NCj4gPiAgICovDQo+ID4gLXN0YXRpYyBpbnQgZG9f
YnJrX2ZsYWdzKHN0cnVjdCBtYV9zdGF0ZSAqbWFzLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZt
YSwNCj4gPiArc3RhdGljIGludCBkb19icmtfZmxhZ3Moc3RydWN0IHZtYV9pdGVyYXRvciAqdm1p
LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gPiAgCQl1bnNpZ25lZCBsb25nIGFkZHIs
IHVuc2lnbmVkIGxvbmcgbGVuLCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiA+ICB7DQo+ID4gIAlz
dHJ1Y3QgbW1fc3RydWN0ICptbSA9IGN1cnJlbnQtPm1tOw0KPiA+IEBAIC0zMDI1LDggKzMwMjUs
NyBAQCBzdGF0aWMgaW50IGRvX2Jya19mbGFncyhzdHJ1Y3QgbWFfc3RhdGUgKm1hcywgc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gIAlpZiAodm1hICYmIHZtYS0+dm1fZW5kID09IGFk
ZHIgJiYgIXZtYV9wb2xpY3kodm1hKSAmJg0KPiA+ICAJICAgIGNhbl92bWFfbWVyZ2VfYWZ0ZXIo
dm1hLCBmbGFncywgTlVMTCwgTlVMTCwNCj4gPiAgCQkJCWFkZHIgPj4gUEFHRV9TSElGVCwgTlVM
TF9WTV9VRkZEX0NUWCwgTlVMTCkpIHsNCj4gPiAtCQltYXNfc2V0X3JhbmdlKG1hcywgdm1hLT52
bV9zdGFydCwgYWRkciArIGxlbiAtIDEpOw0KPiANCj4gV2h5IHdhcyBtYXNfc2V0X3JhbmdlKCkg
cmVtb3ZlZCBoZXJlLCBidXQgYmVsb3cgWzFdIGl04oCZcyBsZWZ0Pw0KDQpTZXQgcmFuZ2UgZG9l
cyB0d28gdGhpbmdzOiAxLiBpdCBzZXRzIHRoZSByYW5nZSwgYW5kIDIuIGl0IHJlc2V0cyB0aGUN
Cm1hcGxlIHN0YXRlIHNvIHRoYXQgdGhlIHN0b3JlIHdpbGwgb2NjdXIgaW4gdGhlIGNvcnJlY3Qg
bG9jYXRpb24uICBUaGlzDQppcyBzbyB0aGF0IHlvdSBkbyBub3QgdXNlIGFuIGludmFsaWQgbWFw
bGUgc3RhdGUgZm9yIGEgc3RvcmUuDQoNCldlIGRvbid0IG5lZWQgdG8gbW92ZSB0aGUgbWFwbGUg
c3RhdGUgaW4gdGhpcyBjYXNlIHNpbmNlIHdlIGFyZSBhbHJlYWR5DQpwb2ludGluZyBhdCB0aGUg
dm1hIHdlIGFyZSBtZXJnaW5nIHdpdGguDQoNCkZ1cnRoZXJtb3JlLCB0aGUgQVBJIGZvciB0aGUg
dm1hIGl0ZXJhdG9yIGJlbG93ICJ2bWFfaXRlcl9wcmVhbGxvYygpIg0KYWxzbyBlbnN1cmVzIHRo
YXQgdGhlIHN0YXRlIGlzIG9rYXkuDQoNCj4gDQo+ID4gLQkJaWYgKG1hc19wcmVhbGxvY2F0ZSht
YXMsIHZtYSwgR0ZQX0tFUk5FTCkpDQo+ID4gKwkJaWYgKHZtYV9pdGVyX3ByZWFsbG9jKHZtaSwg
dm1hKSkNCj4gPiAgCQkJZ290byB1bmFjY3RfZmFpbDsNCj4gPg0KPiA+ICAJCXZtYV9hZGp1c3Rf
dHJhbnNfaHVnZSh2bWEsIHZtYS0+dm1fc3RhcnQsIGFkZHIgKyBsZW4sIDApOw0KPiA+IEBAIC0z
MDM2LDcgKzMwMzUsNyBAQCBzdGF0aWMgaW50IGRvX2Jya19mbGFncyhzdHJ1Y3QgbWFfc3RhdGUg
Km1hcywgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gIAkJfQ0KPiA+ICAJCXZtYS0+
dm1fZW5kID0gYWRkciArIGxlbjsNCj4gPiAgCQl2bWEtPnZtX2ZsYWdzIHw9IFZNX1NPRlRESVJU
WTsNCj4gPiAtCQltYXNfc3RvcmVfcHJlYWxsb2MobWFzLCB2bWEpOw0KPiA+ICsJCXZtYV9pdGVy
X3N0b3JlKHZtaSwgdm1hKTsNCj4gPg0KPiA+ICAJCWlmICh2bWEtPmFub25fdm1hKSB7DQo+ID4g
IAkJCWFub25fdm1hX2ludGVydmFsX3RyZWVfcG9zdF91cGRhdGVfdm1hKHZtYSk7DQo+ID4gQEAg
LTMwNTcsOCArMzA1Niw4IEBAIHN0YXRpYyBpbnQgZG9fYnJrX2ZsYWdzKHN0cnVjdCBtYV9zdGF0
ZSAqbWFzLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gPiAgCXZtYS0+dm1fcGdvZmYg
PSBhZGRyID4+IFBBR0VfU0hJRlQ7DQo+ID4gIAl2bWEtPnZtX2ZsYWdzID0gZmxhZ3M7DQo+ID4g
IAl2bWEtPnZtX3BhZ2VfcHJvdCA9IHZtX2dldF9wYWdlX3Byb3QoZmxhZ3MpOw0KPiA+IC0JbWFz
X3NldF9yYW5nZShtYXMsIHZtYS0+dm1fc3RhcnQsIGFkZHIgKyBsZW4gLSAxKTsNCj4gPiAtCWlm
IChtYXNfc3RvcmVfZ2ZwKG1hcywgdm1hLCBHRlBfS0VSTkVMKSkNCj4gPiArCW1hc19zZXRfcmFu
Z2UoJnZtaS0+bWFzLCB2bWEtPnZtX3N0YXJ0LCB2bWEtPnZtX2VuZCAtIDEpOw0KPiANCj4gWzFd
LiB0aGUgbWFzX3NldF9yYW5nZSgpIGhlcmUgaGFzIGJlZW4gcmVzZXJ2ZWQuDQoNClRoZSAidm1h
X2l0ZXJfc3RvcmVfZ2ZwKCkiIEFQSSBjYWxsIGRvZXMgbm90IGNoZWNrIHRoZSBzdGF0ZSBhbmQg
dGhlDQpzdGF0ZSBjb3VsZCBiZSBpbnZhbGlkLg0KDQo+IA0KPiA+ICsJaWYgKHZtYV9pdGVyX3N0
b3JlX2dmcCh2bWksIHZtYSwgR0ZQX0tFUk5FTCkpDQo+ID4gIAkJZ290byBtYXNfc3RvcmVfZmFp
bDsNCj4gPg0KPiA+ICAJbW0tPm1hcF9jb3VudCsrOw0KLi4uDQoNClRoaXMgc2l0dWF0aW9uIGhh
cHBlbmVkIGJlY2F1c2UgSSBhZGRlZCB0aGUgc2FuaXR5IGNoZWNrIHRvIHRoZSBzdGF0ZQ0KbGF0
ZXIgaW4gdGhlIGRldmVsb3BtZW50IGN5Y2xlLg0KDQpJIHdpbGwgZml4IHRoaXMgaW5jb25zaXN0
ZW5jeSBhbmQgcmVtb3ZlIHRoZSBtYXNfc2V0X3JhbmdlKCkuICBUaGFua3MNCmZvciBjYXRjaGlu
ZyB0aGlzLg0KDQo=
