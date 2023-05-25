Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493F4710F51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbjEYPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjEYPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:17:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AE18D;
        Thu, 25 May 2023 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaqtJCYv8GEOJTt4Jpn23KCOtnF2GS1ThHOERK+62aw=;
 b=bRHY7up55n9tI8HEYkQ24oyx8ZRd/1jpgrk0VzHIC4ZsVsc3mO7Ho/72KYiKqdnUpQJKvQFA7ec9XVBwdZcNZT2YmY2uBEgdr3+Dv9YVGzLKx7LFZwlRaH4zP4Xr+hilrQs5ZrO/r3LAO/VxLQnWi4aQxOWY7gV9tA221/NpZ+E=
Received: from DB6PR1001CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::19)
 by DU0PR08MB7994.eurprd08.prod.outlook.com (2603:10a6:10:3e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 15:17:44 +0000
Received: from DBAEUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::75) by DB6PR1001CA0033.outlook.office365.com
 (2603:10a6:4:55::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 15:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT005.mail.protection.outlook.com (100.127.142.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 15:17:44 +0000
Received: ("Tessian outbound 99a3040377ca:v136"); Thu, 25 May 2023 15:17:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 89d94cfb46a114e4
X-CR-MTA-TID: 64aa7808
Received: from c9f0007a83f3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 383C9FE0-3F87-48CC-8ABA-5A3CBDD1A1D1.1;
        Thu, 25 May 2023 15:17:37 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c9f0007a83f3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 25 May 2023 15:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLK3p1MNARmKMIg7MIUSsWpO1hE6FM4ikETSzfl8vceBzw4SlSkpMnRLbDHF4yDolFK/GGqrVngH2d48Q87JXJuICJ16mm4FPG03MEvhi9wkMLy9Jp+782W22XVcbQY78tU+ScZnsahKR/aT2GAmECpBSE0zNjuhVMYK8rAiPkxpwy7XE9e7eQ5CTsX9Bo8XjkP2d91ypsvP1IWs0VupZgLzW7khnRE94dtKLlnHnSiJDJh4avuk21V7b9UEXocfH4KvfHFRSjsspMKrxoihRU5xkHGLo7Uy04LcpTFJ5h111/t7Nkgx/yTzkjzyhjexr+WNYkzLERMS01PUp1JZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaqtJCYv8GEOJTt4Jpn23KCOtnF2GS1ThHOERK+62aw=;
 b=lr3jIVVlH6AVPnoW7tRl+UZL7h316M7cpdKohHruhs4Oql/BtZoyDV/gfv9QBbV5v+rjmD5nr0BgF10iaww6DOqp9jjsElL3F1uVWvUwXX70SypG7QzuSGGe6akpTL+/MZ7fKalUAglyex2ACSW3wGj1tnoUctSxNIIFXrcM8D33VbJb0X2u1B1CjHdbm83BEDB1GlCzjEhOJq6og0xEHmF69dppnSLTrCSbBvY6kqhe3YGy8bFunzjLTQqYRanTMQ7L0WMYBwMMRHbPlQp5q6KdrSKuRK7aVTiT27I6gCsbE0uGDLYNRQ+8Tp4Cee4SrU9FfrhaRQdC7ip8OZlYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaqtJCYv8GEOJTt4Jpn23KCOtnF2GS1ThHOERK+62aw=;
 b=bRHY7up55n9tI8HEYkQ24oyx8ZRd/1jpgrk0VzHIC4ZsVsc3mO7Ho/72KYiKqdnUpQJKvQFA7ec9XVBwdZcNZT2YmY2uBEgdr3+Dv9YVGzLKx7LFZwlRaH4zP4Xr+hilrQs5ZrO/r3LAO/VxLQnWi4aQxOWY7gV9tA221/NpZ+E=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DU0PR08MB9750.eurprd08.prod.outlook.com (2603:10a6:10:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 15:17:34 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::96b:b3e2:f0e1:4b48]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::96b:b3e2:f0e1:4b48%6]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 15:17:34 +0000
From:   Justin He <Justin.He@arm.com>
To:     Li Yang <leoyang.li@nxp.com>, Toshi Kani <toshi.kani@hpe.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] apei/ghes: correctly return NULL for
 ghes_get_devices()
Thread-Topic: [PATCH v2] apei/ghes: correctly return NULL for
 ghes_get_devices()
