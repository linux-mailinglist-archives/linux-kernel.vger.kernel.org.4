Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD654720BC2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjFBWL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbjFBWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:11:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438051BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:11:55 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352LnJ7U021047
        for <linux-kernel@vger.kernel.org>; Fri, 2 Jun 2023 15:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=MS4aEgmVD+WYNxtXd8jAGo+l5TNp16nhcvzaUhDAc8M=;
 b=RGH8NBi3ulhzTKKhjsLH91OG9MYefdnmTu0z9XB2aOzk+NzhnLGyZVh2uApezzhwsDLK
 KtbgQI9agpxGcG7ryKNrPyhE23r6j8oL/DwWDvuRlBJbNpYgGrruaQDkH3DSD5VnqXKx
 bTVUQ0DuagyqhuJ9YKvoVqGyPSRyFjbU+kIijbDSQgHl/zc5DsY6vSNLK0qD3EghYfrF
 Kv+/9DQqE9If0XPp2I5vG5AKy2a2JV3L0Q3wWKJ5Yl2U8UND0RmjqoWYzZCw03dzJWdr
 qD3myvOLbHYNbB/WaCRKX2VWd4bk8UTpo6bZ/Z/EQwBIme0H7+27YT+il7HX6vmHcam0 GQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qykxj30kp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoRZS4M7RZbTP3FqN4lPKDQE9qjT92/xlVXdwYfL3DdR99mstyZ2INQP96+hQhWKBbIE/WvzQ1V75LJbW4khbW9kzNE3dJZG8ARyHqoayIPrc5VXOyr/r9Za5MSYAjmzaSqb63VShSYpvuRawGFWgwKk7hFLVdvmWLcM8R+7i49KaH0MlxS9m007uMibhl9zOMWsrLZPsNFbVmkDLKzBFjnHStWzOPJdq5w2dVeA2pFgw+LPcoV5NweOQN4L2rzCrmNuKiMJA5LI8e69mDSFyoKNsDRfv0/q/AlHMOk4Wg7RZOp4QpdgFf1fvuJ5L/H/HMLmfLiIDndnsaPX4HwOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS4aEgmVD+WYNxtXd8jAGo+l5TNp16nhcvzaUhDAc8M=;
 b=J53NEGRyyF7ME4F+OqQ7FtxLDzlhlWxOcObiO4u6ZHiFYxuKRxKFL5F3z/aF6Cw69a1wByBC9vdKrPKSadtt+c4uD6PDskx33EYh2N7agCpS+4Pq+7aXekm+jTOlUAQhIb/Bq1xWdwg7Rz2R0QM5ndlFO3+w4M8Xn+c/wKDX5nPUy+JNjiLD8mqtneUzDybMphVqFia05zj55/8s8k4i9gpXPmWUYCIjDb5wsTlPyse6fUwVUKAKCCwO4RkuPOoB6PCpYM6AuWt37igBPOpKno1Z+SLmfGBtauj+MlBLIgU4JO7ndgkTW6TLmEe3FxTawcAIEg7u4EUT+epU340x+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB4881.namprd15.prod.outlook.com (2603:10b6:a03:3c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 2 Jun
 2023 22:11:51 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%7]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 22:11:51 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Song Liu <songliubraving@meta.com>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Thread-Topic: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles"
 event
Thread-Index: AQHZiR9WEaR3xoFFfEGCLaxGjWAWL69h1CkAgAnH6YCADJAYAA==
Date:   Fri, 2 Jun 2023 22:11:51 +0000
Message-ID: <393545F8-AB12-47F6-9293-75B2274CF7B2@fb.com>
References: <20230518002555.1114189-1-song@kernel.org>
 <3BDFDE24-C5B6-47A0-A541-2BF833BBA832@fb.com>
 <5F882BF2-6B6A-4809-B0D5-9EF430E11C2F@fb.com>
