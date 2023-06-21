Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883A1738FED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjFUTT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFUTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:19:26 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4509D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687375164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gL5JnXuT2ZqtMdc2o/AZh0m3G5nUqpWXd+Ha+AGpDMM=;
  b=YMjM+KUZy8MJBXmvJrd7rhO0AErXCel7rkfIrG0hrXCtHz0vm+Lz285e
   jxkEzQTxp2Zn9JgptZ0CDLZdj+YHYk7QDOrNPihOZOFhW7Ca8n96Wi7Jv
   9u1MP79bUL+ivc+plm6Nkp0wPK/ehAbZRhSaNxnC/awqOG48vo/F8xE1D
   A=;
X-IronPort-RemoteIP: 104.47.57.174
X-IronPort-MID: 113687304
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:POlBcaMkSy8x4v3vrR2hl8FynXyQoLVcMsEvi/4bfWQNrUpz0TUPn
 GJJXm2PPq7YNmX3KtxwaNnl90xQu8Tcz9diHAto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/rrRC9H5qyo42tG5AVmOZingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0rctQj5x9
 eY3EQEyZ0ykv7u34oyAGvY506zPLOGzVG8ekldJ6GiASNoDH9XESaiM4sJE1jAtgMwIBezZe
 8cSdTtoalLHfgFLPVAUTpk5mY9EhFGmK2Ee9A3T+PVxujePpOBy+OGF3N79QtGQA+9Uml2Vj
 mnH4374ElcRM9n3JT+tqyv32L+QxnunMG4UPLO20d5MhEaX/VMeIgMkWAak/6mwgVHrDrqzL
 GRRoELCt5Ma7EG3Q8Pvdxy+rmSNshMVV5xXCeJSwAWQ1q384AuDAGUACDlbZ7QOqMAyVRQu1
 1mUg8nuAz1/9rGYIVqY97GbqhuoNCQVJHNEbigBJSMP+/HqpIA+iEKJQtsLOKK8kNCzGTj22
 D2MhCw/gagDy88Ny6i/u1vAhlqEtsiXZg04/APaWiSi9AwRTI69bqS6+ETc97BLK4PxZluOp
 n8fgOCF8fsDS5qKkUSlW/4RFbuk4/KENjz0glN1GZQlsTO39BaLeoRd4yp3IktzBdoVYj/iY
 ELVugR56YdaOT2haqofS4awDdk6iKvtD9LoUtjKYddUJJt8bgmK+Gdpf0H493Dglg0gnL8yP
 b+fcN2wFjAKBKJ/1j20SuwBl7gxyUgDKXj7QJn6y1Gr1OSYbXvMELMdagLRMqY+8b+OpxjT/
 5BHLcyWxh5DUer4JC7K7YoUKlNMJn8+bXzrl/Fqmie4ClIOMAkc5zX5m9vNp6QNc3xpq9r1
IronPort-HdrOrdr: A9a23:fl9ZhaDJL+nqnAflHelW55DYdb4zR+YMi2TDt3oddfWaSKylfq
 GV7ZAmPHrP4gr5N0tOpTntAse9qBDnhPtICOsqTNSftWDd0QPFEGgL1+DfKlbbak/DH4BmtJ
 uJc8JFeaDN5VoRt7eH3OFveexQv+Vu88qT9JnjJ28Gd3AMV0n5hT0JcTpyFCdNNW97LKt8Lr
 WwzOxdqQGtfHwGB/7LfEXsD4D41qT2fIuNW29/OyIa
