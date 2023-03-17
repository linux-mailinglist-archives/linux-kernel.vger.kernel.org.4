Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4956BE26E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCQIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCQIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:01:55 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 01:01:43 PDT
Received: from mail-edgeKA27.fraunhofer.de (mail-edgeka27.fraunhofer.de [153.96.1.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76C7AAE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:01:42 -0700 (PDT)
Authentication-Results: mail-edgeKA27.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2FOCAA1HRRk/x0BYJlQCh4BAQsSDECDfYJPhFORAS4Dn?=
 =?us-ascii?q?CaCUQMYPg8BAQEBAQEBAQEHAQFEBAEBAwSEfgKFNiY4EwECAQMBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBgEBAQEBAQYEAgKBGYUvOQ2DVk07AQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBCE4BAQEBAgEjBAsBDQEBNwEPCxgCA?=
 =?us-ascii?q?iYCAjIlBg0BBQIBAYJ6gikDDiOyAHp/M4EBgggBAQacVRiBHYEeCQkBgQosg?=
 =?us-ascii?q?0yNaIJPgTwPgQaBNzc+gQUBgxEtFYNDgmeZAgqBNHaBIA6BPYEEAgkCEWuBE?=
 =?us-ascii?q?ghrgX1BAg1lCw52gUwCgVolBA4DGSsdQAIBCzs6PzUJCyFeawItERMFAwsVK?=
 =?us-ascii?q?kcECDkGGzQRAggPEg8GJkMOQjc0EwZcASkLDhEDT4FHBC9cgQEGASYknGogg?=
 =?us-ascii?q?Q4xgVBzHpJFAYMai1KiDAeCKIFVoHEGDwQulxaSKZdqp3ECBAIEBQIOCIF5g?=
 =?us-ascii?q?X8zPoM2UhkPjiAMCwuDUI96dAI5AgcBCgEBAwmCOYQShHgBAQ?=
IronPort-PHdr: A9a23:wKuoBR04ZvW943jlsmDO+QUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodWDrp9B7DTqrzuCahpMNchi25MffNZIsVa2zh6
 5pmVTjk0RYqL2IG+1Hat5kj6cATqke4rRtczr/tXq2eO/wmfqX8Id8xSGtiUNRPXiFbGZ6tT
 LcSJusaMbhahoispH8NkCSuLDa2O8bXzDJDvXP1wPMa4dUYDz3Hhyh7PvkkoWb9ru/lM7kZb
 e6T1oLu6A7zZMlygQbj1bDhTQAz+8vRQOMudcjR1EkGTTvGj0yiiaPeMRWl/NUhjDjAtuhGC
 /2vim8LoBlwpQqI5cAzmobujJgH52HY8Qx1x74OH8btGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZkryBP8QqbYNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="50838543"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeKA27.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 09:00:34 +0100
IronPort-SDR: 64141e1e_3Nl5rKR4SHTN1yg7J41ulNu7W6eEkP8Q59y3mZxM8zzeqac
 zS/lT4WXqFDQoxHxb8K5MJg7dpLfRYzkVJiHUvw==
X-IPAS-Result: =?us-ascii?q?A0DoCAA1HRRk/3+zYZlQChwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?AkcgSqBXFIHgUYqWIRSg00BAYUvhg2CJAM5m22CUQNWDwEDAQEBAQEHAQFEB?=
 =?us-ascii?q?AEBhQUChTMCJjgTAQIBAQIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQYEgQoTh?=
 =?us-ascii?q?WgNhlUBAQEBAgESEQQLAQ0BARQjAQ8LGAICJgICMgceBg0BBQIBAR6CXIIpA?=
 =?us-ascii?q?w4jAgEBphsBgT8Cih96fzOBAYIIAQEGBAScTRiBHYEeCQkBgQosg0yNaIJPg?=
 =?us-ascii?q?TwPgQaBNzc+gQUBgxEtg1iCZ5kCCoE0doEgDoE9gQQCCQIRa4ESCGuBfUECD?=
 =?us-ascii?q?WULDnaBTAKBWiUEDgMZKx1AAgELOzo/NQkLIV5rAi0REwUDCxUqRwQIOQYbN?=
 =?us-ascii?q?BECCA8SDwYmQw5CNzQTBlwBKQsOEQNPgUcEL1yBAQYBJiScaiCBDjGBUHMek?=
 =?us-ascii?q?kUBgxqLUqIMB4IogVWgcQYPBC6XFpIpl2qncQIEAgQFAg4BAQaBeSWBWTM+g?=
 =?us-ascii?q?zZPAxkPjiAMCwuDUI96QjICOQIHAQoBAQMJgjmEEoR4AQE?=
IronPort-PHdr: A9a23:XmK96hRwx6fHEHjvvkwkf4fLu9psovKeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C8zDnjP1j/pA2iOXZt/fbO4wejiY1
 I5QaS2wyyM6OiMe/Djmp9Qss6lrrS/09Hkdi4SBeYuSF/dPR53xdtwcHWpHf5pdfCFAIY2uc
 YICFfEcLMVksqD8vFdQrzK/VAqIB97Q2hZ3nEDT5as32N8tEhyY/D4RJswysS/w9/TeHrYAe
 OKP3K7WxgnNSel9/xLG2IPyVkgQv8y0dI1gY5DrlFR+SQfHjkiQgNbdPDKM5MQiiGa938BRe
 d3/0DcljV9uojmu6sw0i477oaES1UDL0i9j0qsEOdmRRElDWuS/RcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gry0iyEuiLKCp+hHVrdaj5ixvhuUSjy+ipTsCvyx4Kt
 StKlNDQq2oAnwLe8MmJS/Zxvw+h1D+D2hqV67RsL1o9iKzbLJAs2Pg3kJ8Sul7EBSj4hAP9i
 6r+Sw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:33RYVa5vn9Zja603pAPXwNbXdLJyesId70hD6qkXc203TiX4ra
 CTdZsgpHrJYVoqNE3I+urgBEDjex7hHPdOiOF7V4tKNzOJhILHFu5fBcCL+UyDJxHD
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="44483565"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 09:00:29 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 09:00:29 +0100
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (104.47.7.170) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 09:00:29 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HueHdgjuWADqqjkB2Mlpse5V07A4qtlHSixK+5EomqSbSqUsnf9yw16hsIiLA9FaGQT0OdVM8eizTZsTPaGJQpB/VGuKdB5lp4sep1siTISiwDBIxWuKTiz9L8bhgOQk5SjG5/Tl31hiffP2AdcLlIV6XIhIrChMIAkOUDSGwMxbqlEX6Uc5+pq6bS6KwW5vQhF6HVanc+lQavhtRHdw9rTD6woYw44XUNR0F/F8/U6wO9aXtWWNSSvOV7d8tEp95V/76dO7QShH5s5UTD+7Ze5yPszDdcec8hUyfM1Fcf3qOQ30QYBrDC8eYmUIExkh1qcL6Nz3CDXjXjma6OssJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZDpgQxUjbe3zAI6lKdRSASIZ0+lUeuOd1YEp4WcXeU=;
 b=WbQChADacGi/EhMRw3brouUvLfRW3oNUhLiaM6FolzHSle5aOJoJv2QS5Hbuk/eWfZ4Ih5NUGmHUIyOyjuG7repuFbuKNBjhGUxNnTZTrPHPurFncZCbYSpwN9nFs2Jud6C/oppOdRW30EanxiFDkBnOLVaHcwA67MS8LmzU54ckRMQ7DzS0n23DqX8T30RvqAzk1SUq9Ambhrtdgo4k5o9HRAouG9ztRpWpevZ3KFR6wMVEydQgIom9MthYgZaKc6iRiZxvilr/VY3XhvjZWxqL7GsnIUDP3n4Re6czsA67HGvxbZs+lIQofaXVK9nX94xmj2cp9ia7/ppCSAd8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZDpgQxUjbe3zAI6lKdRSASIZ0+lUeuOd1YEp4WcXeU=;
 b=qboKeYQVDcgn0hnI4dCeiKfzvaersuyKTuAisd6jAi9kLkUWxAWrWMPnecSdku6HZYQvTi3L3ICByzAjRxovcTfNrCNMSXcRL0YvUPAWxz2R5u96ljhuhA2PkiqZHGSfNXBYDW831jN6whiiDcpioZOKowxgObrzEYtlAdoPSRs=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR3P281MB1804.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 08:00:28 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::695e:eca6:9177:29bc]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::695e:eca6:9177:29bc%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 08:00:28 +0000
Message-ID: <1f58acef-1e93-ed7a-3ad8-dd0927dacddc@aisec.fraunhofer.de>
Date:   Fri, 17 Mar 2023 09:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dm verity: log audit events for dm-verity target
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
CC:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        <gyroidos@aisec.fraunhofer.de>, Alasdair Kergon <agk@redhat.com>,
        "maintainer:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AUDIT SUBSYSTEM" <audit@vger.kernel.org>
References: <20230301113415.47664-1-michael.weiss@aisec.fraunhofer.de>
 <CAHC9VhQ_zvTqck4A7HvqH2rcwxuato_9nVWMk_Yf=ip3q9omgA@mail.gmail.com>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <CAHC9VhQ_zvTqck4A7HvqH2rcwxuato_9nVWMk_Yf=ip3q9omgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR3P281MB1804:EE_
X-MS-Office365-Filtering-Correlation-Id: 69afe9ff-beb2-414e-841c-08db26bdac09
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9aOcJSqrCHiiVkppXDoFEBjdwz17yZYoybWsQU4oUc0bLXRbMqVhmNoUlEbuo5sI3Xy58R4/eS+SOkl2tKMYdnYn83EnfhVRLKKi4KFA9ZREZP1jbKvm6a94OTh9AT2oT8OrH3cBXyMsH0z2Ssg+QbM1ACTJJeSQVJjQUvg0rZBZTlSkvSeZpPWTG2xUZEH2/h4AZb2OBRp0bj8K6ZmhoOZ/tu54RRpIchUzzmz/vvv+Kj5xy3TL4JrX37xisqG1qWdoYBE0A7KX3pR9n2XWkpFZ5bdv8F0+Le5MginHTQA0dSK4KpPNSFMDaq5/aZWZ3kM2XHep07jMcP/F3m/DAQQHZipF8hKLfNU3FduZWGSyxiIgGHphacvdBfS52j+IrQKQVBQZQpiavBz4aiyVu1tbFyZJH+bJ/SR1mk6FMv7m7AnBI+KeC4uRGBXkAVbXhb4GjJYg/LXiGyfRomQkfUqX1sZuSvn8KYrlF0XkQ7AKcmTJr2FcVsxZlBcNUqfhrS3AN8hQsZDkdXqG1QiD19+/vT9thkpqil0B82Dah+MZuZrUE3/6ONCVjZsUc8KJ+3EpUjrzBTD3bxckaoQWwTYpybeLq8uiG6BD35zNIi7Crb7r3EvhrYgrU4JhPfceoC3xa6TwSCx+A0pB+aV5IuHyyJ/FTjYrrcLrlgTXe/5s2MTGTSbSLdtSA7fBceFCRk+uXE8yfLA0Vs+U93LEpmJe8tx9G4iGXQsupOEeOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(6512007)(6506007)(186003)(53546011)(83380400001)(31696002)(86362001)(82960400001)(38100700002)(2616005)(4326008)(66946007)(66476007)(8676002)(66556008)(316002)(54906003)(8936002)(5660300002)(31686004)(2906002)(41300700001)(6916009)(6486002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdVbFlzNnR1ZW1hZ0ZqQWsyS0p1Tm1pWElmZDZLckxURXdwaDgyN0g2UHd5?=
 =?utf-8?B?NjVoRWdONWhVWnY3N3ZmNEVNbWJWUmdKNW5HQWxOMDJmM3Vmc3UvTW5hUFVi?=
 =?utf-8?B?allkcWhkQ0Z0Y0lxSytHNkZucC92d1ZpUkJESkRHQmJoT2YyVlVmODlET1N3?=
 =?utf-8?B?dTdnbzlSWUxVbTAvOHFYMHlvcU4xNGgxR3F6RnJyM081K1RybkYzTy9xelZv?=
 =?utf-8?B?Y3RXM0tYUlUyNmNXOUxWVy9SbTNOaW5rZ3JFRzJWVVU2cW9JVmMvVno5czc5?=
 =?utf-8?B?ZTZuaHU4b2F6cGJwMFFpaEl5UHBzK0JRVllXV2wxbSt2RW5xT2hrOGVYUVlK?=
 =?utf-8?B?WlR2cExIQjlQa3MxQkRPSUNtVkQ3L1ZteDQ5OWNaa3hXZmRQbkZTVHE1WXA0?=
 =?utf-8?B?NDRFWHNweW96N2ZqWHJMaUZRVHV5OWZzZkxDNzZ6ZGNSKzJkemNCTUJwbW1X?=
 =?utf-8?B?dU5ob1BmWUdXL0xFMWlYQjJGeUN6YlVwdFp4Zm5vL0dlVVQxTXRUa1AwQk4y?=
 =?utf-8?B?UmhvdVMwN1FpY0F1ZWdic0dteHNpNVZwbWVjQzVGZkRTb1hHY2NUSkRXZ1Ra?=
 =?utf-8?B?anAzRXJpcEhGM3VsWncvREVtdXhxOEFwN01WcmpmWHdVZ3VGR2FhcGcwNXIv?=
 =?utf-8?B?ZjRjZkt5N0VvRzZzT2JIRWFXOWVMWVlkTjFwSU14S1FJVUhaK2E5NG1Qamp6?=
 =?utf-8?B?NWdTalhtVVdod3plMVlrMm9icyt1SEpraVhuck9oQ29JNEYrZFpvU1ZCMEw5?=
 =?utf-8?B?OCt1TXEvMFJpdmd2SGx0K3Z0OHEzSXlpSy9uL0h6eGhaWHdzOUtiL3pKRCtx?=
 =?utf-8?B?ejVidHBMOFRQUHlSaGZyelBuNDFrOTZQWFg2K2dvYzdtVVV2Rk1tSzJaTG9F?=
 =?utf-8?B?Qzg3bTN4cjdPcTVOdnkyNi9RL0hQSGZKOGJyV3lKV2ZDa3JUZi9NSndKQXJm?=
 =?utf-8?B?UElqS0VVbWhDcUdBdkVndlN0UWlVeHFyS3RZWXNYOWpjR2N4cG50a2g2ei9l?=
 =?utf-8?B?cEpXMHZBS1g4M3lHSFoyd0NVZlpRVTdGbk4zVmpIQUZrZlEwZjBUeERPOUlj?=
 =?utf-8?B?V1MrN2ViNnZwY2ZhSzJHNVoyM2ZvcGxKV0lPL0UvRXd0QkdKM01GbmdvY1dV?=
 =?utf-8?B?S3BvMGNHZGJZVmRSbW5tSnMvSTlPV0NpNllYeDlqSmlSNFNuN0FRNVVwMTRw?=
 =?utf-8?B?N2tFWTRKMHd1ZDQzc0J1NzczeU9RVWcyWnpZNTNEeHFWNjJhbVU5dmxpajZi?=
 =?utf-8?B?SWdFcTBtYjRtd2x3RXYvaFZ5QmkyNjk4QUFPaG0yYXJnV1FPUWY3QTg0UGZo?=
 =?utf-8?B?Rk1VS21JSitKS0loUWxiQndVVmVxS3lxa3lYZ3B3bFlUdWNRMTdqcGN3alpu?=
 =?utf-8?B?RllrMmxUOEgwZldHUkxTM2Yrd0lka3k5Z2R1K1hQcGFQUk5WN2pBS294TjBy?=
 =?utf-8?B?R2ttN1crR2ZGL1BhWGhhd2JuVkFXN2w3bkRCdVU3NlpTS0NuK2FzOVBrWkZw?=
 =?utf-8?B?L0wybkhzaC9NSUZDZG0rOGNJZ3ZrVklCc1MyUFo3Snk4ZDRlOHo1aTJSR1ZF?=
 =?utf-8?B?VllBUFRva2hKcnFSd2I0TnVsUDd4cW5xT0t5T08wZ2d0VkM2WDBQNmcrMVRt?=
 =?utf-8?B?NFZIWDFYMFRoVEM1Tklzd0gyQWROTEZYdEhubitNZjFLMitueVBQOXNLa0xR?=
 =?utf-8?B?MXpNcjJHcFlrMjFXUVlyTTRYUWhBUmhUeHFTblZLbWZQMlF2SDhncVFSZGd1?=
 =?utf-8?B?bXN5THFWZmJEZGVNRG5WaWhFKzlKNWZmREgvemVXbFhLT3N6dlRXSmtXamxZ?=
 =?utf-8?B?RkRRNDlKRXZxQnpIYkdXR0hvL2dCUEJqaWRDcGJOSXZ0N1NlKzRXanBiUE5l?=
 =?utf-8?B?RTJyN0d3QTZ6bjVoWGlWbmUwWU9NZGlaY25GbVR5eGpGVjdweWJBN1FoTG5W?=
 =?utf-8?B?VTRsS3Y2emZhU09sQmEzTGZHSmFsL24vVW5VTVArc0hqL3hldmR2Sk5FY1hp?=
 =?utf-8?B?ek4xSFkxanhUbzdJcENhcmszNmQ3UlZMUzhtUTFEMUdVNzlaLzlySWNManhD?=
 =?utf-8?B?NlJFeXZNYzZwaFdNVThEZ3NXcmNIaGQ1YllTSTN6NVFRSG9LRE9tQ2RZbjRi?=
 =?utf-8?B?UkFOSXluNFZ4dlZORTNDQmxNakZ1Nyt2WHRCWHRUTTVqYkVrQXRQblErYUpo?=
 =?utf-8?B?SDdsZWY0ODlmV3VQVTVJWGU2ZkdyQmRkb2lwL09DVDEvVTh2YkVxekJRQk0r?=
 =?utf-8?Q?J47gBYwCgrFEApkk98LOFVxs71hIT0U0fCPAuq4/bI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69afe9ff-beb2-414e-841c-08db26bdac09
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 08:00:28.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug2blbcfFa855mSLEE80g7R5gwU3SJ+g0MOokuZFBCnfwUV0wIdQuP7AWb0yFUhlUMdizEP0KbL3LO0/0QPFs8fGHc8RIQja+TV2n4jd9fF8XIGXdVKtYGOfkZTGgI9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1804
X-OriginatorOrg: aisec.fraunhofer.de
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 03:25, Paul Moore wrote:
> On Wed, Mar 1, 2023 at 6:34 AM Michael Weiß
> <michael.weiss@aisec.fraunhofer.de> wrote:
>>
>> dm-verity signals integrity violations by returning I/O errors
>> to user space. To identify integrity violations by a controlling
>> instance, the kernel audit subsystem can be used to emit audit
>> events to user space. Analogous to dm-integrity, we also use the
>> dm-audit submodule allowing to emit audit events on verification
>> failures of metadata and data blocks as well as if max corrupted
>> errors are reached.
>>
>> The construction and destruction of verity device mappings are
>> also relevant for auditing a system. Thus, those events are also
>> logged as audit events.
>>
>> We tested this by starting a container with the container manager
>> (cmld) of GyroidOS which uses a dm-verity protected rootfs image
>> root.img mapped to /dev/mapper/<uuid>-root. We than manipulated
>> one block in the underlying image file and reading it from the
>> protected mapper device again and again until we reach the max
>> corrupted errors like this:
>>
>>   dd if=/dev/urandom of=root.img bs=512 count=1 seek=1000
>>   for i in range {1..101}; do \
>>     dd if=/dev/mapper/<uuid>-root of=/dev/null bs=4096 \
>>        count=1 skip=1000 \
>>   done
>>
>> The resulting audit log looks as follows:
>>
>>   type=DM_CTRL msg=audit(1677618791.876:962):
>>     module=verity op=ctr ppid=4876 pid=29102 auid=0 uid=0 gid=0
>>     euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=44
>>     comm="cmld" exe="/usr/sbin/cml/cmld" subj=unconfined
>>     dev=254:3 error_msg='success' res=1
>>
>>   type=DM_EVENT msg=audit(1677619463.786:1074): module=verity
>>     op=verify-data dev=7:0 sector=1000 res=0
>>   ...
>>   type=DM_EVENT msg=audit(1677619596.727:1162): module=verity
>>     op=verify-data dev=7:0 sector=1000 res=0
>>
>>   type=DM_EVENT msg=audit(1677619596.731:1163): module=verity
>>     op=max-corrupted-errors dev=254:3 sector=? res=0
>>
>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>> ---
>>  drivers/md/dm-verity-target.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> This looks reasonable to me from an audit perspective.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Hi Mike, since Paul already gave his ack from audit perspective,
do you pick this up? Or is there anything which I can improve from device
mapper side?

Thanx,
Michael

> 
>> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
>> index ade83ef3b439..8beeb4ea66d1 100644
>> --- a/drivers/md/dm-verity-target.c
>> +++ b/drivers/md/dm-verity-target.c
>> @@ -16,6 +16,7 @@
>>  #include "dm-verity.h"
>>  #include "dm-verity-fec.h"
>>  #include "dm-verity-verify-sig.h"
>> +#include "dm-audit.h"
>>  #include <linux/module.h>
>>  #include <linux/reboot.h>
>>  #include <linux/scatterlist.h>
>> @@ -248,8 +249,10 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
>>         DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
>>                     type_str, block);
>>
>> -       if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
>> +       if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS) {
>>                 DMERR("%s: reached maximum errors", v->data_dev->name);
>> +               dm_audit_log_target(DM_MSG_PREFIX, "max-corrupted-errors", v->ti, 0);
>> +       }
>>
>>         snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
>>                 DM_VERITY_ENV_VAR_NAME, type, block);
>> @@ -340,6 +343,11 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
>>                 else if (verity_handle_err(v,
>>                                            DM_VERITY_BLOCK_TYPE_METADATA,
>>                                            hash_block)) {
>> +                       struct bio *bio =
>> +                               dm_bio_from_per_bio_data(io,
>> +                                                        v->ti->per_io_data_size);
>> +                       dm_audit_log_bio(DM_MSG_PREFIX, "verify-metadata", bio,
>> +                                        block, 0);
>>                         r = -EIO;
>>                         goto release_ret_r;
>>                 }
>> @@ -590,8 +598,11 @@ static int verity_verify_io(struct dm_verity_io *io)
>>                                 return -EIO;
>>                         }
>>                         if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
>> -                                             cur_block))
>> +                                             cur_block)) {
>> +                               dm_audit_log_bio(DM_MSG_PREFIX, "verify-data",
>> +                                                bio, cur_block, 0);
>>                                 return -EIO;
>> +                       }
>>                 }
>>         }
>>
>> @@ -975,6 +986,8 @@ static void verity_dtr(struct dm_target *ti)
>>                 static_branch_dec(&use_tasklet_enabled);
>>
>>         kfree(v);
>> +
>> +       dm_audit_log_dtr(DM_MSG_PREFIX, ti, 1);
>>  }
>>
>>  static int verity_alloc_most_once(struct dm_verity *v)
>> @@ -1429,11 +1442,14 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>
>>         verity_verify_sig_opts_cleanup(&verify_args);
>>
>> +       dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
>> +
>>         return 0;
>>
>>  bad:
>>
>>         verity_verify_sig_opts_cleanup(&verify_args);
>> +       dm_audit_log_ctr(DM_MSG_PREFIX, ti, 0);
>>         verity_dtr(ti);
>>
>>         return r;
>> --
>> 2.30.2
> 
