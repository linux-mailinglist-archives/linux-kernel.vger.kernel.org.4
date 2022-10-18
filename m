Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8C602168
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJRCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJRCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:48:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848021AA;
        Mon, 17 Oct 2022 19:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlW1zdCfClEx0YLI0IDw2SsXkwKoAdU0B4EM/kBcWeP+UfzjD03cdrGAsMtSVY2oegD+Ix6YfY9eH/W3zpO9Q/kR+iOSF1iS2j2qvglqrmMoiAp8aT2CtcKvBcmLX3nqqnjbvuo7SmxT/XQdcfixkm6x882trmiSd0m/DyqVoAKrasdBqcBmKdUwI3Ethb2G7fizwXr0/D+i5bNboWRZ/3Rb9LwzxVOUWk0KDyyOtVMK+gpCBZjyIAg5Lc9Y+vzeawE3xh3FDiBcI+ns9r5w1XU6flR9mkv5E+Z1EXR5QSujeGyWWdgH9pRr+rGs9WV9wCaFathByacs3avhBiOcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTlOmRo0zi01hMW2zfwA6tn3oW3bBS6AxZeRrYO/Mj0=;
 b=JSqteS0m0YyTmy2jyw/zcL/x27GRW1afqYTe/i/Hhwnn5Ly46azDco1qiWo/Yi4Jf4ivmq2fSv91Sm37hVngaaXFB0CBlvfLKy/dVgnGbj4hCpjBPCZapQ3c74eCxRTwFFF0nOaUDO1oWsNzKfncohY/AHnpLUTWoIrrv+Uc/u//r2dJ9lnbPYtjX3tbLKTfLc/ZHBst/wEBLRHRaYD+q6o6XJzxwwYOtnZZWj5zgKVucUiumZd07zfuAPUKg+vWHjZRvke4BHAf6+94bN0PdbG9R/RpUzN14MNPGnScO5p7PbB6QpRR4odkdouu9OiUhOh1uFEfq99p2M8xQ0IR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTlOmRo0zi01hMW2zfwA6tn3oW3bBS6AxZeRrYO/Mj0=;
 b=D/XjxfjIht+K3xgj3B6J5YRHJqKSk3NTKRraSOjNjjd1FIb03Bzyv7EVWXmqKr/L8escrxv13tj3WmgkJm1ZK9jpwZ3ZyS65Lq/q+bRkwHDbN6OcfRrmitARsYc9SJbt2mvdUtgX1c8Lwg+VdgbEQKyoc4mr+HJRmX27bDkau0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 02:48:49 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::306c:ec79:32a4:afab]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::306c:ec79:32a4:afab%9]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:48:49 +0000
Date:   Mon, 17 Oct 2022 21:48:40 -0500
From:   "han.xu" <han.xu@nxp.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mtd: core: introduce of support for dynamic
 partitions
