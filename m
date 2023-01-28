Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CD67F571
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjA1HTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjA1HT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:19:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E97E6E3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674890364; x=1706426364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LWxH/VW2+Lz+1Yq5hCTUsQb1SudnM4pE7CilyGZyicE=;
  b=XhDwWUlA+3TlzCl5B9lwccOezixrh0H+p4dhGmx8okvtN9rOCvkayqBC
   q/53foaZ2D8PCp6wcvh9DyTyeX3QUg3DjTGEOHJEFNGVJ/WEM0n5ZNJA5
   OvqYVRUb4XkV9Fmf6GfdmM+k2LmE3jZ7yB9eSJkAzujlYcyv6g2r+bk4h
   Q7O+iNIblw+/VScmzTow/Cl3lrI7F1TCnC7tzpgXim3lwSbOpNXcG6b0k
   jssHUusQXqTOuzh3M3BYbqGfbgfMV2gejbmYvfxrOKtWlHm13+ZkfBwat
   7c2JWb6A6/azJxnHHmiv+b+1IB+fx2EiL8yS3/7WuJ8pe6NpHx5Fip9hu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="315225532"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="315225532"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="806079741"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="806079741"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2023 23:19:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 23:19:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 23:19:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 23:19:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzg3kPfTGrs4QJB9188uokcna4sp/UoVXKXG5zpLFoS5P45MIaNaH+pWjQArrpJQ2Wpp+5e0TgSRfHEQLlLxKZmEcb1trsvPkbVCB/fJpfWtzsNyRfNQ1NtIsEPhdBYRiB7cIbja/ecJYiRLz7MS7LBpxk4EFI9cqW6l9yIfFSMzaXJ1rbGvVGw8D4L2HyXOs4KYzGEtxZmar8sQP5IU0Oga0zKdCkU+/ogdztZAtBxuWwwBuKfWU0Nx5/uUm3qGdJGTkMD1ercG77vBoTooLLUJbSWMVliHKvJiQSkSNKigFc9r1fX+PAtLOOOPIFT8qSaAJz0Yii8iNHvXOgTa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWxH/VW2+Lz+1Yq5hCTUsQb1SudnM4pE7CilyGZyicE=;
 b=dGi8lqaUSpKaiTAkqs7iMslwaBl4NcKlaqnRfPODlgjfBZdKv5kTfleb/kuGLtMRGN7P35GGx8xVBzV9NVTEOtLYxcZSpEjYoFPhCtx5aQy3D1UgmxUEL6csom5cK3DQsDw3wO18ds9Kiz4mUwNhrK1TItFVCYTUCBcX1VWvyWAy3V8HWmm9mOKUHZ3A22ojk1WTqC4nfu2XxnSXDp7CeJh5RKkimEqz2eJXNBLWfQJ7UxfGC6nrZyxk9ZL0PkMHv6RsQljyWbw3jKHoLAo64GmPLAvf98+Q18YEUWky8ICGSPqriVP8c/lRMPDKUPoSjWFeWE5grM+pDCHQC9Dviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4832.namprd11.prod.outlook.com (2603:10b6:a03:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Sat, 28 Jan
 2023 07:19:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6043.030; Sat, 28 Jan 2023
 07:19:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Set No Execute Enable bit in PASID table
 entry
Thread-Topic: [PATCH 1/1] iommu/vt-d: Set No Execute Enable bit in PASID table
 entry
Thread-Index: AQHZMW1ctbLQ4QKwd0Snbo5JfNawX66zbWnQ
Date:   Sat, 28 Jan 2023 07:19:15 +0000
Message-ID: <BN9PR11MB5276D8D7CF2AD32D605EFD628CCD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230126095438.354205-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230126095438.354205-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4832:EE_
x-ms-office365-filtering-correlation-id: 3a83fb0a-6f61-42f6-26e6-08db00fff65d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zwc5gDoy4MW3msJ2j5v9MEo1nNi321faYzvGs0iN8dKaZSqv5pLpfQFLzuUqcn5HzaB8O9zUsA32NnkQF+TkkHm7G1yZ4skzTN+gKYWJguD9gD/cUVvkzgNE5pj1S0yD7oyKwCJ0OJg42/kye4LY5M+AmABc4DSOhUI0seNUCt1s9l+MezmkpDjSPo4YV00Ips6qKMliYWLPOulI2fViBlt0yNxmpNDFcHyeTlRVa4adVBtI0779tqiJD+hDNIrb2RvF1f0K/ZFf2aAHr0S5FQFmH4WTFQ9DOU3ALZ1r9mdRXvXBulnej5Vopp571Br/ZkayisLk78iU/r3oXXEpd0rCmheBpByhgpmDp70rdrZ94KfmV62gcWQczjcdLswewlV6F7VTlUXET53pGHI/hZfzfV+nHSt2HwI3uW5/sLMHKiyasLW3s4g3dls887UYOcCYspig0fy94g0qkAmBIleU3ToYiH71xTz7BjLjQueoHv0+ZGL90uoonlr0fp+WYwCGuc/69zJS1SFWXFZ5VDDIlA7Zr1n2m76/s6edtxxD9dxjiEZkqzGGxlxSlIehfqzSiSdK1zhLbg1huHZcWVCcMcXGuBt+9OaQLGcy5c/LrgiIWyl6PYEc4FQukNMyaTxcQubdscb5cAEf3RFdHT+CCdmHIrueemBLvUDsDXIckH7I+xinfeNWDhkkNX3cz+Q6UAOah6e7dxtlPuaW1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199018)(478600001)(82960400001)(26005)(9686003)(186003)(76116006)(41300700001)(6506007)(4326008)(66556008)(8936002)(66446008)(66946007)(64756008)(8676002)(66476007)(55016003)(38100700002)(7696005)(316002)(2906002)(122000001)(86362001)(71200400001)(5660300002)(33656002)(110136005)(54906003)(4744005)(52536014)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1F8IJ78HbrrCQKwskrJijaEOJ/s666QONCKooFBxJIMBGJAiZGu8L8CwZUT3?=
 =?us-ascii?Q?g8V804hut/U2pMui0W2j74gTtYasBEYGvVbDHyzevB8y5pitybKCbQpqJWYu?=
 =?us-ascii?Q?4g2sx3/+71R3dKhHxefGF9UE9HsWTHrB77cP4fFHBOYQfLr5Fh5dGOVq0EWi?=
 =?us-ascii?Q?QpqiLRCzcpdO3A8oas0JbDXYTyo4HaolEvqL/+VRNpFmQrRFwwZAstX1IvSg?=
 =?us-ascii?Q?gq4ZZn9qm/ILF2m1VkEf8P52FxpSM1D4r0fzv8iB6JAytSC/AXwDLzU7pE+w?=
 =?us-ascii?Q?hpMKadG+LM3Egg2U6ZqbMx7oZw5TxgvSm9O/8xizKELZKjad4yaLXtaSLHWc?=
 =?us-ascii?Q?+De1Fe2uAZT22alTmEBFqBWVYD3ugX5buUcsVnacGYp9W0PLK/jWfSPbO8O5?=
 =?us-ascii?Q?y1ytwOAPq5qwuq0/LmV99BPdI/ubzJhoLPAo+nT/lLxdUUrMhlYz20sNYFfW?=
 =?us-ascii?Q?x3PtSUoRQxG3p7Dl7VN9S2nJmMPp0jPqq3/b/ljRPjvSpJB7sBiHeebvClWv?=
 =?us-ascii?Q?/JViMXU4EKfUnUbowDxHcQUDNJC1Zcqz7VrcZwZNLqpyvyb30cLdZlUxcvB5?=
 =?us-ascii?Q?WoOM2o2ZABMsSZOfWp8gS4V8Pt9HM3AvgCDTTa+7wzOpI4ejqxVFOzArMPNB?=
 =?us-ascii?Q?grlRKrxCOXhWBKxvG3LbiGwpDR4NsP3F6TjuI4pknBiGFFS7izhbobaKQSl7?=
 =?us-ascii?Q?gX1uXqRgML71jgTdFoR3KNhWcbE6t1INxUunOaUR7Xzz9+1Xl/vnApPJEhez?=
 =?us-ascii?Q?fO/bwR/vdbNusSpWo2NVVIbNdx7+1iWbAgCKfumgjotG860Q1uPuQZclZwYN?=
 =?us-ascii?Q?EvdgPXxHm80fNuUrxJ87Rs/oS1iPu3eB4PhkqwBrKdOQdRl5almj6wONOBei?=
 =?us-ascii?Q?2xZTadzXKhpJhsBRmw95M1QYKlEbX8YB9ep84rZARVixu4aLDj63LdjU98iz?=
 =?us-ascii?Q?tv1OfaC/S6ZShtqILXwWLxhAVemfIfBiihUInIxgxWTDGO4z5PPRRTnR96Iu?=
 =?us-ascii?Q?HUAu/Rg2jyTEWAxVE61DsI5o0X5lmsX8ZL6zxXJ8XnPq//TknRZgkXZdQENk?=
 =?us-ascii?Q?1o2f425q8mloMuquhumR6hx4sIIk1dvNKUP5Ts6be5nvwXkO5k94b2SauKIp?=
 =?us-ascii?Q?l2bGI7eKTXXOhUQ+6XNi5X13Q9A87GX7Cd4q+WwqAFISlf4u34IognIi/mFM?=
 =?us-ascii?Q?byUsxdn+JXZVvH+zgkTeo8I+zunxFUYtHK/ckevaConxi5OnkEgjc/yAf2BI?=
 =?us-ascii?Q?ekasjVJrGio1D83WebM0J1acn4yI5IByXHq7iV610rLbJGCNINV+ro3t4g3A?=
 =?us-ascii?Q?nDaIWPKRPl162vPWJ8Idw8y7mAQ/XkCNP4ehsGgvEp5g3o561Un1xcIJloAw?=
 =?us-ascii?Q?3Ftwbk3GK9yDByjps25vOHoNIY/EyehAj+b4QRcZoY1zZRJXTY1Xc+sWLpPv?=
 =?us-ascii?Q?uSUut4TSl+gk5iUTmoZE7IaJ8wmfQUcqrfStEvRurvr6HcXImrP4l+k4WLgR?=
 =?us-ascii?Q?RZQk0faQewDr2ol9PhFkOW9VX5uFLVCUgw/FSDxw9jM+huYKDM5MKlkn4E3r?=
 =?us-ascii?Q?XVWKewQdJpdgn+rJxZTPSO4LGUlawIpWuAivh04U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a83fb0a-6f61-42f6-26e6-08db00fff65d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 07:19:15.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnMbOgapJy6z0VYm8NSaTVktYmDMLZO7CUDN7wMpZ7AYaHSZvk1Rh8MVRouBdmhx1U8rq99FYMkyVquHDg3HiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4832
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, January 26, 2023 5:55 PM
>=20
> Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
> entry. It is required when XD bit of the first level page table
> entry is about to be set.

"is about to set" sounds like the NXE bit is set conditionally when
certain event happens. But the actual definition of NXE bit is to
allow the use of XD bit of the first level page table.

With the comment fixed:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
