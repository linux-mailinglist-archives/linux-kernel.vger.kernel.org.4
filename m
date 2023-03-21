Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A706C2F87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCUKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCUKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:50:53 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0E6A51
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1679395851; i=@lenovo.com;
        bh=M4tU85482y++YUg4cy0QV706DZm3yF85d6vyKJX7oXY=;
        h=From:To:CC:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=X6dVXY3ywEteE81nxUhS4+O72Vc97nX2Xuo+8XX3N+dg1hFx+FsA1ywMOsbnmwGU2
         QmAWDI5UlKRrPKUWXsH0tO8lJpQUvacU+Gdu2MkOsu/1LWyLp2LT+RBJL0zLMSuI6a
         WxyA2hNn+5/CIRtKLqK9+DFKJLHxWvO4nSGF2wvfpKMuAaS2Nbfphkc4hTzSn4dANq
         kLpu9LxetJUcFWXs4ktohRMh/sOVanbswIyIpZbTlEB2CxQDHH7J9yj36HQHJkkrwl
         SyMUvx02vnDeeNY8xOzpklOAIVJFrUcApu/dmBgnysFhCqf8qnXKYWhirqVr43g8Nz
         6HkkQE7JEOrgA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMJsWRWlGSWpSXmKPExsWSoZ+nq8vZI5l
  isPKjtsX/PcfYLD50rmG0WLn6KJPFpEPXGC0u75rDZjF/2VN2i3Wv37M4sHtMbH7H7rGg5zyz
  x/l7G1k8Nq3qZPPYvKTeY/fNBjaPz5vkAtijWDPzkvIrElgzzi7Zy1SwUqbi66UnbA2MryS6G
  Lk4GAWWMkts3n6BBcJZxCpxovMpE4SzgVGi+9dnRhBHSGAek8THr+tYIZz7jBIdq2ewdTFycr
  AJqEssmnWaCcQWEehllNj5rxCkiFlgK6PEyQsTmUESwgIREqsfzmWEKIqVWDClC6pBT+Lezgt
  ANRwcLAKqElMXuoKEeYFKDt5tZgWxGQVkJaY9ug9WziwgLjF32iywuISAgMSSPeeZIWxRiZeP
  /0HVl0jcermeDSIuK3FpfjcjhG0vcfRxKzuE7SvxbO1DqDlyEqt6H7JA2PIS0xa9h6qRkXhwY
  zsbyC8SAn9YJZbtf8QK4RxjkXhzaTpUt4HEvG9HoLbNE5B4+ogP4lIdiQW7P7FB2NoSyxa+Zo
  b4TFDi5MwnUNukJSbMX8UygVFzFpLnZiFpn4WkfRaS9gWMLKsYzYpTi8pSi3SNDPSSijLTM0p
  yEzNz9BKrdBP1Sot1y1OLS3SN9BLLi/VSi4v1iitzk3NS9PJSSzYxAlNaSlHChB2MXX1/9Q4x
  SnIwKYny/jKRTBHiS8pPqcxILM6ILyrNSS0+xCjDwaEkwbupHSgnWJSanlqRlpkDTK8waQkOH
  iUR3kUVQGne4oLE3OLMdIjUKUZjjivb9u5l5rh65cpeZiGWvPy8VClx3sddQKUCIKUZpXlwg2
  Bp/xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4dHUBTeDLzSuD2vQI6hQnolLgZEiCnlCQ
  ipKQamC4f8RNX2qDWPOVKb1XPF9cyg1MRHlnHXFdYhvZqPnm34fubFGa+a4yCt0617rsss3Sy
  0Wt/p7UevVb5Nb/2zbx+/tSVqE3XY106vrqf3LXx3u2it0EF6nmpFwVYN+6+Gex/bhZjlpsHm
  2fqrY0vOH//l7mR6B1UOil1Wo/9lvgw5qYDchcf6BWc3ZO1KXa78d+eC9PUixVaz7Kss9nzIv
  hjdeW6tWYGkTpMcr6W814qGhrwi6iF9RuGqXSlnXsRtqqiku9D3Oyl2VNWqTl47i3yXNu2+FX
  0rGfVmvw/2icpTQ93fsLdm7nr+oKa25sbbXwTmd79SjwRYrlCLUBEcd1dwXrrvc+VPi46fcpS
  XImlOCPRUIu5qDgRAGfp5v52BAAA
