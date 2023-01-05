Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE3865F447
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjAETTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbjAETRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:17:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1F395FC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISl8u001322;
        Thu, 5 Jan 2023 19:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vxu9/GSp2gjISoQa/VWxjVS2svQdljAFFuFyxND5ieE=;
 b=0pDXVgG4829nnJZB9LgAh2mJ+R1/doBCBKwiCo8ahBqyTee/zA552ae+zFnrjdD2XRsp
 U+KN3wxzbytUvMrpCbyViki20ALG+H3REIaM91h8I+Rw+PpfDqIWyJ8h0StSrhL0TMIE
 vn/iGw1YnM5l5YUU7rJL/Rnl1s1lYV51vUYPqxJMh4LBm37UCpNCcmOtuiir97InergY
 LGRAR4bVjFBRzKl8iHbjPNk42WaIWzF9qP0fssE53ytNDnho9Yg7A4CAP807R896vek5
 zn94DU2eCa/Y5eHk9mhOmAgEgkxXmpe6cM32ceImfGS452jAGRbXlP/XBCpFsgm5sOHD 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9qw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKZ033879;
        Thu, 5 Jan 2023 19:16:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ/LK75PeU3TLuuLNbSS8Arz1CvxeOfUK6l3FIOoc7G0lD3KAdWX7Hw4/ckyFL0zVWT4/3lO4MWzLXCcwbCWwToDrSZK7GmXtgI2ImM6agyayBw8uiozjMZ+l0L/uCL+5GxJotU8iYeQuR/GhYOXqONAQPw6/phaF50VOc1r2dFs+Vzl+Da8qCWhw4b6l9ffLbb740NuZ3tP8ZTelnKyYZCeoFWdnAUVVyjxlLdRJlkdP+OSopTJkzpQVF//o9oIUiBhP/UE4Zq2Bc8r6Hx4K8Ct+M4lp3DSiiysb+81gQNM8cRHIZJFAl4nJsurEoLDdkPGBXsfJ0trpVlXxLuHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxu9/GSp2gjISoQa/VWxjVS2svQdljAFFuFyxND5ieE=;
 b=FuuvJLvXKBOta2sN7YfBxqxpf+qR8mr0la0KsCraF+/3PUtle4UR/qpyKvCAPl3Taf0T5f7zC0oT6rVCX0Rrtr596ePfXDRqRIcvWbQ8S0gv9+VfoDcYL+a75oma+5JdrHoZR2pLbsYCjgHQ6+aeEfVtVndkJEDZXAaWRReEVhJ7I+IrWv8olTixxIkF8Gc3vENVCLDoo/sD2/iP73DkkLIaJi4K2I0ir7NUdvZXM0Q/Mkhiix9OT5uFN6EudfkVY1xvOY8twj2jyD5055HuJ5ZfXCR97lDGTT1/cuBKj2tDpUzRD0FdHvplzD/QznEYhKsy+/IqD3sAQNCX5/7V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxu9/GSp2gjISoQa/VWxjVS2svQdljAFFuFyxND5ieE=;
 b=h0zPWCCzRZHmIX2joAsur3Jfx6T/AuCHMZkhrkav8OKXYj8NbC2dLM/WCoJs+zmfdG+FPhlSEWm6wn/QJSJZBaIy10NWvGFDRQ7liOoPKd+MZhuX/x6kKCheN6vElORAI+s7Dvyx0hfBnNMw8oUgCjZbQux3M49u0fSVT5zlX3o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 26/44] mm/damon: Stop using vma_mas_store() for maple tree
 store
Thread-Topic: [PATCH v2 26/44] mm/damon: Stop using vma_mas_store() for maple
 tree store
