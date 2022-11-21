Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637C763295C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKUQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKUQ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:27:31 -0500
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4A10A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669048050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cGveTbYlUtYIGfGjD5yYpeKLamNB5hByN35fm9LvD44=;
  b=BxPthVtutRrM0/MSn6Vzu8c8C/BoObU5HZUMsxNyDc/H1yJYIIiYmsHG
   vSRUvsHSpji6xaUKw7L9sgNbcRDM4cW7uLHe6/0TzbasSYtu1cTciOpg+
   1GOsASqTZua3m+QedtXOF/PQ3ENpYqKTZHe/9yLmJcvE+glPWmz1G7+Ou
   8=;
X-IronPort-RemoteIP: 104.47.58.101
X-IronPort-MID: 84845554
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:VQT8A6OV53tuQvrvrR1llsFynXyQoLVcMsEvi/4bfWQNrUp00DcHy
 zdMDGnVbKrbYzHweIt0bd/n8xhVvJbdmIVjSQto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQA+KmU4YoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGj9SuvzrRC9H5qyo4mpB5AVmPJingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0tcuMUpu7
 NYhExUEawKIqaWykLKUceY506zPLOGzVG8ekldJ6GiBSNoDH9XESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PpxujCKpOBy+OGF3N79YNuFSN8Thk+Fj
 mnH4374ElcRM9n3JT+toi782rKSwH+TtIQ6LaC57NpIkVuq4W0sEwEIZF2Dr/2GlRvrMz5YA
 wlOksY0loAw/kG2Stj2XzWjvWWJ+BUbXrJ4A+A8rQ2A1KfQywKYHXQfCC5MbsQ8s807TiBs0
 UWG9/vrCiZoq6a9Um+G+/GfqjbaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdJN3r6
 zWDrSx7i7BNi8cOjv2/5Qqe22vqoYXVRAko4AmRRnii8g5yeI+iYcqv9ETf6vFDao2eSzFto
 UQ5piRX18hWZbnlqcBHaLxl8G2BjxpdDADhvA==
IronPort-HdrOrdr: A9a23:GJu9a60y4848+sWtqQO/rAqjBdhxeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5OEtOpTlPAtjkfZr5z+8M3WBxB8baYOCCggeVxe5ZjbcKrweQeBEWs9Qtrp
 uIEJIOdOEYb2IK6voSiTPQe7hA/DDEytHPuQ639QYRcegAUdAF0+4WMHf4LqUgLzM2f6bRWa
 DskfZvln6FQzA6f867Dn4KU6zqoMDKrovvZVorFgMq8w6HiBKv8frfHwKD1hkTfjtTyfN6mF
 K12DDR1+GGibWW2xXc32jc49B/n8bg8MJKAIihm9UYMTLljyevfcBEV6eZtD44jemz4BIBkc
 XKoT0nI8NvgkmhNl2dkF/I4U3NwTwu43jtxRuxhmbim9XwQHYfB9BajYxUXxPF4w541esMmZ
 5j7ia8jd56HBnAlCPy65zhUAxrrFO9pT4HnfQIh3JSfIMCYPt6rJAZ/mlSDJAcdRiKnrwPIa
 1LNoXx9fxWeVSVYzTwuXRu+sWlWjAJEhKPUiE5y76o+gkTuEo841oTxcQZkHtF3ok6UYN46+
 PNNbktvK1ST+cNBJgNS9spcI+SMCjgUBjMOGWdLRDMD6ccIU/ArJbx/fEc+PyqQpoV15E/8a
 6xHG+wjVRCOn4GNPf+nKGiqnv2MSaAtHXWu4xjDqFCy/PBrOGBC1zAdLgs+/HQ0Mn3TPerHs
 pbA6gmcsMLHVGeZrqh4DeOJaW6CUNuJfH96exLL26mk4bsFrDAkND9XbL6GIfNeAxUKl8XRE
 FzFgTOGA==
