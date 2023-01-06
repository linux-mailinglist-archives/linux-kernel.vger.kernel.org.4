Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DB465F9F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAFDK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjAFDKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:10:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A760CCC;
        Thu,  5 Jan 2023 19:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672974622; x=1704510622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kV7eArmMPsusuSCoIzs5ZIpDhWl24zcoGyh1+4ZPNw=;
  b=Su6aUH/Hoa8vR9iwRJ3TFbbOCCxT7Bc07cCQxOIDAjhwDVLeX/pGjx25
   I8TL4JTRBftKY03M+S2nnkMOQ5h+s47fN9afjRNFBhmExox7QcTrwCgDC
   XTZO8WEfOd0wrcMLj8bHfyRExPROZRIbzidjMUUb44A5dt5R1JIZLW1zW
   qohy0AZ+cDA/ZC8mhcxPIlqaipV9oHwk0x9i/IAAqd9w/63gfbOOPPzNX
   kJEleLky/VAvQuVhWAnN+pcPdnM1NgqMisfSB33rR+cvC3688ylJpAPHf
   o5J1eQJjvTYbkHe2FJyII2Z/vBKllGQSG8EKai593u8C0av9fMmlTbH24
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323641863"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="323641863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 19:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="649193139"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="649193139"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2023 19:10:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 19:10:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 19:10:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 19:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E77MZ7mxMX22gC1r6Yr+Qi7w0iuX1FFFLgccUXfGSJOezsz/iBlJ5QWO95RkSZKfHa0WTZvjR9cOa6MWZhe3KsCF6Y+rmaR5RFjOZkmjz/HcQymsZgtVwlGk37go3zm264tpq2IKDcz4xbwXAkH+9KUtkoca/7kj+rMxSUkWcLXAJbshB6lDXgwnCoqlT0HiK5M8UNGKNFLU1lLBZ7J/v/Bi+YccjbTD6nMFMey+VPiyo4di85uzhhKHrjmyunlkn5yYEUCozvl7Yhd6hM+XNuwYpWkOQGioJR+T48v6p6mNVPan23DYVKtVPWI/3a0SxkzeF6J6I/swFbKwZVV2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaKXDZiFxICr2Z+v3aHjubOGzE2qsBZSbOM2UyvJ8dM=;
 b=h+u6T8oe9//E4TjWxfLd24lOoWTw02ACwCPeFszMHRM15E99ZEDEmpwnalTIxbVSKMMsQsNe7Kwkk3Z5pgRk/EnYZajk52+FriTRXJkbhBV+K2rLEneMqXZr9jm4rNgSabRkbE7voJQqVfHBr1kmJEiYRQtoDn9paKjMccjphb4UfeFOdsS48hBkJDMzhVxEBlnQ8xdFwhqrwnevLx7s+0953cjKcCEmQ+2SvwWxKWfPRKatd6ZKrPA+6eseAv/wNTgihwjXOVSfFf+iHk4qJ5woCpKhdvGvgdWs4CkoF9g4lSVDdIrhQQTu6DOgM7ieHwVDp+tjni7NLVGHGuuUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5560.namprd11.prod.outlook.com (2603:10b6:408:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:10:13 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:10:12 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Safe access to rcu_node structure's->exp_tasks
