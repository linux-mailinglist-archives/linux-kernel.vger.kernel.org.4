Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0110F6480B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLIKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLIKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:13:03 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F851FCC0;
        Fri,  9 Dec 2022 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1670580781;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=u4AlrndQaVjjw6Vi9vpMwM4Zj/s4t5pFlY9S6XLazOM=;
  b=LRhr0Ps74NZ/XuqUFVhe3S19HqLxkC5Y6WA3ZPkHvAiyOIOQZcSdFQ1g
   A2EWmeoIGCNN7DwEOg22xyZunPQ5BmVxEz9Diso0CIKAYF5dWP61/vaNF
   l+fYElUVrjRlXqcp1IRwmK9TV4dzyCoExdUY9yktRDUxxNcE86WscntlX
   s=;
X-IronPort-RemoteIP: 104.47.73.175
X-IronPort-MID: 87522462
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:8tISwqKA1iaZC6JiFE+REJUlxSXFcZb7ZxGr2PjKsXjdYENS0DwEx
 2MZXDqGPqmMYGSgfdEnbd7nph5XuZXcmtFkTAVlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHv+kUrWs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPdwP9TlK6q4mlB5ARvPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5VHGNi2
 KUmAwkAf0iHvL+mye+YRtlV05FLwMnDZOvzu1lG5BSBUbMDfsqGRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/VspTGMkWSd05C0WDbRUsaNSshP2F6Ru
 0rN/njjAwFcP9uaodaA2iLz27WVwX2hMG4UPILh28Y6skyp/DQWAz8sW3CamfqijkHrDrqzL
 GRRoELCt5Ma7kWlR9T5dx61uniJulgbQdU4O+Ez9gzLyqPS+AufLmkCUjNFLtchsaceQT0sy
 0/MnN7zAzFrmKOaRGjb9bqOqz62fy8PIgcqdSICCAcI/dTniIUylQ7UCMZuFravid/4Ei22x
 CqFxAA8iK8UltUjzLig8BbMhDfEjpLOVA8uoALMQnii8Bh6daaifYWj7VWd5vFFRK6FQV2Rl
 HwFndWC9ucIDIHLmCHlaOAMGr6uz+yIPD3VnRhkGJxJ3z6103enfI1WsHdyKS9BPs8adHnpa
 UnItAV54J5VIWvsbKlrbob3AMMvpYDwRYrNVf3OaNdKJJ9re2ev/DlnTVyBw2f31kMrlMkXP
 Zqde+6vAGwcBKAhyyC5L88U2r8qzyYx7WPLA5v8ynyPz7eYZ3eJRKwFdkOHauQ49KqIoS3U9
 cpSM42BzBA3eOn/ZDTHtIcYNVEiM3c2H9b1ptZRe+rFJRBpcFzNENfUyLIlPol6xaJck7+U+
 mnnAxAFjl3imXfANAOGLGh5b6/iVop+qnR9OjEwOVGv2D4oZoPHALojSqbbtIIPrIRLpcOYh
 dFcEylcKpyjkgj6xgk=
IronPort-HdrOrdr: A9a23:qW3AvazySfCA362QIcX/KrPw1r1zdoMgy1knxilNoHxuH/BwWf
 rPoB17726RtN91YhsdcL+7V5VoLUmzyXcX2/h1AV7BZniEhILAFugLgbcKqweKJ8SUzJ8+6U
 4PSclD4N2bNykGsS75ijPIb+rJFrO8gd+VbeS19QYScelzAZsQiDuQkmygYzZLrA8tP+teKL
 OsovBpihCHYnotYsGyFhA+LpL+T42iruOeXfYebSRXkDWzsQ==
