Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6E6E97F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjDTPEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDTPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:04:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE443A86;
        Thu, 20 Apr 2023 08:04:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KDwj4x002079;
        Thu, 20 Apr 2023 15:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qFzrCTp0x/KrGKpyfFHmpmuLR3A4LKjpKjbpWoubAW8=;
 b=vVoBHYzwY21etYlK199CpK9fPiY5YZF56GP18KRISPP+7dNY52fF2YYGEqbzRq0ZTTlj
 isnvUiOVmq7PtMuMul2e7+mEYkaLjodNddTUJ/axCqw+xkBjVEZPvSgVEcMmxnBc2tc0
 hBIpgvmngz2fmYHbPRvTst0OKn4UrF/JU7fgQdcE8a2Ch9bCyfaYvz/j2MxCiWKHPdO7
 0CrTRhn0Pd67NEoqhQE0JN5mlSDkbDdk8UTI93llNBY8qNf5bu8O9KACz1txrbanBEcd
 43X9+fTSNmO3wAeBpEq5pIhIxDNQ0/ABSp0eE94MsXEoqrLHtlgsg0ZY9bNeC7yEMu9E Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu33jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 15:04:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KEYkLm026315;
        Thu, 20 Apr 2023 15:04:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcep8y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 15:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J44Y1b+tN0Wdc2EC4VFeshQOPmGmngA6cki9WWRXtfXCIL/UecZBSoCJQxPBKVrlHfsOsUNJ/olx6jaY0/NfXedSuvTqffG3acYPKiG41O1YEcqo7XMMdl9gABjv3PD7x+v5OwKzF8yfJqb5LekfsxaxjeHyedF4tRt8yHLjAJgxr+dAf0JPLyxWtNw27DSFepD2OXXFg+2HuDCRcDdnLobVg6gzHTNCOPh59CrVd0j9MvoLNkHSKzxG9q36l86OX0I5a2ZFCLCGeUKxa+MkqwfUzpjVsXa7TIkk+TC64m2wOrMz/JtefsFbMrIBp/t6RFRJbU8RQWBdXl/nBVDXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFzrCTp0x/KrGKpyfFHmpmuLR3A4LKjpKjbpWoubAW8=;
 b=GV1DHRwgXJzc33/0ZdjKKnzTGYrG0+BBA7MkV61BSX+wtbzimQ2sY4yUTBcS1F3heW2RjLx5GtpmhNrXOB9OjJSi83rMwTq6llQnSsFtnTC2ozt0EYNPZqEMsrTsW5qXh1P5hI/GSBJTX8MbruKmsCIbEzVwf4fOIO56KXHlP79AvpCdjeM2jDxVH/O6HfS+gLGFIxBJn/og9Tz4+fM1akKCySK0eBTPtZCTfuljaEN5ig4UECOgsoa5AO/y5287FE/YlixjscdOcI55Q5uZTeFpBYBxBRJ1Yk6fsncdE/jZ1rFOrlEs6gFFqK+PX0KLnxPHeaYko6nGy3DacYlF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFzrCTp0x/KrGKpyfFHmpmuLR3A4LKjpKjbpWoubAW8=;
 b=h3dfkQeRz/L4m5HAz8cZ1hWwAZl5HlB4G1o200ioXltYpUq6ykGHIeJFHETNda4Iq9feY2IMPgh4ohz/gmV/71CCGi2dC/G2e/ZjpNG/rHEIATZvnZK95B5lLucVGEyudp4Qj9XOzcEayl0q8LP356AdbxaZh/P78NSX6tR0nKc=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 15:04:06 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 15:04:06 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH V3] debugfs: allow access blktrace trace files in lockdown
 mode
Thread-Topic: [PATCH V3] debugfs: allow access blktrace trace files in
 lockdown mode
Thread-Index: AQHZchr91MCG2lkxH0uhDiOtrh3gVq8y7U4AgAFhMNs=
Date:   Thu, 20 Apr 2023 15:04:06 +0000
Message-ID: <CABFFF2B-CC60-48AA-98B2-56E59A717785@oracle.com>
References: <20230418172656.33583-1-junxiao.bi@oracle.com>
 <CAHC9VhTNoVTHMLwu0S5xVrNLe5cQcTpAEMb3fdn+GmoNuyNY1A@mail.gmail.com>
