Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E168DE13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBGQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBGQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:40:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890944AE;
        Tue,  7 Feb 2023 08:40:43 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Ej9Xa008071;
        Tue, 7 Feb 2023 16:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=qcppdkim1;
 bh=N+LhJzGzKRZ+yOwLZVdEUDrMhOLxabpimXgeJt6I7wI=;
 b=CG+RoH9IcBEhtzLi+x00S5sCGD7bSy3QyyS3OzOcjE+KyYNN++jxpZqfcmH2GGr7mA5r
 EW15u/Q9YYvdWKHknzi/lelUvIp+3XqfV2+58lUozmnTVrT4pgjey+WoO13j0Fq0MkQu
 4C2ksK9T7ho0ciYHi3aTM+Rzom2nOkVWWURxf+Q75KaWXugY5H5L99FiCruCrWrRDPUg
 jBW+EipAKC+V/cCgOPmM9UbWJDhHfqsvoO+mE4UpHZhzI8igt5Ct6K2FYlRr7Ox1xA7t
 RvEKlOAX0LqDjbLCKs+CwEa/unS6z8tmA4PgNT4aPHMFzE9pBbkioCeZmkoDtff/uORz IQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkga2shfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 16:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf6SXzfGhqzXQzmZFN6zrQhdix+Im/+C3JW9fWV62q+gpnky5RpthboDEtOkHVeW4vaSlXn4zq6Lpvw6hdtVkusrr0Pup7KWnXemz2SI90JT7Q0ip2JQ4GzmY70lTH/T2h0k7NB3yPBqF5HBjiqSox7jr0lstP3RnwfSDKHw+GIsO3eIfkhXr+Fm4Cb3geO+COhyl3Oa5hCdFVSifSLTfXhWUqA/Y1B+e3+RnzOBLPM8YIo9iMPHXlQkEV12vCMIi511K1vJ6vUEc4QiCqR7OKg6fK9eG3FaCaNlDDMOvWdyHznEHr4gfHVeOqlHepYhw3AAcGQtw3RiElJQV1RWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+LhJzGzKRZ+yOwLZVdEUDrMhOLxabpimXgeJt6I7wI=;
 b=gab9n1gcNxtdqDF+B9DZOpQX1VH6BqRHoXFYohAvbVxAUJeFuE8Zvev5lBrreIgMsOgAz8+uLDnAhyGDHJLeU7puPCRR+Be0atscAk7EPzVwb8AnhFZ+NtB7AAzqqbDExpvvn4Ox1rM+aG3uhy5VP8ohwH/8TpZ1C2I1nEemNTarODgElrtPW2u+Qxp1XfX7GczvGKji8k3M2es2JVggkSLuZSfEZr5Sp4miL3rHYcdt1fv4wzDpzC1InJpXdEg/o48yz3HNl7Mp6glIi4SswdF4CNRBOd8/qvzBl+76urTWnCSHeBDtjovkLwX1ogyFkaCCk3eHFVxlY32thH92Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8169.namprd02.prod.outlook.com (2603:10b6:8:1a::14) by
 CY8PR02MB9130.namprd02.prod.outlook.com (2603:10b6:930:95::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Tue, 7 Feb 2023 16:40:25 +0000
Received: from DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b]) by DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6699:58c9:7fbb:c35b%3]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 16:40:25 +0000
From:   Vikash Garodia <vgarodia@qti.qualcomm.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>
CC:     Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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
Thread-Index: AQHZOt4trMzBaaZ5zE+7PcOTvgimf67Drmxg
Date:   Tue, 7 Feb 2023 16:40:24 +0000
Message-ID: <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
References: <20230207102254.1446461-1-javierm@redhat.com>
In-Reply-To: <20230207102254.1446461-1-javierm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8169:EE_|CY8PR02MB9130:EE_
x-ms-office365-filtering-correlation-id: 0818db5d-b1f5-4b5d-5589-08db092a0329
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3T8o+nw6f3wYy6lMd6O9GQCsjIbByck+sve/e6piLwH7abPX9yu8jiCVvd6nkHApu3SqrGuF6GboiH6YtqLahDVW2uXL0MEPyXWkN8K62BFWHOMDvLmFuq/+ha20WKlC08OvClXEAu+p0KPRvWzZv2zT5rh6kcqAssUsSZl+9VjVm1ujibaS4NCU52EcDJO544mTbAvleZGygqVv1jK490OdG6E3WYElclT7qlEauWKCobgRPzjdVCj8vgGNAa3DvyzAedGM1Hb4UsnKK9gd/rzJzHCAi/sT24VwE9fuYKFJcNayL9oog1XG/QFUiVXWMgsZ3mwqvjPjtQ5RM0v7ivobBEX8nxqisdo/vkygM0Joa9Trf2cm4BsB2wd2YQgNE4OdBWv1+Xu4XoAe/92Cys3n06jyJ7fXZuTZILOEj1AgwH63mWjrDJErRh8XlACQ70ExXctSIIGFmCqiyEtm6iVSXwS7w0uVN10YDbhc96gTn7VEVrP49VKIEdJMRPn2OGMApTMCwpS1fBRI9opojDattIbXOl78CRwVhVVoqMNAf1a+S2t2M+1L/iPGIVUQf/l2RcesV59GPGwgz/yPfX6AUZleUewAvfOuh6epHcfBhERaXrMidadFhc5cU0sNwEVFQfJzpuqzSpIe6jCDHwD+II7WKiGHSE+PohsUkHP9a9T4nlmpHyO8iXw0U5Vsein9MPZXT+p57slzOnkOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8169.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199018)(83380400001)(54906003)(86362001)(110136005)(33656002)(7696005)(71200400001)(55016003)(2906002)(76116006)(66946007)(5660300002)(66446008)(64756008)(8936002)(66476007)(4326008)(66556008)(41300700001)(186003)(9686003)(8676002)(107886003)(7416002)(26005)(478600001)(6506007)(53546011)(38100700002)(52536014)(122000001)(99936003)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EVkt8DR/LXOqcHDYTfFhmIrmBJQXoYWnxzs+2Uxrq7KnGyNBfPRyptvaa1zS?=
 =?us-ascii?Q?f5zoGagGimzpPfPu5BjJiX1xLnKN1HkwCAIp4KhWgahX0xFbvH64gQxT25L4?=
 =?us-ascii?Q?UbjMeWaowiaw4buANesDXgofZstUFlLl/SxeL4sN5i+wTBrbHOvTTCmI06Zf?=
 =?us-ascii?Q?WZztglr8UPqp+LG6fS/FymMXnnXLep0dXyUlAQ94YmZnIE1MtlIbzRRW6LWv?=
 =?us-ascii?Q?yB4gmNtesLZuEwGbmHH1pnE6rkCubjaVZgCQjhm9oFqg/qEdEZzKhYmjZW2I?=
 =?us-ascii?Q?71o58ZETqhdPVDHLkzIuLZEStJyWUGwiSYH8OvEKn2ayk1IIDceXJgnMkUdg?=
 =?us-ascii?Q?bftwsbYSW91vK2yHeO1bB1BBMZjIZ60Uz13dSSc6excEaoRt11xZVH7ynrl6?=
 =?us-ascii?Q?jr0LkONmefiRsdM2kvQMapHUdidivDVWrw/FC6rn7wDhKimGYRgE7jRIeb5S?=
 =?us-ascii?Q?p0QvoYolF/QXVA0D1hJr2LULdpAublBfJMGaWohawEYOa7P0468lZAS/hGvF?=
 =?us-ascii?Q?DPgwd1nnouvhMfEZTr1kOJVq59EoDOoUJbt7oX/uVIK87VvkHzRo0DHImzh7?=
 =?us-ascii?Q?cqDaXAfcFXafgOwhANmS8jVJY4mkhx8SD6YbZFBa4dw98yhzL4om2RL0QBDz?=
 =?us-ascii?Q?y2PfXvj7QUJTsuexEK1goTF1Cq/bh2dHuQhdvEB/av7f3PgZZvjkuEDz8gvf?=
 =?us-ascii?Q?Ucd7FSh3v5iwIwK4lZeVWEsWsMFbUWG0f1RUqzl/Plf0+8pOa6FmyDuctZ9d?=
 =?us-ascii?Q?SE9qJtRHJ77a0Se7eceqjHxh340WL894d2tkyg+EEmpmV7amKRwAYb+2TnaT?=
 =?us-ascii?Q?kWgg1KseTxHT01hCP5bWRxqdUEve7fESRb7WzT/gmo1c2C75hlCGVhVrLXJv?=
 =?us-ascii?Q?l7ldyRdSPhJd6yegBErPL0fflnd5MoIr/fDbE7Vl9QeG0CpW1kHFd2rp7wTt?=
 =?us-ascii?Q?wOqzbKVJK5/64MoFanRMg8TkWM8DizVvKZdol810VADuRCiYBqrFOLdLR8nw?=
 =?us-ascii?Q?OvhZ8KT/57gnbw2YvgfGXju0Zpn4lJ275N9m8FbsJ1tOJBXnFeHm6IiQutmV?=
 =?us-ascii?Q?kxGh/mc9zUMDzhB0+4B6Qs1JD+U7AT8anq3R20+FQ07pz2GKXlb3BcfU/Wzq?=
 =?us-ascii?Q?kvu7MH8C7A01BLF/MlkogcoxPpsqU8xMus2fPVZmEHIT+jKSfD0RJkk2SgQ+?=
 =?us-ascii?Q?X3tJADz9V4JfTlrHaHbreFr5jF0yJEhoqM2ZpTwxfQ7qLlLjrvPJwlRdaxqH?=
 =?us-ascii?Q?/p9XNfQE+Q92XdA7mNh5ExGTGC+Voz4+maqoXxl+qcCC3BVk/xyJyAtgdihs?=
 =?us-ascii?Q?ku2kHaV0MWnP5nbHnlh7StMAcCdMqaV56TJT6Ne6qFEiDirSywTrQ2kVSZeS?=
 =?us-ascii?Q?R1c21JLcGxcbDVnvVZimGqWrYWrBvpisSbvTwSYDbeLBe/+1e7AnJaH/Y48L?=
 =?us-ascii?Q?xHybS50re7DeJJx0aPhKi4MunF2nmumDPyUBLfJSffZ3ikgNTGQCSjNzbkUT?=
 =?us-ascii?Q?pfbXp80St3k5q9ZaMX+6dcTrAypX+i4RTeZu1FLA1rZcHFACzG1mAOR3cGaU?=
 =?us-ascii?Q?p/GP2sDak36KsG8wQhkkH8I/NnPWT2GsEGvXs+Jv1LCdScRiBgoAd32LgaQU?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_002_DM8PR02MB8169809493BF2822E6C29EECF3DB9DM8PR02MB8169namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hq1N/vMrEI+0cH+697KEW2TacAdYSdYpIJC1pZEvVOlygUHQY8QLfLgSsSKz?=
 =?us-ascii?Q?03QIvHp/sHm1X9XWTs7c2Cx4RZwg5Efc1pZeT5OPC5d6JEZ+0MFhIzY5iaid?=
 =?us-ascii?Q?AhQ2mNoHKKXeyU1bjc7jyc2I/Mhn+XuOrYa6OI70/UcG5XN6XcmgZw6EKLQb?=
 =?us-ascii?Q?1bYD1jKSeADqZPEaR/gKkgFkJy7aNGBYPCIeIN2YfCapMw38B/wo7gEzQ4Jv?=
 =?us-ascii?Q?TxPah4h3OEB2XhtfHvVajck1oMVm1kVoy75TVb4ahvq4IXnR2WyVbSMf7toa?=
 =?us-ascii?Q?VOzeXgFERsfpOsYOlr+zfEawFFxGQFKn7OtmYzQxFG8B9YW1qd+Z8HxKOts3?=
 =?us-ascii?Q?KB70YWwfk5KpDx1Bp4sI6YG29VAyApape1r15xMRpyPEtYxlJefzfOV9/ALt?=
 =?us-ascii?Q?52qh+ENHS+D0P0Knsq8WioQ/b3ORUspxZorN9WcUhfnJij0i74h23gWge56u?=
 =?us-ascii?Q?oGwOMmO9D6YJgJpGtY8g2S5kzs/T2v8Q3csakTGG+l965p115735bs1GJrh3?=
 =?us-ascii?Q?cLemw+5SoekyssYFcFhAfW+UnVCRkMnLxubtR+LsHdvz/ml+bfFEapde5sGp?=
 =?us-ascii?Q?5L3pTMrElFoVfWXMLlpxYVI5rlsj4x2FqFsNxicaqF8LXbVzorNC7c2obvAO?=
 =?us-ascii?Q?xPDOG8HxFGq8qfudmoQLRK7yp4hG226BhXQMxEMTRUCSGZwFPXj/fn6MkIU7?=
 =?us-ascii?Q?BHeIVL8o84Kb0ExmHLBOwIirPuwwXsmIsUhhY4YOgCU5oDQAtKJO8PUVy2SZ?=
 =?us-ascii?Q?CjsMZkWO0XCgh0O0qEi55ITxDlyntvIY/kBGQrfZlSCn/jvcrvKFsx22oEkD?=
 =?us-ascii?Q?ne4XbecDW64tLayEVNQdGllT1++z3VgO8ns6s5QONEod/d5dK3O17nOUUoYX?=
 =?us-ascii?Q?zj0Pw73Th3iZGcaVyQh4xcuKZKt5gJaXUO+obZRuTsbYOKNxvfLr1qunbWlh?=
 =?us-ascii?Q?BRuZhNv/CP3SaellH6wvrg=3D=3D?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8169.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0818db5d-b1f5-4b5d-5589-08db092a0329
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 16:40:24.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RA8FNvSjTwdab3bvN5FdEwkPn9hCCBEE0f2X0r719kZLzSfLY+OEld3eP6XbW4ihYpDVlGLMVyAzHfhMTUORyGKGUDxbfJteiEQsbtACkuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9130
X-Proofpoint-GUID: cICxC4KMgCcyti8bvrcDfkI6lrxqzRK5
X-Proofpoint-ORIG-GUID: cICxC4KMgCcyti8bvrcDfkI6lrxqzRK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_08,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070147
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_DM8PR02MB8169809493BF2822E6C29EECF3DB9DM8PR02MB8169namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Javier and Matthias,
Can we try the attached patch if that fixes the suspend issue for sc7180 an=
d sc7280 ?

