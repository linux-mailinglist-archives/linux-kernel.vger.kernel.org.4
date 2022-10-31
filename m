Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6916131DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJaIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:45:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DFB0F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhdE8RE536rjSqQ/EolICH6pS6JbodIbi3AAZDEB7qksUi7uAJK9r6UywZPAEBPnN21DGy6JMWW+3YazG8Qr4g8susIsRaj/ad+pjRn7QYSsz7OK4ogMQPNZeFkO7QsafPCgydKrlh6Et6flvxwX1pXKGm4o/qzdXvDgUsOh/sN1NUi55ofMdBxORip1Hzssv0l1fSKlY/qsTgrPQPB3fgA4uOaYjL72nux3P45Q5fUN/3YQHZ6NZD+Dq5r2wLJYTHRw3b4t++E5GjH+z3o5Cj90iILbjh+30BcgGAri9d6cbVNSIi4BGu7fGyKfjaHrWh15K/ND0DDuxdMxqqbbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODDQcKLt4G9CVZ+1hYxj8ZXKpc/9AzQnXbag4U380HM=;
 b=jHi4EV9JIP63XSZ7o4PejdT4K6mlqKecP7KFwz6xAvUQonwrzgYExsQ9KLC5dH2dx8/9XRxGGrSCwhvjwYckAZGDxzJy7mL5xSHz5m4aa/QMIbsRj71+wip4UQXVhoAIx+rB/fAzxRZUW451dgTYWjXJHOBtLKiZ7pe4gkq8i8hcXT8okZow3Lnk/6IMkKevjQ0M1CyQhfZy/6b1u8kXh1tIL8CKD0GFMgADcu9Y4TRiqPhvMvOO/4wrAHfy7mBxDfbimiX50SxCZPl/e4kKssz2sqmEbBjkyRFdu7jNZLyhwwFjHThvAoS7M/6caB3B/TXwrLcAyPOCSAtv8z54Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODDQcKLt4G9CVZ+1hYxj8ZXKpc/9AzQnXbag4U380HM=;
 b=nK5YCdjk6LIMFfwbM2XZLIgOzikAvcB0FRol25bGlEGviK+fLntEEZGXYqU0xz/CqzEa6lmJh64EhZRwnffL0A+3OK8O8XlT/2H4wz/l0jW3Ej+2bfBlDOxb1Hfb39lMHhpavdndWBrRL5fIwtTkVR0zVD+TnFQYk5QaxMqO0kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB7453.eurprd04.prod.outlook.com (2603:10a6:800:1b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 08:45:46 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 08:45:46 +0000
Message-ID: <c7114aed1e21a6903137ba9288c4d6f6c429fded.camel@nxp.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lee@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Date:   Mon, 31 Oct 2022 16:44:54 +0800
In-Reply-To: <20221017075702.4182846-1-victor.liu@nxp.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d03469-aa93-4df4-15f1-08dabb1c4da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBHSjkuytQ9OELeT1vGr4BKi8fg7Y5cZS8Fek0gSjFtESNVck2Whfvagv4HAXE+zGwbfcjO0RfGYM4tANgbFvgvKlyzY8ra0wNnbSCOkGUI1k0cOSIcqNevqepKkQ+UmpBnpk/BvQGwSZBLNlkpcoG8VDfRFtQAAvVGS5Hd20RIhPLcuO3Qvn6zG0m4jpiHar9RW4Rb8ZoiiYohRq2d/4boxheYf56Gpfq27pTv2hmBKFyLatfCmruS0C9zKsLW3A1EfsUHJRgmAGZxECYCL03eNLKrk+FQJUlDqmCc2RrUbki5P8HbowOxdFTLP2qD+B6UqpeYnQB7jyk6y2DHwHsKhhef415/d0kU8dkJzluXfc1etP+Y/5GVr7JKmlX2gGrZBk6/vvdVSfidQisglZ4ReI7KNzVWfjNwjAfFv1elVq2yNAtbHj+hpj8Ekv2beR49/+CZbkTwbzhuUHxDjidDC4yg0Qi+Zn1Bi5gHK471j+FoCpAM+WFK7dFFHh0eOGoLtEX24VoHcr3AtbX+0ThLyvrt4ZcbVLqm6rRwP6qpdPm18yOHyVw/0UW2twpzszTtIOZS9ZfHhI4HUefjtTN7GsuHOMmzbPwakOTdd+kqYh5pbu06cm265iFY5L36gY4o+k85Rc4HkoD4v2EfLAjjFQg0Ux8ttvwrXb4romwXswnG/PiAomrouTta7azdLOPSEQl4e5CAnhZY81j9WaUV8LVuXgjJ1mlQkzzObB1dKRBgWc6ZPPLJGrMrzItaqlOHMngyybblezCjNDngG3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(186003)(2616005)(6666004)(6486002)(478600001)(6512007)(2906002)(6506007)(52116002)(38100700002)(38350700002)(4001150100001)(26005)(86362001)(36756003)(8936002)(316002)(66946007)(66556008)(8676002)(4326008)(66476007)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzA0V29kVWk5T01DMWZjdytvekkwNmZBNGcvOWlGZ1pSNko3OXlwbjgydEFX?=
 =?utf-8?B?U1ZpRjZWbFI3ZitscUVkU3VOVzYyNTdiOU1MbUFxWERSeERKblhXeTY3bWhG?=
 =?utf-8?B?L3A1RVpTdVkzTzJ4aUpMb00wYm9iZFdzbWR0amt0V0Fqb1RsRUs5aVlaZ1pF?=
 =?utf-8?B?cmQ5alY3Nklac1FKL1hIclBGZThiRTRjT2dDUmszQnVMc2IyUWIxZ0Y2TTFr?=
 =?utf-8?B?ZmlKREM3bHdkR0pTd08xQzh3eCtBOU1UUnZWdkN4UVR3WjV6VzRkK2F3UUw0?=
 =?utf-8?B?blRuWlJaYy9KaFlST3lEcjNZQ3doWldUNE5uNkdtUk5hTjQ2N2x6WXhHTStH?=
 =?utf-8?B?TEJUMFBIbncyZm5sMkllbHQzOXM1QXV2YzBmWnZ0cngzU1hZSFordm9GNHFM?=
 =?utf-8?B?ZDExaStnVmNsS3ZHNUc4ZnJialpVL1Brb2Fadm9XaGtPYnhac011aGxLSEVS?=
 =?utf-8?B?WnFSQXlxS1MyVWEyeHFhNS9RRVNsMTRiUlAweHBQSlZ2a2ozUksvcHVjMUx0?=
 =?utf-8?B?alRCRWF6V3BDdVY5aHZqNnhFeGZOQThSa2dKWGRSQ1ErMGNzaGRlYUJCR1p1?=
 =?utf-8?B?bFZTUDBpTmd3aTl5K09kamVKQUNrdG9RaGJHNzBZUWFNRGdjQUVjRGYwRVFz?=
 =?utf-8?B?NEcrdVAyUk85eHRneTJlY2g0TEE0ZmtuaUdDaG5DTGcveloxaTdra2RlSUJi?=
 =?utf-8?B?UWZhUTdwdHo2elFEQ3llUnV5ajdxMjNoaHY3c2dESFhBZ1l0RmlEaHgvOXQ4?=
 =?utf-8?B?dXpHbnNuMzYzRFFhdUpoMVRRSG5ac2VhZG9Uc05PQVVZaXJDaER4RllKL0tL?=
 =?utf-8?B?ZFFJR0h5ZG1XQ1hNS2hzSWIzdHFyN05BdEJSZWxaQVRZSWk2bitVOGwvaGov?=
 =?utf-8?B?SlJSM2MzOVBaZjdVQmlmbUx3Mm9wWlFxa0lGRU8xWm02Q3VwdkFRbjFUZVN6?=
 =?utf-8?B?VWJLWjBkYTRHVXVLNVk5bmdYZjZVNHVlc2crak51aGlYYkNVaHozTXQ5K2hG?=
 =?utf-8?B?R2d0TXhISGJEL3lYdld1YW12SjZSZlAvY2xuR3BXOVRJSU5Xd25sK2RkMkl6?=
 =?utf-8?B?MEcxZmJPSlJ2b0NYQjZ2M05EcjNQWVRLaUZOMm1vcVNEM0gxWjd3YXo0bnpx?=
 =?utf-8?B?blorako3TGU5dmVVWm5OZFRoQ3VTRUtUNWMxTEhtY0k4NUs2Ym0wTVpDK1BZ?=
 =?utf-8?B?YWVwQkM0bVBsRGp4Ui83cFF3YkxseGQvSWtsWnZpOUJpekdwYnltY2NuL2Nz?=
 =?utf-8?B?UlU4SWZxQWV5SHVReHpMKzdCblF1dWFUVWRwcXZFZXZxaVA2UUtZWmJTZEFR?=
 =?utf-8?B?NWx0VDR5dVJ5K3pqd1pnUUtvK1JRT1hIbFpzSGpQaUZnQUxyU0NDa016enNS?=
 =?utf-8?B?aGcwOERwKzVmRkNKaGE5Qk5uNUdkWTR3UGVpMzBORDI0VUNMdFB3RE1JMFM3?=
 =?utf-8?B?NEc4QlVFckwraG1JdGVINDg1cDBTaWJyQ0VhMWZzS1owK2xDQ2gxRzVyMlR5?=
 =?utf-8?B?N1BlcFprdUxMUVB6N3YyY3hLaGJraktsQ3R6dmlZUWZweUhhRm9vZERIT2tt?=
 =?utf-8?B?d29rSHAwMFZ4QTRwMEd5VHhBbkEzTkEyZUQ4dE5aejhtdWZpZXNSUmhDeFUy?=
 =?utf-8?B?RXJCb0VmeHEzTWJpclA4OS9TVVhsT3BYSTJ5cG03dDlGcWFBeFZTMDJtbUxT?=
 =?utf-8?B?Snc4aDd4TTRUcXZNL0ZVSTl1bkpHTTM2d3lFeDJ0U2Y5NERDVklSbzJUcUZR?=
 =?utf-8?B?ZzczeXE2NG5JblN3MGVNaGxKS09qS1pkRkpjc0d3bUR1OERFN2NaQm5UWVBX?=
 =?utf-8?B?dWcrY1poL29hdjc4QlRGZlpVZHdKQnBUTSsyQlpEUDZOM3hsUHduR21CUzF2?=
 =?utf-8?B?ak1uVkxFZWlGcmk1M0FxUkxLdHdxWDFHS2xWWFRBVnh5NjAvZmhRKzlmS0xO?=
 =?utf-8?B?TXlkRm1RalZ5MVRKWlZva1JpVkpUWEJoNElNcXlsWkhIYTZNWUt3WnIya0F3?=
 =?utf-8?B?b0hQTWF6VjVudXlzaDZKdDFBMWlBU21tRFgrQXd1QUlPL2t5dXl6UXpCaENV?=
 =?utf-8?B?VFhRMlpXcGtQK1RubGRIcjRXMEVtQTZ5eVd2SUFvMm1RRzNCN1VwNFFjTFY2?=
 =?utf-8?Q?QacARiF6qWikhnGEYgWLuik5Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d03469-aa93-4df4-15f1-08dabb1c4da8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 08:45:46.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FAP2fSo5LAFi0IlFtIGgKvNabSum6teDqHKG/H6ZF160UDRTMG2i1e7GecQUXte8Sfhuq53xfvOy11E+3Qoiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-17 at 15:57 +0800, Liu Ying wrote:
> Freescale i.MX8qxp Control and Status Registers (CSR) module is a system
> controller. It represents a set of miscellaneous registers of a specific
> subsystem. It may provide control and/or status report interfaces to a
> mix of standalone hardware devices within that subsystem.
> 
> The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-managed
> bus(i.MX8qxp pixel link MSI bus). To propagate power management operations
> of the CSR module's child devices to that simple power-managed bus, add a
> dedicated driver for the CSR module. Also, the driver would populate the CSR
> module's child devices.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> The Freescale i.MX8qxp CSR DT bindings is at
> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> 
> Resend the patch based on v6.1-rc1.
> 
>  drivers/mfd/Kconfig           | 10 +++++++
>  drivers/mfd/Makefile          |  1 +
>  drivers/mfd/fsl-imx8qxp-csr.c | 53 +++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c

[...]

Gentle ping...

Any comments please?

Thanks,
Liu Ying
-- 
 Liu Ying