X-Env-Sender: yinlei2@lenovo.com
X-Msg-Ref: server-2.tower-636.messagelabs.com!1679395848!307782!1
X-Originating-IP: [104.47.110.45]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18693 invoked from network); 21 Mar 2023 10:50:49 -0000
Received: from mail-tyzapc01lp2045.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.45)
  by server-2.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Mar 2023 10:50:49 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOrzZ01AEPTP7gHDrqO4t7ILc7YP9V504s40nGCSbjjxyL9D1L9TZ9GnP5E6ZMJpQioulpUc5rDosv3eRrUIkS1tpMS9y05bDpt/qm+9ojpGhrO+IVtl7xQdCT043FORkbz46X1EyvNoMgQFLlQP6TuqxlEwywm/HIjshSQJoz2rZuRHblTUlJnkpInfgUfJaWT2Uz4swxFaz1LN11k4LWduFuXN2ZagQ/nNnwGWo9830BxiXbnks3hZAb80kDEtuW43mjqwdCHwDFSXewnK7Gqs+NFB2MZpq3ZJYaiUqNGDxJARJv+BfLNwLodkkIAQbsBUCa22kO9G0wEx4St2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4tU85482y++YUg4cy0QV706DZm3yF85d6vyKJX7oXY=;
 b=XOsYhVzoP7yfIOFVcD9wZXAT55nv/1zwFcNpSdcX3CV/vrtJlxRIF5rP1KzMMiCOuoQ6nBhbp8C10grtxnDBfqWxMjKHR9UfuTWB9EZeOVflZhiq6iTb6SXdDNf9+AJgqRWSBUW4qm4oTNnCinxv/tCXEKfH0RQ1UApCdKQgpUfwM0rCS3P+BlChWq90nx6jZpX2FuQsTKZCEduni6lNVeSKpmjuhPGw+in2M5iWsR0ddzFOC9Y7k07Ik7DKqGBD4twf9aZ6KeugscSTJrq6n05MwkmfNe8YOqyGseR+LefUdJ3GIjpM9qA74G0hvLWcRsQBH7oWajceT0x+850rXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com (2603:1096:300:84::21)
 by SI2PR03MB6110.apcprd03.prod.outlook.com (2603:1096:4:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 10:50:47 +0000
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::6f60:2bd9:5f36:c4f9]) by PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::6f60:2bd9:5f36:c4f9%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 10:50:46 +0000
From:   Lei Lei2 Yin <yinlei2@lenovo.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for nvme
 multipath
Thread-Topic: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for
 nvme multipath
