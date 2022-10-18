Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C06032E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJRS4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJRS4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:56:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3925CA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:56:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIDulS007164;
        Tue, 18 Oct 2022 18:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w/PT8bXpPXUs5+om7RzNNA8+6UaRSpmsGGhywFoJcdM=;
 b=mUOauFYYPsl7T7JkrQTopv4qQiR/oRwL1FZSeIvumf3pBYmkOS7JujxVOqXqZCtVEz6c
 +fYo/ukVUKmlKr3mqsESe33J96d02wsQWTQbLhq8fWo6NZ2GtkbnNklKTCD67wcVKv/3
 B8wyFDYr1Z/KEfETwFWEwgsIBsRYg3hh4vu/sxNPNllueh3nFa0s5+kuL1lyyzsoq803
 9A6V6r+zpedV0/vUW0FAPfvtIABdgvuUw6kvoR9+yt/blOv60kGO7sDH7wf0PG8z0gjK
 UXWAK7oR/BtVrFMUW+fqjnhg9lv74ZH9+2E6FVjVnuY27PLbHgy1GN+cFAnvTXjji4Ar 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtg4at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 18:56:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IHHpJQ035816;
        Tue, 18 Oct 2022 18:56:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu7pyj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 18:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhRlwq+VDm8O16N65uf8ehMAL06XOT12BPKBmYvwE1PT8xdATc/IfsVyu6wQ2i4jvxRAf0jrkw3JEFhk/OIlm4Y3Sz1qub0f6wHX0AmZMYoao2R2Tp1f/LIy9C34srz4Nu+cGQ7Yp6O+PfBWdGvu8ETTM3KGQI7puPmzIQXx4h3EY96TDDn4bzzKkDSrRRTEeqgJUE2yVw5LCD6XW0Of0pmFu49LyMUee40tmcHHuTccFDrikogirFiB19wygKVuVvy/h5ib9T6N26T7poklpgHRLuupE47R4gmBX9go25Zl0j4pFCHf75Ig4EG1NY9pA3hQPjnPLhYgyvcmEFjIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/PT8bXpPXUs5+om7RzNNA8+6UaRSpmsGGhywFoJcdM=;
 b=g0Fbc446N2O43R7lglzSPQrpVG1j+7pznSZQCFErwBXT5LTwMUPutrVkJwC0xs6N1+9BWsyacdwPpA/h3cQcH+S/lbXjqaPy93nXi4+K9ujuUlgBD36iacN8kIiYWKYnDzM+Bg9Ss8Nl52nWUcyfNRIOAtV07p6lPBrL6As7CUfYtHF0HZX9xVDhyigksFFnD8c+cEM6AxVXMKScuZBd9cCDXVPgay38s2/6fwMJC1CWS7x/K3QzgFGZ+vu1InxS0qXHViLbKYJFy9MWcr0KqK4AYWzPBrCNTTYFaHhO+7yU9VkN7v8fqYiveDgGNaxgE8vjBgm2O7Lb+5Q/EfkDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/PT8bXpPXUs5+om7RzNNA8+6UaRSpmsGGhywFoJcdM=;
 b=YfIboPYXLaPsy/Ie6UiRb/OoABCpdS5geen3xJHEo9BRgLhWa4NkvdjuVfX2EoT6QIZljswvF/cX27pC/zEYcCxyAym0Il0fjwoIlZLoEkNNVbyfn/rpib+7wTkA6KbCdGOe6O6ltg+PdX9qJViv2iefVfmj3wWglFhBpJ8SGIA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 18:56:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 18:56:31 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Topic: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Thread-Index: AQHY4lz6JTjIddc0ZUmNZgi7musLFa4S95YAgAAB6ICAASC+AIAAZ7WA
