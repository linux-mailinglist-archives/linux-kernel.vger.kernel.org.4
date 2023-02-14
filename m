Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC96963AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjBNMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBNMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:40:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B11F5DA;
        Tue, 14 Feb 2023 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676378415; x=1707914415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=06O0fT/NGLOuAf0m2zRvfHU+BYhG9uWw7apGGzGM6FM=;
  b=QEutUe2/ie3chF2TsbbobUBZkRiPGnoIT7d7lkOScZ1io4/F5T2ppHMD
   bTxCmjN5b0jVXqroKUNsxf3yqR+kWFfj3tpzuHL4Abl/gcxmq+r4cuBWg
   rQdKZllEdXcDWVpjGyOhtwQcVy3y88EwAK8zKvDQfHLNpW5AuNFUj8vgl
   avR/VA2big8EkSLssclVT/Jl5+E2ZEfN8L6yraP5v/khewGKNgbjpF0RY
   /wmYGL//cpZUIwgVwph8wfBe5EnpbO8cgnj8KUQiOfvjfLXj7gAv0cj7h
   vD0F7P8Q99rahwIKej5W00Ln3FjxXL4QAlZ1wmw8ILKzIr9gnxcMc18IE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332461647"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="332461647"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 04:40:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757972597"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="757972597"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2023 04:40:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 04:40:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 04:40:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 04:40:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu4uflH2z7lKY5h3JnX9pcW/wFu1LT54r31Dk/anSUbLi7jWhzY5hMBnIN4SdDYwbSMu/+a3UeKmyHoODx4tVIIASj/4X7+X7XXxUNl/aQUx2fmHkSTjDIp0UfdhYLgy4kVy5qDPQx6SK/YFiF2i0ixAqndVGjTGe9vcVG4a6MeMYJFTUaXQMar2ATAWNNKWyN4puYMbjWysjPdf5HPOgTqQ3Lf8GLeRXJOrZRrX+qqJCdbte6rP7Ugwc4MCYddYxSdbYIFDhpfZqZIw5i0otb94wI3s/n7vSQN7LQTXeRBkHatr+4ZU1DLP7rYUtDDCz8KBAgXxmYB9reuEEjilKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6vXMwNP1Vqz2mAOtpxXnygGl8zDWKAsdzpEr4Tu+kI=;
 b=aREGuJZ7E82Hg1XDjmySQXdBR5JdTWWLS5P5lIoadT+DVTF+XDrKB5NhKAqXf9C6aNgBXog03iTREcYQ/c360a/FnZ0HaHhhXscqEBWAbkFUlArQUDSW4KvVjCCwrWy0lIp3EXVALAfKWyo83rb6g0hfde1amAe4bBcjWzIKDdWiDDzjmv+9mgVDyOlFOUNAFOwrDgnkm8CAyGuRtI0dw/vzkmVLR8ku7nRbm6J/9LOfds+GOn0f3vKdS3rOdke3Q79m8l2t0Q0H+m8LD2shSnO1Kxg68fcuO/gn3EW6lOxSNRNFOdPA4u2YeiARXp34VPtWszQ6X/d88v09kCgUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Tue, 14 Feb
 2023 12:40:12 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::4166:eaf4:4a68:ee3c]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::4166:eaf4:4a68:ee3c%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 12:40:12 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] media: pci: intel: ivsc: Add CSI submodule
Thread-Topic: [PATCH v2 1/3] media: pci: intel: ivsc: Add CSI submodule
Thread-Index: AQHZP1HqpZLwLlRt00ml9e7fRXtKOq7MO6AAgAG4EjCAACxFgIAAM1Hw
Date:   Tue, 14 Feb 2023 12:40:12 +0000
Message-ID: <DM6PR11MB43169E925577B4054D664FA28DA29@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213034202.2926-1-hdanton@sina.com>
 <20230214083533.3410-1-hdanton@sina.com>
