Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525D66D9EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbjDFRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjDFRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:38:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66FD4C21;
        Thu,  6 Apr 2023 10:38:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EhKS1015317;
        Thu, 6 Apr 2023 17:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=k49EoDHJovtRM5MPKhxMeaVtnBGGH8CDi7giycPX3us=;
 b=cv0y1/qY7GbTqh0IeJhkmg1nIne+KirnWCyR+d47AZeDhasI0/ihHpr09DbivEOWIn2v
 EImYeElRqhJ9/WIfMsGkN+E77B95XjXuVJArHbWopF4TYk/bOhC9mQyoJ8yup8V2SjBy
 Fx3JjNCuI7ZFghVc3jor8N7RwYikPfAXu1sma36fd1xEulc3hCmBtZjBTCPfL6p5YXug
 Im3eeaQNOeMfUAokLuq863jGh4FxefiPJNm5rwAltEPnqPTH6oS5qsAWGkbw/JlQK86V
 qKAsvZEjHh4LVMmAjpmDI7/XlrSH1zbBOTVC2lclO6/sIthcjFpstXNVTww+y19gtcIP cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7u3ees-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 17:38:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336GrVRx034243;
        Thu, 6 Apr 2023 17:38:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjvm6kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 17:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf0DwGbmHaPoJzueJQt1sIipJV8GIaS/kkJXtJh/2iA+eY/tDgFDJLmoDPtNOpFDWxFxHyqiU8kGAbz5pAqR46hrzixZ1XDz4piKOMDsbVNIDpD/J+mGc06kQ7j7zE3YDC9hOhIos6EnxMln3txTRuKqBO1w7BECzdYiAIAgxAbBY+fInL4PoKE4/Li+/L8NOJ03P8n5BvNhBkWKVzLRHWkyLjrHnCekqpo6tuFWfVl/bbKsqMZCJyhTRCZmyL3wYyWub+3yJuxZ6msYZ/brpexA0TlaTSaio7UrI6UHZHTur52ClTuOyrO0q7V3i2oFL29eG9HQOQDGng0ma03OMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k49EoDHJovtRM5MPKhxMeaVtnBGGH8CDi7giycPX3us=;
 b=Yia8HPLuliyUKrg/D2V7PiBSf2+pXGuW0NPu4DaphfjyHX+OMeGkb8/LwtNFftPA7gqsh89LvsYRK0SRsZhtK9y73SNTVr3iILhzcxz9t/b/qr/tmeNY2UHT082ClxM1Etg7IFJhbLbJOMbmE+IgJwABdjETfIf7W89f6nSGCAH0SxTAeurrGVvqwR2Y+sKPqqAS8zHenuW2zSKTvDC2DcND38Jh0nzANU5xU+zQwhblQ2FYhYuoxx6Mr7g896aBjy8/08TzrO8w9UTqumjJtojFMJCzZRwfe7WRexc6WHzof+OANHeVgKeV1Bi0c1Qt/lLkno5JzXkiGnMSSD3lHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k49EoDHJovtRM5MPKhxMeaVtnBGGH8CDi7giycPX3us=;
 b=Hrxrd8t+0r9691psE0DtxM+ZmksV7NGTy//rVHj/UeQbFh2tYiWeYz9FTjrKsxu1y7wup8rfKPjYNjukWXg5FeUqsDVPZm8+iVVMx9iYY4U1Plnszez9M6EnG2cIyW+yqUEtJtcrlNPzCpFmDkVmZ86DN2A5BrSMxAb9lyfcDh8=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by CH3PR10MB6882.namprd10.prod.outlook.com (2603:10b6:610:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 17:38:07 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::d8d2:ddf3:e236:99ef]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::d8d2:ddf3:e236:99ef%4]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 17:38:06 +0000
Date:   Thu, 6 Apr 2023 13:37:50 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, nathanl@linux.ibm.com,
        junxiao.bi@oracle.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Subject: Semantics of blktrace with lockdown (integrity) enabled kernel.
