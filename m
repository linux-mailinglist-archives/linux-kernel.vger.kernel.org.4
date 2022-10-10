Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5915F9D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiJJK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiJJK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:59:25 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF965557
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw97Mnjln9zI4bqsaz12aGknrmpdjYu1knIYW1sD2FKjYfslffGu6IllOmu6ulJEndtcKOh0IEG2nc2RSO6jrik+phZhAIFWSj3iQBW9WnRJdonBI30tmekHU/Au2hY3dAJrZWGgsMTctt4wQUxHepNWy7xaFlg3VL4O/OQi7KQ6Cez9vSt4G0vDck4xjorv8L7JfMVG9WxwAXJPcjsAQMDS7Ph9Mv8lZl5VKs+DJnlqOn/9Jh99CKdvquZPsdWx07bGzAc9jX/EYqPmh5ZbASYscMxZSl9rDNcvUXZ+B9zIeW+ZhqgLZlLAzQ1bqoWXY819ElsOAtppYcS/EuZy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gC2mdhHsVHHikDhwkXLUXNrBpAgqPnuJhkHrFNY0Vo=;
 b=JpnP37PhwYFRYfdlXZkTrFZpB+7f8smQS3F3fNpLYnTSOmqxPYSGSGvQYyfQ7ylgj3mxpCqj2OOmy8xxvLj4yncueKlfkik0b4dxUjdKuDXzmwxVisTMLW3Uunyocyh6gWtOUQE40DXPqkn7SxT3/ozRGLIoiwYMbpDD4l7RRbcTLdojct4epN/np5T8QOXhHp0c+eOdtgzCO/+LxclOqGaiouCZJMmUkxSex9uw72h7jyjCipEOpi21QBFtBQfNGA3TNyQGUAH7dTbUVW3CzW8Qn/5/yxkI87lEgqE+uXGVpQfYcERMPgLcLppN98vfEZOjuX4+RWiqIzsi4aKhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gC2mdhHsVHHikDhwkXLUXNrBpAgqPnuJhkHrFNY0Vo=;
 b=Gd8KB0c83CpjHph+LbFkiBry+LovhnNn0JC9BoqvSRcOycTezoxYYNByFFHIRRBTc/X5+nDHfDlLJp07INj+Dm4r5cpB4Vq1Olf5FMm+aQEpr3iCTuotxEodO7xoTwxF8W/pR4HD8Qqqg5mGyP7V/zHt+OtuoXl36wTWiUszris=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 10:59:20 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fd4:b93c:2d9:2542]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fd4:b93c:2d9:2542%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 10:59:20 +0000
