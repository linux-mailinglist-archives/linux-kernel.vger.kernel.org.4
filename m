Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8E7295BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbjFIJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbjFIJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:43:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD459C0;
        Fri,  9 Jun 2023 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686303508; x=1717839508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=er9pawHZEbhGrrzvh1h7uRTrIWNz6jbKQUkZDfn6hmw=;
  b=c4rUoW393GZf7oKupTC6cR8h/Co5N24bQiuCw3yYrwixevN2/YV8pkYG
   p7qufa979Vp4YzHuknFK9cRGmLNyEYmQohtnEvCDxlq6L/YCBaWEV/Mg2
   EyDZ+QOD9Ch5Brn06k6yyFcGxRPq/hPKSC823pJ192eEJgSiC1TXhNJ6u
   Tx7m99/CGQm8gG/siL9jMSvGyBmhHfSMVIR6rumMHY8WKFsHeDtdZHnus
   fU/BwttWGHK90rEbbzgpU5jmYYOZQlutaaiBmNVlkttHOlWgJnmed5da/
   YEbwQ/V2W49HjL7zbCWRd4eC+AXHFUZ200Rl8foJ44fHa8aSmJha7RDgn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="421153404"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="421153404"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660709865"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660709865"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 02:34:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 02:34:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 02:34:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 02:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKRavx436dV64oFxiY5yWDiJ3X4d7BMsiYj76HKGl4w+r0V/jtqqXenX7R1A7s+XX5vwZNGuEdtzQjGEKzoSdFl0etugoBwoAa0wVkxkJANeLjsCVO2wzkDVPnU/8/d70hV/kI767eUTBY886kKGOHyrQ7QQ6MscHkFDvOxhDtD46VZSnW9CPUMkuDAHf/dBwWf5RPLcsSBXuActgA9S/6e390Myp18n7hGCFah8IH426cEANRwNUFALBoLjz+fp4/nDaX4M2N1kDtIuyCN8JdkyzxX72b798+T4AqnSnEI0WmZmft2sky18lOBeUdsHD+/BdSRfv5hSUYBwPmBpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opSOg9v2tBHc/P1TUvebRAJSNOLQJizJNGAI9nm/7XU=;
 b=SurygviJtPj8YdAAhBa9gaPrQcLjWJuY7NZ7WozkTb7LzPZSl46cCsAa5vh720pxVWzmnoNlnb+a41VFWJguKYomK9d/SOGHEyNvIl5dL9Vip3lIo2rHmyiky3ETmNOjuT1tRhlQJVa211t5j4ZFfDl3Bp+bSzavT2KjYwN7w3r70b184PhURTb7Esz7qHBs8Qir4pfhx56Eyxg6toJXRr6z6z24kLUNky5OOgtNv0uy/DWAC2i5QvHoN7Ov46hp6tMIBw+UZmQFDCbFnJuuzOsfIZ85NpynLb3bK/4saJI3WvaL8t/ujE43AqX0LmgLUIMUT6eai3Uz3+YqgDFwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 9 Jun
 2023 09:34:40 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::cf52:d7:14f9:f2bf]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::cf52:d7:14f9:f2bf%4]) with mapi id 15.20.6455.043; Fri, 9 Jun 2023
 09:34:40 +0000
