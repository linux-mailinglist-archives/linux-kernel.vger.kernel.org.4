Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAF68058F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjA3FYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3FYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:24:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455FD1ABD9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1quWPgzNVQwlx9iMyFgfTJ9JoF89DwrDvoLPD2gy+pK9AJVjoi7i9Qcfjw4P2ONLKogR7eafBOhorghvZddm0PRWmlZAYE2+dvgKyasj4Teacbs4F5tOf6Ugb6nLY6+0AygiYC4v8YiTrorGX1bUnvck9giP/Ls9PQtiB5VUDts9sgPfdVkSVz9BBEbmuLiH9T1b33OpOematWqynqYF/tM75B5BBSpH5J3dQgdAMNWKepZ6fbf9jBI7V4BjLoLl7Hr7rNCaLoKqQVve+Ky9jygwd8Ppt3Z8S6qGE6yqPIUrlmIcHEmFekS12lZqXnQ6B7X08RSsq0EqYzRIx36fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL0zs2iszLGGiuYKBbUchr2bYE5mqqagSO0pd1Ao6Fw=;
 b=LxUW8zj049UpxclPjg97rwKQgdZ8FNMLQgUCt32aQOncSEYvf7FkvKw8B06fpDwImbWwARcc88qmqTqmlVwsMZNxBLQgjpv1P0GjxvnjFlKmvZlwLU02LwR2OYpNj1nHJvw9oK3adBZJ6vGrJARd9p9vx6DJNku6WoOGCQaRCqjrxgMSlFfNNiUPPKv6fbK2Hdh9ZabwgZqluPF3sLT0Obztzznuptfg1C+hM6DAjQXeJJePlg17ufkC713XznaZJqPsc+oW22AB5sOWlhfrk7IAYD14Tddu8cC64UpsYj11eK407rLvvl1YeP/5EboXtkFHLdldlHM2x1xSqcu70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL0zs2iszLGGiuYKBbUchr2bYE5mqqagSO0pd1Ao6Fw=;
 b=kzyzgx23QWMo2F4ylsg7yyDbAHMoy8xRhOt4RU1gzqhLycXoWCytSW84Is7lWmO1OzkICb5DHGsCo2IiTEfUfWOPxXwjYKKCM2dE/6cwNmw5XTH7PLLkxy8PqY6tw4c+HQ12GHPfD9bxNfjMDYphnpAQyt7kOo8Y6UTClnFh58z1GHiL3je1h+RZTvlpeWVLRSLzHsADJJWhJkvvqw50pwY6TcOxo/fkJcHjvUxdgbfYnlF5irwT2D0PWHcqWJonrdsipyWwOICz28UYvuFRMEOPQVFO2rU6/wRmPCXWAoTWzk9AzHsmjcIWtMmf1TtImo9iTMuriLjOUw4Xg9LhmA==
Received: from BY5PR19MB3333.namprd19.prod.outlook.com (2603:10b6:a03:188::23)
 by SJ0PR19MB6840.namprd19.prod.outlook.com (2603:10b6:a03:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 05:24:35 +0000
Received: from BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::2f9f:773e:b1da:5087]) by BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::2f9f:773e:b1da:5087%4]) with mapi id 15.20.6043.031; Mon, 30 Jan 2023
 05:24:35 +0000
From:   "katiyar26@outlook.com" <katiyar26@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Mellanox interrupts are not load balanced
Thread-Topic: Mellanox interrupts are not load balanced
Thread-Index: AQHZMjMkUEeiz2tn4ECAxfc0bz4HOq62b/ZKgAABt+A=
Date:   Mon, 30 Jan 2023 05:24:34 +0000
Message-ID: <BY5PR19MB333337F4EF2491D440453F74A5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
References: <BY5PR19MB3333BC15B1D33E89A679D7A7A5CC9@BY5PR19MB3333.namprd19.prod.outlook.com>
 <BY5PR19MB333326E6CB47FA6946DAF7DDA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB333326E6CB47FA6946DAF7DDA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [JdrASUGqXX0OinqjIK9xq6PUAhGYTRaH]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3333:EE_|SJ0PR19MB6840:EE_
