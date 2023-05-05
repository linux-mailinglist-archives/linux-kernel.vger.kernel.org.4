Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45886F8B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjEEVjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEEVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:39:35 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933199B;
        Fri,  5 May 2023 14:39:34 -0700 (PDT)
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3458vpKu026938;
        Fri, 5 May 2023 16:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS11062020;
 bh=dCT4uKu5fAWUNzArCackAivWFv9fzehnaexSM0QAoQo=;
 b=N5y9jc3kGPZS2RLIkANA0KKoGcS47NdLfVvSW2DAdOTZvphq214rJL9rLX8VUF57vdun
 3SFD9wotWQrU6I2TKcfV1oxmXy1Oe97fPLJyb3Jtz5J54RCZt8AfPGto8Uc7MQ+MqnNj
 ZJrVZke6xN2ew1/66mhSy2disL0Hnn383yU2VhTPu+wg+RXR6SsUwkyhkzlsDHDi3W72
 ss6ytvWsjUuM+1c2NZNLm7H5gmWWoENJwIBK0rxSh1x0+g6mES2OZR6/I/qcVgWieOFf
 dlbevCQ3BT2AImap3L0ahTF0XrilBL95TsaSEYUWDzr4TJoTc7N2dfufeLukNwR9eofW og== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3qbu01mk7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 16:39:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czgEECD24EmCwMctc5jCI388Djk6xe0uBiWs+V6XpKFkElYwbTY7OzogncdcJZXbU+yR9Z5HuYYmAu7fD7YMZluzusBQSsD4LjhVLIq5FosHdPM84LZZFagqg/zmaBco86poNqiV/ynBZ7SIzd6tBwXxBzKyxgTRww8DXYCKez57SdETjzxOEC6FV2gooWGjiEN4j1arFZJvBnNtFxB8fQWPnnl5mSgdAbHpeProkU4ZpVJmbI4twITZ9zNqdMpRCfMJJj4O52TFp6kF2EV5HSk9QvF0twrljg6q5ioyl44rrNt+uplSL9Tz4BYYYQ5ah0L0yP6qtvn7EB4PSWlRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCT4uKu5fAWUNzArCackAivWFv9fzehnaexSM0QAoQo=;
 b=R09fRVbPBvB+CKWjgZ3PUS2aPC2Klv7aLMfW1pgfz4z9vuciYTdRvHAKUcT1lRP2na5gtHB8rSA67jeUFNQUiMlzL12c/VAfKv0dVo4ha1oqd6tTn8HeBBeei6RU7UtCyctb9gXqeMXTDQIkbvuo1Lu8vZ3APCvXm3V7ksjaDHdW0xZtupcIFjt+CH7fjsytTmpVNtBcWJWu0f4+D74fnISvNxj8ChIpdUfpwVxx1kNlsqZ8W3ZOlR2WJAd9eiYE8nSYBj5RXKGjRxPGHkwAtfsKMGg6C8lBBh9XVpV2nPddi//Qm/SUkM3cWuq8TywlcI3AjEDeLRgT2EOwTgCpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCT4uKu5fAWUNzArCackAivWFv9fzehnaexSM0QAoQo=;
 b=HPCHvDZii4ECaiTWHdR4cOatM8/KqxCH1pj6aze1w4WWIT9hpGOPZe/L9qiZX/UG9mZ5rdOepdww2hApvYWWPq3AqsyFMCZGHKZ1IGseMy01rY05LhGuuEn1aqIsERiZypxU3eywz7wQtu1SbicmbIjfKdsbdxkTLZ1DiZ9htvM=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 21:39:20 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 21:39:19 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Brenda Streiff <brenda.streiff@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 tty-next 0/2] serial: Add driver for National Instruments UARTs
