Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949FC68C819
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBFU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:59:00 -0500
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7A23D86
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:58:57 -0800 (PST)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KtXA8032221
        for <linux-kernel@vger.kernel.org>; Mon, 6 Feb 2023 12:58:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=pS0HY9POPNpixQfZ9K0nhi4VHZIVGoLDoAVmg+fsJ00=;
 b=QO8+WvpSVcoEV9AJ/NrsxnkPfbdGg2SvweP5fKqXyQ18Qhyb4Iq7tLRw66mySByXpYbe
 7HyoKeGr/TwG6rwRV4SPDOx2KTE6yDXv34fRON08qMhryQHVKnaWUxJCg62Y/0C89Ukh
 ORVstCE4D+AvvHNrGkxnquhxmnXo+0L5S7nswpvAl1xD+7aWL5nDouUzQGRY0lzrERn+
 +PdXMbmWJmq4uSShkOxwFnpjRONkKbdoCfx1XJ8BDQXbFkS0o66+TtVstLmmF85oXxFZ
 Doi40CRT1e3MoBh5HVQxKXqENc0wqEFtWZFEGJWX5gg+EqhI/ug+Pip972gYZ6Y+8Z03 Gw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3nhqs6bgpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GESlcgOs226mxmuRYljPVQqnS3F1DtDqZ/RN+N0rm3e69vG+oyYdGleGktZIY9C/ZLLfechGf3yVBuw7KAQ+RIZlluk1fIYJuY2JSvodFQ5GFeTfUowR0HNuYZx7mogDXN5Ru2hFyGzECEqYHsDEcUa34QQ9dqA6wKenUSIoLUZAHCYideYs2qrHfkMLqHExBJTMhJw8YvUPxVQZ+9GNmz/i8gCg6+3ywerMK0TzOZmu5HIpiWwfU+H6jO7llxQ/Kb/A+DTCUYI+ol0eCkpuZszncpPiWvZ2iIG3GKQTM02tsUhYr3SAdWKKB3ZxJYBwHAeOIbh2JHq72hU7AQMcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS0HY9POPNpixQfZ9K0nhi4VHZIVGoLDoAVmg+fsJ00=;
 b=gq80woRfDIwTDiTb4NeD5t0ySQIpPQqUYcW7DHLRvhE+iqqXe1uYhiRRakMc9a8AAZRIlTpO5Qys6ILnTT5ieEKBdvE9lR3vuuq/RUEt7/FXknFXko7rvU4kvEFUIXBI/mFTgvUgk+aOgBGDn+7soYcsT6bDysTWYztgVvXoPFLR7xFlaBgjq076b047/hfdWC39rUrbxnPSyrb45Q0pcmgBLlDRMxXdZzbeQkfBCywsiZWy3IBFHuhCGiemaqjpeu7/SjwNtJGuDPehy7EbkO0bsBXN3QES2fjMnljsyJtv+tfVJecULOeaIvInBeIecSAyZ6lFnxlwFETb1hfYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS0HY9POPNpixQfZ9K0nhi4VHZIVGoLDoAVmg+fsJ00=;
 b=gYAcQh2010/9S7MGLjwsLtsM2FEbcYs48dmptZcY6gtWREaTnETNkqfg1GXWkVVk5d8nTnr9oqK7ZvDwZg+jGf/0oEuKIDQ4Q6r6pS6xwD3pDTqHl5ux7P30R/GkHlbxwxD5B0byKDQUF5hFAIzq49fYrro5p/VCx6xhlhE3XMvmMv7FRm2Lds243XcPdHNR7M3uCubSRttyK9NmPGY+t3OIF5jScyIHVsUTCy8R4ANOaXLF0oOXvYbEEJ/Ed139Vm1U6jALUHrclx1PVFkqsqIKyFX9A61Gy1JdEBhnyMmdByofWhAVFnhL0t7jSS4FYFWhX1zAzmg8ojuolNSPKA==
