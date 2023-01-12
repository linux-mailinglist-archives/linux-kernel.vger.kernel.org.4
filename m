Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908056679A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjALPlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjALPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:41:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1961E0DA;
        Thu, 12 Jan 2023 07:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUejrCYtQMknSTe3GlwcGOgTw7j3lgsrdhRckBC/pIcBAXccMefDBf9HhAyJgspWk0GCpbP2RdkZJyx6CzCSJAY2kNE4A2FbjIAPVp/Rhhl+jQbA4TfwN+YZvfan+thws6PQIk+NF2QDnqcmuP7Ty+a2RcAeJ0P6XgARV4Fk8R+oQf7bOj3CScHPwBZFon+tIH4NPhcKkxA92gAZoKiNmPxIQu4gtQR3aYmanhmq6b0oPhlPGSBFPfbADFYmYYI/orBUkPwuw14NvGIIAcxxzCwBHjMvI5HdZojvW/wQA2OC6X+nmIZdL9gHU2f97YaKOgf0GBQC4p11D8jaIIMVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ypVkPRINook+yraif37jJjjkLxdxcUoPnMic3Y5bsI=;
 b=EUf5qk0F9H6Bph94QXHGptvcoOZawL9o0gwXDQEzy/mDD8ysHket/DWbI1raCbO4ayoTrUcQi7WdAb7sun+wWoxBA6lMGiILCd3v81HX2wRc2QHDgBCyXPkNaTyaP8xk1l7Bn92xp+5BVDS7oikIiprjfWE5+URhYr8P5LRQr5nxggxYpLLrBQReWnRhHp9O92xdULicuh4PCspzOeH5hj3Cg2RIhN84qnfTnjrwqA3bfM5GxjT22l8U1PR4zdjQCmOXivw9kuw0yaR0K/z+JukklUJHYznC5MAY7KAlJRit0f4TAblRnCGP9D+33SEYeK/17IdPXd7VtOBkLo+3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ypVkPRINook+yraif37jJjjkLxdxcUoPnMic3Y5bsI=;
 b=Wd/89GCB0taZXs9L9Q6N/sJ2XE9ouATh1yvD/J4gIO/osU9Si1Jfn52tzSyvMQ0JX39gLso8E9eqHU+8qU1e5uvuERhpwGgeut8raUjhZyY79FNo6Vr2lDsNhDRKcyjhmDfEh7HXwtgNDZcGfHqhsMpIDHRcYTqzYNdOGazcxQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 15:31:52 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 15:31:52 +0000
