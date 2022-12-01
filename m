Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2263EA44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLAHXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiLAHXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:23:08 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4982FFE9;
        Wed, 30 Nov 2022 23:23:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyPR8xtI4BCL1DwN0TJLf7Qsgw6l3fiUW9Aigd6CBlVH2x0WoQQvCI1jUkF9M2O0BmQEDnbzJC7T0qy+u89Z5H+W/WumEE+sQU3oJG4yHN1/IWTH1kOVThyfkdjVdg2pY/aIBxJlsNx890ckcmyxc0ObkAjosc337ccQ84ZSPL2i4FXVmPB8t4gV8dBwRDsVtf/jnfw3OdA8VqYzXRS0yhg3LqNRUgH9PsnGx6DJJBVhqXmxw2d39Actogu4tHw8K42fOsezRxeFK7SrlWapNL3/8WAHN/VCsf7O3Wl9qGrHhGOH1nv5nXjxtN4xn878S0zZ9Js7gYc0FD/ZSu9KCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUqCJ82HPMnH6PSzidX/H0fdpuIVytwNRhSCJflFk+Y=;
 b=iykMr2Iv32Q8mc4HC1VLlzTrr67HteUfZHI73az457pBPF6biOMGTj2m2VfJdtOklb7tw+mTSfdzw6MJJ/GR2kMarzTkdLako67FeY+POFSjDfYZIDMKcgRbnbL3lzZU3Kpo/DlkSB9id0LXI35xLnnGel93i7JsT4eKyNXZvRa9QuVM88SIAk1fPAT4jIdKeTPzXGPf5uZh7kP/HaVWkYhNe3HOrLfVkmT9FrsgyKcDwozVp18f/mDPDAI0u2xtDLlR6ZYUJhUdptskx6O54MQka8Trwn953cbly0sl4LgpQBqKSQ1LU7qBGVh/rHW4H20YpDVWspIjlTTP/aS6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUqCJ82HPMnH6PSzidX/H0fdpuIVytwNRhSCJflFk+Y=;
 b=ihtCSpg+YGcM+5eiWch33dKwlN+WrJBeM3sSC9IKJtIxbss8hGlFnDhtQ5ePX/cwJDMnziUf+HoHxrqOplTyvZUN+bLU3Lh9EKn3uijJwysQkE0721ztg9q1J/AfaZxLMaAEdOLnPSe9BtHiIY5voD3qxWFgEjNB6iUE/NpC6eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS8PR08MB6023.eurprd08.prod.outlook.com (2603:10a6:20b:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 07:23:05 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 07:23:05 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v6 1/3] iio: add struct declaration for iio types
