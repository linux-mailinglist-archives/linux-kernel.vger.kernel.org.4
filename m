Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0746FF1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjEKM7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKM7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:59:00 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51361A2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPxNY1jlqelXoPDTwLrGGPamC9LRtN6/zrGDm8fqGsgpz/14cSwaXye0lFGlVQFxJnSAIHu51lfPOgyfzY2qOciOdE0LroJX/eQUHZw6Jhy0Vn5tBJUdmgo1enkOGJVEARmHhIY3L1U4R/pFJLtFNnDP2vnetcw3tVJVN9ufas30XTZcu9E9EpMLwkN7rIUA2agZQ6973sdVKyiY8++feId9Ot4BAM9vHg57TzLwLREDsp/L11zX2CdDZMnPyGryJxFU2gTRqVOlkwzOdBN75sQKnor7jWeC2B1QvDifyG0jUhEVa1vvzXHJ8DDfqTxXZYkz8027H8VitxCaYakTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGH/t2+W+91Q6hF9IFpxlUyLAxQjfTM6o00Lae05gfE=;
 b=VKmtYkT7rAk9dnv+kFyKlQblIjjQDd5MJUanZdkzhXHrEJ9AsekM/t/GBJ7uTKYjVOXKYRINyMcOeqQ8nOSb7U7Ij434tY3oMbWEyBdBPRq131DpvGzWXBXlVKRPkeM9P6fKPOWKZ2jefnmp3SIep7851MKdXa4Tb6Kp4CI0/aQmqhIfKHsU8CqDLakV/TEaDFV13S+Nk2GhWX0fi9e+jxbY9Pz8VKmZQgc/oaNQcektIq35LZ5YfkymOyvahrh1XRx0Gjvrfe3JbRac0XhqaeyzlOtKBHDRVc6dC9kvSb83zCz6I7TXmiXWpP6rhc66PTI41s8OuI2mHecZr37NVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGH/t2+W+91Q6hF9IFpxlUyLAxQjfTM6o00Lae05gfE=;
 b=ZB36MNd95vdOqtr9/6R1+UFv/ZYmsDWHbwQOOESR31znFhFodvkxIrqx7JpxWTpAZ60ZfZln4Ezs2piyfzDul6rRg+eM4a3uTai/2T3skWS06zlXQh6XJx81GTpNpR4Aq51luvBqTBBAc4Y+Q4n0wadN4eZWETj0cifi177ciiER23k4+UQNgGUYvyimOSE76MGTmJ2vtE7HtOfDKOvAIwdGlqDLn6PHNV0J6iHmMhGXxF00RZytle9MWx5zPFDnj3j6IvHkkQI2LZEJczQ7k8o4vTtV54K147tk3dKJOw3ux87QaJoXJ3JJh0CLeuu+oLwELBykqqU3MDtyNi4bYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB5703.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 12:58:56 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec6b:bdc6:10c5:ae86]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec6b:bdc6:10c5:ae86%5]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 12:58:56 +0000