Message-ID: <ZC8Dbux56HbJjpTy@char.us.oracle.com>
Content-Type: multipart/mixed; boundary="5iavvndJv1wOMM1M"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:EE_|CH3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ee6596-19cf-40be-88ab-08db36c5ae44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIyKtOq1aQkV5hoZSvkkD29W+unbsrFxlRYObshURBb2NCyuCG36OENWx1sfiRtilruCmJNaraC+BJQwYqCvSoJcGP6b+Ld6bGI8WeblC9zbLQLHau+veT52msZWW3RIcAb2jJ1hets/PyG88E7ryblJJXG4h7WluZf5QMq1g20SLIHBCQhC8cEOcvcHy9kyJ898+sjBQhMk8WYJik15J1Xgy65xQvHLc8aAFos+yXNReQux42L+Rr7dhvYRIiAz1nFXqtnVpb0OYHPuqrBsGxXlnVKsDf3G06DWw/qdO8c0g3xYoGigbcKuJEwJ1b51NvIa001hiZQ6eBaz/SrDdVkYrisNz6L+421N5skPP9/9y3LVJo1P0l5X1chWwXeHJ7AjxwvwOPPOmdV75i9Dl40ZrT/zU6OSCTkzVGPRI0sczYnXkHlpcQPQ9ez2Im64iEwVgfuyZAQgJ94C+mLVxnUCDaYrcujVCYbIoVKUsQtRim6RwofisXljY0qi7s3VcU0gGFqSoEk6QdyenVgV8m3wI5rpnW5gmSB7Rs4a16GEp8CdU6bgGdEwt3DbJ0MHidw0el3h77KgNmOx5reyMrCuYSc6wX6F+U1sb2UrdlOeK9fY4r2IPTC2YLvL4RtIAPTzWCSz26vEu3vyqmP8dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(38100700002)(6512007)(26005)(6506007)(33964004)(44144004)(8936002)(186003)(478600001)(110136005)(316002)(86362001)(66946007)(8676002)(66476007)(6486002)(6666004)(66556008)(2906002)(41300700001)(921005)(83380400001)(235185007)(5660300002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xqbjVDUVpvNTZpSW5oSkxlc2FoSEMvekxkM1NXNkd4QWpXTHdHcy9nTVdR?=
 =?utf-8?B?TVRCYlBIS0RrSFhuT3dmMVJmSjdhLzhENFhraXlmWkZ5amYvZTczTVJ2SFhT?=
 =?utf-8?B?YjBtS0gzL253RDMzNUZ4YkpvKzJGdnpGRGNZcjBlQjJPYm0zZXNRRVpsWk1O?=
 =?utf-8?B?R0FkQUExaEhZZ2k3SmFJMXduWXVCbTJvM0lMQnRsUWExT2tub0I0NTBZZFQ3?=
 =?utf-8?B?L0syRGorbHhXc0gwcTJBOXY3YUJVNXMwenZVU3NyMjNYK1UvZEtNNmQxU1I5?=
 =?utf-8?B?ekJjbk4rbHh0TUx1ZVFPb2dDUXNEcUZPbGtCWGJyamVmb3laSHFPVS9POWFQ?=
 =?utf-8?B?eE5vV24zOWExUm5Vb1dia25vZHhib0hudDl6UnZicklZVFExL08zZmp3enI2?=
 =?utf-8?B?RTQwcENITVYwbnQweTBVTGVZc3B6Q1FUYlhReW1tdVd5R01ZMERwS3ZXbEdv?=
 =?utf-8?B?VERFdmtJYlZLNHVCZEpLTTkwdExraUc5cEk2dXRVeWcwVEswSWdXWmduR1JK?=
 =?utf-8?B?NXhrMGRETkgxRW40dEhCRmkyNFFXTGMxK0NVM0NNenlBaGgyaGJoZ05aUEVj?=
 =?utf-8?B?YnNQZHNnVnlvWndqVGFDbWZwajNaakx0dTFmYXQrb2VDRVByY1MrZWJlbnBE?=
 =?utf-8?B?UUJUam1Qc1B6K3JGZEhwcWlCVC9SUG05RFlRY0JNVHkrSXdiZS9HOHc4N1pL?=
 =?utf-8?B?amNRTXVJUVdPZ1NIcE4xUktLanBjS0lBazlmSEJMWmF2WFM4VkxtVzVUNmJO?=
 =?utf-8?B?d1BFZy9GM0pTQmdVUGVmTWlESzg2MXZ2b1FXdUg1WVdYRlRKRnB1QWFJdVNj?=
 =?utf-8?B?RnM2OGN1YnJFSGpqUjUrMEdJTXhPQzhYanN1YmFjSkEwVjc5MXRaaXFRYk4r?=
 =?utf-8?B?QTgyaHNlbkg1UHRyZ1JkbEo1cTA4QW1RdGVzd3ZtU1U2WThFY0V4K2hSVnBK?=
 =?utf-8?B?MVg1ckdTZVltM05rVFlSbmVqN215L01sbHlOWForY2tHMmNPSUY4Y2p1c0x6?=
 =?utf-8?B?MDZUVVVaYXNwYzcxR2NGY1dlcnRFRUI1ZXk3WGIxQUpvY1hxVk5QVEI0MnMw?=
 =?utf-8?B?YkV4dlZDRVk1UkNLQ1ZsZkI4cTNRU2pWcXBoTWdUWnd6RXYwS25zOTFrY1hp?=
 =?utf-8?B?M1pHVUJJeWVWQWVmRE1SRU82dFJ6TUpBT2xQRVJvdGRsditvdXduMlYvY1pU?=
 =?utf-8?B?ZjJiMm40dzBuVzA3eUpYRWd4YklRbm9Oc0YxZU5tVG1SVjFIYklNcXNXYzIx?=
 =?utf-8?B?UEVDY1BLUjBOU0lpc2NHSjVYQmJ6UFQ3RVEzam0vbXM1WTh4Tk1ucVlDdXd6?=
 =?utf-8?B?QUx4K0g0RGRGSFA5ZlVpT2QxcVd5QXAzZVNWMjlGeGtyYVk3aU9vWFFEeFhy?=
 =?utf-8?B?R1Qyc2pVdTlFa3A4RUUzcEFrMGI0MmNxWnp3bDVaM01TbXczc1BLRHJYVmVF?=
 =?utf-8?B?QjNQakxBMUUva2hRSlFTQjZGSWVrbEs4TWtYc1BobjRQUWNtTmcwUDdqdXBv?=
 =?utf-8?B?WEw5bE1iTFZURzVLZGs4ZklWSXFzeHVHT0tGOXlybjRkNUFjR3ovNzR5Tkc1?=
 =?utf-8?B?SWNMb1lvTURaK1BLbUsyTnI2OE5ZTVNzS0ZhTXhvOU5ZcXU0bkJLUFBMbnBI?=
 =?utf-8?B?dW1ydTF3VmZnYzRwZVJrQmFpOE4wRHlTclRuVWJqdEtTaHNJK1BhRDNSMDBI?=
 =?utf-8?B?akxzRkcrdldUQkVPZ3pISE43RU9Ddzk2L3lmdk1wTUw5SDdBZG4rVW5mY21u?=
 =?utf-8?B?RmpPZ2U2TEV5eDJuOUcwVTlFbU56OS9ydnhWZTZFanVQTnlVcjFJK1lLVUtW?=
 =?utf-8?B?TWdVMnBWM25vdVZneHRMeWdIV3k3R2JVNUhoVTZUdHorcDl4WTFwVVE3RWk2?=
 =?utf-8?B?UXlZMFNFLzVPend2NElqaUJOazQ2ZFEyTnBMRHdSL2NwSkNwNzVSRmEyWFhy?=
 =?utf-8?B?empRY2VKYzFUQW1SanJOYisrRytoelBpY05makhFTmNMSzhPd01kVXMwVXZG?=
 =?utf-8?B?eE5CQVN6eThJTjlZMkFVeDR4ZE4vdms2SFM3UkdZRGxWckRURW54bjhDL0R3?=
 =?utf-8?B?dHp3b2Z1ZFF3UnFqQktWQmR4UGVuVVlXaGJKaUlkWUQxMUpkTExGZlJzVk9M?=
 =?utf-8?B?aUZaN0Zpa3BBM1QxRnFzOStKTDNmUFZnVk1RSDRRZ2pRYVoweTloRndKcnFa?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xRx43EviDMqyJKu/9PEPTWyp8GUKF3/xLy3GvNVRuyEsop1wV3ILDKb57VSGB/umQDgHXRlwywT/QxRNPZ8MN3/pinXEZIL+74bnQwA+wWXG3lpakszNR1HHMf1FkgwayzHst4BvsFOgNTQL/jJ+zdep57myOIGmLll+1DMriIK1Pkf6os1ocsG2xs36mHsdbekGUZPTJW797hCGQ0o68KylaGjz481dlXuTK4yFn17AGDNHDGtHvDA1nX9IYqf/jDop3eIQg76hgyxD6/Uqxw4hQ2AEcJ8RM75gAaiDOn9ZlrlSJP+kh9RHga6VlzTZsPYjKAfJ12Aar2ffE1sqb94sKy8HzVHaoLG7OudoD8k1I3XCAaW8axyWXXRd5fjO1Jia0bNAlh9566KxvuDfaW6xWmvs8LDeQQOBxDqxXJ/SZqSAqHdNuxAcR8O9oznZm+WfgUNdZam9khMG+S62DGQ4twdgEebbH8YDcT0zH0i8i1RmizRhg4MAkpjFzh9KBFZfmUoX+zSXPJWwUNyA/lYmu2hJNTPNb0vPa0brp9aOPgVRC1wRTFH5nrcedIXlIDa6trKNZN/uEqEzyyNOe3hne6DbdLvCrnbXQlzW5py1YOpBpFkgnkjziLRsw08qP+vSK2K4lbROGyxJfVl5+sNFrcRN77DMBfmWLegPmvbStgqXaG1UMSNTt97cqiKsjkqguI+dNV7dUuQx4+LCPUiKX9IfiHIVUiWyUiAPPIbb4K9wDR18N02HXWJl3+Fu/GB4U8ogr3FNoJkGeLXcO2brzrdwIrO9Le6mdK9DMcFofrwRVQoInlQEtAhhMYFRqIhTnc8ImnDWn3EN6YtAXGjouKtRspje0HKLk+rQvuw+qsqAKy99p3aGxywpExqz13G9vJfFga2LOegXfJPEO0V6D3EtnuVmV3RuQb3QIu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ee6596-19cf-40be-88ab-08db36c5ae44
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:38:06.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCM+15/My87+to+npI3mSmUMm7iRw/NYNFNTY+XqmFs8D83GHMpB05c4D5Eeeoa9CXhCGXUICeNUYLiJHZjUJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060155
X-Proofpoint-ORIG-GUID: 1TP6tYX6Uh9FgLgZvYpYkBSuk35_xxGf
X-Proofpoint-GUID: 1TP6tYX6Uh9FgLgZvYpYkBSuk35_xxGf
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5iavvndJv1wOMM1M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hey Jens, Paul, James, Nathan,

We are trying to use blktrace with a kernel that has lockdown enabled and find that it cannot run.

Specifically the issue is that we are trying to do is pretty simple:

strace -f blktrace -d /dev/sda -w 60
 
[pid 148882] <... mprotect resumed>)    = 0
[pid 148881] openat(AT_FDCWD, "/sys/kernel/debug/block/sda/trace0", O_RDONLY|O_NONBLOCK <unfinished ...>
[pid 148882] sched_setaffinity(0, 8, [1]) = 0
[pid 148881] <... openat resumed>)      = -1 EPERM (Operation not permitted)