Thread-Index: Adlb4qYZRCgfva2qSAaoRzaKM2NfXg==
Date:   Tue, 21 Mar 2023 10:50:46 +0000
Message-ID: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4939:EE_|SI2PR03MB6110:EE_
x-ms-office365-filtering-correlation-id: e8559bdb-68ab-420f-f6fd-08db29fa20a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4thRm9gdDg8h9ynMC0A0UGYzp5xLxCjsBPC/NByEfFrcCVwU1Ac95mrCan9sm7rwk0de1psLrmCnkgFsV3uPBls2phtwcI/tkEwS8KNG8tHtaIUhB/PNaB8NNNbVOxj2XoE/NGw3iT7+67DOL2zA8j7JUzMFPtjfeTOiqX0QvsEzhIphj3XbKFtP0gFXoZCUW3V8bx9EyrF+dod1LkEdDBDuxvnFrWVcgm+hlm26SBi1absZG4v4pZBYAtcIuHoEDmQTRtr+cZVCc+3ju5B5rgKU5lL/ofX5dnEILtaYgmz1HFUGUVK2dv6Ystbm4UBwKatTlJRQTOX9RAq/ZNG9BOjULFmbA7Vyv/nitDfJnYr+x6291R+kNyJQ8c99ZqznAphpTE00fnEr5G9te1Wizg6IrXKw0llOZxXF21JfNsSAoprFaesshtxWHyq5PVcgGHNakgdPq3UXvuKHKte77mbKym4Mo5xujdAdpEQuaSwvuXwo3VD6nSIuY0BbJbWrvO3juiZLO1144qTTW1UYhYaBTzMzHtHIWrqRQeehmq8yaqm7Ygyo044dpJ7WJ7Jfw0hXuSrQGyXJdQqSYnEYozvtuwpGu/m2OM30VOZYI5Rl7lz+ycdGgq6yP37h/njyatdcRz6/EESDwgvV6qIeSOgR0dwHdFtATTvHzewSRteLgAUSxoD3v+C5O1zsIXmwRO4S1BBXSziR8tM1PTnP6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(83380400001)(6506007)(26005)(66476007)(71200400001)(478600001)(186003)(9686003)(7696005)(64756008)(66446008)(66556008)(76116006)(316002)(110136005)(54906003)(8676002)(66946007)(53546011)(4326008)(41300700001)(52536014)(8936002)(5660300002)(82960400001)(38100700002)(122000001)(2906002)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vj4oq0ec7cnLJotY8n/xkSQiy179X3btyORAzMg2q0CXPAZAav8PNXfKYiPO?=
 =?us-ascii?Q?vC83pTHGjZCoj6mO02CDAJjIrpAhkZfB5XIMF+qNY6FB4vzIyS/uGipqV8Ew?=
 =?us-ascii?Q?KB6FrumRgwhpSt0MaSKfM2W20xghZz+sSJl0Bex5SOgzEIEbP3XDfZCYKHS3?=
 =?us-ascii?Q?VQKPUB1javFqu6mLYFEHWn4XQhNsK5lEUb0xvaUL4sFSvPuY7BNTfChXkrZs?=
 =?us-ascii?Q?enj0E4MS4Efx+ARqJBdyxu1RM5Sscf4OGfpb0JkKNtLC3CtNa/uddfrn4FVc?=
 =?us-ascii?Q?XqOkeLsn/ixa1Zg1VjEXN/cr21lyCGSTvBolk+NHIIdn8JktDOmV3sXQ+HmY?=
 =?us-ascii?Q?y5tXDDhKzDj2GOWQNHgeJAI06PiEeuEGqTw9f070vsNUVNisqc26WbDjBJQ9?=
 =?us-ascii?Q?+ZvcAEcb5kwyzvUspNlzGtBSHa2Cz80MTwnq29JuRVNpGMAdutzUhQ9xYxU0?=
 =?us-ascii?Q?9rEg9JBo0BS62eZOF32/lzLrOV11qC7ZbYk/C5OTVttimt+1NHiv88RFs+dM?=
 =?us-ascii?Q?Dl8cDpvhUPxgt4AJ73BecKiziSAruwszk8e27eLCqcxC2rzmnmcnqCuVDg2V?=
 =?us-ascii?Q?LiV4CL0zcGdOvgSKWgnsPAjjVnLbA2LbvFDE/MEsnTa/8OfuzQC0vhAu5+ep?=
 =?us-ascii?Q?eIGqqR71OBkBaa3Douvs5MPwi389Pay5xpdQBBfzmlCXAsyZN74zCHwjiuau?=
 =?us-ascii?Q?EIkV5h3pX91WUmJ7hB4rKIk5SeduKaeIFqElucFdISEjvkI+3XHJoqq94Mau?=
 =?us-ascii?Q?ioyWGPVSYNRg7G2PbfjRbMOu8qbmVUwtVDU+nlSRqT5nHUZSvERHIb/M8Od1?=
 =?us-ascii?Q?PHmREh/cj1gCDuvl7A0focSNNoykyhfMvlep7p6jW0kCTyaPNIRc+XPsnzMS?=
 =?us-ascii?Q?2h6OsYoehNMcsEgVZcfVyrAbBQLkEgYQDsNZQp3L5qCaiIvVGLiBFhVf8CAd?=
 =?us-ascii?Q?K7WzG6ROOgrvRAjJUQJAjDoGFNy21ssVf1aX/ok4qa65Yc4NsOF5LABV77Px?=
 =?us-ascii?Q?K+WU3Yx9TLPWh3NzgU6h1zkyDZZphHw6ReW0DQbuybX5Hg0DrYzXl0RkoxHm?=
 =?us-ascii?Q?HN3sytN/yUe8iphKbRjUAOPZSFQwErUWs1dri/AwNLiXIAZkbvUNcTVm9ICF?=
 =?us-ascii?Q?cR8jewSkLtY9DiLHA4vGkzqKpEe2lBd8Cgh9dkVycRzo0zgmfOfj8gauEGOU?=
 =?us-ascii?Q?CEpdRylfgR5xDVpuaZFsTcSFMeAuksQVFvr22F928qN/3SJ9AoHeLBsxKiYt?=
 =?us-ascii?Q?jgaEwHxR6rN6yxELZOJb6apL/GwgP2pNhxHf58G7Mqa+nLH2/CN3KnEHTO7b?=
 =?us-ascii?Q?jViAyZCK2PSV0Q1FvGTmTkP4vtDf0dPywmfvBJFeCqnKVy9CMwi9jvWAj71b?=
 =?us-ascii?Q?1bE2rWYEU11l33c1Tuc0Kduc9f3H8nlQKJ2/tqDjzgKZIVzyffD/XolhlOb2?=
 =?us-ascii?Q?z7Q9hiv5plNF2fnosdIphf9v8n6I/SMjL0w6veO/0H240oJTER0F9I7PaZkf?=
 =?us-ascii?Q?xFJRCtc/fpAyoCJhzo9pVL/oT0MHuYM/WwDQhWzGWaMuXBYbZSbMTeZ2ijYY?=
 =?us-ascii?Q?lm5AMZdn+ZKJvEm6uHU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8559bdb-68ab-420f-f6fd-08db29fa20a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 10:50:46.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TT57+ehdZhmBjM/59+0HS8uCskkAKFIwfpPyJ6yf5oOkTBptgG1VLt4ffWTlW46PO246cwc9F7u0rSdagb/w/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b134e7930b50679ce48e5522ddd37672b1802340 Mon Sep 17 00:00:00 2001
