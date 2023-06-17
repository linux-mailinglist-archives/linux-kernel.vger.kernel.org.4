Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2D733E74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjFQFvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQFvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:51:11 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2027.outbound.protection.outlook.com [40.92.98.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F92130;
        Fri, 16 Jun 2023 22:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYcKOLeDH6J/3DHPHay88Kw3Tekt1xaA5bQPiXbVoDw5d/dgzk/I3WSn3i8Uha1rfbmfKQStNH1uV+Rgym+DZBtDDA3RrtgqPYXHdalwDoGX2BWfWZfqYeTpkXLL9pMr7EJ+vijTll43Z+Aj2nSV/Ek6sUAi1BAGu3L9l89yqQ2EydF3QCS+tUyYPuabFNyiyrdtpyQvwXmtz8c6nI6UewmLaeI0VsipDFwJAtTM2Z2W6qfJoBCbzKZl+myZe7wmtdz7vHxG9b4Uo2oJ/goADPDskNv4JpUe7YXc06uacTzoRrRwXVY6Vi2GFJQ6cCzdh84ClhyMjr2kLuBO1xMZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLueVn6kaK+CvU8wAYp6owmC9cocm07Ms0Sj3DSeecE=;
 b=BIPlvgmolhsnXT6+smoPzmrQCLcBlTPLwK9dm4x7zh1ezJTmP+d3LObc51SJpuGc06JNhvjnUGRRRePb7/ozrw9N5iYqf/AGL/gLhF7v6+c7puLDQbWFShtkvZgeMw/NC6161ilqZrtBUoa3AtAQRHze7uZQuefLJ45EFEoHO2pKhf8g4KiTeIIwv62SS8ypSinjki9BpvTtNuCGwSUh04eNql2wF/WY5c0slLDarCo2NPkMz01ZmkBmbS3YDOqSYozDcN52dGkb+ERhiHMbluKUYEE7vX9WApSNImHV5khhIBZ9moqw2OuGR6p3xSZ5fKjR5+hrvISqAR1+za3zIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLueVn6kaK+CvU8wAYp6owmC9cocm07Ms0Sj3DSeecE=;
 b=XJSwBwl/k31F4FImKjvU0E3W2eZ2mPTdvtmPQ9jRDbkp6Pwp/ry+9vxuQAoqJmmRtj5vIsLo0n9xFdffsRXgVZwSbvHicKAVlhjrBZsnYddbV1rGLuFGSyM2qGeyyESxrxUtusur1jZX69K8a5M3Uid1GBigfLgzYpupyXim4aStdR93+fDuxjnXNWhFpxE647hNktM2l9tXtVfXVhSOY3/sf4Dm4k0o5ClPR109cuBcbFaEUHLVbT/FvedbcUUgivVtWfmKnsjqDmwj7uBgY7myTe2E4lB5mYdBYusf9sEbCISqvN6WcTXvZCW0y/jXtpM2m3znConKRaFHnNBU4A==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYWP286MB3717.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sat, 17 Jun
 2023 05:51:05 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 05:51:05 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     sergio.paracuellos@gmail.com
Cc:     arinc.unal@arinc9.com, devicetree@vger.kernel.org,
        john@phrozen.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, tsbogend@alpha.franken.de,
        yangshiji66@outlook.com
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
Date:   Sat, 17 Jun 2023 13:50:52 +0800
Message-ID: <TYAP286MB0315C2088627FB035A5D43D6BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAMhs-H_GjHU+r33oeytXiyu+bgGTrGL8Ck=DbsMYnqC-XBNYYw@mail.gmail.com>
References: <CAMhs-H_GjHU+r33oeytXiyu+bgGTrGL8Ck=DbsMYnqC-XBNYYw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ijDvypgcElqj1vHa+rDlNAGCEYUzV7RM]
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230617055052.1416-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYWP286MB3717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1732af71-254a-4a0d-9fda-08db6ef6d70b
X-MS-Exchange-SLBlob-MailProps: 8U9+OAG/EBLXrpD0CXg53XaCeaanzWAblMfm4oyWw6jK1jtVyyGz28gWRUati8w6wq4zi9tobDBIxLRYAEmtAYCDsB0UitKpmTxFvAguYY04c+ActtIIOomgNetwUSKlV5WVCr+HbdxPMunDnLrOLykybRJIQK0S50aepp3xornlRCNkLRUxEgJHhN35ihNFtUTcQxCC9zX5ZMDOJ4RYxrbHDR2BlLKJm2OqY3zN9uu5Dj/v5u571MjmUuij3Om7ZCl1v7QMT2vTehIInO8P8XEtq2k50gCTerkA4ZyLwETXXMoaxKxm7nAJFBAWqVxMkyc0QsXNWyXzyGibZHyv1ausNE3d/VAeVuU3aPYci61hpTfbESO1HhRFeDfyPwM9YZgusFmE30Bt94PCUnITkVa105Y46PN+LbIHKDYmBL9rHmAq6xqPhbUEILULS9djPd4O/maGykRUkobFq8M7VdcQ+wnne8ybQfrxLVfTu/Eu13CGx2a0QWfzudFFFM23F7BLGFjd/HxaVDlrmJfhxB6/ws5ttyfV4yECk9RZ0i5cwPA4xcRiaQO2QIxw16jE5MO/hqdYAkXNU+Pc/uowOOqATMMiqgs9lRIQgvEimcUMu2bVvumPbSnAoDaC9CP2L7f02kiUK/NSNHKkDHhPYbxFEzQOEZpp83aDxCcbaNiVOl4y8TtnhC6LLBe3hErzD38SBnd8mix5cjMkLe4SKMFtTfW6OZlMkJqbEVXmGHwn+DBT3meah/ptfJRd7dmDretgdcj94D/YlQds/i73WTnWpnRcg9xdrCfoXtp41baXFXyCmmDy63j7cEtcHBRm0FwUR5Vph2dR7d6eC3zYDg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlP1BP0bsw5yKHJYj4jzkgelGWORVAb16MuCg0Qk55PT8ywTt4/+fY76ZBIpXc41cvUADURo7N9yqKiqei+XYG0FwIxwJ/wmv8t3aQYhi+eW0Azv822DAfZBkQwVnDEPTe7HiklFx21uDWbHKQ64zdGsHiBypu6pO7xouGeHJwvjgl0Hocx8+yV+qNt4o937bpFWQIfa7zzxdoU3r7buMcgFqkM6o3kTQwrgBVtCpbtPuqaZ3eZ7D3gkre/yb0LLHd0bxDLLiZxDxTe3+cotOLZ7MyjwM3Ukm0WHeLou/UMAYxAAFdOBxc82qPE4BFST9HWqIZDdJZWGsR8LjINsisEoUDb/dKaQwCCusr+sA/E1TdywjmhcEfal+Tq/TawTU41LDt+MyQJ+e1L0ZBAgAcJLi1iKVDLDDa+N5DlO6r+DXUag8+qrMipqCsVuiv71ROHUVg0UqzQtQqK7JeWwij2+nJGehdr8IFE60UzuGCz1QXxTtsTYaLyHeJ3HJO3HXGiETEy8WUMA0gDk4H8rfIxAZ85zm0Doz1OGYgYe7wRk5Bxjj3ADfFLTpUzogqr/I9SfNuZ6lGuquOLZK4Y+mTvEh04rnxVjE66AssILiaHHaq2O9EDWNYyO8VnGMziYEV4akbDEWml1vGGy6rOneg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NyXizcRknSOBKxcrkpKAtoBsHOTbJFcVKDDBfcmtAOGwG1FPnP+/hWXJl9ZT?=
 =?us-ascii?Q?i6GooVG4RaNHyh4GA84dsL+d/cS7KaPAOU8L8+W6ip7KEBAiphm/YqzmQBp7?=
 =?us-ascii?Q?uS+t2IkPg7X4OlC6EeQiiAHVJyrnzL1kv0lKaIQIU+okGZFTrDqOI7XD9Jt3?=
 =?us-ascii?Q?CACTFX0ZtmQsyqAhA6VDtxZuBTCMQsHgZIhCaGJIo1uhxV2QrpfgXLQKGhtu?=
 =?us-ascii?Q?8jFI/8cssLDquoIl3KymZnqm0IFIxmz4GWiZTvk6Ymu5GqoRRbfKQ3sVTo8D?=
 =?us-ascii?Q?+kcnsbmtHi38uMFVeBRqwlfsioSoORsU/7BS97Qv0DQ7oOoPzFsX7I1ropk2?=
 =?us-ascii?Q?Sz37xyy5MClldLWNXPaomEQDdQf8HtI7GLONOH7O3EwY85u9uz/5a+JsdAiG?=
 =?us-ascii?Q?Rlnyn9ZY2rsyUVEbLbNGnnUJtMkO3XQwtDZMZHTbrdCPKkSrUSQ8y8uypSh3?=
 =?us-ascii?Q?XPPfFTy+6PRZhIE87HmWi7RbtqeSgd7jpLC7xemaP7oWiexJdHX0EtKZg71m?=
 =?us-ascii?Q?X/AKEDdRujl2nqty6UM07Bd0v7+xNQnSxS8SFcIKznkubeQby0dYXruNi3gq?=
 =?us-ascii?Q?efbHUSqTzyaDijn72qHeN9obZOOyNm9ULO15c0den/rgCyNN6dJmujyOsi5W?=
 =?us-ascii?Q?biUraQP+diOQPyszPZC8D3mflEni2mZAZGNtRqj4Jc111Zw6wgb/yG/oa3+L?=
 =?us-ascii?Q?SkDbIJI08BDqmQ6mJ+m+07ETA0WyWKeP4HF+/dQRtfFJWGlYnt3Lb911bJ7C?=
 =?us-ascii?Q?RHUZBpxUpQ0ju0r96M7kJMZuqIrGJf3qR78CH9cBNM3FXeFpDYOAqIUDrl7T?=
 =?us-ascii?Q?ddWMxV0B0LUz1uI80uq27O4kRP1zCXjzDbs54qV3/5c/1CdeEmTlZ0whk4UA?=
 =?us-ascii?Q?372k6ZkInXkBoTGv25BwYPBYi24u0YJPr3iqzF+aoYT0w/DkeISE7s0A8pIy?=
 =?us-ascii?Q?NjwdJ3kvvCydzlGsyRYzspkjdusbr53dekPRGW04DcqixsqWHMboDuxsKZUC?=
 =?us-ascii?Q?dpBzDIESN1lVZR3mTYwUeM/yI9FNaULWAew3MsoNcVJLF7KZerJ3w8MR2ew2?=
 =?us-ascii?Q?YcOYOXa0Aa4154s/InqalkoXiu5HYc0+mLD/3gD6RdJfaVr2LcSf472fxiWE?=
 =?us-ascii?Q?LPni4RdAz39my1B9505KptziWjcX9Nr1NStB8IDR6U0pofCS9xtD04tUjdem?=
 =?us-ascii?Q?61QdaBE1JzoHTUrQHLX460tweREsBhkf3oNNEPQC3MPeVkX0xiIJ/NHS058?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1732af71-254a-4a0d-9fda-08db6ef6d70b
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 05:51:05.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3717
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your quick reply!

