Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5269D716
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjBTXbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:31:00 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B12C1B33A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1676935859;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=otdDu49vFfEBxSgbYBS70q5Q0g8c5dkXl/U+IxoxGyE=;
  b=gRedfce0HaSUEIc81Jz6UTFUKbQxX410qx72HtvDBbjMGoqjNGhLpaSG
   gx2+V26aFKkglkdDVSabOvWmO9rn0xtT7SJHOPanmI5+j4HgaekLcCmZM
   FVM8lze4DuSPZx2fM7QJfkzJ1+Rgq8VoWhC8N+WoICVD7h2idIhFncQMX
   E=;
X-IronPort-RemoteIP: 104.47.73.40
X-IronPort-MID: 98213837
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:+hh42a6ISrDBWsALu0z80AxRtIPHchMFZxGqfqrLsTDasY5as4F+v
 mNNUGnXP66LMzH9fNAgbou+8hwHuZGBnNJiQAdq/HwzHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+45wehBtC5gZlPaoR5AeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m7
 d8BIRIhaAC/re+16oiVdutQgf8mM5y+VG8fkikIITDxK98DGcyGb4CUoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6Ml0otiNABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTCdJITeboraECbFu73DIoBkdLdkmA+MacrH+MfekPK
 1069X97xUQ13AnxJjXnZDWyuFaNuh8RXYoWH+BSwBuKxrDV7AGxBWUeSDNFaNUtt84wSnoh0
 Vrht9HuHjFrt7mUV3+c7L7N9Bu9PCEUKSkJYipsZQcM5djupMcoiB/DQtFlOKq0iMDlXzD23
 z2O6iM5gt07hMoGx6y98UrKxTmsr4LVVAMd4R/eVWaoqAh+YeaNZI2tr0Db7PJELZ6CZlCEs
 D4PnM32xPgHEpiL0i+QRewXWr60/+qMGDndh0N/WZgn6zmpvXWkeOh4+DxiKV17GscCdyXgb
 ELatUVW/pA7FHuyZIdlcp62EYIhyq2IPd3oTfn8Yd1JbZx8MgSA+UlGdR7O92Pgik4hlec4I
 5jzWcOtC3kdIb5qwDq/W6EW1rpD7jwxwXP7QZH90gi91ryfdDiZRN8tPUWIRu8+66yArUPe9
 NM3H9OI1z1QV+rxZiSR+okWRXgOLH4mFdX1ptZRe+qrPAVrAiciBuXXzLdnfJZq94xXjuDJ+
 3u6V2dbxUD5iHmBLh+FAlhvYa3iG5Z2q2k2OwQtO0ql3z4oZoPHxKQHbJoxcrkP9+F5y/NwC
 f4fdK2oDv1RR3LH8jIGYJ/VqI1kaQTthASSMi7jaz86F7ZiQgXV5sTjeCPg8y4BCifxvsw7y
 4BMzSveSJsHAghnUsDfbarzy0vr5SRF3uVvQ0HPP99fPl3295RnIDDwiflxJNwQLRLExX2R0
 AP+7QokmNQharQdqLHh7Z1oZa/weweiNiK2x1Xm0Is=
IronPort-HdrOrdr: A9a23:Xlxvya1ILasf/FolnbP0UQqjBI0kLtp133Aq2lEZdPWaSL3gqy
 nOpoVi6faQslwssR4b6LW90cW7MBHhHNtOkOos1NSZPTUO2lHYSL2KhLGKq1bd8m/FltK1vp
 0QFJSWZueAa2SSTvyX3OB7KbsdKRW8n5xATN2x80tQ