X-Talos-CUID: 9a23:pekKj2F5Ss+ntjkRqmI2rg1LJcA/XUTs836MBHfhCERXc+2KHAo=
X-Talos-MUID: 9a23:pklCBAos9Hgqd9e5z9sezz9sE+dO57+qM38Au4s0tpSba3x5MCjI2Q==
X-IronPort-AV: E=Sophos;i="6.00,261,1681185600"; 
   d="scan'208";a="113687304"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2023 15:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL1S6VbhNm8HdJs9swv3lXbhqGBlFN4YHsMA2c09CslXexHYTaMJexRX+degl3F4ofg5EDAdTDEYMGGKYAVk1m+Xyx+QcWyBce5k/6QR1C1O+UVMhrmHAY28o9aVfFHGEeaShWoeSWBVhKmE8Rf7g16nzlmXbPMWGzM5lg11Z5AEGrUdH9rldeSekR6Zj9nF2d7emBQBoftbUlGiYRzHfMNN6D+PaqVslOwV9A7DNCDSeP92/m2iSfeyfOLY3KpNMbvojOXyM1HzKbPD8iYD0HPBf94Y4geDbVYyfnzQ2JCxXGfEWair3C3KsaDf9eTKwAvhGkkSY7khb+uOycnebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gL5JnXuT2ZqtMdc2o/AZh0m3G5nUqpWXd+Ha+AGpDMM=;
 b=KGMbPmZtYqy93+cTWAf3i0awPyez+OmW+KCUrTbwZoFYP48RAknVbe7X0KocvpHcgJFvhj6e2lTmzZTBYQU7LZxBhCrsIu9edk64rdftdt5uZMad7fJ3tHY9G8N6PSydyiMebpAk07fItClyACQc3FCZ6V6L34QZ6Li9Mll1tlWuV5NYG0CrBmvDL7KVeQ7KAD0BdrXtSfYGGPQhloilo8ezUJIbOZVuYw08UUKnrlYjFgBDh0nbqWewXXlEgDbgDTCbt+Cc31zRoeGbtuXW8BdJor7rMbn8c7ozrnYnHqfc7Pt7+BrwrJay4eyrp4wB8+UEz5IEcHbB1UVEuEoC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL5JnXuT2ZqtMdc2o/AZh0m3G5nUqpWXd+Ha+AGpDMM=;
 b=k5waBjqnemZj+IwB4zvGnfRvZ+pdxUmWuEq+hSTmgjHm0kwoaeBpmfb6TOrUpwvOJD9Wuk2gruVVOyK6zr49L4V84LNJTwbP/yq/N0RT4uvzf5BwzZQQ/CcSM232DUOB0tABzBhMiDrFGoArW9h+VoIAZDAOBX9HtwiJ8Tolbkc=
