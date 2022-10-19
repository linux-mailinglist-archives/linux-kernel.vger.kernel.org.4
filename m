Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC034605126
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJSUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJSUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:16:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41721CA5A8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:16:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JKDxUC027551;
        Wed, 19 Oct 2022 20:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=c1MIpxwMNB6QID3tO+pQtGF80UWxEQNLI74daumVWus=;
 b=mmGTp9HzVm9YbVmkTS73pQvyxSokMHY+j8QkPPDopeZm6v9ERHjLSxfrONhuhbI4HcXg
 g9WeLgkWqvATg+kEncIgdLHzVrVYhELLwUPeMAJhlZDW2j3CcKpadz6cZj2bJToJHDbw
 rJy5guxuMkopyRJ2RLTNWvBExrAXGgZjSAr6pTwZP5qCEuNs/1LOfbD4eSqhKTfGEZXi
 xfSGnlbWgAN2MpFPRmDr7b2DPZUkLPANozhYR6PvjikPypYrhM+8gNRkob1gGGg56s4q
 HBMnwDNOmT6HYvlnB4RMlVnKV2TT3VPA3sY6OetGD7zb2ue22hbjpT/0sNMktfNc5QZK Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtkrwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:16:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo6ss002725;
        Wed, 19 Oct 2022 20:16:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hthwg5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX6AVzMmAlzEWwSc4pcL1yOCTaFGauAYblSXEzIdO86NgCvWXlutC4Ao5x3HJjmzGKwEJQoAmdpzalkYs5rYXcLiv6fZBgex1BcZBuQu7SNlqEBC73bTy2H4kVs4Tnz3fMSboYjuCQyDssAKGZ3wo8kLGJqpiqBrJ7eTl965vZhBODpuLEkGLp5cboq6pCLCwXSSECAGZlvA1yo+chbn8XvQ6I6gZfom+1lwm05XP1QinsF5p9S0uiBVEFaLzT5LfshDavxfzm0U8UhNfF6SnQjhqqOPABBibAjNTeOoGR5e6BP23emNCPTa3b59Go8eLqx5wpKb2+S+msyx4EHnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1MIpxwMNB6QID3tO+pQtGF80UWxEQNLI74daumVWus=;
 b=hoViYQANySov3HgIHVfH6llasvLe3C3jlSxu+fgXLGlpCtxZVM96kicaweaHB8dNs4WMV4XnZgBt7hrS3jl8QvifYICGUdAMKjH3vaPt3EYvYGowsFdZwlXu3KV4T8SrkpWW76wcBYPk3vIyPwo1c9V+8ql9RrhX3N7dOAiKf0PKT2+/68/5GMRu+pHz2/mqkAVvSfdH8cZbw0M4omoLEPY2D/eTDwNhdH+xPwpsCE3Dek1FZkOdwkCCv5ZUQhyv3pc8krbrkkf/ecejogOZpF0OWK+HQTpvGtAwhQH0G8abjCCAswXAuM0H6hyxpkTemuqPMZ8yHrQgqmC9bykT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1MIpxwMNB6QID3tO+pQtGF80UWxEQNLI74daumVWus=;
 b=YpXwB12QZf1vmz2Z4z16syKHP/Ku8yTQPIk1sEDJ4j4rnA3KcNndQB5cJFGaOalLP9TJlIPRI6tome2B8U2TuU8ZkXbc6NlF7w+xzC3hL1y1DO6+GMvR2vx/dcjADt3ZJfIycb6QwL8SuGrr48Yesh9w9rVVVoTnkVbb+JNpds4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 20:16:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 20:16:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Topic: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6ICAASC+AIAAZ7WAgAAT+ICAAAYogIAABW6AgAFtFICAAA4jgIAADdmA
Date:   Wed, 19 Oct 2022 20:16:17 +0000
Message-ID: <a555035a-0905-7c7c-bc8e-d5512ca8a84a@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
 <Y08RVzvniYr8ycKV@smile.fi.intel.com>
 <bb8a2add-2b6e-c35c-ff5b-a7816eeb7e26@oracle.com>
 <Y1BPc8JsEoApKJkL@smile.fi.intel.com>
