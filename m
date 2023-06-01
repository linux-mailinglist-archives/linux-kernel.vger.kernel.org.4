Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0871F15A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFASGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFASGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:06:15 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F0199
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1685642763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0zFMCXucLysOYa0FF0t1njk1seLv5p9jq/CettK7p34=;
  b=B3A2SXc8uysUaluPPtVkutUJ5jw5/xJ9E6slGdALFetrZ/A5/XZ5CVeG
   jRYX2/R2EPmMKaPFmc9ckaxPanpR5CNCNSuJxyTHvkWrLGoocgvkmsXvn
   77ax63XYvV2cthz1cfqj+bV3TYsgjboBG8xoWiLBUKsZfLf6xxiaObEtF
   s=;
X-IronPort-RemoteIP: 104.47.57.177
X-IronPort-MID: 111673884
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:00/djK1yPK0rR4PlEvbD5dNxkn2cJEfYwER7XKvMYLTBsI5bpzcCx
 jAXD2rUOviPYjaketgga4m29R8BvcXVx9IxTAttpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8HuDgNyo4GlD5gJmPKgQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfOjoR6
 sMoNW00RDODgu6H34niQ7Jtv5F2RCXrFNt3VnBI6xj8VK9jbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvC6Kk1MZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXqiAdxNT+3oqpaGhnWy+S8JLDhIdGK0rN6o0228Qt92F
 GAtr39GQa8asRbDosPGdxGxvnPCvhcaQNdWO+w89AyJjKHT5m6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq15rqS6D+/JyURBWsDfjMfCxsI5cH5p4M+hQ6JScxseIa3hNDoHTD7w
 xiRsTMzwb4UiKYjy6q/7XjDgjSxuoLOSA8loAnaNkqg7wV2Y6a/aoCo4ESd5vFFRK6TVnGIu
 HkJnZjY4O1mJZ2EiiHLQOwLB7yvz/KENiDMx19pA5QlsT+q/haLbdAOyDJzPkFkNoADYzCBS
 E3cowRK/7dIIWCnK6RwZuqZAcMwzLOmEs/5TPfKddlfSp9rfQSD8WdlYkv493jvl04hioklN
 JubeNrqBnEfYYxkyzysTus10rIxwC06g2TJSvjGIw+P1LOfYDuZTOkDOV7XN+Qhtvrb/0PS7
 spVMNaMx1NHSuribyLL8IkVa1cXMXw8ApOwoMtSHgKeHjdb9KgaI6e56dscl0ZNxcy5Ss+gE
 qmBZ3Jl
IronPort-HdrOrdr: A9a23:HmAbsKA8Bb4N6pflHemH55DYdb4zR+YMi2TDtnoBLCC9F/bz+v
 xG88526faZslkssQgb6Km90cq7MBHhHPxOgbX5VI3KNDUO3lHHEGgI1/qA/9SPIUzDH9lmpM
 NdmvhFY+EY1WIK9voSOjPIderIHeP3l5xAWd2ut0uFkzsaEZ1d0w==
