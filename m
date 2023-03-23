Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB376C6355
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCWJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjCWJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:23:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72676A6D;
        Thu, 23 Mar 2023 02:22:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N8EDa0023492;
        Thu, 23 Mar 2023 09:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=DpNReF4bkkqmSRU1QRK2csKeFHfgX5O9wLeQCqXneI0=;
 b=i3iNEMRbhwsRjllPYkjEh39TpkLDa9Ob586jKH2DAUGjFuK0THyfLHChZ3YxjoGbszgf
 Sk4YpZ/0gq1nRcnQPq96hqAeeoDACKgvYl0q9yW8z8cmD404qFclWXfhY9Mlg4b6mcoK
 J4p/xVMXrYY/jtOoFqXBMDcSyuLyTWBNiaBzkhNRkEsqcT5avgJWqDNk1Ppe4K0AdZoT
 TAfGKoz4yX7u6xzZaOitByTJHfGLM46mP5pKUUddlibQJmAHsAkHBLUHTvJf3YM5ZeR7
 sSYmAooCF0+Jk0b2bjGxJgLmG0QKL0GPFBBieMjB9eenzQ4UsEB0SuGOqSK4dZL+GW2A 0g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg42kt6yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBeHFNISXraAYrG3SRQQ4A9HLKwtgU7Zf5Crv9GBC9itrMs3GNtVnTN9oaHovZyeUTc7hrjpAP2OhQrHg8TJaii4LFREe/+XkFQOGzqpd9Jztb51A64fqDW1LahFQbYu3xbtHW7/Y9KnDDbwM+DphRPlGNfEW2NGR+lPFdN9gvACHsp9actmgl4FQnlj0Ogi792RMPIsCNfThg9PDhnB3NKfKfR5erxCMfJLOgaJV/ddfu2dfsSlA8g3pQS/Zhqi7Xl2CvQJYdaDnYvi7ZvfpR7bUFJg4A1FA/exnGi1ms520mBx8bGoyHz/5AzN8iYuQp+/gKofql1gA01jrpBE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpNReF4bkkqmSRU1QRK2csKeFHfgX5O9wLeQCqXneI0=;
 b=LxsK8Pj/UNWa+Knf7VhYdkEkEYtHFHy6NfKxwJDO4Z3+DXCkImj8lvrIUECSvhuEAVcHK0XUUELLyMWXOpcMNxyPtM7Q5TtbfcnG/V2Q+FbnOL+HoD8qxcmXSnT/jQDZ40FfNd90nA6pQ54axjKPPs1VPe2Ed2Udyq6Il+q8pH7x6Up9w7PYj+3iQhjrZnxQdW9Kts+Rv7jeZ0FFLnNStjTYi9I1fn4+nBOdpUasjnFDOFbnhHx23S+0W3zaNhWpvfgx41P7sFpyy5PwoUKlRl2OMJkcwywL6LIcKWWygEyHUFapu+Gb1dOafgiGfIY/QY4XOEiFh7b95u8yfST/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com (2603:10b6:a03:3dc::5)
 by DS0PR02MB9271.namprd02.prod.outlook.com (2603:10b6:8:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:22:52 +0000
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::8651:bc06:5173:9e06]) by SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::8651:bc06:5173:9e06%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 09:22:52 +0000
From:   "Viswanath Boma (Temp)" <vboma@qti.qualcomm.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 0/1] Fix for VP9 DRC and Decoder STOP issue.
Thread-Topic: [PATCH V3 0/1] Fix for VP9 DRC and Decoder STOP issue.
Thread-Index: AQHZV9957NymzLc/s0qfnWYwWlOOlq79WIUAgArJpAA=
Date:   Thu, 23 Mar 2023 09:22:52 +0000
Message-ID: <SJ0PR02MB884886B0E37DA1F69C92503985879@SJ0PR02MB8848.namprd02.prod.outlook.com>
References: <20230202064712.5804-2-quic_vboma@quicinc.com>
 <20230316081509.12201-1-quic_vboma@quicinc.com>
 <0a9e9729-aa5b-4ce6-fc68-394949c1b162@linaro.org>
