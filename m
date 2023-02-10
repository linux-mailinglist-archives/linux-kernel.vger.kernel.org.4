Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D76691B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjBJJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBJJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:22:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523331F911;
        Fri, 10 Feb 2023 01:22:12 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A97dVe010297;
        Fri, 10 Feb 2023 09:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=/+KyN+SlsSQ1zMjkC0vxqMzi7SEl2394xt8tTxNobPk=;
 b=GmbEwbqnJaf4Xk3ph/xZpP8cody8BTh/46zC2vgz9q2aAm+xaugEY6bueWeBP/jdQD6H
 VojdWX15pIG/i4fho4GkKT0n4y+4RlOeCIQwawa7yzydTxCkrAd4OVg8bVkY5Y1Fez1p
 ThCBxRMR7mLfW3Jf6msVzQwKP9Ecc9PrE9Fk2x2NB2oeFVIH61d3bRY5H+XFrSXW78dt
 2xAGAz83R6DpQtPgC6b4j6zpcagRHaBaz2Tetd0kjrzHGKCDpo2J8i/oc+rbggBXmtRG
 LpPwkM2Na28h+H5rjA0Z/JW18ahgy1p5SppmhfnzZhb1dXIyiChSE0rVyGPfH84up/J0 mg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmv9bu3tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 09:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut7kDUiESFN6w9Ub41HRFv+1i+Zhw4A5/N73rt4CwV/ndiAc4oKHULc20ua3OpKM19ToDaHDzUYfiXsRMug9WEqld/NqeQeWn7ATvy52begHa++E6Yrepm2xcAyEUlYY+o0jsbCY/fD52R1JaJ4miCW+e9Ti5dL6oPbCkazT/F/4eugCV20wW67IES0d+h5iFMWFsqR6Ecxm2HpRy7r5PdjJ0+zrLbPForO8emokTkKM2INm8smxMScDN4NMzHC2P1GEjFBaBg4bgVkeFuCxCG9bHZrieXqG7VDYaEO/uy+MBCP6Y9F4GhuH4c75TaK4oeRqZfRPBoM7hL9XR9sf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+KyN+SlsSQ1zMjkC0vxqMzi7SEl2394xt8tTxNobPk=;
 b=LICvaMM2q7SSSmAID6p7gIjflw2Dot8nchXM/s8/GqlXy2tNrzEGjZLs0ozmiffyx77BQfD/SWqhsc+LibZnpAXZXiluX2wnbyeFGPBsYunHi1a3dOtzdWZbQRpgRsRBwLWWSfFJXh1n/E4xTSdQ/wzgv5jBJJT/+9X6Gw+nv9ZW3XF98Qumr/5aegEFBUNG2gOaKW9u6n3jWpoDmcNJ8OjXItljdFzCSHB4H2u9CbiCVj/RtbictRI1rmJRkMdwt0R7xwbxvITtkLWFU59BVoPG01aF3kEogVUl4OzBSUYUOH+rcKcce5JuxktSJ7NY9ixFs2zUSGE+YPgMsxW/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8169.namprd02.prod.outlook.com (2603:10b6:8:1a::14) by
 SJ0PR02MB7471.namprd02.prod.outlook.com (2603:10b6:a03:296::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 09:22:00 +0000
Received: from DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b]) by DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b%5]) with mapi id 15.20.6086.021; Fri, 10 Feb 2023
 09:22:00 +0000
From:   Vikash Garodia <vgarodia@qti.qualcomm.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>
CC:     Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Fritz Koenig <frkoenig@google.com>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>
Subject: RE: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Thread-Topic: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Thread-Index: AQHZOt4trMzBaaZ5zE+7PcOTvgimf67DrmxggAEVDoCAAxZ1gIAADYWw
Date:   Fri, 10 Feb 2023 09:22:00 +0000
Message-ID: <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
References: <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
 <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
