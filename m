Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB35EA58E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiIZMGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiIZMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:03:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2082b.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF085A16D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm+gCB/a+ZFYzuo3qvKVNfXOmqRdfdafMtQ+KCALJDijmIEEug0wv0mj0wHC0m/LOMmj0/7eUazgWNu9nimXMmGX08lhv0HQbrv91MFIdcneSbAHCMaxEsj9g57pZtRNeKU68ASbk5+fk8EMveFRtGJPmnh/S5Aj4Z7tbYeIIKTvzZgvUl6rfCPoUU+ueyXzcIc1uT4pfm3gW1/+uc52tMxO0WPlPEBMjI2GPNAR16AosYaDmxHw+J16W6N7VmfzAROhsgc9elQZR2BzvyL6GWQAZGMHnzmFRornv2snINgc+ZPLBuM/kHYWPpr/mp0rELvf1gxKZ61RPzb+do4TEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPLpX6D3kgiXwb7QNZf3skNHPH/qpEWKzxqazlP79F8=;
 b=cYjlwfMXIcDqmaAUZlP0PPJ6aJos1CnXSM1UgRegG4l3u6IhH7YisZ5EhAId5Sy7dgSvkS7DU6YcfiZWREtsCODj7oRa6vzvrAc4MXbdKBoBxjUvO1lE9f+9qEgslZ02rBOBBHMkPILI9gbEVmaIjwCKw6l9M5v7xQoziKfFYb8P3JqCyo1QalUrnZVOPz4FARX4NZAxP9uMVUby+PH5TJJMagHGzMvuKPmwOjt45PzKCg8JGv6Y6J53iKrZ5j0kUiFyT3404Mik1hMcXfM78GjhiWbT4vdwydXvxmaoiyqIRnC9jOAKJJucy2dj0KDBBWfLjtI5gvKFMntgMAXhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPLpX6D3kgiXwb7QNZf3skNHPH/qpEWKzxqazlP79F8=;
 b=M0VO87+hRsEq01S0V95amB8E7xNvN9ERK1nVLubodawDu18e8CXBHpg+cTcPX6ChpBtQN0NBmJMZLI/DQv2LGGrpF5bh6YkHTWayTvNxB5ghF2vUPYVfc2Z8rRQ30FDjSk14lVDQU6ppT284oA0Z/uge7Ybe1tuPqwjHmbDPxc2bFD0VmeMaDhRhOaOYx//frvcvWbV9Gwbenf5ycz46GJMcrSKFmVrlSUFLVIlvpES7zWkanYKiwKb8PT7LWLyN1S9GCMcwH3+jX0dQrW/4BHVYNAiKcZ36zNJ+jMQEJkaZ72vYo8HuNJxAvOdg9IO9y3+w83YaI5U8GE90pJN/mA==
Received: from OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:83::12)
 by OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:161::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Mon, 26 Sep
 2022 10:51:48 +0000