Date:   Tue, 18 Oct 2022 18:56:31 +0000
Message-ID: <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com> <Y06f4EwisLTU0rEz@alley>
In-Reply-To: <Y06f4EwisLTU0rEz@alley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|BY5PR10MB4163:EE_
x-ms-office365-filtering-correlation-id: f569e18e-48f7-4d48-5b88-08dab13a788f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DzLSpHx5usv12tKrnJG6WDdEC5wGv6emq79WaJoJnoeZX09+lWugP6/WVJG5Xgdpx35hOlE3TCjYgblqNroSGlhFAXEZQmr9t3cP6yUUzYH5aaqG2blZqmKsaiPcI9kdfIZpRHWfQmoUhUiIx+B0pfMHKs2PMg5zHv55JBU1kvOJfq9gK2jfAdhrmqNJQ9+TL+v3yRmsPbDRODwSui94R5d8eh/e9kHwud9fT04SDym6fJ091betUTdp7vsX6oy9yHlVB5OtO/fHP1m3UE5AwkN2/lF3pl/LocnFpx9I/17HS6KAQgKam34CMx0CLB4iiRtKcJ1zXCEa2E4qXfTeqxAjvuKS84oclF8QzGWLGOSZp9KfsT4lXZkTvHRussC7WdjoYTndmm2jytB9pPWCr8V+E9VaV/dZLzAu5LhJNr2draJXDVPc2y+z4lCA7SbtVVDIoXvshOr6cr0bhr/je1wWMU7xQD/ZPuswo4DaPRwNrxfFfnBGgDUm3Xt79SM/Q5hymvbCi8FofANwFKenc8OnFDunmHofOQ9OPtoEg7pQpCHMxAuQDhaTVO6O7jTceQjpihITyuLuu3ULwT+Ok4LhvHh2L2iN/pqjkUnwOJ0xaMcloZ2fBKqWlaNY/jY3l/PyA1atJQgsA9clYIm6BLvjJzPcB2FXxayv7z50moctmpe+0FByCTQQuFpmOD42/fTUnlHdTkJy71vfkd/eyiKJiUEpASFZVHzkk5wKdUAMGv6yrowdQEp2Zc7p6/lVeeVImylz1mi2HNe9uwLqVLmc2eBIcaqrotpTqGP37Lah4eK5zahl5kLE1BG9n3iaIxfwZPuY+9qI8jbCPRPLqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(41300700001)(186003)(107886003)(6512007)(478600001)(26005)(44832011)(38070700005)(2616005)(36756003)(2906002)(4001150100001)(6506007)(4326008)(5660300002)(8936002)(31696002)(86362001)(53546011)(38100700002)(91956017)(122000001)(54906003)(6916009)(316002)(71200400001)(6486002)(8676002)(66946007)(64756008)(66446008)(76116006)(83380400001)(66556008)(66476007)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXpZSUtCYnpPK1B2Y0UxdW8razlIdXlBV1FvTXg1eTVlOHJPR1Y4ODc0TEdV?=
 =?utf-8?B?WVN2OE4rRHZJMWhIbzNGRzlCYlFYREFCdlBUMWdQaGZTRjhEci83bjd6VkVD?=
 =?utf-8?B?SnplMy8yV2VSMXlQMW9UM1krN0xBZ2ZUUTQ5b3JOeWN5V2lrclArNEZqUlgx?=
 =?utf-8?B?bVJIVGFyOVVybWp1VTFRQndQUFcrNnZnN0dwM2NycHJMYnZmRDJXRjBjeUFo?=
 =?utf-8?B?TDY1dXloTnZOS29DcU5JbmJjbE5BeFJTbXFaQjI0clhnVFpwdGo5R3VZa2VU?=
 =?utf-8?B?VHpzU2hGNVFxbUEycUt0cHQ5RExkS3VzcnhWMm9aREt0N0lhNFNFSk12S2xq?=
 =?utf-8?B?M1dDVDB4RU9mOEVkcmpXZ2V6bmwxZnNKK2ZUMGdicXpITEJQU1lGNnkvZ0F4?=
 =?utf-8?B?R2RnZHg3b2hNVHpDdW1rTnZGc25URWFJUmxOeERTdGNXd1N1ai9vN3AveTRC?=
 =?utf-8?B?T0lpWUhyNTBYTlJTZXMxZUxSNVdqaHhkWnh5OFFqUFp3dnZQR3ppYkpQeU41?=
 =?utf-8?B?ZzdHYVN4UDE3MU51K3RIdGlEQ3d2QWpjVkNnWW9qVjI5QzZrM2ZUS0w5TUc0?=
 =?utf-8?B?Y053djRwajdkM2N2MURqMEZPUld1cEo5UitnZ3ovZDZhWnpmVkN6anc1RmxX?=
 =?utf-8?B?QUZ0UjRQbm54NlBWMjZleVhhRW5YaTljOGJONjdiQlArZlpkRnFOWnZzR1ls?=
 =?utf-8?B?VUxsUUpSeWdrbnhtWUpydVg0dCtYczROcVN3ZFFTeEJvSUdJaXNZY29qbVFL?=
 =?utf-8?B?cy9GUmtvQS9UK0wxb3pMblNPQlFMc21XTGpVMHhTdy9yLzNQRzBDUkE2VUFI?=
 =?utf-8?B?WTVqRXh5S3pCOWIwZjJFUXNpbmY1SXdIWnd2bU0xRDd2ZGh6Sld2SEtLM0o2?=
 =?utf-8?B?Wlk1cEJ2STF3SXZrb1pQOCtPWUcrUTdnOHVwbGs1UFIyYjdIYUsyNFdDYWtP?=
 =?utf-8?B?WDQ0OW1xQXQrUkZxSFpoeHNBRGZGbldxanBQczYwTHlGak5tR0dROHpQRi9a?=
 =?utf-8?B?NzB0YjZ5cnpjMVpDbU5LTFJYWkRqUzhKQWI4WDlVaVc2S3U1NlFITURaK1B4?=
 =?utf-8?B?bDVObzZoNnJMUGE0bHk2aUFLek9OOFdVeTNlS1YzcG10Y2U2QW5DYlFDZU1V?=
 =?utf-8?B?bHg2QVJpZnp3UEhaS2lOaVhMaElUNDZhbWdnQTdWdExkcXczYUxFbmFKS3ZM?=
 =?utf-8?B?RG9QNzJBdmVrWDNyWFBZbERXbnB6TzdVMGdwbWN6cDVldzVRYzlsS1ZYNlg2?=
 =?utf-8?B?dTVNWUp2SUxsVUttbnd6VWYxNDhkc08xeUVVWEtxSk5ZVldQNGxPR0RwS0Ry?=
 =?utf-8?B?SmM3blFXclVIaCtKZ25tMTdMUk5rbVphMERhZDVQeEI1YTF4YkRsTjFoSFJt?=
 =?utf-8?B?SmxJSHN6cFlpU0hvRytYd1lIdVpDZWdWNkhtQ2psZzZ6N2czZ0pxTkJWQ2E0?=
 =?utf-8?B?NCtZSkEwcVpSc3BBNFR2R1dUTDNRaEloYk1LN1ErbHVPMCttRmNoMmxkNDM2?=
 =?utf-8?B?UU9FN1A3a0FrTThTRUIwQ2FYbTJwc1NQK21ISGtsalVHeXI1VER6Y1VrbU9h?=
 =?utf-8?B?Ym42dnVkV3hnbG9zMUlOM3VDTm1ZV3dscEVIK2U3M2VQWVR0enNEdU9XZ3dF?=
 =?utf-8?B?WG5kd0ZtNCsxR2hMT3RpbnlBbTJqcjZIb3lXWUtCSHp2RlhWMHNDeVg3a1F0?=
 =?utf-8?B?ekt4dzhTYmhzcERkemVmRmxleGlQMjZBcTNIY0J1UWRBU3RTVFowaXphcTJB?=
 =?utf-8?B?anFjaWdTOTVGSU1UUy9SYmZNTC9GV21Rck4vVjJ3MVZHWVRXSHhRbGhvaTNG?=
 =?utf-8?B?R3FiUnpMY2pjNFQ3UGJoQXJ3V1dLa3BOcTZDS0UrM28rV2NKRGtvZWp6ZlJL?=
 =?utf-8?B?Vi92a1BCdkJ5RUZLM1hWaGQzeE9qclh1RnR6Tkt3T0ZRUnVWWTlvVE5ZUTdF?=
 =?utf-8?B?L3lmK3Y1aFF0WHE2NVhwOGRNcmJLMFRHYUcyQUF0MlhVZnJ5V1JGUXVBZ3lH?=
 =?utf-8?B?MEZ0WHJQMXVnMzBrKzB6NmYzVDUxUExqQThka2JkeUw4dTA3ZUtmaEtsMnZw?=
 =?utf-8?B?T00yRkJld1F3bERGWktCVlpsTTFXQXdvRVNndFhDcUtGK1dSaXJjVzZTZm5t?=
 =?utf-8?Q?US8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <855FF8E170C50A48874956F1ED619591@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f569e18e-48f7-4d48-5b88-08dab13a788f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 18:56:31.4589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLXuSU6Sm3111a09y5p5wCUEhWV/GWZx3nSXMu8HFCwKMZvsraOBjHHCt7zxkYkPgmqiiyq7ftW9soCd5HCqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180107
