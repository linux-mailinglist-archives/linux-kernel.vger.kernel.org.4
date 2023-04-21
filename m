Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAF6EADBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjDUPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDUPJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:09:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2018.outbound.protection.outlook.com [40.92.98.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB61C65E;
        Fri, 21 Apr 2023 08:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfIswbHLZxcGf8FxSV0Cj4Pg/bLtKG8LKDw6LwgX/f453pnORg13jPtKM5Al2+L1uQBL0xUQqjZYZLUysfJ/Gf85E5Yj+z705GVlcaWpP6ul9NIIYUb1iWyz8EiQmmOB+E58DR6z27J/3qR2H5zgiSFs+j5V1LU+j0CdCObMsEFwsyIrvH48rlWqYhiOx9x3mLNYbMPle1GXwOf+W/NeLX1WvWEK7jkqCVYAVMhaDw2H1UxCIZOUq7UtwTTnHBYLu5+Te/hDE9wpojCewIstJTApRKpRyv4z9aOHTPnen6wFGrBsPInhy/k/3+RdRcZ8pDeaZSp0DJaKG6Z0z872BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMW+pixCxm0LQrW0u8l/1WmRGidmYM6tFHAbsrn+xcg=;
 b=YINXUFz52rPY5bsQ9fSZo8ZbvwGwuHoepd67Fc1YrADZ/Y7slxrdg5byf1661YGVmfkbOH3L3KRsJYsD6kWtZGawFRovm6ll/xvqgcUzPhj6Cl/4x77+QH/j8mE6R3/8atwkgj/eWqL9SvBiBOKK7AKGYi5Jp3pxJjIPqBu07Nrrq/86q+0BthL0cYbLyXchl2wu7VaXwE8pw8cvwcRZ0B+1PTw92rjj1hbZnN7Q0tOiixIvcos41jnGU/oxwA0keAjkqAJv5ympUDW5xPHbDrJh9ScsZ4OETXaH4MnB1dSOEG39l8Or9R4uSDWzF/BQ7P/SKC3ezT6pFXarN+yP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMW+pixCxm0LQrW0u8l/1WmRGidmYM6tFHAbsrn+xcg=;
 b=cA1zPIIzE454DN6pGdlcUjRCgUMkCDcPJJaYhnmH/TSQDTC++c/DsMMDMpPqxkMSk+Pcy0fVW4MkLTA7oOlQp7v9y3cM5UpQtW0oxbuf76D+C7jvSFg44Ycdi7mQg8rs1L7jT4rbxUZmFkIGeeTpHb+kz2rtJxNT40Jf3WyDGzPZQtkxFysQ+sLrVZMn4u/40nG2C1RPe0XlsP5uaqhJQmnocxv+74EnT4nWzltXdgQ7EbfkGLi06Va7voa1EtRQk4tBkOKhjg5D/T9V0xo/2HocnV0Iny8XL5mgn3lEpeeKBBS29nTEFbhxWp7rDgsJLJhmPFLRmV+vS5SohU+ikw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TY3P286MB3505.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Fri, 21 Apr
 2023 15:08:55 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:08:54 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andre.przywara@arm.com, conor.dooley@microchip.com,
        Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 0/3] Add X-Powers AXP15060 PMIC support
