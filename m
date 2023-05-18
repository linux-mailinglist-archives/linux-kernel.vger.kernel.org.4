Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E123707A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjERGkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:40:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282462D48
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm6BTXPc91+F/9291rmksD+ffkTIeVYrfKBZ+aO7PLMSxS9ifi6bYBhUKlvMjMCEPH/+Ni7xenUh1VhHCxk136NgwlpEw1aq7NcI+MDG9eXOoZi6uH/mFKxCSNdmql1LOllZtI585pyIqNw+sfQdfKDI35Las+g7n8hc8FcihLyTc/MGZmy005EyFzVxOVv3YlQ5Ojps+NPrHkM/Nzcnc99vDg0EvTuXRD/admN1z+ffDgeKyYS+bJKbkWHXTxrcoaRon9ePrHERPAw4uZ48kDoE5xB+0MiAQnhPUdqHKgThbSqyC6BLmdp9V77P/XZKYkrky473G2T3oewVwaKOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir2DKUFZEcefDZ35B6POWH+gumwGO22kLIyV+zlmFo8=;
 b=FnB11vGh+4bBI/sWzyoz9On5gA5XW3cvsJ12j+n2noMyRgVspICGDcUcTEuD26alrdCO0W475yWlL3yPtzWtpZrSZrMUxbqmN5ruGdBjR/HrQ6w0kg3bGNO1aswn73+dkGWARy/zoib49fWyIl5ftHnl7M7zc1fN3E6m7kaNTcCPgI9h80y37HDS3f/07KUZgK5buubQNPwTqS5nxibJWolWIIz6oQWolxKskSQEjxbZ0KFZerNGXTOG7lHT81jmzO0MPZnLE9AsiHgwsfNaQlmPTVNuaFsb+pGUoTGHHCwnqWMPcOPn0yDxr7koMsqz4pQJvBUdfNKZ+vQYs45dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir2DKUFZEcefDZ35B6POWH+gumwGO22kLIyV+zlmFo8=;
 b=RSZfXwjvh0eH4ZTEbJbAESua+YBvSbLof9mcpXm+JEZxkqEvot1PDLOE6ize7FvdlpHvFLmrx0QXfYKQvr4e3vMXvIDeeCA4PzBx9+0xKM0Y2RVAwFDk+ti4dBaFfkCuvx71esLy6b2pDIXoiS0Iglzo0ObPx1d6HC/SIP5rzXI=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM0PR04MB7075.eurprd04.prod.outlook.com (2603:10a6:208:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 06:40:09 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::9dc3:f8ac:24c4:9f49%6]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 06:40:09 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: RE: [EXT] drivers/bluetooth/btnxpuart.c:1277:34: warning: unused
 variable 'nxpuart_of_match_table'
Thread-Topic: [EXT] drivers/bluetooth/btnxpuart.c:1277:34: warning: unused
 variable 'nxpuart_of_match_table'