Date:   Fri,  5 May 2023 16:38:48 -0500
Message-Id: <20230505213850.829639-1-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:806:f3::9) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|PH7PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: fd934b7a-e346-4309-e12c-08db4db12eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 814FLs+KOsRO8y8GCRiNNObY2vz0P0TiKKxv6z2r8pFc2ZeHbqqxyr2keSbPHdofm3G2DAywNAjOJcIbqDkhE363XePKRI4nq7Wn8GhwHp93nyJbDrMEZIUIAeabYGKurdbonO5mm1eL+D2GPqGznmU2xT2PwnoZpVxRMDj95JBQH4rkc0ckpq6SelPX+PsdsSOs2XoMBKH7YDI01pLwfR1jE+Z90jtJnzfRgXmGYYMRtcRSPyhGPQsLty8SbRxG/+47g5951/rpdleK2ad948jYCfC24xh+24UgEJu5C31VEb5LJzcfrOvgIWaZRQ5ITHjPLr/fHlrPfmgjlVtilIg0tdAQR+ieAXWHLTTZ0hc2fF+gZ06G8JtC6dIz1/iwi95etlUPRf5slJLx8UtXvEZd7UJe185yQnq3baDSuwKR5ZA9zSF6/7Ba2a4r7831vj9M2MCVsvN4DGt0nQUxzasCzedBvHBUmc1Yb4WbCePq05F2nLau8UlNstuFH5L1/xKQHw04oXS2njyKe1p1mDaYKG4/d45eoQHpx0elxTFp/foWVc5kyl+PUtkrXhGa2Uc0gimLuaWKSAWv65SnVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(109986019)(38100700002)(5660300002)(36756003)(2906002)(44832011)(8676002)(8936002)(316002)(86362001)(4326008)(66556008)(66946007)(41300700001)(66476007)(966005)(83380400001)(186003)(1076003)(6512007)(26005)(6506007)(6486002)(54906003)(478600001)(2616005)(6666004)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLd9hCalnewok80rxpCCL8pxE8lJMLYPiu7qB3XuYh+XNVokltj4q0u4zM9t?=
 =?us-ascii?Q?owPzG/n2PRZCxYFPe2R8gqgAkCusO/o6Cn/xAmYN8QR9B21UkbWc5g9422hx?=
 =?us-ascii?Q?FxO6Uvg+h+/Jzfgs2ZXdemZVN0KdROVED4i6pzfIzSEeMJgSMgCJHix6+h+Q?=
 =?us-ascii?Q?I4/czuEQ2B/XJE4NZQCsA+P4PIBLoDuqqR+1KbavVaiv1L+wttOf+nMU+VkY?=
 =?us-ascii?Q?SpA4t1rX0VhqZ/CLAWOBIRE5GZ3+44axzNn/jW9ONcuTxpkiv/QDk2X2Ctx4?=
 =?us-ascii?Q?6Ew598yyu03u69XxvjaJ9V6lpD3RjevY2IVtPpnapcJkR7yFjSPEJRQyKmmr?=
 =?us-ascii?Q?BogwbBLTc4kAFCEuK+rsKE+s354DfXvClrYalLQDKA/w0NHvATUSn5G9CSpu?=
 =?us-ascii?Q?LSfmvY9deLFdHevPL0WpF0ljj6hT1sMt9jJsrrvscWG57pfDc13reHrwEi3U?=
 =?us-ascii?Q?EQPWNKRyJMpzbAv8H9HO2Sqa7doHea0CoB02F+bQbGf0z3qQpVPJvRqN9bMY?=
 =?us-ascii?Q?+1IcRT8Wm6yTM/ko6eUJuP9Ku1egRXw3lN6Qi3BbXvGAzCYqYPUa3ojAlPji?=
 =?us-ascii?Q?MmHz3L0cmj3ZUcugHaxdC4oNNLm/HySBlINCVumkVH9XFYKn86mE7H+IwIjF?=
 =?us-ascii?Q?y4+HKGFnDx5m61HxKRWCMC+qebL/fJLwwh9kbVBP7DGndbPetVr8ciZ49M29?=
 =?us-ascii?Q?O79cjFPLdcL+Q1ImZm3Zaz+wO02xilvOcD0aGmYX4x6SP9Rx8HV/qPjouT8b?=
 =?us-ascii?Q?JVLVG+VMBWfsGRYm+UmpvBes31/1vuPBM4jVDNfcnk45TkeHdsuNEUpMOKj7?=
 =?us-ascii?Q?eXR2jYD/9DhRunp6Z92iNLTFXhZVNAwOK8AsQo1r/Y5uhpHs1qfQB2uBSKV4?=
 =?us-ascii?Q?QrU9QANG9sgXmOx8A2msBwkLvKBbRsCePvp1f7nh1zHzWVjtY8w0jOOxGsZb?=
 =?us-ascii?Q?orOf0ucuh7N/jSXlyh6ykLx3bMBE3qRQINnVkdH07gSJXf57mbxf3tQEhdnK?=
 =?us-ascii?Q?EOsdLOn8ch6wKsyF7A9Lh7E1MVxLnlVoE2UFJAVdh+LmvVNZk86T1mB73rRS?=
 =?us-ascii?Q?ftqekh+jakgG/6YoklNVfbVdKLTfL5hYHZq2qtifBOKETQmbrAhLlzXaCvYs?=
 =?us-ascii?Q?cTlgbmbQRiumimVEZM1UsaXpxtsOkZiafVIzri4WOfMtpnKkPtX1ynAIEGvW?=
 =?us-ascii?Q?uIH+Gx+pGDo9h4GO05jCuKcLVs91+mIR/23pYt5q3PaBFYQdBE66ibv7hj9O?=
 =?us-ascii?Q?8qaZcelmxQMdYDfawPritMSkaL0Vx2R1umoo6o8n7D+jIsl+7s+mnDCfhDGp?=
 =?us-ascii?Q?pBG2rnVkKt8BIoBrV0STW+11pcZDYp7ptwCktbNVs3zB4/oiOSSxyLoJWkwY?=
 =?us-ascii?Q?MYyrJNKP74c3w4xXuvItEgDqaD9URO6xXZpn4wu2FRlbvj+zQbq4sS7zSyJ0?=
 =?us-ascii?Q?ejlv85QfH77AW52Jfn1l8+nBeUZYRa1KzoL4m+lPlMuKj1Mz6VWykWyKhDFs?=
 =?us-ascii?Q?Vz0m6Y9g3TbtL/ip+XV6sQUA+Kp4wRP2u53HSZ5Rip+dZwD3aiTvwk3H4dho?=
 =?us-ascii?Q?hMj9Wj3I9yW+7lv67CSmiR7KpmvUidExdqW9DLGz?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd934b7a-e346-4309-e12c-08db4db12eee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:39:19.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqFgUdSmp/qdqFMnk7xTW+lux/FsFqK5EPQggPhov4cghb6UEbwYd86CXR+MBNtZVvdUDUmiVGeO5yxKrh1Nfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8755
