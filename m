Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3963694E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiKWSyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiKWSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:54:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453DC13CDA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:54:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANINwgg016155;
        Wed, 23 Nov 2022 18:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=M0Uhp3tREcYerferrwrEuUuFMNGmCAzOo0lM2QkgTFo=;
 b=ZDhaCDaU6SrxnuysPcPyHh9BfGlochkHRczbx7G5AvlJa2GMO9yo/8FDZWaQQkyK27qo
 om1gL5aB4nZ0fXnzvXr+qMEqU+GyD8YFfIEUHK/w7Rg6RtN+qXFE3KYMaABlg/PjwWU6
 MA69+jH4R/VOxDAR5vCpbb0GtAhNHTV4+tUMcgyvcf3W7/xCAkXvAvFRW141Edi/GcNE
 9ym7qDJqkGk052MYVJLbXG+PkBdJcpWNluBBmLB1OCTUBaNAqQFOIrVUGhJ7dIYkwgcT
 TELLN6ZL440azjWoLSi+QRNXHHHlxt6+Hg0aPrKLJtYin0xxSmxxajGuR9JPHQpTamva gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd88q61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 18:53:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANIiHTv009778;
        Wed, 23 Nov 2022 18:53:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk7f2aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 18:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdn1/+96wYixNu4GO2BA/ScKDvpk2nAYTPsjDaY+rTrx13PBkSCUcAa61NwqTp8fpE6gPkNJwBVI22PW8FmLBVZ5wCoV/vyycIZH4X+EQC4LsMucP5tgrzdQNtxXJ7Usx1Z5uWRJ9xs8ptg2mOQUc3f1hQICxvF48+6c/x9b3kMWa7DO7K2XzqxfK3wMcjHaAAs9/oD9jlBuRp95snAPVm8S7FXdfYWc9Mr8F4aNUHDNEsDOw3UYUUfvZQbc52akGGEGFvClmmWBKIDkQSGL/syDfIWlF4Ow6TjsDe7+Wh2kFpaXzXQj99Oy2wmGSzmkBw7OAmWcksoOshXHgQZ0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0Uhp3tREcYerferrwrEuUuFMNGmCAzOo0lM2QkgTFo=;
 b=ZVm/HEogqYmu76RRcVy596qjlTniAbGIQk5TEI9WaYKV+DQtnuZCn9SJqPQ9FAV76ITZLyVrymc4E7Puo5xmUF2mIATCnFmwAALf8FdzIFxxIg7loI2m6uxtCBDo9/Q3EY1Xwv3yjSrG1FmQC02VcXvkMVKGidCqCg6vEvhKHgddfqouwABh4RZGyLK8t/kQTr/+nxhMqEixByIu4iW0EZandE3GD/zKnaoGlSnmG4Xb53cgsHZFtwn4qc0ng2+DytYHbYwH99DWHbDkzvRaFXyUogk30NAWdnzvzAYELZr5zh3XyKKzyqf/hTuZDck9tSUQKCryD/WLvIqrzf30Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0Uhp3tREcYerferrwrEuUuFMNGmCAzOo0lM2QkgTFo=;
 b=TYxXjN7/iAzk7AQRFCwJR+ZjwibV1xaowxhPZPgKINg3pxfMs6aTaix4YIzCeXGwSPBtpIwXIy3zSyBDKgYzqXEucIUpl7tsSFeUbPSKoF8t6uHbKs/hur4M9zg3VdbNyWxMDLgQQW78DSesozoZiYjpxZ0SbY26uxeIUtLk+OE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 18:53:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 18:53:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] maple_tree: allow TEST_MAPLE_TREE only when DEBUG_KERNEL
 is set
Thread-Topic: [PATCH] maple_tree: allow TEST_MAPLE_TREE only when DEBUG_KERNEL
 is set