Thread-Index: AQHZerlGnsBF2dFvJU61HbSi8s377a9fr+qw
Date:   Thu, 18 May 2023 06:40:09 +0000
Message-ID: <AM9PR04MB8603C3ED782FA38EB07C7056E77F9@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <202304300014.vFGw6Dr0-lkp@intel.com>
In-Reply-To: <202304300014.vFGw6Dr0-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|AM0PR04MB7075:EE_
x-ms-office365-filtering-correlation-id: d6f297c4-d632-4a70-57d6-08db576ab95b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //Ww1py/95iOPe+7NPmt9EUz4n7eYzX24sNXJnFHjRs14S2LIfR+Ew0/VHjzLtsKKJDuCJYgJQq4lSSxvt+1P9W4iBymmGWIzZh37STqmoDgv1dcSH/mcoWJNrNREJTfhTFKiQgmkegvtvcDgqhgYF8DfoeusWmVHqxRnoHYPfHwC51iVtmEqs2Q+V21YAGsoIIEYRyZ6dvdTgD1JG3Xoxl6wlmHPkohyXSTKN3hOCaoTLh58c1ymIopSq6yaJlhInoa6iyvAhp1p83I4EnHqxeND6saosXl+vp5FLG/sWcHbZGMYVbg1TP1ODE0m8uNi4MX1WLtkDwcUKpNUMs0UUoS7Qg+09nYU2sDLB6n1WniuUrWlv5lyGrV4R4rLkVh6nJMx1TS+a5uWGGewZe6tw7lxOXtqGAY0OwOgW5svneEhNoFTWnjA2cruaSSR6rtMt6JNrq5QQidK5UkQeLv+wcPE6B3yjX7BCIfeCKf4aunOndcpo+95O4yXLHLhddutL+rVI8ElcMIm9/tSDlNlRfsj7t+hPIkaJ/JMBWe9cdczIpfygJBfFgGWNPlcElvNXPVNc4Tm1S3Iqo0RKqqRXL+YGb02TtjrLIxupvm6CnZYLGUK1OgcZt9ES9ycGtbA+P0BzZzPTTYtsMSbkh3SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(38100700002)(55016003)(38070700005)(54906003)(66574015)(66946007)(83380400001)(66556008)(66446008)(66476007)(7696005)(64756008)(76116006)(4326008)(316002)(45080400002)(53546011)(6916009)(966005)(478600001)(6506007)(9686003)(2906002)(5660300002)(71200400001)(41300700001)(26005)(52536014)(8676002)(186003)(8936002)(122000001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hajs0emd8adaXn4KovI+datdro1sHDp+rWXIAwHOzV8Z+b3CGSan3+JvIK?=
 =?iso-8859-1?Q?/6tjspN1u5hi9phnLTMQPAWZQ8hpFXiIzvhMDvyZ0U+l6crMIkHsGoYf3w?=
 =?iso-8859-1?Q?8U1ut0jZ7hT0SSm7soXHCJaKeJPiEYS/qhZ8YeICc1Tna6WAKTX1W6QzZB?=
 =?iso-8859-1?Q?fpXWjOja+XrAZaG8PJZp4vdo5Mgo7TxzJr1SVzw0oi+CIw7S0o7u1TFzR9?=
 =?iso-8859-1?Q?jZ2M6NVYnEooFmKGUlCAIp2dBp4r1DybHgP6ystc37bxl8HTAy6TK8hvJR?=
 =?iso-8859-1?Q?Ve1zyjyrVicxuYCbBh+kAnuNgWFHuLbbuYpXbeemC6ACSsVmR1/DW/CkF9?=
 =?iso-8859-1?Q?9ks3WHCCr6fpVkIqO5kXYJfxvFAYxas7iIKPR0x+WYy1XWt0zTTQWKkAEl?=
 =?iso-8859-1?Q?rRKX1u8GDnOLSjaS8/hFdRf3bUHdk3p9r7HkXkYd6jxZoksdCZCStq3/TD?=
 =?iso-8859-1?Q?5eS4+At0LSCB/e0oBzAkznJsOT1ajETpRkF+rHMFluWINOtSvoqABFrXnN?=
 =?iso-8859-1?Q?xsyQ4Era3IFzs4V6PTpUh32nkm37BXA9iZFTleMgr32ZKAIZoBzNpWYVtL?=
 =?iso-8859-1?Q?OqrWO3bRqKfrKxEOTljyrIcdZiHb5sjf+lTu5+FN+WqqMKpTPoXthB4QIh?=
 =?iso-8859-1?Q?waId4tLUKl7fSV7DGqTmpEL3l8Ao3V6cNfCG6Uv5OGs+/GihfFo3ZG17cR?=
 =?iso-8859-1?Q?Q40MduiZr8/QHU054QJ1EWi0FOhzSQPLZz7L0Zv/PdSquEOPeyVh2nj2nA?=
 =?iso-8859-1?Q?EWhZ5FZXsvfNdm/obwwZmAjFlWhcKVtoYI+L+jsRIUvWyNSb58NQ7prRrh?=
 =?iso-8859-1?Q?CjfL6yKYwojKNWG0yCHneb1R8lLocM+gdQ/hpJXSqvialY+HL8cDHVHlz5?=
 =?iso-8859-1?Q?z7zI8E2hYVTyqmFDY1PhBo4Cm08Ix1Kf90DDza7QD8PJSwTYz4Hf765OyP?=
 =?iso-8859-1?Q?BUyb/lKfP+YybepMlcY/1mJHofTyLEO5W/906/NXjIqDwi1VFr+JdxwrRX?=
 =?iso-8859-1?Q?VHkPHMo/5wZubAzpuDUpPgEDOQmXZSsB2Cvo/YtjP9uTn2VpAckcn5rSCV?=
 =?iso-8859-1?Q?fVeQrX/laE9tbZRsfz8MdaajxB/WqaTnkqWIzbH5qSsZktZjONKpqqE5RX?=
 =?iso-8859-1?Q?6T367O6PbTi+yYW/NkrlWfM+SEBve/FofBM5EAMBhSJH7jaazgNfUZvSqm?=
 =?iso-8859-1?Q?sz0QEqCn63l5tJNt+MO4QGWpPUA8BJdI9Ko1gObeT5gy5Qjlqg2xldvjKi?=
 =?iso-8859-1?Q?JB29CXlPTbWrm9/BVOT1HbdtoMtm+4H2YMs0coKx7rljsF9I6TiC1P5STb?=
 =?iso-8859-1?Q?GU/NAvEiLTjnkzlgGmpLjRkJ7tTthFoZlFHBGNO88yttjZNIqpGoMSQfey?=
 =?iso-8859-1?Q?1+1ry714/1+6+J4J0U8NiI4L24LYRM8j8DlsjQVEk4Q4oZBZcBzvFH+TAC?=
 =?iso-8859-1?Q?+Ze1Bun2gZ7Bu/Kw55+6dcLCbrp4X1tTC0MjuRbi4Rjf58yYkyU62lhSGJ?=
 =?iso-8859-1?Q?KyBSB4imuWglg4wyOevLCoz4yYxfFR8ZEOBwzZ3tkkaQeMYiFT0374MnU4?=
 =?iso-8859-1?Q?AWNriqmIOXlBRRtHgQ2Y2vObQLJFQtSHS2ksw7NuGCIsQQcbGJQkOYqz77?=
 =?iso-8859-1?Q?jgZw5thlIOjhCQfHZx2XkOmGfHcmtWozTr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f297c4-d632-4a70-57d6-08db576ab95b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 06:40:09.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRi9DS+/3v9me3Eb+Xb/1opafZLEqdQ/is6wiuIy3otaxD2yS0+jTejm0M3hTqM80k82WVmsuYgAAeKJnNbLGRcfeWTkCl0As9POnEO9ubk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

