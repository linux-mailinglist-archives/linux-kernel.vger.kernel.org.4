Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565815EE07D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiI1PaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiI1P25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD71B440E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCMw+hiNJINadyWHoEMvUUAjwDp+nO7CdVaRgDnWdZxDEP1bCTvKc0fGWyZtZFDxITTHHCPOCfHu0u1EeKZcctmKjwhGLGVlehiVaUlh48X25uhlkk2jtnNJPX/o4V8cgD38P8V3hNxPmtW463aAdLbmfO6EbQNx/Tdt14MjdtLt86tOXTUnrHghkCcGD86aKF5QW421/sM7U2fgBvZfHC32MNjpgbbjB9jPXFhiWu1jiHUT8DqfpqeAjX9in+wuY7LrNDBpNVJWiPIAcsAHcDQoQHcjWrgDtyzYIInngrxmZgucYWkfgyagjEPDZASja8Wc0oWxustS0lEcFjj/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+C+1HiLffpCiNVzgUE+c7mu01C85JhAlfiDeG61OJ4=;
 b=fXA5z6OOJV4QAOSJ00DovV6Pb4OWgGeJmBDBijOr9lH1CIsyWXEMa0ScAg9MSLLOPHRA/z9wbciZO0n7ORPYVKJLH5hE4xwKfRCdDM+1YOnkiDm4dKHDx3cs663FwJbOpRP+fhM3XF3Hc9xfjQ3q7MHVSmD0meEmYiTdkvDjB9StWvQPRTvzT7/qxw4aEiIwWq4yI/EAZJ4147CcjCbUHXr3KTXwd9cPlgfhK2aG3BI1X8dsNCkeNgvhnFtDX7jA1GbhiC6vhHoAFqbpw8UctGMaYa1sc7uVtFbyPV91NBWQJNP7t27uwRhJ6P4orMFXOL51iH1zSZnvkkYKEJtH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+C+1HiLffpCiNVzgUE+c7mu01C85JhAlfiDeG61OJ4=;
 b=WUIx3oLruH2zElKGWaIllsCkBDItrPflis/xGX9PN2otKb6DnPZ/v+hF1j5YRJXNaZEoL6SlFVLz/PpNxFJvAUr49sUOoJSzOio1pq4MsYgNfktL7jkg5m7ZpMwhGbsI+uVCkCg7iQfG1U3oxwT7LimKN4A9pC5w/OVelZeS6fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3087.eurprd04.prod.outlook.com (2603:10a6:802:b::11)
 by AM9PR04MB8067.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 15:28:54 +0000
Received: from VI1PR04MB3087.eurprd04.prod.outlook.com
 ([fe80::5c3b:17fe:1047:42f9]) by VI1PR04MB3087.eurprd04.prod.outlook.com
 ([fe80::5c3b:17fe:1047:42f9%2]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 15:28:54 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     linux-kernel@vger.kernel.org, ioana.ciornei@nxp.com,
        leoyang.li@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH] MAINTAINERS: Update drivers/soc/fsl/dpio maintainer
