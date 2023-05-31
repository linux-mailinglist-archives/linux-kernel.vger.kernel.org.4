Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FF718D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEaV4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEaV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:56:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379FCA0;
        Wed, 31 May 2023 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685570201; x=1717106201;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GPs7XTNDi6z5v01pwWcFsKDXDybWD4ogjVl06y/ZBTU=;
  b=kNwXV6/RP6ZNNEAw797IxV+QENLzFFEWXzg4HrstbAAqIeAUjxqfFtsF
   Wc5izaX6NlsyoNNuMdmzEg/RZS4VxRFlbEGAHLmcOC2qpwnyiUIChIGCU
   wwTf3hGCgIaAZUnK4bpzKf+UQJgA3rbZvnND4E7tysq/VJXqbg0VtQ9rH
   SvLkyvH9uIgk7iIlul2OcnVSfcDH1Iyyt1LY0i5iVc31CV3k6TYuk8VhT
   eaZwXglwPSRpazw4LVPv2P34HnaHAMtUS6lWgAimsztnor0IXxmrVrg16
   BF7mmbJrM9aRxTTaW2xhTOsn2OgvrBTjy13Shb+eRwIlz3nt9U1nnn+h8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="418872727"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="418872727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 14:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="772149448"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="772149448"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2023 14:56:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 14:56:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 14:56:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 14:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1S+ItezxKYBB+2Jar4fklC/G+BrHpgIMNg5VfejPpNQcFDRTWR0H15+RNBAGFcT057PG6u/G6XhK9ROn56uGJnhm9/GmFx9fBff5Ci8d50O5GSVJZEy6tpzz+p8VhtdHd9uVQACPnMrmFYAg0ciSag4ssJ8avcEpkR2sfQuzRqR1RMyhxl/8U54OH1Rq8x0RZZSuu3M2satiubImgNJCyFJbvISf3fSQ4aSN6kQSHSBh9apDNuXreiG6lP1y6XqpyREdBSG9Ar3ARKYLr7ic6vJgsCkQwyKwoVRglBXLqMca8jpbwy9EGNRvlU2RDx4itzwFIoQbWDZ2yD08eoGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec93z/zxw8jyAJWDCpgByHBRv8jML667otGL4DPZ+lY=;
 b=jY+0LDnmUDbRRj4baIQ7ZxL1AmzunhYouZQDrb70lie1rpoPKdCMqhdkfd3QiA4rDio+C8cikfoK09Q1EKN5ElK+h4Dt+5apM/KSIWpmE7sNQRexz/SmfmCG13eEU+ROnfefh2pKb2elMoV71rvf8HaMsc+kpA6Oga0Vo9+izvSYct7LZJm46sZFadX39ltENK2So73RS7d1agGd3iCTVxz0X0bIRBEUQFTE5f2/Gn//v3ijBRObIsAqCCXLqJH3mS3CXrtvRkDeSb6nnULqYFEdDokLu3qfG61ERZAO5zI7ijL0BHvAijBXLJ1s06z20b/plQG7GeTZHASKmTRqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 21:56:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 21:56:35 +0000