X-IronPort-AV: E=Sophos;i="5.96,230,1665460800"; 
   d="scan'208";a="87522462"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2022 05:12:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg87I3Erxk3hsb2I4OVDeHkYROB3IoS3fWkm0dv5l3Wq+gnnd/3NoWJScnKw1H6tWm8OQiEpQbYX6bb3iitIbZYO25u9XGYx3IwjYEN+5/Hd4sj5WNYSYA/y5FDTd61hiiPIP981WqwK5h91v35KHDDkaBamwBK+qYk5GW20JhUPv6/awX62UgemnID5vU8aP9qDyC7IWwVqc2Gvd/CyKehs1kKcfdrMdpCJ6wG/Hhcjtq+5HJZsc5KGjm6z+sQ0vNJbRGYjPfSLFT0XZkmP7Qj3RgMigeVR1BEJEOqSBSReNomO7eIBkbOrbjkQkEBOWpycUj3IKnn6UO46kg0oNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjP/Rrmdvq/WTnVAPklZD5PrBjU7PFIzInYp9GdVFMs=;
 b=Uq47bPPyJDUoBe1z607up7E/cSbMnnROBQDtxosIXon7ijAl3TBu9w8jrZXf4M1hreO5fc6MUCi/afEAPeZTZsK6/kZF6OlOEcfzB4d8dDwiKTqabXK0DTUDHLRahTBcPVl6phGYm1UP1t44InYDRZ/V+LCyPyjxMYVI5YRwMSTzFuO4eMEdf319H+FbuF3yssiCC+MpzrxWcKvHQzool7ke6bDpnQNqzKk4gA4zrrdowRS6s+bnUSHg10Fh2RegCpfjZkO4j1thH5S2ie+GlJ2Dwg+WJy+nvS+FH+dZ2KvcwPwCTv3sx2e3QgtQkQ2wFJ3Nl8MrtbFdBbSMMsvEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjP/Rrmdvq/WTnVAPklZD5PrBjU7PFIzInYp9GdVFMs=;
 b=UHOPfTlN7FDu1+/Q7J1HkH371zbI31kvKHJp+dYXEhNrAJ/i4qm3ESbnwrRqdfg9tmmtXRYSJ/+aJXbTqcjgBjcbCV/xEAmqJK0BVvM55vrSqWxkeWyff/Olf7JFoHSXoo9v9JdQiDE3AqertM/F1R4Jd8JU6wW6XUMfZtZKAPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by SA2PR03MB5755.namprd03.prod.outlook.com (2603:10b6:806:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 10:12:57 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%8]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 10:12:57 +0000