Received: from SA2PR03MB5881.namprd03.prod.outlook.com (2603:10b6:806:11d::18)
 by SJ0PR03MB7049.namprd03.prod.outlook.com (2603:10b6:a03:4ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 19:19:21 +0000
Received: from SA2PR03MB5881.namprd03.prod.outlook.com
 ([fe80::6646:2936:9a61:97b4]) by SA2PR03MB5881.namprd03.prod.outlook.com
 ([fe80::6646:2936:9a61:97b4%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 19:19:21 +0000
From:   Per Bilse <Per.Bilse@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Thread-Topic: [PATCH] Updates to Xen hypercall preemption
Thread-Index: AQHZpFMl91hHG7ZDuUq21h7QjP0mVK+VdZEAgAAsiIA=
Date:   Wed, 21 Jun 2023 19:19:21 +0000
Message-ID: <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
In-Reply-To: <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR03MB5881:EE_|SJ0PR03MB7049:EE_
x-ms-office365-filtering-correlation-id: a7795d1e-4117-4351-a644-08db728c6aa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3Fsqp6uHG/5Rn4FTHaCKAFieZk5RVbQMfV2CuyPVmRDU8n0SpJ8uo0HthHCK4ALk5CzX6lOy2xCgIAVJq23sFwFoTM76+bZNOF7XUooeIEuJ4d91cOYChO2sHvGNiQ8HBa3qZky8u9Nr4L4KhcQp7Ugb64V9TF706t8ScxtlzLMtVc3ipCkrV+Lkaz7OmnQaG1+JKycLPO/7po8bJz5g0QvBeXzBjf5lF7nR54ouMVYszwIwlA6bzGOVZs4m/mOyvX19J71zjhuQsmren83uNko71R4+S4EzUoQo4cMpgrv6qCZkF4bZBlRbwd5VgIEzX7tjiUI+kt358ULQ4n0JGXjfcnuV3qjrsgurs/WKCLXv7Y8EQP8ND1YbVnSY7IKHEnLqbrMC/DdNrj+EDtPFezz/yHRT8FWRtG0kppYBtQvI2n9q5p6Zyz+fiBzYprp0nTIX+ZaoUxvzbhocYGFbQzAsA13yUmm5VZ1dxG/ZxLLp2hIOs80Hk/bdOPjf6F7bvRA4ByovWZUBWqKXLTI3bDJk++uOdbWRwaS6/aJ4athWrEVYxQ3BdUp3joUcI0n8HZ4PJRg3FlCDc+lNZx43qVdFOKgs95FMzdbAoJhBt8VWtv9rDJpi/yRO/WwzEVv+6wuat9Yz6aYA6RqusgJZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR03MB5881.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(4326008)(91956017)(478600001)(76116006)(71200400001)(55236004)(26005)(6506007)(53546011)(6512007)(54906003)(6486002)(186003)(36756003)(15650500001)(2906002)(41300700001)(8676002)(7416002)(8936002)(6916009)(66476007)(66446008)(66556008)(64756008)(66946007)(5660300002)(31696002)(83380400001)(38100700002)(86362001)(122000001)(316002)(82960400001)(31686004)(38070700005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkV4TWd0QzBZcVZqVlpvNFQzV1JXZndvcTNFbEFwTm5ubi9mS1pINHBGQkFh?=
 =?utf-8?B?dHRXZU5DRE1MS0IzdlJlVUdXQk1LOGVrQ0JIV1Q5c0tueGgvSFRzZUxNUEg0?=
 =?utf-8?B?aXBMVENsUnlpbHRxdUVoNFpkR2pMT3luM05KWUFhM2ZOZUhOc1M2NCt6eUlk?=
 =?utf-8?B?VnNuVnVKS0hFVVFMVHpXUXgrWXI2ZEZXNkpDamE4TzlqWDlMUWlDNlpmaTFv?=
 =?utf-8?B?TjRGZjZvV3dzUnUyeUJBVXNXWjVtYkNUNFBYeWZzbVUzNjRwNXRFeW1HMGhx?=
 =?utf-8?B?MVZyYXpaSlhQMFU3NGM1VWQzSEdoV1ZYcFhqZk5PVnJIc3dmcjRzbVRDNWRB?=
 =?utf-8?B?eEVJSnB0Z2M1cys1TW0zVWJKSkRBQmtCeGdqWHA2dkdXR1Q0bmc5b1dpQXlS?=
 =?utf-8?B?ODFNZkl5ZkQ5YzNJSFVwSUtBT1ZNM0VsbVRYQis5SU1KUFplSXdSVHhxVEha?=
 =?utf-8?B?Y3JhZmNJUndYN2lCeDJkN2xxNy9NY1BIMEFvTWlUNGxpdlBia0FMdWRSYkUx?=
 =?utf-8?B?ZmdVSVF4SmFuN0FVVjNBQzhjaDRleXVVU0lFY2tJYm9JZUhFV2x1UTFqbmVO?=
 =?utf-8?B?YWZXYUhUZHNzTjBlb211SHc5dFNJdkgvTG5icUcrdmFZcFcrRHVOMElvSjRu?=
 =?utf-8?B?dzlYQ25UZlBIUkVtamlZWXExWDRMS1dGa1JIUnloL0Iya1BGcHNXV2x6ajVi?=
 =?utf-8?B?T3drK1gzVGhhMzlRNVQ5cGs0a2lsMEJWSkpFeUJLbjA2K2VwOTdYZVJxS05m?=
 =?utf-8?B?KzlINk9DMDlKRVZ5ZmlUcU9ONGZsS1NBOEVzajZDOXFkNVhZRWU1Q0JMQTFp?=
 =?utf-8?B?Nm5iMDh2MU43aFd3RTF1ZHJPbmxtTEZGd1BwTnVHc3BGTFpaMllMZU5UaXJl?=
 =?utf-8?B?b1ZCRm1RQkhKS0Z4eWFyekpqY0x3ekJhTXBQSDl2ZDkzcGRBNENTTnhEc25O?=
 =?utf-8?B?c3JldW80bFFrTExuYld1d3pHOTF1TWlicTJtOW8yVzdLTk9kSERXVWh4TXpK?=
 =?utf-8?B?Q3lEMXFIbXJVQWYyOUNGL3M5RnVJNW8zc0J5VkI0NGZpS2cyazdtOStqcGF4?=
 =?utf-8?B?MHFBbTFOL1hQcmFmeUpLYWJxWElpeXJjYVY5d2kwZHhyNVlCOW5NcmhDRUhF?=
 =?utf-8?B?Y3lhc2FaQXNVNlAybjNHTmtCYmo5bXVTaU9mS0hKSzlrNlliTW1VSVRydXl0?=
 =?utf-8?B?ekdDMk80VDA4YmZyUWFmcndLaTN3ZysyMVZ1NkFuQlFOTElJekhrcjROUWND?=
 =?utf-8?B?RHgxd0xaRVo1bWVibFdsVXNWeDlENGd2T29DUWt1enlVTlhsMnYxSk1tZ0pF?=
 =?utf-8?B?NVUwU1I5dEwvYi80cnpscEw1a1B0Rk9IMnhzVjlPbFhOVm1hRXQ5U3F3QlQ5?=
 =?utf-8?B?c2VFWGViWmZWR1dBNnlBbkxQWUkyS0x1R3BqY2RXUW16eGRPc3lhdDJITGRE?=
 =?utf-8?B?eHViSXV3YUNXc1hVSng3YTZMUzhmSTV4SDJGL3lRUDhvTTNSdjB4SzNoTmtC?=
 =?utf-8?B?NVJDclBGQlFWZjNXTHdrY01uRFNJWkpTQldPdkJwdWt5Q04xMjlQVm1ncDdw?=
 =?utf-8?B?N0FOQnl0MklVNzlpK0xHbmlNazF4NXcxQytUM1p4bHBkQWJNNjhkdW9Qa0Ev?=
 =?utf-8?B?d2lLd0VXb3RhQ0JGMURwZ2pMMUtkeS83ZHFrd1phNzdDZm9xWm12ZE1BTXVB?=
 =?utf-8?B?TkFCTldkZHJIandrbDFIWm1BdHJkdDluMFNvcHZ6WnVSb0VwbFZocytDc1pM?=
 =?utf-8?B?cGI4WGt2Q1cwOFErbXJ6MmVPd3JYOXBLQ2xsMlhNMEZacEEwTGdSRVVVUzI2?=
 =?utf-8?B?MVB2VGkvczY5enZzWXJUZm5TR002L2ZqU3htWDFDbkFiVFl6ZnV0ZjhZNitn?=
 =?utf-8?B?OUg2NjlGcUhGczRZSzBRcERwK2t3Tk43Z0FWOVdUa015T1JidGlGa21XWEVN?=
 =?utf-8?B?Uk55dHJRdE5STlFScmxuU2RuNUtNNlR1NHJkbzZHQUxmdWpiR2ZmYWFPYVc1?=
 =?utf-8?B?UFpQQ0RJS1RrMzVOK2xJdkZ3Mk9XVTc3UUFkczhGQ2lWY3AzM0RLUytHMU9C?=
 =?utf-8?B?RDQyLzA1WHBhS0Z6dEhUTU0xc00wNXVmV21jc2phN0JpNGJ2WCttbkIvN1JG?=
 =?utf-8?Q?3Coo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <279132CBC8BDC94493A75CDF45FAB55A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VXNab1BnYm5FK3IyVWpGWWxadEg2bmJYdkFzekhzYzRiVVAvYk9KUCtwS2Jn?=
 =?utf-8?B?UVlVbW5rQmk5MXBUZDVkbUtHejUwd0trRFZHTTcyQlA3Z0YyK0lMa3ducjFm?=
 =?utf-8?B?ckJsSHRUTjlqOUN1cWpwemlpOUJWdzNadzlzRm5Qd1FNTGRIcWZmNHloRGVj?=
 =?utf-8?B?YVFxdkNyQ1FGMXJzUGFmZklFWTRrU3BydWltRi85c1lPaTV3OHl6UkZMWVlO?=
 =?utf-8?B?UmtDUHdiQkFZSVBqQjZGTGhEQW5EV0Q2MEljYWMyWjV2aUlpcnJDbzBEQ01M?=
 =?utf-8?B?Mmg0VTlwb2ZRQnUxNmswSHB4TVFQeElJU3UrVHA1Mzk3WnNlZjV4VlZRQ2lS?=
 =?utf-8?B?T1BheHlQS1llMUxxU0dRaFU1RHU0bWNkSWNGSGZqVGtFdjZiek03WjhWMnNM?=
 =?utf-8?B?aXR4TG9hRzA1ZWtLUjFNYkY3THVNdEhKOU9scFF0R0VTL1htWW5FNFNHQkpR?=
 =?utf-8?B?dk9tVjF5VzUwTk5SSllCcDBHUDBZV3E4ZVprMlFidXMvRDVZMXBoN3pCRWhQ?=
 =?utf-8?B?bmNNVW44TGl5OWJKLzMrMUF2akJWWDRHeUx2UGl4c1NQREtLS2lLNEFXSVZX?=
 =?utf-8?B?cjFibzhCR3hnMU9FaEVGbFBHQ0t3U2FkWU5qeHpCTy9EUlc4RkVHQlY2L0c2?=
 =?utf-8?B?QW85M1pRTkg3Q3BsZnFMeTFUWW1xait0ZEVZN3d4ZGlpaE0zQzdzN0dYdlRH?=
 =?utf-8?B?R0c2TytDMEUzYnZDTDgvNHhHMGFMV1R0QjN0bjRPWkNOSVVTTGw0aGdXcURM?=
 =?utf-8?B?Q25IVWVBNVRwVldPd282S3RCbXlTWFppTUtuWVlZMVNFTG9GZVFFNlFwdDFW?=
 =?utf-8?B?eGZnTzdPTHgzUnphTHFSUzZYVWRLT25RY28vdFJEQ3pJTmYyWWVoa2NZc0FU?=
 =?utf-8?B?UHdBa1RSWnVaSldlVkJld3VQNlRDK3QrZGZDV2dFVU9Od0Y2YmNjTWRQUGRm?=
 =?utf-8?B?eUtFS3lHQzFsSVJtSWRNd0c0bjZZb1R1blFKS21vUzdvcXJJdERXbGhNVkhE?=
 =?utf-8?B?aTdoSU10SlFaRTdyL1U5T2ZyRi9UWTJCR25WNlNTZUZCVENQY1lXWWFDcHJz?=
 =?utf-8?B?UE5CQXBPZzBiL2hkdFZmZHlGOENRQllKc25kUzIxYWU1QWFoZHhWc05vUWxr?=
 =?utf-8?B?Tm1xdXlVN01OVkltOUNUZlB6dWlLT1B5M21QeTgzdG1kVlBuNWxBL05KRTQ4?=
 =?utf-8?B?T3krcGlFOGJYZG1MVSs0dDZBZUJsdkxxVm5QRnVGL1NlZVBDeWNURUhMSnNx?=
 =?utf-8?B?TjB6VGVVV0k1RzJnTXR4WVVrK3IrSTlpQkI0cy9FMnhKSnZoYzhZblgraXRp?=
 =?utf-8?B?SG5MZDBTN1F6bm9wNC9oTjBBeDV5YXNqb01zeFlpWTVzNUlPclF1L2dqUmdt?=
 =?utf-8?B?a09nN0ZRNkdJT0xFQ25tM1VwQmpCNGI2ZjlIcUluMUZGcXZLb1d1V3BXSHJv?=
 =?utf-8?B?UXl1bVg4SDQ4RWtNeElhVkdhN0RZMVQ1NXBEUUVRPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR03MB5881.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7795d1e-4117-4351-a644-08db728c6aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 19:19:21.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVejywJLWS82reu+j4nIFZlh/yPn+fT4xjCeenWwmTseVtl2lV5ipptlHwFiBIRjwC413bWwkf4lgX7uRwfJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7049
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMS8yMDIzIDU6NDAgUE0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBJIGRvbid0IHVu
ZGVyc3RhbmQgaXQgLS0gZnVuZGFtZW50YWxseSwgaG93IGNhbiBsaW51eCBzY2hlZHVsZSB3aGVu
IHRoZQ0KPiBndWVzdCBpc24ndCBldmVuIHJ1bm5pbmc/IEh5cGVyY2FsbCB0cmFuc2ZlcnMgY29u
dHJvbCB0byB0aGUNCj4gaG9zdC9oeXBlcnZpc29yIGFuZCBsZWF2ZXMgdGhlIGd1ZXN0IHN1c3Bl
bmRlZC4NCg0KSGkgUGV0ZXIsIGFzIG5vdGVkIGluIGVhcmxpZXIgbm90ZSB0byBBbmR5LCB0aGlz
IGlzIGVzc2VudGlhbGx5IGV4aXN0aW5nDQpjb2RlIHRoYXQgb3RoZXIgY29tbWl0cyBoYXZlIHJl
bmRlcmVkIGluZWZmZWN0aXZlIG92ZXIgdGltZS4gIEhlbmNlLA0KdGhlIGZpbmVyIGRldGFpbHMg
b2YgaG93IG9yIHdoeSBpdCB3b3JrcyBoYXZlbid0IGNoYW5nZWQgc2luY2UgaXQgd2FzDQpmaXJz
dCBpbnRyb2R1Y2VkLg0KDQo+IFRoaXMgbWFrZXMgbm8gc2Vuc2U7IHRoZSByYWNlIHRoYXQgd2Fy
bmluZyB3YXJucyBhYm91dCBpczoNCj4gDQo+IAlDUFUwCQkJQ1BVMQ0KPiAJcGVyLWNwdSB3cml0
ZQ0KPiAJPHByZWVtcHQtb3V0Pg0KPiAJCQkJPHByZWVtcHQtaW4+DQo+IAkJCQlkby1oeXBlcmNh
bGwNCj4gDQo+IFNvIHlvdSB3cm90ZSB0aGUgdmFsdWUgb24gQ1BVMCwgZ290IG1pZ3JhdGVkIHRv
IENQVTEgYmVjYXVzZSB5b3UgaGFkDQo+IHByZWVtcHRpb25lZCBlbmFibGVkLCBhbmQgdGhlbiBj
b250aW51ZSB3aXRoIHRoZSBwZXJjcHUgdmFsdWUgb2YgQ1BVMQ0KPiBiZWNhdXNlIHRoYXQncyB3
aGVyZSB5b3UncmUgYXQgbm93Lg0KDQpUaGlzIGlzc3VlIHdhcyByYWlzZWQgaW50ZXJuYWxseSwg
YW5kIGl0IHdhcyBub3RlZCB0aGF0IHRoZSBvbmx5IHdheQ0KZm9yIHRoZSBwcmVlbXB0aWJsZSBj
b2RlIHRvIHN3aXRjaCB0YXNrIGlzIHZpYSBhbiBpbnRlcnJ1cHQgdGhhdCBnb2VzDQp0aHJvdWdo
IHhlbl9wdl9ldnRjaG5fZG9fdXBjYWxsKCksIHdoaWNoIGhhbmRsZXMgdGhpcy4gIEknbSBoYXBw
eSB0bw0KY2hlY2sgd2l0aCBteSBzb3VyY2VzLCBidXQgaXQncyBob2xpZGF5IHNlYXNvbiByaWdo
dCBub3cuDQoNCj4+IDQpIFVwZGF0ZSBpcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpIHRvIHJh
d19pcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpLg0KPj4gVGhlIGNvZGUgd2lsbCBjYWxsIGly
cWVudHJ5X2V4aXRfY29uZF9yZXNjaGVkKCkgaWYgdGhlIGZsYWcgKGFzIG5vdGVkDQo+PiBhYm92
ZSkgaXMgc2V0LCBidXQgdGhlIGR5bmFtaWMgcHJlZW1wdGlvbiBmZWF0dXJlIHdpbGwgbGl2ZXBh
dGNoIHRoYXQNCj4+IGZ1bmN0aW9uIHRvIGEgbm8tb3AgdW5sZXNzIGZ1bGwgcHJlZW1wdGlvbiBp
cyBzZWxlY3RlZC4gIFRoZSBjb2RlIGlzDQo+PiB0aGVyZWZvcmUgdXBkYXRlZCB0byBjYWxsIHJh
d19pcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpLg0KPiANCj4gVGhhdCwgYWdhaW4gbWVlZHMg
bW9yZSBleHBsYW5hdGlvbi4gV2h5IGRvIHlvdSB3YW50IHRoaXMgaWYgbm90DQo+IHByZWVtcHRp
YmxlPw0KDQpJJ20gbm90IHF1aXRlIHN1cmUgd2hhdCB5b3UgbWVhbiBoZXJlLiAgRHluYW1pYyBw
cmVlbXB0aW9uDQp3aWxsIGxpdmVwYXRjaCBpcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpIHRv
IGJlIGEgbm8tb3AsIHdoaWxlDQpyYXdfaXJxZW50cnlfZXhpdF9jb25kX3Jlc2NoZWQoKSByZW1h
aW5zIGZ1bmN0aW9uYWwuICBUaGlzIHdhcyANCmludHJvZHVjZWQgaW4gY29tbWl0IDQ2MjRhMTRm
NGRhYSBsYXN0IHllYXIgd2hpY2ggd2FzIHNhaWQgdG8gZml4DQp0aGUgcHJvYmxlbSwgYnV0IGRv
ZXNuJ3QuICBZb3UgbWF5IHJlbWVtYmVyLCBpdCB3YXMgc2lnbmVkIG9mZiBieSANCnlvdXJzZWxm
IGFuZCBNYXJrIFJ1dGxhbmQuDQoNCj4gWW91J3JlIGRvaW5nIDQgdGhpbmdzLCB0aGF0IHNob3Vs
ZCBiZSA0IHBhdGNoZXMuIEFsc28sIHBsZWFzZSBnaXZlIG1vcmUNCj4gY2x1ZXMgZm9yIGhvdyB0
aGlzIGlzIHN1cHBvc2VkIHRvIHdvcmsgYXQgYWxsLg0KDQpJIHJlc3BlY3RmdWxseSBoYXZlIHRv
IGRpc2FncmVlIHdpdGggdGhhdC4gIFRoZSBmaXhlcyBoZXJlIGFyZSB2ZXJ5DQpjbG9zZWx5IHJl
bGF0ZWQsIGFuZCB3ZSdyZSBub3QgaW50cm9kdWNpbmcgYW55dGhpbmcgbmV3LCB3ZSdyZSBtZXJl
bHkNCnJlLWVuYWJsaW5nIGNvZGUgd2hpY2ggaGFzIGJlZW4gcmVuZGVyZWQgaW5lZmZlY3RpdmUg
ZHVlIHRvIG92ZXJzaWdodHMNCmluIGNvbW1pdHMgbWFkZSBhZnRlciB0aGUgY29kZSB3YXMgZmly
c3QgaW50cm9kdWNlZC4gIEhvdyB0aGUgY29kZSBpcw0Kc3VwcG9zZWQgdG8gd29yayBoYXNuJ3Qg
Y2hhbmdlZCwgYW5kIGlzIGJleW9uZCB0aGUgc2NvcGUgb2YgdGhlc2UgZml4ZXM7DQpJJ20gc3Vy
ZSBpdCBtdXN0IGhhdmUgYmVlbiBkaXNjdXNzZWQgYXQgZ3JlYXQgbGVuZ3RoIGF0IHRoZSB0aW1l
IChjb21taXQgDQpmZGZkODExZGRkZTMpLg0KDQpCZXN0LA0KDQogICAtLSBQZXINCg0K
