Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C36B19E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCIDSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCIDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:18:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10601421C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 19:18:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328N4Uae015853;
        Thu, 9 Mar 2023 03:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TDO8E/GAeyqj556ZiSLEMaJKe8ZCz3EMqA3W4gLzc0c=;
 b=ITzbNC5d333br22vjmwxUk8AsIiJT5v3E7XSCaOpqca4CSrmw+97GsVL/itVGrTDn4sM
 mbcxWaIZ33teazFzengjjMezLefAy6tHtXBSIJCH6nL4JyCCcxu0+QGzh4QGx+w02tXz
 s/g4mRDHqJcA8f1RSIrlORFd4HrWpRf96nFqCDJgysNRHHRzgioIaqdiK14Fu8gtZgMU
 RKCKcNq6omh4ckKD51GnGW0nkvDbNPNhdixX7/sQbve5uMkVw9N/RlqGjj3GWOyqkkeg
 XrUG2SN2pBM1PTh7lTFOSS2jAX3ZCXhaWmleCTV47ZmzF0pazDOk3/cjjErs/6GkLWId Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn960u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 03:17:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3292UMg3021709;
        Thu, 9 Mar 2023 03:17:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr9p3ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 03:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQy+b8ueJOPiSrC3lRFQTdvntSAnWNNlN5bG4N1655zQvuYmgLo69Ve5OiOUWqpVV5FWCrxqP0X02x7TytxCNvvQUnfsRvrMx6cQjK3+oGP3d62nCAqLS3lfUCjl25I230siKQqac6tbRkTjO/TI7wnaXmurGqEQjDgM85ZU+yjN8+u+ZZv5C5MSwUxrqP6XwNh9IwWLc3h+DwBaaYH4szgfjHmSCe78bOLiZ5jBiu2jhHVn8ltLovNd6Ge8oYDLVSqXOuImnetwYXGxvUI67zAqSyAD48utgCzqo13z7ZNC7PWm1fPF2JiNdIyNjTchhfSsOxVx7LM+50El5ulaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDO8E/GAeyqj556ZiSLEMaJKe8ZCz3EMqA3W4gLzc0c=;
 b=WlZc9IxH4Yr7SFTESt3Nu8vrbWBA6jnzESsfCXfMHMhDJC6kdk84ys9jO4q6JDUgmXRsrL3dTujSEdwL7Fa59uHYyKMhY6hPPvlP+9YM/POuPeuY9tTk11vqv9WA5zCc+tFiog02HCHlqxqUZHS71zOaZoIJjZR+RlQop0K78ZG0NK4dIgkmekuAsG6KBcyBV0wXQ8hE8gmMbifxZ2NpwyAbyFZgi7Gmd4Sc+lT25c4eP5yWgZEPBu0a7XZs2yJxoI0Yk+Vw4iIyCqCJ+PCjGwrFI40xeJWq2ez1VpTLgAzlmQdv2zIIzkagmLNMh6zUOKlTeiN5bQX7fp00l5wmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDO8E/GAeyqj556ZiSLEMaJKe8ZCz3EMqA3W4gLzc0c=;
 b=aYaznbZSYjk8moX2BkI9jTb/ab4Ml4o9wh/XqGJSxGLqyeHxblkl2CMVdXR614Hu4NYgh5cR+G74tIZGd7EKgRt+/bKsqRa1JN7vaPK+cjxwCzWAsKwjDd2O/Wt1rdDP+F9pmmWn6HzytR8PUulGkRazh4PpJD2fnONXcnEnDdw=