From:   "Roberts, Martin" <martin.roberts@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     lkp <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Thread-Topic: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Thread-Index: AQHZmqPojdX+pHytPUCdD+Alcr/i4q+CJE+g
Date:   Fri, 9 Jun 2023 09:34:40 +0000
Message-ID: <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
In-Reply-To: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|DS0PR11MB7629:EE_
x-ms-office365-filtering-correlation-id: aa5fa61e-5023-4915-a983-08db68ccbfa3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5Ot6LmWVmq4Vyw2uH+8feww5b6kyiJAHiG037Hh8lNqVqeOz88yyUjHgeYLmQ8G2ry4HlBAMkujDY4Yntbn6vCnAOiG9ICDwCGzI5wHPb6U/7BC9poL7ambjdKSM+Ldbo2IqaueKaq7aaz/H+nK9KWvpHOFlnB9gNp+1MT2dSfWnq4hpEsn2B0HckYcog4CFi2Z3LpYpthWXnRzvuYZ60yW1i2qphw9tSCuU30n+Nz0Nm0Uf4huRYSMhna7m8VXBwQ7CF9VW3QVbLqS4yOBHsJr3bE5cCmGbezDkRXNZKKl3PP80s48vBCd+4YAwWmSyIHToRyWn4K4U1vJ1g2WK+dAnGvdIrnQae2YzgCxv6y0g8DYKN24cY3v2rCCwTKDevzZ6wTkOY+wnl16fpDWSYYQjauu0IExh9J6e9YsbbCs3nKAbf1gtoDaJQJH8qV1X/XZZ8+DIIHh4OhdknDY2oK90QEXzvWoMYYoGqeCMQ94i1BvDr6g6zQrDhLDWvnn557btYPG1oiTNiC3NBcPzeu2cgHgfYTpLiRbsjkUsyc9/BKK2Pq2La+y/HQT6K9AVxffH4sJnlYl0Nakk0GRESY2v3gUUvplMGxztJ1VSuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(41300700001)(71200400001)(76116006)(316002)(38070700005)(66556008)(5660300002)(4326008)(64756008)(66476007)(33656002)(7416002)(66946007)(66446008)(38100700002)(82960400001)(8936002)(8676002)(86362001)(966005)(55016003)(122000001)(7696005)(110136005)(478600001)(52536014)(54906003)(186003)(2906002)(6506007)(9686003)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JinBPmX9NVx8lzENe0aAQSouKwAQRc3GUUUR/QisovVU8rXkWewF8RtkTuuB?=
 =?us-ascii?Q?hSjf6FuZRLMid4TQgOuKlmPOv1Mu/VoTMnSRNBiksmX9e3ME4Y9L59tCGPFz?=
 =?us-ascii?Q?IT89JFY2y/cjMIHCDwprvwx7H7HA9zDKpK639PHBX4H48/m82yEtc0hoH+mj?=
 =?us-ascii?Q?Uumg8aLUAO4cZ6RmYxT8vSHIzU2RUteC4FMIUqju/u/4aZm6ASGTpCIav8fB?=
 =?us-ascii?Q?k7ZWQy0mBb30FHLt9AQvs14u+m+bVeMe+Tni+e2n8kUno+tQkk8ectDS8Mcv?=
 =?us-ascii?Q?NJRaVDAXp52I/uwjMJjMAJvy+Bzewxf0QxWT8/vCORUITyE8tgP/GD2okz//?=
 =?us-ascii?Q?QDsa6Tck89WBiemGrDbUngww7TayyqIeRtqoIAl2wxvD0Wnt0A99XUcuLsxf?=
 =?us-ascii?Q?dRX9H96T+dqcjcRAjvnh+U3fjpJMbptMwc0xMbZ97hDMS0jLiuGN3b+02N+W?=
 =?us-ascii?Q?RNVBJMxVK791vIytw0OvhIh/9p05xa7/PbklBu8RJ+wty/WQ9tiuqY8d/1sk?=
 =?us-ascii?Q?y2yVqyZ9uB0+qPKgQzqBkPUqoreUWieBj+okueEbcVrgeMza12w/JPTEgpWP?=
 =?us-ascii?Q?pbfbVFUPcI0aTrpytljOHmYunfX1S0Kcg5cgtpY1XDGVN1VSgCIyacFOzncB?=
 =?us-ascii?Q?QVgDRWlMdgQqaDISLbC4yBVqOMbI6FDDrxhkSKi54OpnXvY6PB86ungzF3+5?=
 =?us-ascii?Q?gXlZcgMqJKp8CeoKObYIfiKJybQgH23IuuQseEXk6CW5x1avybz7S324Hsd6?=
 =?us-ascii?Q?1qXQXbMF+jPtU3QW4qKGu69mukaTV4+UxAgQtqjc1wP6vGhRioBlrhySslhC?=
 =?us-ascii?Q?iShQSbcFrSk9XrrHcPvlsOhLtRHQSKFLvMlzXfVhli7x9eJJ2uBpbZPSHP4u?=
 =?us-ascii?Q?RKTy5sqg8A8T6M3gMv8e+bAS5j4mNDRrI0IqGfFjtZxj+HPc2eV7VEcq1Q9I?=
 =?us-ascii?Q?z+YKkmX+Aioc2bTmjmjwHJe5BzhV3LbXWo5+UmlmHOaSVq3BrnZwuzPmUKR/?=
 =?us-ascii?Q?lgZ4SmTQdzD8bYWscCUPpzp1ktDK5X8KmcxCt2dCvsVIIAmrSVA4TVIgRwGF?=
 =?us-ascii?Q?iyQ3DofefwEQJHi2WX2KYtjHKqYh2o710whzGTxi3P7xSxuqhqYiOfCcIeHr?=
 =?us-ascii?Q?4OeNvIu9ClQB6spm3e4PxjdwdQqtVrZR8cYwTVivsrjK6SBjrs7giksqw1SY?=
 =?us-ascii?Q?pmIR4gWtBdEHv/EM7ZIs6c4VYiP614Uwm4B/XCBTxw4J96JoQUr9JAUl0KNd?=
 =?us-ascii?Q?p5/vcjZAlykzOFbAqyAFt33YBjq0Szv0KEM+Iq/IMd5HN2s/lfDtUHxulXsY?=
 =?us-ascii?Q?AsMyN508Q8N++Stb+fvz7EtSteSJi1iNQlcMF2xJXvrIRbKLCcRJ3rneA0MX?=
 =?us-ascii?Q?eUSPl8grrR7JZYVmJRXZZq9CFC7IlvGpod0EvhOBXeLu07Ar6pkmzJOvBO6T?=
 =?us-ascii?Q?V+2AaTt/9bopzDK9V7KOcbksoXYGGQpRdZqEr3PpSbILZpNZh2eAKXJLh8bH?=
 =?us-ascii?Q?/06+csSn2uzPMga3+6Jl7W4+bb34VeG7eyXcLiyCAu1vAHILKKbp0gelBOJW?=
 =?us-ascii?Q?U44X64AL73/e+Tx3T8k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5fa61e-5023-4915-a983-08db68ccbfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 09:34:40.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GsRWkWEEarsOsFaOrSRf8p0DA+HPstc9KuB83nUvNZxxKZ2Eccpmw6LeiD5I0S7eyfciLISB5gKsnKZCyAn3t3A0hc30J01SWyPAPQ2PV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think, at some point,  vbr->status, got changed to virtblk_vbr_status(vbr=
).
If I use the version of virtblk_poll() from the patch, but substitute virtb=
lk_vbr_status(vbr), then it (patched 6.3.3) compiles OK.

