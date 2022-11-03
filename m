Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA4617E96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKCN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiKCN6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:58:54 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2185.outbound.protection.outlook.com [40.92.62.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2FF62
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlS6MoL5LsRwcaJ1ywuj5250ZsgJiaTMz3XosrwIvVsyjUVuBjC1sMltoyxxlmqcvHYy2OolXxjjUsJh7KBa3PIbzstp56YeECMsu2+YIlPD76F9IijviOFseZObZVloA+ss20t9xp9eaESAOOWJrNT90Mgwap9hHWHMDD6jb3xycukGUczJ7NOd5Pk966g4oCHhgNsu052BxR0j117XLfqdvVxyO1qZAqHn9tioXXwUuqOmiTMuzn/yY3kZJWuUEzcRJMVa6HSNLZdQ0M2f6xqFLPqBhoFdQ6eKKiSLpWeot1qKKNivqfQT+cgJyLNYPdEVbUpk6MeoEUXqeWnxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW+rxAEP9BS9FmYWOILz4EV93ttRD5lOPzY0+8WYeNQ=;
 b=Sa9SyC/TYKg3Y1NR9v3w1tyBp3Mm1OdOFxmSLNLHeJ4YtXCdYUCxWzOsnm6eiPQG5pEq7piEpb7FEJggE65zdeyeavfTzD60TaxLJ7nMMdYCZniTC8WibeLheK43tOu6+SKxxAWWXq7muLxpVI1e5jz6gYCmNab5Pby0YN4DxyaxqbikvDw3rPg+0LRKam16qW/DNpD0i/uJ8NhTeyndqAZw+e44bj8EwM8Kqzj3iX2gl3Q3ns4SNI5Bo0JfnWQuPsHc0R8ZQ2ft/nLHYAuY/JwysqKaigKiuKaTEgiiur1w9S0MfPjXRaFKR2mp5jPnpGL9i3o7RTBqiM2smdMuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW+rxAEP9BS9FmYWOILz4EV93ttRD5lOPzY0+8WYeNQ=;
 b=NV2vDgwCFnXYnNlkKYKpmnxJbhTMti3qDlsYFRp5nMI+5F8jDjaiHx4sdRTucKjKMhNk0gktxiKHXFL4D60aZlrCmhCh2WghpEOn/IhrKg/jy0OzEIf40MYGt71W7EzuqLSqP7W7wnC2VukbLVAvpnNUi96zsTpehsOrvlDL+DUd95O0Be70t0nYmhahO6s4ekZMUs71Qa16BOq+VF78WYW3eyU4Rdvzg+EzgFXLZ3/cV8+QoiCx4IU/1D1WCbMv5n1FSuB/9DH4dsrnIdK9wRlZ6ufYkOVMHzCd3j4lU4dEAGWDeowlcbCFyPobyfgshP8RmKdjIp3E8kjmgGAL6A==
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:172::10)
 by ME4P282MB0806.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 13:58:47 +0000