In-Reply-To: <5F882BF2-6B6A-4809-B0D5-9EF430E11C2F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BY3PR15MB4881:EE_
x-ms-office365-filtering-correlation-id: bd48da9a-25d4-4c73-2cb3-08db63b65e20
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGVEnL+rdgzfOA1qC5RQ36F6XniEXzfuMXjRiasIQJuswEA/Yqc8MjBPbogPiXN0pcz97/7l81cFdbqkJkih7Bf0KovvVmgIMzqp3YoI9QsUl4hMVz7AZa5Y4YDVeM2SirX+gWXRXnz/iQiU/fB8KqOzt+z/20YV21qKV39ixNcSbmfNA6HXeThrneOQQA3A+YV5IwysBo8lmsIM1SdUl9oD8DNcfD7f2lgddnN95TcKRpGm8wDQM+vNSp71ZTS88vYXoQhdb0t9rcMT9qb/dQWMXWoVfoefwBXWw99NViRbYgo1CiuzIZXJqL6/bbTSB+luAo1iLfnLyYx4tlfZD9GjafX/Fx6yt5dAidtVQ4LMTPvZJWg2FURRwpVYlbY4KVb1uvt/nu85ZU0vzPPhv2XFEsvTnL4fJFs/FKqju4D1u+Va+OpnuRBjQ5Nn8jsXNkAmuvDM625AsRVa4X2ep11WQnoKknxGG9fiOtgxTcs7qkkbb2Rug97BNmyP+q2I6cqavi9KqFWBgPteOEtjSsj1anXWx7rSH4RPt2KC2aHcZ7qVt1Re18BJ/ykl9WnKlsdN6xVM4RF2zcba4ceY87mWlTMleqDfagfV9JQ8PRue4p1/DC/fNxxN1Ct9kLkN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(6862004)(8936002)(8676002)(478600001)(54906003)(41300700001)(5660300002)(316002)(6486002)(9686003)(6506007)(6512007)(186003)(53546011)(4326008)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(71200400001)(4744005)(2906002)(6200100001)(38100700002)(122000001)(38070700005)(86362001)(33656002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3G8oqlv6wHfWdkXM9xdBpS/hqU/KCLuIQC8deND9v6jYKt1mg2ken4SsKM5U?=
 =?us-ascii?Q?3sFC8ODOYC4cacgJhQMY303mMPbbRqVf0S5LZnlnouykLGj4Q+Dufon9ZE0J?=
 =?us-ascii?Q?L4cumiqFwMcxk6JIvJJMMdWK1WAggy0tk5Y4kw/vpDHuymskqfPMtLHgnrGx?=
 =?us-ascii?Q?e47Gxm3KhxHdJL4Ffcq+FwU9uVZ6sbGN7ChkLPwk6FMpOJSP8wIvmFSSknvR?=
 =?us-ascii?Q?iR5FOznHBAfxLYZYTYrL5pNlFWCgYRX8xsbwZdP4dNsk9SOMOEHqluF40/8W?=
 =?us-ascii?Q?rYt1D5Og+jn26V8CU5QZV1WCXZuG/WsYLIB1+dD956ej0LdKbiqwfomjlxeI?=
 =?us-ascii?Q?LTlkIDs2ypcKLzLKSOir4M3KTcD7fZhUwF35cbOAaQOCwQ7j8eW34fkW7wE0?=
 =?us-ascii?Q?FZtTCNX/jO97usraHR5YqeEGhXDZ8gayqpwygSS9YUMFnKyy50OodYQpc3GQ?=
 =?us-ascii?Q?IeBI4suHrDwVdh7hqMp5OWILUv03HCu4YLOXzJIXqOM2isaOXD16Z0bg1LZP?=
 =?us-ascii?Q?Ik4EBKWVtT/M+bUZLgM8O3W/PoreR60MVkAPqC5QJZWNrah7kTqvIW6rQISF?=
 =?us-ascii?Q?MjJ2RweiclZ+E5eNS0JlziztAqUlP7l9eEtqYO24R/b6wfNGVmfkmQ47FAvV?=
 =?us-ascii?Q?1DtKnAFhHopt9xWfg5OJWT/TvExnvuzRu09VGUQRvHeuXhS9JbFSJg4b+20D?=
 =?us-ascii?Q?xwr4tBdY6tBG7clXcQ0aGgD4XYVM+rb4jTaxFikjQJPviupeoWUe1mrYJ5YT?=
 =?us-ascii?Q?WP/kmnZje3ijLaMn8bAwXuzgz0wGR7LMGrMWXZAhZZ9eYvUy8kYwb9OfUqk+?=
 =?us-ascii?Q?yQ/lfCt0VWRX9PN3uhti3u2Ra3h0Ff45TOClKJYVGdUcV4LZU13fSeD1XXdg?=
 =?us-ascii?Q?UFPcpe2ZAKZ8Maypn2GSzvYG3TSw1Bak/n13lGv20c+ybxJzQ7O8W4XII26R?=
 =?us-ascii?Q?NytqBhiOGyPr1f6jmTAhcRQMc4d1Pp7xRMYSk87zekr10f8kZmb7sM2IxddK?=
 =?us-ascii?Q?dxe2ZOlM5PelEK+YJb8y1sYCiA3Q4Bjaw6/yJQJu731C0aMXs74l0htsK0Tv?=
 =?us-ascii?Q?RYicO2bjMJwCMAawcH4TCEKochYS2epMdEPzQs8ep1Cz7Gx+ERVRNjggn3e2?=
 =?us-ascii?Q?OoVnjkwvl5Op/0K49ZyhjdY3gZmXp5ffPLHQUdZ1VeBzxLY8ARDm4NyWibOJ?=
 =?us-ascii?Q?JmXm13aRgeIAyVQhJskhzfxVI9QrlQe28p5d/tOcM8Veqf8snbT45L3dx948?=
 =?us-ascii?Q?8p6DkiBhchASalH6/kmFTbN+ZYYJ2t44aZrah+nDJ9UcTP5e2D9GvcArwcsX?=
 =?us-ascii?Q?sw5g1chPJrLS8ih2vWLWKq5ActsSaqVZom7KgF3CD+PkiKKOd8v/b5MhDcSj?=
 =?us-ascii?Q?+IJuP8LRYXDUE3AeS8rQf1KmMlViyTmmFACjgorSXqumJLtYDNB6EEK+x9im?=
 =?us-ascii?Q?9LtTUlNXsyMu4q9ewblJU8d1GBQ4YLBYhUMM4eTOe0f57QFkZOH9sDUsueWJ?=
 =?us-ascii?Q?LcJ5NVlr7gyNH0X0Vg6ySXSrLvkaO75du6uKrxNmlMi7B2uDc6xfurDi9SMB?=
 =?us-ascii?Q?AYcjJumlb7dfZoUMdUY2HhZ08NybmfRD5hLmpMGySRHCrXC+4guMRwMf/be2?=
 =?us-ascii?Q?XNGlsUkIhi7KGvqZglLo3+e38DDTGOxJmlv2eQT2uTvl?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE841E3720E3454495FF53AE31BF894C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd48da9a-25d4-4c73-2cb3-08db63b65e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 22:11:51.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7Ef2LlwCk86dkviLKjPYbUhzdfi1FciqVQ3xMOwpDBfgEnP+QvD7qoSABdvFMBdqEs1sS0wj0hzLyLiIPZuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4881
X-Proofpoint-GUID: P3vVF4kmcPF-beE4W8hb6jK4AgKsvtqQ
X-Proofpoint-ORIG-GUID: P3vVF4kmcPF-beE4W8hb6jK4AgKsvtqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Peter, 

Friendly ping... Any comment on this one? 

Thanks,
Song

> On May 25, 2023, at 3:20 PM, Song Liu <songliubraving@meta.com> wrote:
> 
> Hi Andrew and Peter,
> 
> 
>> On May 19, 2023, at 9:59 AM, Song Liu <songliubraving@meta.com> wrote:
>> 
>> Hi Andrew and Peter, 
>> 
>> Does this version look good do you?
>> 
>> Thanks,
>> Song
>> 
>>> On May 17, 2023, at 5:25 PM, Song Liu <song@kernel.org> wrote:
>>> 
>>> NMI watchdog permanently consumes one hardware counters per CPU on the
>>> system. For systems that use many hardware counters, this causes more
>>> aggressive time multiplexing of perf events.
>>> 
>>> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
>>> used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
>>> watchdog to use "ref-cycles" event instead of "cycles".
>>> 
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Song Liu <song@kernel.org>
> 
> Could you please share your comments on this patch?
> 
> Thanks,
> Song


