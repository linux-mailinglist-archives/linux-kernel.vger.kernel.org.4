Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CB46406C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiLBMYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiLBMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:24:46 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8DCBA58;
        Fri,  2 Dec 2022 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669983885;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=aqaZc2Cq1egACPIy1AhyP4sEkJ58vIqy5db4ZRhDsX4=;
  b=LLpvKupdLVf7cGbXtrghGJYfLlLwiAEVKXkkFIQ5L2RjI72cQVwhB/hW
   ncxpNYSgH0h79a9EdAKRB5Ok8QKZuXSNtQTuKO0CtZItdludcs9uKmmSt
   YUJWHgIvMDHPfR6MkUZuHKpEf1PKIvkAPmqN+/8pn78nmNBl5A0G/4xJJ
   c=;
X-IronPort-RemoteIP: 104.47.57.175
X-IronPort-MID: 85273801
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:syEmwqIh2Z2uXJoXFE+REJUlxSXFcZb7ZxGr2PjKsXjdYENShjwOm
 jRNUTqAaKuIZTajfYsiPty18E0PvJTQn4UwTQJlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHv+kUrWs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPdwP9TlK6q4mlB5ARkPaojUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5VMExMz
 vMCBQkNTT6ypceG8o/kZOhj05FLwMnDZOvzu1lG5BSAVLMKZM6GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dopTGMkWSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iLx3LCUzXuiMG4UPKCm3NR1gkax+nweCB4fCFuDuf6FmkHrDrqzL
 GRRoELCt5Ma+EW1Q5/9VhujrXisvxgAVt4WGOo/gCmJy6zJ80OaC3ICQzppdtMrrok1SCYs2
 1vPmMnmbRR/vbvQRX+D+7O8qTKpJTNTPWIEfTUDTwYO/5/kuo5bphDAVNF4C4auk8b4Xzr3x
 liipi8khq5VitUXzaKl5lPWqzW2r5PNQ0g+4QC/dn6q6hNRYI+jepCy7l7a/bBMIe6xS1iHs
 38sgcWS7OkSS5qKkUSlSv0lFbWo6vDVdjHR6XZjFocssTSk/WWue6hU4TdjNAFoNNoJfXniZ
 0q7kRMBurdQMWGsYKsxZJi+Y+wq1aHIB8X5UeqSZd1LCrBrfQGO8SVGZkOK2W3p1k82nskXP
 Zqde+6vAGwcBKAhyyC5L88U2r8qzyYx7WPLA5v8ynyPz7eYZ3eJRKwFdkOHauQ49KqIoS3U9
 cpSM42BzBA3eOn/ZDTHtIcYNVEiM3c2H9b1ptZRe+rFJRBpcFzNENfUyLIlPoBgwaJck76R+
 mnnAxAFjl3imXfANAOGLGh5b6/iVop+qnR9OjEwOVGv2D4oZoPHALojSqbbtIIPrIRLpcOYh
 dFYEylcKpyjkgj6xgk=
IronPort-HdrOrdr: A9a23:yWcib6wmT3WrgI8g3jm8KrPwC71zdoMgy1knxilNoH1uA7Slfq
 WV98jzuiWbtN98Yhwdcf7pAsi9qDDnhPtICOoqTNSftWvdyRKVxehZhOOJ/9SHIVydygc378
 hdmsZFZOEYQmIK6foSTTPIdOoI0Z2syojtr+Hb1nJsRQZhZ+Vb6RtjAArzKC1LrU19dPwEKK
 Y=