x-ms-office365-filtering-correlation-id: 3e97437e-6144-4dbf-8be5-08db02824634
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02Uc8lc1gcmH5CHNnkxJ4HP4wL/xwjTTJOICHROwTWZhLc9WCJHM0CudeQM994W9umn+NDndu+sT7zVkD611A/csYJ9HFiBCy8MVDqzYUIET8df5EgWo9usIMsvLdG1fG2L0rHpS4pJzuzSfFa/aE2tY1KJkJBv6qMzNifUrvMyF7fhIJKgW9f9VN3K9wppggYaA+1qgFF6cVst8FExwAXGb6VIwWa+Tohm/6Il7shupov1k1T6fSbOSbK2hVYk3/S3kDZDMAgX9T+fLsg5pAnDEKq1AZtxhil3JHl4JdYxuPQmYomtZc+qZwq1CUWXB+uOC9r1uNRWrleacPBPc5XBlQ6cOEU75oe0YyDOoDEX5xh2DedpO+UT75P0ZDAd8PizA3m2WrEKaoe/IQkFGxL8flCZPEtl8JGMe2aXqmDXym8610PvDN9ND6U6baui7w4xI8+5HD2JrIlxCrp62qyMSZJf9gHpY0YqdZ1dWazkkOFwS853qrrrTDxxPk4f8qoAmZkRPxJZPiGqPTxPgvPyO7I6Dcr7L59s6KCXF8ZBnVGGzJa4sPotuM/uf+AEvlkuUUyvjnQhmarHz8iITtsmq0LMJwMt4lCer05Z0Xwg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HI4Q0PvZpQwfuvdEU3hvOVErst9wpnykFLdoBH1haM9xVLRwpx77OZ6u3/?=
 =?iso-8859-1?Q?TrwYaXR+gCfrGEvKYBhg8vQaebdA/fayhwlH6l3aKa+h9ZNvEVXWdkpQqa?=
 =?iso-8859-1?Q?Z19d2o8rlGVGdnzbgt/Tk4oaY0x7ZAtN7q6ehhASiYDnyOzxT0U4vUljKi?=
 =?iso-8859-1?Q?Cir/uVzV6nB0zI6jjA0sXY8+0PS77EclLrLFxGxNriQ5gxZMLvnZ+1GT51?=
 =?iso-8859-1?Q?iENczYP1s5hF7zf69jvBlskq2lTjczY4KPLSRFSXuquGvskGx2OLYZH3xQ?=
 =?iso-8859-1?Q?YC3scxjZJU4ZE5uZY18W9vNggZaDITMjn8BlZmBCSQu4L2jt9p9jRG55+H?=
 =?iso-8859-1?Q?cjazSQGeTOrfvXUws7bPnR45Ctf/BuxaJoBSalWd5Cwg3YJCYqzhP9Iei3?=
 =?iso-8859-1?Q?GtOzXsWMeVCV35iFsfef3BLch5IWXzhYlg+BlqUrj9LBfw9zn3wFTfz2wo?=
 =?iso-8859-1?Q?1/lN/XHfybLM+qVquRMBWZSHE39C03H5kEOfSn9b3tVEscn7gh2awK8MBH?=
 =?iso-8859-1?Q?D+Jxu+WPVLm+mf0mLQcZrQW6w52frc5+UO5keHiNVkYsoOx5wowIuaFrtZ?=
 =?iso-8859-1?Q?617DUxXNhoyaQH9TxS32HOv0QRxDXHKJ/J870zIjDFOQ1Bmi2VeYo1BxqZ?=
 =?iso-8859-1?Q?ERl+4Rsj3urQz5eLo+8cfostGJHyJf5Tg81xV9Xx0lKrRmKUVxZ/cyCjZY?=
 =?iso-8859-1?Q?WPoWpRu04GTEaqy9+O9C7PhOiBS+EEJ+hzEofFeBS1VOy25Fg0sWRLwsYP?=
 =?iso-8859-1?Q?iIeTttTaHuYJSUZbEg52MMdOXiPCxUsQzt79/t77Rz7h6bPcgoTdGlY2qj?=
 =?iso-8859-1?Q?gg8VumJivMiaLUETcigHnQTwm39d24TSOBujf3PmwQnfpOBj3SkT4Tgw37?=
 =?iso-8859-1?Q?/oDRAb1Lyk86VvMfoS467Yj5o1t+6MdhS6b4zGlu8CTtrBQ7QTz88PgpHy?=
 =?iso-8859-1?Q?Rfaj8cXgQumyKvLDCYHQz0+lCHdA3W0nAWohfyKoRfLZ5tqtPfDbkKGY96?=
 =?iso-8859-1?Q?+bi5Ve4HaeXV3I7J20sVrCC96lhkzj6WyRLwYtm+TYB5vdWXKy6Oz994YV?=
 =?iso-8859-1?Q?HCayd2bHCHzdJ6XKlHtYboweIx7xYU6hE71rudKQol9lLJqejdh6SgBWIA?=
 =?iso-8859-1?Q?g+2SadHsLOAgXcKuKmnTWE/GgnGpzO80RjJ7yAUNdDjZjdpzMPaLc9HjRN?=
 =?iso-8859-1?Q?sp3gS3MlqWEdRfLZzRi5GrZD4KXSynwljGyTULcEzibjxUpdTwHqushx7h?=
 =?iso-8859-1?Q?dx9aB5fytNLYLs5WpwPr0uAfNnrkG8+vuFmIGOfYZ3HHQARQkhNzh1qgoO?=
 =?iso-8859-1?Q?P9se?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3333.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e97437e-6144-4dbf-8be5-08db02824634
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 05:24:34.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
I am running centos 7.7 VM in azure with Mellanox (mlx5_core) driver for NI=
C. It is running customized 3.10.0-1062.18.1.el7 kernel image with some min=
or changes in net directory. =0A=
=0A=
It has created as many queues and irqs as the number of CPUs in VM but all =
the interrupts are being processed by CPU0 only. Irqbalance service is also=
 running and smp_affinity is set differently for different irqs. I tried se=