From: Lei Yin <yinlei2@lenovo.com>
Date: Tue, 21 Mar 2023 16:09:08 +0800
Subject: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for nv=
me
 multipath

When blk_queue_split works in nvme_ns_head_submit_bio, input bio will be
splited to two bios. If parent bio is completed first, and the bi_disk
in parent bio is kfreed by nvme_free_ns, child will access this freed
bi_disk in bio_endio. This will trigger heap-use-after-free or null
pointer oops.

The following is kasan report:

BUG: KASAN: use-after-free in bio_endio+0x477/0x500
Read of size 8 at addr ffff888106f2e3a8 by task kworker/1:1H/241

CPU: 1 PID: 241 Comm: kworker/1:1H Kdump: loaded Tainted: G           O
      5.10.167 #1
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
Workqueue: kblockd nvme_requeue_work [nvme_core]
Call Trace:
 dump_stack+0x92/0xc4
 ? bio_endio+0x477/0x500
 print_address_description.constprop.7+0x1e/0x230
 ? record_print_text.cold.40+0x11/0x11
 ? _raw_spin_trylock_bh+0x120/0x120
 ? blk_throtl_bio+0x225/0x3050
 ? bio_endio+0x477/0x500
 ? bio_endio+0x477/0x500
 kasan_report.cold.9+0x37/0x7c
 ? bio_endio+0x477/0x500
 bio_endio+0x477/0x500
 nvme_ns_head_submit_bio+0x950/0x1130 [nvme_core]
 ? nvme_find_path+0x7f0/0x7f0 [nvme_core]
 ? __kasan_slab_free+0x11a/0x150
 ? bio_endio+0x213/0x500
 submit_bio_noacct+0x2a4/0xd10
 ? _dev_info+0xcd/0xff
 ? _dev_notice+0xff/0xff
 ? blk_queue_enter+0x6c0/0x6c0
 ? _raw_spin_lock_irq+0x81/0xd5
 ? _raw_spin_lock+0xd0/0xd0
 nvme_requeue_work+0x144/0x18c [nvme_core]
 process_one_work+0x878/0x13e0
 worker_thread+0x87/0xf70
 ? __kthread_parkme+0x8f/0x100
 ? process_one_work+0x13e0/0x13e0
 kthread+0x30f/0x3d0
 ? kthread_parkme+0x80/0x80
 ret_from_fork+0x1f/0x30

Allocated by task 52:
 kasan_save_stack+0x19/0x40
 __kasan_kmalloc.constprop.11+0xc8/0xd0
 __alloc_disk_node+0x5c/0x320
 nvme_alloc_ns+0x6e9/0x1520 [nvme_core]
 nvme_validate_or_alloc_ns+0x17c/0x370 [nvme_core]
 nvme_scan_work+0x2d4/0x4d0 [nvme_core]
 process_one_work+0x878/0x13e0
 worker_thread+0x87/0xf70
 kthread+0x30f/0x3d0
 ret_from_fork+0x1f/0x30

Freed by task 54:
 kasan_save_stack+0x19/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x1b/0x30
 __kasan_slab_free+0x108/0x150
 kfree+0xa7/0x300
 device_release+0x98/0x210
 kobject_release+0x109/0x3a0
 nvme_free_ns+0x15e/0x1f7 [nvme_core]
 nvme_remove_namespaces+0x22f/0x390 [nvme_core]
 nvme_do_delete_ctrl+0xac/0x106 [nvme_core]
 process_one_work+0x878/0x13e0
 worker_thread+0x87/0xf70
 kthread+0x30f/0x3d0
 ret_from_fork+0x1f/0x30

Signed-off-by: Lei Yin <yinlei2@lenovo.com>
---
 drivers/nvme/host/nvme.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c3e4d9b6f9c0..b441c5ce4157 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -749,8 +749,17 @@ static inline void nvme_trace_bio_complete(struct requ=
est *req,
 {
 	struct nvme_ns *ns =3D req->q->queuedata;
=20
-	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
+	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio) {
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
+
+		/* Point bio->bi_disk to head disk.
+		 * This bio maybe as other bio's parent in bio chain. If this bi_disk
+		 * is kfreed by nvme_free_ns, other bio may get this bio by __bio_chain_=
endio
+		 * in bio_endio, and access this bi_disk. This will trigger heap-use-aft=
er-free
+		 * or null pointer oops.
+		 */
+		req->bio->bi_disk =3D ns->head->disk;
+	}
 }
=20
 extern struct device_attribute dev_attr_ana_grpid;
--=20
2.39.1