Date:   Thu,  1 Dec 2022 08:22:18 +0100
Message-Id: <20221201072220.402585-2-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
References: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0501CA0024.eurprd05.prod.outlook.com
 (2603:10a6:800:92::34) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS8PR08MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de252a6-bd8e-4da2-9f90-08dad36ce348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b//2EXsq+M9HrwHnek3v9rVHYuWthPYNRASf+kZ92G1PypPlO+4n8zJaKrb1UUbD//kaUSyDW7kup2OShb2NKhY8P+FsjWsWisRwZRgR7+wiuZA/UuGS9iWf74V7w9Z1tUfOi4AW5KgCZWZpjBi2rDOPOQlznH8gBXqzKPyfdOaJG3flWCQWsz8BMqXkTJl/xX1/f5SqfVVtDbHkVA/g9qauEQKa/dHLx4CYrUTJeyM2lvqaPLoTOl5n2/qcI2SOipDGqqgdgJLavc3n4gQf0b4WCKf4E3iLZs2SdGNz6YA2nyVFIgzc2xKMbTtn7QKInzfXOjfyzfRMeQ0cutp5B/vFUAUA059nvfgxVvpCzxwkTkosnucXlnibk7Y2AHb8Hev0ODo8XwdeQqeOwrJktLhjnmJ9LYnqFO6tlF3gil5ix1e4FR9q9yO4Y64lmnMPX3uZ67zGN8tVhOMq9tqfHCwQW2RZOuq0WT/fD668QISmm0sIepJsWz9DsIKDZlXyoJ+Naft/L3XU1YFuzPgHpybjoSxYFff+uVHXjk4JhQQa/7zFzQFomSPxxsF02fwBcFiStCTCWAqbGFPI0PKDawYef9EHFTGCajcYcVh13qFF7CUYgGllnEpq4N+kVnTnX7riV92b5pneq7HpW8IJ2Kd6NSZ5qXuC+4dDYEYfzbnczDpoXMr/353ImLpxSDYE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199015)(8936002)(5660300002)(186003)(36756003)(66476007)(41300700001)(4326008)(66556008)(54906003)(316002)(8676002)(38100700002)(107886003)(86362001)(6486002)(6512007)(2616005)(66946007)(26005)(478600001)(7416002)(52116002)(1076003)(6666004)(38350700002)(6506007)(2906002)(44832011)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IVsfZcOrQQfvgf4urp/bmb5qnGZwjgV7rvRE/ZPPcK1i0YJwItAfSUFxg4Vl?=
 =?us-ascii?Q?+QN0hJ5HsJT1jrfMHnI5+nKv2wBdQlKx4Q8tYeDhHeBIuw8FNgmxo9qXL2Dy?=
 =?us-ascii?Q?dE+hZhLqg8FTARxMld758go0Z0jeMQHPQ8kR7DBKLAlT6qx9+8Dbb/ZFtvZg?=
 =?us-ascii?Q?FU/8aak2RQ+6vQgjnOnk7ZDhLF14FIssAdmLB0u8mfo09OOvElOAegeBJZoE?=
 =?us-ascii?Q?OPRGwfeOCneUOKfV1tNsqMAAe470LAFzK0J0as3+hurGQZF3/LEEX6RgqXgb?=
 =?us-ascii?Q?1fcyRk/dOUc14mWhiqzazALnugzfFea+TiKTWgRnsfTCAUDtY7CJEirEJr8e?=
 =?us-ascii?Q?qeQ3l5StMmFSk4Z2agSeJKJEaNAVpfvhr9NHdUfv6ci1QaubegaohrevmWki?=
 =?us-ascii?Q?yfA5NcJRYvourxmx+S7tBPNkHrJhO6UfTWLdN4Fg7xrA3ZlVGpRyOizSZfeW?=
 =?us-ascii?Q?AcXKoQk5wDh+JGFmtdBX237Uo7oaUWcQGHpq2wXK+8S25gIM2prfb9x0A/Om?=
 =?us-ascii?Q?26xLgNI4KlF4+PrzYs9oypgxJUVBnDLbNcpo2wQl9cdTTgq6zRiZTaCv0jnr?=
 =?us-ascii?Q?wIfGnuZ9vio745iRJHDKQ+9eCTamSzfcX6KWG7vF04Cr+wZnRfRpLegGSLEq?=
 =?us-ascii?Q?oiHYfH/498wb/BBPy/cgI72k00WgieDd6wyyxXvX8l4QYvd0g97xP/jcjT9N?=
 =?us-ascii?Q?OMbXVZqrbyqH6t9N1YMi6iIK5qEkn4yxsa9+VHOk1QzaZcwWSSyQaJJ69Hoe?=
 =?us-ascii?Q?U1N10hkyBKM1cts8cQPaOJUdLXreW882Sw843R9ybtA5z1eK46EaJJ2k1bwK?=
 =?us-ascii?Q?PtLnmug9aHlaKEjzGcsUI3AVwo7sVOqsUECaNRDF6LUrQH9JxiGkJSZGwONi?=
 =?us-ascii?Q?yWqCUM1je1Ze9c42mSnxV/fVvVDMkZzpEiMnOGClvLPgD8YRmPqGD9Mf9TCr?=
 =?us-ascii?Q?sQJUzT6eNdExnLCnUrlVOVlmCLHdWbD2yuzQ0F4Sq2ubbqtkiEzV8dAyrnZJ?=
 =?us-ascii?Q?jMrP6WM7lq7C+9eUaA3wDSIwiO4/LcbNxpcsLSzx8gId1jAEJ8K0YL371zK4?=
 =?us-ascii?Q?Xraqfxd5bgjSKnve0Ivpv2U21++BKofWm43eLtBYbYblU2fT+l1ZvXQI8mXJ?=
 =?us-ascii?Q?rDIUo1oNnYF3YeLDQvjNTKq/o3xAHYxvd2rjIsKZ/fc5VZxD/aFmdwIQbemy?=
 =?us-ascii?Q?HCOEMfi7Wq0l/3PEA5UrjrhvZIvywc/oqOa/SAPlZLVYnv2qIvuKzXDWQZQ4?=
 =?us-ascii?Q?PSzCmTVYn0SGso8KpV2tzKr/iXb0Cy1u1uPPMyafoeMVVbsFJIir5UHIA0nV?=
 =?us-ascii?Q?YG1/4XasY84xd/F6Hr2VvawQSlE0WpqRqzdXFuZPxzC9+MsgZaNa/34djbBb?=
 =?us-ascii?Q?0aV2QKxwLMJLQDdFFUy+9lWFnxym2speOqbjoypcZQ3YzGs+IpTbt2U3IbBN?=
 =?us-ascii?Q?TWU7nrv4IZPkq1Ie/ZIZdd1vZr8W47Tjj+1T9By4Za+eS/jqn4p2XhZoNVSx?=
 =?us-ascii?Q?Ly7JAGiRroYvHALyy5D4s75U1MCyh26le2kQEEzqTBa6gzcnz+O+R9lwCfH3?=
 =?us-ascii?Q?pz3fSccT6X+hAVWt5hHgLUbW2irIQEVGeiMlCPLm0SFc0sBZjeSpOdc1hjxk?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de252a6-bd8e-4da2-9f90-08dad36ce348
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 07:23:05.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsNk91WBeYHKn6dbBri0qfHxN2Fg9/iBPqhKb+BXbwTbMMAEneAgnV9pBDi8fKDRemNjAFQmRZVVTClEWHTRQHBfUJQWGN6Uo5k3Z85QshA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct for iio type arrays such as IIO_AVAIL_LIST which can be used
instead of int arrays.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v6:
 - no changes
 
Changes in v5:
 - no changes
 
Changes in v4:
 - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type.

 include/linux/iio/iio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f0ec8a5e5a7a..e5101bef50c5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -381,6 +381,11 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 
 #define INDIO_MAX_RAW_ELEMENTS		4
 
+struct iio_val_int_plus_micro {
+	int integer;
+	int micro;
+};
+
 struct iio_trigger; /* forward declaration */
 
 /**
-- 
2.37.2

