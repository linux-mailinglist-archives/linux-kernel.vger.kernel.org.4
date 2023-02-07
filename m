Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC068D34A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjBGJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:54:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC88EC5D;
        Tue,  7 Feb 2023 01:54:39 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31789g2V022261;
        Tue, 7 Feb 2023 09:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=4iXu1DpY8Log//UrXd00CwDTS6Zkt/Uqvt+xCoydy8M=;
 b=c3SQC5oEtmKXoPbVsCI72LQIfav4mXqOSK4dFiwOw3vfqB6R1lD/g127t1cvVBCEnikp
 V3Q6Oa8HZZvTQYQZLtIKMlM6iRxuYSuoErGcuy+KXPPl54P0BB1FKOp+ksIF4JRV6wMl
 zwxhhX8TZUBE19APbJ9OP7bngMFQnIP+DV1Qbxl7iEMhSVXl4xgXy9pCYAFssL1SJCyg
 rqtdV/vw5Dz+/MHIVonBgMNzIxb4hF+TkkAWMfhh7yHCdfaw7U3Ug1dZVFhfS3B6vkTV
 iaUJGSg9YxpO0IKFgmQ0T2kB2v4ZR+1axntOEiTwF/3TRbBtnQW4HAUnidGZYGGzuSnu rQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkfes8q54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 09:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdTpz6sHHAC8tNttZk4hf3KVYFWZxholYFcoMZ1KG43qnJ142nzUvlGRxn7DsiBJN7bWxCYn/ptHXzA8VjAvf/aSM9yyMh8xdN1s2mDwgejR/95dsPjRO+eqGXiGXEVMlaFGKrZNFmyljmTUwdEBlUr1lwAavMKqUj0xtJXX9k6I5lRqoC3nVz81wOKEZAHmz/JPPL6yHqV3lBNPWXEYKe9Mt7rCf1XtWu7GccxoRdupocC8x52hBsM1Ui/I6iehe/lyKscIEuX3/kA7yQNtX2zeJadFQ5BmoUw1lGsMGyXZW/iGC6i7AZX27Fxy8wFTP7FfGJxE0IBU5zUiW1QhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iXu1DpY8Log//UrXd00CwDTS6Zkt/Uqvt+xCoydy8M=;
 b=k/tJa9muagi0TErr+u+zIm4PMJlm9SoVP59kaE31Nu048EiFEfMP5iPjm4m8yyhpe0+19qsIg4fdcFkv2nVVKLI0uozt59UqTrkO0qeXYoSwbXHMjDevWsfnMaOYf582W7EqmxY9Gx1s8oVSkBu4ALJK1IpQouTqGQzuINLOaWE5XgLZKD7xFUc+w13DY8Nq1RxcL7MVNIVxV2Ckb83ULrqq2Q6gYRDtOSbOVkwCVTirNsT39gDtvWd/IdMgEeGg2uQl2tzyFUDuLy9YqTxHu1yf9KKb3wU3ebIGy+bx4phNfWCvDJcrR6KyHIJgHRTdaZ93v+JLccEmDejpZmgU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8169.namprd02.prod.outlook.com (2603:10b6:8:1a::14) by
 DS7PR02MB9457.namprd02.prod.outlook.com (2603:10b6:8:e4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32; Tue, 7 Feb 2023 09:54:32 +0000
Received: from DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b]) by DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b%3]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 09:54:32 +0000
From:   Vikash Garodia <vgarodia@qti.qualcomm.com>
To:     =?utf-8?B?TWljaGHFgiBLcmF3Y3p5aw==?= <mk@semihalf.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH v2] media: venus: dec: Fix handling of the start cmd
Thread-Topic: [PATCH v2] media: venus: dec: Fix handling of the start cmd
Thread-Index: AQHZNLKHs9xfXF1m4E22SjMycivkWK7DQKeAgAAC7UA=
Date:   Tue, 7 Feb 2023 09:54:32 +0000
Message-ID: <DM8PR02MB8169B2AC8918F8E31628F61AF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
References: <20230130105423.1338554-1-mk@semmihalf.com>
 <20230130135418.1604455-1-mk@semmihalf.com>
 <CAJMMOfNJV+eOqTgUoLLWKQe2MJ=6fXL3aaP6d=YrSBQvfhOXiA@mail.gmail.com>