Message-ID: <e70603da-4996-07c6-62de-85eab2d77b09@kontron.de>
Date:   Mon, 10 Oct 2022 12:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/2] mtd: spinand: winbond: fix flash identification
Content-Language: en-US
To:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9c9a2a-cef0-4e71-6c09-08daaaae7bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQI+RvIOiC/lKrjuluK/PM9LjsW3thUZMHMnpN/UnvK5NgJz0IPLWXsoqQ2ahivUxWF/J2EPcGRSuH2I9Vy6uRdeke0fVdTTAQ/Qyshk8pgg0QRYc54Dx79OspD/9KjnxRknp23eCMK4YxaV6keTxlf5FDHVpal5Pj+DQ9OsYjDPp0CqjkMM4gjWQPZeTye2KxC3Y8ZPIJXCy+Ase40iX4pNSTR3De2x+0SIlDvB3wudjuIYptm5hWpHdOMDRAveb/wyBv1SDdXx2GlRWb0Ow/dwysqLCpjj/1AUxaR4uUyLYrlETmWuQtz0piKYmjTD7beOb5RJj/YaCHnvMvKeIoLF0TNETomrGWb9CPimL3V7GNYWhdNO1aQ8xBAR+3MvWjyCacexq7f16I9CYcIMYB56vMP53hjEBltRAfehKs1Asccbpa04G3syZ44TsLGl7qvuXwKu9s2NOPBuX2FCHFUW1IXzVDkgehKkr5CduCC7gljXRQYNgikuQjEnxJyesMbaLYOyikBUxM9eD1/3B7xPk3bEuPE3ExXSzNuaQBIOYpi0wvZ1lKf/uA8AN+WqLJBDwOsixTu4+HuTNsaiIDRowaKapZH7DPGyV+zQID01+oMxYVzV9j1QpV5AREYShr36vonIk9BlndYujj6frVdRLhxbokORfoYwyQQBhLPo9076Q5lEhxFvfWfVwkqCSTyFvIELWNBmgVEAkjQrhPkW/V180m7HfvqqBlODt67mRcEpzZiB3+B0tC6n9g0hOEcBhmnXFpBl45+IgPyMIw2vmkOcz9/YjDRQ66vkW+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(66946007)(8936002)(6512007)(4326008)(31696002)(2616005)(26005)(38100700002)(86362001)(6506007)(8676002)(6486002)(66556008)(66476007)(478600001)(54906003)(2906002)(316002)(41300700001)(5660300002)(53546011)(186003)(4744005)(44832011)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lrOVVUUmh4K3JRajBwdEdmcXhybjA0WXBINkordkM0MkZXYXZKTCtlT09Y?=
 =?utf-8?B?L1lTTC9DV1lxcmU0OHNYSFhYbTJNTFZ2YWxsU1U3UDE3Vk80QW5aQ1pLaXA5?=
 =?utf-8?B?RnJpSHArMXI5d1lyMXVtUzNIZUFpb0R3d0pWN3dFWGdSdEpaK0MxZUloeHVr?=
 =?utf-8?B?V3JrRnp0bW5ySFlPOVdCeURKdVRZeXdsdDR5ek5IUC9odVFYRUxscHhER1B1?=
 =?utf-8?B?a3NxOXJJSjV2aVV4RjdzNVRkVU05NDVjVnE0dEZUa1FmdHNXK2RMQVR4U214?=
 =?utf-8?B?eEZJYW1XU3NLejhPaEVBN1JzbzF1aFdtQXkzWkNubGdVaklFMXV4cG5TcXp4?=
 =?utf-8?B?azlLMGwzZ081c1NqV3MyQUszTlJUR3dtZGo2QnFpVFV2cWpwZ0h4WWhaVXUz?=
 =?utf-8?B?a0tIbGl2VlRsRStHellxYzg1eEpJdHQ0NnQyVjVGRCtIaGZvUlVqTHc4Vnds?=
 =?utf-8?B?VU92ZmY2SUZoWm56T09vTWxtVi83aURlWm0zTlVjdFl5NGJaaU9peVFVOXgy?=
 =?utf-8?B?QlJUWkMzNGNjMXhZME54UEZJYXlGR3Q0TVYyTmRjTmpveDBWQVpDWjliZHdO?=
 =?utf-8?B?SkZZejY0eHVlMjVQRWlxVVJhWldXd09FcEFqbyszMnB5czZIbVEyYU13aElx?=
 =?utf-8?B?ZnRUa1Q4S2NHT1BjVXhXWFhuUXAwbnRJejNzbUU1UXBJUTZSYWNKUEhoODJI?=
 =?utf-8?B?d1gzY3ZIR0xIV1BWdXpVNDNGbFprcmNuYjRlaHByeWMvRnp0aXQvaURTS0xQ?=
 =?utf-8?B?cEdZcVVCYno4RlA0Z1NUWGE3ekUvb3Rya1lrYnQ4NnExTmFQRXB0bXRvdlNJ?=
 =?utf-8?B?d2dLanlCRThwTCtrK2dpZ2t2aDlyRUZTVzBxR1YxUkZDMHMvMnhNS2tFWXlG?=
 =?utf-8?B?WENkN3hva0FGUVNEY1BPNmFYZzYwRzc1c29ZMXJ4R0JVT0Z2NmlGbXNLYUVy?=
 =?utf-8?B?QTVGWU5FUkxFQ25jbjhtOXpBMEZmeWlhZ2xKUUFEVnc1MjlGNDcxUGV4b3Vj?=
 =?utf-8?B?OFRaV21HSEkvOU81MWFzbzdQcjNKSEdrRzVaWlZid0ZVczBEUzgrUUY5eEFK?=
 =?utf-8?B?NzlRKytleEJiSFo2SUtWa0x6OUhZSXFlQXVCc3BTYXFKT0NkR1NYRERGbzAx?=
 =?utf-8?B?Y0FqcFlLTm96SjVnMnRadDRVWjF5SXNEVnpZM21lNktPbEVIRGNuK3dzbStO?=
 =?utf-8?B?QWN5d0UwZHFML1JrN2E1QWxUNmR1ZGo5ZXhHMjNJdkRPOU0vWWd0TDY2Ti9k?=
 =?utf-8?B?c2F2Y1gvRThvaWNxQStKVklHQzBodUkxdkpMSVE2SmEyUkR1cCszYllSbnh0?=
 =?utf-8?B?NUlWQ3RLSTl0Z28xblFSeGM0QVpDYWlqV1hTVHViUEpXSS9NWHNtV1RlMkVo?=
 =?utf-8?B?R1doOGRXQzVUNmF4cEFzNldVSFVIMyszWmw2ZGZxY0lCMHhDZjhiaTFveW9v?=
 =?utf-8?B?VExmZm9rekR3SmthUVFtUUwzTytzeitvb2ZkQTJ3UzZLdXpacnpUK3UwbXpB?=
 =?utf-8?B?TmJGSlVyWDBnRHA0UFhEb21CUWNLSjBnNFRQU2xoWG1sZXpRUTVOS1hCV1JR?=
 =?utf-8?B?SDAwTlZQb3JaM0xNZHJwQTNDT2dSYVpzeDRsTmdMd2pSMFdvZzRpcVNTVFFv?=
 =?utf-8?B?WW9PaVB6OGU0MUl2b3JvOFc5NzcrRWtQcW8rTnl3QkJpMEFTUHh0SUNxdlpp?=
 =?utf-8?B?L2ZQVUwwallCcXJ0MytsTWxHOThoc3cxVGtTQWNzTTArK2EvY1Zvc2FkeVdJ?=
 =?utf-8?B?cWw3a05VVFN6ZTl3SFBvWTRhckF0QnZrM2NTU2JRR1MrNmZKRGhYaVU2blFQ?=
 =?utf-8?B?eXdZOXhPckhmeFpGT2JYT3ZkTmxVenJYbmhuSVdYd2g5OWlWYkVtc2x6YUZw?=
 =?utf-8?B?WFJmRlNCUkVyanhZdWpQcTcwQzJ0Q0FQQUh4ZlNpMnNTa3VlR2JFa1B3V2Y4?=
 =?utf-8?B?UXRaNnI0QjBvL3BzS3BlM1VhL3F4Sk12WjQ1Z282N1crcmluL0J3M09RWHZq?=
 =?utf-8?B?RTRqdmRaNEJJWFVFY0pYckRVbmIweDNLVnpxNTNWSjYzcklKMEIwVFBhVUhT?=
 =?utf-8?B?L2FNNnRZYjdHaTliVVp4ZkhXdmhQdWVoK1R3WkJhV2lnY3VkR2ozaVhrSDRL?=
 =?utf-8?B?dVZwei9pcWQxb2RLWXVxZzhQKys0RWdsSkVMMWhNUnVtam8xbndyck05cU54?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c9a2a-cef0-4e71-6c09-08daaaae7bb3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:59:20.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzychonvpPB+jLtGdrF9NUrBtdOy801g9qCydCQnInQEubCuvCiuj7c8K9N9FEfxALQha6wCtRrQkfbAnm46LuSxUCG0WNSVDlRViXqEybQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6728
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.22 12:51, mikhail.kshevetskiy@iopsys.eu wrote:
> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> 
> Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
> but current driver uses only first 2 bytes of it for devices
> identification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
> is identified as W25N01GV (id_bytes: EF, AA, 21).
> 
> Fix this by adding missed identification bytes.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Thanks!

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