X-Talos-CUID: 9a23:jn5zD26q/h9WlVyypNsszxVLBf8VbyDk5lTQJkOJFl0wQeaUcArF
X-Talos-MUID: 9a23:3jdj+QuOExBAK4GFys2npQ4hLuNNvYWXB00qgMwludCJHBNcAmLI
X-IronPort-AV: E=Sophos;i="6.00,210,1681185600"; 
   d="scan'208";a="111673884"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2023 14:06:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELI7ns5NGdVDGPhvN2kGrigykKbza1J0ZRAjyrpY7zIb9+f2JlEv4r53fM49yMIaJUmgckraAh+8sBJI9gzZGmD+kNfO3qgfQX/Tk9nURIH0pO5rx08CRupIWGrXLJ2Vg7e7u0Hypj72S/l9ju1ykgAxT7K5YVIfubERFxNzan8CgCh3xJY+w70oSVtJxr6Lbz1rtgR8+l88d6hg4HdV64L12rpc/Pct0n2KFzNYv+NdNOPK6ZxYyKf7+Xx8GK0oQey3RhXaV9ml2d1JBFHUjDof7QtdlqD5LOBWHQCT/CydqpQSufUcxz6490k89JhwLoIi8y30fDRfoyQ7dQ0P5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi7uD2ND6XW8mRc8inwQz8CFapHmqDbZDow354ZJhg0=;
 b=ItIKHk6CJ/hxpZ6IfcyPHI2/vbz6YCM2wAg1fzhThebRMV6N8RpJZGP9/KtXMwfD1gjQqul5zvIX5r1/wiaofDk1WLL94g+IJWnGyWHP47tHXndpzbhkbyAEZR8jpcNRjYU962d1yxUl5D/C8EWWc8bbV7etAkyN19EpWGkZd7wdKTwS7EoXI4dZAn4WPjCbt3QOl970T+5hSwWtSpiERyX5SuJZOOfvwBZ+lTorYlXvU9b3E5feXdBf3CvRAwtqkNxXrMCVNRLsRNf9gKbzCaUfZEZ/7wQ4ucHTcVGCofW3TgAv1bD1F96JNyOgoPuBzTpMgV0VCnbmFDp0p8xiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi7uD2ND6XW8mRc8inwQz8CFapHmqDbZDow354ZJhg0=;
 b=lW4w+HBVR8KA9yql4FbzuSBKXLER6GzhH7xPRSrQdzN9U8/NugH3X/vCNihB7v8bncGLCruer7haqwXzdLhlHl1I3fSMGMh+SVxbt8a3FKiVa7JavVxsaBrGewbdQI+1qp2qVuWPKU/2zJBHxcPPELTHBMQpjM6qKW+CUrO82xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BY5PR03MB5169.namprd03.prod.outlook.com (2603:10b6:a03:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 18:05:59 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::10bb:98bc:e36d:36ab]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::10bb:98bc:e36d:36ab%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 18:05:59 +0000