Received: from BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19)
 by IA0PR02MB9487.namprd02.prod.outlook.com (2603:10b6:208:401::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 20:58:55 +0000
Received: from BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::104d:6f4f:7dff:6cfe]) by BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::104d:6f4f:7dff:6cfe%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 20:58:54 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: intel_idle and acpi_idle driver initcall order
Thread-Topic: intel_idle and acpi_idle driver initcall order
Thread-Index: Adk6bYHffH51yATXQnGvpDCe7duUZg==
Date:   Mon, 6 Feb 2023 20:58:54 +0000
Message-ID: <BL3PR02MB798658A2F65018B3C4B5E9E7FEDA9@BL3PR02MB7986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7986:EE_|IA0PR02MB9487:EE_
x-ms-office365-filtering-correlation-id: 481faba7-0e67-470e-df3c-08db0884f56e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUv1PXlvaj/WP2PxOKQ9qFwZ6EYxk+Lv4XrrMe7BPb/ANS/LcLXGlwmEKhIr2IEb5J4zkvVPom1UdhWAC3uW04pDLl0/be+gYlPbmKDZazoppkp6PD2/aOPC3odvDXMr9FqiY8EKN2iOXVLCN0tdVl2TYgggSI4YEUXXlwQpWKqnaecC3O9G16GySEa9Coycz1kQ79sR2OFh2+vH9bVFqhVS9V0WdQBEk1ACqkDsGSinBYkmyCTGeVg9ryVKvrFA0GnM4xEPWOD+pp5XR+An/aIImr9Qd/M6SHjkYFzzkOXnWRJjg9MeuNnW1+/ZeaD6eVAJL1iTlLat79o6KHHtsZDbVH/z2cWKZRtmDcdoB0lFYgztJOM/IS3L4E7JJ/TGstuifkZeqHOrSrkOh3TqcpFKJ446WA+FC+sKDZd6DB60p7Mr7CU7oeLhxkjWoYXARj+24CKfoqP+m62uRNdi/0o9kQaYr8Emp6qfLhK7lcq/w7sU7EtTD5PL+SfApmjharKLRxGAfuaqcjnr+BhYP0MA3OxqKnqGLgseDk+OmekS3HjQ8YU/CL9YfBJbjvVIvevMYiTE1lrnWPLGoV5q2WtX81KBKLAGjYNaacdJfL3H9/doOAmGoBb94rELNpMihXB0XCzlwy6obHpeHgV5lOK4jZOJb2cRwjO6gGHM6lcVGZ8m4QrsR73l8iw6EPIvLH4f5QtYmMmmD1DGaovgLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB7986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(38100700002)(122000001)(83380400001)(38070700005)(52536014)(76116006)(8676002)(5660300002)(66446008)(6916009)(66476007)(2906002)(66946007)(66556008)(41300700001)(6506007)(64756008)(8936002)(478600001)(9686003)(186003)(86362001)(33656002)(316002)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FCi6tlUK5tgwqozXRwPslKPVGSiK6IWR7sUo6f4LjXxxHInEW0CfP3UOHKRW?=
 =?us-ascii?Q?s0MbFqO+SjRwLm1dpXSkqVqm2yt8iIkm107A805Xp258Y8eaXnRfJ6WtE2Rt?=
 =?us-ascii?Q?EMlAiHVlthIGFSv3e6/NsvGzYfGVSzD3m55Lr0P5wvr1RLnHU4iReJ7OJCrB?=
 =?us-ascii?Q?djd+OYejOn0zCV8Dht/HSSnLXlRTtppWsfuvuCE8sqz4R5oiby2AN8b0RjQE?=
 =?us-ascii?Q?P9/WpxEUtvRUt6UhzOspa/sWK4XrG5Hq9JO3t70YxWRlWLNqBLjk7dxG39Tv?=
 =?us-ascii?Q?uOqdrlDN6XAd3gKJsW1WtlMudI+WbhIyqwYfcbvhg2oFu3y56JfRJsvnmNCO?=
 =?us-ascii?Q?WIMzyqL/drBlLtXElcJOo+1aUyRxq/UDU1ojGhmA3lAQlNf+ZvuQcorZ9XQV?=
 =?us-ascii?Q?ojGRn8i/sXlxpE7mEdl13/1lJ+nJ73cRMMZTJp7CY3/Mw2Qqz8J3pv0sQxKc?=
 =?us-ascii?Q?iTONQt5DU/PYzuNvtO7A1csEehwN88O9J91WXQj5CXFu4RUTmmhpyoFHVyao?=
 =?us-ascii?Q?+95fLct6dqNTCXg0iVsW/mzrmqJVmSZslJu8W9I4H34UudibCJGeWW43XnNU?=
 =?us-ascii?Q?k6EIzV6ThdvpQoaa9YEHg7JL2xPJi8OrHfbCGQegffTmFGZnY4jvgUlxWSnL?=
 =?us-ascii?Q?nWheoSATem7yGGJr/gwtkc7QYDGHTntcbJ/N5oVmB+8YH1bI50o0MStd2FVr?=
 =?us-ascii?Q?Mv4PpOhQjtifxUH2CBhH6h38pV4zrKV0b8AyUrlOQLRNRFHL1dxHlO0nuf1B?=
 =?us-ascii?Q?kHVbKvDidRCk/yVnaKY6QuiabkD/BSJTurDTbEofxroIvU5tbp9VCpjP+Ifl?=
 =?us-ascii?Q?0lY6TkBSJ71aeWSiGO0Usd5dJ0eGK9MDHIyXIsfKme98F5E6cvujByMqtZNK?=
 =?us-ascii?Q?JcNG7/GOoiz3R8h0vuUj1w6P8zQnG2D0t7bX9W+calmg9a1HcO8j2crG3Xlh?=
 =?us-ascii?Q?0cQF0kbhzu63A4Ue8lOkSjctq+PoHYf2DRAOk1+5xelVneYV/AjYqC7t0NmD?=
 =?us-ascii?Q?3Cv6rXiPoDK4JOmtE85EWFBfKfA60btE7Fw5SkOQ/cJ7faL0vk1X1EkmBfru?=
 =?us-ascii?Q?KJzjcgDUcbVZSGMuGaJviLO2V3fXdvHYskKooLTrCrJ1FuHFenmlN1L+bv6C?=
 =?us-ascii?Q?RMEtTedEDmwt9JPfWxEOMBidRoxQqkga4nJkkirHVDTDjkXG8u9YZfguHWd3?=
 =?us-ascii?Q?gQGiHjUbuWUwWTnzlyXUzDuYW16gESZH1nPAk5PE63PNcCMtY6Ej3KtnZeqH?=
 =?us-ascii?Q?n+HuKMQ/+T2G0imFMXBK6In1xLTKWvsO26Tx7PkuGpKD4rFD+P9BkVMrdooM?=
 =?us-ascii?Q?iHSXNOyk8HuDN2qzUG+pvQ2HNxtKRY+x3ri2Gjx8b/N/l3b7t9wyFV7KAdbw?=
 =?us-ascii?Q?B/MGgoDl0y1g5bB08Cq5hpx0EfI/7hqc6GcjEoMa6BULCjUTdoJWCqkMBuF1?=
 =?us-ascii?Q?5iac6L5JugSrFjrDXEnwclg+KzFQ5Et22krbgAX8sPr7Ow9wo3nQpN2knSd4?=
 =?us-ascii?Q?4MHxndGijMruQh7qOe+bPpsbWfiX/fMZpY/N7HFiabAuH1kZ5OQ8MqUx8EXQ?=
 =?us-ascii?Q?kzHehV8TjUddFfK+Uc4bjT3aAeppM4w/0bGzgRTqArjtGBfSI5UqjXPewHo7?=
 =?us-ascii?Q?MXDKO5b2uEWLlJpJY86hW+lhpRR8716/ISwpQ5F6Jba9N7z7NwxFHM2HAHt8?=
 =?us-ascii?Q?QLX0Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481faba7-0e67-470e-df3c-08db0884f56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 20:58:54.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uul86RyMJLXrcZeLa++60v37/1QfvCnxx20gjoJdWqE5pFjvFmvzrOxE6Nbghy9B90FDqeQn+f9cg8kBHNHz9UjF808ICmC2oU3lMOSWnds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9487
