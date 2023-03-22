Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D36C453D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCVIq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCVIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:46:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2096.outbound.protection.outlook.com [40.107.241.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3842A8A6D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSEKp8djkoSFdcW952Nhq7vMlUIO4jP7/FpKnNjrU59v3ngrsXrgJ7uUDFNAT7+RxBkCavGSY39rlGipIxVzKBTJvvl45gOIeptEjruCuA4pw7m15Uvg2nwrlFuxtGAfARGGURG8g5f/SWqbhWZ9unRZ+145RCOPk+CCN+5GpX8Zrsmdq4GcBm2fZPg7wV4PmpOxFrNFxVFmZze0HKuy+IedLQuAUhd707pjVZZb5QKllS1VJpwUm64xqOcXH/vcFwkeJ0/w3DZF3V7uLxE4b7+j32Jmt8GKfdBd2LbucXS93/sVqDiUWdMAT52ZRDEl1WVoN1Y7fjQYH66DU1lKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPBP//XtdlUOhKzK4EVQ+eI3CRF6Yfs5tR43QDTOb2Y=;
 b=ku4Y/XZuydIE8UWiBW75hB7a7vuQ3AD8BuiznXnesz17ldazZoVqMwhKIB/69YI28rlflYrJue845s4XA6dwZpzqJYVIJYZDrwdfLGB6XUCWwWQvzwU1hwfSJ8LxmOG5oG/GMxKnWEv8qX2etYFoR3JXsLFKkjUJD8RyDPgWcevV34Oaq2OsZmIr3LJLq/lSeFr3UHuO5EJmXbM5Sj8HT2Eny0eGFj3JNd230pDDR6iZq72LO2vzGiecJDtuwTJOP9T8n93sOFJF2k3cMRVV0irZHVLKgtFG+YWuAo4rCc4v9Hl77Pay9gpWP831gXUc9NtprwR5vY1JC9VZ1XPpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPBP//XtdlUOhKzK4EVQ+eI3CRF6Yfs5tR43QDTOb2Y=;
 b=fLlwWtWZTW3cYsdBNkrDu/oKDflFpENsetqscdw7neQHdTa2+Wk0oB+A/Xmvd8DG5aqfwLDuY7NO+6R27euridwzDRFJrYMaU2YJvRD3hbhozSxf91OIKg99ASQEKRZRNL71tk75qfT8eJczXLJ39H3pMcpzcBIbXU2GL+mWIi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Wed, 22 Mar
 2023 08:46:49 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%3]) with mapi id 15.20.6222.010; Wed, 22 Mar 2023
 08:46:49 +0000