X-IronPort-AV: E=Sophos;i="5.96,212,1665460800"; 
   d="scan'208";a="85273801"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2022 07:24:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8sf+pVP37/6PlJ3PYocyVdw+Fmx+8MetZFMbDexSPJjKqRP1Ddx7bxMl59tdHs6mXH6kL2gUYzBwo1HYvd+wqVhd3fo9phNk8QLwti486vOW68jOxzeeG4tczCRiPcWgejWR8G2VF+qvWnDONwNt7ke1d7nZsxiXClDgl7UjFjXTlPWN5w+s6bchT+/2QgHio8zehqSEMaVhVFej4I9i78KhdsMSx6EFNnxHQRiosx9SXYeiWg+IhGGW6pBJ5A/WTSz4Qm72kSbMQx9sRjr1h3Y76CdGI2rW15xGCAl96XKX5h56HWhr3KSauo+k1/wBNA6djnAb4oIqJZNz3mdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSJkgbLsYx6sBjOxZtCQkc6d32+ScXt3yjKtA3uX0Gw=;
 b=Fnsz32rIsgJZZDRDnUy2lzg42KGG7sI3rM/YRHAkNTbTvGKHNvdLUeEiIdaRSLAxAc0dgf608BWDj/oGyXb4IBL2Dl8HWETEmOzAybF0er/btNkMbgD1jRwqoD0GUwKp91TyvX2SQa9ToONN//t4nsxCgHMc2CGzdmQx0911VnE5HWadqc/1kzvTf2ypSWKHeDFk9/8mOoRDOUu0CkWv4iM5AgKfT+6tww0/Q4l+kUzE83+BA3dvDqQkQje92aK0iTtFIX2jO+kLJqVCvugNOUmhH+ZFf9Qkyv3w+EIJAcmQBwwMr6gpmGCAnOZzRDWxJgiSdCirgbX0CVzmsc5ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSJkgbLsYx6sBjOxZtCQkc6d32+ScXt3yjKtA3uX0Gw=;
 b=NP4ZzdX8efChl9+5FjrBc1IK1sO2ONJibJigdeA26Zne+HVlfyEdP+cJv/jG3tfhnCsI8HBELZLKyCKhwmVjxyj+1vYUCzS3mVZaBsPfBk8/yQqmGAF+gLcvEOTTcbFxmUlXorou9BPWpd9UqZWK7AtSWpIr1rxT0xTJG41yLNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by DM4PR03MB6127.namprd03.prod.outlook.com (2603:10b6:5:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 12:24:41 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 12:24:41 +0000
Date:   Fri, 2 Dec 2022 13:24:35 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y4nugxKV1J/BqhBt@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
 <Y4d8cm97hn5zuRQ1@Air-de-Roger>
 <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com>
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|DM4PR03MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: a6240a17-563c-407e-119d-08dad4602fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHerTqgJUHfdjhc6meZavVwrZG6p3lJ1gipWcxlaSPoc1qcxOnadh8dmUIYU+2okkTrNLR5vYTfUFrcT7qpnyF4E+AGvlu+yzW94SDSqowqZPYjjZ+3BH1w0X3qHAm3IwmWeC0ClUtfVXHh0Mulp4h7PSsNE51yGSnKQ2qzy+LWD8bDych1TMYXywVI62cXSmdrB1gV9qe3VrpsjVKMkn6nNUWSn2qRn26KVrrRACG05k4o4RJ0Yx6Ezh1dKzuFCyGHDNAJm27SwqGsh641jOf6Q0gy8SbhbBcbIJazFlYHoEzt3Mo4uHn7uOUkDxyzVqKeMCvk9mvITKAZL72mmk5VBEvjbWmuYrdF81YSg6g6/m25W/YcImqYtdW+wmePQYZL+WjWMCZm7jNuZv6FWfWI9G4m//3J9yiWFEi/rK8wIaiHI0skq813xl/6ayUogC0SEYcc+4nsG7MIlAJEb/GvD9zIKlaHpqey7IUqgkXbQWFTJn+Wcb8Tn73kobffUrJITAfXJ8TNhnTdWUKX0XAUwQQFtXG6Z+oRu+iba/gejRc+G9YD/ldiaN4sAgxZFCUZcEff/2eHT/YVfiGxbx9h1303httAuS82T+7EMfknKk9rtVy+H6BdxG/Jv+2NGc5LMviHHuBp8sk4IAloBXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(9686003)(26005)(6506007)(6666004)(53546011)(6916009)(54906003)(38100700002)(6486002)(6512007)(85182001)(478600001)(82960400001)(86362001)(186003)(33716001)(83380400001)(7416002)(5660300002)(66946007)(66556008)(66476007)(4326008)(8676002)(41300700001)(8936002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TENKcldVWmJyWU9Gb2ZrRWk3MzFuT3o5cTFScU95TXdVa2tNZ1ZYbkJMYVJx?=
 =?utf-8?B?U290RFAzZUtTeFZTK01Wc3FJYTFRRnl2TFRLcG4yR0cyOENkZ25yMnRpdnRo?=
 =?utf-8?B?YzNmdzA1SmJGaUJzL2M4R3lMMjFGL0RreWVYMEFmcmFQMEErMExZQUNQT0oz?=
 =?utf-8?B?UkYxZzhEYmdFWkNna2syWW1naHMvLzhGSERZOWQ1ZUs0MCtRc29UQzFnTUgx?=
 =?utf-8?B?MVVUcnlDMlc3VzQ5eTgwa1g4K2RoUWpySm1wcno1aDV1cGxaemxxVEVxZ3JE?=
 =?utf-8?B?OERXckxlRXU1TTRLSjBzOHJmaXY0Z1IxbzdMb3kxaFpOa21iMmZVaXo3Z2w3?=
 =?utf-8?B?bVlEOU1ocko2QVNzRVVWYllDcEFyaUtUblFmWHFNTkw5ckNyRmlPSjJ1K042?=
 =?utf-8?B?Yk5idjZCRDltNTRCbEdMRS9ueXpxRTJ2K29CUTIzSmpydGZjalkxVHA2OEhr?=
 =?utf-8?B?L0x1K1BQL0xBY2RWMnF3NkZ0VE5xcVVWSEJ1UEV4VkhacXJZa29aejBPR04z?=
 =?utf-8?B?U095K3ZObXF6LzRGSXRQbkFCbTFKU2t2N1M0QWZtTzNhSzVYZzNBSnhxWXB2?=
 =?utf-8?B?Q3JFVDUydDJyT21wNjBNRW5IZ0tLWS9SVXZnWVNZWEw0WC9UMTlTL1dFYlE1?=
 =?utf-8?B?bjMxb041a0VLTk5uc0NiZldydWFGa2psU2d6SzR5akplZm1ZK3cwdHBXcWxI?=
 =?utf-8?B?cWhEOUNmUm81ZjdhOUFtcm9hd2tna1Q3VmhxRVp6T1F3Mm40ZUNjQTdtZjZG?=
 =?utf-8?B?SnJkeklLbGJwSkdiVnJoMWZ2WHZVK3o5c1pBTlJndGtmVVJXNFBNQnk3ZVFL?=
 =?utf-8?B?R1ErUGFXbU5KUVNZam41Qzd5MkZFc1ZOOEFnVW5ydDhJL203Q09UaXBEdFpy?=
 =?utf-8?B?QnRYY2Z4VnlxUjE5bWFzY1ZvRDZSMXljZCtkNEhiSHlxNUlQKzk2V2Mzcms1?=
 =?utf-8?B?Q21oODQ4QU9uRTJqMW1CaCtHRHl2SEJER0N0MGlpNmFMeVBkaHFnczZibnBw?=
 =?utf-8?B?dzQ3ZlZlZW5nYTZKNU03VVpOeTd2N2tFU0JIaVNCMzFZWG5VZTdtN1Vmdm12?=
 =?utf-8?B?MXV5VGV4WklCRzJIK2t3VGUrWURiZjFaTUhWNEpYQmF5R3B6OVdZUURLcnNY?=
 =?utf-8?B?ak0zTWdvV0lzbGNjK2JEL2hxYzZKSldBTlgrbDBCZktyMTk5eXROU3QzUDlZ?=
 =?utf-8?B?MEZvaXhVaFNrdnlHaDk4RkVhYXFyVWFvdmRCT3ZsTGg2VDFGNzJJb1J0Z2VH?=
 =?utf-8?B?WnoxZ2lKb0dzL28zWHJBaVh5K3hRb3pGYlJNcktpU3U3Q2lSdnpVWER5OVZw?=
 =?utf-8?B?NVZJVUJMeDEwMHVtRy9ralpxNm80bE52RGxHOEhsd3A0cDEzbXVjcmFrM2Fv?=
 =?utf-8?B?VUJMSEx5WnZ5RE8wMVFoa3pVT0lYZk04YVZkTmRJam5iNjk3T1FIQ2xMMHJo?=
 =?utf-8?B?SEROeEJ6eXF2Vit1TWRGdkx4YVh0akJkNTB6QkFpYVZQNklLZm53ZWJCQ1g3?=
 =?utf-8?B?ZjhZQnJlNGtuZDlWa1hJTldnVWpkMGpCWU9GQVg4WU1wRS9pSDNwV01jOWlS?=
 =?utf-8?B?ck4yUFhGa2swMnZGMFI1K1ZIbXVCWVI5TlcvWGlQTjdTWVUybmF3RjhGMGJh?=
 =?utf-8?B?WWhJM1RKTmduKyt6SlBpUHBPQnFWOG5oNllkSXU0SjZtYm5CZ0R2T2I1NnhJ?=
 =?utf-8?B?YVJIZlVuVnRKOUVKTFY3a0FUeDcrZHRrOWwvTDFmVHRkSjJiaFRRQzFFQ3Ro?=
 =?utf-8?B?bjNMalc5aE95bXl5eDZTWkVEU0d6czgzaTZRQW5GWEF3ZDY4YTdFRTRuVDAv?=
 =?utf-8?B?bnEzbmVKRTM5MmlMeGdXSFJ1a3dtcnZXM2dXOXd0cTlaeVJQL2JNbHQvRFZE?=
 =?utf-8?B?Q2NOK2gzMzBRS0k2UDVvbkRHZU1IV2ZNN1ZzOFlTY2JncWlOZ1owOVliVzVs?=
 =?utf-8?B?aWxnd3NmMncyUzR3UkRxL2hvcmp5YWpiVnRqL2RhL2VPR3creE1PRzkzQjdM?=
 =?utf-8?B?Q3ZLQmRwRFRPL05HVFpHNDh5cEtpUmV3MmptTWF2T1F4aXlrQnF2NEhtaTNP?=
 =?utf-8?B?bm82dEJwUVloa0VXdmwxd0tTd2EwajZRU2srTmV5UWZCbWtJT2pVZVFRbk0z?=
 =?utf-8?Q?/TGGrVb7ZlOxtMwlRFM5RfCcT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTRaRjZPdUgwV1NPcUU0ekx4UmRpdkR0Mko1ekVJRklyV3JtcE1vMVgwTWVF?=
 =?utf-8?B?SEhPUy92L08wOEdlRDlwOGR2dHB6WUYrM00vQkdJWnJVK0tZdDYwczFKS09V?=
 =?utf-8?B?SmtWY2hSZ0lzakpvNnZHQUtGZUZvaGVmVGFJcDd3YWEwU3pmNnVEaVVrTlFT?=
 =?utf-8?B?WndmNjY3RXVqaVptY0JGMUxybGxPSkdlUzdVTW1Vd0swMWdQb1ZBOGp0L0kz?=
 =?utf-8?B?UGVuOVVRRDlhWVdSY0RJZmF1SkFJaEFPMUk4N28xdkZsZFI3Smd0cm1DUk5I?=
 =?utf-8?B?dHNZc3hLZmYwNGxITWFJYUxZYkVTcDRFRlc5WXR1cUlLM1JtWXMvcjFPUkhF?=
 =?utf-8?B?R0p6Qm1BV3o2bmdTL0hOdW95a1gzR0IxdG1XSk1xZ1dLLzhIbU5ZUElsYmZU?=
 =?utf-8?B?azNXT3RwbkY4STNuWUxaWlhVRkFNU3hMTzFEU2dFSUJ0Z25wOFR4Q3FDL3hG?=
 =?utf-8?B?eHNXajh6Q3Bvd3hJTENFRVplWEtHWmtmeW1ueEdlbVNkSUJpZjVzb0JIbjh0?=
 =?utf-8?B?Qk1ocm1sc2JrMjkyVk1YR3NoblhETWtBZDkzTElvcW1qM0FlUVZEd25XTFd2?=
 =?utf-8?B?RlRMUHpONDU0Z3o1M2hrRzJLK2FuL2krWlliNHQ1VlVtVGJIZkdzaGF2Ykhk?=
 =?utf-8?B?WVVOaUU0cGtFM1hEZG4xVWphTGhjNVMvSWsyMndRVTN6UEx1eFR2aGJsMnJs?=
 =?utf-8?B?eW54RFgwZi9tM0YrMUU0aXRYN1Y3N0l1clg0YUhVRWxseFE5b0VpZHZtSURk?=
 =?utf-8?B?YkU0dkFudC9nREJyOXdBUmtKTzNiMDY5WWtOQ0NCVVhCbDFoWFZvYlBhMW9W?=
 =?utf-8?B?bktVQ1RmQlVsYUJXOTRJemNnM0s4YWZ2dXF4THY4allzTzM5UlhhWEU2THpS?=
 =?utf-8?B?VGNrU1JKWEhXeUs0bEltWjl6SExMUDJwRm1YUFhVRExJS2JNYmJaZldwNEwr?=
 =?utf-8?B?ZytlTmRHaHZLT2FhZzRGcHF2c2ZZblhNYm1WcllDVlQyT1VCNDNZcHNJZ2pv?=
 =?utf-8?B?RUFJTmtxdFAxU1JXSno0U1hRZWQ3MStVMllnMmhvWVdFM2xIVUw2TVVNcXZq?=
 =?utf-8?B?UmNOTGsyV1F5YTlNMEh2STdJQjFrd1p5UW4ydTRIZ1g0ajBIUWNOWDZOL01O?=
 =?utf-8?B?U3N2ekNFQnkxckdZclo3aU5ZSlpUMTdWbXJTbEE0bHl5VXMybTZzZTA3ZXJi?=
 =?utf-8?B?b2paWFQ5Nkx5eEV0YjJmaUw5T3lKQXlMRTZwYVBsL0V3aFhRMUcwM3lIeE9P?=
 =?utf-8?B?QVRFTCtueHp2VDZqQ1ppc0NhdDVNbTBNU3pBd0taUUhmMkVoVkwzaEFTbDRB?=
 =?utf-8?B?K2hnU0g5cjFWdXNwZFZ1UUNybTYyMDFFbVFvaHZIcysySXVwWnJOOTJ1ZGJM?=
 =?utf-8?B?aXJqZUF2WElaUCtFNTBXeG5zOE1ZOExuYTZYSXNiRWtsZ1BjRlAzUC9CQUoz?=
 =?utf-8?B?OXRWY2h5S20zdWZuOUlKbk1wN2FxaHJXTFhBUVREREFzbmNtdFRGcm5ocWd5?=
 =?utf-8?B?T05XdmlTejRqMUtIVE0yYmxiaHJLOHJXZDcvbHJtbW5WT1lSWlV0ekRJTis4?=
 =?utf-8?B?bjlUS0lGbFhBSWNPaUlZd1A2TXZYNkhjV2pUSkZxdnU3K25ieExocWc2SFNi?=
 =?utf-8?Q?Z7xtc+R8D5W7TG5iOcmM8Ndf8b6Vw0UBA+G0Hr4xwjmQ=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6240a17-563c-407e-119d-08dad4602fa4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 12:24:41.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3a6LqpSfvQVV/dtkpsm9Yr5xy2Xx2RbHOQpq2mvYEuWXpfmlBsa5NF7JkJn3JOYrBY3Ta9JgFWAPRh3zybGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6127
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 08:48:14AM -0800, Dave Hansen wrote:
> On 11/30/22 07:53, Roger Pau Monné wrote:
> > On Tue, Nov 29, 2022 at 09:43:53AM -0800, Dave Hansen wrote:
> >> On 11/21/22 02:21, Roger Pau Monne wrote:
> >>> When running as a Xen dom0 the number of CPUs available to Linux can
> >>> be different from the number of CPUs present on the system, but in
> >>> order to properly fetch processor performance related data _PDC must
> >>> be executed on all the physical CPUs online on the system.
> >>
> >> How is the number of CPUs available to Linux different?
> >>
> >> Is this a result of the ACPI tables that dom0 sees being "wrong"?
> > 
> > Depends on the mode.  This is all specific to Linux running as a Xen
> > dom0.
> > 
> > For PV dom0 the ACPI tables that dom0 sees are the native ones,
> > however available CPUs are not detected based on the MADT, but using
> > hypercalls, see xen_smp_ops struct and the
> > x86_init.mpparse.get_smp_config hook used in smp_pv.c
> > (_get_smp_config()).
> > 
> > For a PVH dom0 Xen provides dom0 with a crafted MADT table that does
> > only contain the CPUs available to dom0, and hence is likely different
> > from the native one present on the hardware.
> > 
> > In any case, the dynamic tables dom0 sees where the Processor
> > objects/devices reside are not modified by Xen in any way, so the ACPI
> > Processors are always exposed to dom0 as present on the native
> > tables.
> > 
> > Xen cannot parse the dynamic ACPI tables (neither should it, since
> > then it would act as OSPM), so it relies on dom0 to provide same data
> > present on those tables for Xen to properly manage the frequency and
> > idle states of the CPUs on the system.
> > 
> >>> The current checks in processor_physically_present() result in some
> >>> processor objects not getting their _PDC methods evaluated when Linux
> >>> is running as Xen dom0.  Fix this by introducing a custom function to
> >>> use when running as Xen dom0 in order to check whether a processor
> >>> object matches a CPU that's online.
> >>
> >> What is the end user visible effect of this problem and of the solution?
> > 
> > Without this fix _PDC is only evaluated for the CPUs online from dom0
> > point of view, which means that if dom0 is limited to 8 CPUs but the
> > system has 24 CPUs, _PDC will only get evaluated for 8 CPUs, and that
> > can have the side effect of the data then returned by _PSD method or
> > other methods being different between CPUs where _PDC was evaluated vs
> > CPUs where the method wasn't evaluated.  Such mismatches can
> > ultimately lead to for example the CPU frequency driver in Xen not
> > initializing properly because the coordination methods between CPUs on
> > the same domain don't match.
> > 
> > Also not evaluating _PDC prevents the OS (or Xen in this case)
> > from notifying ACPI of the features it supports.
> > 
> > IOW this fix attempts to make sure all physically online CPUs get _PDC
> > evaluated, and in order to to that we need to ask the hypervisor if a
> > Processor ACPI ID matches an online CPU or not, because Linux doesn't
> > have that information when running as dom0.
> > 
> > Hope the above makes sense and allows to make some progress on the
> > issue, sometimes it's hard to summarize without getting too
> > specific,
> 
> Yes, writing changelogs is hard. :)
> 
> Let's try though.  I was missing some key pieces of background here.
> Believe it or not, I had no idea off the top of my head what _PDC was or
> why it's important.
> 
> the information about _PDC being required on all processors was missing,
> as was the information about the dom0's incomplete concept of the
> available physical processors.
> 
> == Background ==
> 
> In ACPI systems, the OS can direct power management, as opposed to the
> firmware.  This OS-directed Power Management is called OSPM.  Part of
> telling the firmware that the OS going to direct power management is
> making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
> calls must be made on every processor.  If these _PDC calls are not
> completed on every processor it can lead to inconsistency and later
> failures in things like the CPU frequency driver.

