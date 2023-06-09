Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C548729E03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbjFIPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjFIPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:13:56 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279611FEB;
        Fri,  9 Jun 2023 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686323635;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o//AMS6AK7pS6LI/eJeqEo91TLLQJAfVS1VEeMAsz0o=;
  b=CkeDPBy+h4UIbQx0ak1M1SEGmPLT/UapgH1i+KYRfvVz9jRaCDHVaD9s
   G4CrySMyanqKbvIYmOCUQ9fdHxVWGk5Ue3T4z1vOm3BrdjQUvl+f0afjQ
   Wqtnahfiz+vvxJSMgHw0W8ij7LRVuNDv5CAqmyy1H04PhBONY3qTkZRAY
   Y=;
X-IronPort-RemoteIP: 104.47.59.172
X-IronPort-MID: 112646623
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:bZ2Nea0tQXqpWgi0i/bD5ZFxkn2cJEfYwER7XKvMYLTBsI5bp2dTn
 GdMXGqOM/+MNmSmf4tya4W290sOsZPVmtY3SAs6pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8HuDgNyo4GlD5gJmNKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfE0921
 +wmJBo3MhGZuvOp57uJd+cymZF2RCXrFNt3VnBI6xj8VKxjbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsi6Kk1YZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r137WRwX2lAtl6+LuQ3fpUkUaBn1wqBzokZV6yhte2mGukcocKQ
 6AT0m90xUQoz2SnQ9z8dxy+vn+fvxQYVsZQEus18wWEwOzf5APxLmEURDlMQN8rrsk7QXom1
 TehltzqLSZivL2cVTSW8bL8hSi0ODQHIHUqZiIeSwYBpd75r+kbgheKQtt9HaqdlND5GTjsh
 TuNqUAWgrwJiMcR2qaT/FbZgimtrJzEUg404ArMWmuvqAh+YeaNY42u9Eie5/JHJ4WxUFaMp
 j4HltKY4eRICouC/ASJQeMQDPSq6uyDPTn0n1FiBd8i+i6r9nrleppfiBluKUEsPssadDvBZ
 E7IpRgX9JJVJGGtb6J8f8S2EctC8ET7PdHsV/SRYt8QZJF0LVWD5Hs3OhTW2H3xmk8xl615I
 Y2cbcunEXcdD+Jg0SayQOAel7Qsw0jS2F/ueHwy9Dz/uZL2WZJfYe5t3IemBgzh0J65nQ==
IronPort-HdrOrdr: A9a23:Eg5ibq1du1lXLFnmIQMlTgqjBNEkLtp133Aq2lEZdPU1SKylfq
 WV98jzuiWYtN98YhsdcLO7WZVoP0myyXcd2+B4AV7IZmXbUQWTQr1f0Q==