Received: from MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da]) by MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8e6c:7cd7:be5d:66da%8]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 13:58:47 +0000
From:   johnnyaiai <arafatms@outlook.com>
To:     jgross@suse.com
Cc:     arafatms@outlook.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, johnnyaiai@tencent.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] locking/paravirt: Fix performance regression on core bonded vCPU
Date:   Thu,  3 Nov 2022 21:58:35 +0800
Message-ID: <MEYP282MB4026FF84EBFFBEB36C9E1682C3389@MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <eb487a30-7491-1ef3-fb11-4dff342215bc@suse.com>
References: <eb487a30-7491-1ef3-fb11-4dff342215bc@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [s0lPQs5wZm0oFBdibT3hiqjyYQCbYrfr]
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:172::10)
X-Microsoft-Original-Message-ID: <20221103135835.3432712-1-arafatms@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB4026:EE_|ME4P282MB0806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7311d1f3-e937-40a5-2e2c-08dabda3871f
X-MS-Exchange-SLBlob-MailProps: laRBL560oLQowKaVx7aWRS10pPzSaWhbYtBB8ss02XkBc9YsyiG5OOsvspan8lCLlupuiSf7UWR3uLfwXMwKETd+0v6Cg25VS/mDNAs+2RU1iS9g8Svi2ZEeuR5s75OTSM238udB/GgWUaFFDnOdiDM2q/4ffrIXigIif6o4QCMBBd4rWYhZaEmxhoF8crl4tYegzZWCMsM4uuvE8ye4w3UYKqCNyx3nCExss2zBpmKYo/ypTyBBHrOLIyyf+U7b2vbGIg0y/JoPtyHEL+N5qPKVDMyFX5juivrZSIACoOeKxgJBWAyJiEkXh1tbkkBuRaPPCPXkHLj9ppdMUDltNBdhkkNxe0rGJM0nsXj5vvZQLmVQvcbBIynI/rxzfjqpR94jls7YkQ1K/AYq95QP8J3bV0axbroUkkRniTh4KEHAMaU7gBGt4ByoPAoQUEcfBZBgfnKC+LSRZhs0hIFLbrYABc8whMzxdmPyuUwOQZHVyxu4kA5zWMytQ+2QbwuxFZDf90UGkHaDise55ycQ/9myVcf9DcY0pFCvcNLEnhhmDsQ9sE8uQsUkjzvXLRxy9vqIbYmqo9pDqCuw/h3HM/Y70H7YWAaBf+YnszNuW2BsFGyRx1IjZaFVh3iuJsinjfCFRRn0M9ePL3rv7KwQPZ2lI58WrwN5WXCpvMMU8Mvefv9u5u2Jge8rQe87OGpBUKdK6YW3wzQEXyrVDs51GZLlpNrpue4TWr9uRQOVcVoCkx/ilf3x36NwGnXepF8h/jg8iZeQR5gimHdoSlc7GYOxS/5C+l61
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elnktPdqpydZgRz2cn6Vrhc2eXgWsHf+/Q6RR5b3yjENoB7yscIuxIPselaXInqRaMedkKuRFdUmp7+HsF2/Mn5RwDRiDhPagTP6XZj3JxCTxa7A3RF6t1GvcqpiDA7tlYdRDXUj1+Hc8E2mg7a3lSei9S3IqmSrQQb5dCK86jhERcpIeDKoZYbTVl1+H2iULF/sv87n5jFf7cZrdXUhUwNf+3jtqqMmYqjYNRY0Lf8OdMc+KI/UuNd07aGocsS8v2Gu6zoOGuWRvo+e35MOfWvQu1ShHAfO+qwfdqQG9o49scYLltSWncHuX4FnPrzcb5ANjPX7bTlFcWqAIuxA5nqu/ULcSsYecf/2B2VMzGMa6/TAtaqXGbtBfN7LMLphPodPleQYY0itHJzyylrkD/UyqLyDpz6mo7tnwG3Y6uQ3Yq2nsV6aEOU7YNbQKFfAEbBfKRd4KKGGaj56AVpZcZwrsFKJ1CtCZDACFbdIXlAuXYFzgo30uD9XMqDFt8LzcO8DQg6jUQr9Rk85I1HpmGJl7d8hgLIHDx1xeWSzRRyeFPrH3rWSCGOZNa1pqiaHIjkVCc2k64K44AwjJqkjvI2RzsDphPTOTU0bgSxEjdyqKwSyiYkKoR/y5wcA41AY2hZhvJ2hPB4tv20T2NBQmW4a/GnnEpgzXWYo4vdCqrQeUixOMmnYd9+XkywOJV2VwKx07kWd5A5/P4kjkkvedlKQrvesYcORzY/YgkZgpMM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yi6vtKI6nWLePfGlQd4JdXxvPczFmGjxaWyRMJ4nnUPYb+7XoZXG0R1PGsFC?=
 =?us-ascii?Q?40WgtTgvWr1IxbOgBNyLs1nnMkCZM1hNIDG43w5lCpkn67jihfaCV17t/pf7?=
 =?us-ascii?Q?fnX6+hCxGnu/Zfbs7aGzAUEi9nVsa5qzoeZF42gUe8VLqzlDoHLbkTq2A9nJ?=
 =?us-ascii?Q?dCgtM3qiP0pnqSanAw/Kywyu3MnHvEptKEDbXrjHlr8T6b0gkHX2qgw4lbzH?=
 =?us-ascii?Q?cWpX93CPAFoLQ4Jwx3S8I1ajY4Op6W3I82zxAaIqfHPmLnmHTdWDnRGD+uMs?=
 =?us-ascii?Q?yJJHPDpzcQb7LvxWBHakgwZyiY30RuQoOdoUnPHjePNevw/9QdojS2hFiSFN?=
 =?us-ascii?Q?s8OcvGSg0JgWQY2s2T8Xdhvt6rYK/YbxIwzv+7wPiPEStZg3kReMY+YiepeZ?=
 =?us-ascii?Q?R+54jdXYNHUfshXgOPYG8xKqkM72fpXYkCVvUgfQ8aZj3cUw6Jeo8fiyNn+Y?=
 =?us-ascii?Q?XwgOTJslneP95YgWDJ3f4/ZSX+JnI446GMgln70DMo9uqrUQergzja6zYm4f?=
 =?us-ascii?Q?zlgwpVIjEGCe4MgiabzT3T80bAdOrkb0zcVaxitqzC6hQeawwREoVNUXtPA4?=
 =?us-ascii?Q?wWLNVgud1dHh+ZLFUSxaI8RxVKvU2H03JtKAhFLcuFBWcKQTIDhyJqyxdpWv?=
 =?us-ascii?Q?r5l87D748sImCtpnfn1+XcabIx9YsbHBViiokq9uaPfV53n5vZ+CSM5GMEmt?=
 =?us-ascii?Q?LBlA9HjpQvnnnLNzMQbd3dHEmOSyKqy0Q6OEulOi7hnb/vz2cQfbzwpc2SWT?=
 =?us-ascii?Q?aTikeWrUE9vM7kJc7CVGqi/0JAcA/qUCtnrPOuTC7vYozSTf0uDqn4mw4dyB?=
 =?us-ascii?Q?lPxgYU2U7zQNjbblUn8u+dRYzzFJ0n76BG1Fut/vJ7nhJABFC28pCH1ogx0h?=
 =?us-ascii?Q?io21Jukq+gQ9miSqwBIACp4+4PZLDlLDEvsPN8oPOsUtizG4mprjvLaXWF4D?=
 =?us-ascii?Q?9BC+hJNtTcrxyQjIvZDeYrFYcSwcRgHLZrRRYvjz97zRAdMYOq+V7YPBPB2Q?=
 =?us-ascii?Q?acab6V08JZUBKO6j7qC9YipVqql/xJAezErCj4KyZ6tleilPqVPhSIwl8lPp?=
 =?us-ascii?Q?6ggIW62S10PWJSs+8CP+1yurMFHT34qjHGktlXR9//0MH8iBSpmPEeq2nuYF?=
 =?us-ascii?Q?x3dwJrxMVoPoFnczsrVp86II/C3hH+LZ5Ynf8UWolvfapW0HLDnXkw9uJTO1?=
 =?us-ascii?Q?A+fgYRt0dpvhVItiEmeKy4SYOHcV5ejw05ZNXurCVBsvl+FZIPb5SRe54i+/?=
 =?us-ascii?Q?i6f0ocaqa1kI11p/LOTuOqqYJN3aTAKlpkVldK9j6Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7311d1f3-e937-40a5-2e2c-08dabda3871f
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB4026.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 13:58:47.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reply! I think nopvspin parameters controls
pvspinlock or native spinlock. a vm guest always running
on virtspin wheather nopvspin sets or not when EXITS_HALT
not supported by hypervisor. So provide a missing parameter
'novirtspin'.
