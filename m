Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6381F7369A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFTKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFTKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:44:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2066.outbound.protection.outlook.com [40.92.98.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD49D;
        Tue, 20 Jun 2023 03:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dROIsacczbqrA4k9JRhcc7SDfPuqmW+Z+EV87chbWPqebOvXurYdwIM7PnuDME4M0BACMWzP3evdGNrzqFUy7ABUOggPQGctWX+gj2TG5JHfSgwI1GG9wLh6qa5TNclPODJnX5HEc0d2+kpcQ6WYIhFbU1/uKTyC3PEz7nGkqSkSFarSoNALJbzdW3ULFTH2VQNQSoiW7vg29QAqGo+5ImzuE0WXyI90PPqJhJPRGavOf4c1CqFSRq38CO/TQ5FrQXyiqSxCJsREmJk3C73merRz54j5KzeRZX1JZ7G8YCjTSxdR+nV7ubfdbnPLjO0HoubfJttoKRbPxVAnk+xd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfFsV3+qYHHIILFjef36lPtxBG2DtX9mZshFhrFF/vE=;
 b=BS4ZA42abYtXfNwm9NgMAPmR5AC21BkC062hBHLuiZePTUmEqRgO9EdeZEEbcbCNC8G+OyE6QLWMv3mYEFECjjv5LqyxLQjsg1pu8+w9sIqkxOx3VCW6ou2sU59LGjhBraYDIr+Ik2jTPEwau/uYCGCQduKUiDlleLXFuA0eH0tQIKkfShemN+RY17LNpgWftbl5huYyCm0iMbInwRn4ftV3rrGs5S0/QhIcAcgijp5B5PEFLrGXQlD2RSE8eyQFIyKvndmaKRJ4E3CGzlxCwa2J1SeViyl6NCEZng8xYBWrq20cnbxRNc/FWQ+36ZPHs/oXKfYLzb17cP2GeBreoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfFsV3+qYHHIILFjef36lPtxBG2DtX9mZshFhrFF/vE=;
 b=rADiGtVu0SJ1ye+3dQJWXx9GEUBLMoTzW+Eiit9JZBodYxmjYCpsuyMIl9NImvBPSI/n37fp4Tsw2zEVpX6P9N9zYlNL+EnQ1qmo5GVCyax1HIMcfmfv9rrKLwiG3j+80A2ROdhSgOM0WhvJS88SLqRJzqCAARdaJ897P6RSXhN62gg/VB/5QXdqkNzUEuaIwMfejNAoupPTwUGXJsHO7fGwOQvMFdrwu/MnDDFNZjKQ2rz60qeVvtbQfowINUOs2RvPz3qcpDu8kKPO8tknpr+R/grKuxRV/kbbq80kd/ADebykYJw6dvuRzyzppQ25xGinqh7NqqjwpRvnapRIYQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYYP286MB1546.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 10:43:58 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 10:43:58 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 0/2] mips: pci-mt7620: reduce unnecessary error logs