which fails. The analysis from Eric (CCed) is that 

All debugfs entries do not exist until blktrace is run.  It is opening
/sys/kernel/debug/block/sda/trace0 which isn’t there normally. While running the utility, 
to place something in it, it must have the write permission set.  When exiting out of 
blktrace, the entry is gone, both on a machine running with secure boot enabled 
and one with it disabled.  Which also indicates the write permission was set, 
otherwise the entry would still be there.

The fix is simple enough (see attachment) but we are not sure about the semantics of what
lockdown has in mind.

Looking at the include/linux/security.h the LOCKDOWN_TRACEFS exists which would
imply that it is expected that operations with tracefs *should* work with lockdown (integrity mode).

But at the same point, debugfs writable attributes are a nono with lockdown.

So what is the right way forward?

Thank you.

--5iavvndJv1wOMM1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-debugfs-whitelisted-relay-file-for-lockdown.patch"

From 20bd7b8c91463191924ec69833bbd6e6a6231f52 Mon Sep 17 00:00:00 2001
From: Junxiao Bi <junxiao.bi@oracle.com>
Date: Tue, 4 Apr 2023 19:13:21 -0700
Subject: [PATCH] debugfs: whitelisted relay file for lockdown

Relay files in debugfs are used for sending data from kernel to userspace,
the permission of these files are 0444, looks safe to skip lockdown.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/debugfs/file.c     | 17 +++++++++++++++++
 fs/debugfs/internal.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index d574bda24e21..93ab719d8c7b 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/relay.h>
 
 #include "internal.h"
 