Thread-Topic: [PATCH] rcu: Safe access to rcu_node structure's->exp_tasks
Thread-Index: AQHZF1d1vL7vqzT7Rk6Qh2aIcidsQa6QyRzw
Date:   Fri, 6 Jan 2023 03:10:12 +0000
Message-ID: <PH0PR11MB58801E84B4601F207B02377FDAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221224052553.263199-1-qiang1.zhang@intel.com>
In-Reply-To: <20221224052553.263199-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BN9PR11MB5560:EE_
x-ms-office365-filtering-correlation-id: abc0313b-cc16-4a99-8449-08daef9386b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Badsrh85/eFj0KEE/ZvFABKay7Fmk+feLF6yAbam5IJRcyXtQ5ybchwc/uzHG4hfDd36S4IMl5DHQTPONpMRnoNeJ1hledB/wDEgpjyL2hshvweQqYR211/D2E6vc4rAxtyXROhz7Pzgk1KjxA9kwdHZZtUMAtBMGqX+3OqWLLSgGwrVvZW48QVtsWLxDWQap3bBAxcPAV8u342H/67q5QOJTU6P5ty6LdOTvgTff9s9cQL1TxBjjVSfOGqKix411dlff9aMEdDxU7eKVqyRvv14iFd2hUuVgm1T+yiLS9DQCYM5WQFPE766eeftlu8GaWdfsFpGub3rKiqKGFB1lFQMBKmUL5QKBJ39FEu2U9AMs3SMd4mQF16oAxu6+6VozV2PMfOghDrnMVYCs+c5bJahs+V59vy80h8yUVzWnOPek4xME256OjMdduAd9FVLBn3HLj/OB0L9JcwXSBjnAelYDZNQ/AaASpODE/HqzyoTBeG/JxPd4ljEuaFw7s+kxUBY4BpjVeU9IlO77A6jcLlY8AmbFBxdpUBf2TmwytIPD6eRauJwhKSG8A42O0RAfMpiq3ZZP2o797DM5cfyD8SxQLRjrzA+et2Qx8z8Sh9RruhSvS2rEgNt5oXQV6DUiHBt6V+WoZ9Hxu9lzCCDnQIxMJwkFqwKFSRp5SAk4L61K3SKicEuV78yfGXBtwGnucLlrWdj4DdeGl5foKECXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(41300700001)(4326008)(110136005)(33656002)(316002)(66946007)(8676002)(66556008)(66446008)(76116006)(64756008)(66476007)(38070700005)(86362001)(122000001)(38100700002)(5660300002)(83380400001)(8936002)(82960400001)(55016003)(52536014)(54906003)(478600001)(2906002)(9686003)(26005)(186003)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ECiOgJhJzew02c51fG9emV/TR2kRSDZcj0iS1x3U6CKJNeDuKOOe37Ti/jT?=
 =?us-ascii?Q?UowozRT4aakoqpCK3oVK2Bi9Hi+5RY8YLniLPhqhevOqQzyMVqePbDJEZINb?=
 =?us-ascii?Q?DtF75UTLHDOHKO7ScVgpqrR2U/xwL9B7jOXdU9yIY28+FSA4Dmfz1qPh6m4Q?=
 =?us-ascii?Q?d71RcUnjicXtatRdd7iz30ZWmkiEACtqbUhcNl2cJ1yc0wzXO2QNDWyTagMd?=
 =?us-ascii?Q?KjGVpl4pFS7EqJUnTIXtbpwDkXhmPbbjwX5c2t7jdvhP+KQe8wG20FcH0mlK?=
 =?us-ascii?Q?jMf7hF4KGWj63e9qfbAaoAXBA3gTz6RwTHtDDk9Y3g/qdNLaRFL+87IUsG09?=
 =?us-ascii?Q?b8NK8PKjnFwCXLQ80SvqZEBjLhKiHyz0bQEsgCEgjiknn1mLdll7/De3nBNQ?=
 =?us-ascii?Q?L95vawD+UBQBsjHNeFuPo8BhtRemn45TLCyYTshYXSN+9GK+UqJ50P+pGsDv?=
 =?us-ascii?Q?bbrC+sTOj3Tb7hZhsqkPTCfA7kxHb2+NG4T9qSw67L6m8HhViad4dNdUlBkE?=
 =?us-ascii?Q?cF6C+3mFJwJnWp9aGo0QAnFkWFx4W2C+/hbP46BoT/4RYm/716pA9G+9VJO4?=
 =?us-ascii?Q?N4BYrn87OBTXmGCMK/RovjHfBtn3FfA0QAgdOsyppK9XB4D5ycYE8CPEmFn+?=
 =?us-ascii?Q?lTeLEeOWz0Cs9D9WBcP2uPhE6lHFLnUm9ySBo/MWMsF3DutI68AW03j24yut?=
 =?us-ascii?Q?yBnxiNTNWdPmpl9FT/Z2rRkqNdLGj09ejpd1S+oCg77SiZ4foP7s76KjSwqU?=
 =?us-ascii?Q?hXLTmaw4mqHkQuqD32P2Emy03Q/ow1iR3T9uYTlOrcmhHKc2WH0p++NNmUAL?=
 =?us-ascii?Q?y18mNUmYWyUnSjLkXpuRoU/2xhPSS09GMJMhW7iRhXZiRKSaeVXyy4aThlEn?=
 =?us-ascii?Q?PGTfeTNhBgb78Kh9Mq1E/JOzyl1mZBLRxZj8eYKbNze4c1uwEyEgkugagjBk?=
 =?us-ascii?Q?24ItP2dxff5xmIlDWReHymrecPGoUrUQ0DN4cTC/z+5ORicGBtsZlJo2kaRc?=
 =?us-ascii?Q?LG1R090MqUdfq4EirXzNRud8wmbUCvxKobuMOjAnjRj4TaZgMgFff3g14jl1?=
 =?us-ascii?Q?7QujaGwI/VacO606gGwwkEgFmTZt3gG22aRVac4FH9ooxErq3T/30jrgNMsT?=
 =?us-ascii?Q?ScGprRkEdP3rRmUw4rMT3QgOcx3tXaiDnuJvCPWuAlAqKNEMNVKICEdxo/ud?=
 =?us-ascii?Q?i+6dp6DQJz2gkg9JcX0rR+nZOD7KCHf0ZTcaRFpuUEIIUhZ5oQz1fGXIR7pO?=
 =?us-ascii?Q?8aCZmOY3TtK7SY3xaMzrYO/Btik/geiVulZrvpYtuMHY0MdvFSvpfSpPD2ht?=
 =?us-ascii?Q?80dOfUE2hHqytlEsxHQHti7OzPNOHEDvl5Y7X6WtpWeWr0qbpYAwJT/wDwI9?=
 =?us-ascii?Q?R1f1ZBO4QICu+4yDC9T6I6k8/+eNGF6tkYvWKoy2a10ZqDqoNya7iaHD8y55?=
 =?us-ascii?Q?3cPCuEaKL5q371bgxUjXNhTjAAkCVEjQWyQ16jLe66yTjnn4f4zQrixIVGY0?=
 =?us-ascii?Q?c1Gs0wWzzwB+bj4Sv6TORcXw4N/V9/v1tf3tP2+C/G4Nb99KO0X4sHLpQOOS?=
 =?us-ascii?Q?oP7s8bk4spd0wBThYRNMfU40Foscp/DPsge8fG3w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc0313b-cc16-4a99-8449-08daef9386b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 03:10:12.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+G9095mjd5DCA9jhNH13Qf9xrl/uvC5/YsESgKqw3RDUOMZlmCXLcbYC23GjEnBlbSOmWiyT9Qj/+VdgvpWaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
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