X-IronPort-AV: E=Sophos;i="5.97,313,1669093200"; 
   d="scan'208";a="98213837"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2023 18:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXwHB/wJ5SmIicuCSuWejTtpC19dPDb1Kmt0SG+yjA6uK9/5MIJfdtNjNoVQekWD4wzuzJaHZFZAnp0NjARd8+vyl8TMNbABVrjETqVcElIX2+1yFwJhfFp9Xps0nAlIo8G96zUFhQ4AZbyBOpRKBgBpvAYEJdV/Vao/R418q5CUlmJObwd7sZPImuOehrIxQf97OyJnQZlnsXkekHX39ApWGm7lMnHOVqI6u2T6UYske6VmrN8SHwy2MVkbrgYNCbUeYbFCjr6wo7sPIWS8woSwh4nfSX6fcAQKNK9NjUUagEm6b/FKXFlVxjrlQVPWJd2z2votsqqHFBCBasZEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otdDu49vFfEBxSgbYBS70q5Q0g8c5dkXl/U+IxoxGyE=;
 b=DTkydtMcgnXYw4oHZtaN9/8ZYojHpfEXcvooZ4NT9g76DITV/rNmGx+ZumRJ3wPKy+Qn56khIOEhifDmXZ8YNq0YO9YSlWTDRkzVVz56gp0JwFQdUCv5qN5hT2GBzCC44zujh7Zct5oVmipF4O5x328vfzrLd6HbtBWJAEuJtxpkn0Dh7huvwlo8C+8rYyJw9YHeBYKn9OexvOzuNCkWDilSPt+O5jJUHlF5LfFi5+NxQaU6cvgsNzMARaadctjag8CF3h6gwRkMUgewyzBQUTwFhmRcPLkE5oVYAS+IBTsZUNkqqKIbNmYtsz9KvAXVlBiu19jPnDEts5R8BCTiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otdDu49vFfEBxSgbYBS70q5Q0g8c5dkXl/U+IxoxGyE=;
 b=X9RBZ4PnmOOyO/E59OB7XbBUz14WARAStfmZNsMZB3IkmWlMsq5MJdyVRtWRtKxUuc5Z1RH+9Yw8pmzV8LYDmjztsz1TxauXme4xqIlSbplGhOL8UPlEk5JydYMGqB8DFp4Dc7gJ9+3NBz6GuP76lYTZBl5DXvWqQj3ZLpd+mkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA1PR03MB6322.namprd03.prod.outlook.com (2603:10b6:806:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 23:30:54 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 23:30:54 +0000
Message-ID: <50231372-2d6d-e4af-be88-5fe45e0c210d@citrix.com>
Date:   Mon, 20 Feb 2023 23:30:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     KP Singh <kpsingh@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=c3=a9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic> <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
 <Y/PhxDIVsa4WU5gu@zn.tnic>
In-Reply-To: <Y/PhxDIVsa4WU5gu@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SA1PR03MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: fad31d34-bfe1-4450-8b8a-08db139a82c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndUiS5kzbtXN5NqSrZ7m0wx7gpjYkG8oHMfbYCtWPj5E5KxJJk/IvInzmqZhDEG87oMeBPbnu1gqq08c8U8mb5c/ppkNFfqE+t4PJtetKmqDN3fScZ+KfSLldoyAkbjYm6S0hBBwBtRtYPxPaPtRdWIQnTaD6lzeiX7JGvxuGsZMA2+oEee2/MHpQiHuiFnK3hTOgYgLIxUhxjd95uFDs6EqP5LvN7nBfz0OKC5OzMpnnKjER7uFXw7KdEQa7vA1E7yD/227/KtYZVXS6UtV2y8l8o3oauzunl+rBWxQF9G7uq9axTGlEbZGparv1oCD0qOltlxeItF19OpjAwG5IQo0FD/MOFFJDcC3JfqRCXUx+lnyDaxKmWSZMdU9Hqk7HiWs1lx0fU6r5ekHV9eRaiKTNm46PLjO7SrQrTv3nWQgPApdUl6BK5sIKqzwGooGrBitHARygE/JtzOi1XNmmw3iIjzfYdAyN5zo5WmEAsv3KaXHpiMx5PLqZg966g+y9KEw80WeMKfgQN6C/skxz3Vx1FSGAZWpOMgLDJ8Nb4Bq1AwHANQWNC78964NVua2ZnY4gkcfQ4MXHvzOLZyVuZ4pS0xTmnT4S23LYRjeNkBE6NLG8+HZteOIHox2is/+jpnFyqlflQ1uyo+nqPNAzpIVCBzWm/8a5gFc+4Da6UOh9eHaULTtRc+THlyl7dXZJUmcIHHyW5MNzm1zLmFzfBgAZaMSotRSXUFiTC9mcok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(82960400001)(31696002)(38100700002)(31686004)(86362001)(2616005)(36756003)(316002)(8936002)(54906003)(5660300002)(4326008)(6916009)(8676002)(6486002)(66946007)(478600001)(7416002)(41300700001)(66556008)(66476007)(2906002)(6512007)(6506007)(53546011)(186003)(6666004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlZCY29jSWhOOENkVno3Uk9HeGJEejVIZStOd2FxbnhHYVlBaUdXZ2d6Ky9k?=
 =?utf-8?B?ZDFYNnJURDBkK2FwYTc5SmprekJWcmFFMm5MVGE2SEY0YlNyd0pla1dVK3JV?=
 =?utf-8?B?NExJQVljU0hieWpCMWNQZVQrSTBjY1ZEekNyRmgrMU9UZ3RhYnNad3ZjcFhy?=
 =?utf-8?B?NFdRc3ZiRjFPZXI1Zzl4VFZyZkt6QkNoanliaks5WmMwa3hwNnAzTlJpRFdU?=
 =?utf-8?B?cXBveEwvWlpod1ZkTnBsU3RMOEtwVkpPMHBtZWNBeUdKbUJYcGhYbFIrWjdX?=
 =?utf-8?B?b0JmeTdhRldBYUgyeFRZZWVCMnhyQkFtb0tBYmhOWXZPUTVMaVVySVNTYjBt?=
 =?utf-8?B?WllFMUQ5K0VHTndQOGNWVm1BaFNsRkc2T3FWNHJLaGtnNTBLR0djbm9nZWtw?=
 =?utf-8?B?OVhKRmZEUS8yTTFLZmVnWE1ndDYzZm1FYS8xUkFRUUhhcnk2Vm12Z3pDQkd4?=
 =?utf-8?B?L1pxd1ZOQzhpaWdxZVptbFVrSVZsWDYxTnNPMzFZcVA3K3g2R0pqUHRsYVdT?=
 =?utf-8?B?TmtSQXlvaXJxMHV6WmVzcHo2UXltQ1BuR0lHc0d3bWxTeXFBODQ4aE5mSk05?=
 =?utf-8?B?c0kwUEh6RVZQS1VENjRVZ1Jrb0liamNNMXc2c2hYeG5HMlhlNG5IbkxQREJO?=
 =?utf-8?B?bzQ5eGI4dWJPYXdqK3JtNWF6WDNFNEdwcExBQUl4V0YwSS8xSnpQZkRLdXZY?=
 =?utf-8?B?NVZOQXBya0x1V3krYi9ubmZ3TDM1NFNVcXhBQUQ1eWpjSDNKcDVnenJmT2dn?=
 =?utf-8?B?UTlmaE5qSnBYSFliVnhmcHd4N1UxeTE0VnlrSVV6d0JrNG1YZmVoTmFiUzU5?=
 =?utf-8?B?eVloSnF1aUlWQWVjQVhqYjhnS2FTS0d3V3h4ZHNqRFhtTm8wUG04em5hMDJC?=
 =?utf-8?B?amZ1WFdYTkV2NFdWZDZZeEtoeVVXUmU5WlU3NkhERUJ2SXMrL0w0eEd1MEp2?=
 =?utf-8?B?ejJDdG5mRWZ1T01RUE1PNUQyTWpHeUhQeW5DRWI0aC9FdHZweHNJNFpydUcv?=
 =?utf-8?B?UWRwN09rV2VNU2xCRmc4Nk5nZE5pcExKUS9sZkFncXQ5WVBtb2xwbjd2RFZB?=
 =?utf-8?B?M25mT1I0VlVweDMxcEZaSkdjRFBNcDVBV2daMytTVVAwbDl3ZkRoMTI3WUxs?=
 =?utf-8?B?UjVOcCs5WTR5Q1hOckJNVVQ2c3pqcm90SW42QkgreTY2UEVlTUFFSS93TkxH?=
 =?utf-8?B?djI0ZFJUNnBSbmlQalN6NGU1QmJQdXdHTS9BR3Y4QTZqRG0rZFhXNDZUS3lr?=
 =?utf-8?B?ZXFvRVNlUWZaYVdQTEF4anN5UDUyWCtPcWtGWFg0N0RZWEJzbGFsKzd2c0NF?=
 =?utf-8?B?NlhjV2pFeDVCSFhBUHU3dGpSK0ZZL2RoeUp4ZDM4SGpJa1pZanFrTkJTd0pQ?=
 =?utf-8?B?U0ZtMUlSVmZ6eVVaVHU5NUN3emZjSGg5U2xwTkFETGY1WjZRMGw4N3NGOVNo?=
 =?utf-8?B?bU9rZ3ZlaTdWOVNWRDNzR3FxUDdEd2ZBOXFhRTJRTFhXVlhZeE9sUmx0cTF3?=
 =?utf-8?B?d0VVeCt2RnpHL3FQUDgwRHhKcnVZMEVzL1dsOU4rcGM5WGRScURXMnFzMmZD?=
 =?utf-8?B?Zjd6OS9QaTZiay94S0JpS1FmM3hQa2pTQWw4Rkh5SUZCWXBWOHBHcUVjTCtr?=
 =?utf-8?B?YlVWYWcvQ1FPcG1jdTZjaU12LzREOXVuRm15WEMycTc3Q2NmVFJCYnNiODh6?=
 =?utf-8?B?Q0tPSFM3TzVjaXR5WVp6L2JNNkRYSFhIc3NBM3hRZVc0eGNjL0hGbHZlamQv?=
 =?utf-8?B?UzBKREl5endPZmpzZlpZbk9FbmVRcUdIN3hlanNFNkZQNTdUY0xYYzhVcFJn?=
 =?utf-8?B?MG9xQ3RWL25HbE5LeTJPZVUyeUg3N3ozTCsvUHQ2VWdSeWx4VlhGUmtWTXFJ?=
 =?utf-8?B?N0dIcXQ3MlozRG0wQ1Q2VEhpZ0lLT0VXZXVjRm0vV3RyUis3b3JWNkFjbkJC?=
 =?utf-8?B?bUxjUmp0Uzh2UG83cUVsKzVjVjZROFlJd3QrSnp3SzR0bVRQbkROQ2NiYXRD?=
 =?utf-8?B?Yzl4dkh1VTR6RjlsRW9QQ1gvWUdIYXNFZHBmUi9TY0IrVC93SzNkZFp0Mm9T?=
 =?utf-8?B?SEM0UzVWbkIzR2NxTUV4bi9ENldFa2Z6REkySjYvamhuQVMxbXI5U1RIL21B?=
 =?utf-8?B?Q3RYRTJpWlVEbS9UN1JKQjZZbmF0MmJybkFJU2JQWWw2WFFkNHFUKzNnRkUx?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGJCamcybFJ1bisxK1lPekdHTEZENnZjMVJoc0htY0orQytvMHcrYk9HZ1Fk?=
 =?utf-8?B?MVh4cjJiSytuZ1NtOGlxU0FPZkI1VlVxcjFYRUtDNXh0NTVFblM1M0dLYzhV?=
 =?utf-8?B?U2dCM1c5WWFySnFWM3B2NzJlOUZCYUpCeWZtRUtGK002NlpJTHgxV2FKdGhj?=
 =?utf-8?B?Vkx2bmhpSG9nNVNHZUlUM1RoQVVidWRMMGtsSklSK2o1bUFQQkFHMGo2NDRG?=
 =?utf-8?B?eWdWQTdreWJQOXdmaDh1RmRJcytnNzM1RGluL2EzL0llQ04waHE5andJbzhT?=
 =?utf-8?B?QStYUnZGL3huN1hxaWV4VlhPaWUrWGNKS01BL0xtS0dOdEpWVVRHYnV0V3FR?=
 =?utf-8?B?dnl0V253Sm8yNHVpb0ZWOXpoazFjNVRWNGk5N3UxTWJ4WDhpYVlXUEtrVElQ?=
 =?utf-8?B?TXJETUNzT05IZTdzUWorZVJTbTRJNmdQVzNQMmFaa0pDTU44OU1XaTVSTjdw?=
 =?utf-8?B?a1BFMmdmRFlQRWtkQ2pQOWFpb09wUFRTbVdNTjVpRlZCU2pYRW1YeDZ3Rm1u?=
 =?utf-8?B?MU9CM0VjaGRmMWZwOS81NTI4Z24zNWxIM0UyM2FidWZDNEVNTlp4cTZOejVF?=
 =?utf-8?B?K0E0WGZoUGNDRkVsOGV3NTJUNWJScHVjMEdhbzdrdHhXNG9FOEJLMkFvbmZW?=
 =?utf-8?B?NE1vVkpEc3hxOXA5V3BzZGgvOGZSVWJmN205ZCs0NFJ4MDRZcWU2NVQxeFlS?=
 =?utf-8?B?MVdJQlNvZTV2YlZsV1dtekZJc0dReS91emdmcCtPMVZKdE0yeW1DZjFiR0JC?=
 =?utf-8?B?MnZSWHNOZDVON2hsZHkwbWlnVXpPdHlURjdyb3U3aWpFcUIyQllkMVBzNm5j?=
 =?utf-8?B?dTNDaURVVStQbDE5SS8rdks1UUF4aXFmOTZMVGtzQWdENnhvRDNyMFVmaUxJ?=
 =?utf-8?B?aVB6bnRWUkRuUWxhMEdmc0JJY2pOQm4xMnpDZmlsV2JCYVVyRWRObHJkVVpM?=
 =?utf-8?B?WXM0QjJPa0NnT0RpU2ZNZjZMOE93MWpRMEc4OFhXWTByNysxLzE3YzF3ZGRD?=
 =?utf-8?B?RWx6UUNyWFljSUIwcERMM0VudUhtTUJ0eWhrb0VPQWxnN3NxcS9GZXJlVlIz?=
 =?utf-8?B?MlNxcktRNE83bmgwajU3T1k0S3NPZXpiOFFrMmJaaC9aMnNCa1JPOGdObTd1?=
 =?utf-8?B?cHQydDhnUEhYS0xRU1Z3SzBDWHZNRy9QSkVXOTAxZU1uN2F0bVA4RC9tSHlq?=
 =?utf-8?B?M2ZDQk1GcjRkZ1BVbDBPTGVuZjljNWxOL0pZWnRPM0NQUmxQWHFjMStiTEdK?=
 =?utf-8?B?OExHSHovMFRndDg5VkZGT0hwTU1qNXNnYmI5OXk2Nno2a2dEaDZHQ2U2ZUd5?=
 =?utf-8?B?ay84RFJXK2h5c21oVFdEVzdrZHExRmlhVXFnTjlKT0pGd1dPeUJrWG1CN2Nm?=
 =?utf-8?B?cHp5OVZJd3F0NWVhRldVcmFYUHlZUFhWYjhuT2NGOFd1NzlhMk5TWEdTTmpP?=
 =?utf-8?B?ZDlQMU93dEs5N2lBUlZGL2ZVVXVia25PNGFseXFKU2VoTWU3dHc0Rzk5WTZo?=
 =?utf-8?B?SzU5TU94dU5MOTlXRk85d2N2dC9MRDBXY3BkdHhldUcrdTV4RHZ6TzZYUnRI?=
 =?utf-8?Q?MTt9JvUwDROVzioqR+6d0Q3rI=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad31d34-bfe1-4450-8b8a-08db139a82c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 23:30:54.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t96Jo+R9OL67V6DHWSF2+VjQDFvKtyfSSGQe1In3glUsnJ8PpPAtsEhDu58mlpyS3a3OMrfOKoRpelGmOWIERsqoE+N28/OpfjktAna3Wj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6322
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 9:10 pm, Borislav Petkov wrote:
> On Mon, Feb 20, 2023 at 07:57:25PM +0000, Andrew Cooper wrote:
>> I think we're discussing the legacy IBRS case here.  i.e. what was
>> retrofitted in microcode for existing parts?
> Any IBRS actually. The one which is *not* the automatic, fire'n'forget
> thing.

/sigh so we're still talking about 3 different things then.

1) Intel's legacy IBRS
2) AMD's regular IBRS
3) AMD's AutoIBRS

which all have different relevant behaviours for userspace.  Just so
it's written out coherently in at least one place...

When SEV-SNP is enabled in firmware, whether or not it's being used by
software, AutoIBRS keeps indirect predictions inhibited in all of
ASID0.  That's all host userspace to the non-hypervisor devs reading
this thread.

For any AMD configuration setting STIBP, there must be an IBPB after
having set STIBP.   Setting STIBP alone does not evict previously
created shared predictions.  This one can go subtly wrong for anyone who
assumes that Intel STIBP and AMD STIBP have the same behaviour.

Furthermore, extra care needs taking on vmexit because transitioning
from the guest STIBP setting to the host STIBP setting can leave shared
predictions intact.

~Andrew