X-Talos-CUID: 9a23:0/3QzWMDX7+XA+5DSgdf1l4qFuofLnzH8WbPBEaKNGg3V+jA
X-Talos-MUID: 9a23:73sJ+Ag4CITUvG0W46p0LMMpH8NW8r+8UXA0nrI0i8yNEgJ/KRKHpWHi
X-IronPort-AV: E=Sophos;i="6.00,229,1681185600"; 
   d="scan'208";a="112646623"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jun 2023 11:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG5W8fW7znhzZrsehrUf+oRsqJ5qSek90bj/Jw12qTbtTuow27wF/Pn521HgRXQChEIRfwgN5qx4NR1TMp96o8jh29wMesjkxb5rIhYtEPiNc4fUNJ534KpiTdb3tw/rii9+wp70Yc8wBAcv3ZfbNj+io6BWsFejzmrcInjiTcS4kruqKEpXrasDnhYZOEmdz5XVE9scgVIB8VkNpIREi+/T07hUCUPXTyv4srwKErQh9fzyvTRwfH4CV3DBWMgn9YYeoj1aHaYdgl1w08EOsiiLiCb9tVt1647I7gz+iKbmXJgB1rnRbnApxE+ya3HPYmouU4v8Sh0i0L/cNO+2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUFXXxMg0k7jjDh8dJSp3UUZ4jZR4bpZshfn2ePp5xY=;
 b=DfNb5wiJdbzef7VQIiTGOv1Zkqu0hwue0nl839Jmtb6xV4+bgPP8gPeO2XzIvhMs1e8daW113DfSSVDJPhycNzShbgB2dEgXbPQuhUNNZMoMxPgNkAPSCGbV5FXmQ0FIRCDyLmh6ifYm4z77TzN+zd3dMMc3l547EJJ0ihH//WoVJi9q9cG98ntwgj21m1zPCwQSsLCewgMrMruBNZx0vrK3Yn3lNo1yMvinZE3p4Fv7WS38t+nXwpoiGITB8LQTRQWEJxgqKmbSgrJUdhaK9vhuEkdQln6fKsnnidx2ljN74+idxAPbxOxZFBuQ56f+4ze3Sixtnvi0pMNS0Sr/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUFXXxMg0k7jjDh8dJSp3UUZ4jZR4bpZshfn2ePp5xY=;
 b=xc9cuqmEt1agA7HSV7HBF2UsvPbtjTsgOTp7DYfVQurmPC9AtoxNP8ma5H2nxvZ1bHgOxUgdi9Ag25P2AiWGKyN10qn377AjltUmy5T0UKmMYMxs0UuhkQYiRBpJWQlBF3/8FoJj+vrzX+JFoca25bFFrnuCM3fA1Fl+UMn7IRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by PH7PR03MB7161.namprd03.prod.outlook.com (2603:10b6:510:2b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 15:13:51 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Fri, 9 Jun 2023
 15:13:50 +0000
Date:   Fri, 9 Jun 2023 17:13:45 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZINBqToBZVdfmr0e@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
 <ZIGRXrSGmgLF/07O@Air-de-Roger>
 <ZIH0yQCICZRpliSc@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIH0yQCICZRpliSc@itl-email>
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|PH7PR03MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3c429e-66d9-47fd-0a74-08db68fc218f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5Ue7PcpP3u2dMM+Io7ktvMTdxS4q70nuNMJpQW//v/SbPPgr113/8gaoXOdhKo6Xpxg8hVmXhE3HtQK+ipE1bgmg24ROvuZILfGFzqaj4NDz/aWpFTaV/rXL5EY3uYCOkXgN2eLnC1bGLxDnLRZl5BrfGk0x3D7PYKL6LcziWT0/XkVABeYTG1CxleI9AWEl4OaM70vQ0xalCNuo/qPkvEBSsZR0rb4ITo629Wzek/NDscPu5wQ/Rqsn2t4xOU6cYr7jxIAUKuam0jYW7ODghBV17OAsEaT3Jxy+kSEHtMLT0ISl53hUqRChf07pNxhvi81jolg1iVd5DNRYiOIv3igqyjea7vqgEOU7nHG0cCU+sDmJpd3Gcc/46T1kn7GxmmW7W9AuP4b60m9oGe1rOxttg3ABXDUvlwV/cZWOyYRG1toJXaHX35z6ZUESfcYp4IV/FBwCYlEa+YaaSO0rEmGmw9JIXdqbZR8LP6zqYlifiZsQ+sYGAe6dzTFQfOk9vvZoE57r+iAFizXPGky/bY+A6cWD8EgKYfEDiwbbUrlc29pdourFd5yGvqoxBf1o5p7B5y/3UfGPr1ugIeaczt0cyzhOT+VRdcko2w9xHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(2906002)(5660300002)(6916009)(41300700001)(8936002)(8676002)(4326008)(54906003)(66556008)(66476007)(66946007)(478600001)(316002)(6666004)(6486002)(186003)(33716001)(86362001)(83380400001)(85182001)(82960400001)(6506007)(6512007)(9686003)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJYUlA5U2NnaVFqdlc0V1R5MTNzaXJMR05RQzI1Z0h5SDJHUTBHcjhIbk1Q?=
 =?utf-8?B?ZDYzc3ZtVExlajVzL1RTSXpPc1lpQVZMWXN5dHMxaFc2K0FXcDBFeUEzdng4?=
 =?utf-8?B?OEJxbnN3K1d4ZXhvb2xhRFY4cVhsTzd0OXB4TmZJeGtQeGdpK1NYUUtUS3Fs?=
 =?utf-8?B?c3lyQXhVaHpjODNqRDhqUURKeFZaZ1NzQ04rZnkxRE5TS3VrS2twMlNuYzk2?=
 =?utf-8?B?dmdnakhhaVovSXZSNmdRS3MyWGtVa1Yxc1FzK3ltZHozQ3k0ZjM0d3owTmhu?=
 =?utf-8?B?Tk82WDc4ZVVDK1A5SXIwdUl0R1RqUjQ1QjZjQXR2eEZBT1A2OEd4b3NJOHJW?=
 =?utf-8?B?MytLeEI2UlI3VVNMb21YRkE1QkNUdnRiSmVDb2pHdDBxTFMvZHlsaFJqcEJ2?=
 =?utf-8?B?WjhKcUhic3lwRWhDZUxvNkFJV3psTDdNYWR2VlB1eHE0Z3hUWlRwV1BtMGRS?=
 =?utf-8?B?TnZjV3kvVXVZdDZDZFhHeStQK3pBY1JmaWpabXp3V290MjBNK3J0ZGNFanRI?=
 =?utf-8?B?MHM1YkVmSEZlOGZMNVpFYlp3RXcvWXRSYTFkSHRPaHBkL1BIZzE2MzcwcVJu?=
 =?utf-8?B?MzdyZEQwamtoT2tpN010VngxWUprcktjVytYdzBJd0djc3J3UFBFaGYwY0h3?=
 =?utf-8?B?WXkyb2t5RE5SM0pzN1FIVTdHUFdPVDRORXlOT3A0YTkrVDNEUVhHMHc3ZHRu?=
 =?utf-8?B?bkhhQWhwRzc4ZkdJLzhmM2UraG1QcVpIN0x0eGNROEs0cHR6akxhOHZJRGcz?=
 =?utf-8?B?WFJLWS9reUF6SWI5QkhFQWF5RlkyclVIRytFSnEvOThWeXNtUXpkbmlwVGVl?=
 =?utf-8?B?M1N6NjNCdG5pZHhQOFRMWE1BYnM0b0JYbjlrUmlIZFc0Q2VtQzBIUFM5djBZ?=
 =?utf-8?B?MmZwcWxLYU1mN2Z6c2J4d2h0MXM3R0pjN3ZNS1c3UnkvKzZ2ZVNhdVNRWEhy?=
 =?utf-8?B?R0daZ1U0ZjdhV2xTeVV5UFlIeGoxemp6WmF4c3Y4WGFESlhrR1gyc0NBL0h3?=
 =?utf-8?B?MVN2TUVSSFEvUzFaS1NPL2J5TittQzBhZ3gzUG10NzB6WkpWWlJwTnhydjI4?=
 =?utf-8?B?RWQvRDk1OWVDZW1WSVdWMjZwaVZnZzk2cWpBSm05d3FNUitPakdZd0dTTzZq?=
 =?utf-8?B?K1o2V0VJWWpXYUlDTEFQaW9lMlhDWXhNWGs1WUg2eWFPWlZZUWJGeHBkK0NV?=
 =?utf-8?B?cE1KL0xwamROZmhwRGh4SjAzUmQzSlErNFdlVFlSYWNlOXRCaVQweEo1WFcw?=
 =?utf-8?B?KzR1c3BHb1RWQjh6OHVZNU03eTRDU2I2NWt4KzI3THhEWDNYdVJJMVk0d0Rw?=
 =?utf-8?B?Rmpab3VvWmhhRHVqNXZYRzdyTkxTaDF1V2s0aC9JcjJOamNQalR3eXo3cGc2?=
 =?utf-8?B?WmJCcXZhTTNrS3NEdjRLQ2J5RjFNWGk4SU1XaVFHck9JMlo1V3NOanBCYkY3?=
 =?utf-8?B?NGNaMmFYTEpYWkFUMHJJV1ZMNmJNR1hxeDBIc1JNeHA4bFd3RWZmK2Y3aXh1?=
 =?utf-8?B?UUt6ZXB0YllhemdTUnh6K1A1QTdZaVFPb2M0TFNvcWNqbVBWYnR5RXpzZnVE?=
 =?utf-8?B?ZkJyOWx1RmxZRXI1aDVIMVVIcU44MHRqTm9NL2MwMGsveWlNdVIvVktMKytQ?=
 =?utf-8?B?VUwreEdMT0UvREJZN0haaGpDRGNYNnF4ZmpvSHcvZEYwcFE4ZGFJM28wb2ZY?=
 =?utf-8?B?U3FmV2tMZnB4SHQ2VDZYakdsOU9HVWQvRm5DYXJPQ2Q2ZUZjK29mNUdvS1NN?=
 =?utf-8?B?cXhuVjRzYmRqamx0SVg1by9oYXkzaFNVTUZyRVB5bmVhMVg0VklWdjFyc241?=
 =?utf-8?B?cGprakR5VXdWTzczajI4aDVrSXorTnBWNCtjMjdhaml3VjhTaGxDays2ajA2?=
 =?utf-8?B?bW92NnN0NS9sWjhUd1BidlEyT3NmZ1VtYUR2dVpveURlVllQalFEcTNnVHhz?=
 =?utf-8?B?bEloTytVN0NUSGk1bFNtZWh2ZVFxRDNkNnBneldEVU54UFRuQVo1ZGszWnlI?=
 =?utf-8?B?bGlRZzVvRUxRN2w4cGw2MWNKSTVhMVNCRFg0VnFXNDNXc1lFSWl4WmNTMEtB?=
 =?utf-8?B?ak9IdDlqREp3NXI5a2kwZ2NFYkJCU3dNTUZwZW5QVHhRbHZsTENza2xRQU5E?=
 =?utf-8?Q?l33QYGAbTGml6xbV0FTDYJxoi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZFlkUnFaZ1htMk9XeE5JblFpY1FIVndFM0hNUDVxUE82YVYyV2hiSUorTmJU?=
 =?utf-8?B?UVpHek9KUVF3WnhyZ1g1V3VNcmtSWjZOMmFBakVubDlZVTlxakF4WUhTNjda?=
 =?utf-8?B?V2pveERBcGVDd0hxaUo5WnNlMWFsaVZUR3UwbzFlTE1ZME1aSHhSUWw0RXpw?=
 =?utf-8?B?TXMzSFFoUUdHTWJxUjdSNUI1M01KOHBBSG5rY0VoSmp5Ri8zc1Fnd2RiL2pS?=
 =?utf-8?B?Y0Z6RytWc1ZndUQrSERLSHAyTHpNSnJWL2FRSFFlN3BQclpCbWZZa3k2Q2JW?=
 =?utf-8?B?OTl0eUU5WUpOazlpQ0pIOHl3aHdIYUREYkI1WHNCeHhQekFUYzVMZ0xqM2sv?=
 =?utf-8?B?ZzVvWnVPWnljSjJ0amlPU3JUd2JsTjM5b1pyTXVWYjVnVmVoa2IxcW9YTnNn?=
 =?utf-8?B?TGwzWHlmOS95Q010WmpsVWVPejNVZzRtb2RMV2RlUi9aWlR5ZkhndzRaVm1i?=
 =?utf-8?B?ekpHSy9mejRtVkVTZWpIKzZMK2RmeHNMWVgyQjZwUUVhY0FkdGVGRG0wcDlT?=
 =?utf-8?B?ekprd0hZODM4L3ZmS05aWnlFQm5yeHJyNDlYUFZFRUlGdGYwSkVBcXNEblpm?=
 =?utf-8?B?M2Y4RDhxUlIzZzVYOU9KMVNuQ2RmMmw2VEZobGZrKy95VmtxZTVlQlFSbkpV?=
 =?utf-8?B?SU9KblFPTlJQVTUrdFIvZ3JBM01URmdiSDRQQ2F1dDViU3l3SDJIalRnR1Bq?=
 =?utf-8?B?SjlLdnNxelNlRm05NEpBRzJqNkw3MExrVzhNRE1hekY4dGl2bVFWQm1UbTV3?=
 =?utf-8?B?TkNmbjU5dkg3MFVaalI4L3NyUGhCRks0TDlZZlFwRG9SSnZjaXR5NmMrUElW?=
 =?utf-8?B?Tm1JMzhTNC9hM3l1Qlgva3hPS3R0K3dzLzdoNXlVclErS0VPK3RZc0lnamRp?=
 =?utf-8?B?OGpKbk9HVjYzWHRqb2RQa0ZYN1VxQmI4YXNFT240c2Y2RGtySXloR1IyeXpD?=
 =?utf-8?B?WmJjL0ZvOTVrRmY4YXZsampaM0ZUb0JRZm5GSVR6RnJGU1huQThTYWNqTzZH?=
 =?utf-8?B?cGd4TVFuN3VWSjk1WGtpV0xsU3pzZjVkMzJpdkRWOGZwQmZpMGU0RnFCVDRD?=
 =?utf-8?B?M3M3SDN2OThnekZEOXR2WDQ4TzBUSm9MSTZrdTBKU2VLWE5XKzlqanlSeXZ3?=
 =?utf-8?B?dmNmQXQxc0hqSGR1ZjFLZzdVZWtKZVVWR0V4a3NPNVh5ZXNoU1RRNVo5V2tr?=
 =?utf-8?B?dmdMWnU5YUcvZ0hRSmQzTUFUc0Nvd1VNdFllZFVaRDdReWlnT2Fpb1ZvZkVG?=
 =?utf-8?B?ZEl5UW9FTWx6cWJIQXBiWlVNTG13bGJmYVFOajhQWlVsbFNTUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3c429e-66d9-47fd-0a74-08db68fc218f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 15:13:50.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg9Y3LdB42Eq1+kEALYd0hKxNYVHh3U6763fXGi05G2CJRGSVkWu8BSrqOcAkO8EBORhfhmdpt8TcZejcFjLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7161
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:33:26AM -0400, Demi Marie Obenour wrote:
> On Thu, Jun 08, 2023 at 10:29:18AM +0200, Roger Pau Monné wrote:
> > On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrote:
> > > On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monné wrote:
> > > > On Tue, Jun 06, 2023 at 01:01:20PM -0400, Demi Marie Obenour wrote:
> > > > > On Tue, Jun 06, 2023 at 10:25:47AM +0200, Roger Pau Monné wrote:
> > > > > > On Tue, May 30, 2023 at 04:31:13PM -0400, Demi Marie Obenour wrote:
> > > > > > Also, you tie this logic to the "physical-device" watch, which
> > > > > > strictly implies that the "diskseq" node must be written to xenstore
> > > > > > before the "physical-device" node.  This seems fragile, but I don't
> > > > > > see much better optiono since the "diskseq" is optional.
> > > > > 
> > > > > What about including the diskseq in the "physical-device" node?  Perhaps
> > > > > use diskseq@major:minor syntax?
> > > > 
> > > > Hm, how would you know whether the blkback instance in the kernel
> > > > supports the diskseq syntax in physical-device?
> > > 
> > > That’s what the next patch is for 🙂.
> > 
> > Hm, I think we should separate diskseq support from the notify open
> > stuff: it's possible a different (non-Linux) backend wants to
> > implement open notify support but doesn't have diskseq.
> 
> I like this idea!  What about having blkback set diskseq to zero?
> Userspace could then replace it with the actual value.

I think it would be better if we used a sysfs node, because blkfront
has no business is knowing whether diskseq is supported by the
backend or not.

xenstore should be reserved to features exposed between blkfront and
blkback if possible.  I know we haven't been very good at this
however.

> > > > Can you fetch a disk using a diskseq identifier?
> > > 
> > > Not yet, although I have considered adding this ability.  It would be
> > > one step towards a “diskseqfs” that userspace could use to open a device
> > > by diskseq.
> > > 
> > > > Why I understand that this is an extra safety check in order to assert
> > > > blkback is opening the intended device, is this attempting to fix some
> > > > existing issue?
> > > 
> > > Yes, it is.  I have a block script (written in C) that validates the
> > > device it has opened before passing the information to blkback.  It uses
> > > the diskseq to do this, but for that protection to be complete, blkback
> > > must also be aware of it.
> > 
> > But if your block script opens the device, and keeps it open until
> > blkback has also taken a reference to it, there's no way such device
> > could be removed and recreated in the window you point out above, as
> > there's always a reference on it taken?
> 
> This assumes that the block script is not killed in the meantime,
> which is not a safe assumption due to timeouts and the OOM killer.

Doesn't seem very reliable to use with delete-on-close either then.

> > > > I'm not sure I see how the major:minor numbers would point to a
> > > > different device than the one specified by the toolstack unless the
> > > > admin explicitly messes with the devices before blkback has got time
> > > > to open them.  But then the admin can already do pretty much
> > > > everything it wants with the system.
> > > 
> > > Admins typically refer to e.g. device-mapper devices by name, not by
> > > major:minor number.  If a device is destroyed and recreated right as the
> > > block script is running, this race condition can occur.
> > 
> > Right, but what about this device recreation happening after the admin
> > has written the guest config file but before the call to (lib)xl
> > happens?  blkback would also end up using a different device than
> > indented, and your proposed approach doesn't fix this.  The only way to
> > solve this would be to reference devices by UUID (iow: diskseq)
> > directly in the guest config file.
> 
> That would be a good idea, but it is orthogonal to this patch.  My
> script opens the device and uses various means to check that it did
> open the correct device.  It then passes the diskseq to blkback.

How you do this with losetup?  I guess there's an atomic way to setup
a loop device and get its diskseq?

> > Then the block script will open the device by diskseq and pass the
> > major:minor numbers to blkback.
> 
> Alternatively, the toolstack could write both the diskseq and
> major:minor numbers and be confident that it is referring to the
> correct device, no matter how long ago it got that information.
> This could be quite useful for e.g. one VM exporting a device to
> another VM by calling losetup(8) and expecting a human to make a
> decision based on various properties about the device.  In this
> case there is no upper bound on the race window.

Instead of playing with xenstore nodes, it might be better to simply
have blkback export on sysfs the diskseq of the opened device, and let
the block script check whether that's correct or not.  That implies
less code in the kernel side, and doesn't pollute xenstore.

Regards, Roger.