Date:   Wed, 31 May 2023 14:56:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Message-ID: <6477c29121ae3_168e29438@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
 <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
 <646c313f20907_33fb329412@dwillia2-xfh.jf.intel.com.notmuch>
 <a7443a348b9c2b51cf141ad1131c9befbb09724e.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7443a348b9c2b51cf141ad1131c9befbb09724e.camel@intel.com>
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 719ec02d-2e42-4884-3fac-08db6221e735
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjXHobCoG73hcQJuuRg7Ynb52FT0fuKSHxy7Lob/dauOgezI5d2WEr3+pDKSw/rOt9a1W1gxRtA8WY7O5W501p31qOtrj12xpgIz/PVPxj/SBk8NsB4U1ns9KA1oFnlVFprkaKUI62XPSgwUPuZTrYnOOJftfE76MRUkSzxDkBFLj9t6VbBILDZp5+KVzkebsjqkLmilhgcCXFEX1sOo2bRYZwXhE79hIXJv45XXRJSw5YPYXURlp8ieI3k6kj0IP308VEY3O6t/AQ33CRGfGu02Am3SU8UIodFbFRTLoRVcH/RK5AW9yfF/BK9fz7UGJrprrducygq6NGkXUjBqhCR80u0AMJhJWzpLNUyZg6mLjL2PJTNKV4PqFWN68/R1ofbxMeixf/JDH1kSp5eun8MH7oHpMo/y60nJY9x3ziN8EqY6fl00x7ZdL9ffYppQu8OUWB6skvOvie5NBCPyz+/8sB75mJwcwzV2hIe6Cq1Z2PcouegouS/zqRAQpZHlE+cBaiqEFc1dl3XsKS5Y1y6JE03CjTYQhEK4etG99DfEvxPO/FP6y+t6YrhGNk3tGEa4leeh7CCNuVCBlHO4UlKXezhR0rBR77UR8YsFJnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(6506007)(6512007)(186003)(26005)(9686003)(38100700002)(41300700001)(83380400001)(107886003)(6486002)(478600001)(110136005)(54906003)(66946007)(82960400001)(66556008)(4326008)(66476007)(316002)(6636002)(8676002)(5660300002)(2906002)(921005)(15650500001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cpzmBmotlP6d/+LfgchVc1/idiJjKNlobbMw76Jv/swKntg4ZWbqFuCqWd?=
 =?iso-8859-1?Q?PRvWxPwOnPjbrcx142WGiY4RFjUb9K1PUpu0+4vH3CvHJf+6qdCo5M2Ksn?=
 =?iso-8859-1?Q?aEvLiRtkyHOXTFs9NGmtU1pCNa8GWdFbGjgTNNioOV58MTcPsD3PtyM2X8?=
 =?iso-8859-1?Q?5cEKGOlEDdUqogDEnjMZ84e5E2QecelDxZq0bPY8Sy4mVbNpzu/etlG9aq?=
 =?iso-8859-1?Q?PQZ5gYqU6upRLPTN3u+WWzAKO2HyhHcqdxGE7/8ZfIZkA7GQsoqxtxNP2A?=
 =?iso-8859-1?Q?YkfeuWlRdzrI/je1NgRHmQVTSD63ZTpAkigJKAYvOhYceTlDq1MyTVrsh+?=
 =?iso-8859-1?Q?UlJradi9GzfONgf8k2GbVH7qRuqmKiJsrostOsQcOpGLQeHxQmtj7cBRsF?=
 =?iso-8859-1?Q?JQHIMZouIGKrJ9gexhJ60yFwMz09QNg6dBm/08Ww/Tnmcb0FgtunQFIFvQ?=
 =?iso-8859-1?Q?kZaPecZ7om8Nu4ie53CX+El37fgHNVbgzK7nmhHLi4SuDBLa29zFhZ3MQ8?=
 =?iso-8859-1?Q?DtnchRHTJ5ZPvENN+xfD9D0IdfaZPpwsHX78Gc9PO/s4OybibHvNtC7miJ?=
 =?iso-8859-1?Q?TEWNvHhpcif1SyewIZpiTgxIuFXV7zDXCVheXR8SQ2NSIm23x90gxBXdKD?=
 =?iso-8859-1?Q?zQoNyLcowjq6qzSeeB6gp7c3U5eT3QxONAPjlRJUeJRiRuumOYoRxUvYVt?=
 =?iso-8859-1?Q?vcH8WQyApw1EvGauNOgk/MgknjgYx9XlV7Kq+BKkIn5vKcB1gSaF2ax2bq?=
 =?iso-8859-1?Q?NVdB179Q1XrlaDyC8yhSKrLttWLI3j+jNrGkHAW6wbKGM3VjGT+bkE8siu?=
 =?iso-8859-1?Q?9EpF6tF2grJ/EeQuTFTu2uSD/MPtPVJ2xCLtbku89EUZgDaJQTb6g+4KYr?=
 =?iso-8859-1?Q?wKoC8rrGv7Uq171NubR1OFjBYXyYSBNgP64TcJuaYP9atVZutwRL60f5qe?=
 =?iso-8859-1?Q?DVCUlr2u4COxWU0rliR/NYHrZ8t36rTtseVHajrNmVnWjkM7WpqFAmCoG8?=
 =?iso-8859-1?Q?mFEx8lC6Na9JxkdJ2V26soUID/HXT5/Qf+sVBZ0QfxMI2wP+UYgsSmBQuU?=
 =?iso-8859-1?Q?9Sb+vJkDZgYTLI8bC9C66MnlU42s4gEtBZr0sstBkOxGGDfrkFgHB0d5Ap?=
 =?iso-8859-1?Q?J/aor8A8FsHMSpGE4KikCtLCSGrXq02XctbMU6YZjGmzv2wmPexqW80PRp?=
 =?iso-8859-1?Q?JvM6Fqoukgj1X1YHnITDBOMlc9h7imTzDXSskqa9geELKX/DT1D5Vd0Bnc?=
 =?iso-8859-1?Q?rXt+wRzg1TtSyOEQP4vO8nNJ8mLcdooVw/LoNo/4qBmVCjNRNiHA52naNH?=
 =?iso-8859-1?Q?6ZqHsqGNbjTGVRfUfMKRyj+PcdBYvVgQamtGF9rMOPbCsFoBUV6Upzt/qb?=
 =?iso-8859-1?Q?AcGlTcwXKuTkkXYlOVNAVg4zqmCi7jPZVpxpJHOE0DTwTsy8wusIcU8JSu?=
 =?iso-8859-1?Q?mJjcJFiN/ZozDXkAroPqUk4NUYjDwZ46APmJlzcBkBDVItG+V+GkmJlbVm?=
 =?iso-8859-1?Q?bUeKbN0Fejr9OSFbWpb9YIMdAaneHgNznU+KpBP9mSJ6zRCL13qhM7J6w2?=
 =?iso-8859-1?Q?sSwvRu1oZ2zdSCHmHvZh89GA/5NLmx3fIUTSSdGt5dJBxq2dFzUYHh5nn5?=
 =?iso-8859-1?Q?G3bAV8T56iDj0UySb0nEuiWfwcL+kbV2mTkzO7sRsoHSbd0zcfsv4BoQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ec02d-2e42-4884-3fac-08db6221e735
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 21:56:35.7424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcAdjFSPU5fFFVpTWYo5NJpp2ZesfCV5JJfidDHscuE1qbbmJmxvq3CIlCLQrQNrzD9Nz7IIv7698L6q7Xgb3kuVU9eOLFF2xNJWR6ORiYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verma, Vishal L wrote:
> On Mon, 2023-05-22 at 20:21 -0700, Dan Williams wrote:
> > Vishal Verma wrote:
> 
> <snip>
> Everything else not addressed here sounds good and I've made those
> changes.
> 
> > > 
> > > +       remaining = size - cur_size;
> > > +       size_in = cur_size + sizeof(*transfer);
> > > +
> > > +       mutex_lock(&cxlds->fw.fw_mutex);
> > 
> > What is this lock protecting? I.e. will the fw_loader really try to send
> > multiple overlapping firmware update attempts?
> 
> The lock is just to provide predictable points at which a cancel
> request may be intercepted. The loader won't try overlapping firmware
> transfer requests, but the ->cancel request comes from user space, and
> could happen while there is a transfer in progress. With the lock, the
> cancel will only be 'processed' after the current chunk's transfer is
> done. 

So right now cancel is only considered at certain points within either
the ->write() or ->poll_complete() callbacks. The firmware upload core
is guaranteeing that ->prepare(), ->write() and ->poll_complete() never
overlap for a given session, and that if any of those return an error
the upload session is terminated.

While the lock does flush in flight ->write() and ->prepare() it does
nothing to enforce when the cancellation is processed. It will still be
the case that the next invocation of ->write() or ->poll_complete() will
consider the cancel state before doing the next step.

I am failing to see what the lock is protecting. The other usage is for
checking that ->prepare() has completed before ->write() is invoked, but
again that is enforced by the firmware uploader workqueue.

I think the lock and the clear_to_send bit can be eliminated. Clear to
send is implied by ->prepare() succeeding. Convert cancel to an atomic
flag where cxl_fw_cancel() does:

set_bit(CXL_FW_CANCEL, &cxlds->fw.state);

...and cxl_fw_write() and cxl_fw_poll_complete() can just do:

if (test_and_clear_bit(CXL_FW_CANCEL, &cxlds->fw.state))
	do_cancel();