Date:   Fri, 9 Dec 2022 11:12:51 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y5MKIz4t8pfx/M3h@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
 <Y4d8cm97hn5zuRQ1@Air-de-Roger>
 <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com>
 <Y4nugxKV1J/BqhBt@Air-de-Roger>
 <93fd7ed0-5311-d6db-4d8b-b992a8f78ada@intel.com>
 <Y4opuLnLIT3v9Aa7@Air-de-Roger>
 <CAJZ5v0hrdwUNOELXM5zxtTeavp+_o7TbkCRBjZVqvQVxt4QBnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hrdwUNOELXM5zxtTeavp+_o7TbkCRBjZVqvQVxt4QBnA@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::13) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|SA2PR03MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2ac5c2-df33-4240-d62a-08dad9cdf1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrbIhnevrKE6GcxhMlmZugkS3bIJ6BHKMGgG/UM31jreWVyyJwEr/yd7NAN7nO1MCOa79HguJWOijc+s+t3MWv8exQHaGWdRkoa1vGoXjf5XAtHkn0mHcyomTht0fwfMh7RFOIb5Q+dl1VnRdJ5q7FtPDBgTKmGEFoDeeyVQrOiztYxhgeRRMnJuF7Abjk+c5+jgS5sP7uXRDFGaX94Xt78EgL/xPqWYCVE2SYN8RejTMa2b+HKjq5yxik2xQGjBzXprWF7C+BAaVsdY+406SaU4oSraHRFnP3yIKCN2ZREL1lzK6wiOVG0YCjuACdz7FX6xhO3urfZsEMJYDq4OpKlOmXiVDIjFyX/9tjOlLpsCvMkDObz0cNd9PbcmZFYIINTFmn7BHmuDAU9OKiACe/5bPxcLz9sjBNKgex32ArGf7X2TbCOuVdApo/clRYNYVxUd10dUIulIysPfHcEwvHoGIycP36DJcW/lqmzTXd0rPpOOWDDxz2f51fPvOW6ne6Aa5m5kFeP+zPP5JpyzHMnbBuYVqOgAkn2Xm5hDI2ibMP9ylvr8vuftlomcnsZldvFWB7y4yvOVbZNh57M50RPOqWzhmCtQZl7h7kRAK+7ws9rU0Di1C/1Xb0gcrwZlkWf5yB7d5RN1gD4rBEtQKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(85182001)(6666004)(8936002)(5660300002)(7416002)(38100700002)(86362001)(41300700001)(82960400001)(54906003)(6916009)(6486002)(53546011)(508600001)(186003)(316002)(6506007)(4326008)(66556008)(66476007)(8676002)(66946007)(26005)(9686003)(6512007)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVIMlhOQmhOcGhyMDBwbjRrcFJLVmFhMFJ2ZWFWdHRKRmRteWVadnl6UjV1?=
 =?utf-8?B?WkYyRmxoOGdjSkpSTVNoZTVPMWpYMUNBNkhocGxhM1pDdU9zSzRadzFNOUVS?=
 =?utf-8?B?YkRZaHZSamVXU2dvRUZjUDBpc3RPMENmR3BPME01S2FGQzBXQWl3MmpzQllG?=
 =?utf-8?B?UFlPTzk1eFErWTNPLzJhdkppaFd4SS9wMVAyUUVTYnc2WkthVDV1SVBqREFp?=
 =?utf-8?B?SFA2YlRJdTV0MEZNcC9sREp5ak82S01kck5WSzM3RTduWVFmNDNIdHhEaWdj?=
 =?utf-8?B?d0EwUTBlZW9WRk9vWUlzQkZxWHdjWFRPdzQvQmhRL0RkN25YSm1tNWg4R0dm?=
 =?utf-8?B?TzlTUElNcnplMVVvaFVPQU5yd0tHQUUwRTJheHRySTdVbndIT28vZXdkdTF3?=
 =?utf-8?B?Zjc0S2lTWkNpT21BVjZ6SHBXMHc5enY3T0xDbzZYOFg4RGRCQ0JsTmlRaEZM?=
 =?utf-8?B?ZW8xK3F4eVNVL1g4c2tLd2tkbnhveHBzRmZmZmQ1d1QybnBDKzBBTnZrYUMr?=
 =?utf-8?B?VU13dS9uZDhWMXdrQjhoLytQVDkrZzY1RkNIaW4wOGZQZ24xWm90emZERDZM?=
 =?utf-8?B?VWh4OTRMNEl2Tk9JbU5aaDVNcm9halVSZ0xBeEQvN2ZpWGlocGRJS1NSYVFX?=
 =?utf-8?B?S3BJb1QxMTFFeVlQczBhVGlGb1VwZVNiaEFxejFjenZnT1E2L0pDb0VyMUJW?=
 =?utf-8?B?TEdpbGFjOXljeS93TlFidGRLM1VLb29HeFRxdVFYUkxnMmluZjZkQmZaTklE?=
 =?utf-8?B?MEljdXV1cG10MzJTbXV1ekhJQ3ludkxIMHR4YkhERytnSXR1Y2h3QzZzbXNS?=
 =?utf-8?B?Um45MTAwdEZ6OURBWndGYUExOGhXckhwSklqRHUxVWxzYnM2TlVqb1Urd1pa?=
 =?utf-8?B?UjdjcHFwNEZhK2ZybWZNRmRXbUU2blFmY3ZXN3BVTVoyamxZbUJZWndWUmZF?=
 =?utf-8?B?K283dkxOdklyLzVCdnREUmZFdVJYT2ZQdVowSmNTM29ZNmFwMFhtMUtHeTMv?=
 =?utf-8?B?dHVwWmZSVmJDZ21Ub09GWjFNaG50YjN1UXgwcDNxSEREMURJczVxMFplbDNF?=
 =?utf-8?B?Yi9McktCK3ZoZ1d6eEtoS3F1U2RkaHhteTIxYU1DTzZvWHFNNDExeHlwejRP?=
 =?utf-8?B?N2VzN2RZVW1pOFNDVDg4bjBiZ0RZZ1B6clB0bytuVkUyYmt5ZHJ6cWRzVU0v?=
 =?utf-8?B?aGtYSExQYVp3bnJHV0RSQTZaYmJBYmkxcXpFZ0w4d09YMVZZd3Blb1cxa0h2?=
 =?utf-8?B?aExMeGNJSERXa3hvQmRBeWRudUhvSTZXcnhFRlZ4ZFNub2haTjhFMllqVlU1?=
 =?utf-8?B?SnNDRm9wNzBuaHlvQTRnQmpSSzBlRWVDejFpNkZ3dkdueGtkMm9TYzZWbnQr?=
 =?utf-8?B?MWdPL1N4eTZrQzBQamw3Q3pvL0R4ekUwQjFNSk1QT2E5TGtMVUk5VUZ2VEJI?=
 =?utf-8?B?dmpIdy80MXZhemROUjRneGZVcTdVRVlTMUtzRUlTRVFFWVlWYWJwQWxKblR2?=
 =?utf-8?B?ZHhlVlhkTXJSNUptS3RUN0xuQ3FuZ0UwUHZwMHRNQmI2Y2plQ3ZTMHJySEdy?=
 =?utf-8?B?dnJBL25FQXpsVjVyblM3QlFMczVOOGgrWEhQcUFDRktqb1Q4K3Y1WEthWUdJ?=
 =?utf-8?B?Y2hsMXQ5YlBZbzZQUHdqUndUZVY4M21ReU5vR1kwT3BlRlVzbmN3cUM5R0Yr?=
 =?utf-8?B?bGtCZUtKUjA4MERCYnJ5WjcrS1dETThPTmFLZWU3Zjc1a2VxM2FJWE1YTHdl?=
 =?utf-8?B?T3Y1RWYwRFlHdCt2bHhpaDRrMHZ3dVVyYnpZbGxRZXJDSDQydkYrampOdVJR?=
 =?utf-8?B?WmgvcmlESTE5QlVubDFhWkVvbkpnR1M2Q1dMOUFVTXlVUW9WeXhVbkRTMmVC?=
 =?utf-8?B?a1hYTTYxRCtWZFJXRnlOYUgxTUp5TDhNajlLd3lWQWtLTkFsQnBjQ3Z1WUl1?=
 =?utf-8?B?Vk9XVFI4bnh3WXVTMkFwa3lJcXlGa0FhMGpJNlVKVU5YR243dUE5WVk3STdu?=
 =?utf-8?B?ekdySE8xaGE4SVFaR1BQOEppaUJhMTlkYmcyOVZZSVV2Ryt3MDhwb3lUamdT?=
 =?utf-8?B?Q0dCS0NwRDdxWFV2dm9pMHVrWTVZQWhJdzZpV2dOSlg3WG5KanF2dHc5Q21o?=
 =?utf-8?Q?mjFmxT0NZ1GVj0W8j6iyM9Xyk?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2ac5c2-df33-4240-d62a-08dad9cdf1ab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 10:12:57.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL9LexSSqPQ+ZY5r28LX6NTy7X6oTmDqjYxfwoHJS43+1aB66d/gSyO+ac/K0itDsCajX4KeR+GtAB2HDo+9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5755
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 06:06:26PM +0100, Rafael J. Wysocki wrote:
> On Fri, Dec 2, 2022 at 5:37 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Fri, Dec 02, 2022 at 08:17:56AM -0800, Dave Hansen wrote:
> > > On 12/2/22 04:24, Roger Pau Monné wrote:
> > > > On the implementation side, is the proposed approach acceptable?
> > > > Mostly asking because it adds Xen conditionals to otherwise generic
> > > > ACPI code.
> > >
> > > That's a good Rafael question.
> 
> Sorry for joining late, but first off _PDC has been deprecated since
> ACPI 3.0 (2004) and it is not even present in ACPI 6.5 any more.
> 
> It follows from your description that _PDC is still used in the field,
> though, after 18 years of deprecation.  Who uses it, if I may know?

I saw this issue on a Sapphire Rapids SDP from Intel, but I would
think there are other platforms affected.

> > > But, how do other places in the ACPI code handle things like this?
> >
> > Hm, I don't know of other places in the Xen case, the only resource
> > in ACPI AML tables managed by Xen are Processor objects/devices AFAIK.
> > The rest of devices are fully managed by the dom0 guest.
> >
> > I think such special handling is very specific to Xen, but maybe I'm
> > wrong and there are similar existing cases in ACPI code already.
> >
> > We could add some kind of hook (iow: a function pointer in some struct
> > that could be filled on a implementation basis?) but I didn't want
> > overengineering this if adding a conditional was deemed OK.
> 
> What _PDC capabilities specifically do you need to pass to the
> firmware for things to work correctly?

I'm not sure what capabilities do I need to pass explicitly to _PSD,
but the call to _PDC as done by Linux currently changes the reported
_PSD Coordination Field (vs not doing the call).

Thanks, Roger.