In-Reply-To: <Y1BPc8JsEoApKJkL@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|DS7PR10MB5181:EE_
x-ms-office365-filtering-correlation-id: 28dafc99-c296-4a99-a156-08dab20ec7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/U7GQgeqy2ewanqaRatMsJVf9PcfVbxf5Cu3qNExRScrZ31GqOwmlr40yjgX2zrkdWY24kdipECg+NgDCJmMdDz1A/6pqofiVW/QcNwDde4JjTgeF9314100+oDbbVbgROo3x+RM8GVeEvI/LjnAtjmgd86Oo41BMCnmh9qaK5JOc+mDZoyLuT5VkyOkNtqAjybVGFdi2Unc477NL2E64cRNN26xsk7GGe1AXa3lP5lhsA1s/0AB6pilaG5HnPKDD1xBpa/Ux8lxf9A39+qcfxDmEhMDf6v4QKV2X6NH35kvOm9jDffVl8dupNoR1ecwH6nI/WUij1A0EYJrxrxHD1L8RI+HQn6ea5ZuhucO8MfGwxqithroRCHUI4v/UNvvbVe8M1Qys39UNC6ptmnf8DamrtfVwdV10qOZRQf3XzzHY6pNEpftXfPHfJozk3EMCE0HWjSUtUNI5VVPZBg8/tnhme8U7pV7hWXIS8wcCFydxmB6XfEs0oS2YKc/sxyP3YMXok9bkzyfsE8v4l92KEDEM56360cpgZYTrc3HkhxdciU96jcNJ8/3PysEPKBd0Z03/hFvLW0grPWqaGxCIHPmNiIU1MZ+HktVA7GxQciaAxmTXD4u8zm8RPjG9lIH74fnbbR+HfoyQ/e3iUyuK/5Wd+0ar6w4d2YdZizdgysUc1uJsetu9NsGmMEY7RYsI0AM1gSkIKhjd7z/VYFndPpUJ3m63Bov9SPtdUpJhKALyYv66sSzcqnx3HtGQRMjeILYUKD3qgkjKD7gRS/KqOwwsOKnHQyau+2pgydMMeBLPH1mInx+kQTF+xeOYMjM9OEJZcgL7xv7ZnBqJPUXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(6512007)(107886003)(53546011)(186003)(26005)(6506007)(83380400001)(4001150100001)(2906002)(5660300002)(2616005)(44832011)(8936002)(4326008)(478600001)(6486002)(316002)(41300700001)(64756008)(66476007)(6916009)(8676002)(66556008)(66946007)(71200400001)(76116006)(54906003)(66446008)(31696002)(36756003)(86362001)(38100700002)(122000001)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHRyMXdyaDA3cStrNERoT1h2aUVXUEtVRnhqZGwzeGh5aUdjNXRMOVpUWjI5?=
 =?utf-8?B?OFBONUxzcVQ0T1VsUFl2SEliYjJScTlWY2p3d09kSVJ0T3paQXZhZVpCajNs?=
 =?utf-8?B?MHJwVnR6ZXNsYmM2YUszTTBDdjJ1anN2RUZpOWpvRTdUOUh5azQ2WmpJcTAr?=
 =?utf-8?B?VTEzVXZJSVdDL0I3bkdlNUtPNkdlckwyN3dyeGw5elV0STBYVVRWZWRZUmZM?=
 =?utf-8?B?OGxGa0FJYldFNmY1aW54N3NpbnZSODF2UkdwbjRNNndpc1cycFFCYlFCQUg4?=
 =?utf-8?B?L2U0dm9RcnlDU3l1WmdWbS9tNzVaV0c4VXNvOHIxYkdHbmFsZDE4NHRZKzhl?=
 =?utf-8?B?aHlsZEgvNUltZ0RwemdVQTdzdVZXU3JMMGo2WXFjeGZNYzRhQXdBcExPRE55?=
 =?utf-8?B?WkVqUW5EZDFCVDRLN2pOb2Z6S2VvN3N2WXBWZEkrVStUcjRGY2NWanZscWE1?=
 =?utf-8?B?djdncWdoNkJMMU5nbmMyZGNjdXpyU1lpVWI3NEdRL3ZIVWpxUGNDNmVwUklR?=
 =?utf-8?B?T1JZbitTOXZFR2JPSGlTTUJqSm4wNGtrR2ljZTJ2dEx4cFEyNm5pM2Z2VzRZ?=
 =?utf-8?B?Y0JQcEwwNCtXR0xUNU1EUTBwK1pWemJlaThjVnpIblc5NTZoNnN4MVlZejVK?=
 =?utf-8?B?aFFFdkREMVNUTkRDT0VERzRJRVBpbFRvMGI3R1ZKSTZ6SWtnUWp5MlBtRUMw?=
 =?utf-8?B?RXJrNWZXWldVUmdXeEFYd2NITFZxTWF0ekMrWGFRbHdsYytsZnh5UjVOQzdU?=
 =?utf-8?B?dk01QVQwODZTVW1Lck0zOU8rZzNxUHVaMVE3VEZ0dWlDazNhM08zVDVGUko3?=
 =?utf-8?B?Umc3TC9wZVlwcndMNDZNSlpVTTNCejZvUStwQTg3V0gwQXBPRmMxM2RGQUY0?=
 =?utf-8?B?WFp5R3Z1STBwc2kwamQxSjRsOXI2T1V5THBUTEd0MUwzVnN3TERvM3NVTlFJ?=
 =?utf-8?B?L0NxaHNLT1NSbWxrSlVCcTA0RTlrSncxaEp1WkxOaHVUaUtZam8rWDhhcFdF?=
 =?utf-8?B?OW40Y3Y1TkhwS200bWNjNlFhTGtkZkxpN3FXS3h1aFgzSmwzcVp6VThYa2E2?=
 =?utf-8?B?MHJZd1pQZXhlek81bmRnZE5jNjdwU2xhUVhuT3Z6YkRNdks0anpiZUdFNXRo?=
 =?utf-8?B?dzMrRG9qMThHSWd0Sms3NTg3T3NzZlBxZkxvMEs1cGlLRFJ5MGlyLzJhQ2pw?=
 =?utf-8?B?VTVuUHVCek5DOVFGTWFvcCtaYm1VbG9jaFVUOU5GT2RpY3U1VWNOa09Remxv?=
 =?utf-8?B?K3ByeGgzakVwTkhZZnlGcnI0VnRXd3BBcCtoTzVlNFZOSTh0czRzNGhCOU9S?=
 =?utf-8?B?d0VHalllTFVrbzg1eTBKNUJsNDZjK0V6M2s1RVpXSDc4T3J2Nlc5bzFPN3F1?=
 =?utf-8?B?eGFINzZ6THo5LzlhSHJlUnRaMmk5MGlLU1Q2ejRFVzVxaW11ZXo5S3dlL01n?=
 =?utf-8?B?dEx3T0hLSG00Wkd3VFFLVzc4L1BWbHh2YXAxVFg3ZHZSWFlYQU1lRHJrcmd4?=
 =?utf-8?B?Qm9jMVBZMDdES1U5VzZiOHV3c280bWZ5MU95T2MxSit6L2FTb1g3d1F2UXFJ?=
 =?utf-8?B?NW5MbjFFR0lWMVBJUS9NcVJlSjVRckNwcmhuQnRSbElPN2l3M2hYWGk4M0VS?=
 =?utf-8?B?ZEFkOWFmbCtLd3diTklFWC92SHRsemRySFAxZnJlaDU1K1ZvU3Bzc05NTXhz?=
 =?utf-8?B?b3hlLzhBNnV6TWQxTDFFK1JraElqNWRuMkJoUitIazRKU3c2QzQ5Q2grcy9U?=
 =?utf-8?B?NHRtYjRHbFJselpub3drU3RPQTNHN0V2cGxGbDNPamdSdDlOLzFzdyt5dlUr?=
 =?utf-8?B?eXc4T2Z0UWVkYzZlN3Fia2VSUlJVODJ1YXN5b1lhbjNpa0ZFVGNIdHJBUlhR?=
 =?utf-8?B?ZzZNelY3d3p4bmwvSzlSc2IyTUxlakFnK093TlRUeFhyYWkvZitSbm9VWTM5?=
 =?utf-8?B?OFh0Qm1QeS9ldVg4dFRKQ0ZqOFhMWDRpOU1PZXB5bWs4Zm1QcUZSeWRCVHNB?=
 =?utf-8?B?UDlLQzlMZWlHQkZJenJudVdlQUNMMFpDOHowaVlBdXVTbVpudUt3aW5XeEhu?=
 =?utf-8?B?N1prbi8zR1ZScUh2NnlzRnpwVnlCZVE2Tm9aaU5jem5nWDIzZklOVFAwei9X?=
 =?utf-8?Q?BD+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F54DDA3F57596242A2D2115C3830F233@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dafc99-c296-4a99-a156-08dab20ec7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 20:16:18.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6R/MAZVrN/8hmOWHGzHq0TqEaZuoTCHUJKL+tDkgpAMFMl2ITkZVg8Ci7hBGoh74UNMP+Dgb3XHlUiXZ6ySwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_12,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190113