Message-ID: <5d1de7cf-495d-18bb-d4c2-227d9182a0e9@citrix.com>
Date:   Thu, 1 Jun 2023 19:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-GB
To:     Dave Hansen <dave.hansen@intel.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
 <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
 <b6c4347d-bd03-0332-c4a9-9d2a11f17a6a@intel.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <b6c4347d-bd03-0332-c4a9-9d2a11f17a6a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BY5PR03MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa203f6-712f-4f34-b66b-08db62cada11
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wv5Ia9cOKCrDYsIderCc2PsH9N+IAFgpVtrAwo27OrTwXGI/lr/OPpaIHly4wU85tYsTngup7tuKbhL0XtVGFenrNIr64O2Rw8hrM4bAQvm0EsS0MQ5DkRH1Li6Jl3MHHttQqBYsJApKScm0rIJhx3vG+fduyWyvR8AskT7FlnOati2glIEY/9wUcJSZtYlnt7h8MtwwWbkL6qGltCE03/Ux3T1orV152FLJOJ4e7zFPIhiEuVdRiwDx9NeqW27alf6N08C3mkC9+iW7zDu1JCoO95RYIMkYCMgZOmmLjfK1PRqdEr4SdZ/dwDqrobAmN74udRZSChAV3k7pM5Fsr4VyyNL7VU7+M1MT4liTwc/bHJwg4cygZFoavK5xDrfoMmnv29Q3xA24seZ7hfQzVSQ5ZnmiNmTEVc3pCy/FGCsKaX8eurs0Msz7uGJ1kaTZ5pvNW7ESWLXzpQaAQ4TXNIzfwTFwZ4q9ZRxWL6yI7hF9h44LswT91c1qmVIH7aMkDvFk6k5sj9mCCGr+5VnV6joy3TgowZxWTyIbxEHcqeQFQ/LW7/AYiqN+EhJYP8kaUKfLPlMptmih70aYsDIL9W3pPu/bM7reg6nCE0lcZoB+qrco4VUJip5ixiSnhJmkFSDOP1K568jwbrFzsCriDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(36756003)(2906002)(31696002)(86362001)(7416002)(5660300002)(31686004)(83380400001)(6666004)(6486002)(186003)(6506007)(26005)(6512007)(53546011)(82960400001)(478600001)(110136005)(54906003)(66476007)(66946007)(66556008)(41300700001)(4326008)(2616005)(38100700002)(316002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TER4Wkk0WUsxN21CRlJvayt3dHZHQnJvdkVlM2RyUnNQeTlMWDVHOHFXUExl?=
 =?utf-8?B?V05JRnRnTUx6ajQ4TFd0a2NzcWhBTkVxQW1oa1JlbW9iZWU3c0ozVGhsOStZ?=
 =?utf-8?B?WmdMRUdVVjhydnd2UHF3UkkrS0tTL1NwMFh4eUxncitWUkRMR1hNNThEWWU2?=
 =?utf-8?B?aVkyZFpab1RyNUY0bTE0eEFVZUhOTXFWVktZZER5N1RLRTRMdmlGMVBoMGZ6?=
 =?utf-8?B?YUJsSXJ1WWEyWnpNRmRmVGZFTnp6QkoxdENKRk11L1JFbzkvZTlnN2UxamlY?=
 =?utf-8?B?STJKb0JMcXdXQnNzYlRTUzhXTGdJcTNYTDdtWE1OOVRMdkEydnBuTE9nb2Zx?=
 =?utf-8?B?Q2UrMDdITWlvWUpRcW5OTFJyYVZXTFoxRmRWZFN2RXhEblE5dXUwUVF4eW56?=
 =?utf-8?B?MWZ1RExRL0NpbXZNSFp6bVBFeGhsbDVRc250dXZqM3E0K0p4RHFDUHQ0THBW?=
 =?utf-8?B?enNYczRtQW9kVitOaFpsUjVwRXlRUUtVNmJ3WjB3K0RFdXliYWhmUDJxYWY4?=
 =?utf-8?B?Y1NqakpncGlndHhsT1RwWmVxY3FMZi9RZDRHTUpkZ0E4dm9hTTh4dVJYMkxx?=
 =?utf-8?B?dFl2emFQVElzNmJrMkIvMldxTWZqcFVOSEVLejNqL252QXN3ZzVFeTRMdnlV?=
 =?utf-8?B?a1pDN1Bydy9ZVzg3b1ZpUGdjaVVUZEZIZW9KcFRUVWg4M2YyTHh6TkFwRWxO?=
 =?utf-8?B?YVhCTlVoaWlvTnZyUjYzMEhlM2liR2VwWmRLQjBac3VLUTdaWGRYakJqSHZR?=
 =?utf-8?B?QnVjR2tiSE1wZnExWTByek9lMkdldGMxVitkTGd2TEsrT2xIcDNwdG4raVdE?=
 =?utf-8?B?c1BZNXdxZ1ZXOUk0b3FhNGV0WnBqWWV5Z01GdGNMNVIxWFdNN3dBeStFbVda?=
 =?utf-8?B?ZUtkZ1VycGVLTU5uRGdXc3JWV2hSYW1hV1ZpMUFqRW1KUG50eTc1YWRoSVJO?=
 =?utf-8?B?aDIxS3RWckU1alpJRUhPTlp6Tkc3L1c5dnIzK1ExZVdobFlubThKK2hTanhE?=
 =?utf-8?B?bTYzaXZxU2Y3Yk12ZldBNDZ2aWlTblF4aUNxZXBSaXVib01WZlM5THBFNXQz?=
 =?utf-8?B?ZzNidXRRa0pJRUYyK3BhSTJEMjA3aU9KT1gzSjFKRStUdlRGdTdZVUFqSlph?=
 =?utf-8?B?NkxkbUxNODlUbzZNOUVheGxJOUhHRWt4M3JWUStPN1ZnOVYvMTd0VFdjdERZ?=
 =?utf-8?B?dHZkeFM5cThMaXR3SStsckF6QS9FTU9tNmZLRFNkc2hTek96cEtjUzZ6UmZo?=
 =?utf-8?B?VFQxNFk4dXNHdnBoczhNbFp1VDIwVlZBTFkweGVBRWw4K0FzTllJckZGQVVJ?=
 =?utf-8?B?bVh2aUNUWGw5ZCtRK2xLVlllZzdFbm55SU1OQW5GSzl4ZEpDYW5zVmxTdWVD?=
 =?utf-8?B?SVpGK0s0eENhcEJ6R1FvVS9mRnFrMUdZMVd4YmpVMDJGdFBWcERjQUYxOUpU?=
 =?utf-8?B?SDI3aHZ4QlRMcHhqWm1JaWorbUd5d05DZndDbzJJZjFUR0sweUZCNk9pUGZz?=
 =?utf-8?B?Z1BCbmp0UnpQT3IwR0UweUlLd29ocEJMSFk2T3hsOHp4cTczRFI4azdBWjdv?=
 =?utf-8?B?L3I2UDBqdEIyY2FVR25FeHFsSEwvbVFBK056TE00RG5iQnBZV1B2dDZoUjZR?=
 =?utf-8?B?VytRMGZTeGRoeXdTUGtXWHZKME1NUWRYMEQ2Zkttcy8wb3VEUTlLK2d0VWlx?=
 =?utf-8?B?RG4yNnp0akRnMkQ2TTN4NFJZa2Q4LzRPeXdmM3hOdENNTUJQODhLRFR0SXJi?=
 =?utf-8?B?UzF0S1dYbUFtMldxdXBncUFKSWQ1eWFVdkN2MXliWlhFSExHZE1kSWdpLzVs?=
 =?utf-8?B?bEdmOERFOXV3ZjE2RUQ4ZWxhRTRaZllnZ1VXejZIdmpaL3Bmd05UMzJkMTBl?=
 =?utf-8?B?amVVK29oeDNybitZOFpLbWFaSTdmSUdtVFQzSzdkVVN5aWhvWWlHcnIxZmlv?=
 =?utf-8?B?SUs3RUhKS2MrQlpEaktHOXBDTHplbjdvM2ZRcVZWa2RrTzRMS0Z1ZXkyOVVU?=
 =?utf-8?B?bmRsVy9GaGcyRTFzR3hWcDF1RXpKc0d0czVYQlU1ZEJqUC9QbUdUSVdSSTdk?=
 =?utf-8?B?YUtYT21leFJxbzN5c3pTVVNSeFNROTRlNm9MV3B1NmJzSzRvSnQveG9CNXVI?=
 =?utf-8?B?aWVDOXozcWE4aW1BUTFicllXdTlGeXNiY1lwMUFiL2Y3cGdvMndyN20vWmt0?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUdkeU5OQmZLRE42Y0o0MU50d0FUR0V5QkhhU3NTVmZhcEhVbHBXdmNxVG9q?=
 =?utf-8?B?T1NRQTVNM1hPbCtVendkT3l0UmdWRGJONnorL0JSc09sa1MrWW5kaDJBSmVv?=
 =?utf-8?B?WkRXQVJzQkZOTk1OZy8vc3V1VVZzSjhiU3ljbkJOUjJFb2R4NHpyRUc5a0J6?=
 =?utf-8?B?YmZseFhzV1hRK2w2T1lEN05mSzVodTg5QTlzdkJYV2NnZTBESGd6ZURxdXE5?=
 =?utf-8?B?bGMrdUlTZkF3VXppRXNacitzYTdCbVpwcTNsT3ZWbHhUY21HZWMzRHFteUh2?=
 =?utf-8?B?YzQ1Z1NRdHJROThqazZiME5iSVBYd2kyZ1Vjc1ZRRldHSWVkSHJCTWtiTXJk?=
 =?utf-8?B?WUg2MGI5SGdvbEg4L2NIdzhXNm9pam95b1pYcEk5NEoyaVFTOWZ4WFNrZnd3?=
 =?utf-8?B?M05IbnZwNXV6dnovUGY3Z2x6dEtkVTloc2lPRG5mMWZsTi9kOU9QR0cyZVRK?=
 =?utf-8?B?K1BFSERveDM4a050eFFpMkhWRWIvMkU0QmxFVnBSM3JUclU3cnlYZXFYWjNP?=
 =?utf-8?B?amhqb0N6MXBudmRjT0FUaXB1M1pvdCtoNTJib0xrSWZPVktORjZmbUlsekg1?=
 =?utf-8?B?dTFxY2JxMUk4RW1HcWtjSS9JK1B3WENVTVlac3o1aTIyVkF0SjFhSXBzNzV1?=
 =?utf-8?B?U3pncXk1R21XMVJpbnRldHFTSmpkdURxa2xCZGc5R2FvaTlWdnVEWUtmdjNZ?=
 =?utf-8?B?QjlXcnVVci8xdTFQWnUydjdjaG5XeU5TWllndTBIbkh2THhOZDdPWXZWY2JT?=
 =?utf-8?B?NFBaZmE4ZXZhaTBhbHBDM1hBa3ZBaVBINWx6WFU0UDBkUmI2bVdZVWlid1h2?=
 =?utf-8?B?OENuZWs0MUduU1R5bVR5Y2c0eTZ0RnhxRDluWm84S1FSTkw2cGlzWTMwY2VC?=
 =?utf-8?B?RTRRYml1UUxSNkViQ2V5RnZQUVZWeXZRVm9DSXNQZEVWaDNQb0QvajFwc3dv?=
 =?utf-8?B?L0pmYkRvRkVRRnUxMWZYd3M2ZjF5ek4xL1JaUDAxV2JyRHNGVW56SGtlbSt0?=
 =?utf-8?B?ZGhMejlpS2J0enNZd0h1UWE4Tmh3SmM2QXhjeng1L205WndNMXJWaisrTGVS?=
 =?utf-8?B?cGptOStHNlg2RmNKUkZidWUvOG01Vjg1TVZGdW95U2hNMDkyUFN4RVdqRWJj?=
 =?utf-8?B?blZpYTFNSnVVTEF4RmFhTmcwU1pIcGEvUUN1RHorTVJIc2htSG9VNXFWOVNS?=
 =?utf-8?B?ZmV6ZjA3b1diY0NiVjB4R1duRkpPaVNhcjQ3aHlTVWNUM2V5TSttRmZ3SUdX?=
 =?utf-8?B?NHNRL0ZSeXBadkVJb2E5Ujk3OHIxMzVWRFlBTEZJNjN5MHNBZVRvc2tRYWZj?=
 =?utf-8?B?OHZhQVk0SWpBbFYxcTJBM0xXU3d3elhOcitRaHNPT1lidnBFbnJVUXNFZDlr?=
 =?utf-8?B?Q2ZPVk9qMEZic3dlUFpSMkNjK1dYdmprSE1RTjJMbTMrRTVkWk9MUCtkNno3?=
 =?utf-8?Q?4C5OG9Wh?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa203f6-712f-4f34-b66b-08db62cada11
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 18:05:58.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH33+koBq382yyUXjXguNwGkW0A1bHcUaWLZRke5lMKWxIanF+vMWKAKFi93h1RuNBnSIUWb72eHWaE3tohjGHTYiSaSDHfez0ieYraPZn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5169
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 6:08 pm, Dave Hansen wrote:
> On 6/1/23 09:57, Dave Hansen wrote:
>> On 5/30/23 08:01, Ross Lagerwall wrote:
>>> Since firmware doesn't indicate the iBFT in the E820, add a reserved
>>> region so that it gets identity mapped when running as Dom 0 so that it
>>> is possible to search for it. Move the call to reserve_ibft_region()
>>> later so that it is called after the Xen identity mapping adjustments
>>> are applied.
> Oh, and one more thing:
>
> What is the end user visible effect of this problem and of your solution?
>
> Do Xen Dom 0 systems fail to find their boot iSCSI volume and refuse to
> boot?  I take it after this patch that they can boot again.
>

Yeah, this isn't as clear as it could be.  In short...

The iBFT suffers from the same problem as legacy ACPI RDSP.  You've got
to search lowmem for a magic marker to find it.

Xen dom0 is just a VM with root-like perms.  Anything it wants an
identity map of, it has to ask for.  And because dom0 is commonly
sharing ownership of hardware, it requests identity mappings for
everything reserved in the E820 table.

The consequence of not having this patch is that if you try iSCSI boot
under Xen, dom0 can't find it's filesystem, because it can't get at the
iSCSI initiator.

~Andrew
