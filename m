Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7E5B64D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIMBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:00:30 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453027177
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1663030828; x=1694566828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lUm8tTddQdLaTe9qeOfJZKxzkCUwpT8hHo+Ud77B6BA=;
  b=MmEZ67LaxpL9m1NGNQuJiwivY1aZ2glcOHJFBcc2HWjr/5lrGLZ6VHLA
   LBXRm5HYwoAq2kxtBtGs/0wWWx8A0DyYeZvMC8ICK1SkqpWl8t3qNVJL3
   Tdq2KvhJjdX+tm6slxSThaT8HlUpiKT4geSf+0x4y/BfepTA8qLZ4cvJX
   QvUbwyqCN5J9IVpmeEnaZ2ea/71UTdtGMjjKH2OLp602WlRzjhA6AdieR
   KbKTNW/+ErAAGq05DU6U43wEee0hlWDpuWbasmkN/8dPZufw/oycHQdHS
   R/rclCeTphDDn8z9dy+rYx2P1wgxhpFmlFcE6QmUWPL971Qc3oMdDemlz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="72800890"
X-IronPort-AV: E=Sophos;i="5.93,311,1654527600"; 
   d="scan'208";a="72800890"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:00:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQwZ7T9OW/c2GbsBlUQdhCYfVosQwxhYEXwAnMvUdlzM258ZkAXLThASXuQkkMaq4+O+G3x+yo2f2W0p9VOK8XPWqfeAmKEL0QclIKbsGPgX1QjL8hg14EGGfys5g9Xik2FUW/HE28YGcDvIAFnCqiKf+f9Yd2YbRkuimiDKLd4pjLjkztN3P9Z2W1gzfGPUojFkE+wINCQy6ePMeQdM5V7lL1LfBwhLhzrfV5YbSz8vgkp3veDv6J3WdglFJRubQK/1OXUsz0xq6k8yaFJVp/98BFQtGZ2SgRtEbL9qVSkbnOjsDra6EJjinmku6KNCo4iX164kFpQPUx2GxtWkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G76lqW7JZPKTqsYAzjhFQuyuOAxHk7yXyPV8Mu+oxs=;
 b=LMsmwzASSI5NpFXGjLeVAEJbXxCfmvMeK4XpHI9FxvEKDwiBuhRN43K+iy8BvuW8SJ9RqpwfEj/dAae1+xFsqSgS/OGUYHnPlUyApQl7OBEHq7FLo99lytui/AerqylvK8ixuHvomEIv1xABSakXU8zXleqGHxMebcFDqYfP+Ig2w5SSwWIZ5SOnWtIoUR4qzfe22JSnZyDoxfviM6EE0LWm34rMYMYl+IQzBJR0SmVMK1ky5GqIIaTvPnnvqmNkURWoLhAnWdJHdPcwI6aKPApePHZdr8V1CYDx4ZkWV5tTPLv7nFqu3dwj7qQWL/brvaRl4iiK4zXImRV6cMOTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY1PR01MB10704.jpnprd01.prod.outlook.com (2603:1096:400:31d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 01:00:17 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 01:00:17 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
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
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
Subject: RE: [PATCH v6 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Topic: [PATCH v6 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Index: AQHYvuOO/bHE0lxAWkmN57Rje6utbq3cmGwQ
Date:   Tue, 13 Sep 2022 01:00:17 +0000
Message-ID: <TYAPR01MB63307A29B75C74ACFE2A748B8B479@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220902154829.30399-1-james.morse@arm.com>
In-Reply-To: <20220902154829.30399-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-09-13T00:52:30Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=bff8a14c-e638-4417-a7f7-e8f618fccb4e;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 5ac0573517594b9caa0897a54b4f222d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY1PR01MB10704:EE_
x-ms-office365-filtering-correlation-id: 9ae7f79f-098d-4f03-ed9f-08da952352f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMpuNL4gtastPMV5nYt/k+DBH9nU0RsgXAU1s6tVJ/YTiyAYqhB9zUGYBRJ85iMJGVBzkVKGq3n+DdGuFtjUgq+ZurEk3f9AcNRL8GXRCEn5njinLVXTQxjTRft3QYSbq39xzjAJNKId4ur0fNTBkGbbPcfNL5fKmMwT0U+Gwxe7y8IqRuyXb/xu4UP31l6Ds3AVsRFUNgAkekpaElKDl0U5UIuTn1Sp+VidwLQed4rU7SR/ftY2iO4pAlI7jTaa9icT6/GaFyHgONiV1/lb7QnwIO/OgLQSZ9uDNOasEYmDGpz0gNcUhSB8MmK8x7cXVZRMOwoUzUMQTdN6oyDnX0453crMB0R7/oQu4OPF3Wu2uirsFhscYe1Tcj0XR330jbSTBBaKVOEAuK2tV2TlEPsd/JxdJwnKDJavOmF3x1b3uwD5nuX4/qMimvUeIYcdNE2voVLQkPqYOyx9M8f6HUmEORVVJtsqS4j1owobM4b0ulRITlMyGvKwqyegS9Pb7PoH1B1DUF9xmAhbozbMzW0OH6ZfoKy/LiWVtmlbM0MtSgqN12Y59fNbp4eMzvre/qFZmBCOeIndPcSOagU8bSycms4eEpPutvCxHDroVlM2DaXoGnJ/ALar3s4Bv1IVrxqCwNetzEN3agCxI+NQ2s25KOO4jXPXEe4YIKY85yDVVAlvtCmbv/To4Zv9oVLqHhCurEmEFfCdZPCwnawtILNAva/IkwsnLMNVSCgjI9FYsTzkth074AfMJr9bynHhJTAffC6OWujeky1SJK9dCTtcG5DBH34oub1i6W5zSK8+Qj5BdSU5TRUqpfgSuEvO2H4+LtaUL6fFQJdqMYV/6BcBHvmvP/kUAEdut9AW834=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(1590799012)(451199015)(122000001)(186003)(83380400001)(1580799009)(478600001)(7696005)(966005)(9686003)(82960400001)(6506007)(71200400001)(41300700001)(26005)(110136005)(54906003)(4326008)(76116006)(66946007)(33656002)(38070700005)(316002)(66556008)(66476007)(66446008)(64756008)(8676002)(5660300002)(38100700002)(8936002)(7416002)(85182001)(55016003)(86362001)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RmZNcWVNbXIrT1JPcTVJQ2h5WHZ0dDBsZ25tZ0NHVXR2R0FHMUw5aEUx?=
 =?iso-2022-jp?B?M0FRYnhYME9IM3lXc00wbEc3YmR1d2ZkS1FGS1REK3Q3ZjhPT0htdnF4?=
 =?iso-2022-jp?B?Tnl0WU5iRXkxakE2RlIxbmxYdUJvbkdLa1N0Sml0ZStSZUpzWk5OeTRR?=
 =?iso-2022-jp?B?cFVOZENYUitZUmdQd0xTZ1dnR3V5RER3UTVXbThLTFhyL3VmZTFjVmRu?=
 =?iso-2022-jp?B?bUJqYlBqM0hxQmtLUXJJS1hxWWxSYnlJc0tiQXRqWmNXS1V4a3ZSUTVB?=
 =?iso-2022-jp?B?M1hWYWtpVzdJc1VnZ2VtMWt5Q0xPbnNwMWZZRDlpQTcxQjZmdWxCNnVh?=
 =?iso-2022-jp?B?UllKeFNVV2JrTFhlVC9wSHAxa1l2YWpsRGtiREJZajhYNHpiRUFQMjhp?=
 =?iso-2022-jp?B?R0Uzd0dvQ2QyUWFEZXVNRzd0cGtpYmlSYVdGMFVycVFKdzJVWE16NHhD?=
 =?iso-2022-jp?B?eTMyT0NzY0szMkU2R3MremhIb2hHUGtiMVQ3b3QxTVdGZlM0cUZPeWcz?=
 =?iso-2022-jp?B?VFprN0ZPa0RzTUdXaXNUa1JNRUozZU50a25GQ0VDYU1oNjRnRlNhMHRD?=
 =?iso-2022-jp?B?L1lSUDFxOVVXZExHRTN5NEhUYXNMOE42d3NjVndoWkZkYmFQanVDT2JY?=
 =?iso-2022-jp?B?cDFFTUEyOFBQR1Z2NHUvVURGZGlScnpRcGt2M2IxNVFOYjRPYTNMdm1s?=
 =?iso-2022-jp?B?UU4wd04zWk82bERqRXVzVVpYais4dFhFMER4WW9FWUhaTkpVT3lUUjZX?=
 =?iso-2022-jp?B?enBRaWJwbFYzWnQwSU1kRXlXT21lcTBIMDNIMjArOHQxWU5pOEJHK0JE?=
 =?iso-2022-jp?B?MkJodUNxM3EwYjhiRmVSOUhWZ2VNR1B3MWhBRWM3dktod3Z3WE1vNU5z?=
 =?iso-2022-jp?B?WDVSWHRUR3A2SDl2blg4RzJNV3FtcXNDZHN5WFFZOEdZVklCeXRhZ1VW?=
 =?iso-2022-jp?B?SlZ4YmRpQU4vL3pZOWZKOFVMYStDbVlCdS9QVkpPcm82aXNYQXRTUklQ?=
 =?iso-2022-jp?B?bk1pVWhMM05vRlBjL3QybVMydGxtbUg2bWxzdHErYVovODF4MlFCMktQ?=
 =?iso-2022-jp?B?bDBPaEc1WXZzbWxUalNaYTJwVG5DVHlRdUt2djJhM3pORk9YT3NpY1By?=
 =?iso-2022-jp?B?dGU4WjIySW1UdjI0RFBvZXJ1bVF0cEJTVVdMazkzd3JmK3lHT2w2L3JX?=
 =?iso-2022-jp?B?UVFsZTdySmZDWDRlazFiRSt2eUZFbElZc29DaDRYYTE5TVJURkhWVnhw?=
 =?iso-2022-jp?B?WFNyYy9ieFVKcjV3ZGliUlh4ZmduRS9CSXZuUlkzKytZeXRoSVhkUHlo?=
 =?iso-2022-jp?B?Q2tLbGZlZWtQT0xxOVRZdXk3Qzdud0lMMVQ1ZXR2em5rN0NGcGZqSnc0?=
 =?iso-2022-jp?B?WUNRRlA0dlJLbTZkTjlxbDBaNHFRRm9Fc1Q2Q21jS1FWaC9qbTRXKzRa?=
 =?iso-2022-jp?B?czVGYjNVUGFJSFhBNVdmVTBNOWQxU1NXeUpGRHU5TEh5a2YyZW0rTXFw?=
 =?iso-2022-jp?B?UUtlMGlxWDhJMVZqelJZK3VnZisvbGJnZVhGVEdJQS83NmZDMG9uSUdz?=
 =?iso-2022-jp?B?R0J4VkRDb3dLS2JsOUt3OEdoaGFjYWtoTEwxbjJpRnMrNStQeU01T2NP?=
 =?iso-2022-jp?B?TW15c0JHTmloZkJIU2U0MVRGeXFDejY0T2ppWjVQVXdCbXZuWS9ROGI2?=
 =?iso-2022-jp?B?TzZaSzNiRk11WHEzc05aUHBZYjVVSlpaTFI3VGpFNFM0QmpDYzZwUzdW?=
 =?iso-2022-jp?B?U3M0eUZ4dDhUbk9uMEY1MUhCSUVSVi9oek9ZRlVUNUFqbnBRSmJxZDNr?=
 =?iso-2022-jp?B?ajBvdjBJQ0IvMDNHaHBzcnVNbUQybzVubThXdUsvRnBwWmJzMTJEUXFG?=
 =?iso-2022-jp?B?OUFiN2UwVVJaT0E2Z2I3cGxWakQzVjF0QVZpU0R4UEN4Wm1Oek1QQUFQ?=
 =?iso-2022-jp?B?anBLc0NudGtoVHlxcWZQNHBvd2VRNGhGUS9Nengxd0RqanFsQU1FZjRw?=
 =?iso-2022-jp?B?c0V3NHJ3OVdqc2FQKzFLUTJGREx1NmExYXhmWi90RGdod1N6SDdhNjQr?=
 =?iso-2022-jp?B?K1VyamVpSGNIR1VJRmlIV2FicVl5end2VHZXMDFiSUw3VUo2bzI0QVl6?=
 =?iso-2022-jp?B?amcyR3NWWnJMdVB5UUpRbGhFeFBHdW01YVpWMUFlT3I3dktjaHdOOGtK?=
 =?iso-2022-jp?B?T2t1ckQ3TWlWZGh5L1hBRjBid0F4bGVYVERiUDNjQ3NlUXNVbE9ieHRN?=
 =?iso-2022-jp?B?bVdmMTAyT0syU0pYWUJYZml3eXNEdDdJVHM5d0tUWlg1YnJxUEhXZFc3?=
 =?iso-2022-jp?B?ZkdvNkJNcno2VlFBZEhlNjRvM2htU0ZiSWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae7f79f-098d-4f03-ed9f-08da952352f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 01:00:17.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJrPtTYEBCkS6KuCx+YBmCgKdXzSaqykM4Hj3b4aNrnWd8ZXPishyBTJgzzj0/gneX1oIfdxncflRTbwuzOwbkvqdAQ59+S7xpWtImphRvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10704
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> Changes in this version?
>  * Changed supports_mba_mbps() to use is_mbm_local_enabled()
>=20
> ---
> The aim of this series is to insert a split between the parts of the moni=
tor code
> that the architecture must implement, and those that are part of the resc=
trl
> filesystem. The eventual aim is to move all filesystem parts out to live =
in
> /fs/resctrl, so that resctrl can be wired up for MPAM.
>=20
> What's MPAM? See the cover letter of a previous series. [1]
>=20
> The series adds domain online/offline callbacks to allow the filesystem t=
o
> manage some of its structures itself, then moves all the 'mba_sc' behavio=
ur to
> be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array=
.
> As its all software, the resctrl filesystem should be able to do this wit=
hout any
> help from the architecture code.
>=20
> Finally __rmid_read() is refactored to be the API call that the architect=
ure
> provides to read a counter value. All the hardware specific overflow dete=
ction,
> scaling and value correction should occur behind this helper.
>=20
>=20
> This series is based on v6.0-rc3, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_monitors_in_bytes/v6
>=20
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_merge_cdp/v7 [1]
> https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com
> /
>=20
> Previous versions of this series:
> [v1]
> https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com
> /
> [v2]
> https://lore.kernel.org/lkml/20211001160302.31189-1-james.morse@arm.com
> /
> [v3]
> https://lore.kernel.org/lkml/20220217182110.7176-1-james.morse@arm.com/
> [v4]
> https://lore.kernel.org/lkml/20220412124419.30689-1-james.morse@arm.com
> /
> [v5]
> https://lore.kernel.org/lkml/20220622164629.20795-1-james.morse@arm.com
> /
>=20
> James Morse (21):
>   x86/resctrl: Kill off alloc_enabled
>   x86/resctrl: Merge mon_capable and mon_enabled
>   x86/resctrl: Add domain online callback for resctrl work
>   x86/resctrl: Group struct rdt_hw_domain cleanup
>   x86/resctrl: Add domain offline callback for resctrl work
>   x86/resctrl: Remove set_mba_sc()s control array re-initialisation
>   x86/resctrl: Abstract and use supports_mba_mbps()
>   x86/resctrl: Create mba_sc configuration in the rdt_domain
>   x86/resctrl: Switch over to the resctrl mbps_val list
>   x86/resctrl: Remove architecture copy of mbps_val
>   x86/resctrl: Allow update_mba_bw() to update controls directly
>   x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
>     chunks
>   x86/resctrl: Add per-rmid arch private storage for overflow and chunks
>   x86/resctrl: Allow per-rmid arch private storage to be reset
>   x86/resctrl: Abstract __rmid_read()
>   x86/resctrl: Pass the required parameters into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
>   x86/resctrl: Move get_corrected_mbm_count() into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Rename and change the units of resctrl_cqm_threshold
>   x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
>     boot_cpu_data
>   x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
>=20
>  arch/x86/include/asm/resctrl.h            |   9 +
>  arch/x86/kernel/cpu/resctrl/core.c        | 117 ++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 ++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  61 +++---
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 232
> ++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 216
> ++++++++++++++++----
>  include/linux/resctrl.h                   |  64 +++++-
>  8 files changed, 514 insertions(+), 262 deletions(-)
>=20
> --
> 2.30.2
I tested this patch series(patch v6) on Intel(R) Xeon(R) Gold 6254 CPU with=
 resctrl selftest.
It is no problem.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>