X-Proofpoint-ORIG-GUID: HbK7aktDbAROYOgT1JdRJ92jayflGZ6n
X-Proofpoint-GUID: HbK7aktDbAROYOgT1JdRJ92jayflGZ6n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjAyMiA1OjQ1IEFNLCBQZXRyIE1sYWRlayB3cm90ZToNCj4gT24gTW9uIDIwMjIt
MTAtMTcgMTk6MzE6NTMsIEphbmUgQ2h1IHdyb3RlOg0KPj4gT24gMTAvMTcvMjAyMiAxMjoyNSBQ
TSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIE1vbiwgT2N0IDE3LCAyMDIyIGF0IDAx
OjE2OjExUE0gLTA2MDAsIEphbmUgQ2h1IHdyb3RlOg0KPj4+PiBXaGlsZSBkZWJ1Z2dpbmcgYSBz
ZXBhcmF0ZSBpc3N1ZSwgaXQgd2FzIGZvdW5kIHRoYXQgYW4gaW52YWxpZCBzdHJpbmcNCj4+Pj4g
cG9pbnRlciBjb3VsZCB2ZXJ5IHdlbGwgY29udGFpbiBhIG5vbi1jYW5pY2FsIGFkZHJlc3MsIHN1
Y2ggYXMNCj4+Pj4gMHg3NjY1NjQ1ZjYzNjE2NDY1LiBJbiB0aGF0IGNhc2UsIHRoaXMgbGluZSBv
ZiBkZWZlbnNlIGlzbid0IGVub3VnaA0KPj4+PiB0byBwcm90ZWN0IHRoZSBrZXJuZWwgZnJvbSBj
cmFzaGluZyBkdWUgdG8gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0DQo+Pj4+DQo+Pj4+IAlpZiAo
KHVuc2lnbmVkIGxvbmcpcHRyIDwgUEFHRV9TSVpFIHx8IElTX0VSUl9WQUxVRShwdHIpKQ0KPj4+
PiAgICAgICAgICAgICAgICAgICByZXR1cm4gIihlZmF1bHQpIjsNCj4+Pj4NCj4+Pj4gU28gaW5z
dGVhZCwgdXNlIGtlcm5fYWRkcl92YWxpZCgpIHRvIHZhbGlkYXRlIHRoZSBzdHJpbmcgcG9pbnRl
ci4NCj4+Pg0KPj4+IEhvdyBkaWQgeW91IGNoZWNrIHRoYXQgdmFsdWUgb2YgdGhlIChpbnZhbGlk
IHN0cmluZykgcG9pbnRlcj8NCj4+Pg0KPj4NCj4+IEluIHRoZSBidWcgc2NlbmFyaW8sIHRoZSBp
bnZhbGlkIHN0cmluZyBwb2ludGVyIHdhcyBhbiBvdXQtb2YtYm91bmQNCj4+IHN0cmluZyBwb2lu
dGVyLiBXaGlsZSB0aGUgT09CIHJlZmVyZW5jaW5nIGlzIGZpeGVkLA0KPiANCj4gQ291bGQgeW91
IHBsZWFzZSBwcm92aWRlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgZml4ZWQgT09CPw0KPiBXaGF0
IGV4YWN0IHZzcHJpbnRmKCkvcHJpbnRrKCkgY2FsbCB3YXMgYnJva2VuIGFuZCBldmVudHVhbGx5
DQo+IGhvdyBpdCB3YXMgZml4ZWQsIHBsZWFzZT8NCg0KRm9yIHNlbnNpdGl2ZSByZWFzb24sIEkn
ZCBsaWtlIHRvIGF2b2lkIG1lbnRpb25pbmcgdGhlIHNwZWNpZmljIG5hbWUgb2YgDQp0aGUgc3lz
ZnMgYXR0cmlidXRlIGluIHRoZSBidWcsIGluc3RlYWQsIGp1c3QgY2FsbCBpdCAiZGV2WF9hdHRy
WVtdIiwNCmFuZCBkZXNjcmliZSB0aGUgcHJlY2lzZSBuYXR1cmUgb2YgdGhlIGlzc3VlLg0KDQpk
ZXZYX2F0dHJZW10gaXMgYSBzdHJpbmcgYXJyYXksIGRlY2xhcmVkIGFuZCBmaWxsZWQgYXQgY29t
cGlsZSB0aW1lLA0KbGlrZQ0KICAgY29uc3QgY2hhciBjb25zdCBkZXZYX2F0dHJZW10gPSB7DQoJ
W0FUVFJZX0FdID0gIkRldiBYIEF0dHJpYnV0ZVkgQSIsDQoJW0FUVFJZX0JdID0gIkRldiBYIEF0
dHJpYnV0ZVkgQiIsDQoJLi4uDQoJW0FUVFJZX0ddID0gIkRldiBYIEF0dHJpYnV0ZVkgRyIsDQog
ICB9DQpzdWNoIHRoYXQsIHdoZW4gdXNlciAiY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW1zLy4uLi9h
dHRyeV8xIiwNCiJEZXYgWCBBdHRyaWJ1dGVZIEIiIHdpbGwgc2hvdyB1cCBpbiB0aGUgdGVybWlu
YWwuDQpUaGF0J3MgaXQsIG5vIG1vcmUgcmVmZXJlbmNlIHRvIHRoZSBwb2ludGVyIGRldlhfYXR0
cllbQVRUUllfQl0gYWZ0ZXIgdGhhdC4NCg0KVGhlIGJ1ZyB3YXMgdGhhdCB0aGUgaW5kZXggdG8g
dGhlIGFycmF5IHdhcyB3cm9uZ2Z1bGx5IHByb2R1Y2VkLA0KbGVhZGluZyB1cCB0byBPT0IsIGUu
Zy4gZGV2WF9hdHRyWVsxMV0uICBUaGUgZml4IHdhcyB0byBmaXggdGhlIA0KY2FsY3VsYXRpb24g
YW5kIHRoYXQgaXMgbm90IGFuIHVwc3RyZWFtIGZpeC4NCg0KPiANCj4+IHRoZSBsaW5nZXJpbmcg
aXNzdWUNCj4+IGlzIHRoYXQgdGhlIGtlcm5lbCBvdWdodCB0byBiZSBhYmxlIHRvIHByb3RlY3Qg
aXRzZWxmLCBhcyB0aGUgcG9pbnRlcg0KPj4gY29udGFpbnMgYSBub24tY2Fub25pY2FsIGFkZHJl
c3MuDQo+IA0KPiBXYXMgdGhlIHBvaW50ZXIgdXNlZCBvbmx5IGJ5IHRoZSB2c3ByaW50ZigpPw0K
PiBPciB3YXMgaXQgYWNjZXNzZWQgYWxzbyBieSBhbm90aGVyIGNvZGUsIHBsZWFzZT8NCg0KVGhl
IE9PQiBwb2ludGVyIHdhcyB1c2VkIG9ubHkgYnkgdnNwcmludGYoKSBmb3IgdGhlICJjYXQiIHN5
c2ZzIGNhc2UuDQpObyBvdGhlciBjb2RlIHVzZXMgdGhlIE9PQiBwb2ludGVyLCB2ZXJpZmllZCBi
b3RoIGJ5IGNvZGUgZXhhbWluYXRpb24gDQphbmQgdGVzdC4NCg0KSGVyZSBpcyBhIHNuaXBwZXQg
b2YgdGhlIGNyYXNoIGJhY2t0cmFjZSBmcm9tIGFuIGluc3RydW1lbnRlZCBrZXJuZWwsIA0Kc2Ny
YXRjaGVkIG9uZSBsaW5lIGZvciBzZW5zaXRpdmUgcmVhc29uIC0NCg0KY3Jhc2g+IGJ0DQpQSUQ6
IDMyNTAgICBUQVNLOiBmZmZmOWNiNTBmZTIzZDgwICBDUFU6IDE4ICBDT01NQU5EOiAiY2F0Ig0K
ICAjMCBbZmZmZmMwYmFjZjM3Nzk5OF0gbWFjaGluZV9rZXhlYyBhdCBmZmZmZmZmZjliMDZjN2Mx
DQogICMxIFtmZmZmYzBiYWNmMzc3OWY4XSBfX2NyYXNoX2tleGVjIGF0IGZmZmZmZmZmOWIxM2Ji
NTINCiAgIzIgW2ZmZmZjMGJhY2YzNzdhYzhdIGNyYXNoX2tleGVjIGF0IGZmZmZmZmZmOWIxM2Nk
YWMNCiAgIzMgW2ZmZmZjMGJhY2YzNzdhZThdIG9vcHNfZW5kIGF0IGZmZmZmZmZmOWIwMzM1N2EN
CiAgIzQgW2ZmZmZjMGJhY2YzNzdiMTBdIGRpZSBhdCBmZmZmZmZmZjliMDMzYzMyDQogICM1IFtm
ZmZmYzBiYWNmMzc3YjQwXSBkb19nZW5lcmFsX3Byb3RlY3Rpb24gYXQgZmZmZmZmZmY5YjAzMGM1
Mg0KICAjNiBbZmZmZmMwYmFjZjM3N2I3MF0gZ2VuZXJhbF9wcm90ZWN0aW9uIGF0IGZmZmZmZmZm
OWJhMDNkYjQNCiAgICAgW2V4Y2VwdGlvbiBSSVA6IHN0cmluZ19ub2NoZWNrKzE5XQ0KICAgICBS
SVA6IGZmZmZmZmZmOWI4N2NjNzMgIFJTUDogZmZmZmMwYmFjZjM3N2MyMCAgUkZMQUdTOiAwMDAx
MDI4Ng0KICAgICBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgIFJCWDogZmZmZjlkYTEzZmMxN2ZmZiAg
UkNYOiBmZmZmMGEwMGZmZmZmZjA0DQogICAgIFJEWDogNzI2ZjYzNWY2MzYxNjQ2NSAgUlNJOiBm
ZmZmOWRhMTNmYzE3ZmZmICBSREk6IGZmZmZmZmZmZmZmZmZmZmYNCiAgICAgUkJQOiBmZmZmYzBi
YWNmMzc3YzIwICAgUjg6IGZmZmY5ZGEwYmZkMmYwMTAgICBSOTogZmZmZjlkYTBiZmMxODAwMA0K
ICAgICBSMTA6IDAwMDAwMDAwMDAwMDEwMDAgIFIxMTogMDAwMDAwMDAwMDAwMDAwMCAgUjEyOiA3
MjZmNjM1ZjYzNjE2NDY1DQogICAgIFIxMzogZmZmZjBhMDBmZmZmZmYwNCAgUjE0OiBmZmZmZmZm
ZjljMWE2YTRmICBSMTU6IGZmZmZmZmZmOWMxYTZhNGYNCiAgICAgT1JJR19SQVg6IGZmZmZmZmZm
ZmZmZmZmZmYgIENTOiAwMDEwICBTUzogMDAxOA0KICAjNyBbZmZmZmMwYmFjZjM3N2MyOF0gc3Ry
aW5nIGF0IGZmZmZmZmZmOWI4N2NlOTgNCiAgIzggW2ZmZmZjMGJhY2YzNzdjNThdIHZzbnByaW50
ZiBhdCBmZmZmZmZmZjliODdlZmUzDQogICM5IFtmZmZmYzBiYWNmMzc3Y2I4XSBzcHJpbnRmIGF0
IGZmZmZmZmZmOWI4N2Y1MDYNCiMxMCBbZmZmZmMwYmFjZjM3N2QxOF0gPC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLT4NCiMxMSBbZmZmZmMwYmFjZjM3N2QyOF0gZGV2X2F0dHJfc2hvdyBh
dCBmZmZmZmZmZjliNTZkMTgzDQojMTIgW2ZmZmZjMGJhY2YzNzdkNDhdIHN5c2ZzX2tmX3NlcV9z
aG93IGF0IGZmZmZmZmZmOWIzMjcyZGMNCiMxMyBbZmZmZmMwYmFjZjM3N2Q2OF0ga2VybmZzX3Nl
cV9zaG93IGF0IGZmZmZmZmZmOWIzMjU3NmMNCiMxNCBbZmZmZmMwYmFjZjM3N2Q3OF0gc2VxX3Jl
YWQgYXQgZmZmZmZmZmY5YjJiZTQwNw0KIzE1IFtmZmZmYzBiYWNmMzc3ZGU4XSBrZXJuZnNfZm9w
X3JlYWQgYXQgZmZmZmZmZmY5YjMyNWZmZQ0KIzE2IFtmZmZmYzBiYWNmMzc3ZTI4XSBfX3Zmc19y
ZWFkIGF0IGZmZmZmZmZmOWIyOTQwZWENCiMxNyBbZmZmZmMwYmFjZjM3N2ViMF0gdmZzX3JlYWQg
YXQgZmZmZmZmZmY5YjI5NDJhYw0KIzE4IFtmZmZmYzBiYWNmMzc3ZWUwXSBzeXNfcmVhZCBhdCBm
ZmZmZmZmZjliMjk0ODVjDQojMTkgW2ZmZmZjMGJhY2YzNzdmMjhdIGRvX3N5c2NhbGxfNjQgYXQg
ZmZmZmZmZmY5YjAwM2NhOQ0KIzIwIFtmZmZmYzBiYWNmMzc3ZjUwXSBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUgYXQgZmZmZmZmZmY5YmEwMDFiMQ0KDQpjcmFzaD4gZGlzIGZmZmZmZmZm
OWI4N2NjNzMNCjB4ZmZmZmZmZmY5Yjg3Y2M3MyA8c3RyaW5nX25vY2hlY2srMTk+OiBtb3Z6Ymwg
KCVyZHgpLCVyOGQNCg0KYW5kIFJEWDogNzI2ZjYzNWY2MzYxNjQ2NSB3YXMgYSBub24tY2Fub25p
Y2FsIGFkZHJlc3MuDQoNCkFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2ggdG8gdGhlIGluc3RydW1l
bnRlZCBrZXJuZWwsIGluc3RlYWQgb2YgcGFuaWMsIA0KdGhlICJjYXQiIGNvbW1hbmQgcHJvZHVj
ZWQgICIoZWZhdWx0KSINCg0KPiANCj4gSSB3b25kZXIgaWYgdGhpcyBwYXRjaCB3b3VsZCBwcmV2
ZW50IHRoZSBjcmFzaCBvciBpZiB0aGUgYnJva2VuDQo+IGtlcm5lbCB3b3VsZCBjcmFzaCBsYXRl
ciBhbnl3YXkuDQoNCkEgYnJva2VuIGtlcm5lbCBoYXMgYSBkaWZmZXJlbnQgaXNzdWUgdG8gYmUg
Zml4ZWQsIHRoZSB1cHN0cmVhbSBrZXJuZWwgDQppc24ndCBicm9rZW4sIGl0IGNvdWxkIGp1c3Qg
b2ZmZXIgYmV0dGVyIHByb3RlY3QgaW4gY2FzZSBhIGJ1ZyB3YXMgDQppbnRyb2R1Y2VkIGluIGZ1
dHVyZS4NCg0KPiANCj4+IFRoYXQgc2FpZCwgSSByZWFsaXplZCB0aGF0IG5vdCBhbGwNCj4+IGFy
Y2hpdGVjdHVyZSBpbXBsZW1lbnQgbWVhbmluZ2Z1bCBrZXJuX2FkZHJfdmFsaWQoKSwgc28gdGhp
cyBsaW5lDQo+PiAgICAgIGlmICgodW5zaWduZWQgbG9uZylwdHIgPCBQQUdFX1NJWkUgfHwgSVNf
RVJSX1ZBTFVFKHB0cikpDQo+PiBpcyBzdGlsbCBuZWVkLiAgSSdsbCBzZW5kIHYyLg0KPiANCj4g
UGxlYXNlLCBhZGQgbGludXgtbW1Aa3ZhY2sub3JnIGludG8gQ0MuIA0KDQpXaWxsIGRvLg0KDQo+
IEkgd29uZGVyIGlmIGtlcm5fYWRkcl92YWxpZCgpDQo+IGlzIHNhZmUgdG8gdXNlIGFueXdoZXJl
LCBlc3BlY2lhbGx5IGR1cmluZyBlYXJseSBib290LiBJIHdvbmRlciBpZg0KPiBpdCB3b3VsZCBt
YWtlIHNlbnNlIHRvIGltcGxlbWVudCBpdCBvbiBhbGwgYXJjaGl0ZWN0dXJlcy4NCg0KT24geDg2
IGFyY2hpdGVjdHVyZSwga2Vybl9hZGRyX3ZhbGlkKCkgbG9va3Mgc2FmZSB0byBtZSB0aG91Z2gs
IG9uIA0Kc2V2ZXJhbCBvdGhlciBhcmNoaXRlY3R1cmVzLCBpdCdzIGRlZmluZWQgKDEpLg0KDQo+
IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IFBldHINCg0KVGhhbmtzIQ0KLWphbmUNCg0K