In-Reply-To: <0a9e9729-aa5b-4ce6-fc68-394949c1b162@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8848:EE_|DS0PR02MB9271:EE_
x-ms-office365-filtering-correlation-id: 8a3c9f71-ba92-4648-6b63-08db2b802d79
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwo4QfBbYjv64jd6dHycCtmETP6rkomdZkR6dqEUtBQVa6PEKHZ++AKLOBwaC4MN+YCTy7X9/VuJzEC2Pmi8kO+0Wz1vaUtji7xYSLxOHmhE/G4bViJtnz6a2vBSovvLaIFEs09+AkG/ZY2imUKoE/nRiLriyRiKTnsORVpQjdUFdpzWzsNW2kC2uCRFBe9+C3Jzk9q/dihBfkh7ac9uhh6B39MeQ3ybvtdqw8PdUjFPYJbCSEkJxL8IbVHfvPQgSf49SNZUchtk2H2UtDkeKEKk39gshbIYoCayLoXfUoLrpvcISMk4ZcyjMAlwlc/28tAnuj7/32zBkxP/3nFFLGTIZz/K7h3DxxamFwtJiX3CB73j1nm7jtKoQj4oD4IrvaQvCBLHRqA6H2YV3aroXKg6pBXCYV+vLAeQNnOaEUsQWnRaStGlgR/PAQzHpqX5t/yX24WgzDSDPJ6PzbhTnkdTvUl700se34Zw6tGVydblAcqN0bH5c6atfrz9Kx/7Zs3zjl2HzBjFEMesFPL81VIhZxi38JHjgzT924K2Dlh/nxRiwZu158ih/cy9CiOJXXHs/HoF+gGKYC6AFRL2V0VPtUygeAs7/Y9xfAh7vyEpzxGKtGTDMq8SqdQ03zFmnysK4czIhsR+6ZSWkzrHnhDLNCbZpi8k5svf2aO43RpJ+IeablLZe+PbRKcDF7kRxfEnK5AfbiD/zXIz9tcY2ch/+0St1wXHinH3xv2DHpg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8848.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(921005)(55016003)(38100700002)(38070700005)(2906002)(478600001)(71200400001)(83380400001)(7696005)(9686003)(186003)(86362001)(33656002)(316002)(110136005)(66476007)(66946007)(66556008)(64756008)(8676002)(66446008)(76116006)(52536014)(53546011)(26005)(6506007)(8936002)(122000001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1piUVdJQksxZ05VQkJndGsrOEg3dUlZM2VodkoxNldiZHZYN0FPSnFTa1J6?=
 =?utf-8?B?ZVFKMU5IcDk2N1FuSVVybGZrM0pSWWV1RWhJZDMrY0tPRGlPUjB0QUFGbG1h?=
 =?utf-8?B?VEh5YW11U3ZBaE1TQmpIQm51aU9TejFMLzZIcmtaRXN1cWlNTGx6V2hxMk9W?=
 =?utf-8?B?dXEyV3BWeHBXVWNxUDJjQkkxcHczTjNtZDlkMXFaOGtYcVJHWGxNempsdDE1?=
 =?utf-8?B?VmI0c0owYTR3VlcxK1dDMzBKRlBqZE16NjhmUU9GZkx4NTJhRFllaXZtYms0?=
 =?utf-8?B?d1o1dHkzZVd4ZFR3aWNoR1dGbjVuZ3NLKzBoSnQ5WldKcHNnTy9SdVhEUzF3?=
 =?utf-8?B?VlJmU285Q2tlN2YydXd1Z3Jxd1J6WjRTL05ZbHpEUkUwQTl0aTk1VzBpZkNm?=
 =?utf-8?B?RTEwZExETGQwR3c0RjdpWG11T01Mekl2dmVtSko4cllVTGphdGNXV3VpL0p3?=
 =?utf-8?B?QTBvZEFORFpnZG1DV2FOUXdEMG94OUh0K214NG1pSlZqSFZOcHZCSWVDcksr?=
 =?utf-8?B?SG8reHp3ZkJwZG9Xd0tGY1NZVWpZb3k2Sy9MMUVjUGdEWkJlR3RLQzQ1bFo5?=
 =?utf-8?B?NWpRYmRkbnJYRFBmaGF3WEpFNDc1NmVkQnFnYXAwQnpHYkdEWEFZUlNPRzZz?=
 =?utf-8?B?dkJ5VHBnN0NkSzk3MXY2NDNTNGhOWVZjU3ZiY2JYZ0lhWjNSUHk3OTVsQ3pH?=
 =?utf-8?B?Y2swYUd0RUJyS25ObE1Ndm0wazdzWlFJeUNFMldCdUxrOFdObmplTTgvYS9h?=
 =?utf-8?B?Qm5KVkU3VkpFQ2QxQmhrbmxaNTJjQnlSQTUxUW0xcXJZQ0hXdURUOVZMNzFR?=
 =?utf-8?B?MTZLOEtXc3lsNytzY3FRRHVjb2NoWlFrSE53R29ienJkNzVRbGg4YkIwdE51?=
 =?utf-8?B?MlhseU1abDBYUmxNTU1wQUdVZUhrRkQ0OS9CbU02ODJzTFIwSVpBd2g4Y2Zs?=
 =?utf-8?B?bys4Y0RwRU9OTmdsSHFuaU5TcE9aSXRReGZIYWhpQmoveW1oRzFDQkplTWJH?=
 =?utf-8?B?blg0ekVTUEhtNTY5YUhoYzJYRGZyNFNpbVZscEpDSTloa3JNa1c2LzlXY3NW?=
 =?utf-8?B?UnZDYVVabzBzdHlxT1IyVnYrODU5c2tsTTgzUndqaDZzdk1JY1BJMXlra1Uw?=
 =?utf-8?B?aEVuNDNEcHhRdWNrMDFadWdmbEZ4TGJiSlpYd3JjTUZJWXlVK1JYWmF1b29I?=
 =?utf-8?B?M2lrbGRhZkpjbzNQeUcwN3FPSzJOWkVaTE1FN28wOWVFbFlaalhRNG9NblZL?=
 =?utf-8?B?QU5nT1Z6b2FsckZQQm1KcTlWOGJXMmFLUnJIQ1VrekZHNmcxT3ZjakpNTVVL?=
 =?utf-8?B?b0NWYUcybTk4dG9WNDJpeTkzOVcwSjhHUnhvdURvTXpXTENqaENTdDZuQ2ps?=
 =?utf-8?B?T0FGZ2poWEp3WnR6Zmc5aWw0RmlCZDlBWi9aZ1ltOWgxamlaVjZUWFBRdzB5?=
 =?utf-8?B?WUhrZGljTEpWMHhJUHEwMCsxdlRCeHhZNjFEU1dReEtRbTVYeVZTRGI1bm40?=
 =?utf-8?B?VzFsdXlJeEZ4a1BuN3RnUHA0QmZNZElORiszQUxuQWpzWC8yMWwxQ0g0aTEw?=
 =?utf-8?B?SVFNMHRoVjBhdWpzL1NFVFgybmQxd3Y0dHFXYWxQeVQxMWI1ZWFHVDExTmth?=
 =?utf-8?B?bTc2Z3hRVnVtdGFUVW8wT0FaMTB1dUJ3SENqNjFlQ2pUYk1la0RUVm5kY0d1?=
 =?utf-8?B?aE5XQ21Wdk9DWVhGejA3VE5jcWdVdGVDQ3ZkbUFlR01haE1aMmJYVzZNQ3Jh?=
 =?utf-8?B?aWJiM2ZaTVBmdUc2cFVIRU9KcE40K2VLMnFnN2VISWlXaWZxKzc5S1ZBK1VF?=
 =?utf-8?B?TXRDanhiRnZnanBxZER6Y0hvOW40NXJMakdhN2VMODMvZVJkNnErcXJscEIw?=
 =?utf-8?B?bVJPMVdCY1o4US9ZSDBkUzlmMzBuN0dSVytIYjJBT25RRXMxd0Q3RkFhMGp2?=
 =?utf-8?B?ekNMd0JVTm1uaFhXNEpxa1d0c3NBWjFQUHF6bmk5VEsrOE1SVU9NVnNqL2or?=
 =?utf-8?B?SHNLUHVLakRBTDFhNXdKQzNzUjdidHdJdkcwTW5MQXlGVTFnZnFCUENRQTln?=
 =?utf-8?B?M3hHQVFtY3BBRStSSFQ3K0pURDVSTlhUcVFQNDF2Q251Q3I3aVBIYis2RlZX?=
 =?utf-8?Q?tBuyDQ2o9hxq95/s6U7jjnSbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PC5EAUM08gVVrRhGLZT1xH23i5Dd6+tff8+DKHhp0Kmsdg1NYx5RveHyA9a99gOW7tY2akCDzE6kUL34rfyu9VTcsSBjZePh7FQSxhX9gZoQ97dyw9IskfS5DPdO/RLIJJMtlLPpL48Pzyp+fpZAs+qDExX+mVdL78DHtMnaWY9l+MGXp6x6qSo+AilG1JDuqWbnZtSq6852zfn0CoPUQ2yXrYEdk5jcjKn6L4xCziQQHYtJoJWbZJCZtnQjTfM+CP54/KSZiQ4xdc0G6coSLqwlOcI1wZ98cFlY+AWYoHN4eMbSwL0rbvEyoCilnelU603tghPG6iOjoHouIYATMKePGS0bVjm3fY3HCLpXuuaDBG2ccwluOU90zmyFV6+KCQ2hWOzChpnhRgJzvy8F6QLZ+9oHCEsb0eLig3zsmc10hikMmvEZLxtns6QvMbTc8/47sb/CGmEdkAIL93YWTF2v7vtzUhHPEUoRsR9d4hBj0i3CKp1fef1AklvEb0ByycuLDe4vwq0SLl+HvcPntQIF7tccycDwYHGS4jCgrFdhbKklp2wM6SAvXfqcLcnqVF69fbgSn9tkTk8065skepByCcG8izv1NtGKyerTRlkKUHJJ9BnItl/15Hw88xV4n0N/KdyyK3rYMeIFb/GLRW10hkKXxPDhLrTUL6fYLzvT6XT2RvlY97nBt/MPvizS1+y2DZmjfbZMBX84tJbMCkEqz+UFUqdl76Q4rmxOkEi/1DOuhzzKFTrcsqy9WfPA5KKLryh1PP74pqCzjEPJfxgmIzKe/HT70gR5d/aGa0qW6FxNFLXVLRcpmAtL67UPTHCg4zgqK/ckL5vnvHU9Vw==
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8848.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3c9f71-ba92-4648-6b63-08db2b802d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 09:22:52.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhXzUvd+dpXhjqibkc12LHX8uclYaVt0zZU1JPAe+2bNt/hgm/XfZu697GCV+NJRXwd8eKi+QM8H3gflPV0NBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9271
X-Proofpoint-GUID: z2KcIHgQOhq8fUH4cX9M_hoxxSEVP_75
X-Proofpoint-ORIG-GUID: z2KcIHgQOhq8fUH4cX9M_hoxxSEVP_75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=963 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230069
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEkgRG1pcnR5LA0KDQpUaGFua3MgZm9yIFJldmlld3MgLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IERtaXRyeSBCYXJ5c2hrb3YgPGRtaXRyeS5iYXJ5c2hrb3ZAbGlu
YXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE2LCAyMDIzIDY6MDggUE0NCj4gVG86
IFZpc3dhbmF0aCBCb21hIChUZW1wKSAoUVVJQykgPHF1aWNfdmJvbWFAcXVpY2luYy5jb20+Ow0K
PiBzdGFuaW1pci52YXJiYW5vdkBsaW5hcm8ub3JnOyBWaWthc2ggR2Fyb2RpYSAoUVVJQykNCj4g
PHF1aWNfdmdhcm9kaWFAcXVpY2luYy5jb20+OyBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9y
Zz47DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBLb25yYWQgRHliY2lvIDxrb25yYWQu
ZHliY2lvQGxpbmFyby5vcmc+Ow0KPiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2Vy
bmVsLm9yZz47IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21A
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIFYzIDAvMV0gRml4IGZvciBWUDkgRFJDIGFuZCBEZWNvZGVyIFNUT1Ag
aXNzdWUuDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlua3Mgb3IgYXR0YWNobWVu
dHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDE2LzAzLzIwMjMgMTA6MTUs
IHF1aWNfdmJvbWFAcXVpY2luYy5jb20gd3JvdGU6DQo+ID4gRnJvbTogVmlzd2FuYXRoIEJvbWEg
PHF1aWNfdmJvbWFAcXVpY2luYy5jb20+DQo+ID4NCj4gPiBGaXhlZCBpbmRlbnQgY29tbWVudHMs
IGVuc3VyZWQgcmViYXNlIGFuZCBjaGVja3BhdGNoIHdpdGggLS1zdHJpY3QuDQo+ID4gVGVzdGVk
IHRoZSBjaGFuZ2VzIG9uIHY1LjE1IGFuZCB2NS40IGtlcm5lbHMgLg0KPiANCj4gV2FzIGl0IHRl
c3RlZCBvbiB0b3Agb2YgdGhlIHJlY2VudCBrZXJuZWxzPw0KPiANClllcywgRW5zdXJlZCBvbiB0
aGUgbGF0ZXN0IC4NCg0KPiA+IEZvciB0ZXN0aW5nIENocm9tZSBVdGlsaXRpZXMgd2VyZSB1c2Vk
IC4NCj4gPg0KPiA+IFZpc3dhbmF0aCBCb21hICgxKToNCj4gPiAgICB2ZW51czogRW5hYmxlIHN1
ZmZpY2llbnQgc2VxdWVuY2UgY2hhbmdlIHN1cHBvcnQgZm9yIHNjNzE4MCBhbmQgZml4DQo+ID4g
ICAgICBmb3IgRGVjb2RlciBTVE9QIGNvbW1hbmQgaXNzdWUuDQo+ID4NCj4gPiAgIGRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9jb3JlLmggICAgICAgfCAxOCArKysrKysrKysrKysr
KysrKysNCj4gPiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9oZmlfY21kcy5j
ICAgfCAgMSArDQo+ID4gICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvaGZpX2hl
bHBlci5oIHwgIDIgKysNCj4gPiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9o
ZmlfbXNncy5jICAgfCAxMSArKysrKysrKystLQ0KPiA+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9xY29tL3ZlbnVzL3ZkZWMuYyAgICAgICB8IDEyICsrKysrKysrKysrLQ0KPiA+ICAgNSBmaWxl
cyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiAt
LQ0KPiBXaXRoIGJlc3Qgd2lzaGVzDQo+IERtaXRyeQ0KDQo=