Date:   Wed, 28 Sep 2022 11:25:29 -0400
Message-Id: <1664378729-24815-1-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
Reply-to: roy.pledge@nxp.com
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To VI1PR04MB3087.eurprd04.prod.outlook.com
 (2603:10a6:802:b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB3087:EE_|AM9PR04MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: bf985e19-52d8-4591-3945-08daa16626c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBk1Usmkhj0Hdf+f+FWQWmfYOqUqhIVksAyzT2nPmAU7dQHR5V8h3u2zMpKVrLGwHxMoNMnpbRELcalG/TZENor1supspTmUk1iIqk/9Bm/ExFLqBmm3zWt5oKX6AyPGOMl7Tdu+lxVwzWCnp9snsIgN+Lga4aCoU9dcgMy6PRtxEcFqLISpL760Fydw7Xd7/f13cSsk984L+sbyoFaKwNn21u1JZlXMjNFVA3rFYJTq8yOiEuuQkTWBjpjB/4G3uFJnb8ED57pr3949qmJO95831GfYPzlPL04S4a4QJaYEYMvwdlu12c7/TAIyEDV7nqx0aLk+7/nyavBxw40lFX4FQWcLp8tmbO+EpDqMbGGwq+Cz271pWrr3GGMCwfqARN6eEOX97/+jUyONUTt1YjV2HD5Z6yUe4Rzp8+YmLBqE/YSdEuXljQFYRx0Wf9JeZPTC+mtG9ApW/carTiRPK2nPlLftBRRG5Y7ycSDeFlBjWpuDSqvvBoB0LXrJPBKFvXs9tUSyo2cgtvzRWsaaz2swZ114FdQl9KxgI7ooHmj5bKv64TCUC2yVSsNVzsaW7G/t2nQaDW+rxRhZpUJ4MTJru7UbQ6TbPG2bz0+1SINBbOhUtcNn68qWZ5quP6vcmo2ztkz/FyraBTPNcWE2zu7UYCcSgQSXZJs51Lwrs6IhDCppIW3GBDLa70M8J7lfTXsiES0rqUmmTmKnLJLo1danRb71bLJcuvSBy3WFnPAaC3A7HsclDbYldvgTquG+9ZnVVO9ee++Vbx8fmXq90g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3087.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(478600001)(6486002)(52116002)(6506007)(6666004)(186003)(316002)(2906002)(2616005)(3450700001)(38350700002)(6636002)(83380400001)(38100700002)(26005)(6512007)(36756003)(41300700001)(8676002)(4326008)(66946007)(86362001)(66556008)(4744005)(44832011)(15650500001)(8936002)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQtoYWYKU+z8i2WTjuSVd9JeSHPmV9HBErH+htFJm/gcPYfr+h9fqC7gLuD/?=
 =?us-ascii?Q?K07WjIMG8Rd90BcLQtTKuhi2rNjwEhGyaZlHpMYcWaNDdKvt93irDxu261LY?=
 =?us-ascii?Q?LbfDjXH2mjxiZTqoXBiVoSEfnZ/lcft9dzEMRsp+dui27f/3B6QlDg6F/zGO?=
 =?us-ascii?Q?mzj64+w1H5SVojrmnFzgZRaGhdE/5fN0hkgusHFCVmfVd/Q5O6eL6D5ynjyS?=
 =?us-ascii?Q?igxmHYwamYQoL1h7ayCEVGlIuIYZcj3mC+oMrSoqFAkq1qGSDOjCdCC0MPWY?=
 =?us-ascii?Q?kUYKlP14BCfqqeVBNWl21ARI1WvJmLc04MrgZR1B+OXkF9qRRReLAIo6KHFt?=
 =?us-ascii?Q?5yohBQ31/4/rmmIjJcrPO7KXvPnye57/RDCwzBeK25Mrcpcs+UUQ3RteHv7V?=
 =?us-ascii?Q?Ae6U9dAAW2dZN5Sqf0hS43zB9pmZXeDiWxmoqXCOuj+sw1wdq02TV7qVc4tn?=
 =?us-ascii?Q?67126QoH4mO3GSQ4TKpW6lNAx5o9LRk6BACXlopV2+Pz4zWcCXasK+YeN27E?=
 =?us-ascii?Q?Ty1pbSqxTw0gX4QJliOzPhsn3w74R34SYhpv9xQ/zffizrBuBGsMQwh9BAHV?=
 =?us-ascii?Q?h9JVupoKidvO4QUCjPZWFmGFzTO1EYE2adkC4NG+2Urhb7VStL9PUCVQdzPp?=
 =?us-ascii?Q?ii8+WRA6SF3FI8/m/i5T/LQO47bBdGzhiOJruWIi303e/PdBk7v+cBrE2gVg?=
 =?us-ascii?Q?ISMvELftE+pnbQ88AnULx0NlStRdTmpEkaOKwFtJbOv+eNDIXg9W9RQD4Osu?=
 =?us-ascii?Q?haM90NHanFQisaV3ah+ADs+mdriHRLf+2+53hu4sDiDeQBMLAcm1Wa5nmutc?=
 =?us-ascii?Q?9ErcOp9IdS3XdHntM7gcXhg2X+ar1u6uMnp9KvQ1CtzNTJz7eA7JpmKCXqoq?=
 =?us-ascii?Q?Er+94PageL9FnKKSNuuI+A2hu+vXM5yLI6bEzwn1ViF+Nsk7lOlQN4tB2v8m?=
 =?us-ascii?Q?oLzbK5zVu/RSbrvIe0hk2DK24ZmJxiOytJmGP9NKwoE/q7rKJ/MOUStOniBL?=
 =?us-ascii?Q?ma84212YiaqyUrkX8eXxPKj+AXLc/CEJ9MKQmjX6H70mTd0WjgbtCKxvMsBF?=
 =?us-ascii?Q?YqzEyXVzjT2yd/9mveREcief4eeBg0xwYUOCk+9pXhnDIOf7WlchvI33tXJc?=
 =?us-ascii?Q?0SEBr6EPr6Lpq5uc1CVSaT9gNuBFulu+p+/VldLonPUhAxGgtARV3UPI11lJ?=
 =?us-ascii?Q?5uzR684WP2CeTuDYb5w4ydf6oa4zfjXpsRFKPHDgwzqFrjDQGtIDUtPW5b6S?=
 =?us-ascii?Q?gr0rtr35hl1aBmVYYJAXCYHanM8yBPJmh1etxfMyr0HMjlMYbz3EKVpkLMdG?=
 =?us-ascii?Q?HkeAP/HT33qSL+BUM1su3Xp+kzSVXh5fTruSgd6jwRI1VHhw+wZBblTSyA5S?=
 =?us-ascii?Q?IF611tFKQppMCz1FHRfX0trlhZeA+EGnTCxO1G4yERUMpu6kKHDdFb6Y3DBe?=
 =?us-ascii?Q?ddqAZpxIDDXfJ7Yy6viuM/0jQoDyC6SW3jIqCvqE8nDco3NJXADUMe9QgJhV?=
 =?us-ascii?Q?UXhvWzKVyfFECWh5FmErfm8CJLffBGNDTOJnX6vxA2KIWkpJ+pMAzqvX4upZ?=
 =?us-ascii?Q?gKdGXNtEqooz3lO20dI7IacO68hYpEeQmhFtZvmp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf985e19-52d8-4591-3945-08daa16626c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3087.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:28:54.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3D/VbJqzyBecsm+T/ktvQD+MBrDYu0aMfDOMIe4+QXIcxB1G56JfgRi/K4CzjvjmvPYnEcGslMrRoS/A2yeXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the drivers/soc/fsl/dpio maintainer to be Ioana Ciornei

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4e3151..875f5cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6309,7 +6309,7 @@ F:	drivers/char/dtlk.c
 F:	include/linux/dtlk.h
 
 DPAA2 DATAPATH I/O (DPIO) DRIVER
-M:	Roy Pledge <Roy.Pledge@nxp.com>
+M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/soc/fsl/dpio
-- 
2.7.4