I think the "on every processor" is not fully accurate.  _PDC methods
need to be evaluated for every Processor object.  Whether that
evaluation is executed on the physical processor that matches the ACPI
UID of the object/device is not mandatory (iow: you can evaluate
the _PDC methods of all Processor objects from the BSP).  The usage of
'on' seems to me to note that the methods are executed on the matching
physical processors.

I would instead use: "... must be made for every processor.  If these
_PDC calls are not completed for every processor..."

But I'm not a native English speaker, so this might all be irrelevant.

> 
> In a Xen system, the dom0 kernel is responsible for system-wide power
> management.  The dom0 kernel is in charge of OSPM.  However, the Xen
> hypervisor hides some processors information from the dom0 kernel.  This
> is presumably done to ensure that the dom0 system has less interference
> with guests that want to use the other processors.

dom0 on a Xen system is just another guest, so the admin can limit the
number of CPUs available to dom0, that's why we get into this weird
situation.

> == Problem ==
> 
> But, this leads to a problem: the dom0 kernel needs to run _PDC on all
> the processors, but it can't always see them.
> 
> == Solution ==
> 
> In dom0 kernels, ignore the existing ACPI method for determining if a
> processor is physically present because it might not be accurate.
> Instead, ask the hypervisor for this information.
> 
> This ensures that ...
> 
> ----
> 
> Is that about right?

Yes, I think it's accurate.  I will add to my commit log, thanks!

On the implementation side, is the proposed approach acceptable?
Mostly asking because it adds Xen conditionals to otherwise generic
ACPI code.

Thanks, Roger.
