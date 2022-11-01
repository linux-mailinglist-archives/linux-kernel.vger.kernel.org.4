Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D166961446E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKAFyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiKAFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:54:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8CD14029
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWdv8JEhQZsOeOpdxSYaN83+cOn5enXWXKZS78zEu7mG35smpwAsgKZgJMFUUldNJtAoPg8sOdrnaOS5dsSpMYKzRi80d/x8c7EOPYvwE35fPlnIGRwEb3PcFd6zvly7WnitmNeBkCDIx5hvY0kPmSkpGkT1YgzLAIaXTuikOiPCZ1uCv6OHIqhoIb30ZREm75T0gGO+ByIWT1R+5GzQDdXSpzoMQPSJl2iR7ynqkbHlegwSraNZM1S8X3/jygX5qjMgAOnfrgdaqHDyQ0DewEcMlH2fhp1Ap8iscLrBOFGQG7GXzeli2FFaO74xNm+bnBQTZHAgEjs1mupeN36InA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuirbZ2/O85beU+sd0F6z9tKYtBxNjrg8ztaokaXOzI=;
 b=nLrdC+uwTG2atXPyeKRFPp2c0R1OH1u24xZrd0ty/sWBH7YIMNW/FT6/V6UHY+PqbiEzMpBvsZ4uPLm2pBN8DfzD1Ms3DjyxCtLveDC808f7j1qPvdOud+7kNKB1bBIE7STKGty1zAAqgOV3GnqL1Xkk/nmnpEepwJ4xUD/aJld6AqpSNUNGKVDWGmmF0V3CBXrhk3NOHvxDBU36i6xf02XFo3+GAvEb3vfIjzjH7TY71F+pZapnO9ryMkpUlQasNYEBssBnXggAX48c6/CpESDLyYWvSB/+4aagC5MntmeYXRxW4YRlJEG/LjMNfpARCvNhJQAiqkqzrOC9Dsa4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuirbZ2/O85beU+sd0F6z9tKYtBxNjrg8ztaokaXOzI=;
 b=OXrl2O0ODz1s+odB3CWc1VcCOXAZwJWUFyYJtdMz/kDR5OW7VJ4qJqkCe91XDjbJsLhMsE0VxE5WiZIVaFStqjLnuIZUksyCXH79XEMXB7atiyJfgO7y9qaLqjnsWlM+JqxlP/4vg3B/y5rD/3Y5uIEtWi/+7DSOaq3JSk+pSGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM9PR04MB8665.eurprd04.prod.outlook.com (2603:10a6:20b:43c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Tue, 1 Nov
 2022 05:54:41 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 05:54:41 +0000
Message-ID: <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Date:   Tue, 01 Nov 2022 13:53:49 +0800
In-Reply-To: <Y1/sUfeVy1a6EKZQ@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
         <Y1/sUfeVy1a6EKZQ@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM9PR04MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: a8719d7c-8c07-4ff6-cfbd-08dabbcd9164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anEI+9gs8xlB+kbKkT5yn2DJ7kul1n5n1fj2AU3B8PiXI2mtzbidjWCYQsE8ebkdLfJvbNXOknVXQy/XbYxv1YmWc6zEY6+/c8X7Iir/0y6NxEN1ePOVPPA+hJxX07nnkJF9dt9A/i+nJNWS7A+K5L+RF3pwC5fIcraBMUxbuoJVtcknR3xnB4zlF6bChZvwDb/XczEaIVJWjC0ZzOntCCgEajzBU6dkc7HVGSMcbZLdGIpUNRKWTiilp0WnvzleeYsrlSMtvWBRLmRc8aDjnuBBQvVcxgfjZRzN7QgcwS+flSMXw3KPGoaoJwvWbfUsqXdGcJAg8VHpp34MlfGooaDPDy5v3a76pTw+jgWy4fPbcQGa5wq4Rax9Ndl4h/QhloLKmuwRwhDv1sf7qVc4YHcVdvsMq0dP23hf6pFsypeWsakfAwS+ukuXRE1QxjUWKhOAnYpxT+31pDBVtNCI+5+nys8DqIWs1eJIvc7NyZaQH5QiV3moNTnPFGwEZgiRQugfoonHLK44JVdkeBdEVpZQ93f2sM3C+C51D8emvP17pcEchExtxIY8FnoMMHR2JOYXyAW47N+vsJlbdAvgTIiHLGpdGX3cyo7+maoBGovSwizGVDVkwXrOYE0eS1DVM/N4rdt7hNgF6LmRwnvPMTV3IqNZyeWD1bKxYy/sFrJc4uAffaZJstoNu4grkbaOw+uhCYlWm5PaJGgqLPOvRTlod4WrPaPzidAwMRkg6Ua6jafY0Qa+/Krc2ojYoZfjpHJ91fE4dl/4gOIwFDMaow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(8936002)(8676002)(66556008)(66476007)(5660300002)(41300700001)(4326008)(86362001)(4001150100001)(2906002)(6486002)(6506007)(52116002)(2616005)(478600001)(6512007)(26005)(186003)(38100700002)(66946007)(38350700002)(316002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJ1WmFLOWhVRlNXMXBkRXhhQ1Q3Ylk0RTVibUJHY2cxVEMvWGk1TUxXTTE3?=
 =?utf-8?B?ODBYV2owZmdCZ1JVZ0RIRG45bG9qeWxTd2ZFV0FHeTJvK0V5VGZXdWtPS1Nk?=
 =?utf-8?B?QzBYc3NTaDdna0ZpUWNsd2RLWk8wYTBmc3N3NDFtbDlTWFFwNGJ2OVFwL1RR?=
 =?utf-8?B?RjlwNVpoSWVjQlFGY0dkMDNRTGFUWkNidjQ0SWtRSmVwOFlnWU0wL1NPRXNy?=
 =?utf-8?B?VDloSkhXbVJKeW9uc3F4S1JVaFozK1RmZEpvWWdqbFRWMWVpSHc2QndGWVJy?=
 =?utf-8?B?L1hiK2t4ZnU3d3V0bWRmWUZMR2tlUHF1aTNOVFpTbFAxaHllZUJRWGlWc1Qv?=
 =?utf-8?B?NEFKTFArNE9LaEl3TEhnNmpGRkFPZnVNUzNxYTMveCtPanFrdXNpcC8vOTlI?=
 =?utf-8?B?WFMwSWRWTHJLb0lUdzl2a0ZDNVFBOVF3WjJQYkJJRm9ISW5wc0pnYVlEbUFV?=
 =?utf-8?B?U2YrbGlFa2F6QlhSUDMzUlJYVzNuUlNkZ3RrRDVhRzlZSTZaM3p0LzRFdGdj?=
 =?utf-8?B?Z1VkUFgvWjg2NHRxUTUxL29YZGo2OHVXLy9yNlZOdlIyV0U2Nkc0bGNrc0dy?=
 =?utf-8?B?U3VSWDcyL1h2RzNucHowSDFwUmttVnYvcmc5TE50SXRwVXNnT0d5MWxqWjV3?=
 =?utf-8?B?UzlsZng3TG52YnUxdmE2NUJqb21BWHp6WDBiTXpvaXdEaVhNblI0cjM5RW9P?=
 =?utf-8?B?R2wzSHBWSjViZE10UUFlOXp4UkdqZVM5U3hSR0pKcDV5eTZ1TTFjR01yT3Q4?=
 =?utf-8?B?M0Y3VGZ6L3phbE1Ma3dGUkx3ajA3blZMSUhvVmNRK3dqWjlYRzhIMVRTZmwr?=
 =?utf-8?B?UFVOT2FNbDRUdGdmMGZaVmVGdkRCUjkzNGt4ZHR0VXZYSlRxY2VCNVMvOHpa?=
 =?utf-8?B?RG9XTWR0RURsOFRJMGpDNWxleW9TazFzNnpqckxLU1pTbVlDMm9TRE84SjBr?=
 =?utf-8?B?QTRyOTRvQ3J5aUx1Lzg3TE5Ya3g5Sml6UmtjR1hkSTNWWVJ4aHU1M243eHQ0?=
 =?utf-8?B?SU54SmdjME9wS3RFQjVZdHprVWV2ZmdxeUpWTFhIY0lRbGF4UmNjNzFuY0RM?=
 =?utf-8?B?dE9GczhMbDdBQ0ZYNlJyejhPMCthc2crb3V3UG14MTJvblVDaE9zaXVMK0hE?=
 =?utf-8?B?UEN1b2xEOExEdjVLRk9YUW8zTlBxT3ZQdHd6NVpWL0ZLYitmYjlDYUliWE9s?=
 =?utf-8?B?allJNEc0S09Ja1hPTllLSGVXN0RNL2h0OWhKVUN3TEtEckVCU01VMjdPL0tz?=
 =?utf-8?B?WjBJNkhMZmllZjVzSFlEdU1tdHdHRDJrZ0pHeGpTa05XNDNKMnhiWWxjY1BL?=
 =?utf-8?B?Wmw1VzJBa2hsZzYvRTJsUkJHZ3pteTVrODFObWg1ejB3dk5YaGRSR1h3VFFr?=
 =?utf-8?B?eWVGSzE1TjcrU0w4MDhMdGFPL0JlQlJ0L1JtTFEzS2VHK0pJZlV1K2R0UnRT?=
 =?utf-8?B?SVZiU0ltcHdUM2xWaEZjeWZMQVEyMmRDS254V3FhUDJVdXpGWjFpZm1zQitT?=
 =?utf-8?B?Q0dTbUY1SURBWmJZQVljRlg5MjlkWnhUM1dTR05QRDlLUThKY1pKd0I1bXVW?=
 =?utf-8?B?eFYwRzUzODFvRUpRUENrN0RDS3Ardy92T0p3Wm9PbjZVM3NmQklSYWZvSUpl?=
 =?utf-8?B?NVVoSFIyL2xBL3l5clFzTCtHVlBoWkEwT0VqU29DdmJzMFhSaUk1NTVQNlpC?=
 =?utf-8?B?SjBzcmRDUG5mUjFKa2RXbTBtdzhpOGRwdjNVWTdES29lRE1Ub0tGOERMUGc3?=
 =?utf-8?B?Z3d1elNPOGp0V1R6WEttNDJ5RGVEZksvdEZkOFI1UU1QK3NvQVhOZ0VZR1NE?=
 =?utf-8?B?OWZxQzBtUEszZFpITWNYMTZmeExieExKNjZYUmdaNDZ6ZlFSVVF4aTlVWnNj?=
 =?utf-8?B?MmlLTWRMUGQzTnQ1MXlFaTJBRlN4UTl5QWs5a1RXTi9lTkNnL1BtdlFCangw?=
 =?utf-8?B?MStmNk5FbWtZaC8vZ25MOCthcmtpTTJnL1NxaXdza3FGZHFWTE1GMzhyUnVx?=
 =?utf-8?B?UStXMk5DcXhBS2R0cVY3TjRkYnA3ZjJJL3NDdnBOMEZEWFlPWE9jaFpVazYw?=
 =?utf-8?B?enhMTko4Smc5bkhsU3ZVdTNybi9KT3dVOWQwYXBERlErajhVV1RTaXk3MDhD?=
 =?utf-8?Q?DJhuEdjIYOHk4DB7767os6J6S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8719d7c-8c07-4ff6-cfbd-08dabbcd9164
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 05:54:41.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbDen9rJu3xXFaRbheeIfeD5g7/+aKNgZPZfPuU9CgTePDTRB9koR2kOO2rEQPVLZ9wL5VOzNmG1EvRAtnNo4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> On Mon, 17 Oct 2022, Liu Ying wrote:
> 
> > Freescale i.MX8qxp Control and Status Registers (CSR) module is a system
> > controller. It represents a set of miscellaneous registers of a specific
> > subsystem. It may provide control and/or status report interfaces to a
> > mix of standalone hardware devices within that subsystem.
> > 
> > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-managed
> > bus(i.MX8qxp pixel link MSI bus). To propagate power management operations
> > of the CSR module's child devices to that simple power-managed bus, add a
> > dedicated driver for the CSR module. Also, the driver would populate the CSR
> > module's child devices.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > The Freescale i.MX8qxp CSR DT bindings is at
> > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > 
> > Resend the patch based on v6.1-rc1.
> > 
> >  drivers/mfd/Kconfig           | 10 +++++++
> >  drivers/mfd/Makefile          |  1 +
> >  drivers/mfd/fsl-imx8qxp-csr.c | 53 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 64 insertions(+)
> >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c

[...]

> > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-imx8qxp-csr.c
> > new file mode 100644
> > index 000000000000..3915d3d6ca65
> > --- /dev/null
> > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/*
> > + * Copyright 2022 NXP
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	ret = devm_of_platform_populate(&pdev->dev);
> 
> The use of this API does not constitute a MFD.
> 
> Please use "simple-mfd" instead.

simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
simple-pm-bus driver would not populate child devices of simple-mfd
devices.  Also, the simple-pm-bus driver would not enable runtime power
management for simple-mfd devices due to "ONLY_BUS", which means it
would not propagate power management operations from child devices of
simple-mfd devices to parent devices of simple-mfd devices.  That's why
a dedicated fsl-imx8qxp-csr driver is needed.   

Regards,
Liu Ying

[...]