Date:   Tue, 20 Jun 2023 18:43:21 +0800
Message-ID: <TYAP286MB0315B9598EC3BBB0783203CBBC5CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CLb/ixjjzdBLElFIRLRyxo8cA9FLVKJC]
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230620104323.1736-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYYP286MB1546:EE_
X-MS-Office365-Filtering-Correlation-Id: 322e0da6-d1e3-44d6-de87-08db717b402c
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwUWHGrk/AHBK7arRP2SnzW9RDd9YSWgbbNkW04I/GqsiZsxVUa/sW9NqK0a9aE/lF63p6E9esAeijbSDUa1b4NSJ7pAbCPBWebUNA4hBbdhLtbwmlV9EGIwtGf7Ov+w1URDmrPuJOtRBbLvP8k3WAemScx37ss2+BBBkMF+02tURy6OKAj0Zkr0Qozlr17R5loepw7bJfS4HY1Yxdv7+LGCsvnYiNX2LbeJkuLE4m7GFwTN5I6kisSShPnTf8F/pT8N2Rrc9bY0107g/AgJV4hiD1+Igvz/QyK+pdFc9GgQPOnrSfvD3e+sHwF/AFvllS/Y9Ckq/qGhLb4Q9mEbR7R9veR2IN3xYUvAu6688bCSwUoQTEU2jJC721RQt+HOdbp42+SgMmR8RtI0jdYL7mcYALWSnl85dG5LMiMoocbesot6KvRGB90OhNsAN9Kz8VLjqEa/VT3V4WGmtMH62RyuyKXmE4OlGO40HSoRNfoH08HlnP+XQDmApU/ZYCsERsj01kOGNBjUsEp4CfCtPp30y91nCMVHk+FLdwRRWcSpQfjLLRdExX2yrNFRL+KXWmxVBauxuPmYrLMay/xVfLQ0TaG06k64i/vepjMA2w9IHYl69nnc8f3oUKvs+Az7KOka2RsHUI7GGSwa0LQ4UjAlwi6aGqQRvpYTVKOeWxEn9Gqkro8Vl2w6ZUIJJrTyEVvLVhOaR4StoHJ2p38jrPEN3Ons0D9QiysJubqQ/tfdTLeOVz4X3XbR2LO167iDNlE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iW5S0jrpfyYuigJ3iyYH++IpenxmHptunjimnD4Wlm4ZlPt5poKGIU8npyzXIN1+FzMyMtgeL6u8sTTCUwnpgbI1ZX2Plu9FOCrr2Q5TQGBkDqtGzvU0UuNGn7VNZIT3n5voZPz2kGsW54nm2UwDaYkSxRqsOL4bj7N4k6VELZa/JIADD3CgqvXguLjK1xEHL4ZCUA9wnavDmOS9odJ+lFrJhQRCG6emXFvW6IwWknsPAYMyOIfrIgumtv3yION3RYN8fDEAFHBIvpRkbEKYqF8oIXISBGn/RqKQQKKtHY421LWxPZH0PRR2BN4saQikC/m1fXNTsViITPhJieNJ8xabOIyAaTJ/5aGHKPYVwjc0+mO8ofdf8eG2AXQ5Gt0xk0l3FeJeIGAJ+QrIqv6puykR8PWlsSJ0XJmZ0RHHJeIzzzUDQwe3SYg07tNPiMqTN7alYkzIVXjbI2JRgJB5Lvr0NTOXscaFF3TnoNn7lN/BhFNyiwIpc7RX6NxOxRv3sngArCJrXhMJiDJAYM6Ayzch+K7MOk3MqYhaA4DUwq0AO+H5yKUs2ncnL3oQ/XuZo7eoqfRrF4ZwmObb/XoFqL7NAqXqmqrLaQ1ilMgcnkv/cRycSRY8DNK1zpOruBpY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UeD3/NtL7/q4DCEst1iatK4iQg42xZtFgZg1v5V49p0ie06SYzNIfWuoIJxF?=
 =?us-ascii?Q?mkvJB27W7OkPPXDtA6z2ZsYwzQRKV9NLL6CN4EZEGYHhSBFNUM0ffs26uoAI?=
 =?us-ascii?Q?x0e5sUlCDWld5LPtfY+5wRATAhJdxBt7iNXHHpu3nBs1OzGDAsYt4WVqjaD+?=
 =?us-ascii?Q?qXS8pkQf6bAtJ43SeKFLVFWCWUG9T7K4Dsqz7gZRJNrhaH9+TKmKlut2/5Ve?=
 =?us-ascii?Q?cVqubYrudqw+R3uSeKpImFw7ib6Jucvq4A0rOHd/jZ5zHSK8YgfE3DcjPds8?=
 =?us-ascii?Q?f15lPC54DbDMWAJSXbkkQNKA3GuYelgwvlz5yafBReKI+3A34P0DxdmMhtjA?=
 =?us-ascii?Q?aSxnk7nfCuBDn3Q3o3fmvQe2XPqPug6uAe4W9uoe0JGbbNPLI/0UjCCKkZjl?=
 =?us-ascii?Q?jnezWsYlbsSryGULO8HFaVIdoEeClvXOfEG76Skfre5oPik6M3ria1ac/CuP?=
 =?us-ascii?Q?pU5tFRE+KxQ8InaYkNQGrz0/0MHdJ4jBU4oe2bmMHON/+zcZia+nvKRDWRn9?=
 =?us-ascii?Q?WqSPC2Bc8hYXwmdzN5hQFsiNfKu22NYyvz0GrOdFKX1DVU6BJs3EltvAH9r0?=
 =?us-ascii?Q?9zYer/CARseG2GH+GBs2LZZ3vrF/L1zNPMGEO464flt+mlsaUISqd+psC7Ak?=
 =?us-ascii?Q?KaOtOiD7TgA98HBzfuoy/QNOwY7lNZEhOHEw4/26741DBVF47w45zrAtxDQV?=
 =?us-ascii?Q?nD55d9PNrXM3a2ZDsjFUtsZfcXeZF6mDcx7NbeYlC3bHhmFhzI64FflVzm6d?=
 =?us-ascii?Q?nMGh7h6QLym65iMWgJMuQl+y7S5EbfG+m4vYBAWeY3HEzL/NAR1hZTLTmnNT?=
 =?us-ascii?Q?aV1D0olvL9l/SCYuJe5cFXfxsb6lEBTNMx++0fFbzNA58BK+JYRKF7NQNV49?=
 =?us-ascii?Q?S3bIydCPyML+U+de8aIaV+59P360q+27zMuFBeLr5l4Ys63VRh8QAYS56qle?=
 =?us-ascii?Q?QGgbrup/u9DQi1x3mvBA24NNK8DJgX79WrrTqVUvmMYhJRZ3gNG68luFwEHP?=
 =?us-ascii?Q?ONNO79B5ujiFS+Jvale0fDqTen0LGrSaiZIRz84pBaLPzmG0ROV7VdTYujNL?=
 =?us-ascii?Q?B0e6tTKItKJyMkKfKAvPrRVRqYJD9rkgs6mvAerciBkaBAKaA2KURBm9a7yQ?=
 =?us-ascii?Q?rg8IbnDacupsQE1aMYja8btQIn8bVFRoy23Wrw/WIbbelxk8613SQFC5N9CQ?=
 =?us-ascii?Q?seOZBtDCqbqumkq481gGblGdV4kJ/b40Qus2KY8eKqHVHJUwVsjrPzqff28?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322e0da6-d1e3-44d6-de87-08db717b402c
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:43:58.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches silence some mt7620 PCIe driver error messeges by
removing the useless debugging codes and replacing incorrectly
used 'dev_err()' with 'dev_info()'. 

Shiji Yang (2):
  mips: pci-mt7620: do not print NFTS register value as error log
  mips: pci-mt7620: use dev_info() to log PCIe device detection result

 arch/mips/pci/pci-mt7620.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.30.2