Received: from IA0PR10MB6844.namprd10.prod.outlook.com (2603:10b6:208:434::7)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 03:17:50 +0000
Received: from IA0PR10MB6844.namprd10.prod.outlook.com
 ([fe80::bd0f:b240:936b:152e]) by IA0PR10MB6844.namprd10.prod.outlook.com
 ([fe80::bd0f:b240:936b:152e%5]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 03:17:50 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Thread-Topic: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Thread-Index: AQHYrQkykNfcpDPFyEGaogq/ZprawK2v0rmAgACK9ICA5zO9gIBbf/eA
Date:   Thu, 9 Mar 2023 03:17:50 +0000
Message-ID: <1EB52D2D-C1E2-47A4-AF30-10068B6F4EC9@oracle.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
 <YvonlUOgMbla6dSh@worktop.programming.kicks-ass.net>
 <aac4a43d-4999-1da5-a617-b512ae0b3982@oracle.com>
 <82d4e87d-edc5-19e9-bfa8-70029610457e@oracle.com>
In-Reply-To: <82d4e87d-edc5-19e9-bfa8-70029610457e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR10MB6844:EE_|CO1PR10MB4545:EE_
x-ms-office365-filtering-correlation-id: 97f1ee0f-07f8-422f-0628-08db204cdd87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5kT9XlKG616QtOwucM1uiEp3tFRuEPLFgEU1z49LB9kmhf3sA4LMlN2ReGJKqmWat+dXQ1oLNwxIu85kB/OabKveMsOq5gy0Y0boM0Yd+TvH2TxJPK+uKMFRtK0xyO7X9ph/Y1zbBOZNoohlzXR3GJbZ2TWn+fRF/1p8g2TIDiRqRg2pbPS+LCGZb8CPtzN2FeQhcxOW9cTe8hAf74npntg/4sDtGJoLpHLmNzpiyLjsbjsEn8cvdQRHQ9UJJk7+l0fC3wXhq+83g9HvHNCQCrvsGUJQ1kkGXwxMMgedwJRz+l8jprJ1l30rxvqbQr4F5i2dKp+bfXkGxxVTz0LeGgaHHUvsz/PunkrmmUY1qAvUmtJ/G/jxPiEoClc8jCGl9CmwHmfwmsWJsO8fI4XXacI3oPOO59hK5gtfI0GM3cM2yzajGMzqtid135NzT3nga/wKSd0ORhVncrM6jBjQIw0TIqQg2jVMA6VUFeujobhs9gZl4sjh3RAWv4AxokBmt3GJ77IsoScDGk5skgAyb3FNhPytTHSJhqiV0fBnZ8Bo4PKDrEpgPjpeBRgmw76BKl9tIXaaCKf88P/IDZ7Qh4QnYqFcQosyK5CjEgAoW8pWhwiPlYjdTpPrMug/71rM2+lF7+hnLMoGbzhKxs19jJtocj/MaTmoRNEqKGJUlerBpeMPS2DVlB7YYnq4DktHFtqu3MwDDL/IlRh+CLDgEdZ1+Qu4ZsyKp/tz11wR6Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB6844.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(38070700005)(44832011)(2906002)(8676002)(5660300002)(8936002)(36756003)(41300700001)(66556008)(66946007)(76116006)(64756008)(4326008)(33656002)(66446008)(66476007)(6916009)(316002)(91956017)(86362001)(54906003)(71200400001)(478600001)(6486002)(38100700002)(122000001)(107886003)(6506007)(53546011)(6512007)(186003)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cVYJZVfs8pF4FZMM7ksypRPP/7HEEgKzQdYC4Hb/dZQqZwSKfjOegB7KueIH?=
 =?us-ascii?Q?kqTP5hU/psZ0WrYHFOqQHx6G62CkPJq3CE/pj2aNcmYShih5JFd25G+MZMCy?=
 =?us-ascii?Q?N5zX0f88D9XV+z3NcY6wRlDfEyRND8kuOjiUeCuQJRb+/UIqzl3pf/998bxU?=
 =?us-ascii?Q?pKf6pvk9zwHv0l8Gy4FrDCpsTuzbzMBqxziz1VAz+Idc7YbLHXMZlgqkj6r+?=
 =?us-ascii?Q?gBCfpPXdCuTaVyyd9FJOLPacGphlH+BQdpd1mHYSl0iRTFbUG7IWjZ8REYFW?=
 =?us-ascii?Q?OEgcTEFq1iI3kFYtTt8nJ7gKiAZCRSFl37zdvG7WUEzvi7mM/lzgVXbSOc/r?=
 =?us-ascii?Q?gLX6O5Vz67kJSbho0rCIEjr+wNl8UXOVmPtFc3LJJYjz/dSXTLZQ1ZNh2V/B?=
 =?us-ascii?Q?wobs/Mvq6IjGNtsYZFtABgLzukYxeGt3lnh26gatqI+buNsxYQBTbv8JXHRT?=
 =?us-ascii?Q?nE1HuX0ZDMCKy7H3p5KjBYZ1QK7Yp4cOqUzy83tjXharVs8NzFvkf8ohvmue?=
 =?us-ascii?Q?ZYFy/lRwwrzF9vE/ee0NLzZH+1cXGVgyErdmL6Ww0wjo1AJ2QZp3NDqG9NnH?=
 =?us-ascii?Q?0MsT9UW7eB6tiUu9ASs85eZvw5tpNT63bgYTYMZps4UZnx8eauia1notnGOV?=
 =?us-ascii?Q?fTw0ukfzCda8oS1jkXNaGhEya5R3CJJGReVxwoFhuc8yUrppP+4Ar/Kf0fdP?=
 =?us-ascii?Q?zf4BRzmDhxb2in5H8D4IoBec5TEfJimbOQO3vbP1PVFdxFT1/cYm8rGHJM5w?=
 =?us-ascii?Q?KLIZ5vs8K3dOcgi6dSnBSYNC1tl8xI1GQOfcFKAtl5a+OozmHwe/nsxJRUMq?=
 =?us-ascii?Q?xCCnx8tSWFCWEKdkllEmvqyG0zc8eWK2RTnciwL525HgZ194BE0nqVuaXV5H?=
 =?us-ascii?Q?stSNvsyx3wroX/x/e6PyRhQ9/uN4oTxGw071wt3mfGH7lc1b2pyLa5xPn6Hl?=
 =?us-ascii?Q?3FS6BgEsP4LKtCBbaiTrGefilB0jj/tHqbZyPP4V2f6mnuhjeAtm+uM1Y+Gy?=
 =?us-ascii?Q?7BMrkAqS24bUCPWkHTl6ajklMzlqgeybucyd6K9xrCl2EzwW9Yr9AIuXQylG?=
 =?us-ascii?Q?XxHTUl7s//KLbwxGPBqloc8ZI8L3S3wiLi7c35uTzVAGyYfLrwl/L44g+NCE?=
 =?us-ascii?Q?mPQ9xdqslB2CJGbKozV6v9BS3rQb42HLJM8FNSeBdCJS+vZFHthC4bZnu475?=
 =?us-ascii?Q?POK++ggdC8MNgiDZK+UBKWzWRXSWzwZkaCGhn0bKDn0nNTyDFmbWDNY4vPeb?=
 =?us-ascii?Q?wIatemWz5VdcvB8u5c8qlUEaJz46bH1Madh6dW5MC8NO4E3VkpqMNdQQUMcK?=
 =?us-ascii?Q?FmaRTNzlfpz22IWtfFYV3CEv3WcyIOiw/ynWXf4NdejK3BjO7o0ohtWkrn1r?=
 =?us-ascii?Q?cNYPqeofPmK0Do5LsVnxuDs0kikINi/qrgpY6JDYJ0kwluc08VWc1KX1tQZT?=
 =?us-ascii?Q?ZH5OgjQWeBKsJNUWl5f30Cke5iGTCeNqh7KWrd2FG63ZW9vSDiZ5QSLc6l2d?=
 =?us-ascii?Q?xzPqVuDQa2fYDRfaC2taYmVfgR6xBIQ71Xtn1lOa75gflQgcRYzHT3ZClj+c?=
 =?us-ascii?Q?AkcWsTGT6bdT9JH5skQ+fMOhhfDx1HJuJn1nD48/Ue6V2uVqVBy4JwPcBsaY?=
 =?us-ascii?Q?l5iR4FuIb6OMB3b0Ekdxv/maqF9k7Rx6fFzCgecrhDZFZ9YA9v1Pf2Ni1l68?=
 =?us-ascii?Q?YUREeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA011C799B95B547B679DD1110C3830B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YDBt3CQa2JR2j38WFNE5iWCOMSSqFqAHdDVNUNEX6XSIkOUqK7qed2doDOktrIEp3kv43ZUhfyXNO/c2PRrKXWmBxy2SimTJebZoTgCyAVl4ZaOTZgEtCvN4UmJdHW6tpKFqCCc80zd+vSIieUuTHB2lrrX0x9s02deUc0bUXgxYiFssvYGsni25cXGmk4TiwyN2VjLP8u+4AtBJYLjBwjU/xy0b6efklSdFJTq8j1vfEoZgZhRpVYvqJVesFgVlgBqkRMZFwULWnARUFye9p+rjiLB04k2nGXmnIlB8yjaA0k2vOO+CpwRviWVu+jzxMnXzxplMklH7OR3qEV6cUUbHjfQSVd9xuoKNWb3fbUa9UnnPZP2F0evCWj85DZYmIz3trW3dnwdJ23txkzMQICXiDrrLNpbrELcTYCZjujbd5+tQgqAqLnON7C/RzRQFZsKvnrWniTLRrd9ThxwAJIrGfALF6cM+47dobP+bR+cKNAKABbPjP7tucOJGGo+bhGwa9YhtpEDnkiwodP6ON2L76oWtAyA+7DUOLQJ52dVGbh4uxRukNsbrrAWMZvoZSmxlZCZ0z3agsm3kGW5gzzTgdyMkNPXg7sGNRTLHshl78rNIRGep9/jEknrCc6poTaxWEPpXgFN5YE6kkWwjHhNW5izdvXrd3NtArNk9MwGD78vcLgDG7mK7De8DvKs2JKh6e/2o6BBQ+yaxulId+V7TnXO3eIrivmiOE9VeqFnywl07LGU7xPGJm1fLvsENPvH+Xwk7XF1IyU1HW7hT+PMcXlnaZciGdgAqhcpf/2N/Gt5lCGuxkVRUJ7RG2qUH1LdFBe7VADfDU536M0cy8O9JW/zA1OPTTw98c+xd54yOVDDoIXACKARMA89iQd5kqiQ7AnBtiszXOV6tQwxLnA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB6844.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f1ee0f-07f8-422f-0628-08db204cdd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 03:17:50.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gh3VCyhH53lwVVfngaXjZaKnDg6FAk4O8S+vXtZ4kp+5zFPSOcx20rVpUnzb+aAIZMzCQVc8TtbjdTKOC3483g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090025
X-Proofpoint-GUID: OTf7a2husA-vLOY4uXZdGxgY8-tdnD_g
X-Proofpoint-ORIG-GUID: OTf7a2husA-vLOY4uXZdGxgY8-tdnD_g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 9, 2023, at 2:00 PM, Libo Chen <libo.chen@oracle.com> wrote:
>=20
> Hi Peter,
>=20
> A gentle ping~ Vincent has signed it off. Let me know what else I should =
do for this patch.
>=20
> Libo
>=20
> On 8/15/22 12:19 PM, Libo Chen wrote:
>>=20
>>=20
>> On 8/15/22 04:01, Peter Zijlstra wrote:
>>> On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
>>>> There are scenarios where non-affine wakeups are incorrectly counted a=
s
>>>> affine wakeups by schedstats.
>>>>=20
>>>> When wake_affine_idle() returns prev_cpu which doesn't equal to
>>>> nr_cpumask_bits, it will slip through the check: target =3D=3D nr_cpum=
ask_bits
>>>> in wake_affine() and be counted as if target =3D=3D this_cpu in scheds=
tats.
>>>>=20
>>>> Replace target =3D=3D nr_cpumask_bits with target !=3D this_cpu to mak=
e sure
>>>> affine wakeups are accurately tallied.
>>>>=20
>>>> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is id=
le)
>>>> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>>> ---
>>>>   kernel/sched/fair.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index da388657d5ac..b179da4f8105 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, =
struct task_struct *p,
>>>>           target =3D wake_affine_weight(sd, p, this_cpu, prev_cpu, syn=
c);
>>>>         schedstat_inc(p->stats.nr_wakeups_affine_attempts);
>>>> -    if (target =3D=3D nr_cpumask_bits)
>>>> +    if (target !=3D this_cpu)
>>>>           return prev_cpu;
>>>>         schedstat_inc(sd->ttwu_move_affine);
>>> This not only changes the accounting but also the placement, no?
>> No, it should only change the accounting. wake_affine() still returns pr=
ev_cpu if target equals to prev_cpu or nr_cpumask_bits, the same behavior a=
s before.
>>=20

Hi Peter,

A second ping in case you missed the first one, what else should I do to ge=
t this fix in?


Libo=20

>>=20
>> Libo
>=20