Message-ID: <7d9582ed-227a-7ca2-19eb-76eeae3d0662@siemens.com>
Date:   Thu, 11 May 2023 14:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: net: usb: ipheth: add CDC NCM support
Content-Language: en-US
To:     Forst <forst@pen.gy>, Georgi Valkov <gvalkov@abv.bg>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <0A1C2108-75F2-46B7-8712-616FE6464294@abv.bg>
 <C1lCmpZY7M2QToZGt4ihBCKBHAjyQ4MssYLUheV7tyHA66LovXU1XvE0UAQEyF1Znoy2CAa_XamQm41fa3Eh0r3cVC19qTbavOhesrSX0fc=@pen.gy>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <C1lCmpZY7M2QToZGt4ihBCKBHAjyQ4MssYLUheV7tyHA66LovXU1XvE0UAQEyF1Znoy2CAa_XamQm41fa3Eh0r3cVC19qTbavOhesrSX0fc=@pen.gy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: 62644419-f741-4b57-dc68-08db521f7aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzwWVQBiHcs2mx2yVLquOOYIgr0FvaYPZJgF0Airc1/wBB7M/5vpS0MaDg+x+lTz2js99Fwuc03H0QZJDRv3RRMxiMhIBIpxKot4QrY1QAjlSlOkse0YTTqUuvBkBrSmQy2coL29SZMp7n2zmxpgKOuxRfYaEkBKZU1al8p3YsGNZ7KV9u/GTuLnjFeUyXCm6f7RWnPDFM+myW2uz4zndBaXl1YnCrL2T1hGMNUxRMcbmcy23nAyOnH4BvfyEUrpVi9XLjod6siXqpWi1bjSJfZ2R+58Uh8sDK/B6cUFWsva3mmbhQQvNYQ0Xw0VxHrhXl9R7GNdMuE1fE14DcBAruea2EH2cL6VEk4f5h0C07JDUAmQ8gqSCJ07ej2GsGo8ZtUBMAEEjbdgPvgw7VERM72Nf150YwIQKt2aR+0vg+AzFE7tuBlXM4DRTE5ab/TaN5OTHB30/kzpNXiaBkT4OCUnBLqnnUMnejq/WpmNIKOVmrFjoC0OOMyntaioncfvai2CuWuuirCPLBTBNmDNadFSuZ0a9yA7/0KCJYLMfTbzfrS3XmcqhHyTeM13QlLaGfgXoUBzW/fE0dhI3aHkv1k9EMrBm/J7QXZ+33ZeONXHRrG936mI8WGiEw+65I63rZPdyUd8wkAd7+PZbkl0OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(2906002)(54906003)(6486002)(44832011)(66556008)(66476007)(66946007)(316002)(41300700001)(83380400001)(6512007)(2616005)(110136005)(478600001)(6666004)(186003)(26005)(6506007)(53546011)(86362001)(31696002)(8936002)(82960400001)(4326008)(4744005)(5660300002)(38100700002)(8676002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdvbVRKYTE5S2tIb0tpTnNyMy9vUXdDTDRsQnJlMHhpdFhuQnFJWHF5a29B?=
 =?utf-8?B?WDZ0SnQ2b1lMVzNVcEU2bS84Z1BkbGI4VW5tZWZVdmI1Q2xETFBxNFZXQW9W?=
 =?utf-8?B?NkVJOXFRK0d2WE1Ud3VienNwRG1BcC9JSHphdWZYajV2NCtQRklJV2MvNzZm?=
 =?utf-8?B?REx0cnpWbWp0WUNtVTlIUjArSXkzZXhuUkF5bzNoMUc0VjBLa1g1Y21FejdS?=
 =?utf-8?B?RlZaODBSNzNvTENaVEZuOWIwd1hqQVlzNUl2TkxaY1U1Z29XcWk2K3FYV3Qw?=
 =?utf-8?B?RXVHOUlRSnhjTWZpOEhEdmtxcDBvMFJpd0hHS0NxdSsrekNpN0lZQ3FZMysr?=
 =?utf-8?B?TUFHeDl0VlAyM1F3cExlejJsSEpXZ2VFQkZ1MXpiQ1BFZ1pRcGh4eWVYZTNN?=
 =?utf-8?B?ckd6NjQ4VVY1RWRkL3JRYjFKZ1ZjdTMrejlUU2dXT09YLzJBK0xQQnNFbGdO?=
 =?utf-8?B?ODNod0J2N1JCWS80QzNPM1pwQUY1cUh2NHJ0N2YxRENXNy85SlFGYlJSaHJ1?=
 =?utf-8?B?M3IzN290clQyQnN4S014SHZ3cFYvT1lock9YYTczMDE1cm5HK0s2bWNhUzkz?=
 =?utf-8?B?UVdwdDhzakh4OTBrOWVoWWozOHZDSWU3a0N5K01ZdFY5dVFOT3NDM2ZGUUxu?=
 =?utf-8?B?UTlsR2tGZm41ZG1vdHlib25pS3Btd0FMMUtHUTRqM043OHlkNzVwbEwzd2hK?=
 =?utf-8?B?SFpIVGNhWEpVU1RidTRoc25WbTdGRWJaRHdrdlRDZHdROUlQTFU0REUxMlF0?=
 =?utf-8?B?ZWx0SU5Za0JWOHcrNzhiZ0RQL3ZXNE5KMmlqQnVFTnlaVEZVb0RMZUFqYnBh?=
 =?utf-8?B?VTM1VmFXbUQ3bDI1MnFENjdJZGtJQkcxeFdZUWtNOEFMNTlOZGl0YmROQVdL?=
 =?utf-8?B?Z0ZmaExaOWVTSUhJQjJodFBYWDh0bDMwQW9QdG5nZ25XTWw4d1ZrMk4wNC96?=
 =?utf-8?B?bHk0UFRNMVVMNmFralFVTU8rem5FN0tOVS9aMkpidERBNzJGbUxiYUVJdXBN?=
 =?utf-8?B?eFlKc3ZabFIxNG5rckZhSlMzV3pYY1JnK1BYZ3Voa2R1eGFoZ0d3czFFSjNU?=
 =?utf-8?B?dDFjZEtSWG16MU9MbXdVTEczaFJzN1FnV0pZZXNEY21nc0lKbG1EU043VnN6?=
 =?utf-8?B?ZUlETXFLK09VRjFBOHpjRnk5OUpPQTI0YU1IRUU1cEwyNjl3dUJJV2QyVnZS?=
 =?utf-8?B?a2ZqcDRUdFZlNzRmUFY0dUdIb1dJZGZoenhEbWpPVFBUSnJEQ3llWE43YlNs?=
 =?utf-8?B?UmoxVmhlbXU3YXhBYkxGM25HOW1xVjQzWUV1SmxnN2dsQW15UVZmaVpKbjIy?=
 =?utf-8?B?ZmtJNlp2T2JKWitMcVhYMXd3dHhuaE1kZElBMjdaQXZZTFhvcnlrNDhRRHQ0?=
 =?utf-8?B?OHdNUUpheDk2dUVtZTRObjY3aTNJUzJGQjUrNTUvTDBhMTBhVHI1Z3dURkU3?=
 =?utf-8?B?cDNIWElsOCtuS0IzeEpFSmx1b2ZNVERiemlDc05BNXY2Y2s0NVlQYzFoR2s4?=
 =?utf-8?B?OFg4Vm9UUGJPb0hhb0E1RzBNWm5wWEprelhDd2R5RXE5YnJtQWhPTlptTnF6?=
 =?utf-8?B?R3ZlWE8vZ0ZRMlNTWEpmdXJUQ3JhWjYreTJqVk5mUlMzL3RxMUhCTVd5SlV5?=
 =?utf-8?B?UUlycXRTTnI4N0JaSGFybURhU3lKcFg4Vk1lYUU0bGdscWVvWndiS0tFSE5X?=
 =?utf-8?B?OVAvMkhabWxJc2NCU0VaOHR5Q3lYSXJESS9lbGNYUldsaGJUamVvalVpU2Fs?=
 =?utf-8?B?a3dKLzhxYmMxajYzNzhwWEl3QVZtK2lweTVjUFpEdzgrbmRkbUUvTlZSRVNm?=
 =?utf-8?B?RkF2c28vdWRzYjArNmt2Vlk3a0tUWEkvWU1ocC9ROEJzWVh6ZTRoOWFUQVlU?=
 =?utf-8?B?YnZGQ3hJSEJMWjAwVVJ6U3pYL3pwRFVQWEU5Umw2ZEtZUEd2RWtQdUN6TkJi?=
 =?utf-8?B?eWY1SlhJaG1NUGJmdEJzMnNiY24rak9lcWU5N1ZxN0FwbVV0OSs3WkM1WFRM?=
 =?utf-8?B?NVprVFBjS0FXTU41Q1BCME5ndmlFSU9pemQ2aVZOc1RyRzloN3pIQTl5QTNq?=
 =?utf-8?B?eklPUUhORHJDbDZ1cFJJdktJOU5vempHb3pOa0k5Yy8xLzdxLzBwd25tTHIr?=
 =?utf-8?B?K0JsSDZkV2ZtTVFiNUdRWUJJVXZvazlqWm9tMEh4N3kveEU2aEtLSGtvRkEw?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62644419-f741-4b57-dc68-08db521f7aca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 12:58:56.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpbDhpYCZ39yDCWxxJvY3R3Lnfr/mG3/Uaw6Y8x6Uaeiz204oeU90T3kTacvB2Cq9CVTltNjGou0EX4ToBavIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5703
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.23 14:02, Forst wrote:
> Hello,
> 
>> I added the author Foster Snowhill to this mail, as well as a link to his Github [1].
>> If needed, we can ask him to add the tag Signed-off-by:
> 
> I do not mind my patch being reviewed and included in Linux kernel if it is deemed of good quality. I would like to point out that I wrote it for personal use and may have cut some corners, so I likely missed some places when it comes to code style and data validation. The latter is important from a security standpoint, so extra attention to that would be appreciated.
> 
> If I need to resubmit it myself, and maybe to a different mailing list, please advise on the appropriate procedure.
> 

Sending it inline would be needed, and your signed-off. Regarding style,
use scripts/checkpatch.pl, regarding where to send it to,
scripts/get_maintainer.pl.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

