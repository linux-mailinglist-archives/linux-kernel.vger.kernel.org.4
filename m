Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891CA67AAC4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjAYHRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAYHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:17:46 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 23:17:44 PST
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EA30F5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1674631065; x=1706167065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SoFXOwk74qGVAnzbw+c0QNOlYUrBdTqphVVuL2cKF4w=;
  b=SIVrmiKAu3CiFHrUg9i9pglf1AvuDzm0qGZRua4+tuTRFj70PvXqXui8
   5DeSaPHhJHGcsQDc+qXsVupzAlDbq6a4UO4hYC3UUwNXHMWf8vEjPKlGT
   12C/P7+h4HU+K0Rgr/TXO1002rPEE5OOamONfWp368GmLZtFZU7LPlYkt
   ESD8FLfZCOlUNbzyF4SVGVLCXnW7vf1ES6d7FZyvd6rZF9piksy5tjU2z
   rCkLoOgJSpcKjlATJ5YF2o32jQq8vdEwE6qq0vlrIl9MPOl3j8Fsvgehj
   Yz64CUnElwBSXAWUfccehp4tIYuaIVahx26uDDq+cszblXALmLBkmX9Aq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="83151695"
X-IronPort-AV: E=Sophos;i="5.97,244,1669042800"; 
   d="scan'208";a="83151695"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 16:16:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvcVEsUl80JFmU08KzHoxymhee1uG7wJknlzfWtP982PgkbdXcvw82T2OpZIRDdy3irK1RWt8fWfpj6i30mEYIKMinWzpuaT3habiaHZlyYRAC6XxKRrFcf7Y2koLswJHocA++/5iJRx993fVprQNuwybuOwH3ZpoJ/z/NYezNIInnXjKP2bZcXN5oOqqA88f4+O8COvXDSjp4ynEHH4l7J9jIjqHkBjHTCFlSirISLHPq5JvP63jilt+PFLGiIkKMNlmOI9SlfokSxlQml/D87t/pJ31/OeuXTTdJWvqmS5SGf0NAU2T6xNlRoJj3t1fssiMxphRbKtKz0Qh2EfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv0AOio9loSfaR+XoeFDG5bo5k6xVSMu0v5B8GpYBrs=;
 b=IbgpwX1dPwnBjjqAPJpuZCglsTuNZOlO4hB4VmJV7/LmgIl49iVrOKYxx5hbqzycxDeGl6D5xzVRiP6y0PieURK8vey2hz2tk2kNThaPdqrCCbj5f1Ft6icy1uv1RnJnY86RAUEUgHgESdZln/2FLeRVneJzL17Y2YBntqd4ZZlQA7c7jau79fcbfSdkm0ANrSvOX5k4YzoDl6ru9lUNg8WqDkZcPDsbUpbEHKQkhGSGfIzrUz7ogrQ+vnf4iWaXRCNMsg+3w9Z0Uq038vCBXsXotRstHQnXo6s5mvkC1wZiKdVMZZkNwnGQgAQqsWPIfj1FnZblMjHKW3fiCTgF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB5626.jpnprd01.prod.outlook.com (2603:1096:404:8054::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 07:16:23 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2d81:9d85:cd8d:e41a%8]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 07:16:23 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v2 14/18] x86/resctrl: Add helpers for system wide
 mon/alloc capable
Thread-Topic: [PATCH v2 14/18] x86/resctrl: Add helpers for system wide
 mon/alloc capable