Date:   Fri, 21 Apr 2023 23:08:13 +0800
Message-ID: <TY3P286MB26114581A9F347B5ABE54E6498609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GDCsPcj1Uiwdf+bsSRrt8Pr72rY4DOQr]
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230421150816.10513-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0607ba91-d3f5-4b54-7bdd-08db427a52d4
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EDXF+C/Fo+05XB94T6n38Pv8l3AyQv92FLUWBmnFKsxzggkVGKNQ0BACvpJqo8PQipBW55DSnYlxQXvkrDIlPLl/Fy9Mr7pfwjc0ig63oErstUExjXFdbn+nqH8iVrSGbxtr7wSlyKHauJ9k6TpANHmyXwVTT8/kmAAxqY7cG1EPH8rEtWA7HzIGCDWwoBOnZwIo1NCnVulIW8jGnpaPB8W8jFn9fvn2oebmHcD3/hJa+8SLvPqskuHBHTEivFcHpiZftCG5bSRfVfecAxdcAvBga655uWcTbrGxgrMt6cXTEpPE/F/4XOnB3e1dZ/C+qI7oCdMqw0eEPmAPZSHgIICRM3JRHfTU4bEHhtpyNTMcA0ezViTwEbJhlCEtFB7PwvsxpotNyWcm+fYdeZT9p+c8JnGQd2FN8Zc9HDhdV//BfTMUW2Q2NDGd5odIFNnT1r6GuPZYhiUbifGUHch1j9/a6Qc1D9lMEyEeyLcUK72O6LVGFKrN019A282HPRPKwCwoyPy2BZEhSnbE11W65eewo4kty3U6Ydv3oExnezbvXc5qymC+QtK7blfWDMa4Lk1IjKHaYFdwZpRekDLSGdF60yCizmoZ1ACvENtI3bJ09JUQcm2JCsLZeyjy0fhQ1patV1psKKwWKtJ3Ce7CbMMUHev4fTTn668ewu95dPzTrRT+szNtRHB33qxY1+57y2O44+bYePNPL1jr67CX5cWE7uINbIppHuoXBHdtuEOycoH+4Hi/Fvb2nUDyqSHDO3e9SUUcv/DL6x8Wc+LEpEp1eWiJLlaH22G9ZwxGjHfzuBYRQ4654/CCgCbEhjb3hd855v1ngikZO+L6LANHSza
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJNBpxBXLRHlZMujOCZtxBGVzaG4HSDYdi0Nmgqr8O7WVChZDpFOxn6fjsjuef+FOaIBXcncwunLPfYQS8RW7tf4qzfwWWxfzTfMAA9G/EKyhtfNdVTO1ZPdhUdyCT9PPgq8llqJqgYcqCgouTg+GlNKPCgC90a7JSTCVGNTV9Zwc3sn2gDCGJG+vY2jBfy7Zwq8IQiOyq1rvSbU6WMbHDh7eKbCTc5nMrkbfYzxY4NIFubZQ5Mp74sQTSL9GII8PpLuuYon+KC0YTX64d86jCnK0rdqB5NhWbI0EjT3KLkxJxY5XxlawSeM4iudTEJwZVZqb+t3wPZvdV0wBE4xgFu+KwJ1NIn9U6PhsHePffI7srg7tthxQCMSaLqYvpUv0mj6dIOWl9AzY7lIFbvU4i74rJVIJGyYuwv6eQkaRynCebxC0IsrjExzFGsFSDTF1m9p9tVPeBpXYqRhbrsH2olbcp/Sqzcvsneg+mRYDyBsmEC/GF6CBFD2N6PrtWsCOcKtfLfZLKBXK8BzUzO1juOl/jMkjhgxhpVOkaX7r5p5+G3kD/UKMKVhbXmem2jKqqfETNVwgz/wAKQ8RRlk+y6NakfXTOStXIi8NfZYELY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ht6W0tLq+e3cdftMd0kIcEQFRkJA7HJgcA9vSXXEfAFcRPLqNln6I/l3KEYO?=
 =?us-ascii?Q?fvayragcBvoGO4gAEwOrhQYlfjgJAUlrgmfb5Qc+bEfpjhE+OnoIVBCAoycp?=
 =?us-ascii?Q?J3G7mYNoDYmmO39AVVly2Uqjz/JQelpSy+qNPR/t+cDZyvO7OcMO+f/CB5Uh?=
 =?us-ascii?Q?EALdDqIEMsp+IhkCZucMMxQS3LLZghihN7Q/z8DUxJ5vrTl5wzoi4BbDRTDO?=
 =?us-ascii?Q?ugTF6mBYmvHgO9/Ao9P8vfOQYq4KRJYlyVRsD908sjiBddef80LY/whoKBHv?=
 =?us-ascii?Q?3wx+3g2YR98/tQxP6Aa7//t5bySuGZikYDLVFD25qn9dbhAoYAdWyNx6ixr5?=
 =?us-ascii?Q?gMMSQU/cryrE9P3OpTG6X79gv95K3hb3IMdYqqbQuQSLOJtEaR73P8itQEGO?=
 =?us-ascii?Q?ZwPVe5pJcK1SwZ2KhQ+XHdit/n6rQPmhakiLDPFbjfg4jbyQUNiTnMvM/CN5?=
 =?us-ascii?Q?G/n8qCW2bdk7Z3av23dRaOpZP0Kwq7ca2uNAZH6Hhky/424rHgy48sTzm/VE?=
 =?us-ascii?Q?QzudoqLzrJQ1k9tAQfnYq4uHZpnc0oqxz6L7685bBHnIe3ERfej/bIndRTiW?=
 =?us-ascii?Q?zlQtjKJgKQLoo/VF5lJhHBj+TOShWDRdmGfx3HXZMy3WnJE9iCTB+lVXJbN4?=
 =?us-ascii?Q?DZZgTWmxakvoF8SCUdM1+FhYqaTX8UJJnLvKslFeShRCDA/lHzd3M6EeNgzM?=
 =?us-ascii?Q?oCME7WjM3bUr1tJ0T7XjKIhTBSgQV8R4VLPzUyeupAYUZaOmf1TEHtfyud73?=
 =?us-ascii?Q?JilWG/xoWSaqHz81qkPu8kQTyCFrIB2vnTlrjeKjPgeOfkw4yLWsQvkVvRV7?=
 =?us-ascii?Q?YJUepyUx6tLPByCEeNTzjDWS0ecxcx2DC06IiQoFxgvKt/V6udbsGzaNxQj4?=
 =?us-ascii?Q?KlCSOtvUtWItIIaut+QjHHN6DdWwu8l6OQIsu4cu7VQQJFvk0d6rDymnOrjQ?=
 =?us-ascii?Q?4mi0uGD2erNZ/BVAeuYBWJe5TAMrAoKQn+iJNTgHwWXGyIpOalGspzFi1nGX?=
 =?us-ascii?Q?D93E/jMobTRUfcQRw9qKXu560SljCn9/gb8KTRuRUhB74X8OIqvC1zdGjwd2?=
 =?us-ascii?Q?wpbFx2uRja7FOnrW5dXlmPnDvioPHmsiZV+YF4oAXevQRlSV7xU1wGwSyr3g?=
 =?us-ascii?Q?p/ErkZguErshuE4yot3DW3+UaOkSAidRdJOr629R0SE6i/g7uOwIMuS6fl/n?=
 =?us-ascii?Q?2UUL7f9l73O2PFf9WSoebGpdZGc3tUm7y1W4ig=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0607ba91-d3f5-4b54-7bdd-08db427a52d4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:08:54.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the X-Powers AXP15060 PMIC, which is