In-Reply-To: <CAHC9VhTNoVTHMLwu0S5xVrNLe5cQcTpAEMb3fdn+GmoNuyNY1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4752:EE_|BN0PR10MB4871:EE_
x-ms-office365-filtering-correlation-id: cc55c3a2-fa14-4ebf-d52f-08db41b07cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqFPaTnQGWQ1684Pe3QzodiY6UX9L4n/9+36YzXfQrRzHT2r3WU6B1Ng2zpDLen7JquMMEkwfMeRI4YB+8ebVzO8t9Ea5Z4Bqy8Wi753tpxtraKGl1DUBcIAvWCU6/hnO0B7srEIYNJtalAGVaTmaQNP9rZTAmYRp8h/kUnbKIJrm2u6FpN489xD9JeD3YrxoLsnm38BPbEplK+TW/nqnQtDCkuWl8QiFGAbr/nBoPCqm8qAL8Tk0fSm/EsGMYjwrgqPT1VQt3noZ+N7Mhd0ubbQQSP3hS5FUduNPnAKO0or23yKFfnvcNpuY/qb2cCayh19xIWZV6Vs9zQY4bJZu3IfLSt4KYOWeqsUQwX2hgsS7EJEI/VTEogOHdUViZgSVv/8qzdNAl/hbM8DuTjyTzFAKgILP+zh8YySe8dnFLIUL43nY2Zg/BuJ+E8cpmIl7E06JGswi2npwk0cB1/BNM3MZsCIB859MNaVqZ02XUPNS3aeBk+qRBW2frqnYj2XrMvwB/YUnluy5LhS02XpBwwKm/hOzpPdkKaD+S2IDQNBCZr8flvuS6o8dYAP2aGdxhoA0Fi2Si9/FXwhhlMFciN4C8Keyo+2AuJosl9PHbJq/SYHLeM/NN9/r42jwDdi9zCSUNjS/eZdpe8MmAYXGTdHt5mC0f2su1W6ZDUAiZ7Ockgwtv31uFjvPqdAiY3s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(38070700005)(2906002)(8936002)(38100700002)(8676002)(44832011)(5660300002)(36756003)(33656002)(86362001)(6506007)(6486002)(71200400001)(107886003)(6512007)(966005)(54906003)(478600001)(2616005)(83380400001)(53546011)(186003)(316002)(4326008)(66556008)(6916009)(66446008)(64756008)(76116006)(66476007)(66946007)(122000001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUxEYzdNY3ppM1VuR3p2WENkSmVGMitLOW1XekwxV2k2aU9ZTWpMUE04d041?=
 =?utf-8?B?Q3JPVlgyeUxyd05JWm1iSXlUYVQ1MHZBWmp2K2VsNkZiZ3lSczRPaU8vd3Zt?=
 =?utf-8?B?dXYyWFdVL2o4NUErL3R6WHU1NVhnek0rNnpOaFpHdkRjRExiZ1FXSTIxSVh3?=
 =?utf-8?B?QytER1gySzRoSWptMFA4R1JTc3B4cWw3MWJWVTBnSEJPcm01Y2JZTTZRbm54?=
 =?utf-8?B?QXN2YWlaSnVBL3pTdUcyc3hSNXdnT2FDb0g1a2Z6S0NsV1NlSGVCVmx6eGtP?=
 =?utf-8?B?U2RVOFRjdi9KVmp5eElvMGVCdkhJN0Q4SGNQd0Y2STIwbi96WFhGMEY0TTJX?=
 =?utf-8?B?dzBHeWt0Ky8wRjR1UFI2TjMvWnExc1g4L3loTDYvWWZVd21CdThaQXJqb0Rs?=
 =?utf-8?B?NXNNSDNQNTlyNHAvd1VNQnlJdFJhbDdEMkJSZnZFWEpPL2FCS1Nnang2a0NR?=
 =?utf-8?B?QXM5VDA3Rkx0MTFGTnJxQmdoK3RyOEV2Tm5HZ1VKWUFCaEs2U2NudTMxa1dI?=
 =?utf-8?B?Ly85VjFsK0VSelN2T0FMenp5SFo5cHJ3bmRZbW4wanByazdqN0lpYm9vN3pD?=
 =?utf-8?B?SldvRk51ejQyalArSUxmZmc0WDdsMEJ1VnduTnZnR0xDeHJSY0dOK1lkVk5M?=
 =?utf-8?B?eFY2RkVTeWprZkZMNkZ0Sy8zajBLeDFJSHJpVnJTNW1IMGRXczEwQU5FazU4?=
 =?utf-8?B?WGZwa1p3RVEzbUtSZGJIQnk0WmRYVEpoeDJiTmlkTGNmUkNNMSt5eGdNODBx?=
 =?utf-8?B?eDh1WElneE9pZUswenF6TlFJVzRGRlNLM2pnWkQwallnRldEM1RJY3BvSHJr?=
 =?utf-8?B?SUt2OSt1NmV0RnQwdThCUEJrS2o2bi9BZit5WkU0ZW8wSkd1emx2RnZqVU1h?=
 =?utf-8?B?WUFTbjlpTGpVTXRXS25qQVJ1emdsaHlOWERYU0RVV05Ia1ZINjg5MmNYSGp0?=
 =?utf-8?B?bit2TEZJZUVZeE1waU92RmpCZE0vWlAzWjJtb0g5VjIxVWhVcURIdkY5NFlI?=
 =?utf-8?B?Y2FsRWtJMVRaUFdlV1ZmYk5ZVFhhZ2k0NTNNQUxuT0ZiRk5LRlErUHEvQ1Fz?=
 =?utf-8?B?U0EzbENheFJIVG9YRjNvL0VwaVRyK25nMnNqSit0a0YydVkyWkhaYm12akRR?=
 =?utf-8?B?Q09NeHJCK0paSFhpaFVpeU9qeGNIeVd4SUIxaW1jdXVxUGFMb3ByZ3liVnJH?=
 =?utf-8?B?cm9BT0JvYTRWRlhhc0Z3Qks1S3ZTM2dyTkRrdHlGSjcwQ0loTStIdUVTdTlj?=
 =?utf-8?B?dnZoTXFvUkJjWDZiN1lac21HVnVESjd0YVl0UXIvbU80OHNYZ3VSajJncFBS?=
 =?utf-8?B?ek9MRHlkUjFNVVp6TXVXY2p5QmlMSmcyQ0FuMXNrd2xuemJ0NjIvdzA4STZw?=
 =?utf-8?B?MVB3YXlldWszSjJIa1c5SkZoczBRUmpISW41ZlpzS0RISjdtc0RpYWZzQmlH?=
 =?utf-8?B?V3RxTzl5d0dXaDZadC9LMkR4VG5UKzByY2RUL2V1bURrejRiaUpZMytHQkR5?=
 =?utf-8?B?VEFJK0JTTWM1cVJKTW9TUkZQT3U1MUtXN1lvNmZ5YWIvRURqNjlwbXh5dmZO?=
 =?utf-8?B?bGYweFVBVUVlZGl1UithTWxjUDZHRHJPL014UHQ0bnp5ZkpYYmFjb1BpL09U?=
 =?utf-8?B?LzUrMlh5TE5wSExydXkwV0hTdWdpdnRpRXhZU1NDZmRBNkowSEdTb2FQN2Fo?=
 =?utf-8?B?TmtEU3dSZzJKVGtNZjllRC9HTldsN0xKcGR3c2ZXaUU2bGFTZjM2OUJSQ0tN?=
 =?utf-8?B?RmgwWjJjcUZleXVzLzhxVU5zOHh2KzVTZWh0LzVBZmsxOGs5TEJjZVUzTFdI?=
 =?utf-8?B?TldQK3dpMDIxTTkyczVBZHZkNE43akVBbzFrcVNqTVVkbmI3QVVJRFpQeXMv?=
 =?utf-8?B?ZWpzRjFFNi9xZDBaeWpiMkxiYkVua2FscFVQRFJicWd1djFhRjBnZ3p0UUIy?=
 =?utf-8?B?aWZGdFRJYW5HTVpoSHdmQlpTL2ZxZXRBc0NTVWxSVkh0emZnWUVQMHRuNVE0?=
 =?utf-8?B?bm85L0UwWi94TnQ2QUM5Y3JiR2VHS3FsemNRM0p0L3BJdDdCYmJ0YUxEbm1t?=
 =?utf-8?B?QkNFdDJpeU16c281cUhzZG9ET1QvZGpjaDErcnI4ckdlT0JPR2pyeXl5L29Z?=
 =?utf-8?B?THdMVExwdU5lMTRDMjFtcWFLNk93T01GeVdPcHVpTmNpWXp4VVdwWWhPTUNP?=
 =?utf-8?Q?MhtBlTHWmA0d58wPvm2uvBp02CjNp0FcqX4f2pvKrLAZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yxjv8ogVnK4HxYsQMW2I8VeMVrjmztHq0EdF9XHXvErgY6P5Yzzb5oYQ94WBeMqjLCjsPg07Hq2+F4xyY86iELkT2+/EmUt1H1ym1j7E6nU8/iH1Fz5qznxXm2Lt2l98v8aqbeXYcFpv3jtxQkSPgxSSQxzUEsv4OLMaotnBSONdt8A5pmWzLdmzKmnjIgW8sbLYWR8CI14ob5WNW9mJzmFpQKwGSnCuRJ9suLvd9+wDA3gygbEqRYfNO6ZbwBP0CWFXTSmz5z8QdqPlOHHxaTJzUT56acGWRIIh/xnvY70t+rzvet0EVA0Ro2yRzdaCfUuJk68Ie9OdYsR3Tzxn30lRphTSirpOgxQFLn+RYLZgskOJfeGA64xbYLLxVUYylFtyBTIhusZ2ftcE8wdRWKcfk3vK800daZpE5TrM/pTsion3YnEUhKc23VTWBdBK+Ng4tRqcCv73c2dYqLOTJ+sfc/gFYCBnxFEwXNc9SWFoOfrFF02pVnfNDdspOyCVCGy1lXNe1CcVDQgrDja9a/Et8xDMQEAjIWl3DD1gOs5Hg4HRZTYx//E1+nO0GCztH7W30j6gqBC3ssDRMTO/dcmTpdKCcqyiMpR41Aos7oyf86DcLINycWxCT9FwShwCHcz661ugeAMmP1mS3YdiRk8lv1rjSwFI1f7OhWs7T03lAyplj0N5fwsKIaLXPE4KrrWoXGJGfMnUlp/Xww6U3h4r+GS/t3bKkXSubdAxLmkgfjkTafttrPdPC6G/6UPemQ+pxlJ+b3ItsLDi675UFMEdOXEpSKZi2hIM5/u8dbAa4HNpjk+ZPw3kS0+uxuphqK6WBJjAby6I+0mNk8gv70a+2g9PuKR5TAiN6ty5we4YN8A9wpWeErAykORqg1u3nHwADvYs8T78+g4YzlIPzmflqYrIfw0EVoyCSiCvkHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc55c3a2-fa14-4ebf-d52f-08db41b07cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 15:04:06.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqVDs3d0O6jQIwE4kWvuOGT/RDS8XQB9J+y9DRBKEf6dAm0GjtjVNgHP5K5lsbTcpzg54/QZ4u0+4nklEbX6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_11,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200123
X-Proofpoint-GUID: txr-bYtR3sr1-1_wkmmb9E-R03yhCg44
X-Proofpoint-ORIG-GUID: txr-bYtR3sr1-1_wkmmb9E-R03yhCg44
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDE5LCAyMDIzLCBhdCAxMTowMCBBTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUdWUsIEFwciAxOCwgMjAyMyBhdCAxOjI3
4oCvUE0gSnVueGlhbyBCaSA8anVueGlhby5iaUBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4g
YmxrdHJhY2UgdHJhY2UgZmlsZXMgYXJlIHBlci1jcHUgcmVsYXkgZmlsZXMgdGhhdCBhcmUgdXNl
ZCBieSBrZXJuZWwgdG8NCj4+IGV4cG9ydCBJTyBtZXRhZGF0YShJTyBldmVudHMsIHR5cGUsIHRh
cmdldCBkaXNrLCBvZmZzZXQgYW5kIGxlbiBldGMuKSB0bw0KPj4gdXNlcnNwYWNlLCBubyBkYXRh
IGZyb20gSU8gaXRzZWxmIHdpbGwgYmUgZXhwb3J0ZWQuIFRoZXNlIHRyYWNlIGZpbGVzIGhhdmUN
Cj4+IHBlcm1pc3Npb24gMDQwMCwgYnV0IG1tYXAgaXMgc3VwcG9ydGVkLCBzbyB0aGV5IGFyZSBi
bG9ja2VkIGJ5IGxvY2tkb3duLg0KPj4gU2tpcCBsb2NrZG93biBmb3IgdGhlc2UgZmlsZXMgdG8g
YWxsb3cgYmxrdHJhY2Ugd29yayBpbiBsb2NrZG93biBtb2RlLg0KPj4gDQo+PiB2MyA8LSB2MjoN
Cj4+IGFsbG93IG9ubHkgYmxrdHJhY2UgdHJhY2UgZmlsZSBpbnN0ZWFkIG9mIHJlbGF5IGZpbGVz
DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2I2OGM5ZTFkLTcxYzgtYWRmOS1mN2Rh
LTFiNTZhM2Q0YmZiY0BvcmFjbGUuY29tL1QvDQo+PiANCj4+IHYyIDwtIHYxOg0KPj4gRml4IGJ1
aWxkIGVycm9yIHdoZW4gQ09ORklHX1JFTEFZIGlzIG5vdCBkZWZpbmVkLg0KPj4gUmVwb3J0ZWQt
Ynk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPj4gTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIzMDQxMjE3MTQuNm1haGQ5RVctbGtwQGlu
dGVsLmNvbS8NCj4+IFNpZ25lZC1vZmYtYnk6IEp1bnhpYW8gQmkgPGp1bnhpYW8uYmlAb3JhY2xl
LmNvbT4NCj4+IC0tLQ0KPj4gZnMvZGVidWdmcy9maWxlLmMgICAgICAgICAgICB8IDEwICsrKysr
KysrKysNCj4+IGluY2x1ZGUvbGludXgvYmxrdHJhY2VfYXBpLmggfCAgMyArKysNCj4+IGluY2x1
ZGUvbGludXgvcmVsYXkuaCAgICAgICAgfCAgMyArKysNCj4+IGtlcm5lbC9yZWxheS5jICAgICAg
ICAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrDQo+PiBrZXJuZWwvdHJhY2UvYmxrdHJhY2Uu
YyAgICAgIHwgIDcgKysrKysrKw0KPj4gNSBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCsp
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9mcy9kZWJ1Z2ZzL2ZpbGUuYyBiL2ZzL2RlYnVnZnMvZmls
ZS5jDQo+PiBpbmRleCAxZjk3MWM4ODBkZGUuLjk3M2UzOGYzZThhMSAxMDA2NDQNCj4+IC0tLSBh
L2ZzL2RlYnVnZnMvZmlsZS5jDQo+PiArKysgYi9mcy9kZWJ1Z2ZzL2ZpbGUuYw0KPj4gQEAgLTIx
LDYgKzIxLDcgQEANCj4+ICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+PiAjaW5jbHVk
ZSA8bGludXgvcG9sbC5oPg0KPj4gI2luY2x1ZGUgPGxpbnV4L3NlY3VyaXR5Lmg+DQo+PiArI2lu
Y2x1ZGUgPGxpbnV4L2Jsa3RyYWNlX2FwaS5oPg0KPj4gDQo+PiAjaW5jbHVkZSAiaW50ZXJuYWwu
aCINCj4+IA0KPj4gQEAgLTE0Miw2ICsxNDMsMTIgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZGVidWdm
c19maWxlX3B1dCk7DQo+PiAgKiBPbmx5IHBlcm1pdCBhY2Nlc3MgdG8gd29ybGQtcmVhZGFibGUg
ZmlsZXMgd2hlbiB0aGUga2VybmVsIGlzIGxvY2tlZCBkb3duLg0KPj4gICogV2UgYWxzbyBuZWVk
IHRvIGV4Y2x1ZGUgYW55IGZpbGUgdGhhdCBoYXMgd2F5cyB0byB3cml0ZSBvciBhbHRlciBpdCBh
cyByb290DQo+PiAgKiBjYW4gYnlwYXNzIHRoZSBwZXJtaXNzaW9ucyBjaGVjay4NCj4+ICsgKiBF
eGNlcHRpb246DQo+PiArICogYmxrdHJhY2UgdHJhY2UgZmlsZXMgYXJlIHBlci1jcHUgcmVsYXkg
ZmlsZXMgdGhhdCBhcmUgdXNlZCBieSBrZXJuZWwgdG8NCj4+ICsgKiBleHBvcnQgSU8gbWV0YWRh
dGEoSU8gZXZlbnRzLCB0eXBlLCB0YXJnZXQgZGlzaywgb2Zmc2V0IGFuZCBsZW4gZXRjLikgdG8N
Cj4+ICsgKiB1c2Vyc3BhY2UsIG5vIGRhdGEgZnJvbSBJTyBpdHNlbGYgd2lsbCBiZSBleHBvcnRl
ZC4gVGhlc2UgdHJhY2UgZmlsZXMgaGF2ZQ0KPj4gKyAqIHBlcm1pc3Npb24gMDQwMCwgYnV0IG1t
YXAgaXMgc3VwcG9ydGVkLCBzbyB0aGV5IGFyZSBibG9ja2VkIGJ5IGxvY2tkb3duLg0KPj4gKyAq
IFNraXAgbG9ja2Rvd24gZm9yIHRoZXNlIGZpbGVzIHRvIGFsbG93IGJsa3RyYWNlIHdvcmsgaW4g
bG9ja2Rvd24gbW9kZS4NCj4+ICAqLw0KPj4gc3RhdGljIGludCBkZWJ1Z2ZzX2xvY2tlZF9kb3du
KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgZmlsZSAqZmlscCwNCj4+IEBAIC0xNTQsNiArMTYxLDkgQEAgc3RhdGljIGludCBkZWJ1
Z2ZzX2xvY2tlZF9kb3duKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+PiAgICAgICAgICAgICFyZWFs
X2ZvcHMtPm1tYXApDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+IA0KPj4gKyAgICAg
ICBpZiAoYmxrX3RyYWNlX2lzX3RyYWNlZmlsZShpbm9kZSwgcmVhbF9mb3BzKSkNCj4+ICsgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgYSBsaXR0bGUg
bW9yZSBmb29scHJvb2YgaWYgd2UgbWFkZSB0aGUgY29ubmVjdGlvbg0KPiB0byBsb2NrZG93biBh
IGJpdCBtb3JlIGV4cGxpY2l0IGluIHRoZSByZWxheS9ibGt0cmFjZSBjb2RlLiAgSG93IGFib3V0
DQo+IHNvbWV0aGluZyBsaWtlIHRoaXMgaGVyZSwgYm9ycm93aW5nIHlvdXIgcHJldmlvdXNseSBk
ZWZpbmVkDQo+ICdpc19yZWxheV9maWxlKCknIGZ1bmN0aW9uOg0KPiANCj4gIGlmIChpc19yZWxh
eV9maWxlKHJlYWxfZm9wcykgJiYgcmVsYXlfYnlwYXNzX2xvY2tkb3duKGlub2RlLCByZWFsX2Zv
cHMpKQ0KPiAgICByZXR1cm4gMDsNCj4gDQo+IC4uLiBhbmQgaW4gdGhlIHJlbGF5IGNvZGUgd2Ug
d291bGQgaGF2ZSBzb21ldGhpbmcgbGlrZSB0aGlzLCBib3Jyb3dpbmcNCj4gZnJvbSB5b3VyIGxv
Z2ljIGluIHRoaXMgcGF0Y2gsIGFuZCB1c2luZyBzb21lIHNob3J0Y3V0LXkgcHNldWRvLWNvZGU6
DQo+IA0KPiAgYm9vbCByZWxheV9ieXBhc3NfbG9ja2Rvd24oc3RydWN0IGlub2RlICppbm9kZSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlv
bnMgKmZvcHMpDQo+ICB7DQo+ICAgIHN0cnVjdCByY2hhbl9idWYgKmJ1ZiA9IGlub2RlLT5pX3By
aXZhdGU7DQo+IA0KPiAgICBpZiAoYnVmLT5jaGFuLT5jYi0+YnlwYXNzX2xvY2tkb3duKQ0KPiAg
ICAgIHJldHVybiBidWYtPmNoYW4tPmNiLT5ieXBhc3NfbG9ja2Rvd24oaW5vZGUpOw0KPiANCj4g
ICAgcmV0dXJuIGZhbHNlOw0KPiAgfQ0KPiANCj4gLi4uIHdoZXJlIGluIHRoZSBjYXNlIG9mIGJs
a3RyYWNlIHJjaGFuX2NhbGxiYWNrczo6YnlwYXNzX2xvY2tkb3duDQo+IHdvdWxkIGJlIGEgc2lt
cGxlICJ0cnVlIiwgYXNzdW1pbmcgaXQgaXMgc2FmZSB0byBkbyBzbyAod2UgbmVlZCBzb21lDQo+
IEFDS3MgZnJvbSB0aGUgYmxrdHJhY2UgZm9sa3MpOg0KPiANCj4gIGJvb2wgYmxrX3RyYWNlX2J5
cGFzc19sb2NrZG93bihzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiAgew0KPiAgICByZXR1cm4gdHJ1
ZTsNCj4gIH0NCkdvb2QgaWRlYS4gV2lsbCBtYWtlIGEgbmV3IHZlcnNpb24gZm9yIGl0LiBUaGFu
a3MuDQo+IA0KPiAtLSANCj4gcGF1bC1tb29yZS5jb20NCg==
