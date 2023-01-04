Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCC65DDBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjADUf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjADUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:35:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76911C924
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672864524; x=1704400524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aW0CdnqVHlnSHDnnxPvLHKNU+4xEoyotrkFsmYWoX5w=;
  b=fSl+6dy3ftdt4ld49ua0xDoO/QneSOE5b3cTa7oBo6hP+Ammw5obbfyq
   qanKq0mbz7KMoqZNkzB2V3UBPh1G2b9iWwk23vfEDjxNvx3E8+v8Czdr1
   YRP0sHWoMgJhCE+qNMi914JaPq48WlTvR6OaWDuQyZGZZYC9qiczqjMTv
   fhqZwhhg2MBbodQVM9gBvV0AbghsQMidsi6KjLC2zOQSl2PMDkYeuhjWL
   fTHKuDvEUz3j0XBwRB2ahskURZT1infhYFvTGL1k7RecUSxdVgX+3MS9s
   zZg2+i12hIk/b2n2rqawjar2RRSKvVrWdlTaI74OYLwyj6ompEJdzcIb6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408288191"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="408288191"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900692892"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="900692892"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2023 12:35:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 12:35:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 12:35:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 12:35:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI/S7Rw44XzIANXIcZAXR4Mz729lkW46Z+KAxvir4wM53/qT8ZV9u8tnLgr5JeXO+MYqQLwc3Op/XI1Ya48l7xIpEZjuEPpDMH1gWWOAYnXvLRhqpAcO0gfA3YpC/CI6X+dsHg6GPf5pTl2gctqs6CasJYc5TsVBwXPjsu4GgobJJwuXyuL3b0itG4wmNsjWmZJFn1JO1J2oC4QZ8Y/+vZAHyHi/fn7zcsOM8ALPzddaI7J7bP9PxTXASQZbAxE+CxcN5P+V5aVi5omhfSk1rxHr7+AaF/0NGXJwlnEtlrsIYSXzbQjcb/F5I5i6QORWUU6Owcx7+dK95CdGGQbwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHn6aaBlGUueB17iaNHSVgk2U7wIW7/KED0sNyOMB6Y=;
 b=GY0f9gVtHa/HY0nHlPRP3sgPgT9U99zeW0YWHT06qeb6f3wYAWBdcCRvWkt1Vqha43JqhD3n0FGtaUz1AZtP5Y/3zknxGBMxLb6Ot9HmuxbMypU5hHrcWm4jv8DdSTLZyAMKC7Muxs9tmKvlJ9EL0OiT75Z/FcOSrc0EBw079VCfdrkkogUf1Cl6BuMoHZWwe9IWIC3r2nv4nus9k8Uw0J6/tFDpEgENaW/JeyF6K52V7eEj26MmX4RV60+ImW3Q7nTc92HchMgQauJK4ZuQbDP1LqRxjSQWDe4LWqjMsT2EuYnNsX/ugVuIq9YWaw7OKTLRmliZdyY7p8wd7OcTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5353.namprd11.prod.outlook.com (2603:10b6:408:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:35:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 20:35:06 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Du, Fan" <fan.du@intel.com>
Subject: RE: [PATCH] x86/mce: Mask out non-address bits from machine check
 bank
Thread-Topic: [PATCH] x86/mce: Mask out non-address bits from machine check
 bank
Thread-Index: AQHZH8OLupGeyRaqakOWIhG1CMkdka6OtYYAgAACq5A=
Date:   Wed, 4 Jan 2023 20:35:06 +0000
Message-ID: <SJ1PR11MB608316C5959B4858110D4550FCF59@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230103223416.310026-1-tony.luck@intel.com>
 <Y7XgdFOEfHei9xEK@yaz-fattaah>
In-Reply-To: <Y7XgdFOEfHei9xEK@yaz-fattaah>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5353:EE_
x-ms-office365-filtering-correlation-id: 376e1075-ff20-4ebc-ef21-08daee932a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ivAROepxgBdydsMnQrxzLGLOE1Nryiz847cmAe9eIaWs4KNYb9H+xTvl67T69q0ZGHg9jAxWaLjnkxT9CZRfFVHW+maLoNcqs+jyt9QsVpOTU4wpT/pQiQLRH8JMTZbfpo2n45XIEYYMQ+0QluZoGENckSHcoQ/4/doLmYET+r0OyhZPkuJi/6pv9HuTeUTM8cxOFdPCmPdPctrXr/BBr7H1ktpMB2X/4SPLDoy53OOBBITUvMPPB2Y+3m/8RFL2uFWUExO3MRdOoQ0vXKmuNULrAR8Tc5Cvzv4S4pyMN6CbBpuzpgR9kPpELylzREeZ5hFraRNlcyqaP2l01SZ7LsUCnuF82US5yA3SkdoLali1pjPvLRq790XCrcJ3SP4qQ3hd6gqqVcJxAiSIot6oyY7/UjSNbPjXVhfACoSFp43WKhK39Ly8gZeG4OVTweYLEB6eCR5vuu5KiIoLVs7KQC66XBCxU3OSYAMaKFwjICzarvIeahsDyOhp9UOdHQ3cyN2De6sy6Y2bIwA3csLIUHA6ZEjpaubWatXLNMHT86o1uhgCbsNa19hZ1e7N+qeaREmO09dyK/xSPJC2+/IlJ68LMzQPW1PU77c4zQXiprRcW1108jMZNEToXIjrQF33Kgb+kmphqeW0T5STT0oVtmOqZ0cB1g3leFoRCXk9jN1+3BCNC37Kd+bQUasLD1mbyWPYv/07EfAJDrIr4x65UgqXfuHUEbKONzOMI8ROIeo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(186003)(26005)(33656002)(9686003)(7696005)(6506007)(107886003)(55016003)(558084003)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(41300700001)(4326008)(8676002)(2906002)(5660300002)(8936002)(52536014)(71200400001)(316002)(66556008)(478600001)(76116006)(66946007)(66476007)(6916009)(66446008)(54906003)(64756008)(171953004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U7pEbBttDhxPmh1UoGW349MTc3tzhXopj/hstMbhQcy3qCOTMpk9JX30okZF?=
 =?us-ascii?Q?mOZPbZqAmhRou3+3iRPTnDtmqoo57skOmQNchm3BPUtOZsSOj2LFhJb3JwiB?=
 =?us-ascii?Q?I12WDg+JOQewjkY8aOGB+O2joqq4m2fVfGwC612WjMxTMEDlt6WztBrUwqe6?=
 =?us-ascii?Q?Vq98jU4QXVheUnDKH176tPQ2p94Mp+TkVZw8WK6PlEYlE7s9oon58MpYxGH4?=
 =?us-ascii?Q?ulfxeyZGbqQ/xBYUfB+eh/+2F840AVYxyNj3nszxWsA7hsKgmPjX/lQfcH0w?=
 =?us-ascii?Q?H/2G4qxExCW3JRS+jsuTeDdxaO67+QjlqI1WQv9c135QgrIYCAt7yhr3NlrZ?=
 =?us-ascii?Q?3j9qr/t1kypRfiVjpVsyqd5XUPYXYGSWXaay49ENjnBsHe2AxqmAKIP+kysV?=
 =?us-ascii?Q?zcsI/laG0QNwve4VyRAdQYCkwSomst7pnQ8zL24Ip5V+cgh1oiz8SZUjbqoH?=
 =?us-ascii?Q?2XdZPRRrjyECyYtJHbqoj7U+X5KSmPNqKNHG82iYQqFkdJjy0RA0iMUYozp9?=
 =?us-ascii?Q?+c4eUHxR3nO/koYTfdsi5qANSSWmcM12Exbo5upWSaSs+f6WUxZJknPnlR5q?=
 =?us-ascii?Q?gy2MykhdftbjaX6Bm8hROlpdxdMBecrJ2XcjOkWB1wEU9bgqodg4jcBLtvW3?=
 =?us-ascii?Q?bhpzG7vRp23yto5ftgxx0DMcrg9K4YhFkNxLcXxrWkYh1jpVzpt3OL2KmViL?=
 =?us-ascii?Q?ECJmq4sR+3WEy/mtG/XMD2SbOLhjqktgV3yg9JtboPTeDAHlOSWzub+VFQkN?=
 =?us-ascii?Q?TiZVHZ1yLL1obr8IILkGRvM1krvwfErobwvB1RnjZRieY8Lm80g7YACFJuAt?=
 =?us-ascii?Q?CSJmgjvGt1kyj8vNZVN0NlQf3jUCt0C+8nVWb/NNmcnEt10YYmXL7ZLtA7GX?=
 =?us-ascii?Q?w+ZAyLR682x48FerJqMCZKY5HcjdC05+GOB/dfFfEGSS/A/5Bhj51ARMfwKm?=
 =?us-ascii?Q?b7ZVRn3iqySrTbTQFp0/nxCiTNQF3DzFFJE9ZboOgYjQ3A+RyHBr0svlelDX?=
 =?us-ascii?Q?kVk4UV55aGqbnuNaQP+kSUFkCXZxgTtm6SxNvgGDpohwaljE1oos5DdPNCCx?=
 =?us-ascii?Q?W6blwlcn5kwADq0Vbk7BofbZ+3EckI7YChlWdb36jiQxBxSnuabGrESALW7y?=
 =?us-ascii?Q?aukL/Q802I/9oxxZXKYS//cYbMuiibJWk3j5FVyqENpziEDOsakrZdqWPTDA?=
 =?us-ascii?Q?EbycV4/F3Fg/RQrFtj7mtpBm96FWAUr4lqt7mrHcMZZqur4Jop/JrOBmKlHO?=
 =?us-ascii?Q?PO1rL8JPZyI4jP1iOyExhoUen/hFo2L62n9YNdmQMP3bdjUx3Pxm2fs28Ywk?=
 =?us-ascii?Q?CC5OtVIHYSMIn2a/W+ySTuc2WbkQjiD0pjniy/a1sG67BBWwdXA2P9LNU+L6?=
 =?us-ascii?Q?cmTmJmj/rxyc2ckzZrTeCOPR20VkXU3HGKMazQzFtOZqdPK9WxLEg+N/QdRb?=
 =?us-ascii?Q?Yyvl1sOi+oILLQ8hTHMN3UUdEozklBBOUTH8fXp3KeYrAGDtprpk2kNjYxFz?=
 =?us-ascii?Q?L12Gccqc4Ng3GUIqnOjGDFxdLrVFq2IgZnSogovsXy/tLjCL/Dt2Ztqym3xP?=
 =?us-ascii?Q?2l5PIZe+SFfJPDvGP6lJNOfPuFtFirZ6retxr1Ss?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376e1075-ff20-4ebc-ef21-08daee932a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 20:35:06.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hP80w/WP4ZHlBUPNRXfXVGGUuvCTZfxo5bXJN+iGacm7TZNHY+gLheHbX/0UQFRzlcUvXkgmv9Pb3Ke4DkSAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +/* MCi_ADDR register defines */
>> +#define MCI_ADDR_PHYSADDR	GENMASK(boot_cpu_data.x86_phys_bits - 1, 0)
>
> Should this use GENMASK_ULL in case we're running in 32-bit mode?

Indeed it should! Thanks for the catch.  Also for the review.

-Tony