X-Proofpoint-ORIG-GUID: 3WZkjeds-4kD4I0F0IlLNqhwTLrfJg-5
X-Proofpoint-GUID: 3WZkjeds-4kD4I0F0IlLNqhwTLrfJg-5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTkvMjAyMiAxMjoyNiBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQs
IE9jdCAxOSwgMjAyMiBhdCAwNjozNjowN1BNICswMDAwLCBKYW5lIENodSB3cm90ZToNCj4+IE9u
IDEwLzE4LzIwMjIgMTo0OSBQTSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIFR1ZSwg
T2N0IDE4LCAyMDIyIGF0IDA4OjMwOjAxUE0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+PiBP
biAxMC8xOC8yMDIyIDE6MDcgUE0sIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+IE9uIFR1
ZSwgT2N0IDE4LCAyMDIyIGF0IDA2OjU2OjMxUE0gKzAwMDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+
Pj4+IE9uIDEwLzE4LzIwMjIgNTo0NSBBTSwgUGV0ciBNbGFkZWsgd3JvdGU6DQo+Pj4+Pj4+IE9u
IE1vbiAyMDIyLTEwLTE3IDE5OjMxOjUzLCBKYW5lIENodSB3cm90ZToNCj4+Pj4+Pj4+IE9uIDEw
LzE3LzIwMjIgMTI6MjUgUE0sIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBN
b24sIE9jdCAxNywgMjAyMiBhdCAwMToxNjoxMVBNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+
Pj4+Pj4+Pj4gV2hpbGUgZGVidWdnaW5nIGEgc2VwYXJhdGUgaXNzdWUsIGl0IHdhcyBmb3VuZCB0
aGF0IGFuIGludmFsaWQgc3RyaW5nDQo+Pj4+Pj4+Pj4+IHBvaW50ZXIgY291bGQgdmVyeSB3ZWxs
IGNvbnRhaW4gYSBub24tY2FuaWNhbCBhZGRyZXNzLCBzdWNoIGFzDQo+Pj4+Pj4+Pj4+IDB4NzY2
NTY0NWY2MzYxNjQ2NS4gSW4gdGhhdCBjYXNlLCB0aGlzIGxpbmUgb2YgZGVmZW5zZSBpc24ndCBl
bm91Z2gNCj4+Pj4+Pj4+Pj4gdG8gcHJvdGVjdCB0aGUga2VybmVsIGZyb20gY3Jhc2hpbmcgZHVl
IHRvIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdA0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiAJaWYg
KCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRyKSkNCj4+
Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgcmV0dXJuICIoZWZhdWx0KSI7DQo+Pj4+Pj4+
Pj4+DQo+Pj4+Pj4+Pj4+IFNvIGluc3RlYWQsIHVzZSBrZXJuX2FkZHJfdmFsaWQoKSB0byB2YWxp
ZGF0ZSB0aGUgc3RyaW5nIHBvaW50ZXIuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBIb3cgZGlkIHlv
dSBjaGVjayB0aGF0IHZhbHVlIG9mIHRoZSAoaW52YWxpZCBzdHJpbmcpIHBvaW50ZXI/DQo+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJbiB0aGUgYnVnIHNjZW5hcmlvLCB0aGUgaW52YWxp
ZCBzdHJpbmcgcG9pbnRlciB3YXMgYW4gb3V0LW9mLWJvdW5kDQo+Pj4+Pj4+PiBzdHJpbmcgcG9p
bnRlci4gV2hpbGUgdGhlIE9PQiByZWZlcmVuY2luZyBpcyBmaXhlZCwNCj4+Pj4+Pj4NCj4+Pj4+
Pj4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgZml4ZWQg
T09CPw0KPj4+Pj4+PiBXaGF0IGV4YWN0IHZzcHJpbnRmKCkvcHJpbnRrKCkgY2FsbCB3YXMgYnJv
a2VuIGFuZCBldmVudHVhbGx5DQo+Pj4+Pj4+IGhvdyBpdCB3YXMgZml4ZWQsIHBsZWFzZT8NCj4+
Pj4+Pg0KPj4+Pj4+IEZvciBzZW5zaXRpdmUgcmVhc29uLCBJJ2QgbGlrZSB0byBhdm9pZCBtZW50
aW9uaW5nIHRoZSBzcGVjaWZpYyBuYW1lIG9mDQo+Pj4+Pj4gdGhlIHN5c2ZzIGF0dHJpYnV0ZSBp
biB0aGUgYnVnLCBpbnN0ZWFkLCBqdXN0IGNhbGwgaXQgImRldlhfYXR0cllbXSIsDQo+Pj4+Pj4g
YW5kIGRlc2NyaWJlIHRoZSBwcmVjaXNlIG5hdHVyZSBvZiB0aGUgaXNzdWUuDQo+Pj4+Pj4NCj4+
Pj4+PiBkZXZYX2F0dHJZW10gaXMgYSBzdHJpbmcgYXJyYXksIGRlY2xhcmVkIGFuZCBmaWxsZWQg
YXQgY29tcGlsZSB0aW1lLA0KPj4+Pj4+IGxpa2UNCj4+Pj4+PiAgICAgICBjb25zdCBjaGFyIGNv
bnN0IGRldlhfYXR0cllbXSA9IHsNCj4+Pj4+PiAJW0FUVFJZX0FdID0gIkRldiBYIEF0dHJpYnV0
ZVkgQSIsDQo+Pj4+Pj4gCVtBVFRSWV9CXSA9ICJEZXYgWCBBdHRyaWJ1dGVZIEIiLA0KPj4+Pj4+
IAkuLi4NCj4+Pj4+PiAJW0FUVFJZX0ddID0gIkRldiBYIEF0dHJpYnV0ZVkgRyIsDQo+Pj4+Pj4g
ICAgICAgfQ0KPj4+Pj4+IHN1Y2ggdGhhdCwgd2hlbiB1c2VyICJjYXQgL3N5cy9kZXZpY2VzL3N5
c3RlbXMvLi4uL2F0dHJ5XzEiLA0KPj4+Pj4+ICJEZXYgWCBBdHRyaWJ1dGVZIEIiIHdpbGwgc2hv
dyB1cCBpbiB0aGUgdGVybWluYWwuDQo+Pj4+Pj4gVGhhdCdzIGl0LCBubyBtb3JlIHJlZmVyZW5j
ZSB0byB0aGUgcG9pbnRlciBkZXZYX2F0dHJZW0FUVFJZX0JdIGFmdGVyIHRoYXQuDQo+Pj4+Pj4N
Cj4+Pj4+PiBUaGUgYnVnIHdhcyB0aGF0IHRoZSBpbmRleCB0byB0aGUgYXJyYXkgd2FzIHdyb25n
ZnVsbHkgcHJvZHVjZWQsDQo+Pj4+Pj4gbGVhZGluZyB1cCB0byBPT0IsIGUuZy4gZGV2WF9hdHRy
WVsxMV0uICBUaGUgZml4IHdhcyB0byBmaXggdGhlDQo+Pj4+Pj4gY2FsY3VsYXRpb24gYW5kIHRo
YXQgaXMgbm90IGFuIHVwc3RyZWFtIGZpeC4NCj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gdGhl
IGxpbmdlcmluZyBpc3N1ZQ0KPj4+Pj4+Pj4gaXMgdGhhdCB0aGUga2VybmVsIG91Z2h0IHRvIGJl
IGFibGUgdG8gcHJvdGVjdCBpdHNlbGYsIGFzIHRoZSBwb2ludGVyDQo+Pj4+Pj4+PiBjb250YWlu
cyBhIG5vbi1jYW5vbmljYWwgYWRkcmVzcy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2FzIHRoZSBwb2lu
dGVyIHVzZWQgb25seSBieSB0aGUgdnNwcmludGYoKT8NCj4+Pj4+Pj4gT3Igd2FzIGl0IGFjY2Vz
c2VkIGFsc28gYnkgYW5vdGhlciBjb2RlLCBwbGVhc2U/DQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgT09C
IHBvaW50ZXIgd2FzIHVzZWQgb25seSBieSB2c3ByaW50ZigpIGZvciB0aGUgImNhdCIgc3lzZnMg
Y2FzZS4NCj4+Pj4+PiBObyBvdGhlciBjb2RlIHVzZXMgdGhlIE9PQiBwb2ludGVyLCB2ZXJpZmll
ZCBib3RoIGJ5IGNvZGUgZXhhbWluYXRpb24NCj4+Pj4+PiBhbmQgdGVzdC4NCj4+Pj4+DQo+Pj4+
PiBTbywgdGhlbiB0aGUgdnNwcmludGYoKSBpcyBfdGhlXyBwb2ludCB0byBjcmFzaCBhbmQgd2h5
IHNob3VsZCB3ZSBoaWRlIHRoYXQ/DQo+Pj4+PiBCZWNhdXNlIG9mIHRoZSBjcmFzaCB5b3UgZm91
bmQgdGhlIGN1bHByaXQsIHJpZ2h0PyBUaGUgZWZhdWx0IHdpbGwgaGlkZSB2ZXJ5DQo+Pj4+PiBp
bXBvcnRhbnQgZGV0YWlscy4NCj4+Pj4+DQo+Pj4+PiBTbyB0byBtZSBpdCBzb3VuZHMgbGlrZSBJ
IGxpa2UgdGhpcyBjaGFuZ2UgbGVzcyBhbmQgbGVzcy4uLg0KPj4+Pg0KPj4+PiBXaGF0IGFib3V0
IHRoZSBleGlzdGluZyBjaGVjaw0KPj4+PiAgICAgCWlmICgodW5zaWduZWQgbG9uZylwdHIgPCBQ
QUdFX1NJWkUgfHwgSVNfRVJSX1ZBTFVFKHB0cikpDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuICIoZWZhdWx0KSI7DQo+Pj4+ID8NCj4+Pg0KPj4+IEJlY2F1c2UgaXQncyBfc3Bl
Y2lhbF8uIFdlIGtub3cgdGhhdCBGaXJzdCBwYWdlIGlzIGVxdWl2YWxlbnQgdG8gYSBOVUxMIHBv
aW50ZXINCj4+PiBhbmQgdGhlIGxhc3Qgb25lIGlzIGRlZGljYXRlZCBmb3Igc28gY2FsbGVkIGVy
cm9yIHBvaW50ZXJzLiBUaGVyZSBhcmUgbm8gbW9yZQ0KPj4+IHNwZWNpYWwgZXhjZXB0aW9ucyB0
byB0aGUgYWRkcmVzc2VzIGluIHRoZSBMaW51eCBrZXJuZWwgKEkgZG9uJ3QgdGFsayBhYm91dA0K
Pj4+IGFsaWdubWVudCByZXF1aXJlbWVudHMgYnkgdGhlIGNlcnRhaW4gYXJjaGl0ZWN0dXJlcyku
DQo+Pj4NCj4+Pj4gSW4gYW4gZXhwZXJpbWVudCBqdXN0IHRvIHByaW50IHRoZSByYXcgT09CIHBv
aW50ZXIgdmFsdWVzLCBJIHNhdyBiZWxvdw0KPj4+PiAodGhlIGRldlggYXR0clkgc3R1ZmYgYXJl
IHN1YnN0aXR1dGVzIG9mIHRoZSByZWFsIGF0dHJpYnV0ZXMsIG90aGVyDQo+Pj4+IHZhbHVlcyBh
bmQgc3RyaW5ncyBhcmUgdmVyYmF0aW0gY29weSBmcm9tICJkbWVzZyIpOg0KPj4+Pg0KPj4+PiBb
IDMwMDIuNzcyMzI5XSBkZXZYX2F0dHJZWzI2XTogKGZmZmZmZmZmODRkNjBhZDMpIERldiBYIEF0
dHJpYnV0ZVkgRQ0KPj4+PiBbIDMwMDIuNzcyMzQ2XSBkZXZYX2F0dHJZWzI3XTogKGZmZmZmZmZm
ODRkNjBhZTQpIERldiBYIEF0dHJpYnV0ZVkgRg0KPj4+PiBbIDMwMDIuNzcyMzQ3XSBkZXZYX2F0
dHJZWzI4XTogKGZmZmZmZmZmODRkNjBhZWUpIERldiBYIEF0dHJpYnV0ZVkgRw0KPj4+PiBbIDMw
MDIuNzcyMzQ5XSBkZXZYX2F0dHJZWzI5XTogKDApIChudWxsKQ0KPj4+PiBbIDMwMDIuNzcyMzUw
XSBkZXZYX2F0dHJZWzMwXTogKDApIChudWxsKQ0KPj4+PiBbIDMwMDIuNzcyMzUxXSBkZXZYX2F0
dHJZWzMxXTogKDApIChudWxsKQ0KPj4+PiBbIDMwMDIuNzcyMzUyXSBkZXZYX2F0dHJZWzMyXTog
KDc2NjU2NDVmNjM2MTY0NjUpIChlaW52YWwpDQo+Pj4+IFsgMzAwMi43NzIzNTRdIGRldlhfYXR0
cllbMzNdOiAoNjQ2ZTYxNjg1ZjY1NjM2OSkgKGVpbnZhbCkNCj4+Pj4gWyAzMDAyLjc3MjM1NV0g
ZGV2WF9hdHRyWVszNF06ICg2ZjYzNWY2NTc1NWY2NTZjKSAoZWludmFsKQ0KPj4+PiBbIDMwMDIu
NzcyMzU1XSBkZXZYX2F0dHJZWzM1XTogKDc0NmU3NSkgKGVpbnZhbCkNCj4+Pj4NCj4+Pj4gd2hl
cmUgc3RhcnRpbmcgZnJvbSBpbmRleCAyOSBhcmUgYWxsIE9PQiBwb2ludGVycy4NCj4+Pj4NCj4+
Pj4gQXMgeW91IGNhbiBzZWUsIGlmIHRoZSBPT0JzIGFyZSBOVUxMLCAiKG51bGwpIiB3YXMgcHJp
bnRlZCBkdWUgdG8gdGhlDQo+Pj4+IGV4aXN0aW5nIGNoZWNraW5nLCBidXQgd2hlbiB0aGUgT09C
cyBhcmUgdHVybmVkIHRvIG5vbi1jYW5vbmljYWwgd2hpY2gNCj4+Pj4gaXMgZGV0ZWN0YWJsZSwg
dGhlIGZhY3QgdGhlIHBvaW50ZXIgdmFsdWUgZGV2aWF0ZXMgZnJvbQ0KPj4+PiAgICAgIChmZmZm
ZmZmZjg0ZDYwYWVlICsgNCAqIHNpemVvZih2b2lkICopKQ0KPj4+PiBldmlkZW50bHkgc2hvd24g
dGhhdCB0aGUgT09CcyBhcmUgZGV0ZWN0YWJsZS4NCj4+Pj4NCj4+Pj4gVGhlIHF1ZXN0aW9uIHRo
ZW4gaXMgd2h5IHNob3VsZCB0aGUgbm9uLWNhbm9uaWNhbCBPT0JzIGJlIHRyZWF0ZWQNCj4+Pj4g
ZGlmZmVyZW50bHkgZnJvbSBOVUxMIGFuZCBFUlJfVkFMVUU/DQo+Pj4NCj4+PiBPYnZpb3VzbHks
IHRvIHNlZSB0aGUgY3Jhc2guIEFuZCBsZXQga2VybmVsIF90byBjcmFzaF8uIElzbid0IGl0IHdo
YXQgd2UgbmVlZA0KPj4+IHRvIHNlZSBhIGJ1ZyBhcyBlYXJseSBhcyBwb3NzaWJsZT8NCj4+Pg0K
Pj4NCj4+IElmIHRoZSBwdXJwb3NlIGlzIHRvIHNlZSB0aGUgYnVnIGFzIGVhcmx5IGFzIHBvc3Np
YmxlLCB0aGVuIGdldHRpbmcNCj4+ICIoZWZhdWx0KSIgZnJvbSByZWFkaW5nIHN5c2ZzIGF0dHJp
YnV0ZSB3b3VsZCBzZXJ2ZSB0aGUgcHVycG9zZSwgcmlnaHQ/DQo+Pg0KPj4gVGhlIGZhY3QgYW4g
T09CIHBvaW50ZXIgaGFzIGFscmVhZHkgYmVpbmcgdHVybmVkIGludG8gZWl0aGVyIE5VTEwgb3IN
Cj4+IG5vbi1jYW5vbmljYWwgdmFsdWUgaW1wbGllcyB0aGF0ICppZioga2VybmVsIGNvZGUgb3Ro
ZXIgdGhhbg0KPj4gdnNwcmludGYoKSByZWZlcmVuY2VzIHRoZSBwb2ludGVyLCBpdCdsbCBjcmFz
aCBlbHNlIHdoZXJlOw0KPiANCj4gTm8sIG5vdCB0aGUgY2FzZSBmb3IgZXJyb3IgcG9pbnRlcnMg
YW5kIE5VTEwuDQoNClNvcnJ5LCBJIGRvbid0IHVuZGVyc3RhbmQsIHdoYXQgYWJvdXQgT29wcyBm
cm9tIE5VbGwgcG9pbnRlciBkZXJlZmVyZW5jZT8NCg0KPiANCj4+IGJ1dCAqaWYqIG5vDQo+PiBv
dGhlciBjb2RlIHJlZmVyZW5jaW5nIHRoZSBwb2ludGVyLCB3aHkgY3Jhc2g/DQo+IA0KPiBCZWNh
dXNlIGhvdyBlbHNlIHlvdSBjYW4gc2VlIHRoZSBidWc/ISBUaGUgdHJhY2Ugd2lsbCBnaXZlIHlv
dSBlc3NlbnRpYWwNCj4gaW5mb3JtYXRpb24gYWJvdXQgcmVnaXN0ZXJzLCBldGMgdGhhdCBnaXZl
cyB5b3UgYSBoaW50IHdoYXQgdGhlIF9jYXVzZV8gb2YgdGhlDQo+IGNyYXNoLiBBbmQgd2UgbmVl
ZCB0aGF0IGNhdXNlLiBUaGUgIihlZmF1bHQpIiBoYXMgbm90IGV2ZW4gYSBiaXQgY2xvc2UgdG8g
d2hhdA0KPiBjcmFzaCBnaXZlcyB1cy4NCj4gDQo+IFNvLCB0aGlzIGlzIG15IGxhc3QgbWVzc2Fn
ZSBpbiB0aGUgZGlzY3Vzc2lvbi4NCj4gDQo+IEhlcmUgaXMgYSBmb3JtYWwgTkFLLiBVcCB0byBt
YWludGFpbmVycyB0byBkZWNpZGUgd2hhdCB0byBkbyB3aXRoIHRoaXMuDQo+IA0KDQpTaWdoLCBi
dXQgdGhhbmtzIGZvciB0YWtpbmcgdGhlIHRpbWUgYXJ0aWN1bGF0aW5nIHlvdXIgcG9pbnQgb2Yg
dmlldy4NCg0KLWphbmUNCg0KDQo=