Note, my setup never causes virtblk_poll() to be called, so its influence o=
n the issue is unknown - but maybe it also shouldn't be running in batch mo=
de.

With the patch, I've not (yet) managed to hang it - I will let it run a bit=
 longer.
Martin

-----Original Message-----
From: Michael S. Tsirkin <mst@redhat.com>=20
Sent: Friday, June 9, 2023 8:27 AM
To: linux-kernel@vger.kernel.org
Cc: lkp <lkp@intel.com>; Suwan Kim <suwan.kim027@gmail.com>; Roberts, Marti=
n <martin.roberts@intel.com>; Jason Wang <jasowang@redhat.com>; Paolo Bonzi=
ni <pbonzini@redhat.com>; Stefan Hajnoczi <stefanha@redhat.com>; Xuan Zhuo =
<xuanzhuo@linux.alibaba.com>; Jens Axboe <axboe@kernel.dk>; virtualization@=
lists.linux-foundation.org; linux-block@vger.kernel.org
Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the=
 IRQ path"

This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.

This change appears to have broken things...
We now see applications hanging during disk accesses.
e.g.
multi-port virtio-blk device running in h/w (FPGA)
Host running a simple 'fio' test.
[global]
thread=3D1
direct=3D1
ioengine=3Dlibaio
norandommap=3D1
group_reporting=3D1
bs=3D4K
rw=3Dread
iodepth=3D128
runtime=3D1
numjobs=3D4
time_based
[job0]
filename=3D/dev/vda
[job1]
filename=3D/dev/vdb
[job2]
filename=3D/dev/vdc
...
[job15]
filename=3D/dev/vdp

i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
This is repeatedly run in a loop.