Message-ID: <7b7cd84a-e9ff-b2c1-4bf0-0ed05cca76bd@amd.com>
Date:   Thu, 12 Jan 2023 09:31:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 02/23] arm64: dts: Update cache properties for amd
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chester Lin <clin@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Wei Fang <wei.fang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-3-pierre.gondois@arm.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221107155825.1644604-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:610:b1::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: a062c05d-9055-44e5-402e-08daf4b220e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TUH8PsIFKnGxIVf0IAQD6kX28An3Y3E4vLgq7qyZZZHWKQCZ5s6QgaeBmo7vqHsEC3SRvcTfb+gDNtUK2Ko7Hyp7Yg5XIjzzlFzXqLBAgXt0snPUPYaxpSQCytm66e5UqhxWKC+TU1crs1HXZZ5oSpLxFVwY3Br9DUtf10sefl/hN9NoRH41nGjnKizTsQH+U3SDDNW7QgZfIlSXJkOqBPYRJfW48dQyWfNM+yow48r1vW9GQM1FWW1L1JUIsiAizx6v98ulKHj14vwRLRIdtMJt/bT7nIZFwV2K2ZKRj40JRCl29HeFFNl/z8nWHvMbCR/aSEi8Xf4EgCPwk2fBokUsfd0cnpvVWB2vlaq7X/nkyDT/cIEOH1Na7KV68cCqB8xsIZ3jVT41tc1nBuMT3SNfpTD3RE8jWXBdCJooT8izwF3qLbnk2Fzaca1t6QdY1WEvbpocnzcHXjDsMN8vvwojdcs4UoWSDngtX+IWMvZwNP6ono6+iJf+kUAjqnPtBhun2b7idwpH4cYgP9WFqMYmftugqB5r39brHpnZMQx+W9ByFd+ky5rZ8JRHKzs/EcgZK+08jkiyEkyIADW2EfiXtyWnk4OtABuATeA4LDzFf9pqjPklsJC/VwTzDv3ImUIi0xzphkUW5rpq7KYd1qvutD5PhDiWMVF5NJT4L+egWeyhThg0ojkuem+kbA0Dgq1cgS0t/7bodxTvYPfuPK7ZcCBGgxC2+wtFEDsaJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(53546011)(2906002)(15650500001)(6506007)(6486002)(6666004)(26005)(478600001)(6512007)(186003)(31686004)(316002)(54906003)(4326008)(36756003)(8676002)(66946007)(7406005)(66476007)(2616005)(66556008)(41300700001)(8936002)(83380400001)(5660300002)(38100700002)(7416002)(7276002)(7366002)(7336002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3VOZGFsM3V0OCs4VjcyZERYUWZtZ0NORndQL1k0MzlWRzY2dlJnQ0NWc2ht?=
 =?utf-8?B?VHQ5L1V5YU1VUnZFRC8wRTB3N0h5L1BtaUJXc28yZGtzQlk2NWtNaUNEQ0Z1?=
 =?utf-8?B?R2ZHa1Z0aUl4eE5Yd1VBeWgxb2plVGoySU1BN1FIVndZMnpZei9kQit4bEwz?=
 =?utf-8?B?Z1RhLzZYejhGSFVueVd5a0pwVzBOTk1YNDZQR3RCcnc2VW9MTGRFdjh3V01y?=
 =?utf-8?B?cFBEeW0vT0REVG5UM2I2U2N4ZHZPNzhqNjFaaU1iRkhZRXpZNWh6em9VZVM2?=
 =?utf-8?B?elhlTTJ2QUI3end1SmVtN2EyUFVQKytDLzdxRjQ0eWI2SC9IUXMwUk1idEcz?=
 =?utf-8?B?d2F5RmpTNGV5Y28yMmtRNDE4N2NXYzZHNGR3UVd1K29sN0Vjc3dFRFhlZHpB?=
 =?utf-8?B?ZUpJc1JINUtoQW82cVUzOGZLRjRHdllxQWtiMTdjc09GcXNPT2xVUVVSUTY4?=
 =?utf-8?B?bmxLN3FKZ1hBdUNzTERHL0RiNWpPS2xIODJ5VXE0eXBqRkwzaGJhdTNxd01s?=
 =?utf-8?B?VE1nKzVwTElVUHJmOXY3YjZRSVZXcjc3a2xjekRRWWM5ZWUxMlNQSVVkNzAx?=
 =?utf-8?B?TmdQQm9zS3lRelF4ajBOYlRvVk02Q25JYmNoSWREVm5SYVk3aTFDbnBzMk1n?=
 =?utf-8?B?a0luVEFnVmRWaFhmWE96OS9NY3R6R2ErZ21FWlRZL1dlTE1uU1V6bUplSlpT?=
 =?utf-8?B?YjZ5dC93NHVlZUJvMjJiejg0THhLWDRXeThxbXFtVGo4dnU4c3dvLzJ0ZGN4?=
 =?utf-8?B?SEd0R1ZpbmFPMWJFb055S0hvYzRzeWNHSDN1YkdqMVJBZnZwYngwR2RCZlI2?=
 =?utf-8?B?QTBzU2pXWDIvZ1VLaFJhd1hmQk9POTk0OUpGYndXMWtpVU9NNUpBNVhVOE84?=
 =?utf-8?B?cWY2U2VRb3pZdmJyTmZoRW1zbkpjaGNjVUhGK20zUDVDQUxUWHNKM2hRUE14?=
 =?utf-8?B?WFFqaHhwdHRZZVlSVVRjVUd3TDhXOEdVV2ZkazlrU0JtZC9zQzhRWk1SMFVF?=
 =?utf-8?B?T3dXZURyVGtiaVBONmsvYjdQWUFGMjVFNGErUzg3S1IzbFhGdVUvK2xPZFRK?=
 =?utf-8?B?dyt1b2xBTXBhZU1QSG1CR04xQkNlUFFiQW1ianE0TWF3WDZMM1ZOS2o2MTE2?=
 =?utf-8?B?Sk92clo3TnY1YnNqMDJXNjkzY1d2S2hFbjlXOU9UN2tRVTJwTWhiSDJuTFFt?=
 =?utf-8?B?K3d1S3hLTjcwSGlWaDRkN1FzZDN6SXZ1Y2VBT1NlKzQ2clBlMnFxVWFkbHB3?=
 =?utf-8?B?TURuaG4yY1RxUmZvR0tEQlp3VUwwZnVrdEVOR1FqNEVycmtndjk2VTAzK0o0?=
 =?utf-8?B?MHVPZVVFanNMSy83SnRIM2toUmhURzFaT3A1RFF5SDB2Rm1tYlhPazJHQkJj?=
 =?utf-8?B?VTN0MmNXOEhzajg3N09ETkpZTFY5RHoxWkF2bnkxYWFmNEpIUXhTbkJJOTRG?=
 =?utf-8?B?ZEVOMU9BTk51QjVLRDRvZHYwbW9DN05zeTlhTlNKU3I5VkUrdWpReldxbCs0?=
 =?utf-8?B?dlhBU1M4VjgrYTN1cnl5NUpyVDRRZGhkRG1vZEsxUDZjR2FCckRrQkgxNks0?=
 =?utf-8?B?NkRvM1FVbnVQSHNxRUU0czV0enNoaTliZ0JjZFVqYlhsMTJXZ1NwV0hCZmM4?=
 =?utf-8?B?bjZDbDBXZmZpL2xwZXN3Wi9qOFFic2p3MnY4UE4zcmdlTWtBcDlLWmNwR251?=
 =?utf-8?B?Nm9wVktvZGJnR2ZQSk5jNjVhb3hHQmdxa3NXeHovTUF4NVBxSkJjaTVlK2RY?=
 =?utf-8?B?QURxSGk3U3pyWWVXTzVZMktIdXB6a3FCNTNCclAwUThzcmhMd1FmZWFOcFkv?=
 =?utf-8?B?L3g1RTg2OEpUa0Z6SGJlekhSbDZwWjF6UFlnWU1vRnhLR254VWZlZmZxSEtN?=
 =?utf-8?B?RWVFcnc1VWpGdU14bWRRTGNCSGNoV2szQkZZN3BBektrVkszeW9ySTBmYjZz?=
 =?utf-8?B?TnBFV1Bnakk2TkZhcjhweWFRK0tyWi9zNEhuWHlmUDBWUW1TYjlkRjVlaXBT?=
 =?utf-8?B?bVZrbGdZSzF3UVZIWC83OHVlUHYrWU5VcGgwR1hNL3pFTXJZSWMvaTF4b1hW?=
 =?utf-8?B?L2NSWUF1OTRsNlZrUU1RMzFRenMzcVhLZkFyRU11R3JrTjFpS0hYL1oxZ1J6?=
 =?utf-8?Q?B5ax5vAtZ862qfhM6klYHG0aD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a062c05d-9055-44e5-402e-08daf4b220e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 15:31:52.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t/eEDE3kMlj1iHqlQjkoQmkkqShsVxCkGHmhayI6j7xw63i+GnEkqsmI7aUCgFaoBdqh213mqUwtvEhO1vyxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 09:56, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
> index 93688a0b6820..9f2d983e082d 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
> @@ -163,38 +163,47 @@ CPU7: cpu@301 {
>   	};
>   
>   	L2_0: l2-cache0 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L2_1: l2-cache1 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L2_2: l2-cache2 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L2_3: l2-cache3 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L3: l3-cache {
> +		compatible = "cache";
>   		cache-level = <3>;
>   		cache-size = <0x800000>;
>   		cache-line-size = <64>;