@@ -137,6 +138,22 @@ void debugfs_file_put(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_file_put);
 
+bool debugfs_file_is_relay(struct dentry *dentry)
+{
+	struct debugfs_fsdata *fsd;
+	void *d_fsd;
+	void *fops;
+
+	d_fsd = READ_ONCE(dentry->d_fsdata);
+	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
+		fsd = d_fsd;
+		fops = (void *)fsd->real_fops;
+	} else
+		fops = (void *)((unsigned long)d_fsd &
+					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+    return fops == (void *)&relay_file_operations;
+}
+
 /*
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 6bcedb3f90b3..392bb1972226 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -37,6 +37,7 @@ static const char * const arch_whitelist[] = {
 	"mds_user_clear"
 };
 
+extern bool debugfs_file_is_relay(struct dentry *dentry);
 struct dentry *__attribute__((weak))get_arch_debugfs_dir(void) {return NULL; }
 
 static bool debugfs_lockdown_whitelisted(struct dentry *dentry)
@@ -51,6 +52,10 @@ static bool debugfs_lockdown_whitelisted(struct dentry *dentry)
 		}
 	}
 
+	/* relay file is used for userspace/kernel communicate.*/
+	if (debugfs_file_is_relay(dentry))
+		return true;
+
 	return false;
 }
 
-- 
2.24.3 (Apple Git-128)


--5iavvndJv1wOMM1M--