After a few, normally <10 seconds, fio hangs.
With 64 queues (16 disks), failure occurs within a few seconds; with 8 queu=
es (2 disks) it may take ~hour before hanging.
Last message:
fio-3.19
Starting 8 threads
Jobs: 1 (f=3D1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
I think this means at the end of the run 1 queue was left incomplete.

'diskstats' (run while fio is hung) shows no outstanding transactions.
e.g.
$ cat /proc/diskstats
...
252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568=
645 0 0 0 0 0 0
252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905=
623 0 0 0 0 0 0
...

Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queu=
e_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and =
show every request had a completion, and that virtblk_request_done() never =
gets called.
e.g.
PF=3D 0                         vq=3D0           1           2           3
[a]request_count     -   839416590   813148916   105586179    84988123
[b]completion1_count -   839416590   813148916   105586179    84988123
[c]completion2_count -           0           0           0           0

PF=3D 1                         vq=3D0           1           2           3
[a]request_count     -   823335887   812516140   104582672    75856549
[b]completion1_count -   823335887   812516140   104582672    75856549
[c]completion2_count -           0           0           0           0

i.e. the issue is after the virtio-blk driver.

This change was introduced in kernel 6.3.0.
I am seeing this using 6.3.3.
If I run with an earlier kernel (5.15), it does not occur.
If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq=
_add_to_batch()call, it does not fail.
e.g.
kernel 5.15 - this is OK
virtio_blk.c,virtblk_done() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          blk_mq_complete_request(req);
                 }

kernel 6.3.3 - this fails
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                  if (!blk_mq_add_to_batch(req, iob, virtbl=
k_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //=
this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

If I do, kernel 6.3.3 - this is OK
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                   virtblk_request_done(req); //force this =
here...
                                  if (!blk_mq_add_to_batch(req, iob, virtbl=
k_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //=
this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

Perhaps you might like to fix/test/revert this change...
Martin

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@int=
el.com/
Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Since v1:
	fix build error

Still completely untested as I'm traveling.
Martin, Suwan, could you please test and report?
Suwan if you have a better revert in mind pls post and
I will be happy to drop this.

Thanks!


 drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..b47358da92a2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct reques=
t *req)
 	blk_mq_end_request(req, status);
 }
=20
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
-static int virtblk_handle_req(struct virtio_blk_vq *vq,
-			      struct io_comp_batch *iob)
-{
-	struct virtblk_req *vbr;
-	int req_done =3D 0;
-	unsigned int len;
-
-	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
-		struct request *req =3D blk_mq_rq_from_pdu(vbr);
-
-		if (likely(!blk_should_fake_timeout(req->q)) &&
-		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-					 virtblk_complete_batch))
-			virtblk_request_done(req);
-		req_done++;
-	}
-
-	return req_done;
-}
-
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk =3D vq->vdev->priv;
-	struct virtio_blk_vq *vblk_vq =3D &vblk->vqs[vq->index];
-	int req_done =3D 0;
+	bool req_done =3D false;
+	int qid =3D vq->index;
+	struct virtblk_req *vbr;
 	unsigned long flags;
-	DEFINE_IO_COMP_BATCH(iob);
+	unsigned int len;
=20
-	spin_lock_irqsave(&vblk_vq->lock, flags);
+	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		req_done +=3D virtblk_handle_req(vblk_vq, &iob);
+		while ((vbr =3D virtqueue_get_buf(vblk->vqs[qid].vq, &len)) !=3D NULL) {
+			struct request *req =3D blk_mq_rq_from_pdu(vbr);
=20
+			if (likely(!blk_should_fake_timeout(req->q)))
+				blk_mq_complete_request(req);
+			req_done =3D true;
+		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
=20
-	if (req_done) {
-		if (!rq_list_empty(iob.req_list))
-			iob.complete(&iob);
-
-		/* In case queue is stopped waiting for more buffers. */
+	/* In case queue is stopped waiting for more buffers. */
+	if (req_done)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	}
-	spin_unlock_irqrestore(&vblk_vq->lock, flags);
+	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
=20
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_se=
t *set)
 	}
 }
=20
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *=
iob)
 {
 	struct virtio_blk *vblk =3D hctx->queue->queuedata;
 	struct virtio_blk_vq *vq =3D get_virtio_blk_vq(hctx);
+	struct virtblk_req *vbr;
 	unsigned long flags;
+	unsigned int len;
 	int found =3D 0;
=20
 	spin_lock_irqsave(&vq->lock, flags);
-	found =3D virtblk_handle_req(vq, iob);
+
+	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
+		struct request *req =3D blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
+						virtblk_complete_batch))
+			virtblk_request_done(req);
+	}
=20
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
--=20
MST

