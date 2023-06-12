Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D67C72BECD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjFLKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbjFLKWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:22:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4A12353
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:01:55 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35C6eNS5019182
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:00:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=ztytaLGnz7JkCZGHFYbRVuKwtFUpL1/NAozwvA3ONmY=;
 b=FrMUlfTV2X1fYaqcvyyADVKy6ybE3XTpXFezSL4hlau7dWPYKT9m6zQ/K8qf6DkT9pbv
 hF9O+WzJ8R0dqjKAPpFh0v9YRZZNspLqc8Ma/usXSt7b/KgsdBWztGEWQ2RNZrYSjOqZ
 /ZzlfKE91MQOPJQ2uoeKMZCK7s9acpVB4IknTvyDXhpYr7svSDR58aDtGmukp8fzMh6x
 gLn3TUxzxWIyLIWX3PLmtZzHTQ4NCrmHKtswIvcI8hQGHRJCk3xImvu9ogLSbEd04SeA
 14TuXuWV7R8nox94Wp0Xi6YhvGjbwOcQZgwftlQcNzYdofo4OV6NpjMI5Uz1r6oGXg8M JA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3r5xa5gw4g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLl3/mR3Ruayjhv6DngPfrNuh+hn8nzvJsJdlZ325OxQpQUd6ELG6dg1wvl4Z6K819okB2MzR2qQiPYjdXbK3kHQDQg65Qm6D8HtsGthhJ5ahrEm+w4wWuXPkFOdc2wl6MQr2T0Uq29QahZtjfyu9mQLcvHOUdo1Vkd03N6WGBevl8UaiHt5EYK0/7aBC/0ATTDq84TYL2Ym2p11i/tfDr+AN586KuPjSdn8ohp9W6ztvx5n6ei7OzcdgMIaQ4U/iO3ahmyMN36R7faoIoOlvPLUzr+U51FtFVnQYZ5BmQZgsXGR71y3M5b5UTrTDxzaGaZyMV/zWPCp2IxIKdm/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztytaLGnz7JkCZGHFYbRVuKwtFUpL1/NAozwvA3ONmY=;
 b=YdVXVGaVgZjqPPW2xPG7rn/bI8N6zQML34AylnCLGFPbtkjWsSZNoOp/l1wF2ZxU3WhLOReMYfgcHNUyT9kLdh3Svs7fP0DucTOHWeetWZb9Jc930hNctt9o7AZWLPPMCGzpxCi7JbjnVoAd3+K2HYb9s1tJlFTw6Rd6p4GD32rj/dOllvmAxwABAyodhrbUYvF5LVQ9zy1h5uvUJoINSrVeRZ9FHoMHJA4o6nzl763g97upp4AHBBbLr00tJA9kIREltE4cPwqDW5GmkEgOuwQimVt9WzGnaAvDdp8DJV1POOhh4LP49BOUOlaywe4U0rSVJ+eq8fkynnx4fgUMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA0PR15MB3997.namprd15.prod.outlook.com (2603:10b6:806:84::21)
 by PH0PR15MB4182.namprd15.prod.outlook.com (2603:10b6:510:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 09:59:50 +0000
Received: from SA0PR15MB3997.namprd15.prod.outlook.com
 ([fe80::7366:b7ac:5a7c:968]) by SA0PR15MB3997.namprd15.prod.outlook.com
 ([fe80::7366:b7ac:5a7c:968%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 09:59:50 +0000
From:   Jonathan McDowell <noodles@meta.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: dmi: Don't restrict access to serial number / UUID
Thread-Topic: [PATCH] firmware: dmi: Don't restrict access to serial number /
 UUID
Thread-Index: AQHZnRSgbC5BfmvI5025YFjNaR+wNg==
Date:   Mon, 12 Jun 2023 09:59:50 +0000
Message-ID: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3997:EE_|PH0PR15MB4182:EE_
x-ms-office365-filtering-correlation-id: 6e0ec677-70c0-4db5-e17d-08db6b2bc314
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRWdKaoDL1iaoiTge1BQrmDU/5bQ6H/Zt4eVj1mLSala+12PxsiN4LQBiHoNDQuA4qFojVCoFTGVZB6PnYRZX1mvOi42BAGatrhkK+VISqC7kJxs/xOytwoohrZoXy9crDj4XtxNZoqYCHxhuq4znID0tBsneKPWqp3FgvP5ZZVFDlX7WecMQQGUwuZvbUpktQAjGzeeV2SgtkYsOjFV+bmXTMcCXA0hPTPlE+sN1YfDnxNzJNhPcLI3p3dYGIHDQaCzbtLMg1YzUkA4RrF4Q2Gn+4taqezH8cw4P9rKdXIm9uRwGo80Ej52lR2sw7//U2eIDHh9Kd1TaCx7QuJrOAv9u14OwqlxmaLNL2wS3ggsrT4KEP2lTUtCd4Aa3sZQ2XVWXgA/dDBMK+1kid4yfptd+0Us1fFjQfTW784CMdqUmOUpyMPeDiEv9lD/MiDyjuMvPoFfNumufR12tHqHnFj5IEcpjSbIm5nzOqbRmct+K4zp++LChCOw/k1GOuLCXPvmQH87IblFBaa7p5DtTUG+P+65qM3UecGTv9CMMJsgzE/5NJ0FiP2x+PN1zbLmti97S0M6eAYYsVD3ZPibGP0bAb88hV6rm6N968NNLDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3997.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(186003)(8676002)(8936002)(478600001)(110136005)(71200400001)(5660300002)(966005)(41300700001)(316002)(6486002)(26005)(66556008)(91956017)(6506007)(66476007)(66446008)(66946007)(64756008)(76116006)(9686003)(4326008)(6512007)(83380400001)(2906002)(122000001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVCON+jQZhnB+btpU3qH1cdmmqet+upkuxwvazflBc4hresFXO05KsH/Konb?=
 =?us-ascii?Q?l+w1LMBw3xa5AwW3dCMrultcTV1l2tVBRKtE38ZmvSdB8fdI+pgJJzVJhW+t?=
 =?us-ascii?Q?7vIEaH5L1TByvLkag4Zo357dRKT+InxcBWeIuGi5hvdF5as8pPykz8TxhcRj?=
 =?us-ascii?Q?JYOvCnOZJQ5Fyc/tL4hO5u6kolxyEWPe/o7289xNpATupv4NZHfbqgYYGmhf?=
 =?us-ascii?Q?+RpjJU8/KDBJmCxIwzwO/wVaCarPXV/JiLL6m1HA1my1W8+uqlDsYHcTwOhy?=
 =?us-ascii?Q?p0nBqhl5qDxt7gQcLePLcEZLCdiXBFRccM7HDm2PO1qISbzbKsOvsZ74wK0Y?=
 =?us-ascii?Q?TcqLhmmTCZ2uE+KBmDxgp420SmSB5KTqs4u0PI406DzCoxCXa65Zi2BKRuxx?=
 =?us-ascii?Q?D+r7iLQyeTRlTAqAleSCXZjcoF7Oe7StEpcu9CR5OGxa63OAbshdqryVV+ZD?=
 =?us-ascii?Q?Y/GC1ugmahpGRXS48Pd3VcE5HF05mPhgdPCUSt/h+AParhoVyGmHhOL7JG5I?=
 =?us-ascii?Q?nJyfq2GbQnNbCYMtRVXn3UR8gBYutEOZ8k9sbCBw812iyYE+t2BQqLC8L453?=
 =?us-ascii?Q?T+//N5610uuUksiWTVJbVh3gjHb5Ig0KLR/MlggSwSYRwCLnVkXPWD+6rPfD?=
 =?us-ascii?Q?WNElWxhZzjgxVXymxpeywnOSWhctL+RhcEM7mt02RbWD+enPRdf4t50ViQEn?=
 =?us-ascii?Q?mJ1A5TvVApLbV99vOZLB5oAg9cTiXiD6iF74XCB9vLnAEdzFwvS0pQqFVOxG?=
 =?us-ascii?Q?MiIQ/qfRU1lC/XtH8LsRoNej0RtAuy14IEhvtndISBFdceiOuq83pvSFtwnN?=
 =?us-ascii?Q?HFwDCo5qaYgJh72LbohIYu+egl7A6vn35qXt24RvHn8R8i1SOZ23YWT1flvD?=
 =?us-ascii?Q?lLBX+6uX3Hti+2rtUeQIQr3uSmhabpwn410efoS2TFSEgsAES8ElBjUwRdKT?=
 =?us-ascii?Q?CXq2wpiqwHrzMAHzRjOX8L1n9CYHy8mBLTEcAl35GnVFHoOpCx+uZkcH8d4h?=
 =?us-ascii?Q?9vpt9tTzaeh4PpM0X6RdklE7YN7y0tOzBYPbRp/d5exbAc2kB/CCanirgSe+?=
 =?us-ascii?Q?Xtn1A0KWqNspxoXP5YtukViLSoN2wh8l4pV5Gva9HeyNTLEROPBNUJpVQU7M?=
 =?us-ascii?Q?E6LeNSrvXOwh6RZmyIdR9NQUJCj8BxJDoUcG5yx3LUy3YgfPcbg9vfUcVPiS?=
 =?us-ascii?Q?h3ny0Of+7L9LHer10BTJRAqrnfIOgbHStUTVGnIJfmfAqh5+1dtXdMqPWMvZ?=
 =?us-ascii?Q?eBpnWwLKddANkm48hg8N7cOpxfHVSw74MkbcqearLHLQ0k9FafItKFZqgz6Z?=
 =?us-ascii?Q?Ho08acfEDmTtiEVPI4nG8z9OCxzeTnM+rEmkWdnW0C3tY0aHFl2Fz0Iw0cS6?=
 =?us-ascii?Q?d4vM/JB5PRHXg9xSdU6QQ1XbgRtkUMhdGs9NTtlnIALFUaHNjfbNm+D670ZJ?=
 =?us-ascii?Q?jWcccrsQQibg+87k+XbPsX1CGaRRSxwZJ3nKjdWXSo9a4jpD95Resl2B+tab?=
 =?us-ascii?Q?31wvETctMKngcbuODhoUKculMeXJMdrRxxOZF/9DMScY2hmJAjpq6Eju29r7?=
 =?us-ascii?Q?BLbWRJaX0y+lQQq9HRa6lpYJVDUBC0ySHJoLbRO6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <850F49339C8A1D4CB828761608F42520@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3997.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0ec677-70c0-4db5-e17d-08db6b2bc314
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 09:59:50.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MbaDO5+ZLUOmMAfCfsyXDT0XZzVGIY0ov697KHTeeIUGNynJNL0MNHvrOCFcBQgTCHsjFAoKgZUoWASY6u6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4182
X-Proofpoint-GUID: Y1EjdHx_FMbdVVpgfl65Ig7Dulv_i1VO
X-Proofpoint-ORIG-GUID: Y1EjdHx_FMbdVVpgfl65Ig7Dulv_i1VO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /sys/devices/virtual/dmi/id/*_serial + product_uuid files are
currently only readable by root. There's no clear rationale for this;
Windows + OS X both allow regular users to access the information, so
there appears to be no expectation on the manufacturer side that it
should be kept secret.

Having the information easily available helps with automated tools that
collect system information for the purposes of fault diagnosis/tracking
without requiring the tools have root access.

(I've tried to look for context on the initial patch submission about
why these were root-only but didn't find any; hopefully Lennart or Kay
can provide details if I'm missing something.)

Signed-off-by: Jonathan McDowell <noodles@meta.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103601
---
 drivers/firmware/dmi-id.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 5f3a3e913d28..ae700c09d7de 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -46,19 +46,19 @@ DEFINE_DMI_ATTR_WITH_SHOW(bios_release,		0444, DMI_BIOS_RELEASE);
 DEFINE_DMI_ATTR_WITH_SHOW(ec_firmware_release,	0444, DMI_EC_FIRMWARE_RELEASE);
 DEFINE_DMI_ATTR_WITH_SHOW(product_name,		0444, DMI_PRODUCT_NAME);
 DEFINE_DMI_ATTR_WITH_SHOW(product_version,	0444, DMI_PRODUCT_VERSION);
-DEFINE_DMI_ATTR_WITH_SHOW(product_serial,	0400, DMI_PRODUCT_SERIAL);
-DEFINE_DMI_ATTR_WITH_SHOW(product_uuid,		0400, DMI_PRODUCT_UUID);
+DEFINE_DMI_ATTR_WITH_SHOW(product_serial,	0444, DMI_PRODUCT_SERIAL);
+DEFINE_DMI_ATTR_WITH_SHOW(product_uuid,		0444, DMI_PRODUCT_UUID);
 DEFINE_DMI_ATTR_WITH_SHOW(product_sku,		0444, DMI_PRODUCT_SKU);
 DEFINE_DMI_ATTR_WITH_SHOW(product_family,	0444, DMI_PRODUCT_FAMILY);
 DEFINE_DMI_ATTR_WITH_SHOW(board_vendor,		0444, DMI_BOARD_VENDOR);
 DEFINE_DMI_ATTR_WITH_SHOW(board_name,		0444, DMI_BOARD_NAME);
 DEFINE_DMI_ATTR_WITH_SHOW(board_version,	0444, DMI_BOARD_VERSION);
-DEFINE_DMI_ATTR_WITH_SHOW(board_serial,		0400, DMI_BOARD_SERIAL);
+DEFINE_DMI_ATTR_WITH_SHOW(board_serial,		0444, DMI_BOARD_SERIAL);
 DEFINE_DMI_ATTR_WITH_SHOW(board_asset_tag,	0444, DMI_BOARD_ASSET_TAG);
 DEFINE_DMI_ATTR_WITH_SHOW(chassis_vendor,	0444, DMI_CHASSIS_VENDOR);
 DEFINE_DMI_ATTR_WITH_SHOW(chassis_type,		0444, DMI_CHASSIS_TYPE);
 DEFINE_DMI_ATTR_WITH_SHOW(chassis_version,	0444, DMI_CHASSIS_VERSION);
-DEFINE_DMI_ATTR_WITH_SHOW(chassis_serial,	0400, DMI_CHASSIS_SERIAL);
+DEFINE_DMI_ATTR_WITH_SHOW(chassis_serial,	0444, DMI_CHASSIS_SERIAL);
 DEFINE_DMI_ATTR_WITH_SHOW(chassis_asset_tag,	0444, DMI_CHASSIS_ASSET_TAG);
 
 static void ascii_filter(char *d, const char *s)
-- 
2.40.1