> -----Original Message-----
> From: Javier Martinez Canillas <javierm@redhat.com>
> Sent: Tuesday, February 7, 2023 3:53 PM
> To: linux-kernel@vger.kernel.org
> Cc: Albert Esteve <aesteve@redhat.com>; stanimir.varbanov@linaro.org;
> Matthias Kaehlcke <mka@chromium.org>; Enric Balletbo i Serra
> <eballetb@redhat.com>; Javier Martinez Canillas <javierm@redhat.com>; And=
y
> Gross <agross@kernel.org>; Bjorn Andersson <andersson@kernel.org>; Konrad
> Dybcio <konrad.dybcio@linaro.org>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Stanimir Varbanov
> <stanimir.k.varbanov@gmail.com>; Vikash Garodia (QUIC)
> <quic_vgarodia@quicinc.com>; linux-arm-msm@vger.kernel.org; linux-
> media@vger.kernel.org
> Subject: [PATCH] Revert "venus: firmware: Correct non-pix start and end
> addresses"
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> This reverts commit a837e5161cfffbb3242cc0eb574f8bf65fd32640, which
> broke probing of the venus driver, at least on the SC7180 SoC HP X2
> Chromebook:
>=20
>   [   11.455782] qcom-venus aa00000.video-codec: Adding to iommu group 11
>   [   11.506980] qcom-venus aa00000.video-codec: non legacy binding
>   [   12.143432] qcom-venus aa00000.video-codec: failed to reset venus co=
re
>   [   12.156440] qcom-venus: probe of aa00000.video-codec failed with err=
or -
> 110
>=20
> Matthias Kaehlcke also reported that the same change caused a regression =
in
> SC7180 and sc7280, that prevents AOSS from entering sleep mode during
> system suspend. So let's revert this commit for now to fix both issues.
>=20
> Fixes: a837e5161cff ("venus: firmware: Correct non-pix start and end
> addresses")
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  drivers/media/platform/qcom/venus/firmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/firmware.c
> b/drivers/media/platform/qcom/venus/firmware.c
> index 142d4c74017c..d59ecf776715 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
>         writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
>         writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
>         writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
> -       writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> -       writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> +       writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> +       writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>=20
>         if (IS_V6(core)) {
>                 /* Bring XTSS out of reset */
> --
> 2.39.1

Thanks,
Vikash

--_002_DM8PR02MB8169809493BF2822E6C29EECF3DB9DM8PR02MB8169namp_
Content-Type: application/octet-stream;
	name="0001-firmware-video-configure-the-secure-and-non-secure-r.patch"
Content-Description: 
 0001-firmware-video-configure-the-secure-and-non-secure-r.patch
Content-Disposition: attachment;
	filename="0001-firmware-video-configure-the-secure-and-non-secure-r.patch";
	size=2481; creation-date="Tue, 07 Feb 2023 12:17:01 GMT";
	modification-date="Tue, 07 Feb 2023 16:40:24 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiY2NlM2ZkOWU2MGE0N2NiNzA2M2I2YTViNjY4NjdlMTlhMGQwMzE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaWthc2ggR2Fyb2RpYSA8cXVpY192Z2Fyb2RpYUBxdWljaW5j
LmNvbT4KRGF0ZTogVHVlLCA3IEZlYiAyMDIzIDE3OjQyOjExICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gZmlybXdhcmU6IHZpZGVvOiBjb25maWd1cmUgdGhlIHNlY3VyZSBhbmQgbm9uIHNlY3VyZSBy
ZWdpb24KClByb2dyYW0gdmlkZW8gcmVnaXN0ZXJzIGFib3V0IHRoZSBzZWN1cmUgYW5kIG5vbiBz
ZWN1cmUgcmVnaW9ucy4KLS0tCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvY29y
ZS5jICAgICB8ICA4ICsrKysrKysrCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMv
ZmlybXdhcmUuYyB8IDEzICsrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9j
b3JlLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvY29yZS5jCmluZGV4IDk5
MGExNTEuLmUwYTQ5YzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92
ZW51cy9jb3JlLmMKKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL2NvcmUu
YwpAQCAtNzYyLDYgKzc2MiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZlbnVzX3Jlc291cmNl
cyBzYzcxODBfcmVzID0gewogCS52bWVtX3NpemUgPSAwLAogCS52bWVtX2FkZHIgPSAwLAogCS5k
bWFfbWFzayA9IDB4ZTAwMDAwMDAgLSAxLAorCS5jcF9zdGFydCA9IDAsCisJLmNwX3NpemUgPSAw
eDcwODAwMDAwLAorCS5jcF9ub25waXhlbF9zdGFydCA9IDB4MTAwMDAwMCwKKwkuY3Bfbm9ucGl4
ZWxfc2l6ZSA9IDB4MjQ4MDAwMDAsCiAJLmZ3bmFtZSA9ICJxY29tL3ZlbnVzLTUuNC92ZW51cy5t
ZHQiLAogfTsKIApAQCAtODcyLDYgKzg3NiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZlbnVz
X3Jlc291cmNlcyBzYzcyODBfcmVzID0gewogCS52bWVtX2lkID0gVklEQ19SRVNPVVJDRV9OT05F
LAogCS52bWVtX3NpemUgPSAwLAogCS52bWVtX2FkZHIgPSAwLAorCS5jcF9zdGFydCA9IDAsCisJ
LmNwX3NpemUgPSAweDI1ODAwMDAwLAorCS5jcF9ub25waXhlbF9zdGFydCA9IDB4MTAwMDAwMCwK
KwkuY3Bfbm9ucGl4ZWxfc2l6ZSA9IDB4MjQ4MDAwMDAsCiAJLmRtYV9tYXNrID0gMHhlMDAwMDAw
MCAtIDEsCiAJLmZ3bmFtZSA9ICJxY29tL3ZwdS0yLjAvdmVudXMubWJuIiwKIH07CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvZmlybXdhcmUuYyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9maXJtd2FyZS5jCmluZGV4IDE0MmQ0YzcuLjVj
Yzk3N2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9maXJt
d2FyZS5jCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9maXJtd2FyZS5j
CkBAIC0yMTAsNiArMjEwLDcgQEAgaW50IHZlbnVzX2Jvb3Qoc3RydWN0IHZlbnVzX2NvcmUgKmNv
cmUpCiAJc3RydWN0IGRldmljZSAqZGV2ID0gY29yZS0+ZGV2OwogCWNvbnN0IHN0cnVjdCB2ZW51
c19yZXNvdXJjZXMgKnJlcyA9IGNvcmUtPnJlczsKIAljb25zdCBjaGFyICpmd3BhdGggPSBOVUxM
OworCXZvaWQgX19pb21lbSAqd3JhcHBlcl9iYXNlOwogCXBoeXNfYWRkcl90IG1lbV9waHlzOwog
CXNpemVfdCBtZW1fc2l6ZTsKIAlpbnQgcmV0OwpAQCAtMjUzLDYgKzI1NCwxOCBAQCBpbnQgdmVu
dXNfYm9vdChzdHJ1Y3QgdmVudXNfY29yZSAqY29yZSkKIAkJfQogCX0KIAorCWlmICghY29yZS0+
dXNlX3R6ICYmIHJlcy0+Y3Bfc2l6ZSkgeworCQlpZiAoSVNfVjYoY29yZSkpCisJCQl3cmFwcGVy
X2Jhc2UgPSBjb3JlLT53cmFwcGVyX3R6X2Jhc2U7CisJCWVsc2UKKwkJCXdyYXBwZXJfYmFzZSA9
IGNvcmUtPndyYXBwZXJfYmFzZTsKKworCQl3cml0ZWwocmVzLT5jcF9zdGFydCwgd3JhcHBlcl9i
YXNlICsgV1JBUFBFUl9DUEFfU1RBUlRfQUREUik7CisJCXdyaXRlbChyZXMtPmNwX3N0YXJ0ICsg
cmVzLT5jcF9zaXplLCB3cmFwcGVyX2Jhc2UgKyBXUkFQUEVSX0NQQV9FTkRfQUREUik7CisJCXdy
aXRlbChyZXMtPmNwX25vbnBpeGVsX3N0YXJ0LCB3cmFwcGVyX2Jhc2UgKyBXUkFQUEVSX05PTlBJ
WF9TVEFSVF9BRERSKTsKKwkJd3JpdGVsKHJlcy0+Y3Bfbm9ucGl4ZWxfc3RhcnQgKyByZXMtPmNw
X25vbnBpeGVsX3NpemUsIHdyYXBwZXJfYmFzZSArIFdSQVBQRVJfTk9OUElYX0VORF9BRERSKTsK
Kwl9CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKVGhlIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVy
LCBJbmMuIGlzIGEgbWVtYmVyIG9mIHRoZSBDb2RlIEF1cm9yYSBGb3J1bSwKYSBMaW51eCBGb3Vu
ZGF0aW9uIENvbGxhYm9yYXRpdmUgUHJvamVjdAoK

--_002_DM8PR02MB8169809493BF2822E6C29EECF3DB9DM8PR02MB8169namp_--