Message-ID: <0dcfbc49-d3db-cc4b-b5e1-8341dda672ec@kontron.de>
Date:   Wed, 22 Mar 2023 09:46:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: Starting app on i.MX8MM M4 core from DDR via remoteproc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7c2c86-9ded-4e95-63e6-08db2ab1f9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bG+kL62lFYEc09XazeuBuuuSOR9S3L8NlsqoYn96virLDClcl772fh0y8ogiCsQd9TWb7J/KlHcPynai90ibKpq03cUGfHqDCCdA3vOaSr0K9oER3ZRPFgUA/yk9Zvnp9Hd1fnCiNt+WGLQ77N4b6agOZuj24pGMnZfEXbOl7g/gc3qPCMiTO4LSLRWq0q36m8qd8XIg3lH7vNe5nsOOROsPcVNVTxQHH3kf8iqNvEQ6m3t7Z8u5OzwIXiKZfgQU/ksfiIba53moATJ1GuQByXvkb3xmlGjIGixMokbUZUUd9xnEZ4al0ciAixR83a8vU7G3DHCjTM+XX8GdHMECI5ihPxGGprPW9fyFryy71BOwm8zc3KNwlz/DaFh3aHba3vKqKD6VUxlPZaOqt8eBU+Be/8xZjg6ac1GyhbBWTnZGBxIZyq6GVKHoOlktvKvcOKwrgmYyc3nuvb2yEsgopr08hR4gTWBDi9nZDSOFLqgqY63iZlcXISoRAxoKpB8PRUWhsjtjgMO4B2IbYDkLXBCPHt9ZwcO1udLgyuZ7cp0ehOUB9IT+/4bjFycAsshPsGgP6REjlygUn2D+8sHQmz26pFKaiYF8Lop27oJSu4jO6waHRpmkerVMhOWCQNUzLIaDuP0/jPTItwMWDL+LXxVNwhhfjItq0G+/dd56i5TvRrMTy0vXvb6AU4X8H+ofLKkR978EPKEgXmQHwKOGVXDVevuAcKyeRJMB1UNge2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(186003)(83380400001)(2616005)(6486002)(31686004)(38100700002)(6506007)(6666004)(66946007)(6512007)(44832011)(2906002)(41300700001)(5660300002)(8676002)(8936002)(86362001)(66556008)(36756003)(316002)(110136005)(66476007)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FVOXgzRGF6ait5R3QyOVZLeHRTZ3lyZG9KSkNQY01uWHkzcGNpS2hPN2F6?=
 =?utf-8?B?MktXWVRRWVg0QS9YeVhiR04zQ0xFSFlxM1Z4c2llOGdGbWRmbFd0dnpSVTNN?=
 =?utf-8?B?M1BpL1FMRHZzd1AvUjJya200UUExVC9sNGdxVlNFcFJROWZzNkZ1Qlg5eUd4?=
 =?utf-8?B?N0Y1Z1lYZXJyTy9ILy80MnhMTVA2Z0h0UFgxS3oreS9jTFM0RXNDNUxPZmU4?=
 =?utf-8?B?MVpUOWZaWU1uSTJYSW1hdGQ5K0tudWlkVm5kY0l2eHE0U3JSZ0RIZzhwbnBH?=
 =?utf-8?B?TXBpWkdxUktZWm1kS2oyUWtTOGg4d0tpekYyQzRpQ0pCN2xVT1hOK2tzNldh?=
 =?utf-8?B?d2NNQTAxbnNzMW1QK0NSYW50UFcrZElvUWI2QWtYRzVsUEtjUitRSnExUmF1?=
 =?utf-8?B?Rk5mM003dW5lcHpuZWZWb0RPWTlDeWRFK1lqSGdzZXp4bjlEYU1KSytpM0Rq?=
 =?utf-8?B?NVZ4RVFES2NtT0pZdFFMNXBUUk5zUXVJZjdIMzVtN3Jhd3pEOHhsZmNYTVh3?=
 =?utf-8?B?UDJ6ZUNwZ2FmNHZhRmtkMlQ0Q2VzRTBBdGJHNlR2WkJrbENKYURESEI5YjVO?=
 =?utf-8?B?NkhDQytqaEFiaFh1cDFtd0RhWjhiOGdzVmRtLzlYSk1TWCtKV09qbmNxSith?=
 =?utf-8?B?WXdwcElKNHhKMmQ5WUl2dTRmc0J6NDNtMVNBbGh2SWRxK1Fsbms1M1lZdW53?=
 =?utf-8?B?MTY1bkFIb3FzeHR5ZHFXeEVCcDFWTzQ1ZkVvbVlIYUtHM0xtcjVrM1ZGUlZL?=
 =?utf-8?B?K0ZISVBTRkNjR2JPdXI1S3Vsc282L2pmNm9OMi8wUTFtajlrckdpWVFrbzNr?=
 =?utf-8?B?cFYrUm9EM241MEFMOUZtMUJPN1QvWVBLYWlZYnAyQ3VQZGh0cmtrMS9LUm5M?=
 =?utf-8?B?NThGbWExcm1DVGZVMUsyUlhLbzFwcWZlYjdlTWFROUtFTHFGbi96eC9iRVFJ?=
 =?utf-8?B?V0IzRWFmUmNoLzM1N1VJL1UxTTU0Q05aQ2JIa2dtZ01rWW5kWHVZRkRQVlNh?=
 =?utf-8?B?bHhaVkZtMGJZYVRRQ1BiUjVYNnNVN1Bkeit2dXRFK2RuWjVmZVpnNDVpK3FE?=
 =?utf-8?B?N0hmL1d1d0gzNjE5YnpWYjRxM1FvbDB1ZXEzSFVrMXkyeFVJNGZIRVFxNmNR?=
 =?utf-8?B?OUdJblZwSUJBTkl6b3d2dXZocDc5N2hORlA0aGpXSllwdGlWQTZRc3lueGt2?=
 =?utf-8?B?YnM4UTNpdWR5d3ZHNkdYT0xDZ0hweGRyWWdOMUxvUkkzWjdoN0x0VVNlYi9T?=
 =?utf-8?B?US9qSTlxT0wxeHYwNlJJd2NldSt6ZXd0ZWI3TjJ2YUxPT1l5VS9uYURlaDda?=
 =?utf-8?B?K2RNczNDOGJTamlBYkpBalo3Ym92ckR4dFNSek9xMHNKODNtTHNpaEt5bzJt?=
 =?utf-8?B?SW5jQUFxRkdvU3dpOW84cXloc0dVRGVzcGlTckFNQk5vYlJISThNNHZhZzJi?=
 =?utf-8?B?ZGtxeFhIc3RPem41VytuMk1EVlp6TlNPM1N2RThTOUdJQ2wrYnlYNEhiSStK?=
 =?utf-8?B?QXhLcE9LVjVyd0pLUVp1bXFVNUZZMzhnK2JMbENyZVdudG5wdms3dGlJUkNp?=
 =?utf-8?B?QWo5WkprNUZOa3R3MjhoQ3FqMVdoNXBrZE1NZkxXWC9vdlBvc2pkWXlreGha?=
 =?utf-8?B?eW16VTFiNEEwQjdRdGcrWFN5Mld3WWlzZDNiZDBVdnI0dHFQbjdCOWYyUTBl?=
 =?utf-8?B?RjdBb0JOTXNENXByVnFnOEJKM1pLb1JpWThLdDlITXRCUGdhbFppNTFmWjVC?=
 =?utf-8?B?ZzlIaUZjVXozZEdvci9VUmJDVVA1S3BycU5xKzgrR3dOWG5LMVB5SUJQZkI4?=
 =?utf-8?B?M3pjaTRka3loUU9FVzJwWThoQWlVTWFmRGFJZjdVdldYNS9BRVVEeUZyT2N4?=
 =?utf-8?B?MlhOcWxKaTcxMi9ML2JldlM5Sk1GenNtYVBxcStjclkzUDZyVi81dE80eFZJ?=
 =?utf-8?B?UER2a1NvNDR4QzJicjF4bnlLR2lJV3I2OWlWZStqUGMzVDd4U3pZNUhoWDVo?=
 =?utf-8?B?dWFxZTVGWC9QSUVnQ0w3eXdBeDZpMHVpNk5ydUVSYjBJOHR1MXFsSEtvQ2tv?=
 =?utf-8?B?RVZ5MXkvU0ExYWV6a1EvTWFsUTJoNlF0WlNMRzFueFV0RVkxT2oxcys3RnR0?=
 =?utf-8?B?OTJycmY1cEJxaVpHM21kcjFiK1dSK0ROQ3JUUWxvODJDeDUwTEJnQkd2WEsz?=
 =?utf-8?Q?IQdkI1NhutI3WxiS++k+W7StEM3KdH9XIzwkBqPihd+C?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7c2c86-9ded-4e95-63e6-08db2ab1f9a9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 08:46:49.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXvBZrIvU9cF9zOFPzq7+id75ebmWs6PmxnU7QxPrIOJOnchvTQAE0k8XtB+T2UcZob4ga8FpjrmeRz/myC8K2Vw0tGBTsrzR3ZYJiZGZHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6106
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having problems with running an application from DDR memory on the
M4 core of an i.MX8MM using remoteproc in Linux.