a general purpose PMIC seen on different boards with different SOC.
This series were tested on Starfive Visionfive 2 board.

On this board, IRQ line from PMIC isn't connected so PEK function is
completely unable to use, so IRQ existence detection is added to patch 2
to avoid initialization failure.

Besides, its GPIO/LDO control logic is quite different from other chips
and is not easy to add support for it basing on existing axp20x GPIO
driver, so I didn't add support for it in this series. Maybe others
could do this.

---
Changes since v2:
 - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
 Patch 1:
  - Disables DC-DC frequency setting (Andre Przywara)
 Patch 2:
  - Add axp_regulator_only_cells rather than directly using axp806_cells
    for cases that IRQ line isn't connected.
 Patch 3:
  - Fix some whitespace (Andre Przywara)
  - Rename swout to sw to keep up with bindings (Andre Przywara)
  - Add check for setting DC-DC frequency (Andre Przywara)


Changes since v1:
 - Move cpusldo before drivevbus (Krzysztof Kozlowski)

[1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/

Shengyu Qu (3):
  dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
  mfd: axp20x: Add support for AXP15060 PMIC
  regulator: axp20x: Add AXP15060 support

 .../bindings/mfd/x-powers,axp152.yaml         |   7 +-
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 107 ++++++++
 drivers/regulator/axp20x-regulator.c          | 232 +++++++++++++++++-
 include/linux/mfd/axp20x.h                    |  85 +++++++
 5 files changed, 422 insertions(+), 11 deletions(-)

-- 
2.40.0