In-Reply-To: <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8169:EE_|SJ0PR02MB7471:EE_
x-ms-office365-filtering-correlation-id: a623355f-15aa-4bc7-0d43-08db0b484386
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BICRFZRbTAlIBeSGAvAEwr1/GG5LPjn2Si2YmRFpMb5Pm9we0LFq0CvhA6+7WzfFo3PrQenfAa6WfCq8L53y6y9t/0jd26SiwdQfX/ef3r8NHX4TpIKRj6zcVx4M+W2cymA6TCaQsd/9Ewn85xf7kkdWn7zpKmlLPkVZFWMsIZHt5tBYtHLJVNZtlImCCRfnl4Sj1xDnZlzXUB37OQUVZkWLjp+J4Oig99peVwN5jh31PuoGMEowElT1fObBw7K2YPg0TgTq3kp3P+SmiCDMRJgkwl6IOnPsJ4UeF0Yc2W05EwY2dSwUGU6I16E703JAPDBZJZ+yhLb8gsg6TXz794wNZ9ZRK5Utn4J6CMftZ/mzpRJOBjIpsiEfxJ/0ratWUD3vTg7BQY48OCn7wmARwlDqfT1mo0BaWUARyaqDdXXqpCvPZ5gPezWs6EOEUsNFa7uV65a6KR7UNLdkZpcG647sIGa1w5O7Qe9HRVC7FGA4CHOU8OFcZf7VKqBJziMCYo72nYeAHnw9DCsPMNpjaIKr6+scnXEDeOK7YDpBOLf27H3hjMyUzSQmiU8P+yQEM48NNHUvi7c9Zl3lerKZNwokMXgkGrGKWdfLqaTS8IdJhfMKgHkuYIUCDHnsRC5ribfsWUnYYrOs7VJCmN4fwVl2nnSJTr2N0q+kvcGnXl89CykyEAAjg+3qlTcmm+P6SrxWNvd//tN3lGyu+JIesw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8169.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(478600001)(2906002)(33656002)(55016003)(316002)(38070700005)(7416002)(5660300002)(8936002)(86362001)(122000001)(38100700002)(110136005)(54906003)(9686003)(83380400001)(7696005)(71200400001)(52536014)(26005)(53546011)(6506007)(186003)(66946007)(76116006)(107886003)(4326008)(66476007)(41300700001)(66556008)(8676002)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU1mNHhKS3FJcDJQNjcwMStYS2NxRmRaZlhwU1djMjJZeXg5WnYwVXUxWWsy?=
 =?utf-8?B?RGJ0cmhkdVFqcmZFN0tWS3duTkhSVVRGTjNydldHUjh4Z2pPb1hxVElVbndL?=
 =?utf-8?B?N0VxMVp4TkRwVWx1N0pCZFQvWldOems3bWd4a1RHRFduK04zbEVnWWVhU1FJ?=
 =?utf-8?B?Z1djN29wcDRmNTFPWnhaRnNjQzh0ZkFZR0dTYW9Rd0FSS3FtNW5qQm1Ndk1C?=
 =?utf-8?B?WkVKemo0aG52MXk2M3Vla0NLUkN5akFuMkVPQ3JYZEZrZXdCdGZ4UFdGNGtB?=
 =?utf-8?B?M3JRdnlzNzYxbXlTQkNpRnNSYkVrdTQzV3MzdHlLempYZk9aWnBib0pvakFn?=
 =?utf-8?B?L05LYnBta0ZtRUt6SkJRWUhqTnVOaTFEQ1ZidlZCMkVmZURJQ1EvaE9MZ0Jy?=
 =?utf-8?B?RTBMWWVNNHJvbFBZcjhmbUZvbTM5WW9XVGY0QWdjSG5BOGhMeUpLM1BpS3Vj?=
 =?utf-8?B?OHc3eWNsQVZEN1ZQVzRPQm1UQW9ndlJYKzdaMVVhQzhsSkVjK0tpODl5Nm4r?=
 =?utf-8?B?YmlrUzArK0w2bVdQZWVnNXhheldLbmtoZWxNZVB1djhGS2lVWUZVSnM4SmxL?=
 =?utf-8?B?WkJuWHorbnEvbjRhQ1NDeUdiS0UxY1dFOEZkOFlnMy9EQVVWeVNRQlNiYzFR?=
 =?utf-8?B?ZlVrb0M5U0w5Nk9FdExiV0hGYldSMW5sUkIyR2phWXRYK3BBMVU3cEc5QWVH?=
 =?utf-8?B?RlhMZjlkTnRHZEYvMnlSOW9HdjdKRWZUOVFIRFhBd2JybEhKVXBkZHVaeVRr?=
 =?utf-8?B?OG8wMXhXQzhwWEQ0NG1OSkFKMHh4cGpEUHlWbkhpMVN3U2xscDZiQkhCd2xt?=
 =?utf-8?B?MllTRVlnRnRaeFk4TWh4L29tRVJseWNQejV3Z2YvT05DdkZIMTRWZjg3eFN3?=
 =?utf-8?B?ck1veVJtdUhqZHBkdFJyYUMvcVR3ZFpHRmN6N2RKdWQzVFllUGowL0Rieklv?=
 =?utf-8?B?MTlwS1ZaOHFmK2RJbGJjcjh0a0taNDltVG1PT2lIZWtqUFp1Wm90WjJEem16?=
 =?utf-8?B?NmpFS2dGOHdKRXN3UlVTVi82Z0RmZ1N5a0FtY1FVSUthdmdGWkVuUWpjSXVT?=
 =?utf-8?B?WGhINGttd2dTQUQ3emh2d3VFb1Btak5XSWtaRHY3SE5vbFhuSjhlZmtjSTRV?=
 =?utf-8?B?SERpVW0yeTQvMi9hcm40UHZJZ01kSU40VTJ2N3NTcXNWUHFXcGFFb003ZVdD?=
 =?utf-8?B?NG05bksxd3BtNm5PTWgxWG9lT1lBdzJJMUZpbDNnMVFtQXlXSTlIQ2VtU0Vp?=
 =?utf-8?B?OWQ0VlJmWkVqeXpKKzdYcW8xVGNOZUV4UFJaNGYwUFRVcWl6UFdlMXJlR1Vm?=
 =?utf-8?B?cXVycy9ZUTNkeUpWaWxuTGdIVjdxT0JwU2pMbkdVZHFidDJGTzVxb29yZFRs?=
 =?utf-8?B?RXpBdG41V2Z2ZVBrRDVaVjRMZkY1THJ4VEdIbjBKUTJxM2NNdUs2cWVIaXpl?=
 =?utf-8?B?NkhwYWdZbUpxZzJFYXA4LzkxWFVYR2RBZTQ4WjluaS9VV241bGk1bmNtblha?=
 =?utf-8?B?cFNjVzJlUWsrczdsK1Ayei9OcmV0TFlYaG5ITTIyK0NQOEtwOWlIYkVrSDJT?=
 =?utf-8?B?bjByS042RGlkREJ0c0NPdVNmT2k3Y2EwbDE2YXBDQjdDSFQvM2N5MlJUVFBy?=
 =?utf-8?B?ZjNrYUsyMDBDNEFFVGxMcHl3MTFSWHdRdWNpU2NQK0FJa3dZWjA2bytJQzlH?=
 =?utf-8?B?RkUyU0pDSEhhSHpMSW9yeUlYazA4N0c0NzZ5STBvVHE5c1N6djdtRjRreXlM?=
 =?utf-8?B?THZnN1llQVhKeDMxMEVFR1Fibk51NitUbFRsdmJXdlc2dVk3RkdmZEJ0eU41?=
 =?utf-8?B?Sy9kT0NYVlQ2UitTcnh3M1VBbEUrU3ByLy9jaEFmN3VXTmpER25GUlZ5Wll5?=
 =?utf-8?B?aFQ0dVF1VGlYWEZOSzdQYjRtL0I4L1RJclR4YktoWUY5REo1cFJFTVhnOHB3?=
 =?utf-8?B?RTgyRXFpVklINlNTMWlXaHRFQi9kcnZ3cHZnZzdwYmZ1Wm1hSE8wSStNMFNj?=
 =?utf-8?B?NmFSRFVqZG9RUUV5cWlObDd2RWZBc3dxZCttOGRPY2M2NUZkTlRVRXZxbzFh?=
 =?utf-8?B?VHU4aGFlSDFxQmZibkducDVVQ3VoVm5sZmkwUzJkdXNqN1cyNFRSZEFqMWVF?=
 =?utf-8?Q?ND3HuhVIwI8uhlG5XIRUNoHrh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VDZEQVVVZm5naE85cjVtTVo0eUVCZzBQZjJuaEo2d2d2NGlNZ1JjRVJxU0oy?=
 =?utf-8?B?a0ZTbzgwNXozUTd6UTFZTEZyOHNia2lBMzJDeHZOS05HdTgxMVFHK1cxdWlX?=
 =?utf-8?B?YVJsWmZjUW9wZmhYN2c4OUhQejl4cGhNaEhKTG9ZY09wV1J3Wm55YWdIMWhL?=
 =?utf-8?B?QUJvVUd4SFNhcDFicTB4RzViMDJLYkFWR3F1emJIZTA4Ynk1Zyt0Z3hvTTlY?=
 =?utf-8?B?VFhkWWZKNDcwblVFeHFsSEQwUDFUZVlJR1RnaGhHeWRKM3ZydEFFVmk1cy9v?=
 =?utf-8?B?M29aTGx4cEJURDZhZ2hndXJUdGdhYWYzaVFUTGJEVDJoTTl2OHk0eWVTaGhj?=
 =?utf-8?B?VUE4ZlU3RzkxbXcxU2xPcHA4Zmt4WW9KcVRoVi9xaDFEd0V1bnZMcVJiaXB4?=
 =?utf-8?B?a0JoYU42ZG5qWTArdzFKaWdLQ0NnaVRpeGNQcGpndzNMTEJpd1ZvV2VDcXJw?=
 =?utf-8?B?OVhNcGE5RmV3OTBSY1F5UnE0bldFc1FXVEhWRnYxc1QwU2FSbHBKK3NRZXhV?=
 =?utf-8?B?aE0wRmZKRFdKMmxIL2lrdHdraFFVcXB0dURQVkVOVjN5aElCNlVWREVBNmdY?=
 =?utf-8?B?Ky9MQUgyT3puWVBOalJXQXNobEg4azlzZjRBbmNDeWxZS0lLOW93UGFIMXdn?=
 =?utf-8?B?Q1MySUNrZkdJcVAwaHQyMEJhUTI4RmZLK1hxNCtJY3pqZnBzbVZGN05lNklI?=
 =?utf-8?B?ZlFUZEtLNG83QXhIeDN5YVpiUUtJK0RmdnVsSHh1UnZ6MXQ0c1NnbDZ6VDVC?=
 =?utf-8?B?VXR4TkF3MHRtNzZkL3RlQ2VBMHJKR2dFN3ljZ05XK2R1bEVNUXF0MGdaNXBT?=
 =?utf-8?B?cEJjYUw3Y3A4Q1doL0FXalpPcnRIa1JWbXNhVHAzWU1QQVBOejFMUTNIaHg2?=
 =?utf-8?B?TFVmblUvRFJZbUM5d1AzYzAwMDBLRExGS1JUTXh6c2VaMEMwa3pYSEdMTlVZ?=
 =?utf-8?B?a21kUEZ0SkxiWld0ZnVFbXhaOVBMRElWaTJUWE90dUhZWjdlVkY1ckF6bWtP?=
 =?utf-8?B?dldVUDVZaE1oZndZRDNLeDUrRWk1Skh3WTBHK0hXaE1uOCtybEZvRWdSbDFP?=
 =?utf-8?B?VWdrT0FxeFNFVklYcU1tN2hsU0M3cHRlRkg0NWtyWVBjSXp3cExBM3hsRHNz?=
 =?utf-8?B?eHUvV0JpelZ3bjBLRTYzbWhnQWlVTTMzRUhhNTZNUER4SVYwZDZQRzNHNWlQ?=
 =?utf-8?B?RTQ4ZXQzUE5RbU80ZFY2VWwwLzVFeis2cmlQSFVpOEpidW04OHVXVzFwNVBT?=
 =?utf-8?B?KzNibUZWMzN0N040a0s5MEtjSm00VHhITGxXNXMxR0NkTkp2QT09?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8169.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a623355f-15aa-4bc7-0d43-08db0b484386
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 09:22:00.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgCMskjlDvhqS7zy9/BwlppyDMFUy5rlXr43mUWyPVkHASXyW0etQExVKMOykZ9Qw7tFfH3KNOo1oOYqUtUNdUtQl9+8qQxeYL0vj/+v7v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7471
X-Proofpoint-GUID: v6aAdVay9BxwuynX0JbL0mFpJ6g2sBXy
X-Proofpoint-ORIG-GUID: v6aAdVay9BxwuynX0JbL0mFpJ6g2sBXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_05,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmF2aWVyLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBKYXZpZXIg
TWFydGluZXogQ2FuaWxsYXMgPGphdmllcm1AcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDEwLCAyMDIzIDE6NDUgUE0NCj5UbzogVmlrYXNoIEdhcm9kaWEgPHZnYXJvZGlhQHF0
aS5xdWFsY29tbS5jb20+OyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBta2FAY2hy
b21pdW0ub3JnDQo+Q2M6IEFsYmVydCBFc3RldmUgPGFlc3RldmVAcmVkaGF0LmNvbT47IHN0YW5p
bWlyLnZhcmJhbm92QGxpbmFyby5vcmc7IEVucmljDQo+QmFsbGV0Ym8gaSBTZXJyYSA8ZWJhbGxl
dGJAcmVkaGF0LmNvbT47IEFuZHkgR3Jvc3MgPGFncm9zc0BrZXJuZWwub3JnPjsNCj5Cam9ybiBB
bmRlcnNzb24gPGFuZGVyc3NvbkBrZXJuZWwub3JnPjsgS29ucmFkIER5YmNpbw0KPjxrb25yYWQu
ZHliY2lvQGxpbmFyby5vcmc+OyBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVs
Lm9yZz47DQo+U3RhbmltaXIgVmFyYmFub3YgPHN0YW5pbWlyLmsudmFyYmFub3ZAZ21haWwuY29t
PjsgVmlrYXNoIEdhcm9kaWEgKFFVSUMpDQo+PHF1aWNfdmdhcm9kaWFAcXVpY2luYy5jb20+OyBs
aW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+bWVkaWFAdmdlci5rZXJuZWwu
b3JnOyBGcml0eiBLb2VuaWcgPGZya29lbmlnQGdvb2dsZS5jb20+OyBEaWtzaGl0YSBBZ2Fyd2Fs
DQo+KFFVSUMpIDxxdWljX2Rpa3NoaXRhQHF1aWNpbmMuY29tPjsgUmFqZXNod2FyIEt1cmFwYXR5
IChRVUlDKQ0KPjxxdWljX3JrdXJhcGF0QHF1aWNpbmMuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0hdIFJldmVydCAidmVudXM6IGZpcm13YXJlOiBDb3JyZWN0IG5vbi1waXggc3RhcnQgYW5kIGVu
ZA0KPmFkZHJlc3NlcyINCj4NCj5XQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBv
dXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPmFueSBsaW5rcyBvciBhdHRh
Y2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPg0KPk9uIDIvOC8yMyAxMDowNiwg
SmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIHdyb3RlOg0KPj4gSGVsbG8gVmlrYXNoLA0KPj4NCj4+
IE9uIDIvNy8yMyAxNzo0MCwgVmlrYXNoIEdhcm9kaWEgd3JvdGU6DQo+Pj4gSGkgSmF2aWVyIGFu
ZCBNYXR0aGlhcywNCj4+PiBDYW4gd2UgdHJ5IHRoZSBhdHRhY2hlZCBwYXRjaCBpZiB0aGF0IGZp
eGVzIHRoZSBzdXNwZW5kIGlzc3VlIGZvciBzYzcxODAgYW5kDQo+c2M3MjgwID8NCj4+Pg0KPj4N
Cj4+IEkgdGVzdGVkIHlvdXIgYXR0YWNoZWQgcGF0Y2ggb24gYW4gU0M3MTgwIG1hY2hpbmUgKEhQ
IFgyIENocm9tZWJvb2spDQo+PiBhbmQgYXMgTWF0dGhpYXMgbWVudGlvbmVkLCBpdCBzdGlsbCBj
YXVzZXMgdGhlIGRyaXZlcidzIHByb2JlIHRvIGZhaWw6DQo+Pg0KPj4gWyAyMTE5LjA2Mzc3OV0g
cWNvbS12ZW51cyBhYTAwMDAwLnZpZGVvLWNvZGVjOiBub24gbGVnYWN5IGJpbmRpbmcgWw0KPj4g
MjExOS4wODU2OTVdIHBsYXRmb3JtIHZpZGVvLWZpcm13YXJlLjA6IEFkZGluZyB0byBpb21tdSBn
cm91cCAxMSBbDQo+PiAyMTE5LjE1NjMwMl0gYXJtLXNtbXUgMTUwMDAwMDAuaW9tbXU6IFVuaGFu
ZGxlZCBjb250ZXh0IGZhdWx0Og0KPj4gZnNyPTB4NDAyLCBpb3ZhPTB4MDAwMDAwYjAsIGZzeW5y
PTB4NjEsIGNiZnJzeW5yYT0weGM0MCwgY2I9NyBbDQo+PiAyMTE5LjI1OTM4Ml0gcWNvbS12ZW51
cyBhYTAwMDAwLnZpZGVvLWNvZGVjOiBmYWlsZWQgdG8gcmVzZXQgdmVudXMNCj4+IGNvcmUgWyAy
MTE5LjI2Nzc4Ml0gcGxhdGZvcm0gdmlkZW8tZmlybXdhcmUuMDogUmVtb3ZpbmcgZnJvbSBpb21t
dQ0KPj4gZ3JvdXAgMTEgWyAyMTE5LjI3NTA1Ml0gcWNvbS12ZW51czogcHJvYmUgb2YgYWEwMDAw
MC52aWRlby1jb2RlYw0KPj4gZmFpbGVkIHdpdGggZXJyb3IgLTExMA0KPj4NCj4NCj5TbyB3aGF0
IHNob3VsZCB3ZSBkbyBhYm91dCB0aGlzIGZvbGtzPyBTaW5jZSBub3QgYWxsb3dpbmcgdGhlIGRy
aXZlciB0byBwcm9iZSBvbg0KPmF0IGxlYXN0IFNDNzE4MCBpcyBhIHF1aXRlIHNlcmlvdXMgcmVn
cmVzc2lvbiwgY2FuIHdlIHJldmVydCBmb3Igbm93IHVudGlsIGEgcHJvcGVyDQo+Zml4IGlzIGZp
Z3VyZWQgb3V0Pw0KDQpJIGFtIGFibGUgdG8gcmVwcm8gdGhpcyBpc3N1ZSBvbiBzYzcxODAgYW5k
IGRpc2N1c3Npbmcgd2l0aCBmaXJtd2FyZSB0ZWFtIG9uIHRoZSBjYXVzZQ0Kb2YgcmVzZXQgZmFp
bHVyZS4gVGhlIG9yaWdpbmFsIHBhdGNoIHdhcyByYWlzZWQgZm9yIGZpeGluZyByYXJlIFNNTVUg
ZmF1bHRzIGR1cmluZyB3YXJtDQpib290IG9mIHZpZGVvIGhhcmR3YXJlLiBIZW5jZSBsb29raW5n
IHRvIHVuZGVyc3RhbmQgdGhlIHJlZ3Jlc3NpbmcgcGFydCBiZWZvcmUgd2UNCnByb2NlZWQgdG8g
cmV2ZXJ0Lg0KDQo+LS0NCj5CZXN0IHJlZ2FyZHMsDQo+DQo+SmF2aWVyIE1hcnRpbmV6IENhbmls
bGFzDQo+Q29yZSBQbGF0Zm9ybXMNCj5SZWQgSGF0DQoNCg==