>For kernels built with CONFIG_PREEMPT_RCU=3Dy, the following scenario
>can result system oops.
>
>           CPU1                                           CPU2
>rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
>  if (special.b.blocked)                            READ_ONCE(rnp->exp_tas=
ks) !=3D NULL
>    raw_spin_lock_rcu_node
>    np =3D rcu_next_node_entry(t, rnp)
>    if (&t->rcu_node_entry =3D=3D rnp->exp_tasks)
>      WRITE_ONCE(rnp->exp_tasks, np)
>      ....
>      raw_spin_unlock_irqrestore_rcu_node
>                                                    raw_spin_lock_irqsave_=
rcu_node
>                                                    t =3D list_entry(rnp->=
exp_tasks->prev,
>                                                        struct task_struct=
, rcu_node_entry)
>                                                    (if rnp->exp_tasks is =
NULL
>                                                       will trigger oops)
>
>This problem is that CPU2 accesses rcu_node structure's->exp_tasks
>without holding the rcu_node structure's ->lock and CPU2 did not
>observe CPU1's change to rcu_node structure's->exp_tasks in time,
>if rcu_node structure's->exp_tasks is set null pointer by CPU1, after
>that CPU2 accesses members of rcu_node structure's->exp_tasks will
>trigger oops.
>
>This commit therefore allows rcu_node structure's->exp_tasks to be
>accessed while holding rcu_node structure's ->lock.
>
>Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>


Hi Paul,  some suggestions for this modification?

Thanks
Zqiang



>---
> kernel/rcu/tree_exp.h | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>index 7cc4856da081..902e7c8709c7 100644
>--- a/kernel/rcu/tree_exp.h
>+++ b/kernel/rcu/tree_exp.h
>@@ -803,9 +803,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *=
rnp)
> 	int ndetected =3D 0;
> 	struct task_struct *t;
>=20
>-	if (!READ_ONCE(rnp->exp_tasks))
>-		return 0;
> 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>+	if (!READ_ONCE(rnp->exp_tasks)) {
>+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>+		return 0;
>+	}
> 	t =3D list_entry(rnp->exp_tasks->prev,
> 		       struct task_struct, rcu_node_entry);
> 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
>--=20
>2.25.1
>
