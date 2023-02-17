Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334CC69A62B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBQHho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBQHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:37:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD05D3F9;
        Thu, 16 Feb 2023 23:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676619455; x=1708155455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5+amSRvoEf6RSqchQtCJJyj0eQ+92k99nms6PnzvlnA=;
  b=AuSFGhUSHAz0OEZU2GvWDQbDSHdhT9XCVdk9ryG41LtpSAzthc+a/Gdl
   7Id9Cfsv6vPD3En+EcmOVXz/9wFs5WTomPln8ZcxIhFzV+s9yirClHq//
   9tfbjvLeZRdUE8L6zOMDEoTMAmTIHNFVMU8E+lvk3jvia84o7eZAVHUId
   QpLER6wnHbtJf8HXXvML9erjjYO+e90fDQ/wTuP3TzzyvHCyXn9TCBL+y
   UmqIBcNHSNsflsqdj4Vzye8xHa+pRr+WGt9udqHpqKR+m3PbMyViA9XYx
   NHAcPnGW0csSzQOKNF8Gsatlw6uoa6rbjlLKyrZbizIrFSP85nXqmwxp+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="330594075"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="330594075"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 23:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="794327007"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="794327007"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2023 23:37:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 23:37:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 23:37:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 23:37:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czcbkHSCMbs6IA/VuZFMCIX4NLkyXiYCNThgSdBQghVJonIsLjLKEe9dKvq8Tqx7jNV3x5wFNRVsvIiG3xr2lybPRm1qN/L1GnzBhBaCpVIsO27/01RXQuo2gEJs9wTmE7+khtQ0p2f/WbYnBVdDlh9hj5VHDQD7lRz6Rr3fua6GPVTekec0X/zRSMogkbkVu2kbnvWLYW6NNOGRvYvtEgVisIL7xfxirXkCo3Y7gLiocZyCEcBwYSUo+vJVcDxshWH/c6tM9s9sqSZH7Xt3JPn6C79WMN2nyM2FH1lEn8LI0VpyGNy7qpHlpft/Gsf5FXG1mTg5Y3E/M5SVrY11JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdhWWb0rsDB2XLkzYbsrpHbgnt5eLdRi9eLMdKlC/5M=;
 b=VtlHQRyxgQBn0ZnBWXfb93pWv3shcEIbt9/bRVH2wv68lzsqfkV3jsnBQW+/Yp7MDl9w6k95R0lFjR7QaGD0FcPVN8SSWSQg7/iFajpOTtZvO2c+lHk/7wR4/8ZAZ6FXlGHFgDlhhdYmD8Tt124smauNzWmaaNli8odL4vrfPh7B4lz59Uoz5xnkei7eJFEyy3vMaiMIdFTJxpvdFbhLZG+4gIbG1oUaQQh3R7mvSIrvo+9DkLIP6nibdjrBr5GjoHI+pBf45S4EKc7/qBxbxurXv37cZmVDuytNuiY+6ER374DamvIi0sIFzT+eAgEvm/TNyT34fml3cwFq3GhmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by IA1PR11MB7246.namprd11.prod.outlook.com (2603:10b6:208:42e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 07:37:31 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 07:37:31 +0000
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
Thread-Index: AQHZP1HqpZLwLlRt00ml9e7fRXtKOq7MO6AAgAG4EjCAACxFgIAAM1HwgADNUYCAA4fWgIAACvWAgAANv1A=
Date:   Fri, 17 Feb 2023 07:37:31 +0000
Message-ID: <DM6PR11MB4316365C6A210BC728B5C4948DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213034202.2926-1-hdanton@sina.com>
 <20230214083533.3410-1-hdanton@sina.com>
 <20230214235405.3587-1-hdanton@sina.com>
 <20230217062815.1682-1-hdanton@sina.com>
In-Reply-To: <20230217062815.1682-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|IA1PR11MB7246:EE_
x-ms-office365-filtering-correlation-id: 5e4ba3b5-8695-4d83-dbcf-08db10b9d3e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7O1pXmhWGJhtycymEaozpPzqzaFwFQapimDChAvEXGvn0DeA0ruQDk8B2DMEDwLKGMDxG2/QA3wMmZfWaQ87RqXyt6N7g+aQd18F7GH0PZ7zoSG7LzdY1rtyEwKL4aRGELukJb3CvW4S1S2meR5bU3chKFjDaFxo3FhTRujmCwLlzIffo56wQw1O0cxrNPp8A7UXDs499wdu2paIy7QRtdKlkhg1WsuCZTMjalWdwqo9oSUjU36AbGQJx6OKQwEUswm4Th/fmEa4MvyyD0A9odiHqDWiNhNhOU4pElLnnHxUoXG+0sjZ1uOY0CoevUO8Krz08OOz+hp50YcKjokdANXHX8/vvf2nYWTMilhqCgI716hkuQ6KjIXxZCEHoZaKmWdNbKHaYyRnFq1SJRcjhtGQTnYJJCw7Y+142WQwh21RDEGhIGYtvcuAHT7BiYwizt3jjS1D7YCN+0a6NEi2EVg06swFuLNCn3b1tl809s8hEtDMVApHJPNQ7B4Nlf01mTyvkz/uIczcsaL9TILVBxTJLxhC2WS7UtKA43yoLvJTpFLpxkS47OOmmZdEbkd8LjDpC0awJVY3p7xTyOS1XmU1BuSqTnMly4dvxrTiWTDIoDF77BZnFqRbb3WvAHuaS358aBPwTD32tgeIl4Xe2BKwfMWyZ07mYuRUHW5B3EPbMpUyRhsk9AgR9bn0Ycf6LgkTkDqWQ9ouQWNoK6yEJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(55016003)(83380400001)(86362001)(2906002)(478600001)(33656002)(7696005)(71200400001)(6506007)(26005)(9686003)(186003)(122000001)(38070700005)(38100700002)(82960400001)(5660300002)(52536014)(41300700001)(4326008)(6916009)(66476007)(8936002)(64756008)(66446008)(76116006)(66946007)(8676002)(66556008)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?db8dEevQqCp+wqlrOJ+eO0cmCwo2LrTl2+1xioo5xhuveAsrgLiC1Z45EH+T?=
 =?us-ascii?Q?LCRC2enntn4nwikkaVIuOal2ilytdt8h1fxAlofCuVc6FY75Dm35MKqDJrkr?=
 =?us-ascii?Q?Y3psZPE4PhBOztFlPjltwc67QmmCJQNIWHfKU0wSC2AQL0wBUidm1mdo2h3F?=
 =?us-ascii?Q?4ZQR90Zka4lWsGBMSYBe1xFEcyNsQb0Uw686KFIO8sxZzQTYsIXNmo1Q0oTj?=
 =?us-ascii?Q?HwKrnD6xvpfhmlmm3PsQRr08hymdo5eTVupfTEay4qAcazi2Wlj9wPv+qo42?=
 =?us-ascii?Q?KRxSnOA1Tok248TBogcEcfmD1gu/Ral3Fd96dRmm0/9okp4YLT/iMCdz3gXK?=
 =?us-ascii?Q?H/LKIGdtm5FjSJZvWbp+zWaP/C3V2DAafEJysiQoSrAdMoFyZUzoG7t18hTh?=
 =?us-ascii?Q?sLVg9R49fPncNdPMS2bTfAtCzdC5nFLG3f7meKBkiczJycgmTythhZDy1J3z?=
 =?us-ascii?Q?9vv0BFoNWYVxvlL4YDgRHwwoQbQvDZyRQlIJi/UGPJD5dznR+eNajfFg7fEZ?=
 =?us-ascii?Q?zujuWAs05HmJ8mAhqEkIlJ5C+SbzqTHwxcKWDmsItwaGTfGlC3pNwiPAgBwQ?=
 =?us-ascii?Q?pOXoyfm2HVdq4uiFK/1n9jYpVWM5J+mwrtAjwoDUQyDJ+pB+OpCffPNeZYe4?=
 =?us-ascii?Q?4W2hAv8VjdEc2k3RNLsP/82eOdNE/lBn+qR/ppKFRTxGnfq2RyC8NIHBgfEE?=
 =?us-ascii?Q?VblnoXZLmlhuhu2x2hnRcnlKBSPBsPne5Eucp+23k4BdoPP3kEzDqzTrxnUp?=
 =?us-ascii?Q?fSDHGFfo9gRFWq7dcgkBPYuIxwvfFPWEi3xxGuh4t45J1c4soQPrXnc1OuS2?=
 =?us-ascii?Q?LPOPgx17kSMEo9EWVVgl1fYPcuF7Pf2QctjW0TsAfiuNWj+ZumefQPNK3Qif?=
 =?us-ascii?Q?ouMvLe6k5YQQnffX9LAk1o/MN5IvCWNlZzC9nWVPYn9aN6qdo295xlN7hfIO?=
 =?us-ascii?Q?rjy/ukpS34Geu/856UyRyRhTFjTyJeULLfibTe6w9MKFJT8r1hjN4FnNZKm6?=
 =?us-ascii?Q?uzKWG4N0tPTsSjvSnrbqiZlJwmqEV4NkKAI421NmFuyEK5iC8jL+W7yl4TxT?=
 =?us-ascii?Q?XWyuov2x5UsiXkhGcHwnGJHPbJxYYEZlGT+EzSWqglsZLTETsnm65iNPTBq6?=
 =?us-ascii?Q?VHT5+IY1Rha9MlVxPnzKzX8NQ9nGQd8TySojugLEy58A2LB4ug6i+EJQZujT?=
 =?us-ascii?Q?XeMcVcB7NSeRBXi5TJBeu9Dlo4mUHVYKl1P2JBgN8ctztBdIL4Ja0F8+pJqo?=
 =?us-ascii?Q?qlM2s8lN4gawyTWjbpjGImFc2OHfafLX1SpCJ9hNn0d+hNr0Swa5o1FaMCKb?=
 =?us-ascii?Q?CJkzYfkfdqZXHsMf48hV465LzPdU8o2Mhc09sJyVY1tHA46t9jNv9repfCIO?=
 =?us-ascii?Q?LAg0xRypYUXhiH2L6Szoru1rsH0C3ZX5sctK7U8Cu+Sb0/ibffg8VOFGX4kk?=
 =?us-ascii?Q?7a2P8oZZOzNiXyVarSkSGCUjJWbCDrnGhYyxhzsUpU6U/qtDKDa7zNfFxZYk?=
 =?us-ascii?Q?3nK97RhPaO/637o0SFeavqUvDFgLJhMA71NmtsRBLAn1Zfosr6Q5ItntX6ac?=
 =?us-ascii?Q?fJ+JKphRrd8JuJIXSN7vfx67S4zofIDwrnG3acpV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4ba3b5-8695-4d83-dbcf-08db10b9d3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 07:37:31.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx9dydLNLn1fIN4/CoiLjvwTfDwfbTKy22ESYoty+sB9QFq9IypqGQjmUf1bzEAasJFFRX95WqRp3AUlWUa5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7246
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: Friday, February 17, 2023 2:28 PM
>=20
> On Fri, 17 Feb 2023 05:52:38 +0000 Wentong Wu <wentong.wu@intel.com>
> >
> > Thanks, but what do you mean "emulated"?=3D20
> >
> Construct a scenario that ensures wakeup comes late because of no wait fo=
r
> completion. And we can see what will happen with the current test cases.

Thanks, I will remove reinit_completion

>=20
> > static int mei_csi_send(u8 *buf, size_t len)
> > +{
> > +	struct csi_cmd *cmd =3D (struct csi_cmd *)buf;
> > +	int ret;
> > +
> > +	reinit_completion(&csi->cmd_completion);
> > +
> > +	ret =3D mei_cldev_send(csi->cldev, buf, len);
> > +	if (ret < 0)
> > +		goto out;
>=20
> 	return  -ETIMEDOUT;
>=20
> > +
> > +	ret =3D wait_for_completion_killable_timeout(&csi->cmd_completion,
> > +						   CSI_CMD_TIMEOUT);
> > +	if (ret < 0) {
> > +		goto out;
> > +	} else if (!ret) {
> > +		ret =3D -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	/* command response status */
> > +	ret =3D csi->cmd_response.status;
> > +	if (ret) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (csi->cmd_response.cmd_id !=3D cmd->cmd_id)
> > +		ret =3D -EINVAL;
> > +
> > +out:
> > +	return ret;
> > +}