tting it manually after stopping the irqbalance service but still all the i=
nterrupts were targeted to CPU0 as can be seen from below output.=0A=
=0A=
> cat /proc/interrupts =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0=A0=A0=A0=A0=A0=A0 CPU1=A0=A0=A0=A0=A0=
=A0 CPU2=A0=A0=A0=A0=A0=A0 CPU3=A0=A0=A0=A0=A0=A0 CPU4=A0=A0=A0=A0=A0=A0 CP=
U5=A0=A0=A0=A0=A0=A0 CPU6=A0=A0=A0=A0=A0=A0 CPU7=A0=A0=A0=A0=A0=A0 =0A=
=A0 0:=A0=A0=A0=A0=A0=A0 9881=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 timer=0A=
=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 9=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 i8042=0A=
=A0 3:=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0=A0=A0=A0=A0=A0=A0 25=A0=A0=A0=A0=A0=
=A0=A0=A0 13=A0=A0=A0=A0=A0=A0=A0=A0 19=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0 8=
56=A0=A0 IO-APIC-edge=A0=A0=A0 =0A=
=A0 4:=A0=A0=A0=A0=A0=A0=A0=A0 68=A0=A0=A0=A0=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=
=A0=A0=A0=A0 25=A0=A0=A0=A0=A0=A0=A0=A0 22=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0=
=A0=A0=A0=A0=A0=A0 10=A0=A0=A0=A0=A0=A0=A0=A0 19=A0=A0=A0=A0=A0=A0=A0 360=
=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 serial=0A=
=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 rtc0=0A=
=A0 9:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-fasteoi=A0=A0 acpi=0A=
12:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 5=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 i8042=0A=
14:=A0=A0=A0=A0=A0=A0=A0 602=A0=A0=A0=A0=A0=A0=A0 318=A0=A0=A0=A0=A0=A0=A0 =
226=A0=A0=A0=A0=A0=A0=A0 232=A0=A0=A0=A0=A0=A0=A0 278=A0=A0=A0=A0=A0=A0=A0 =
205=A0=A0=A0=A0=A0=A0=A0=A0 69=A0=A0=A0=A0=A0=A0 8917=A0=A0 IO-APIC-edge=A0=
=A0=A0=A0=A0 ata_piix=0A=
15:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 ata_piix=0A=
24:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_pages_eq@pci:8b76:00:=
02.0=0A=
25:=A0=A0=A0=A0=A0 19694=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_cmd_eq@pci:8b76:00:02.0=0A=
26:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_async_eq@pci:8b76:00:=
02.0=0A=
28:=A0=A0=A0=A0 123648=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp0@pci:8b76:00:02.0=0A=
29:=A0=A0=A0=A0 152455=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp1@pci:8b76:00:02.0=0A=
30:=A0=A0=A0=A0 102308=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp2@pci:8b76:00:02.0=0A=
31:=A0=A0=A0=A0=A0 89403=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp3@pci:8b76:00:02.0=0A=
32:=A0=A0=A0=A0=A0 86793=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp4@pci:8b76:00:02.0=0A=
33:=A0=A0=A0=A0 107817=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp5@pci:8b76:00:02.0=0A=
34:=A0=A0=A0=A0 117091=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp6@pci:8b76:00:02.0=0A=
35:=A0=A0=A0=A0=A0 59714=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp7@pci:8b76:00:02.0=0A=
36:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_pages_eq@pci:83a4:00:=
02.0=0A=
37:=A0=A0=A0=A0=A0 12427=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_cmd_eq@pci:83a4:00:02.0=0A=
38:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_async_eq@pci:83a4:00:=
02.0=0A=
40:=A0=A0=A0=A0=A0 35520=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp0@pci:83a4:00:02.0=0A=
41:=A0=A0=A0=A0=A0=A0=A0 576=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp1@pci:83a4:00:02.0=0A=
42:=A0=A0=A0=A0=A0 34139=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp2@pci:83a4:00:02.0=0A=
43:=A0=A0=A0=A0=A0 19951=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp3@pci:83a4:00:02.0=0A=
44:=A0=A0=A0=A0=A0 41038=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp4@pci:83a4:00:02.0=0A=
45:=A0=A0=A0=A0=A0 36569=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp5@pci:83a4:00:02.0=0A=
46:=A0=A0=A0=A0=A0 42023=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp6@pci:83a4:00:02.0=0A=
47:=A0=A0=A0=A0=A0 12610=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp7@pci:83a4:00:02.0=0A=
NMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Non-maskable interrupts=0A=
LOC:=A0=A0=A0=A0=A0=A0 1536=A0=A0=A0=A0=A0=A0 1224=A0=A0=A0=A0=A0=A0 1240=
=A0=A0=A0=A0=A0=A0 1107=A0=A0=A0=A0=A0=A0 1299=A0=A0=A0=A0=A0=A0 1379=A0=A0=
=A0=A0=A0=A0 1171=A0=A0=A0=A0=A0=A0 2152=A0=A0 Local timer interrupts=0A=
SPU:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Spurious interrupts=0A=
PMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Performance monitoring interrupts=0A=
IWI:=A0=A0=A0=A0=A0=A0=A0 726=A0=A0=A0=A0=A0=A0=A0 143=A0=A0=A0=A0=A0=A0=A0=
 776=A0=A0=A0=A0=A0=A0=A0 309=A0=A0=A0=A0=A0=A0=A0 780=A0=A0=A0=A0=A0=A0=A0=
 370=A0=A0=A0=A0=A0=A0=A0 748=A0=A0=A0=A0=A0=A0 1047=A0=A0 IRQ work interru=