Below warning is resolved with following code change:

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 5f641466d695..fa6ac4dacd1d 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1264,6 +1264,7 @@ static void nxp_serdev_remove(struct serdev_device *s=
erdev)
        hci_free_dev(hdev);
 }

+#ifdef CONFIG_OF
 static struct btnxpuart_data w8987_data =3D {
        .fw_download_3M_baudrate =3D true,
        .fw_name =3D FIRMWARE_W8987,
@@ -1280,6 +1281,7 @@ static const struct of_device_id nxpuart_of_match_tab=
le[] =3D {
        { }
 };
 MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
+#endif

However, I was asked to remove this '#ifdef CONFIG_OF' in V2 patch by Rob, =
as this driver only supports DT.
https://patchwork.kernel.org/project/bluetooth/patch/20230130180504.2029440=
-4-neeraj.sanjaykale@nxp.com/

Please let me know if I should add it back to resolve this warning.

Thanks,
Neeraj

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Saturday, April 29, 2023 10:10 PM
> To: Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; linux-
> kernel@vger.kernel.org; Luiz Augusto von Dentz <luiz.von.dentz@intel.com>=
;
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Subject: [EXT] drivers/bluetooth/btnxpuart.c:1277:34: warning: unused
> variable 'nxpuart_of_match_table'
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> tree:
> https://git.ker/
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&da
> ta=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C11316289cf9545181d0108
> db48d0676b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638183
> 832151571141%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdat
> a=3D4l684I87hYaEh5cUL%2Bq15Vded2F4OQ3DgIugH4zWUJw%3D&reserved=3D0
> master
> head:   89d77f71f493a3663b10fa812d17f472935d24be
> commit: 689ca16e523278470c38832a3010645a78c544d8 Bluetooth: NXP: Add
> protocol support for NXP Bluetooth chipsets
> date:   6 days ago
> config: hexagon-randconfig-r045-20230428
> (https://dow/
> nload.01.org%2F0day-
> ci%2Farchive%2F20230430%2F202304300014.vFGw6Dr0-
> lkp%40intel.com%2Fconfig&data=3D05%7C01%7Cneeraj.sanjaykale%40nxp.co
> m%7C11316289cf9545181d0108db48d0676b%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C638183832151571141%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&sdata=3DeIEMVERAnzpSUne5cHVZ4E%2F4J%2BDI0
> yWQv0muvQCHGx4%3D&reserved=3D0)
> compiler: clang version 17.0.0
> (https://githu/
> b.com%2Fllvm%2Fllvm-
> project&data=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C11316289cf954
> 5181d0108db48d0676b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C638183832151727365%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&sdata=3DqPIgkv4%2FfQT%2FaNq5p9oGoU6bcdlA7Afgk5EcmmzAUDE%
> 3D&reserved=3D0 437b7602e4a998220871de78afcb020b9c14a661)
> reproduce (this is a W=3D1 build):
>         wget
> https://raw.gi/
> thubusercontent.com%2Fintel%2Flkp-
> tests%2Fmaster%2Fsbin%2Fmake.cross&data=3D05%7C01%7Cneeraj.sanjaykal
> e%40nxp.com%7C11316289cf9545181d0108db48d0676b%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C638183832151727365%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DOb0AKmINs53NPoF%2B6MI4
> %2Bco1dbRThKLdfqWeon%2F5G%2Bs%3D&reserved=3D0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://git.ker/
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2F
> commit%2F%3Fid%3D689ca16e523278470c38832a3010645a78c544d8&data=3D
> 05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C11316289cf9545181d0108db
> 48d0676b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63818383
> 2151727365%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D
> Gr95jXMcCmzeEhCJbbUaz05ng1APFM3Go0CtIK6VLdk%3D&reserved=3D0
>         git remote add linus
> https://git.ker/
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&da
> ta=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C11316289cf9545181d0108
> db48d0676b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638183
> 832151727365%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdat
> a=3DGqQ70C15HhFspSctvuCHHbJliFN2mv94%2Faw%2BrBjUlB4%3D&reserved=3D
> 0
>         git fetch --no-tags linus master
>         git checkout 689ca16e523278470c38832a3010645a78c544d8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross
> W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/bluetooth/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link:
> https://lore.k/
> ernel.org%2Foe-kbuild-all%2F202304300014.vFGw6Dr0-
> lkp%40intel.com%2F&data=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C1
> 1316289cf9545181d0108db48d0676b%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638183832151727365%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&sdata=3DfuRUTaxTT04M2tT6SUVJDRWbTo3lAkdxgSTk4ov
> enh8%3D&reserved=3D0
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/bluetooth/btnxpuart.c:10:
>    In file included from include/linux/serdev.h:10:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +
> addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m
> macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from drivers/bluetooth/btnxpuart.c:10:
>    In file included from include/linux/serdev.h:10:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +=
 addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m
> macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from drivers/bluetooth/btnxpuart.c:10:
>    In file included from include/linux/serdev.h:10:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + add=
r);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c
> on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + add=
r);
>                                                          ~~~~~~~~~~ ^
> >> drivers/bluetooth/btnxpuart.c:1277:34: warning: unused variable
> 'nxpuart_of_match_table' [-Wunused-const-variable]
>    static const struct of_device_id nxpuart_of_match_table[] =3D {
>                                     ^
>    7 warnings generated.
>
>
> vim +/nxpuart_of_match_table +1277 drivers/bluetooth/btnxpuart.c
>
>   1276
> > 1277  static const struct of_device_id nxpuart_of_match_table[] =3D {
>   1278          { .compatible =3D "nxp,88w8987-bt", .data =3D &w8987_data=
 },
>   1279          { .compatible =3D "nxp,88w8997-bt", .data =3D &w8997_data=
 },
>   1280          { }
>   1281  };
>   1282  MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
>   1283
>
> --
> 0-DAY CI Kernel Test Service
> https://github/
> .com%2Fintel%2Flkp-
> tests&data=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7C11316289cf9545
> 181d0108db48d0676b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638183832151727365%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&sdata=3DkT8SZ3zL7FhnwCwY3eSxuj8y0uZCJx4RpYjGSPBL%2BjE%3D&res
> erved=3D0