>> >+      {
>> >+              .compatible = "ralink,mt7620a-sysc",
>> >+              .data = &mt7620_clk_data,
>> >+      },
>> >+      {
>> >+              .compatible = "ralink,mt7620-sysc",
>> >+              .data = &mt7620_clk_data,
>> >+      },
>> >+      {
>>
>> I am confused about the difference between `ralink,mt7620-sysc` and
>> `ralink,mt7620a-sysc`. Do you mean mt7620n?
>> https://www.mediatek.com/products/home-networking/mt7620n-a
>
>There is no real difference. As you can see both of them use the same
>'mt7620_clk_data' but since both compatible strings already exist
>somewhere I introduced both of them.
>

If they are the same, perhaps `mt7620a` also need to be checked in mtmips_clk_regs_init().
Or just remove compatible string of `mt7620a` and update dtsi files?

>+static void __init mtmips_clk_regs_init(struct device_node *node,
>+					struct mtmips_clk_priv *priv)
>+{
>+	u32 t;
>+
>+	if (!of_device_is_compatible(node, "ralink,mt7620-sysc"))
>+		return;
>+
>+	/*
>+	 * When the CPU goes into sleep mode, the BUS
>+	 * clock will be too low for USB to function properly.
>+	 * Adjust the busses fractional divider to fix this
>+	 */
>+	regmap_read(priv->sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
>+	t &= ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
>+	t |= CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
>+	regmap_write(priv->sysc, SYSC_REG_CPU_SYS_CLKCFG, t);
>+}
>+

If we choose to update dts file. We can also remove the legacy
"ralink,rt2880-reset" compatible string by the way.

>+static const struct of_device_id mtmips_clk_of_match[] = {
>+	{ .compatible = "ralink,rt2880-reset" },
>+	{ .compatible = "ralink,rt2880-sysc" },
>+	{ .compatible = "ralink,rt3050-sysc" },
>+	{ .compatible = "ralink,rt3050-sysc" },
>+	{ .compatible = "ralink,rt3352-sysc" },
>+	{ .compatible = "ralink,rt3883-sysc" },
>+	{ .compatible = "ralink,rt5350-sysc" },
>+	{ .compatible = "ralink,mt7620a-sysc" },
>+	{ .compatible = "ralink,mt7620-sysc" },
>+	{ .compatible = "ralink,mt7628-sysc" },
>+	{ .compatible = "ralink,mt7688-sysc" },
>+	{}
>+};

Thanks,
    Shiji Yang