Thread-Index: AQHZITolwyWRLkqcX0iP8U6GnafTZA==
Date:   Thu, 5 Jan 2023 19:16:00 +0000
Message-ID: <20230105191517.3099082-27-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: a55ed17c-b462-4ad1-df9c-08daef514b18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/xNsrKXRZZV/v0bKBbrZ5W2g9HrFoqqi7GUxTd7ULkKK/OyARmWo7Ww2U9JzM09c9qOElf9CK62WIFCMZl1+Kv7AMIzXea0fGXUMqlKoYJleU0rZZIpXafnUVXZjgvB1gGvldgdSdUzJCtn3yvcMYsjBX2Q7kAEMu7Sycp2RCwOdIoOFH9JlztoPQHkDV67t7cYhTadZAg1Dv055vYdIhwFgaa7DHNd9iSxf/EFk/ObtP40BnaqUzmG2TTPoqApOEo58tAbrkuUlbFlftpf79k5WJw57PTz4050TZuQ4njn+YwHITOqVouqyMfZlBPOAbtxu/EfxqJOiAZ8aOoN09qTNOyxv2auj3FiFYWPZOJAOKBiikzCc0rK2KXiXzgKnPUVEGtHdU1B5n0LtKFdBJlhMq0Rhuj/dSsuSTWAXkWpvsz4lrk5VU5gl3uCNzF3ZztzM2nX7gIGSjwdrvFIhS6MUKa/fQ3TXTt22wqVMjuxdvczpm7Gcjzjl6jizHCu1cfS4dojDEHXxHw+qDB1X1wRhxfgJCfZObJpunHLX6kTUZ2vSDYSgotIkXAoUVMhKYUGvuI/+H5xBiXfYqH5hL5IUOrtn8YcAnW1KdNJPU13fMkrA1YAjNihNBuJoTvz9vKBnJU5xUrhMvFkqFVc5vCFf+o1zJD7GH60crlJ68t0k06N7b6CrdSJXm0TplWTCVYkcRiE06kJhc6gir8F1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(4744005)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mau4lxzIiZVEw9i5YIxOv+IUv//rquaxsr3xy9UfEH2u093MQkHKny2Opm?=
 =?iso-8859-1?Q?t2MRe0RCA3ZOuKmunF9UXKTejoJShCEPhzwDPC031ZfeXOHJJdc2nVZw44?=
 =?iso-8859-1?Q?fiIG2W84y9PzcAM3P3hfzTNjWwAg/zmvuWD2s8NLriMlotalMaShvLKw7p?=
 =?iso-8859-1?Q?ZvP9+8tqrVGCSC0PusArEAx1r6GGOIqMymVuVG+KX1dzc3TBRrgAKcFv3F?=
 =?iso-8859-1?Q?b/GVpxTvJlrZF/izHu2E+mpHm6GTtRV/ixbWoz0KOjtRqR5bfM02GjaS6n?=
 =?iso-8859-1?Q?bPSyBZ/X9wFL+lVK9BiXpyctBY/EHW0XIYkWLPu6+o+ciiSJKZfFPoZQ5t?=
 =?iso-8859-1?Q?RivB0wZhQa9DlkADuAbFf53FBkWoztEkeCBFs3qu0Un2bhhlCcLnsMfzhx?=
 =?iso-8859-1?Q?PWXQFog491gG8ESpyEKUv5e4r7UTrFXcOHsLKS+j+qdmFNHrdxmztQMmj5?=
 =?iso-8859-1?Q?xIx6mKgwHNLDKxBm2MuQBhFveaeJl4HyEh+M+7vF7nRpqmpE/USG5ptymj?=
 =?iso-8859-1?Q?sIsTdKo1RzxcS8ctiuRLiGsTAkaYuVtsjZ/QMuGhnCZH9A8aB1OrBv3f0r?=
 =?iso-8859-1?Q?vwgIyAZMao466fhxCY/7C+tOQETtEmFaMS0Bkbdmz/bmQZygXCnpcUx9L2?=
 =?iso-8859-1?Q?Fp3Zu+ND4cWSiLsWvfsDvWqL27dgGFSUwL8EDJ8b5kU6Vr8rQXRxhiaV0D?=
 =?iso-8859-1?Q?3odUnJNJELODj7tdVy+sWNq7Boo1KOf47vI4ncNWk3X/wchzhUuphJVFQd?=
 =?iso-8859-1?Q?7NkT0cHd3bFNaUxb4QtsHxMMJBoY+4E4YS84Ud3pXoA/+aUxyT1/V7iINO?=
 =?iso-8859-1?Q?+LmfBX0rKQ87F8Bl1MTxuUhJyxY9BBiCV6qNg9i4m85oGtrn1ZRIh8YfED?=
 =?iso-8859-1?Q?C54TdlIYF6Sb1Mg5o81Aa158mbzBhcPJrw3mrPlEFFCfY6sS9zAbAQ8DQH?=
 =?iso-8859-1?Q?guErn3KW5D5Ou1pa+XL9Mefx9r+qEZ4BBmEXcfWpqrs4ErbXvgnUv9mOY7?=
 =?iso-8859-1?Q?bslGqoyzVNd3fuN84TdtOMX3CfAR42TLfOvAtS/HdNNQb3saGofg0Qape+?=
 =?iso-8859-1?Q?DuSx0U6r8nVkkpuYwDjFu3yRegd3nHz36VaawayZEsVLSwI92MCVETC/tm?=
 =?iso-8859-1?Q?F4VLuGHvaXJ0BqcolrnK30shuKGssCa7vqV/vlHWy8JAHr8I40jA4klrvy?=
 =?iso-8859-1?Q?kJjqmxgYD2LDlwO1S5Q6iAA9NZcNhdbL/+O1lV9Xg+sJSej81EWnKgN3BE?=
 =?iso-8859-1?Q?EYRp2kiSnMsGUmlJIliT1Tc01KZTwX1+iJFwxEXUmEj0c/hJfTjNtEBpBa?=
 =?iso-8859-1?Q?dkD9Acm9Kyk9WVgnPxgOECR2JEM34WYGMxlF+9PlJCTAac6jYiVrNXtauw?=
 =?iso-8859-1?Q?FED8H47F3ikzrj/Ujhe/HHRsR69dYKHOqLzEvpOg+MLdz3tHom95SPxGLa?=
 =?iso-8859-1?Q?rbQDbtHe1T/k0/8cxoZ2T2iC9yuk9SmsI79wiGaY3SKcXh9ae7yUzPjXns?=
 =?iso-8859-1?Q?W5RzhgShvRSByGn6WpVtxwKqKuqmp5ipWwiMkVTHN6y0LVUd3EvK3otcau?=
 =?iso-8859-1?Q?IF0RyJQCAzgIzdrJ3ApwWFP2EGx3QtslzBCpgYWVwyD7jA42mxGO/krRTZ?=
 =?iso-8859-1?Q?7622oZFqLHwHQY/OtIDFFFHwfPc7icVvGzO+BaYZIpUTxgM7KNPzl3fg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?DVzOlMjzB0HP6c/rqTp0i1D81/k6tgJ1/AZ8YT9IvydiZqtd2kURkHB6ps?=
 =?iso-8859-1?Q?g1V7Ad2/Vx0RexQXi6lZ3lF1RIQQNz5bqpZ8vGhrtDpWJS3/KlT9XzLTcP?=
 =?iso-8859-1?Q?q9iFLXuY5r3sb5Q+Wfe+oRSoFEVG13u/nV3/I8NI6KvHW55qJg3pxbZyuq?=
 =?iso-8859-1?Q?OHTLhTgFR/+2V9uhfPOMWwq+WE7PhSj18MVvngE5z/Wj5GmsVhV/N3z/pj?=
 =?iso-8859-1?Q?/Su+j0OcmntTGyMbPAIwUEN/gKLV4c73QUhbxGmUZDLOOh0rJirUfyNOwt?=
 =?iso-8859-1?Q?/bzCC4yQ3Yi4ihKggqRW3nA2cST2MNTmVLYjiBe5VS8+pb9ygJTRubDDxF?=
 =?iso-8859-1?Q?jNw4KL01JN2dEBciwiT82wYRI6METXXQkrjZW6PSOxb5z2pZihfuJPGwgd?=
 =?iso-8859-1?Q?y40n+Y5LqSBfZh0GYY79k1Xp7wGdRl6H1ByFmGHlhq2ynVU4zHEuKT8hcY?=
 =?iso-8859-1?Q?DCN7f6aFKLFYTF5uxbDGTl9BFDKgCid3z2gvwgyolyKTlEQ7lVGesNmGYp?=
 =?iso-8859-1?Q?W1ZdcgjjeL77fASPStxRm5oNMtN87YmKRd2OlVc5mjf67LnR+nxFe1o6H8?=
 =?iso-8859-1?Q?TrZlt0oY9qovBMWCL9iLO6UcIr8Bn5akMSPu6FuR0ZYZs7u7MsSb7I1Po3?=
 =?iso-8859-1?Q?5f2TiYyVS+MIeBeZRSJy0ltjzXN9fwmOO1bVXurSuxKXVvWgTuLkvnpD+Y?=
 =?iso-8859-1?Q?hVdqy2iLt3SVQ+5gWKaSFljTUgh+icMXLjE00rD1JbYh6fC72xDradR6Yg?=
 =?iso-8859-1?Q?baZVK2i058dtut7L4X/H6jjbdUSC7QmcnY3U050coNdC/wMmntZqj4kJgn?=
 =?iso-8859-1?Q?LzgzvT7VTcD09+n0R8Zgi+Z4jf6tIX2JxIj27W5GMh5/urcg9BTcP7GfBb?=
 =?iso-8859-1?Q?FRN6oOLhg6jD6X1jwQ3AbeEUhFNVjl/w9Gzx6CYRrxolZeiDXYXkoHVi0/?=
 =?iso-8859-1?Q?SjgphFDnbN0By8RqTlbqPrMO6USXx3znuyQ7HqOETOR+20czNSVXw0SZOR?=
 =?iso-8859-1?Q?+28YIxCnQSw5vxGCU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ed17c-b462-4ad1-df9c-08daef514b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:00.2817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6sUvcBRIcEj3Z05VWEP/3NpJ/NeAKHVm603Z+f/LFzjs2iNXVsIUazAkNpfS6H8stZHF5dVfNiZHPIAMA6DFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: Fm86oMk_UF-JFlvoRsy7BKLViUowZ0os
X-Proofpoint-ORIG-GUID: Fm86oMk_UF-JFlvoRsy7BKLViUowZ0os
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Prepare for the removal of the vma_mas_store() function by open coding
the maple tree store in this test code.  Set the range of the maple
state and call the store function directly.

Cc: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/damon/vaddr-test.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index bce37c487540..41532f7355d0 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -24,8 +24,10 @@ static void __link_vmas(struct maple_tree *mt, struct vm=
_area_struct *vmas,
 		return;
=20
 	mas_lock(&mas);
-	for (i =3D 0; i < nr_vmas; i++)
-		vma_mas_store(&vmas[i], &mas);
+	for (i =3D 0; i < nr_vmas; i++) {
+		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
+		mas_store_gfp(&mas, &vmas[i], GFP_KERNEL);
+	}
 	mas_unlock(&mas);
 }
=20
--=20
2.35.1
