Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA475686B88
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBAQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:26:32 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142ADBCB;
        Wed,  1 Feb 2023 08:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJAq2tAQ4vqzxOG8iRfE/+EfFzdbVLe1p+KuLgAonFUNUCIUe4ruMzN4RfyZ+UPqTehOCfabt01dKOl0JqNsse8FyWqNmBkbfjPFww3ClCW7VoYFjdyX3bTQ6aCPkU+8M33kd/f6VpUwpA/A907XM/s/JB+VnVh8dUit0FElfq43YGE56byJxh3uLgBnhrSZ3BoB1XHCNY9V0VU/hbVmagvn3irgh0ztM8q17pFCHPXGNTclA+2gHmTBjA0fb+dN5dk8xbA6dhUhAgX9Wdt0KltRF7+dKeqw8GSDGkyWSPnDslYaddO0A8yPtab1HOIxYB70rWfKHUvkRwZEYXsevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYzAPkjNT2aarNgDOfP9UhLHkpKML1PAggomdBMIHDs=;
 b=HloTgGgRDE/lf3lj3vxd/P6JCmnkFkdx4FKdZAEU7ki+vKcThfVJGYpqN6GcL8OH7pX4TTBJZ8gvcfUVXXNOdIahtywr8eN1SkKSzKDOAjZluszn8lj9Oxk0wtmx1kOaLjLbNhpGJEutnjEsKKCkXHamAk6DKr9wEvn5HhZzN5J97jwHFN4mOYKe5k5Db4V2/ffsnOahOU4uXne++wnH5SGjercR2oQLhm3WVXLvIhNzmip4kvPhEZQ5g2dI54n09WxTEyl/uAMGr5JReLVCP/iDwtTLoFR2FPuYDj5ctgOCVypdPmUmyicKYV/PYKIRa77ZVD2g2biz3LYD6E+3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYzAPkjNT2aarNgDOfP9UhLHkpKML1PAggomdBMIHDs=;
 b=dIAW/QTy4r235VIWJFsldiOyMUbPkIIdeTeOj5lZj0wCvNZhVVHswg7UEr4YesmtnUh640dIljGfI+oM8F+KUcu8iKKu1x65ohmgWXLKSJOocX6ln2Jio+ZEF5toNMhOuJIAVar/1RzOK6XNqWybkP0RZgL3WVWjja66XTEVAzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA4PR10MB5755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:268::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 16:26:27 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 16:26:27 +0000