In-Reply-To: <20230214083533.3410-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|DM4PR11MB6478:EE_
x-ms-office365-filtering-correlation-id: 37b7a6da-999d-4657-3dbd-08db0e889da9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVRQiryWYUXOkjUfXI8ApQ78AMn1EqiVGBlX2D+Sj7r+xBDpft5P0uLLM8u+9oH1Y5hM4v5Wbb27yFgcQ5vx4rF4hH7Uzygtt4fCz74fR6PdMtt5Wyko+zYOeera0DacmDJn8a41AvIYJih6Iqwu7aZ4zAvhX7BH57td7YPFnIpbFUTiMQyJOvm82T3mMcGdMvjxhOPf28RgiiSEI2x3vz/bvQy9mJriu56EGJzXxjtMdF79UBMb468Lgxp/6sUg5Nrrr4W5o38wRB3zWNiVWHAY15rWusJozNH9Vp6SGpufS9g5yKxWxVPn4d0iZ9AVcOH4uxmNwi0bAtK2+yh/muDrUnOmqMoHQLPqqRjtvozyOcO2m6msjX9DnfB+P/QMUSjE8cathj7WOC7ozZi50ePxAVK3C35P1yrmmaL+pxVmzrhOPFiFS0QH2KdeZfP3qZJCX3N8AFXEmezrWuyOve0gBt/Njo1lyrIOMai+bR3/lSqR3dovrIWtOa1eYl0+nZsdRWIU+JAx+ooBiprUajsIuolTmwfe31d0IeFjW8MUNCmDRD83YCokIUYVBx4AQIHnG4ysFQOP3bk2X6VZ7WM0sR/vJ4j1BZNn7u42cfynMpiCW0G1W2eOv85pPqNizkrS5G5cE57ZGBxrC8aWDnSLaFbF4DYKRoxCq0P8EDTn/INTO6PKkuawG5A8xklqHnrZE3r+Sv+zz7ztcfCZOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(71200400001)(83380400001)(33656002)(316002)(66476007)(38070700005)(64756008)(8676002)(4326008)(66556008)(66446008)(66946007)(55016003)(9686003)(6916009)(76116006)(54906003)(186003)(7696005)(26005)(478600001)(6506007)(122000001)(2906002)(38100700002)(82960400001)(5660300002)(52536014)(41300700001)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SFQ60MRg5jWr3GIGjs4jP9gyPCpSX9i7qPNrsXIqzJkwdgz46AWNhSys3IH/?=
 =?us-ascii?Q?NLWaZDUMuF5wQGyGfEtaDjiPVRG93NW1jqdMm6R90TzPSXZqp0D3QmIVpnjs?=
 =?us-ascii?Q?4VTv+N15cnVoDN/zHkBJHlaSGZ6ZSZ9h34bK4mpxTQGbIzpJclZY1Ya0Ao3E?=
 =?us-ascii?Q?li3QtPdGPBXknT8q27mAwZg8SgaQfc/2f2McJ67hYoj/jopEIuH9SPC07kZN?=
 =?us-ascii?Q?bMMKd5H47849g8PVfoZ+fpKeRgRgHdapdvhbaSgUW07b8Q+huKArU9pHCjYF?=
 =?us-ascii?Q?t2/Sg8Wz2DSYrp0jHYo1Qk1iIWcw/6I1gfI7LfPL7wttkq4Hfqr5lstfFoUZ?=
 =?us-ascii?Q?CP1eygy67W8Rqv2MQbvF+3UtocFrAv7GlIuAMOPJapz5lbeB56ubg/86oOge?=
 =?us-ascii?Q?mmeKidy6/r1tirjAqYsNuctjRIwoIHfbTgmnqF9VBXfdFsc+KEFTkFM3aipH?=
 =?us-ascii?Q?ei5VvDs0Z1WFIjFLaucolve+R6kHY257J2yNvGTynxbsbOZnBhAr9nSqUZPP?=
 =?us-ascii?Q?ohBT5HWojsLIKwHR38TwPbs2+2sQo7YCZXQx06ALxY1HH+AXWPTesgP0BLPo?=
 =?us-ascii?Q?lx1/J7jZ4wRCCI98GqmwJSdzihU63iJ+aWGm05CSAByLoi0XbQ0u71inZSHe?=
 =?us-ascii?Q?sq+fJGuH3ES3hL98g9021xXVyNfGWxGiOUFGu13zqrlu6hPjCVAtF/RK3A3Y?=
 =?us-ascii?Q?zr2J7ypC9SNPYZgZSCgtozpiUhf7MatN9MmYr7VrvYrWS+vQLPFnRRpndrhn?=
 =?us-ascii?Q?ITmAtM55IFpRDsn2EBH+HekP2tFvKnM37dFqwHFvcdloNzDsCAEYyY8RjNkt?=
 =?us-ascii?Q?3dP/cgTf91c/+jHppTBhOCScfeLVmQkD96Kd9DHdyXOVCOvd9aiNNs5wa8xc?=
 =?us-ascii?Q?lDyz3xOXU1Ytkl7qb8BfcDk7V9m0zSJUCy3Gsn950QHX4oa5eJajt7M7UsjC?=
 =?us-ascii?Q?YEy8WLyRLgLgh2/5JX7HvIGPVZcy0MZMF6FTc93klv8fzROcCKMaK0chhxWe?=
 =?us-ascii?Q?LpsxuIkrbsMGLc8sYbyLHkyOW7Nd+ROLgdAuUfBu4jza8eZyUF5uvaBpiXsq?=
 =?us-ascii?Q?ejcP5Rjo0f3gc2Q3w5Z7xDIrVMFKbr5/DE1LXfHBcO0IvAjn30WOu8PjtNZt?=
 =?us-ascii?Q?2AlJUDaBizXUxxsZAF6uCcPwVMRp85lIbBJ+ailgKjBUrBfw7jww9XBuyGWp?=
 =?us-ascii?Q?X7hc+zosHr8ZrrDGfjnYOr5b6tMXTl2Xg/EBHgntEs4BBMy2Haq1x7YJUn2j?=
 =?us-ascii?Q?WAvdjJMPXWtYQDhwH+0++xN5/DvnhS0F5/po3ycIaLXdQOfQTsk7hPsGROD7?=
 =?us-ascii?Q?P4uwexiJC+dCCL4JYY+Xekwqw+reMJq30bXzW8+yqyIA1VCt/GQz/QLoiiWL?=
 =?us-ascii?Q?zoH/JGacd3O/CD/Z/L4atUXlCt2zNLL2+VlYmTjDIKA24NGi0yD87zOrgIuW?=
 =?us-ascii?Q?u81Cw2N2VBFysLpZZxed8HTL6W3fBmyE2UVR3fw5Zy5DKnDdswHVDf5NLwyA?=
 =?us-ascii?Q?SEUo6bSZqmpX9S5xUuiyCdROcJWJjlXKkQnOiuD/B0f26Qo9gLAcwzoFfw+K?=
 =?us-ascii?Q?ZMQLYtUDIqkxyR922EhK/DUr6WFOBHEePZSeF0E1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b7a6da-999d-4657-3dbd-08db0e889da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 12:40:12.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAIgrJakfLmI+3BA6QsKp8QAPp8TB86fd38It+BGepS/UV9rQ/TSMEiovIVIZYM2NIs1Dy6O4nZU4hl+FMDz4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: Tuesday, February 14, 2023 4:36 PM
>=20
> On Tue, 14 Feb 2023 06:25:35 +0000 Wentong Wu <wentong.wu@intel.com>
> >
> > This allows new command(e.g. 'get status' command to check current
> > firmware=3D
> >  status) to be downloaded to firmware for debugging purpose in case no
> > resp=3D onse for current command though I have never saw this happen.
> > =3D20
>=20
> Thanks for your specification.
>=20
> Another question, is it likely for the wakeup to come after reinit becaus=
e of for
> instance timeout on the waiter side?

Thanks, first I want to clarify why we have timeout here, in case firmware =
stuck somehow or IVSC device is removed suddenly, calling thread can't be w=
akeup if wait forever here.

And firmware gets high priority to handle command and response, also there =
is timeout mechanism inside firmware, I think there will be some problem wi=
th firmware if driver gets command response after 5s which will be captured=
 by driver code(if (csi->cmd_response.cmd_id !=3D cmd->cmd_id)) but I have =
never saw this happen.

BR,
Wentong
