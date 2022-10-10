Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9C5FA3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJJTEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJJTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:04:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A340CD5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:37 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AIpKrI009705
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=hRTIq5UtDVOXGJRAuHpitTlCAoCOiRsW2fukf5LVnv0=;
 b=qo+4EtdHzF89OOAyiEMv5EcxqCrgTkHhJABsoFlph847GJrnaeGypOhSyELr2oTBPhww
 YnMMqjzdWr9YPnP9w9J7VO4NTVprivP2SHV2CZPI2E5zAe6HLQujoWNhMF4slJsXpuDQ
 tl7jcPkbR3nXU8fhy+feZmBMtYJ3ywTZIWc= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k4qjx0utx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W28VwpaaXwYXe89PpoG2jyWj+aTg6x2SeW5y29oJ8Y9vK6CPCDyXvD8cn+/w/rDxqe5DqIA9ptgfzodz8vCQmT/tHaGkkaW9x9G/HIYwQsmBH6RkHHPkpmibk3N+O0lyiv+Z8/Ir7hv4kkupY4KQBVP4pJJyi4OMLB0r/y+ebf4PLZ3uOFPZ216rXWoS5SrQ05OognTcIL8D/30v3xhxgpWvp5axrYPQJqJrD91QpU0ILMSkCzLcYQnz+d+SmeDP+6JFQ3f5+tIQV/Ob7kH7nHrYBFF9ZwB7BCPIgtFdfa2b67Jdjlkk9/41JmU+YWbX79aYys/SdEd/EUE3F6xQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRTIq5UtDVOXGJRAuHpitTlCAoCOiRsW2fukf5LVnv0=;
 b=TJf9JA2O8S1RauDODGplq+mGEzzUDLjYhENRM3BUh6U77OO3x+VgXh4xhZjI/FYn+7pV5RMEqbJUfXXLERdgytHc41AsjKZ++EuRyGv2IEYSF8tRO/vfHSwyST8PJMFJiVNJsm16zF5xxn5Ukazu1V/oeJAuuBD5f/Gamga6TcC25jGU8zmAs1ngV735g4HIEgEyOaOpL0ncHvh06QAnatXQ1lCZE9SlCbIxzT3HyNnBno4MPGxXMuyq+xcJRCmbWBhd497UxyMCCcpxlQyAT51erkod4iuLBlTf9OsEyaBg1/6abR7RWiczg6fj4U6C+2uWBpy/qqSbsUBvJlesNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN6PR15MB2320.namprd15.prod.outlook.com (2603:10b6:805:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 19:04:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 19:04:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [RFC v2 1/4] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Topic: [RFC v2 1/4] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Index: AQHY2qb++NlPiWGm1kODRYKDJiQHsK4H8qyAgAAOQwA=
Date:   Mon, 10 Oct 2022 19:04:31 +0000
Message-ID: <F038FF61-C131-4FA0-8F19-647A3486A3F9@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221007234315.2877365-2-song@kernel.org>
 <53f0f3feebceead8a40185a5fe59ab15f8bcdcb6.camel@intel.com>
In-Reply-To: <53f0f3feebceead8a40185a5fe59ab15f8bcdcb6.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN6PR15MB2320:EE_
x-ms-office365-filtering-correlation-id: 5c068553-f487-44b6-6d69-08daaaf24362
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbL0AagDbVIIENzZa1cAKA2OiERlDviWyt8zy55EpfAozbT0O+IWHDBvRdepMW7C/sAfAJt/afIUz4rttOwFDdnR4CdfTL6BexmROSAOyWwcNXM6s/1eYsYmQL3EuSjSNZgInxjgWij1furPLkfdhkFipAIBvzinMVPDSQcHhuPN4o4gXLETsLiD+l5YC36zZZS9IlFqpSlsAdHiAG3ZClzj/bqmwzr4KIC0msJiYkOwyKr9QmoMCxC9lcf5QRFGhbbo9g36O2Cz21wr9zqxzzpINVWj09u7Zvd+9IEOkL3UA7rftxJrQqyyvQpvtQBY7QpnZqWRhw9wJrCJ5fZQXlSNRcqHdd6rRsYdCDWJQSwNFFQWTryUqdnR88H1XUIPjak0mSh1iaXZn5Cnyh8I8AbRxszNaJ7VlTRKYSYshiDKb/2KXsasxrFJ/47LqzhV07BtUaiyNaJPqgeAPdcAh5BnCSRt/izBsdP6+yeupPPkRDRXXXdctRH/gGMOuwOoDcdHuGadWVbyxhJ/KsoukMWomELcivYaHZ+LMy1L7akMXNB9fkMp9JyTG6W0oa2vbkKQ/ZkX2yJ51ndKBKlOrLOPKUK6LCzRId6Iqeqrdfno+qdyQv5KbI2CfoOWkDg6R8gVakKSQbQouyQg86xWn9SZK8Tup6A9cRl8cWXKhEuEfsbyDZBvbrdP9dwBpMOclApJAPs+Uwd9qohoW/laCCnq7axp6l+fQvfC/0TZBAuVGsJMaDnoOHPW6VDKzt/EgDxznvRWyInc0qrfmG8pFFt6EQWsNQ6Dn8M1NDkXJl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(66476007)(6916009)(36756003)(33656002)(86362001)(558084003)(54906003)(2616005)(122000001)(5660300002)(38100700002)(38070700005)(7416002)(186003)(76116006)(478600001)(6512007)(71200400001)(8676002)(66446008)(91956017)(4326008)(66556008)(316002)(53546011)(6486002)(8936002)(6506007)(41300700001)(2906002)(64756008)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DTSxTraz9XUgTW6+7v2/5rZR+4b+LP573lMqoinLnEYpr9KowP3uoubf+jt4?=
 =?us-ascii?Q?sfPyogJ8o2WWp39PsR8W9vssxuX0QqhbatIBEIPZ2AscZSc12m3U51szwD9c?=
 =?us-ascii?Q?Sf+d3NrqtlgjO+KM43hSnfcnrwIYVqIodoHjrv2mgy+cqVohzgmYkbBpjSRI?=
 =?us-ascii?Q?VBCBBcdRPdshkIkAGYTPKxbGGZK/iEBm1ug9Ccwog/xrDedVYrFPg+0MYCgy?=
 =?us-ascii?Q?BYDpKZQZR5UDhbN58L03IMktCZQmmHB3tOvXCl3aZicUa7VC1YnCdEBuEQ8s?=
 =?us-ascii?Q?HxEhwEjsJ+Ok40gT6JCcZ8hPyh1H6fIHj+Z/BA7eER4A2+GS/pZW4JM7/Lwr?=
 =?us-ascii?Q?hdGXHH0AJ27MVa3xE1J5lS/PXeM4aaxIPVrTGg+jvAXq5i+8i1xCnaQqslGY?=
 =?us-ascii?Q?Ly2ijrp06Uc/sR5Nfwhe/SmQNtJBcssb+ewJsiW7nfGpMYywhmzcnYgUmaz5?=
 =?us-ascii?Q?zICjQK1eg3bZcgYHpfdvEXTMJ6I6bdEsjChaJqzYGD7lWe+vU/GDZQKqiO8E?=
 =?us-ascii?Q?CGVrtM5xf54wJTMmsGNq7c56qOvLBRKrf2wIdXTqcYNqgisUNTkYH9MsQMYy?=
 =?us-ascii?Q?Qn3w4ExLIh9VPpfqU5c3+lwBmIiAxTVcTfsMlgvrLlKsH2iyg8aXNMVrgh4g?=
 =?us-ascii?Q?5+NeB3UKcT1kAjQZERhCSLjsXAr2SKOgmJQBbz1eeC+LvApe22w2p+qbu20D?=
 =?us-ascii?Q?aIwhfUV9MX5C2hBM5zYfVVvYiLeAoxrZKKZN3TQ7XFSeql9wBQlL0t/aKaJz?=
 =?us-ascii?Q?H9XuJueVi0XIOD/O/ogAVDzMTMiHvHBn4tvH/AoA3RXILWy/Bd+w3Z2ZJ0Sg?=
 =?us-ascii?Q?WIcE/OrWddhXrjkV44XvHBdQLmWaJ9MZubqyZYU+GgP4E/VSz9qZgM84fEfm?=
 =?us-ascii?Q?+nlJ8WiZC+TCx8UYA+apFYNiRHkLtXuECkE+q9YiYWM4EyLiZpg8dWTodx/N?=
 =?us-ascii?Q?mgEk9k+wlMdr9IsuiH8/1uQtoDaRl0apxeth8R1+Rghqgdt/jXEumKmXn7KA?=
 =?us-ascii?Q?uF6Y+KMkgcYg/bKOHxZfcWeTxFgylcOGZ/hgHlLh1pS5o4vpndTKbx6/rqVn?=
 =?us-ascii?Q?P0DjOtB5f48a/Os9eRLURbCwyaPpD3wPwgjLtQPQSqbovq9l/ZmePSdHo8D1?=
 =?us-ascii?Q?ZcWO2h2U4cytxxtKU0dG7lpkdbSnFwvPd8J+OQ928HOwuWTcp1gYD03nfz2q?=
 =?us-ascii?Q?zNoKZNpCpAdE2HB68QHWZ/xymp3SFRtcQgKCReZWanC9iXbBMfsBfwxxn4Og?=
 =?us-ascii?Q?jL6x+WE0VRli1MDNuryYcciYRdjSJKviZdX/g/Gejo08K6Rv4Pdmvs8SKphm?=
 =?us-ascii?Q?dl3y9VfqzIGkNX8VLQSJN4o0Y7nOJDbHgQ231gbb+s3NUatBSBpiKbwMwotL?=
 =?us-ascii?Q?sA425M99Mbp/ZuWMgjLMVG0PFpKsCHMbpP3SdIUcYYd80QRmxvatZuLY5cch?=
 =?us-ascii?Q?4TgTgo3dNwN79ajYfztA2yRZZZQ+G81ZlXgto+OFSy3ZWVj2XswADec2IvQ9?=
 =?us-ascii?Q?t/n5Ix5j1FW7mhRVT3fn1kSmWG8nm0hnGwB8AoGMSU7gK0KE1yKWI6m8WAVz?=
 =?us-ascii?Q?KndO9VqdDSuTnW9npyk1dRryxKAmfPDfbE3cmRrz5s/S9FjHqYy1pxf3GO2d?=
 =?us-ascii?Q?xRj8UhhN+staI6X0IT8yN9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <705C094617A8384DBBA9835A89194970@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c068553-f487-44b6-6d69-08daaaf24362
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 19:04:31.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mAJCD9XEaBIG9J+HV9fRJR8yebcL0ZYK6rhXtvY/c9jPzZnqJmeC86WdviMvBCk5ze+uNw7zaKpXx34f7rXRPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2320
X-Proofpoint-GUID: S5WXQpfG0n4KunV1H-kNy4AcwVR_bC1Z
X-Proofpoint-ORIG-GUID: S5WXQpfG0n4KunV1H-kNy4AcwVR_bC1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 10, 2022, at 11:13 AM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> How does this work with kasan?

With KASAN enabled, BPF works fine. But module load does hit some issues. 

I guess we are missing some kasan_*() calls?

Thanks,
Song