Message-ID: <b58f5e31-f13f-6d90-774c-2017ee3de121@kontron.de>
Date:   Wed, 1 Feb 2023 17:26:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230201143431.863784-1-frieder@fris.de>
 <Y9qQHpySbrFcBB0P@mail.local>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <Y9qQHpySbrFcBB0P@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA4PR10MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca87749-364b-422c-84bb-08db0471118b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qyZzxZGgFVaMSdBQWsH73PkW3WRz+gqELLw2vGMNstzJlIt6SwCCjFtXIXQ1Spu4ioBATkxxsvPVpEvdmh94NrQsWJFt0spYyTa5j4FXqWjFr9V3yfQZV4kXpy7xm5PAFU0Y69joDxi5SgNKn46a5rPCHNbAFVk4xKHJLuzTqbWhRJnSRTCLZGUzUUnH3SgFiJh18kgiV31rIMYqUoe3yACsxexyAEm7zYntq71meY2+HAZVPLCaXq8OQNLyYrChXk3V6kDAQW47pL+LR8g3tlODXvoVB4nOf8wR8r+/IOuNYTSTcRtGDRsKsh8kAa0wmjUNYr3G5pbhoW/JqOSwQd2NavMLkiegPZRX7JDRTsjRpFbm/aQbtaU4gZfHJ8+plirUMEbiRbabmIm3fmgvQRrrBaAmMsCLdNKuwOXdyZ/84CWgj3MALyar7bFDUFtw7m71HphSUGEzBh9iSuGyc4sMRSojwTcBEBpDFDnSPXTo8kYFn6XOKXBC7Xu7FtLSK/x0u5JHpeMLyPVObRsY1XC40dml+jee8H11XY3HwRQmEkdf0Ufg7FyPihjVC/swoEYh0iqlfDGcH3vJWkQ42+oleNh68UUHtIaJ8GtCfzVNC9c8gHEj8iqQCSBrjlC92M93wC3rnug1X5QWC4wn50tW7u+J5wD/UCvU85IVJZ7tDFnMAIjcaDBNhIpqszzxFPn/bQZc8qWaCm8LOkw0Nkghn3ohbJEbT5EtzIQ+gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(8936002)(54906003)(6512007)(41300700001)(31696002)(86362001)(4744005)(7416002)(44832011)(4326008)(6486002)(2616005)(66476007)(66556008)(66946007)(38100700002)(316002)(8676002)(186003)(5660300002)(53546011)(6666004)(36756003)(478600001)(110136005)(66899018)(6506007)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHMyN3M3ZEVWR2llVFZNd1RZQWhDTHBxVVQxeEY2cFdmQkh6RGQ5QzUyUmY5?=
 =?utf-8?B?SWhhRGdPR2ZnclFFbWFOdmR1SUYyeTNpTjAyT05HZ1BHYWE3MWFGbFRGVUdT?=
 =?utf-8?B?SlRuZ3FzRDBIckpuSS94bDZxTlJoUzcyMGl2c3lDcWRrVnZacTRCcUNHUldt?=
 =?utf-8?B?MFdYVmNGUURQK2IrcTFSUUNnKzlOUVFqbE14d1RMby8ySGdPWGFrVzRHTHBE?=
 =?utf-8?B?d0pUVUh3ZWlrVm9jS09veXlhSzFMaXFjd3kyTmgrNFZHU3p4cDRGMW93Y2ZB?=
 =?utf-8?B?MFhFLzBYT29zSlB4VFVaZytNMlczSXlTM29qa2ZodVdnMlh4L2dmWkhKcUpw?=
 =?utf-8?B?N1I4cGxnTjhsT2FLZjBWOEZmRE94Mk5UbkRSSUtEL0dwcHNzeTZpa0k5Rktv?=
 =?utf-8?B?TU9RRUtxZVNOMWtkeERYRWdkS3Qwb0JZSldrUlBMcHhhRGFyclg0QnVaUlN1?=
 =?utf-8?B?alRoMG1uMkg2ZC9MSHhtdllESHRzdFZuOG9yN3hZZm5KNWxyVHJLSlYwMk1E?=
 =?utf-8?B?OWR6djJlRHVrN0YxTi8wMlhjWm9Ra2NlMXp3c05qNnlNSnhkNS95eWxJNnZv?=
 =?utf-8?B?WHFJNXlkbmF3WU9lZm16SHhVaTl3U29kR3ZqOW9xbk9nT1hnOW5MRDU0NTBk?=
 =?utf-8?B?SGZFUUF0V0pMQzhobE1SZktVQjZaM0V4Ulo4dmF3M2Fab2J6YWExOE1rRkdX?=
 =?utf-8?B?RVJUY09SaG1leGNQRjBYRzdNVk9mWGJJWC84UjNsdEM1YWYzZmkwbkhkQXI5?=
 =?utf-8?B?YWl0Q2YxbkFtMlV0RzZ3ejJkS2UzNUhpdXRkcDdEbGZXRHNmdVNBd1E5aE8z?=
 =?utf-8?B?RjRGTTBFQmFFNGtwbHgvLyt3TTRiSElhMUY0b2JwalpXOStYRUhzR3dFVy9m?=
 =?utf-8?B?MWVrS0NLTk9RbmNOQmtIdVFlRjhDMllIZStMV1NZSFdVZTdzZFBGK3ppdHNR?=
 =?utf-8?B?Ym9uREUrODNkZ294YjhuTkhnSnV2bnp1QlZ3TytTU3ZTVDFSWDFjb1pncFRn?=
 =?utf-8?B?ZVRjUkdLZ2VWVGJUQlNVaHBYYWNIelJmR1lkUU9PaFdPYitiWnRNTGpLQzNN?=
 =?utf-8?B?YkR2d0p2MzNVRko5Q2NXODRMWHI1Snl1Tnc4OTJKZDhrdzgydmFCNGV6TS85?=
 =?utf-8?B?bzZGVWFhZ3E1UnZvNlpmcGdnbVhCcDBvUWdGZ09zeFpIWGpBVDdPVldFR3pn?=
 =?utf-8?B?M3ZHSG56WGsrcWh4SytBNFJqVEI0UjVuQWpidWliRVJMdms3eHBOTlViR2FZ?=
 =?utf-8?B?U0hwdXZZdFZqTVh4OGZEREVFRExCQjNUeS9oc3JFcEo4UjR2NmZoQWhReWJl?=
 =?utf-8?B?Tk0yaWxROVFXd1dIb1RjQkdXMTUraERhYnY4bXVrVUlQcFpPWGp3Yi9MMTBi?=
 =?utf-8?B?ODhtWm8wa2xnSkFRQThtVVFZbFN0bGp3Ty9OdlNMUjVScGxNZTg0Vk9wQXUr?=
 =?utf-8?B?UnEvYlpGUnlCa292U0ZFak5SanpaTHI5MzZOUGFGbTJzcTdVd2RNQW5iV0xi?=
 =?utf-8?B?TXAyMzNFd2E4ZC81Rng2T051bU8yZmVGRTZtcWJET1VUYmFDa2d0MnF0NW1q?=
 =?utf-8?B?dllDWmR1VFJEZzM2OWxSZ1Z5TGc0czhIdEgzS2xSbTY2bFZ2SktTS1hCa1gw?=
 =?utf-8?B?cmowL2tZL2dud3hMSG1EQTVhUGpGVno5T21qZGwzMHVLekxrZnhoSldoQXZa?=
 =?utf-8?B?N3VjeHZMdFd5dnk2N0FoMHBnZkNBN3VLQjBNMGx4bEZBWE1CM3BOOWdCbUN0?=
 =?utf-8?B?elhwem5kSFRkZnNUVk0wbTZrMTVDdUxMOWQvSWQwNEFyaEIrZ2ExUTZ4M3ky?=
 =?utf-8?B?TllIZWxrU3Q4UXpWWkpNcitPd1VBQXhsbVIvUDBndzlZa056aVBkRU1kODhT?=
 =?utf-8?B?dUhLVWk2c0pBdzlqYlFLVFAwY3NEdWNBY2k1NHJxa243REEwY1FaT29Ec3JC?=
 =?utf-8?B?cnQ4bHFMdWhUM1dEKzlaVnJ6MURMUTNvR3A0RysvY1dkTldZbmhHd3dhaWcv?=
 =?utf-8?B?a1hBUlNTd3VUcFpLVVlKNVJjODBiRFZFQkpZaGRMS1pxeEovS2tMcjRKNFg0?=
 =?utf-8?B?ZXZWdk1NdngzcUZDOGdzOW82aGNtUndIZWsxNVNZN3NRK2tYWDNiWlRkMWt1?=
 =?utf-8?B?eUVTWG0xRjZOVlQyNUM4N1czWWx3eHRNei91dkpPYnNKY0VFRmdqaFQ5NFpP?=
 =?utf-8?Q?9nv2fJTqK97chxCWBZWx47g71RnDIBYXf0pieCyu646D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca87749-364b-422c-84bb-08db0471118b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 16:26:27.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgzPflKM0QW/jYI2Bzrys9lj1uC8h8oSln9YrG+fH2jFYkH3l8Gga+q432yeE772I8sGd72f96OS0AoRCn3NL6xSf1v2EHzvwrI8H+btolw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5755
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.23 17:15, Alexandre Belloni wrote:
> Hello,
> 
> You can't do that, this breaks an important use case and it is the
> reason why I didn't use device tree in the beginning. What is wrong with
> setting BSM from userspace? You will anyway have to set the time and
> date from userspace for it to be saved.

Ok, I was already afraid there is something I missed. Can you give a
short explanation of what use case this would break?

There is nothing wrong with setting BSM from userspace. It's just the
fact that users expect BSM to be enabled in any case as there is a
battery on the board. It is much more effort to ensure that production,
user, etc. are aware of an extra step required than to let the kernel
deal with it behind the scenes.