X-Proofpoint-GUID: AeigGm6SM7jV6l0Fuy2FkPzWEd2PTo-D
X-Proofpoint-ORIG-GUID: AeigGm6SM7jV6l0Fuy2FkPzWEd2PTo-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 bulkscore=0
 mlxlogscore=914 clxscore=1011 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver for the 16550-like UARTs on National
Instruments (NI) embedded controller hardware.

These UARTs have an interface that is compatble with the TL16C550C (for
which we build on top of 8250_core) but also has extra registers for
the embedded RS-232/RS-485 tranceiver control circuitry.

Changes from v3 -> v4:
- remove "clock-names" from schema, as there is only one clock
- remove legacy "clock-frequency" from schema
- use GENMASK
- fix spacing
- fix uartclk on NIC792B devices
- add comments to clarify flag usage

v3: https://lore.kernel.org/linux-serial/20230329154235.615349-1-brenda.streiff@ni.com/T/#me4a5f3dfe0282145565d409f06934739b7a4b023
v2: https://lore.kernel.org/linux-serial/20230329154235.615349-1-brenda.streiff@ni.com/T/#mbdd219bdffc41e766634440ff6fe37e75d5a8c0e
v1: https://lore.kernel.org/linux-serial/20230329154235.615349-1-brenda.streiff@ni.com/T/#m05ac0a562351ebf2807c3c226cbe9ba3ebf0045e

Brenda Streiff (2):
  dt-bindings: serial: ni,ni16650: add bindings
  serial: 8250: add driver for NI UARTs

 .../bindings/serial/ni,ni16550.yaml           |  64 +++
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/8250/8250_ni.c             | 467 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  13 +
 drivers/tty/serial/8250/Makefile              |   1 +
 5 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

-- 
2.30.2

