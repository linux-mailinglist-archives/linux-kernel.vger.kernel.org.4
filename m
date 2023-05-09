Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799806FC4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjEILTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjEILTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:19:42 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2077.outbound.protection.outlook.com [40.107.239.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEBA46B4;
        Tue,  9 May 2023 04:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNpdRUGWuxAAan8L7tQRXS0arlIi8GI3uRHMMyIIY7h7RR9LDgI7QnES9t6O64hZUFE/nPCercZvdIm6aKiik1UoRLHluXecfXIPEZvlTAtfoz0WqohQ4BmxVgNrFzmoJOcI7Oxt9KTKn5HSk0zojs4nn4bpVm0GGSs0zcrtX29hpbrKFXACjBv4NFYX8EAUy5rAVC7DIY94XxvFSD/WiIsnsYODmFtFPAyCTzVxFzk5+KDWmISnQn4DkfmbOTUCe+hx5MMch6xE3cLdX2X5Kpj5wiKpcJaMkF/FqKMu6hMSqv9P4n5Io5dxpGP7WibvcnLaYXmdmlsUOGDQZkR5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVGhN2u01rYSUjrOz3+gHPadzsLF0tfe6UF386OJeoo=;
 b=V//JBJtsyIU49XH/lsmZMoFznrvfCB5rBQ9CDz8jHO/cwvYaG+UobcRWeesgqoNGKdS+nmbxzMFRiLxlL/6Z5/1PBEP85Hm/ZHbmo/ov4OvP2a3Vg8M5AH6mElbSruzTp0ht2gyyrnZeZsGVTsSW0/wpCfZ+uhqrXgA+Q37Bmo8qx1JFwxWcl9ibzzQZr2p+3YC+Si6BAwZEtp0l78KSIgnqWD9tMZ9ntbEBaYimtEWO1DQ7mxv7sfby0roVu4COrfAsbf4RLIvAXGtZG5sCAOiUqFk+RmpL/1nRHsNhaoK0NcrcH5z6Tzc1yXF3Fp6gVZrQrPJJG9skI6EH+8sPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by MA0PR01MB9627.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:19:37 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 11:19:37 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     himanshu.bhavani@siliconsignals.io,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: fsl: Enumerate Emtop SOM
Date:   Tue,  9 May 2023 16:49:18 +0530
Message-Id: <20230509111920.3301542-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|MA0PR01MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff2a19b-532d-4f38-af23-08db507f466c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLjYMTq+vtGO7eGHhFHQ1FRThLnChFo6hxVrNZMZq5GfMGKaqTNPRJwUK/WwK77NIeL7ShonojiuUDY0da4J9zIvF/FwUEcYBoWNYYPVt6kubGEkU6O0MRcP+79INME5Ooj89CbO/+lwMKClcDu0bY05aBXyJnA4LsdaupMX/KvtvuwaY0MRXUJwsaOJIFkvSTVTyuDMOpN0e0MgIaaGrEognzzudX3qOrScuCOQjw2kxlO79qeEhPPeTro7SBHm/RsqtpJLBE2/Ufj4lVAWS3ROrAvQlxAe9ZjsBVXFzR2t47C07ruhisgcGoozdZcA60EZ2mpPv94UVRslBLRKiiRQNP28WqEU8XSzL1IbUB+VGgG4b3/lERE/6bpHv+u2cG8LJvnw34MkMGtKzRbPoen74dklRByXfa1/LEQgsymvSGD+q5LelIpPXYinrXzFkZNklJ4TbmtOh/M7f3dV7NqUKvYfLVoFtkEc585cGUcZXsFCTYM37qiLtM6WMSP9P+kD7aD2NJPfdw+Je3x2YK4FESF63pFAXamfFFxj8r+mhcR2IcetSJAnVcw/iJiFQvjebGHnmczCilMlZ8MAsvBcg2+DL7Xs5fpmx7jFI6W7EulMZfmaeioBJLlx04AY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39830400003)(376002)(451199021)(186003)(38350700002)(4744005)(2906002)(6512007)(26005)(1076003)(6506007)(36756003)(38100700002)(2616005)(316002)(6666004)(6916009)(66556008)(66946007)(41300700001)(6486002)(66476007)(4326008)(52116002)(54906003)(86362001)(478600001)(7416002)(8676002)(44832011)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51GbaFN+1zTonW0XzvEoRoQD8+VePpZfOqevcxoFUTnZl/UxGaVAi0+tf5HT?=
 =?us-ascii?Q?sEUbxl7k880Y/Bf15g8f8H7OfZ6jjawwVHDh1vTW61zhtde0/MAI7mznRBAb?=
 =?us-ascii?Q?HUfxQxEhxuLV2xpfzvh5ERj07+cvgm3/MSSIQpW1B+FiCj/8GqpRJt6aOltf?=
 =?us-ascii?Q?hS+LFiKW8HQpxnX7wtkp52QS/JlG+/lCEbFzNdslU89ys+ny7iKmjHyEO4aX?=
 =?us-ascii?Q?dT/UdSMS1o0aTO4sEhQYYLkJYtkuaoP08JiX7zAKDkfXlnChcBRSwFFvWJGk?=
 =?us-ascii?Q?fUWi5PGxWtOCXkA6zaeaEfLu1OddcTP/zRv603b+PM2CFFruah325MCfzrgS?=
 =?us-ascii?Q?ql+iSsUB+VHE+LezZzz1K1iDdOJ/WoxpDoEPEqpb36rOgngtipZXaJpEV5Qf?=
 =?us-ascii?Q?BywojxP3FTVjJwIis0ereFvoQskMclRZju2l6LiDFw3GkVyruW6Ny1bkzLLN?=
 =?us-ascii?Q?aI52aGRlmEcGY7RIXi7vgMLKmSaaVxs2Pj9TLiVZH9NaCFL2s5/uq0r1kB2u?=
 =?us-ascii?Q?X5Ny5dXK0LB8MOcWpkg+cIsTObDLeW1dwkaF7XHl2RG1431AUciCKCOlE4AV?=
 =?us-ascii?Q?gXOujpYjHm6/w5+gpKtzdJxeMai+RZXjs4aZ6b+rZXFmuFzP8yUON4IVyT98?=
 =?us-ascii?Q?ZRgGXS/AzU3yDKOU24Tb6GOnz19Ns3TsejtcGwvhMkmDlMaeoZkwOGfbipvj?=
 =?us-ascii?Q?jypHeH/rsGhhi/smScR1n1T+KSlWw9JeFVL0QSe7E+dS9Xf6fiEJVedL8g+Z?=
 =?us-ascii?Q?nZoFf5rpgKNZ8sRFL9glIak9b40RoDEG0R/o/kWWjSnoqEp6wioBPNSBlJC9?=
 =?us-ascii?Q?aizAR8dSZq/GOox3ymLB70cJgGMxileJP1PuDjOiywfwjD63T855RJ+73HE3?=
 =?us-ascii?Q?8EFvD1tKJIJkGiFIVBdGnMa4zNW18ac1xtlvXW38x/gig7kgnZbAt6lxNbXL?=
 =?us-ascii?Q?x1Fk+3EZW1mltpAYJsYI7zOltPcXKFW0CDF1lwnM7zI+iXeQEoNIoBX9QK1b?=
 =?us-ascii?Q?Rl8L92BQvWcjKM6P8s/tge5g26s2U4YgyKA9bkacY1nE4A3rL8LeJDgqKlG8?=
 =?us-ascii?Q?DgcuRO0UiJkSEKZLdNyLg57LSzwgCnGFG9gvSVF51MJPh9zL1cTsuSEgQHG7?=
 =?us-ascii?Q?cj5g66vGm74ceLhuy2G0AKHDUTR2M1L3RW9WAY65N77xpMJdYjZhQ4CwBYRf?=
 =?us-ascii?Q?5o2sqGi/HvFsCWWP70NEobOW4vHl9BMfp3Lk8UlQuw33eIsHBwlOlDpj9jEk?=
 =?us-ascii?Q?CFed5uF7R2Y/D5TvTX69F8FU42ZpO0U8KDBezsnk19nUWJvP3R7BN4V6yk7R?=
 =?us-ascii?Q?BJerRIYA3vmxfrrk2RDQtyBhsYWCcrUlo0mK5r9pnCPdT163a7TCTke4xU8A?=
 =?us-ascii?Q?YhUPxW4yke/CM+rgZESRrjet1SoTUBmkqh8GK+8XIorQq5IUCemOsg5JKnS1?=
 =?us-ascii?Q?lwCL6LYX0bRDW/822A2Z8Qu4a7Ozr55XDrFfEcxaXAthkgixqoaki4SOkC8S?=
 =?us-ascii?Q?F5VJX2knkbdfVfGD6v2NUmN6h+175efCQkdceq0VsmuAp7H7dkbC+kllRZ23?=
 =?us-ascii?Q?ILvKbWxLp3/DbKiDj8jiOEUgg3eL6hp2Nat7C2vIHd+dT1vXmCuEIapbyVLq?=
 =?us-ascii?Q?Nz90xJNBmb4T10J0iz0xgN0=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff2a19b-532d-4f38-af23-08db507f466c
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:19:37.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGMwHmSOYZRpWUTFurII7c2/S+F02+cVgRoNd1zW/zYZOCab5CMqHx2YPvJqjP+WObuCGZ/oZxnhxaorP06/qiCNtcAC+kKxnWAK4oPapwgDUA7/d4jHk9Uwgie/KFWe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9627
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries to the list of imx8mm boards denoting
the Emtop SOM from Emtop.

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..06eb2c790f90 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -884,6 +884,7 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
+              - emtop,imx8mm-emtop          # i.MX8MM Emtop SoM
               - emtrion,emcon-mx8mm-avari # emCON-MX8MM SoM on Avari Base
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
-- 
2.25.1