Thread-Index: AQHY+9r9CftH3uBNqEq6k3ovMJNrz65M4h4A
Date:   Wed, 23 Nov 2022 18:53:54 +0000
Message-ID: <20221123185346.q6sfeb74ahj3rdcu@revolver>
References: <20221119055117.14094-1-rdunlap@infradead.org>
In-Reply-To: <20221119055117.14094-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MW5PR10MB5808:EE_
x-ms-office365-filtering-correlation-id: 7b0f0a69-ac57-4c6e-4e08-08dacd8411ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PnpUrWseUZSYJMakL/FIHYQ2xmB3X3N+5ccuh47RWJY5ZDyP32UpSkghbGrLjVt4gNSp0JM9aDVI3ro+dVma5sOGnN7oI1/Lt3rRYvTYwb/3SAy2ADo6hZMGFTuMNS/7p3JxsmFM8TdrG6yqCX03NBPg4To0hBu4LgdTLIyj0DskXeQZkntzCCOqfyj8V6WiNx7zTIh75YgIca7onDSLZM07bu0LjXQ5W6aF0EfWfhERtXMSwjG6WpgHiAkJYpXblkVUNICmLLD3RRFEn7uQqWwyJ17u04853suywdu+u/0rPYjLq5QFRSDcxA1SdenRmwmiKCcXxM0t5j0L4NFNu9YvgV95Nrv+EJA44MoFt+3erb8QoYNdd5hqQmtikKWhQopofSEWzTBL6Xz2D0naJG13LfP7De6TRBJGIYq+n+U7swDQLyL5hCPNyTm+DNrADg00qacqEQkjesfqOjYewLHyatQHci9UxHVtb4+F8wXbMINz0LXZ5FZU7dwk/iumgpJI9bkYmKqQTbMMP9j7KGKpM1dH1c3JrIZtYXO7xavf3yHyq0RsNpWuljPvc3Og+SmZmB2sbXkWb8GhleHqlIvcwPXaoaMX3ghMn1uksC1Sc91SfZ/XlqUgnGzx/J278AQ0dnFnr+BI8NC6AnZe+lLtMz7L43MlK45dRTPrwtKYBrdXZRN7nh2vNgdu9WcibHlg/NDV7Gi049ETEVMm7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(316002)(54906003)(6916009)(86362001)(41300700001)(83380400001)(8936002)(8676002)(76116006)(4326008)(64756008)(91956017)(66476007)(66556008)(66446008)(33716001)(66946007)(5660300002)(2906002)(122000001)(44832011)(38100700002)(186003)(71200400001)(1076003)(6506007)(6512007)(9686003)(38070700005)(6486002)(26005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PD34ke+bFdAcSm9RMDArknnywwi8IXt7w/4NNyM8ftwu8HsiUMiwPwRMinD?=
 =?us-ascii?Q?a49a0WoXRe3k9WAMOFcDZZdx6OBoXH04jlfU/PIUtttR5vNNI4kSS9XCHdf+?=
 =?us-ascii?Q?We8nYK1w9K5vZzT7akjl8HbgRypKAPAmWy7XvhPFY5mhJS+uS95V/5CL6CKM?=
 =?us-ascii?Q?Q7y+ZHH9AFsLJ85MJfbHu3z3mfqDWocpMCuwdvG2ehudXIDTvJHLX/7GnTjI?=
 =?us-ascii?Q?OQeY5YsTF5FyuwPVa/ljwLRORBTt8dQR6BGgSnFJVMJJga1m0I9h2Ys1YdX3?=
 =?us-ascii?Q?Biua5J/CQThYO8qHKVxQZX+4SP4y4KLaPhClidfPe259PTSwujP0FA6GpkIm?=
 =?us-ascii?Q?jelY3moNrioUv1lBqH1nN5LHgTlsTfz++KvFo0KcISbuYtFEz+Ebtge2UXgh?=
 =?us-ascii?Q?DrInNWskM8L9tTLJQ5s/ApXRJRKdvpI7FGFtVO/AoG+9o3GWUxsfoHfFI4Sv?=
 =?us-ascii?Q?pR7KWUeA+JcyK+MRFNcwNGLMt/DYjQtYmEYanrfSsRvqxuHzDgflPyucERhk?=
 =?us-ascii?Q?6zLUcmGi10WghUdWiyklB9DC4nIw+Y3dv2ZrJK+E+MswZW+Apr8x2WdZogHw?=
 =?us-ascii?Q?PJSRWxUxbaM9S/ceqiJwS1hmusE6xI0TepIobYa/iVMDKLzEnT0sGMw1bNrb?=
 =?us-ascii?Q?ETsN8AAC8MNx8v37spgHMqCE42i2J2z7Fez2C11Ysen0xeSZ85kgor15uKrF?=
 =?us-ascii?Q?90QeZOS5cOPZI7hvIcu4/Fz7yovdQ/ddw0ueCiCzihi4JpGMiuPdjdjY29mp?=
 =?us-ascii?Q?0C1s4chM+jRSHrK3q+ncmP5my3o6NxLuIzaLk0I1YNpccDhD8/jGcst7YaYx?=
 =?us-ascii?Q?nM2v2ogGuGgOZWGwQCZubm84zRt3tOyDAO0omgSTQm4KvdMkDJoqKUgdHCRh?=
 =?us-ascii?Q?VfuMGIzWs+nitmc6+mkB+Qk4Ovu3joE8VNBbbaJU6EHpAWZDQb/l8cbwkMoX?=
 =?us-ascii?Q?mnz1qw1JDM2oK37+XdVS0ezPVL8iUMi2Q+GlEB9PIzQ28YMbpQcACA9Vw+fJ?=
 =?us-ascii?Q?YaobosJ0ITWCpeR8zBpnT5liqs7t0ax2j+mdadKe/v8iFfRrzatGtm3RWWq0?=
 =?us-ascii?Q?CJNcFZ0chw6PdEj/UjBjum/4jvbUK+JQKmDlaY+4nEIOwPb8HB4I4iqnTZWW?=
 =?us-ascii?Q?L6KJ4BM/9Gky2OMzCfxpKDpTXLs9k7j4ue7MlOXhbNiv02VOM6zHiJmft+jQ?=
 =?us-ascii?Q?QtXAd6qmiYm54LkU4XCL3p36G42zbhB8oW+uSjS/m5VaVcPzL1xJIy+bSCh3?=
 =?us-ascii?Q?a6iqyZPhUEldTJFVz6pT6MWZjS5Di3vczvMo6TajzxFZ2+4ZHgrXEUsFzGFM?=
 =?us-ascii?Q?jaxDS8oD8slssl8DE57DEzRXXHsflWkgjzIJ2LI5ZcePatrgYuXs2NKRHBHc?=
 =?us-ascii?Q?AxsWq+4lEf3cPjD6QYaF5czvtatng21aY/hCxSSjhR+G0kmMBRq0gsFZFPhu?=
 =?us-ascii?Q?fv50t0Y/Q6wRk3Q4xEekChiSyGwyYwYEuj1tkcyMTJDOUflB/Bommo9qwhcP?=
 =?us-ascii?Q?UP4U004phZManp6OE5dPJK3k+eMJmBEBR4bU+WQo/yn0PxvCipJMlQUBiVaI?=
 =?us-ascii?Q?NL2DCem+w//+3kuYMLOlF6BtfKuKFLR8+MsEGGM7k7UliFFUFtSNnfGAh0Xb?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D54173FE771D744A6E478B1C9DB55DF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?r03bdeMWAFl+YvnxWt/+YZMIKNL8mL9lkaPWqlumwH/FmpIiHnYLokDrrQjz?=
 =?us-ascii?Q?3L5XRAtUGbFoUMTIR0XaYaJnYA6fFVmUrjwkzn7xjZdxggit4qzCShW6T0nN?=
 =?us-ascii?Q?HDK/UMVVpiwHe/Llc+3k8dp9AKZeRYTzNhVOh42KodhsZZv7IGI6v8KCx/f2?=
 =?us-ascii?Q?QkbZ0p6PgusmVF6oxewfNISIEpWCZQG9vfyz0VVMbk/7KMNcNfpPr15vnPCB?=
 =?us-ascii?Q?YKsFV8UwOvmHpNb45iwo4pGzED5IR5iDceH3iiQTWy5LcuMpuEBFu+5UvLwr?=
 =?us-ascii?Q?nLvG98/QJMhVgubwlWvo+PN2RC1O1YeD62ULDUp1eKdRTVP82B6lHCUiSXW4?=
 =?us-ascii?Q?x7W7OlIcMvXaiLHh1uGCKOzijtbWLWMKgD1ivS3eVMZNrRNxhqLO4vKN6JWr?=
 =?us-ascii?Q?wFVzGqsIvFrd+46uXXTICuwJG7ad9pKlaRSfqee4Egsf1pGYJEgUYp+mSs1B?=
 =?us-ascii?Q?r0yCMwD2h6IVnaP+B2hvxIuvid5pSyLWqS/dcffzYvyRoAtInFbzV+NTNcM9?=
 =?us-ascii?Q?9LgeU7q5WriH2VrYgMwMygUEIW2Pr4XhvwBM/Xe5D5tsQEU2QH6DhIS59gO2?=
 =?us-ascii?Q?y81FvbhJ1i0aQv+jdURvVH6qdCSUN86yv/f8GbQEi7IjhqPLXZP9T6jLYrv7?=
 =?us-ascii?Q?TwSlXuWU/JS6RYEcdCMx6Koc+LUHUYdA8UCar4aRcEQiDt2OA8L1GFwCFw9Y?=
 =?us-ascii?Q?XPBijJycYbCL/76hRtvjaDNO0tii2VKcss8nb5LKoHMjcN77dtb8PLNkrRh9?=
 =?us-ascii?Q?fUhYLR6F6UzjgdlYGh7GI9+arKndlFRMpACyOUXa7aKke6qikbtBmyMmO9pg?=
 =?us-ascii?Q?xPxG1M4lkJgtphLphgDhyZY0wIC8wl3fJr/JZagvU+6yD97IoBPJ/ZYWl7MM?=
 =?us-ascii?Q?6mlwFKXmPxQHXpoyJJA99bw2cg0KWm/QzI92pOuNEM+221d1OQJNmEpIGx+0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0f0a69-ac57-4c6e-4e08-08dacd8411ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:53:54.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cs4+iOGYdF2gObHrGygFn+vVFxlZ/m510ftiWR4d4a11MGD41Liygp6Zd/gK3WcX3Tx0l1dS6EOc4N6UIsutCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230140
X-Proofpoint-GUID: k8zeH-ozjzrrWghAZbXteZBoYvLLIGQT
X-Proofpoint-ORIG-GUID: k8zeH-ozjzrrWghAZbXteZBoYvLLIGQT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Randy.  I'm going to look into doing as Geert requested and avoid
pulling in dependencies, but this is the right thing to do for now.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


* Randy Dunlap <rdunlap@infradead.org> [221119 00:51]:
> Prevent a kconfig warning that is caused by TEST_MAPLE_TREE by adding a
> "depends on" clause for TEST_MAPLE_TREE since 'select' does not follow
> any kconfig dependencies.
>=20
> WARNING: unmet direct dependencies detected for DEBUG_MAPLE_TREE
>   Depends on [n]: DEBUG_KERNEL [=3Dn]
>   Selected by [y]:
>   - TEST_MAPLE_TREE [=3Dy] && RUNTIME_TESTING_MENU [=3Dy]
>=20
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 120b116208a0 ("maple_tree: reorganize testing to restore module te=
sting")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  lib/Kconfig.debug |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff -- a/lib/Kconfig.debug b/lib/Kconfig.debug
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2259,6 +2259,7 @@ config TEST_XARRAY
>  	tristate "Test the XArray code at runtime"
> =20
>  config TEST_MAPLE_TREE
> +	depends on DEBUG_KERNEL
>  	select DEBUG_MAPLE_TREE
>  	tristate "Test the Maple Tree code at runtime"
>  =