Message-ID: <20221018024840.z2qzt4kac2jilbq7@umbrella>
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-4-ansuelsmth@gmail.com>
 <20221017195820.ve6c3zj2civkswm6@umbrella>
 <d98dd483-70b9-4bd1-0463-9e3343576955@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d98dd483-70b9-4bd1-0463-9e3343576955@gmail.com>
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b78219-e3fd-4a31-eefa-08dab0b34892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FG/+vWbwWz1XYIa3xhquHIAQzizf8zWRFyD2N8DfGMJPe/MFgZ4y5nsAEAkb4bvtDrV7sT5HvjGpNMRZWy29GuB3Q3HYhzsoa8JENYqBj4VWqQMOer1DTzW+ID2FzmDVx0LbBN9j1Z/HeUcHu+YY8JbawaopqP2btATnNniZbyDh6hS0j79ENysD5LMHv6VyTb/rblaSZowaYiBrwisWMb590mvdBJ1D/V9NrH6TWzmxt//1R20ldLMyVSVN6PjVEnhEYUqZ6Fl4YhbC0nu4sucUkwL2vwtkVVRKoHxC4BnAfMdl/ThoA3mgIlVmf+m/LHAnClpWpATPZmDR+ILv8Ef8XoO0V18LK1EVwgaFcCXeKE1DxXd0JCBI+qESp8tgB/L78abi0nZN1fGcCBu1oMpStW95tliXaYE63Dfp/EPj4WbEesBKhiW/0T3XwJa3OWZ1pwElaEEuL/4jwd+fkjrHMNO7zlNDyXyOHaPiYL5sL82uW/7p2KrnQMQANCczV2xwMoNvgaJBzZLygzVuBxZlkeY84Voqb8Wk8qUj2qkNtsm9Q8EQj34SMx9IWCkb2BGugShbkHPQIqNIakXLwnQuCYgH/pJvnzjXWXy4Zjv411XD3KVsKkVeGYjli8dtGX67y7ThtVWhPhn9fw4ebMnDoWUcdXrO8HQ3h+LTx0ZO3XOd3O9Flyg7dLjPbJvIe0qitKyffCZr9q9JT2qaFrm+KLByFBiq64rDJPVW80ap44AVd3bMDQTsAg72mwzvKYIoGnh1yI+3X3EAqemJaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(6506007)(2906002)(8936002)(52116002)(38350700002)(86362001)(7416002)(53546011)(4326008)(5660300002)(9686003)(6512007)(6666004)(26005)(41300700001)(186003)(1076003)(33716001)(478600001)(8676002)(66574015)(6486002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(6916009)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak04ZUlRSmwwWCsxVVE4Y2RTdEgxL1d4Nko4V3pOQnJGZk4zelhIck5Cdm1E?=
 =?utf-8?B?cURCN01vTFVjRjR1YklOSkVVcWtDY0hhdVluTk9aSlhEbUN4Rm5aQ0poZGZl?=
 =?utf-8?B?RnB4Qmd0WXNENXN5YXR2eE1EYlV5Q0dOdG0yQnlOc3JTRTBlelUrTGVjZ1hU?=
 =?utf-8?B?UC94YVN3VExYbDg2a2NmZURIek5OSGJmSm9DNXczdE1NdmVVemRjWWdRQndP?=
 =?utf-8?B?cVF5aWxsQ0JESlNmb1NCWXBXbkt2OWpGL0VoWDA3Q0VUL0RBQVNpWVFwTG5o?=
 =?utf-8?B?SXNzbjBJQlA5OThTa3FxRW5DeVdPYjJpTVRSWWpId0s3VE1zUm9Va0tSTlZ1?=
 =?utf-8?B?cFgrQ01KUmUxa2pZRmVORk00TFM1bUhnM0s1V1BXb0lpT1Bmd3JuSlJQL2Fq?=
 =?utf-8?B?NHJsT0tHOUgzaFpmVjNYeFhldFFpcW5ZcDdMR0JNOUNOUzBUNy95VUFRSUdD?=
 =?utf-8?B?b1hkbzY4M2xPVGVlMmlCbDZyWnJMakhtRVlBZzk3bEZ0ZDdzb1l1SjNkN1NF?=
 =?utf-8?B?ZmkxTDh4K25Zd0RnaUlIK3diN3I3bElHOFM4RlErUHIvWnE2Mk80ZWVxVWtl?=
 =?utf-8?B?ZWVFWTFHRkdjclhBdURQWVY2NWh0ZWpWVzNZdEVtZTkzdmx5eFhlQU5wSnVO?=
 =?utf-8?B?OWovdDJCTE4raUtpSWUzd3owZkJaeTIrd0wxTmlGQ1dYdUZENWNqbzYxUFNL?=
 =?utf-8?B?MGNNVEdmS2ZTOUNmVkFWalBNU3MvY3VUOHdrS2FRRlZqQldBYmZlSHhIMDB2?=
 =?utf-8?B?bU1tL0J0bWg3d3BONnJDak44Q01nMWpGK24rdllNM3hpMW1kdlFVWkExNXNY?=
 =?utf-8?B?THJJK0x0SjUvajBoRUpxL3lkRklzYUhZLy9WSFEweFBENkZ1NVJWRGtzYlpJ?=
 =?utf-8?B?aFRiR25Xakw1b1UwdmVPR294dlZreUNlajBzcGRqeERzbS85QjdrSUsxRlRm?=
 =?utf-8?B?WGRzNEdoOG1QUy9YUWtFWW1ma0hLT0Evb0poOXBEVGhDTWl2SElPZ0lNb2dZ?=
 =?utf-8?B?cllBeVZPYWxuZTdPcUQ3YklWN1RjYi9Tb0pGMTJZMW04MDE0T0ZaU3U3ZkJV?=
 =?utf-8?B?OVJSNFVZdnVVZTExRWdQdmZTZ3ZNMGxacndLVjBvcnI5OFZFV2VLWlNEaEJ6?=
 =?utf-8?B?a1VRYU4zelVHQi9XVEd4Rkk4Wk41SmxRODNiS1NyelUrdTd4eHdYbmJ5MzZ4?=
 =?utf-8?B?akdQR3paTTIvaGNGelliWVhQZzJHVFlrYzRnczV2emhZQklpVWhNSW5HbC9M?=
 =?utf-8?B?VkJBeTVZTUdvSnVJaXhhVWQ4SjlZMUNzMllXTXowMnBlR0xSUjN2bzMzbGJ2?=
 =?utf-8?B?QmFDeHFCRzQrak1ma0dpZDZQeEY5ZDB5eTZmV3lueXRwc2JwcHNvK2duTnY1?=
 =?utf-8?B?RmNvR2FaK0I0U2ZzZW11aTZzYVM2Y1daeTg0eVZWUjlNWXJQZGQvMGFzdzlv?=
 =?utf-8?B?ZWg4ZHVaaEt2R2tOaWtvUmxseWFJWWpjZ280VjJEVEsxZ0RXbWROQWxTbTBW?=
 =?utf-8?B?WnN1Q3g1eTRvQ3hqODM5ZUhrOFVhaFdQSW1RZGlsd2txZHFNaDFwZjIxOThk?=
 =?utf-8?B?elFUM3k3Qnh0dXdnd3lwN2V3Qm1DVmhoMStWYklDWjRIU3BkVEVnWENWZ3h1?=
 =?utf-8?B?N0premNjNlptemNiWlBROEtlSDhJZFE1cGFtQVVYQ0lyNmgxQitTMzJ5dS9P?=
 =?utf-8?B?dVdkOUMyc1hodDNDZ1lkdDNWQVpkQTZKOWoxRGNRdEx1QVo2RG5GbkpvVUMw?=
 =?utf-8?B?eEFzR291MU9IamYzeXA4R0hTREV6YXE4OHk0T0c4dVlTQjk4YUxCZ2s4d2xE?=
 =?utf-8?B?dDlpYW1XSlpsb2ZWamg2QUFsdm9qWHZDVnFET3JoTjllNnlpTlhzbnJKOXB5?=
 =?utf-8?B?RE5PMHp5WjZSWlFYZU9QV3owZFhZWk0xK2xPTmxlbDdiMkhpOUZqZVAzOSs3?=
 =?utf-8?B?b2pIUDhSZ2drbHZQVmlPY0FWTTA0YWs0VHE1VUo5SWJ1YmtJYjN6WjkvSEp4?=
 =?utf-8?B?Vng2dlZOd1p0azMzdytNeXBHNXlNOEJQVXVNcjJMYk5STVo2QmovL2tQTldn?=
 =?utf-8?B?R3UzMFl1MEcwQWcwcHRzVFYvbUE0NEg1T29oYnpZRGNSZnZ0bFc4R0tNOVF5?=
 =?utf-8?Q?c71yPftV+RWRyApFk1JQ5Ikbg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b78219-e3fd-4a31-eefa-08dab0b34892
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:48:49.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw/gTebivUq+HPry1fjTjg+pgFntly/N3CrjJltrPE81sptJjgT6bDMwpNmlxJR0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/17 11:52PM, Rafał Miłecki wrote:
> On 17.10.2022 21:59, han.xu wrote:
> > On 22/06/06 05:14PM, Ansuel Smith wrote:
> > > We have many parser that register mtd partitions at runtime. One example
> > > is the cmdlinepart or the smem-part parser where the compatible is defined
> > > in the dts and the partitions gets detected and registered by the
> > > parser. This is problematic for the NVMEM subsystem that requires an OF node
> > > to detect NVMEM cells.
> > > 
> > > To fix this problem, introduce an additional logic that will try to
> > > assign an OF node to the MTD if declared.
> > > 
> > > On MTD addition, it will be checked if the MTD has an OF node and if
> > > not declared will check if a partition with the same label is
> > > declared in DTS. If an exact match is found, the partition dynamically
> > > allocated by the parser will have a connected OF node.
> > > 
> > > The NVMEM subsystem will detect the OF node and register any NVMEM cells
> > > declared statically in the DTS.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >   drivers/mtd/mtdcore.c | 49 +++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 49 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> > > index 7731796024e0..807194efb580 100644
> > > --- a/drivers/mtd/mtdcore.c
> > > +++ b/drivers/mtd/mtdcore.c
> > > @@ -546,6 +546,54 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> > >   	return 0;
> > >   }
> > > +static void mtd_check_of_node(struct mtd_info *mtd)
> > > +{
> > > +	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
> > > +	struct mtd_info *parent;
> > > +	const char *mtd_name;
> > > +	bool found = false;
> > > +	int plen;
> > > +
> > > +	/* Check if MTD already has a device node */
> > > +	if (dev_of_node(&mtd->dev))
> > > +		return;
> > > +
> > > +	/* Check if a partitions node exist */
> > > +	parent = mtd->parent;
> > > +	parent_dn = dev_of_node(&parent->dev);
> > > +	if (!parent_dn)
> > > +		return;
> > > +
> > > +	partitions = of_get_child_by_name(parent_dn, "partitions");
> > > +	if (!partitions)
> > > +		goto exit_parent;
> > > +
> > > +	/* Search if a partition is defined with the same name */
> > > +	for_each_child_of_node(partitions, mtd_dn) {
> > > +		/* Skip partition with no label */
> > > +		mtd_name = of_get_property(mtd_dn, "label", &plen);
> > > +		if (!mtd_name)
> > > +			continue;
> > > +
> > > +		if (!strncmp(mtd->name, mtd_name, plen)) {
> > > +			found = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (!found)
> > > +		goto exit_partitions;
> > > +
> > > +	/* Set of_node only for nvmem */
> > > +	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
> > > +		mtd_set_of_node(mtd, mtd_dn);
> > > +
> > > +exit_partitions:
> > > +	of_node_put(partitions);
> > > +exit_parent:
> > > +	of_node_put(parent_dn);
> > > +}
> > > +
> > >   /**
> > >    *	add_mtd_device - register an MTD device
> > >    *	@mtd: pointer to new MTD device info structure
> > > @@ -651,6 +699,7 @@ int add_mtd_device(struct mtd_info *mtd)
> > >   	mtd->dev.devt = MTD_DEVT(i);
> > >   	dev_set_name(&mtd->dev, "mtd%d", i);
> > >   	dev_set_drvdata(&mtd->dev, mtd);
> > > +	mtd_check_of_node(mtd);
> > >   	of_node_get(mtd_get_of_node(mtd));
> > >   	error = device_register(&mtd->dev);
> > >   	if (error)
> > 
> > NXP GPMI NAND controller with 6 cmdline partitions meets refcount underflow
> > with this patch. The of_node_put(parent_dn) doesn't work with cmdline parser and
> > causes the issue.
> 
> Can you try:
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 18aa54460d36..0b4ca0aa4132 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -562,7 +562,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
>  	if (!mtd_is_partition(mtd))
>  		return;
>  	parent = mtd->parent;
> -	parent_dn = dev_of_node(&parent->dev);
> +	parent_dn = of_node_get(dev_of_node(&parent->dev));
>  	if (!parent_dn)
>  		return;

Yes, with of_node_get() the refcount issue gone.

> 
> 