Received: from OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8b83:8fb9:2676:a925]) by OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8b83:8fb9:2676:a925%9]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 10:51:47 +0000
From:   =?gb2312?B?1cUg1PPT7g==?= <zeyuzhang07@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 
Thread-Index: AQHY0ZXz932WyCfEx0Gkolf26H7Asw==
Date:   Mon, 26 Sep 2022 10:51:47 +0000
Message-ID: <OSYP286MB0103249637A140F226B01D53B2529@OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [23BT+eqY/0Ds1RImUbQNOU79G6M91txz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYP286MB0103:EE_|OS3P286MB1640:EE_
x-ms-office365-filtering-correlation-id: ed78836b-1f3e-4957-da0c-08da9fad1c54
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Wty1o38NxQ7x/hYGFdW2AE5kJUtUSQ57w1sYVAXvLt5uvgRARthXaSQqWlhb8iYaUo5GpbKd4DZbqm+uMtlrQxiDpxHf8T83J9OapsNXzwAf+VvWKBfsxg/SP9Jy1n3BDIOI85FEJsnXopPoqW568FTWloG1hwc0eoFpQtwOwc0XSu/yEOO3UZfwl0AoHm0V47lzct2fW4qOMebxfxYgLtX9q0148odI4xh3QVpVAhPJFWl2Sh7s6nRPnf2qaavHgkKA8vkLKgH/BeqakJ+DtWKpzsfWfd7JFqtJLy+DFQYJvhbbwX/7owMfihgI1kSJv0To8s/LXKAzNzEku3Xq/P8+w4EBK4y+dZZknq2Tt9Vx4VuU/8LhyPgZiEWw2q3AM8dwTZUnzu0QFIpUWicFtfeb2PmMa0uHFzc5D9G7pLdebliGVFJRSV4ucoKBRyXAoEGLwZvG4ildaaq03bkAZsqcACrDunpfF1vA9EmMCV966Z18EUxue9ctt3HqgNWH4pmgAcWeBU7K7ffhbLJBHG7fml8VFtENdL/kq54YPtzSKJraFDSYHWogNQy5EoaKnzaZTLU1O/acXloIDna4fAYBkRr5jrA5x17Jw+09IBt4hIE/6BGJacacHgSQ0/xZXjyvSfSYAHYX03snqac6A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YUNHSlZLZTRSTTFqS2JqMGQ1eFNGcDVsVTdxVFE3cFd2dlBkcXJCMjJ4bWtW?=
 =?gb2312?B?MlZ6aXBLZ2lsSGd2ZlJ0QlY1TTg5ZlR5Y1dqZko5RHlzUnJ3RnBxaFdJaGJ3?=
 =?gb2312?B?TGRQOUIwNGRvTm4rMjFzSWJieE9VUW5DT1NxTHlodklpcFhMNEg3Z1QvaUVk?=
 =?gb2312?B?YnFjcUkrNWt4QnZYL0ZwS1U3bS9DekI3aEdRclE5T3VKTU9sRjVoY1V2TEVH?=
 =?gb2312?B?UG1oVzVnWVVzWHdXMXo0SmxyN3A4aHRWanhBK2Z2WC84N25Pb2xCc3loMEJI?=
 =?gb2312?B?c04xbjgwWURSWlE3S3FyajhPcUI4ZEV4VGgzYlNaTEFFVENtZm9lSE43NnlH?=
 =?gb2312?B?TmR3ZkRXaytiSW0rbnh2VFhxN1BKaTAvNkxQWllxa09tWDhURlpERGFMNTNV?=
 =?gb2312?B?cWlkOHlnRVM3eGpNTGkzYXVsb3ZzYWVyS1VRd2FkdFcvZ3dyYlZCbVJHMkYx?=
 =?gb2312?B?WnpTSkZrS05KZGxJeHpIeVhEZlRxc3ZQVjBsVXpvOTlCT2FHSExyZlMwdkJ6?=
 =?gb2312?B?Y055azU1d1NZVjFkdEpqWjNpWkFOZXUwOEJCdGFZNjdiaHh0b2pTTEV5ZnBl?=
 =?gb2312?B?VFF3OTZHS3VSWW8wOVFQSDBKYWtCNVJCeWVwT2pyeVNDZTh3YnFOak8xSTV6?=
 =?gb2312?B?Mll1Mm9sOXNoSjZJN1pUQ3pSSDNlMytsT3U1WHpkZGRqeTd2WnQzY01YcGpj?=
 =?gb2312?B?UW5LZmVBTXZSMVczL1FIVTY4YTE2TVJrVVVDaWZCcHkwUG5uLzBRYXdPQkxI?=
 =?gb2312?B?emlPdURELzJQa0VmV1VWME0vc0ZxWWZwYW5hN3pNcGhxNzUxL3ZQVlp5ZE5v?=
 =?gb2312?B?TFJ0N0JSRWU5bENsV0NWSC9YNkdtSlFUUk5TRGtwV2poMGhYWHNkbnEzclFD?=
 =?gb2312?B?NHY0M1BWV2kyekFzNnJsOGppOU4wbXNRS1RrNHFHRm5GYms2ZG5NdktvdzBt?=
 =?gb2312?B?RTVqWmRudEhqa1hvaFRjMU15TWlYRTJ4dVpJMDdja0kvMkFPUXl4QWdBMUNj?=
 =?gb2312?B?OUtjTHlhQTBLOWdYWGtxWFFpUFRJZ2ZUTXJGMkFqdUdzSWdNRGlHNHNpbHRj?=
 =?gb2312?B?d3lVOVpiMkJPTmJKN3RxdjBFcXRXTlZGZVNUcVRPUDc2L2RKSEM1QS9idno0?=
 =?gb2312?B?UDdZMm9haDV2TGkzYld5dGFPMlBlREYwT203LzNXNDN2aEVyajdiTDExNHlm?=
 =?gb2312?B?eU5PQk9ZdEpFeXNoUUx6YmRhT1Y4cHpGUzNQRGhiVy9QSXJGSEJHSHgvcWNr?=
 =?gb2312?B?WXBONTNuT1RhZHNmZGFOT2l1N3M1WmZYajk2UlhSWnZNUFNSV3kyTVZzOW1M?=
 =?gb2312?B?NG1nMDFvZW5zOXdZYkdDalc4akx0M1ZNMmR6anZ3L0JTcXNNMTNZbGRrMGxh?=
 =?gb2312?B?QXM3Qm5oQWlsVG1oYytFemFnWHYrRFYyTmdVdlYySE5scXpMczBMRUhvTG5F?=
 =?gb2312?B?OEZINm5nTUFob2J4SmhVMnFWNGVKNFB0OHpPRVdVejl2cmxCeTZaQVRMZllW?=
 =?gb2312?B?RFJReG42SW9pK1hpZXkzUHh2OHNPamJ2YVFyMmhqRXAvbksreEtWUHZsenlz?=
 =?gb2312?B?cUZwM0F0cWwzRG1UVk82cndNVnJ2TXhYa2ZJbHUvcU9QcUhyc1ZmdmpCNUE2?=
 =?gb2312?B?ZjhjMXdobjVIUW1mR0hUa1h6M1BSWlZkZ0cvKzZkSFM4ajJXWmdmVTE0Rjhk?=
 =?gb2312?B?YmY1M2F1VzFCejU4eXBwaG5QR3ZnOE4xd2JDaEZKZGJESjJGOERWSjhRPT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0103.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ed78836b-1f3e-4957-da0c-08da9fad1c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 10:51:47.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1640
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dW5zdWJzY3JpYmUgemV5dXpoYW5n