pts=0A=
RTR:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 APIC ICR read retries=0A=
RES:=A0=A0=A0=A0=A0 59746=A0=A0=A0=A0=A0 34162=A0=A0=A0=A0 150579=A0=A0=A0=
=A0=A0 45146=A0=A0=A0=A0 149421=A0=A0=A0=A0=A0 87954=A0=A0=A0=A0 149095=A0=
=A0=A0=A0=A0 47137=A0=A0 Rescheduling interrupts=0A=
CAL:=A0=A0=A0=A0=A0=A0 2562=A0=A0=A0=A0=A0=A0 2717=A0=A0=A0=A0=A0=A0 2601=
=A0=A0=A0=A0=A0=A0 2590=A0=A0=A0=A0=A0=A0 2577=A0=A0=A0=A0=A0=A0 2649=A0=A0=
=A0=A0=A0=A0 2572=A0=A0=A0=A0=A0=A0 2557=A0=A0 Function call interrupts=0A=
=0A=
Mellanox driver version is :=0A=
version:=A0=A0=A0=A0=A0=A0=A0 5.0-0=0A=
license:=A0=A0=A0=A0=A0=A0=A0 Dual BSD/GPL=0A=
description:=A0=A0=A0 Mellanox 5th generation network adapters (ConnectX se=
ries) core driver=0A=
author:=A0=A0=A0=A0=A0=A0=A0=A0 Eli Cohen <eli@mellanox.com>=0A=
rhelversion:=A0=A0=A0 7.7=0A=
srcversion:=A0=A0=A0=A0 7D9FFD656B0EB1000804CB2=0A=
=0A=
Same kernel with different NIC driver (in AWS) and igb driver in physical s=
erver works fine.=0A=
I tried centos7.9 (3.10.0-1160.76.1.el7) available in Azure market place an=
d there I don't see the issue.=0A=
=0A=
Please help in debugging/resolving this issue.=0A=
=0A=
Please CC me while replying.=0A=
=0A=
regards,=0A=
Nitin=