Thread-Index: AQHZJ3hcbehw3tinR0SjrmZ2wyVwKK6uyeNA
Date:   Wed, 25 Jan 2023 07:16:23 +0000
Message-ID: <TYAPR01MB6330E95EE56DC59DAA2A8AD28BCE9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-15-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-15-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-01-25T07:12:42Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=132a30a9-f9ba-4b15-9af9-67edc0f1fb79;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: cc35431b3e984e0e913d890a66088515
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYAPR01MB5626:EE_
x-ms-office365-filtering-correlation-id: 828b93b5-2cf6-47dd-1970-08dafea41084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S78+/F4+Tyc6OSqVdtTHgxeebftS4M7ThACizFqbvJLsstTwuARuCqBtukcGlH188kU3hWdyzZqhE/E+S+i0M30sNgtQyRLw4XpuK+1M59WIl2d/pT8zxxk/z4LjDhs62Hl3mK0xVR5qKyHqCVcYFpUiIcNryW2RNo+IFzZjMApKkr5yobM8+LZIh3mQPJ+PfCbqa1GH9B3PHYwxICT1JYZxAsXcOnCQ/BvKYlNKyLRVoxdBuB9mKgMfwk0LUIzEOaPqx14WtzC98o2GwZcPQRDFqY7P4/Y/k8IdIxEE63Hp9+vrlW4tzBWTDgKcqeWGdMCl7Pl1E99vti/inFhYEkrhrMwBDqd9qwuhWadcgw6eiU1ecGlUevc7ucASetwvfdr06irUekXV3tEIHC57E5U3aaFaxZOkccaUKiBQOmdYx5ru2sSRYM71o6eJw8fFa09Y9V/0MHQkixMAs+4sjbjOc3RZHfBcyvFJ1Yuj2oEZngDvmtgbPu2S3YKBbgGNgu/0Vhw0KuAD4xXT5WG8d9pJEJ3T+Jkv5P/A8s06bMW7e5jnp+Qcmr8zxScZ/BEBtsDMtpNiII+ijnRCAew/yhEacZpxU3M60vfvXUIXKAD7sGG25efBE+C9d5D7VwRnlbNpQhoVkY+ZnokXaNQtRdynOwWd3qPX6oZHxKkzMOsEtGRJo9NhaaLo+PKpKxdk8o4yf9fY2E26YQAaJhCLYhTDzv9QROMTZxYTcIlGNLc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(1590799015)(85182001)(86362001)(82960400001)(38070700005)(38100700002)(2906002)(41300700001)(8936002)(5660300002)(1580799012)(186003)(7696005)(26005)(9686003)(71200400001)(8676002)(52536014)(66556008)(54906003)(6506007)(76116006)(316002)(83380400001)(66946007)(64756008)(122000001)(55016003)(66446008)(4326008)(7416002)(478600001)(110136005)(66476007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?M0FFTFBNdlhYeDAxWlBnTGhJTTIvWUlBUVY5bWt5ZU13WkNIZGJWYTBH?=
 =?iso-2022-jp?B?V3pJVW1tT0l2WTUybFQ3MzVqaCtFelR3alFKc3RtZmFYaldCT0VWSXlq?=
 =?iso-2022-jp?B?U2p1b1c3L2hiZTB1MUp3ZkZIVHhiUkcyRE5mWndTY2l3VEJnR3YranNM?=
 =?iso-2022-jp?B?bHZMYmVySkxYOVNwaktob2J2RFVxd2xyREQ1NHZXQjJtWFpUUkVmWE04?=
 =?iso-2022-jp?B?VnRKbmRJWjFmUkk5cTFmMGYxeFV5THZXczJFTFBJcEhrZDUzdUpSellJ?=
 =?iso-2022-jp?B?ZFB0aTBkYUdIUnU3aWdUelhveWtocmNkQW1OQys4NmJIeER0Vk81UFAw?=
 =?iso-2022-jp?B?TVVGWWoyUDFCa0JVRGs1N0M3cE5WOXhqRStYaUU1RUc5Z2swanNiTkhi?=
 =?iso-2022-jp?B?YVdja3VNbTZVQ1JRaWdoTDN1R1ZXc2I0czJQVEhDcFdPVE0wUHdFRnNz?=
 =?iso-2022-jp?B?OXdZY3NTRzVLdjNhekE0TVhjUGloV1ptOHZDRFhvY0s5c2UrT3ZJT0Rm?=
 =?iso-2022-jp?B?bTRZRFcySUo2eks0NmQxUGxWYW1ZeHIyQXo1L1hTRU1JdWxScGtvL3dp?=
 =?iso-2022-jp?B?ZytUelJCbHpFRzNWRWx6enBpK0ttbHNpdkk3TmNORDQ0a2dmam82ampF?=
 =?iso-2022-jp?B?WEtudFJJVVZGUXZKbFc0dHdXYXprVDlYcHd5aEVvZWorZDhRSmFiWUlx?=
 =?iso-2022-jp?B?MkdabFY1TFVGOTVTSEJNaHVJU3l4dVpIWHh3akNFWldaam53WDZwb1Jl?=
 =?iso-2022-jp?B?ZkN3U3MyZU9WWTk2V1dvZnI1TVViVUZhcENyajZMUEI2YU1RRSsvazcy?=
 =?iso-2022-jp?B?SDJmMDJESHErSGZLOGF3KzJNQk9ndjRqN2pEM09ENWZCMmczbmNQbk01?=
 =?iso-2022-jp?B?OEkyZlFvRDA5UVBldGgxdGo2MVg1WjF2bWNiSmY1c01KOWFNQjVwbkJW?=
 =?iso-2022-jp?B?Z21IdEswQ2YrNG5ON0N5RjFFc0ZxeUJHQnJ1Vm9hVXlaKzBUNjV6UmhW?=
 =?iso-2022-jp?B?d0NQSHNpSTlaTEJ6SWR6bzhWc0V6WGgyWkxsTk1YeHliQmpqRU96dzB0?=
 =?iso-2022-jp?B?SFZNSnlySjl0WXFndXB6S20yVzBiTGxFblEwRXdJMHE3MWlmaUIyT1Aw?=
 =?iso-2022-jp?B?ZERPUFBqRTkydWVGeVBpUnJsL282MCtyUlgxalkwdnN2ZTdwYzRYUEZk?=
 =?iso-2022-jp?B?T1dWa1Z4QTNrdG9WWVFSS21tZkZYVURrSEROWGtxZmlqVTcxKzJCOXBm?=
 =?iso-2022-jp?B?YTFCNVFPMXExVks5ay9QcUluY3dUUlJjbVZOa2VqS2xEU2hWdERndDZG?=
 =?iso-2022-jp?B?bjhwQWtBbkllZW5zdkRzWWRMRTFHNVk2Qjhkd2FlbG9kK0F6am9nZjBU?=
 =?iso-2022-jp?B?UUN6WjR4dGZteFNFQld6c2Nhb0hkRjNabUk4SFN0STJWTitQU1gwWllo?=
 =?iso-2022-jp?B?NW5JdEdveUhPVDhXTlRYdDhuWDZlbHByeEgvNkljTmNUSTk5bTNjZ2Yr?=
 =?iso-2022-jp?B?YkxWVjZmdTVRaVZGRWtleEYvQS93RVY3STBzRjUycHgrY1YxbDhCMm5U?=
 =?iso-2022-jp?B?cGswWnNpRVRNODZrbTRHV2ZXZnhFUHB0TldmZUl5eUxPSVl6TDgydHNk?=
 =?iso-2022-jp?B?L2ZKQ0wzZHhiV1hXTXR1aExHRFU0QTFTTm1wc2JxT3lDWnFsZTdUZGsy?=
 =?iso-2022-jp?B?UXAwUDZweS9Fem03elZpaWNYRnAybWtETzU4eWFjWERCTHBuSXhIZXh0?=
 =?iso-2022-jp?B?RmNycTQ2ZzhOQlZZWk1qVlJjaXBsOWhzcEpxem5lN0tHSzZ2SVI5aU5B?=
 =?iso-2022-jp?B?RUdteHpMTnJPb2ZGNU5BTTV2bHh4YXVCL3ZadHZ3bWMyRE1LeTFnR1Ur?=
 =?iso-2022-jp?B?VjNBcG5sbDRqQURsRXpQTGY1YmNkMkxBN1FvQituSE42VnU5Z0R1Nmgz?=
 =?iso-2022-jp?B?ZkhSQjdkUVUrMGxsd3ZDK21QZTdkdFJnZWNmc1FMTDBLWlRhOE92azgr?=
 =?iso-2022-jp?B?S1RmODNVZ1NxTEhHZEptNXVGK1BQOWlMWVpwQitOSHV4YWZDVmFnTTcr?=
 =?iso-2022-jp?B?QTc5SE9EOGxaeFI4a0NvbmdidWNhYTZhcFdMakJUOUkvUVQxTEowVjc5?=
 =?iso-2022-jp?B?ZW5RMCtoUWo4aWVXU1ZudGlVWGhQNExURWZ3M0lGU29DTWlza1hvTldL?=
 =?iso-2022-jp?B?MjB4MzUxdk9uZHo2Ry8wVVNpZWgrdHpZQ1NNY0ZYV1FOV3JHWkVzbXZU?=
 =?iso-2022-jp?B?RUUvNmJmc0drd0hLWjFBdm8wUW1oTE5lUi9WSUNtdlZPZUJXb2psOUQ4?=
 =?iso-2022-jp?B?WG42R09xRlYzWkY2cEMwVWRZVVcwWjJ5SWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?UjdmZlBJUSt4QTlrdzR6bE5rMVZmR1NmMktFK3lSSWJDWnlqaFpGc2pH?=
 =?iso-2022-jp?B?cjZ0N20rZWxOSjlEb3lBRXh1S0FYOTZsT3JmNHhnVEJDRGJiUGcwVUN3?=
 =?iso-2022-jp?B?VExVdU9vYmZGekkyeUFjQ2xRempONGx3WmF0M1JlVk9iQitwK284WmlH?=
 =?iso-2022-jp?B?a2tmbVRiQm52VjhuOXNhT3MvcjM0L0MxMkl3ZkJLSVBYL09wSlpCSjZ2?=
 =?iso-2022-jp?B?eHIyUUt4ckxrSCtabFc0STVCM0s2L2FnbDJtYVF2K0dVdC8xQzk0KzBx?=
 =?iso-2022-jp?B?RDJ4bWs3NmhQdlQzNm9LL1ZVejhpL1ZtcGJHYVlKZldoaDg0YUdxYlpH?=
 =?iso-2022-jp?B?U053eDFmOXNNZUVDOTZTeWtWeGhEdUNWczFzUkhNbFV6L0svZ0dMMDVL?=
 =?iso-2022-jp?B?c0FuNFptai83M3RMdlRGbGt5Rlo3d1QxdE96aUJvYVlYalNlVllCZitP?=
 =?iso-2022-jp?B?VXhXNVIrdUhsVkdhdGt6cmtKOWQ3Q0Jsc2JSU3N0UytTOGtOdWxxcEZH?=
 =?iso-2022-jp?B?ZGxQeUpzUmxKQjkvWnk5NkZHMStsYXVXY2tzZEoxelpYaHN1dUxFYmdW?=
 =?iso-2022-jp?B?b3dyU0h3SkpSY2F2aVlWNkd1WjRjNW1jZHJqVDFyNDFDOU9rVnp5aXdW?=
 =?iso-2022-jp?B?U3QvWG0vdVZlTS8rdDFlT3p4dEJIdklCMTFQWklEWGlkQnArZ3FVTHI3?=
 =?iso-2022-jp?B?TWNOczJ1QXhyTDRGSmVTeWRJRTIwOGZ6TkJsaEdkbzREQXlNSTcvdFNV?=
 =?iso-2022-jp?B?SDZWOGVtbU9SS2FwbkU5MHlDS3hWMEkrZ092Tlh5RVQvZktPcHJ1VHdR?=
 =?iso-2022-jp?B?dndWbWFONnlpTjMxV0tYVzNXTm00UElaRmVicG16V1ozWjFtK1FJZ0gv?=
 =?iso-2022-jp?B?bXpkcXdGNFlVMnNJcEpUVkE2Z1VDQ3hlVjFuekNnQUdYZ3lIbW1yVENK?=
 =?iso-2022-jp?B?cWQ3UXhWZm41M0tSQThDWHpINVZJWWdNN1pwNWdRQnhXUWRZdHlrOUZQ?=
 =?iso-2022-jp?B?YkQvSTFIVGRqN1FldVdmZHprY2NHRlVZQ29OQk43d01GRk5TNmt2SGQy?=
 =?iso-2022-jp?B?ZEdRU1cySDdlWTkyN2txUlIzMXAxYjRTYnJXek9IbGxuWlEreDA0cXNL?=
 =?iso-2022-jp?B?WjVGY3RlU0JabmdMT2NyWmJYUGhjcnNUTjlqdFBuSnNQdTkvNlcyWlFz?=
 =?iso-2022-jp?B?TTRkZUFLL1Ftc2F0dGRMRUtnWGFjbnYrSWVTQk1wVDlkakZhdFVZRjZv?=
 =?iso-2022-jp?B?WVp3SCtVNExwNWdKQjRHR0NvUGY0SjZKZ2NYWWV6dGhjWDhwZ2phcGgw?=
 =?iso-2022-jp?B?WW1LWG1CekdZNG10YjVHVTUydGlaSmpROEdWNCtLUUR4cjRmalFlVXNH?=
 =?iso-2022-jp?B?cjhGYWplbFRVUUh5RkVzbUhWQVdlSzNqMDhZZENFRTJ2YzNuMlJ4Z2I3?=
 =?iso-2022-jp?B?TWhKMVhCMXVsL1d2clZLekhZY01YblBMaVZ0ZjljN094dzlWTjFuVVQ5?=
 =?iso-2022-jp?B?TG9OWFlDZERlREEwa3JucFl3NjJCWG9Hck1xc2g1THBaVmlXZVBKcyto?=
 =?iso-2022-jp?B?Mng5MWh0NThrR3VCSTgxR0wzOSt6ZWRUN0Z0cFJjcmJiZEZ2bUlqeGVl?=
 =?iso-2022-jp?B?RnZwVVBpRUo5V2EvSkJEa3RDbUpiRmVLT0ZFTHJyQU9Ga2k5cnM1STN1?=
 =?iso-2022-jp?B?Ty9zQ1pOSTVyendhdzZqYmxRaVh1RVIvRzFuMURjaXlGM0M1SFdEZnRP?=
 =?iso-2022-jp?B?Z1drMHhHeDBzV1pBRXpoS05mZW0rUkJsRlhrYUpPMU1PK09kRnF4Qmlj?=
 =?iso-2022-jp?B?My9SVDBPR2FlK3lvUlkvYXFHeHg=?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828b93b5-2cf6-47dd-1970-08dafea41084
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 07:16:23.0905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HPErvT8z7m5r3H/JAPku8jZZa7BOE4ggE+4B8dOsP5Y/Om+QmbGUZLV9J8ri1R4olIuN8owOcogrlsVR69k/2RxA4CZEdLE059Z1sDgNSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5626
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine whether a=
ny
> of the resources support the corresponding features.
> resctrl also uses the static-keys that affect the architecture's context-=
switch
> code to determine the same thing.
>=20
> This forces another architecture to have the same static-keys.
>=20
> As the static-key is enabled based on the capable flag, and none of the
> filesystem uses of these are in the scheduler path, move the capable flag=
s
> behind helpers, and use these in the filesystem code instead of the stati=
c-key.
>=20
> After this change, only the architecture code manages and uses the static=
-keys
> to ensure __resctrl_sched_in() does not need runtime checks.
>=20
> This avoids multiple architectures having to define the same static-keys.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
>=20
> ---
> Changes since v1:
>  * Added missing conversion in mkdir_rdt_prepare_rmid_free()
> ---
>  arch/x86/include/asm/resctrl.h            | 13 +++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 34 +++++++++++------------
>  5 files changed, 35 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 5b5ae6d8a343..3364d640f791 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -38,10 +38,18 @@ struct resctrl_pqr_state {
>=20
>  DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>=20
> +extern bool rdt_alloc_capable;
> +extern bool rdt_mon_capable;
> +
>  DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>=20
> +static inline bool resctrl_arch_alloc_capable(void) {
> +	return rdt_alloc_capable;
> +}
> +
>  static inline void resctrl_arch_enable_alloc(void)  {
>  	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> @@ -54,6 +62,11 @@ static inline void resctrl_arch_disable_alloc(void)
>  	static_branch_dec_cpuslocked(&rdt_enable_key);
>  }
>=20
> +static inline bool resctrl_arch_mon_capable(void) {
> +	return rdt_mon_capable;
> +}
> +
>  static inline void resctrl_arch_enable_mon(void)  {
>  	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 3997386cee89..a1bf97adee2e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -88,8 +88,6 @@ struct rmid_read {
>  	int			arch_mon_ctx;
>  };
>=20
> -extern bool rdt_alloc_capable;
> -extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
>  extern struct list_head resctrl_schema_all;  extern bool resctrl_mounted=
; diff
> --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 4ff258b49e9c..1a214bd32ed4 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -795,7 +795,7 @@ void mbm_handle_overflow(struct work_struct *work)
>=20
>  	mutex_lock(&rdtgroup_mutex);
>=20
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		goto out_unlock;
>=20
>  	r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -823,7 +823,7 @@ void mbm_setup_overflow_handler(struct rdt_domain
> *dom, unsigned long delay_ms)
>  	unsigned long delay =3D msecs_to_jiffies(delay_ms);
>  	int cpu;
>=20
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
>=20
>  	cpu =3D cpumask_any(&dom->cpu_mask);
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 3b724a40d3a2..0b4fdb118643 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -567,7 +567,7 @@ static int rdtgroup_locksetup_user_restrict(struct
> rdtgroup *rdtgrp)
>  	if (ret)
>  		goto err_cpus;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
>  		if (ret)
>  			goto err_cpus_list;
> @@ -614,7 +614,7 @@ static int rdtgroup_locksetup_user_restore(struct
> rdtgroup *rdtgrp)
>  	if (ret)
>  		goto err_cpus;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
>  		if (ret)
>  			goto err_cpus_list;
> @@ -762,7 +762,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp) =
 {
>  	int ret;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D alloc_rmid(rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Out of RMIDs\n"); diff --git
> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0e22f8361392..44e6d6fbab25 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -609,13 +609,13 @@ static int __rdtgroup_move_task(struct task_struct
> *tsk,
>=20
>  static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)  =
{
> -	return (rdt_alloc_capable && (r->type =3D=3D RDTCTRL_GROUP) &&
> +	return (resctrl_arch_alloc_capable() && (r->type =3D=3D
> RDTCTRL_GROUP) &&
>  		resctrl_arch_match_closid(t, r->closid));  }
>=20
>  static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)  {
> -	return (rdt_mon_capable && (r->type =3D=3D RDTMON_GROUP) &&
> +	return (resctrl_arch_mon_capable() && (r->type =3D=3D
> RDTMON_GROUP) &&
>  		resctrl_arch_match_rmid(t, r->mon.parent->closid,
>  					r->mon.rmid));
>  }
> @@ -2220,7 +2220,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_schemata_free;
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret =3D mongroup_create_dir(rdtgroup_default.kn,
>  					  &rdtgroup_default, "mon_groups",
>  					  &kn_mongrp);
> @@ -2242,12 +2242,12 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_psl;
>=20
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>  		resctrl_arch_enable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		resctrl_arch_enable_mon();
>=20
> -	if (rdt_alloc_capable || rdt_mon_capable)
> +	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
>  		resctrl_mounted =3D true;
>=20
>  	if (is_mbm_enabled()) {
> @@ -2261,10 +2261,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_psl:
>  	rdt_pseudo_lock_release();
>  out_mondata:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mondata);
>  out_mongrp:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mongrp);
>  out_info:
>  	kernfs_remove(kn_info);
> @@ -2512,9 +2512,9 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>  		resctrl_arch_disable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
>  	resctrl_mounted =3D false;
>  	kernfs_kill_sb(sb);
> @@ -2889,7 +2889,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
> rdtgroup *rdtgrp)  {
>  	int ret;
>=20
> -	if (!rdt_mon_capable)
> +	if (!resctrl_arch_mon_capable())
>  		return 0;
>=20
>  	ret =3D alloc_rmid(rdtgrp->closid);
> @@ -2911,7 +2911,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct
> rdtgroup *rdtgrp)
>=20
>  static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)  {
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		free_rmid(rgrp->closid, rgrp->mon.rmid);  }
>=20
> @@ -3075,7 +3075,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct
> kernfs_node *parent_kn,
>=20
>  	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>=20
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		/*
>  		 * Create an empty mon_groups directory to hold the subset
>  		 * of tasks and cpus to monitor.
> @@ -3130,14 +3130,14 @@ static int rdtgroup_mkdir(struct kernfs_node
> *parent_kn, const char *name,
>  	 * allocation is supported, add a control and monitoring
>  	 * subdirectory
>  	 */
> -	if (rdt_alloc_capable && parent_kn =3D=3D rdtgroup_default.kn)
> +	if (resctrl_arch_alloc_capable() && parent_kn =3D=3D rdtgroup_default.k=
n)
>  		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
>=20
>  	/*
>  	 * If RDT monitoring is supported and the parent directory is a valid
>  	 * "mon_groups" directory, add a monitoring subdirectory.
>  	 */
> -	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
> +	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
>  		return rdtgroup_mkdir_mon(parent_kn, name, mode);
>=20
>  	return -EPERM;
> @@ -3341,7 +3341,7 @@ void resctrl_offline_domain(struct rdt_resource *r,
> struct rdt_domain *d)
>  	 * If resctrl is mounted, remove all the
>  	 * per domain monitor data directories.
>  	 */
> -	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		rmdir_mondata_subdir_allrdtgrp(r, d->id);
>=20
>  	if (is_mbm_enabled())
> @@ -3418,7 +3418,7 @@ int resctrl_online_domain(struct rdt_resource *r,
> struct rdt_domain *d)
>  	if (is_llc_occupancy_enabled())
>  		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>=20
> -	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>=20
>  	return 0;
> --
> 2.30.2

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