* starting the app compiled for internal RAM from Linux works fine
* starting the app compiled for DDR from U-Boot works fine
* starting the app compiled for DDR from Linux doesn't show any output
on the M4 debug UART

Below there is some more information on my setup. If anyone has an idea
for debugging this, please let me know.

Thanks
Frieder

* Kernel 6.3-rc3, but older versions show the same behavior
* M4 app is the HelloWorld example for the NXP EVK from the NXP
MCUXpresso SDK (v2.13.0)
* Devicetree entry for carving out the M4 apps memory area:

  reserved-memory {
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        m4_reserved: m4@0x80000000 {
            reg = <0 0x80000000 0 0x1000000>;
            no-map;
        };
    };

    imx8mm-cm4 {
        compatible = "fsl,imx8mm-cm4";
        clocks = <&clk IMX8MM_CLK_M4_DIV>;
        memory-region = <&m4_reserved>;
	syscon = <&src>;
    };

* Kernel debug messages from remoteproc:

  ~# echo -n hello_world.elf > /sys/class/remoteproc/remoteproc0/firmware
  ~# echo start > /sys/class/remoteproc/remoteproc0/state
[   16.321669] remoteproc remoteproc0: powering up imx-rproc
[   16.339005] remoteproc remoteproc0: Firmware is an elf32 file
[   16.344811] remoteproc remoteproc0: Booting fw image hello_world.elf,
size 172988
[   16.352339] imx-rproc imx8mm-cm4: iommu not present
[   16.361694] imx-rproc imx8mm-cm4: map memory: 0000000067eba0ef+10000000
[   16.368370] remoteproc remoteproc0: phdr: type 1 da 0x80000000 memsz
0x240 filesz 0x240
[   16.381663] remoteproc remoteproc0: da = 0x80000000 len = 0x240 va =
0x000000005d9c21f9
[   16.389694] remoteproc remoteproc0: phdr: type 1 da 0x80000240 memsz
0x2908 filesz 0x2908
[   16.401658] remoteproc remoteproc0: da = 0x80000240 len = 0x2908 va =
0x00000000daf54708
[   16.409789] remoteproc remoteproc0: phdr: type 1 da 0x80200000 memsz
0x850 filesz 0x0
[   16.421658] remoteproc remoteproc0: da = 0x80200000 len = 0x850 va =
0x0000000042d1e7ab
[   16.429682] remoteproc remoteproc0: da = 0x80000240 len = 0x10 va =
0x00000000daf54708
[   16.441665] remoteproc remoteproc0: remote processor imx-rproc is now up