X-IronPort-AV: E=Sophos;i="5.96,181,1665460800"; 
   d="scan'208";a="84845554"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 11:27:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIoxd9JhG43ATbf3w97tlDb4bQ3lwzWvfEL7XmdRL9GAqu20lNH/YcdvOJG+Q+89BPQUR0iGMWWDeosjjE/kBxPx2pivMHJmACWz634Y3LSmZs2Tt86W1JpcevtUcvJkG1LMy2Wzonp37zeEiV9mSMPve6pzKFm8sLE7em8s1s/9evWTqLHtKHGPrx4cZh8CFsW/DC74H1Ww8GJQO7b/JXvpLI5F73tsR55b7Aue0DJy++sePbD+iRoRP/0KlKiPKXxNXfvu+a2uWUAtwhKh45985X9mAx/UuLwhPSg3KyY8dPd9wCe8OubhKxYkrfr0dIWGAK7NCxlp/Dv+TOKEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsDEQpJHO5qJ24sFtz7HXkUECot20VnojR6DUr5V4Ms=;
 b=ntMaA6Azl3RsjhJsBsXqCj0Nh/G7UGhKXMMdKTVbWGWigxNxCcmYe4fCiELKfT9btdOexdWDJvVQFkTRmLiPr0wGTB4J5kSPZ+a3aDP89JUQaKtlKcOmb64HH1bZMzctJ1o6c4SNhLWSnN78oRD2usZABbH8F0UJPvZJ+7351afYCELUdTR0AWlp1sqmG5xRKgHz8NpaqPECQfXa+LaV9ac1n9jIy1Sw7C7NvTpOtoqX1ztIUtXbh1nq2nTrOeBLZrBk+RGS1iZXey+0FJomW5bEOGU7K+yOtKa9iZ9V8dWXlTfKuRzEu8bEQXxjFfHdxC43DqpyumPgXyhklaNIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsDEQpJHO5qJ24sFtz7HXkUECot20VnojR6DUr5V4Ms=;
 b=pIAVQ+2ynKeGQBPgqQ0zJFez31ldOzUOS0ZEt2X55FWlZoe67uHlPnttDZuBeHzYQ529uifJBCoBAnv1K2jcHxpUgiqPW6CI8RiOq/pW7CP3ZCGcpPxGhjxzsm2ZvsTCUt0AlK+Av8j5BLnh2oN58MyD7V5pKabn6pg/WQvWhUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by PH0PR03MB6350.namprd03.prod.outlook.com (2603:10b6:510:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:27:25 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:27:24 +0000
Date:   Mon, 21 Nov 2022 17:27:19 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] xen: ACPI processor related fixes
Message-ID: <Y3um59/fBPetF4VV@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <dcecfb8f-f90f-2250-2dbe-a86fee5cf263@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcecfb8f-f90f-2250-2dbe-a86fee5cf263@suse.com>
X-ClientProxiedBy: LO4P123CA0573.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::6) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|PH0PR03MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f828085-d316-4891-b486-08dacbdd45c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avCsakB1YpFdIiWP5zy2QqBWzI5kBMasDQiPUn9+CYwfs5xlmk0NxdNKXK9LPydPmHsY8XtwWVvZoR+tO6kyzWM01z2cmXqBvmO2i4rjkjnYQWHUUgCJsxhK5nSng85crDHdIb7gMqEOuUOm3ERyA85yE5p759uh8YHlWFfVayjsMvQrO38zP/hNr5F8KKcB223FtVmW/CB+TfG8v+LwzQZsFLR4vdwSOwKJhYnzRjRQpgI2984BOe3fL35CQD6MDmHoDSUE2ZYpXRXVQtjbEx3W8cQj04NpE4c4mmdZQp9hnSKsNHS+OxhH7empfmd6kwpHmOom76aVhKddaCUgUoWTeE4Gr/JfyJv/PPwvjuS6y7vSF42g0IZqQRTFJlHIKByyVz11ao6t4glzOs7zcO3i7pe9n6sqQwOosd5RZ/xkG9PGp9Z6uxG7f1AN3rXFso+CVS0GHgxVrrPy4mGyvOjPfTUTT65oLhw723aO274i6AdfhSGUIulRPz+YIW93s/vM1VADhfQQdcpLAC5ls7YBiQHRDL8IbW9h26vC2k8mrh9QDBwoeQBjs0oz2t5buUKkCuA1/5Y6U05pK4nOfFkkfCFuMUvczH5Lzc7jbLy5j0koc6DrmGN4VRlP6pN752soyJ0rAhb/emOv+12WtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(82960400001)(38100700002)(33716001)(26005)(86362001)(6506007)(478600001)(6486002)(53546011)(6666004)(5660300002)(8936002)(4326008)(66556008)(8676002)(66946007)(66476007)(41300700001)(316002)(186003)(2906002)(6512007)(6916009)(83380400001)(9686003)(85182001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Jzczk1V2hpd0k2blJyY1JjeVlFL2dnWk1kTWdPSE5TejZNUGJ3MlhXU2hh?=
 =?utf-8?B?cjl5SitwNmRQd2FvbWNEOUVaRklPQzUvdW9HYTZvNzI2NW10dExZV09VdVh1?=
 =?utf-8?B?LzBNVVlCVGJrY1NBZXNaQ0FxNUhhRHJkZytwUGVaZjZ0V0gvNEhPUGZncVBI?=
 =?utf-8?B?WkhEeXdEbkk2RUlUNnhJRU9lai9wTlA2U08yT01IQlB1elY5QkRlVHVlNjJa?=
 =?utf-8?B?TWpXWGVtZXNYMHdFeG9HbE1kakE1azBacHVKQU5FZWdaUUZEZ1FleW1vVlpZ?=
 =?utf-8?B?ZjR1WlRyMm9EN1dDajZaSzNpYlpmd2FuVHh2YlljTWZTUUVLU1p1RHNUYUFp?=
 =?utf-8?B?SVJCWjFaSTFnQm5aSGVUWVhPeS91eVdWQXFUcUp6MzdFeG5ZcUVBaDRaNGkv?=
 =?utf-8?B?YUNXZkJZOHYybE9VM3FZcHY5MUc2REJ5bVJyR09uL1hYWUp5ZW9wK0hoQ0Vk?=
 =?utf-8?B?SEZsTHZKQzBwSEJPTGp6UUlkUUwrcHB3K0w1SHhpdkx1dFJTeHdwKzlUbGMv?=
 =?utf-8?B?SEFtWlRkczJydjh5TmRTM3dqak1lam5hQW1HSUJQRWlyeUJ1eUhCc0hhNnNS?=
 =?utf-8?B?NHpiR091Wmo2NmowNThnZnB1Ky9GVWZoVUFHbTV0VThUSXk4V1VLQzN6UTZU?=
 =?utf-8?B?L1pwbHFmV2w2bW4zZXBhTG4xTXVjN3VlYmxjMW9rNEdWRWZPWDFMSlBMVFlu?=
 =?utf-8?B?N0x1b0Q1eW9nNkNmenJYVVRxWTY3WE1CTWU5d3dYWHpFVjVZY0RpQ0IyUWc5?=
 =?utf-8?B?amFsanJYM0g4djJSdlFNS1hkUmVBR1dISVJBTURqYitkNGExNXhRQXlQeXZl?=
 =?utf-8?B?L2FaQjZyYXhqSXRSbTN5LzB4TE5jQ21jVHFYN1ZzR01oY1FXL3Jibks4YUpX?=
 =?utf-8?B?QUNvK1AyOGpOb0RtUFNTS2Zlb2hmcm9IdTFUODJkTzBFMGJUR1hxTmxvYnBH?=
 =?utf-8?B?T3lCckoxRDFTclo4c0lNUWNqL3Qxem93bVJtejRmaFBOR1g2bXJzM3hQYnFy?=
 =?utf-8?B?Y1dZbUpTODFHWnZ0akhkUWNrcGlyL1E0eWRYUUpYZTRSQis2VkNHRmkyUmhy?=
 =?utf-8?B?dSsrY1djK2ZEeEtPVWJSeG5KUy9iYWZQZ3htWGpObzE3Y1J3UXlUMzNUeDlp?=
 =?utf-8?B?WnZxTE1SVENhNzlwMUJaN244UksweXErMW9zVis3TngvNXFyQzU4STIyc25N?=
 =?utf-8?B?L01yTTVRVzg0L0JEZzN3alNHQ253RVY2S3VaaTRDbjlRMXJacndFK3I4ZEND?=
 =?utf-8?B?bHVpL0FnVmNnd3FLTWdrUDh2MlUrS1hZaWZVYXNoVGVBaVJZMGVwaXVjMzQ5?=
 =?utf-8?B?aEhEWndKRjdkVURyRDJEeUd4MjQ1MGdscTdGSkp6UlVkYmVMYnhCNTNHbEMw?=
 =?utf-8?B?Z1NlNU5HYlN2THB0RWZGWHN5UGlzNzBMKzlkQ2p6enY4Vjl6VVZFbkZzN2VX?=
 =?utf-8?B?ZWs4K2ZZVE82WEZGUkxpSzJMVFRZZDNlZm81R2wxQ2t5VVJScGU2UW9qQ2ZU?=
 =?utf-8?B?ZlAyRjk4TjB2bVAreU1uV0tZMmQ1MHRoSnpuWHUrRklZcG9veWR1VGU3N2FH?=
 =?utf-8?B?Y3NmZ1dtVmtsbmQ5WXQrRnJlTmFDYzh0ajByelFBZ0QySE5mSkdpckRjbHl1?=
 =?utf-8?B?KzlvMmRTZ2E2WEE0V1N4Mkx4VFRXc2JHaXM5ZWh1ckszRWdDVFVSSXJrUEdR?=
 =?utf-8?B?NEhUaFlMYnFRY3ZhVHRCVjV5OW95SzZRNUNlS2NrYlFXMnB6amo1MVlhODNs?=
 =?utf-8?B?M0UwMmJVY2NlWVJURVdwNWtra0lsLzlEemEyeUhOZU9NUFB6WUtOU3dVUWpS?=
 =?utf-8?B?QXduS0NpUVczQTliZUtKeTVUdjVRRUdRODhENno3M2xLQm15OENLTEp3Tk1F?=
 =?utf-8?B?OHNJVzVGL3FSM21ZTCt0U1ozKzlUaUpPR2l1bEFneC8zM1NUT0hlbUFvQkFo?=
 =?utf-8?B?aVYzTnZXQXlZVnNMQkZWcFVtZzhEYkFYTm5wWnZaeXMxNDlsM09QdC9lUjd2?=
 =?utf-8?B?VTJtQzU5Nlo5S1VhM1hXczNmOGprTllYRktpOXo4eGlveHBSRjRlZTRYeGZH?=
 =?utf-8?B?dWVIeEVVR29ac3RETXFhMktGTlN6MmRUNzBvTHBJZXY5YkxCaXppeExqWDRV?=
 =?utf-8?Q?iXwvticTTHULGYmZcjBngVpoJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o+sqLHxymIPca3z3XM/2t0I9q89f7wgQNv8mHsTFpyUhAQPczGCGBKV2niGI82KK1LzTuipQBUMxrTmisBcz1TufQTKkKVbWmujVWSqn2evhg+tBWd6sk81kcScFYxFFgBZ98Ji+WPpYrjhUpntQI6ghYTP+mN6kSFiWsKU9H4Ti7ldF3Ov6j5Nkctb4C3UEGFzMJcss6Rulgpk6ykipK3oKIEDxsZ2v2H2KF9RmsTax5HN5UCmdp7SqmTAXSz0M0cHvnN78ANc3KJND78ipxe1x01FLC8ZNi9XmT5H2EsfK1j5VihLlwHTA3E+jJi0YYGxh+LA9sXrtKBWesQvxO6YxET9btstkeXS8ZzCpGQxVzwM5iuFNvq+7w24QCk95KLxT5SgyMZZai0Em+Ugnas7X+xcIBWInvwlhPN5OpQ1O3S4lDOkXmDhbod8W+zubaZbfKFUJyPqSFNxHWmbfimS45SC+sopNFW1BJW4Zp5ESRizCfaGnHZKfgTvQqjOc3LDGpH5mdkQguKF4gkLhcGR4iLRA0pQvQ0wlxk/yGtu060Rq+ABL2dMJMZr/sTK68CijnzevmiOaLgl8YudcXLFTkia3JmyeD7T8xFq76QQiUr03alThmm+UxSu7av2pmnYr09bpz5zhJa4NCxyblYHEoe9c525FrkiFxs0M0z7rHf9sgfrjfIF6cTuWW4HnnwgGJ55D15qjZ1rOrued4EN2VcbdFz3ceP5aLF9dHkwBicYWfqdGf8oAelMYI4wSkIGqsqy1ClXxW4Kfd2LxIbniRqSVML4UIKKsY1oXB6B6lNpORR7sPvmQRrThahyQb4C6tchrye8GA1gWepZiEmwJYd57GfKX+GDRvXLBfEsq4SwrndNMumeAlsm3M6zu
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f828085-d316-4891-b486-08dacbdd45c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:27:24.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gq+BjUuQjIsGxnzgTx0NRgszJX8XGRXDv3J/u3biWfVbrcFQaCIotBSNaQk6DtS1vxmhacPKqhXWTjnuC8VKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6350
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:20:53PM +0100, Jan Beulich wrote:
> On 21.11.2022 11:21, Roger Pau Monne wrote:
> > Hello,
> > 
> > This series aims to fix some shortcomings with the handling of ACPI
> > Processors objects when running as a Xen dom0.
> > 
> > First two patches fix the execution of the _PDC methods for all CPUs on
> > the system and not just the ones available to dom0, while also making
> > sure that the _PDC capabilities reported to ACPI match what the
> > perfrmance and power drivers in Xen can handle.
> > 
> > Final patch fixes the Xen ACPI Processor driver to also work when used
> > in a PVH dom0, that has a custom build ACPI MADT table and mismatched
> > Processor UIDs between the MADT and the Processor objects in the dynamic
> > AML.
> > 
> > I don't really like the current implementation of the Xen ACPI Processor
> > driver, it IMO relies too much on data being fetched by generic kernel
> > code.  For one the generic fetcher functions can take CPUID data into
> > account in order to sanitize what's found in ACPI, but capabilities
> > reported to dom0 can be different from the native ones.  Also the Xen
> > ACPI Processor code relies on cloning the data from CPUs in order to fill
> > for the pCPUs > vCPUs, but this is wrong when running on heterogeneous
> > systems.
> 
> Yes, these are problems (and as per reading the description of the
> last patch you even extend this "cloning" of data), but ...
> 
> > Last patch introduces some helpers to Xen ACPI Processor that should
> > allow fetching all the required data, for each ACPI Processor object on
> > the dynamic tables.  It might be helpful to explore disabling any
> > Processor object handling done by generic drivers and just fetch all the
> > data from the Xen Processor driver itself for every Processor object on
> > the namespace.  Likewise it might be better to just execute _PDC from
> > that same Xen ACPI Processor driver instead of polluting the generic
> > ACPI Processor driver.
> 
> ... cloning functions living elsewhere also has the genuine problem of
> them then needing to be kept in sync without there being any trigger to
> know when an original function was changed in some way.

Well, yes, but using generic functions also has the risk of them being
modified to take into account CPUID data for example and then the
result would no longer be suitable for Xen's usage without us
noticing.

Also has the downside of parsing the data into Linux structures which
then need to be translated into Xen format.  It might be more straight
forward to just evaluate the required ACPI methods and parse the ACPI
data from the Xen ACPI Processor driver into the format used by Xen
and upload that to the hypervisor.

I realize however this is a big change, and would mean almost a
rewrite from scratch of the Xen ACPI Processor driver.  I wouldn't
want to start that task without having agreement that this is the
correct way forward.

Roger.