X-Proofpoint-ORIG-GUID: cj9avtBXwzlpsofAwp2LqeBVz8g7Mor8
X-Proofpoint-GUID: cj9avtBXwzlpsofAwp2LqeBVz8g7Mor8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Looking for help understanding how  idle drivers get loaded on Intel pl=
atforms.=20

The intel_idle driver always gets loaded. Both intel_idle and acpi_idle dri=
vers are built with =3Dy and both use device_initcall.

Added initcall_debug cmd line param and noticed that always intel_idle_init=
 got called before acpi_processor_driver_init.

2.736001] initcall efifb_driver_init+0x0/0x13 returned 0 after 5 usecs
[ 2.736003] calling intel_idle_init+0x0/0x406 @ 1
[ 2.737335] initcall intel_idle_init+0x0/0x406 returned 0 after 1297 usecs
[ 2.737337] calling ged_driver_init+0x0/0x13 @ 1
[ 2.737350] initcall ged_driver_init+0x0/0x13 returned 0 after 10 usecs
[ 2.737352] calling acpi_processor_driver_init+0x0/0xbb @ 1
[ 2.767685] initcall acpi_processor_driver_init+0x0/0xbb returned 0 after 2=
9618 usecs
[ 2.767687] calling acpi_thermal_init+0x0/0x86 @ 1
[ 2.767850] initcall acpi_thermal_init+0x0/0x86 returned 0 after 156 usecs
[ 2.767852] calling acpi_hed_driver_init+0x0/0x11 @ 1
[ 2.767888] initcall acpi_hed_driver_init+0x0/0x11 returned 0 after

Question: What determines the initcall order within the same level?

init.h:
#define device_initcall(fn)   __define_initcall(fn, 6)