In-Reply-To: <CAJMMOfNJV+eOqTgUoLLWKQe2MJ=6fXL3aaP6d=YrSBQvfhOXiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8169:EE_|DS7PR02MB9457:EE_
x-ms-office365-filtering-correlation-id: d4cf1ec1-82b7-46d0-88be-08db08f14ffd
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzGRSbELGKtMebxpnn6zweUt3VQKpglIug3urbt2AcH4sQx1x2mGLFKRhVv5XwjVVLYGsD2mnqquTisrGYVSnUCp0pasEnoK2S/Zhj8pynHUNs3iHRqqBPeudPU0iQ0GaOMK91zJr7/nUfypvO+Mqes110z9Qw3hAoCeqbPMFh5QkgM5T0+aj8sadduM+QJBIa8F4RcWZd/bU40MoPzIx1ncW9Rij9UBDPU+s76uiby247PyecsuEX8y5qXUJ63b9+OZbnxA8/El6BXO6om6NkRQg0FF+Eai6WJx9Nawg4JvgA2AmvN6G3N5G+vOhbtJEfg2VcSo9M19ZGll3n4AAh/BVCkHLyR8rJmFsvj6pUBmO77S5ToqZut2lM3d6xhuilpWUfO426CQyJG5YeXsJIbl1Aig8Tz2kVJF46xbjkLaPi12C3ZGizVd89ZSMYfydyxHSNyduKhaVtgn0in8r4F0C9cfPmRl0s6GZVkjyy0zCvlIBrOaNZKCMi5MVsrpQ8EHXm5WnRoxMcIq30psQOrs41N/bDrqBfsPiOgcNxZrNxZmAKKdvkJbiidnBUbU+ioNxsrVEQk+quQ7BgevqHzcTzSNpRYXs9IJL4rRRbHjtYdGAJF32YvEk+Ebud/xuoIVqbO6THONUZkG5ynKfLXAby4oRDeLItR2yh+4d9JAockOrhsrHtI1TmrtYqZnZZ3ORpCYJ1NnokCQ5EGXPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8169.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199018)(54906003)(110136005)(55016003)(33656002)(83380400001)(38070700005)(38100700002)(122000001)(71200400001)(7696005)(478600001)(2906002)(86362001)(6506007)(53546011)(26005)(186003)(52536014)(8676002)(64756008)(66446008)(8936002)(41300700001)(66556008)(4326008)(66476007)(9686003)(5660300002)(7416002)(76116006)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBnWXFWWTdsYTBUcXZqcW9XT01lUWNMTFd0ZWFsQWc4OUZ0ZTRvaS9BdUd6?=
 =?utf-8?B?bjNPY3FrTzYvYlRoSXhlZlRXVGVQNkxWd1RYcWJaZldCQmlLSDc1VEhMTzQz?=
 =?utf-8?B?WFAzVEo0Kzh2VWl6a1VQTTd6aUpCRVFpOVV2NGltYlNsb1JmeDIzdE1QcFds?=
 =?utf-8?B?ci9EZkZpbmlWeWtBazh2THZNZng3djNKWjY0S2JTendWaER1eWFNVXZCa2hm?=
 =?utf-8?B?M3FyNW10SVpXazFnN01JTmNtdVVVamxFUHdXV296eERBUExkSTJIempkR0lP?=
 =?utf-8?B?YVpPUVU4dlA4dEYvcks0R1FUWHA3SDMrWVpOdjU0TzJMOHFwWlNPcjVaV0hE?=
 =?utf-8?B?UXpMUGpGMFdYTFFPT1RZaW9vVEJOd1BDU2xGSWtUcFRSMitGNlN4NDRiQW0y?=
 =?utf-8?B?eFI0L0JrY2hvbVJVK1hRazlCZGZ1b0kzMllta1p1b1NDdnBMQmNjb2ZWVi9Q?=
 =?utf-8?B?YWtLVDA2ZE5XdnpyOVQ4M3BnblVwZENVMVV4c1FwMlorNm9sbytqK2hDS1RK?=
 =?utf-8?B?QjBMQjU3RkR3dTRwYVVWQm1CVVdqZE1XbFhpVmRtajZ6eUNnSmlpamx3Q0VW?=
 =?utf-8?B?Z3dsQUxUNHdlV1JMSmlQREZVUXNLbUNmSjhTQktwOU9jTmpGWWJWZmwvRy9v?=
 =?utf-8?B?eVg2anhGbEFCZnE3eU5Ybkt6bEVzeUEwT1RkMTllajUxcFVWZE8xbjN0ZUtE?=
 =?utf-8?B?bC9pWTNhTVQvMGVrR2VGY213WG53RlVqa0J6UFFRb2xjT0RuVDNSS0xMMTU3?=
 =?utf-8?B?UzkxcmloYitwaVJwVEJYYjZpYmtDb1NTL1RiQ3hiRmVWdnRXY01VVGNydGhv?=
 =?utf-8?B?SStwTkpXMVJyUSs1c1E5akYvelI0Q01FUVVxV0VValZ2WnpKZjU3WitXZllN?=
 =?utf-8?B?R29yWkdlY2tlTkIwYU5tYmJyQlo3WjY1WW5NOXA4RjNxTTQ1REJTaHZCMXNx?=
 =?utf-8?B?Q0N3bEluT2FwcmU1bThXZzNwcjV4Rjl0OEhCZThYZDBDNWh6ckQ2bHkyeEdO?=
 =?utf-8?B?QVVmMEowWjZ3a2pQQ3BtckpabEZma2ZRbkZLM0ZkeDk2VkFjWXBPQ1I1Q3Bx?=
 =?utf-8?B?MkxId0ZGYWZWNkF5dk1Fc1hrK21WUW9LUzVoeTdzdWRYOU1nOVpPWk5YZ1Z1?=
 =?utf-8?B?bSt2NW90UFZRNUpPTGxpVzFGcWNCZ1dkOThwOUJrSFVwM090cmQ5TU5QZmZv?=
 =?utf-8?B?MVhLaXZFMGp6ZVVZQnUxV3JGcEUvRHBtOUFMTURKTnk1eHFmWWx4dVR2ME1W?=
 =?utf-8?B?eWk2WE1xdlBmUGFGVVBBY1JPZC9pN0tuTW92aEVna2dmSmhObDVQbFN1MUEr?=
 =?utf-8?B?QUpydGFFNFhtbkRjbHhOVVVnbko0UDBVeDhlajREYkhVZ2RxZXhXWHFDQ0ox?=
 =?utf-8?B?QU1WbXhPMC9zVVJqb2FGbC91amNsakJMaW5yekJNdEQ4OWx0cHNxMGI4T2g3?=
 =?utf-8?B?dUp3dWV1Y0hWdGxmU3NiQWlFQnRYSXo2c2tKbEp4THQ3UEJtN0dYRE5hVDJq?=
 =?utf-8?B?K0FJNFpXd3l3STVsWUt2cFFySXZObEJ3d0MxdTFTV2J5MTZqK0xWQkZRZGJW?=
 =?utf-8?B?eHVhNGFRbnJxS0ZTeWl6OXEzSTlTUVoxa1VOWjZpUU9VRXZUeU9pbWlzRUo4?=
 =?utf-8?B?TFllZWZlMEFhTTVnbmJFVmNMczY4NG85QXc5M21ZS2tFWmVNMzJOM2UzZm1m?=
 =?utf-8?B?SVg3K2c0Ky9HQzcxL0xjSVowVnlaM250dUc3VWczZVZNcjZ2SVpCTm1zUUF2?=
 =?utf-8?B?TnJjeWJDU1U3Rk4wUWN2QXR1TWdFNTUwVWVEcEYzbkE1YmU0ZDBMNmdzaGJu?=
 =?utf-8?B?RitwWnhJR2ZSZjRrZHlsYzNxdUlObjVXNjZ5L3lGNktBQTAyVjJvYnBiQjJZ?=
 =?utf-8?B?N01FYzFsSzlkWlAzVVo1Q2RHNU5qVmtxQXVwR1FObkJudVFkblhmMStvVzI4?=
 =?utf-8?B?d0FldFFtR2x6MmhFTUFscGwxZCtlMy83VjVtVnllOXdDc210WUp5ZUxDVm94?=
 =?utf-8?B?WGU4RDdwS2czSVNtRkU5cXh5RTYyVDBxZ3JDMGRGTXNKYTdrMnFINVRsZTFG?=
 =?utf-8?B?Q2tUQlphWDlJc1hvYlllSFdTWkRGYVVhS080UDMyL1BsWFR1NzM3VDdTUEZO?=
 =?utf-8?B?SGlCV2ZTVEIrN21QZStjY2szYmlwTzVXYkJZTi94MVRTZlllS0dRZ0FNMWc1?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1OsFMGkYpIMH9HkSUZ8lrM9dV2FxoryFX7rAVw/yw3fWt2/ipAPfKeqLh4eeFSbM1uh/0vc5rU2o36eK5B/1pokaMg9sYzWGOSfjkIZUJ3gYOn7M3Lpqs7F8OSqeHxBuRs5HP20YMIao9eFqQ1YYEH8u6HY7zWI2RD4HKxwJxLA3T2HLIF9vmRP2CU79neEvml+SoBbVLZZtFGVtmIKkhVMZQzk0qEhAwZDuXcQWw8E3I8qFXL0xBdgl7JcxTeqIAFJGjB6wxDwFBY/wTZzfg/sGQN1F7gtEOyhTNpvKsiMo+qoYwFyWEfPEGx543BnTYDN5gVs1rMUVlPeQhQugIhOwHOjsQkrMeCoxU7f0ft2xEOWYaZFIBRwcqweOFlbXU3HsUZHpwHakXZ0aVUA7dSbkEXQgxf2XQ+YzGRwI0+DFSne4uePzAkzvnPmOu+S1ZK79MZuUHcsXj5g2OuHUK4JSWR7hdQOFfTplbOC0sicz/Yu9QMHAlBFA+7to51tnu21RCt0cLMT6OVj2n9E7XHja6R0anDZ4sLB1TLurS/7evq47weGUwGhE8yb5NjMivu49yggldtNflOeSxDtszxl259v3arJe6Y4OGaeB7wrmHM1RePw1lKz6iWOaLJt+wGhgsFJVIeGKcprLp2x3ASEBe7P8/+gYm5t/FAwcDJmo89YN1I1ieFurLP/6Rhkq2dVaQ5tEJip59KEfe4u/AyX+D18i3UODRMOPQ958DUPAbaEZ4cluktHeVl0+LRj2yqqaHg9rRI8pFqu5F7t/vB9CaA6Z8Hi3wnrYwTjSXLWmtJ5pVzFA+6X6S64w31oua3APnQ90Osmn6ogNvt0eV2XWe/chVaNHQX8jzQOaAwI0os9X1VbH0wZelzpg31ftNVb19T7ET+OL0kuTd2K1rw==
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8169.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cf1ec1-82b7-46d0-88be-08db08f14ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 09:54:32.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuLxfMT5bAk+0sNBB/quTBmDgl0rNAxP2EeImy3nP8xdLpLNN/TGFE7WRrymHovvU2BaWZNK5D4TM9Ln+9PfKXTRUWKgvmnFFWlpGVWPX5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9457
X-Proofpoint-GUID: KNSfX5GrShFgTxA2tuAcHY4z5FWUMas1
X-Proofpoint-ORIG-GUID: KNSfX5GrShFgTxA2tuAcHY4z5FWUMas1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 mlxlogscore=672 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWljaGFsLA0KVGhhbmsgeW91IGZvciByYWlzaW5nIGEgZml4IGluIHZpZGVvIGRyaXZl
ci4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYcWCIEtyYXdj
enlrIDxta0BzZW1paGFsZi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjMg
Mjo0OCBQTQ0KPiBUbzogU3RhbmltaXIgVmFyYmFub3YgPHN0YW5pbWlyLmsudmFyYmFub3ZAZ21h
aWwuY29tPjsgVmlrYXNoIEdhcm9kaWENCj4gKFFVSUMpIDxxdWljX3ZnYXJvZGlhQHF1aWNpbmMu
Y29tPg0KPiBDYzogQW5keSBHcm9zcyA8YWdyb3NzQGtlcm5lbC5vcmc+OyBCam9ybiBBbmRlcnNz
b24NCj4gPGFuZGVyc3NvbkBrZXJuZWwub3JnPjsgS29ucmFkIER5YmNpbyA8a29ucmFkLmR5YmNp
b0BsaW5hcm8ub3JnPjsgTWF1cm8NCj4gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5v
cmc+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhcm0tbXNtQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbXdAc2VtaWhhbGYuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIG1lZGlhOiB2ZW51czogZGVjOiBGaXggaGFuZGxp
bmcgb2YgdGhlIHN0YXJ0IGNtZA0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBwb24uLCAz
MCBzdHkgMjAyMyBvIDE0OjU1IE1pY2hhxYIgS3Jhd2N6eWsgPG1rQHNlbWloYWxmLmNvbT4gbmFw
aXNhxYIoYSk6DQo+ID4NCj4gPiBGcm9tOiBNaWNoYcWCIEtyYXdjenlrIDxta0BzZW1paGFsZi5j
b20+DQo+ID4NCj4gPiBUaGUgZGVjb2RlciBkcml2ZXIgc2hvdWxkIGNsZWFyIHRoZSBsYXN0X2J1
ZmZlcl9kZXF1ZXVlZCBmbGFnIG9mIHRoZQ0KPiA+IGNhcHR1cmUgcXVldWUgdXBvbiByZWNlaXZp
bmcgVjRMMl9ERUNfQ01EX1NUQVJULg0KPiA+DQo+ID4gVGhlIGxhc3RfYnVmZmVyX2RlcXVldWVk
IGZsYWcgaXMgc2V0IHVwb24gcmVjZWl2aW5nIEVPUyAod2hpY2ggYWx3YXlzDQo+ID4gaGFwcGVu
cyB1cG9uIHJlY2VpdmluZyBWNEwyX0RFQ19DTURfU1RPUCkuDQo+ID4NCj4gPiBXaXRob3V0IHRo
aXMgcGF0Y2gsIGFmdGVyIGlzc3VpbmcgdGhlIFY0TDJfREVDX0NNRF9TVE9QIGFuZA0KPiA+IFY0
TDJfREVDX0NNRF9TVEFSVCwgdGhlIHZiMl9kcWJ1ZigpIGZ1bmN0aW9uIHdpbGwgYWx3YXlzIGZh
aWwsIGV2ZW4gaWYNCj4gPiB0aGUgYnVmZmVycyBhcmUgY29tcGxldGVkIGJ5IHRoZSBoYXJkd2Fy
ZS4NCj4gPg0KPiA+IEZpeGVzOiBiZWFjODI5MDRhODcgKCJtZWRpYTogdmVudXM6IG1ha2UgZGVj
b2RlciBjb21wbGlhbnQgd2l0aA0KPiA+IHN0YXRlZnVsIGNvZGVjIEFQSSIpDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYcWCIEtyYXdjenlrIDxta0BzZW1paGFsZi5jb20+DQo+IA0KPiBI
ZWxsbywNCj4gDQo+IERpZCBhbnlvbmUgaGF2ZSBhIGNoYW5jZSB0byB0YWtlIGEgbG9vayBhdCB0
aGlzIHBhdGNoPyBJdCdzIGZhaXJseSBzaW1wbGUsIGJ1dCBsYWNrDQo+IG9mIHRoaXMgZml4IGNh
biBoYXZlIGEgYmlnIGltcGFjdCBvbiB0aGUgVjRMMiBhcHBsaWNhdGlvbnMgd2hpY2ggaW1wbGVt
ZW50IHRoZQ0KPiBmbHVzaCBtZWNoYW5pc20gdXNpbmcgdGhlIHN0b3Avc3RhcnQgY29tbWFuZHMs
IGVzcGVjaWFsbHkgaW4gdGhlIG1pZGRsZSBvZiB0aGUNCj4gdmlkZW8uDQoNCkkgaGF2ZSByZXZp
ZXdlZCB0aGUgcGF0Y2gsIGFuZCB0aGUgZHJhaW4gc2VxdWVuY2UgaGFuZGxpbmcgbG9va3MgZ29v
ZCB0byBtZS4NCkNvdWxkIHlvdSBzaGFyZSBzb21lIGRldGFpbHMgb24gdGhlIHRlc3QgY2xpZW50
IHdoaWNoIHlvdSBhcmUgdXNpbmcgdG8gY2F0Y2ggdGhpcyBpc3N1ZSA/DQoNCj4gVGhhbmsgeW91
LA0KPiBNaWNoYcWCDQoNClRoYW5rcywNClZpa2FzaA0K