Thread-Index: AQHZio5ijWrlLPoKjkaclOfBPO5Xm69rGtXw
Date:   Thu, 25 May 2023 15:17:34 +0000
Message-ID: <DBBPR08MB45386D3C1E4958A36FDA781BF7469@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20230519201249.31147-1-leoyang.li@nxp.com>
In-Reply-To: <20230519201249.31147-1-leoyang.li@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|DU0PR08MB9750:EE_|DBAEUR03FT005:EE_|DU0PR08MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4b30a1-52fc-407c-6c42-08db5d3330b2
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AcmzoXkNU3sCTwisRQXH0cO4DHU0Fr98nSiUoOFrY6XZ487LyRfKo+9P0XgHpVgJiruedsV+fjHz7F0SkeLGPUfWAQ6aUEKcfzw9A7CA8V7vLb/utf7zWnZdVT/0BlGD2Q8MGsH3eFLt3Lzi7gG0X23819yMsYw1Y8G9IDz7DxS+iCcwaG0sXOx/yHsUTdiuEfF07cXmNzkBodgXAW41/sdYZJ69j3r5pV5vt4ggxBZaC25Az5Hqboo6mYTM0Ph8TXkkDmlabqtF0pBZWK3XHTIB9cyMYha4EMaMq73gtdhYKOQPjQvuJYgPoWVNh0tdcSzeC8JrIqoUU34FBhsH7QDOkWjs3p67U4cDwaoupn5d+QjuCw9P9w1or/0bQgkQYdTVkQwWbDFMmypYYPBLLGqYmfltNlTIoH34eq97aLIfmlT7F76DRxyX792oM5GGNfn9yEUI/6jH7wjfqfFLy4YHldjxjq6fMzXzQm/fDlSRtTh5QkvI2pFTYM0WOEm6uShEbH4liv79cg4KqzHlV1kJBaXhrCvfdnszcyyznZFD60Ommkxa+u+OFjJq12DlQkey2Bav/I/o8oTXi69+gqeTvIYHXH7YEh7qssMMMInPpM4QjRGjcSIrpKkLSFgR
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(26005)(9686003)(6506007)(53546011)(33656002)(55016003)(83380400001)(7696005)(186003)(86362001)(71200400001)(8676002)(8936002)(478600001)(38070700005)(110136005)(54906003)(5660300002)(38100700002)(2906002)(52536014)(122000001)(316002)(41300700001)(4326008)(66946007)(66556008)(66446008)(66476007)(76116006)(64756008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9750
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 94e61f9f-b565-4c43-a052-08db5d332aae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMBqGNQjPzd+yBFCyRN867o/tpGfC8q6ZHGra0K12V0oErQ5h2couFhjp8FrQ/vEiPEqBblyaoBfXxDv9yz5YrWZdtE/+KEf+FDuJ1xtSM88US5keqgPAAtqvP57Wxa9e7AoSRVMJOB/DrzYSJNTN5BtrS6dXWBIew1ko6eXXc1SvhRsmXi0nQf5ab3lVLx9bwWAdqNAM0Ex5asfBTWr7nSvlEF6DxAR3TUaiwA34BCcsrwhoyF2KoMvoAcS9h2/HlWo0/YZnquu8R6EQznCv5jgiDmpHybs/qMqEhj0+AsreFzlte86OoXGT5bGfR7R4n4JvyHKeOjvVVHP78qcQ2vg1ltu0S2woEhLwHuees9YMZRaLdMTEnW7KF6yZXpDkNPUGoYNxASuzmtojdjMs88l7/PkcBFjEdyDpQWlR8VYfe77oXRz+wgfxRi5Rgw/8ZKiYaJ/CB/X58lwLhqKyY9z6ZH4Ed6QNOL8FH5tPU4bwriOu4xX0b+Wkn+bWF7q57LOfDm3diAxB5CW8SB2VzlMsjov/vHsplUAMaQekt0FZLrnzD+hHupxoLBf8981GFnGhQ6i9y0L49JqqFEeh1xWyK5ZD/iOOcV7e7hnJMZDEG+ElB9jsZF1LQlYUI/ul3QdG7e+C4kWgtZSS5KkU7A7bp1iV3hE66qmdk9Tu4eW56q03hP5fAQyYRk3OHMRAkDAo8eE/p/ZmOyXt86xeW/yRLcPN/GRcYCCOxR5nzPBjfRCJ1HWRx0sclhpM1Mx
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(5660300002)(52536014)(336012)(86362001)(83380400001)(47076005)(82310400005)(9686003)(53546011)(186003)(6506007)(36860700001)(26005)(356005)(82740400003)(81166007)(40460700003)(54906003)(110136005)(33656002)(7696005)(478600001)(450100002)(4326008)(40480700001)(55016003)(70206006)(41300700001)(70586007)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:17:44.4615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4b30a1-52fc-407c-6c42-08db5d3330b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7994
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Saturday, May 20, 2023 4:13 AM
> To: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> James Morse <James.Morse@arm.com>; Tony Luck <tony.luck@intel.com>;
> Borislav Petkov <bp@alien8.de>; Justin He <Justin.He@arm.com>
> Cc: Li Yang <leoyang.li@nxp.com>; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v2] apei/ghes: correctly return NULL for ghes_get_devices=
()
>
> Since 315bada690e0 ("EDAC: Check for GHES preference in the chipset-speci=
fic
> EDAC drivers"), vendor specific EDAC driver will not probe correctly when
> CONFIG_ACPI_APEI_GHES is enabled but no GHES device is present.  Make
> ghes_get_devices() return NULL when the GHES device list is empty to fix =
the
> problem.
>
> Fixes: 9057a3f7ac36 ("EDAC/ghes: Prepare to make ghes_edac a proper
> module")
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Cc: Jia He <justin.he@arm.com>
> ---
>
> V2: fix the fallthrough case in x86 path
>
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> 34ad071a64e9..4382fe13ee3e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1544,6 +1544,8 @@ struct list_head *ghes_get_devices(void)
>
>                       pr_warn_once("Force-loading ghes_edac on an unsuppo=
rted
> platform. You're on your own!\n");
>               }
> +     } else if (list_empty(&ghes_devs)) {
> +             return NULL;
>       }
I have no major objections to the fix. Just curious about the edac driver i=
n you platform.
IIUC, in your case, CONFIG_ACPI_APEI_GHES is enabled and edac_ghes driver i=
s either not
loaded or fails to load. Is my understanding correct?
I wonder whether ghes_get_devices() can unblock such check condition and le=
t other
chipset-specific edac drivers continue with the initialization. @Toshi, Wha=
t do u think of it?


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
