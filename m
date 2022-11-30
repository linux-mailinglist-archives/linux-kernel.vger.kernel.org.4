Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5FC63CE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiK3EKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiK3EKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:10:13 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81013F1A;
        Tue, 29 Nov 2022 20:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9N+mRGOQuol4mB7UcwHXVJLnNo36gNm0UcaLhQ/TDkHYzkYfrDj4W7VnXMjapZmcWoRzzvtzBfrTtPN4axGfuCi+TEWYdp9L0DildESv5BHh7nlzFV56jXMq1h7MHrkLxwEuIOGNGdCdVO/UjLvzO8Wwm4ZtZTiHwbGkhpQAU/zx00Bs/NrHQXod9WwWPzlCoCsGLJU7PMc78jPXV8a8mXiia8xju13IuOtpAopfLdoUQ+4AKzFmJJhq812eRXHEBz5isfSUaLvVw7wJ+JLG0g6LedSSPoSNF2XVF166QPJqO74QHNDsCo863pHK9cLoYBnxYEdN2OmcomYxXKgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5DkrDefDg/kYAqyeeoCkENqVKsAhh1DHqMonEOzyak=;
 b=dXpZYYcwuU1+3KMtPnhMsfQ/p+awxX+Z7toqvVgzwh5U/VjnfQbKushLODi8u7UuMpuPOfq10T40MaWLfQ7bLrubmMYysrenJ3eDeXwjTAyZXhK4HFFInIqi+xERH8aNex8sUvoYvDsMl2vqY5Pt+YwxdLDWgM+I2+ChroMDiuNztc+T4N5h9nUVborD6Uq15aI1IIv1cKjYxN/25i2v+2NSrBYPcAYecXzYwo3UxvNbaUTuo+eJrCx/T9CCRbxQsGtQewQH+KP73TXjwOYeRvTEEqIT4xssMd3Je1+Ehz9gz7tvgXNBjJKbbmabbaSgdr4WVn1uuWdXWyqSVSHsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5DkrDefDg/kYAqyeeoCkENqVKsAhh1DHqMonEOzyak=;
 b=l4FQxwEkMYmIQYMdKze+uWSjAYo/mxFOL+aM4LdoJqib8yJhFDa8nz/3OjVweNAfC/YCuYR7iOhmU2olDvNwsIwavSJ2tagg//E2X6wCN9xy4gMHJcY3Vx04Nx828RJnM3QYQNVvcJ4stn/Oxjc0SfQ+fuppynwG/iwmIagXL1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AS8PR04MB8071.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Wed, 30 Nov
 2022 04:10:09 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 04:10:09 +0000
Message-ID: <dfe167cf-5d4e-6fc7-c954-25f719b1e843@nxp.com>
Date:   Wed, 30 Nov 2022 09:39:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
 <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com> <Y0A+Y3uNzpzGx0Ey@kroah.com>
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <Y0A+Y3uNzpzGx0Ey@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To AM6PR04MB6407.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|AS8PR04MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: b33b34ce-85de-4a94-6f7a-08dad288c4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5BwdwL9UWopZCRTufPc4TfBazc2zjedoFddoPTDRGQP7vKWxxNs2Qbm66xwRMkIxbIMNGjauYTLjNIiQGV4PscqOReFR/oWUP8cjUfVCTHu+r9ibtJrtywmgz22fCSajbxPpXkY8u/WhK5nv81A2e+5Bw57TGxTvU3KS90zyfwOHwX4mepqGLbwqU45ZR1mhjfQ9Hwgx9Lb7x+jBKANfVugtFxD8Op3wXJqfzyu7nn526NsYOS1ndRyugtOla6Xny1uTa0oYRhalmkERiKfLoS3vQzu0a16PMFXnRRV5GrUqTUYiSNdxz60BTU6VmUaCh7TrggSyVtZmvAayg3QGx1SWpd2MOOKzMFjLyolvtldeyOCpGJWRZrKRHrT4/GZ2ffzt97d85TgWkBB3aiRPAsB00XvnfaofEJHzDIOEwdKt8kH6fb1JYuwToiwmXK8ohzJABfzKFptqRxJ5wNBCQAdHoMD0621aZx72Klssd8SOmB6eYDhx55Dm8lcN7TeJpbSiXrbXXVdVyGq/zG91cPr1glf28k4am6pCu5+g8Ovvy8N5YXxMBN8WELUXeWCLGM0zPIDAXADC9LtaY1yYdelroh2LxujJ+4x7yuK/97y6hX6wONRVb5LawJdKjuhlnR/KDC/H/HlaHtM7hIFuwlQzAA5uMk4IV0FnE90l93qudTzm3VKg9ugF3QGAd/y5SaPTxaa0h/lHu35GTMwsUVIByXgm295gO+g/CyZfDfqCe8vGdd1A4EKFDh19Bm9P4352JMq04AeeChy8imxZXM385eyEqNzcGcTHDHWTedvINA4OgTBtEh2Cy2g52Cqcz7Y/GV6A+R2gKm62PdLC76stPtH5a+nNOLeHy39EbsFv7t8X0JEC7bDnmX6EkGz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(83380400001)(86362001)(66476007)(31696002)(2906002)(44832011)(41300700001)(7416002)(6506007)(8936002)(5660300002)(4326008)(55236004)(52116002)(186003)(6666004)(26005)(53546011)(6512007)(2616005)(966005)(54906003)(316002)(6486002)(8676002)(38350700002)(45080400002)(38100700002)(6916009)(478600001)(66946007)(66556008)(36756003)(31686004)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytVangrV2tJU2w5SEZDaXd2ZUFVUEpGbzVvRm16b0FyNWdDSko1Q3l6M2pu?=
 =?utf-8?B?QlhIVG5nSVE1Y2R2bFZKZHhsRjdVV1lLVS9ncVY5Z081N0JrWmtWbkhWZW5S?=
 =?utf-8?B?NjRiSU9TeHZST0hvUGxIZ1BhN0dkaXU1Q0puOE5vSnM0MWJMd1MyZEsrVWVz?=
 =?utf-8?B?RUZ1NGF0YStWcFZFRFVzOHlaR2dpdVJsSDNsZWl2T2k3cEl5d3FIWUgwWmhj?=
 =?utf-8?B?NFh6OG03UjZDZFhKTHBrNW1WVm1kaDBxblVIeDQ0Zm8veCtwOVFYeCtvVzho?=
 =?utf-8?B?ckZLbHU5WXhuQ2JnTUtXNlU2RElwV1ppaEVUcTVOSXZEWEFtRjZtOHhwV2pH?=
 =?utf-8?B?NXNCMTROSWF6R3lMS0x5SS9FVlhHQ2NDVnA5eVhTcFJzanJDOUtNQzlLdzl1?=
 =?utf-8?B?VG9TR0taYXhXa0JIeFlRbUgyci9EWkJWT1FFSktDdHhSR082R1IzZUpkMndu?=
 =?utf-8?B?dWVacW1wTGU2K05MNVhiOGhrR2YyZkVTWEg4L0ZYa1hMeGliUnRoNWo1Z2Ez?=
 =?utf-8?B?U3krM3JEQ082YnJpRExDUlVnZExLSlhyVStvaUQvcHhybXVKbVNMOXRoOVVK?=
 =?utf-8?B?Q1ZWczJrRTRzOUxBRCtiRHFJbnBmUjcycHBRM2NsKzAvMVpRVXlmNUZEUmhI?=
 =?utf-8?B?Ti8yUTMxSERacXJNZGQ4aUIxZmxyallqMUVXQmJydUJXUkk3L2pXOVVTQ0c5?=
 =?utf-8?B?Q3FUclU0SzB0YkJpTXNnd3J4ZlRJNmpqWTlqeG1DOWpqRUJLTnR4YWpNMUxP?=
 =?utf-8?B?UDNXV1pVbm1XOW5IQVJxUC9kb0k1R0E0KzUyU0hhemcycWg0QWhMNmVqOUdO?=
 =?utf-8?B?ZGlaQk9qdTRRZ3lTTzh0cXdOTDRVaGttTGovMk44Q1U5VTZZT21uU2Z4bHVI?=
 =?utf-8?B?a1lHNE5JeGdiUHlQRGhRb2YrYy9hanEwRVl0aDNjVi9MSmkrclViN2c5M2Q4?=
 =?utf-8?B?ZSs0UDlVTlFrVzNuVEd3MjVLRDVZcEl0R1hWbm9ZWDM3NmIwS0xOdWNML0lM?=
 =?utf-8?B?MTFOaU5oR0dIM0hkTlZPUjM5SkZzNUZKUFRCZ09MMG44ck10Q01Vd3QyVjlh?=
 =?utf-8?B?NWJQbEhQZC9raW1NSHEyUUdzMzJaUXdFTjBHSE9lODdtZi9jYmJnMHpmcnNC?=
 =?utf-8?B?ZmxkWkVFQk00eFlWeDJRTWxQQlFqZUxucksrcG9VY0NibHNTRXZiUTZBV05s?=
 =?utf-8?B?VEVnZ1pDSG5QTW9NeFJyOWJuSmJjU1YrYk5Pa250TXFqek55NXRSK1hzWkY2?=
 =?utf-8?B?a2RWL1JyaVI3bS9WdWtCZTV2eXh5OTArazhyQ1loM1Q1NHUzVVVZcUJpdnZR?=
 =?utf-8?B?aFJNa2FjZmkzd25ML3MrSkExaXFiTFVINlorY2l3Y3NubDFPZ1F1MlRHYlNH?=
 =?utf-8?B?T2hOMEl0bTdzOFFjcnRJQlBTUCtVV2RuM1Q0RkVWcGtkU0NXU0Fkb0x0azQx?=
 =?utf-8?B?YlNiRmR3djJWRmlvTi9XYmtrMFlWdXU5NWtpOXBiSWxqQW04K1B3aEJwRE9k?=
 =?utf-8?B?dDZBVEFXT2hkSERoUXN1VkZLcVhTL2pnU3ZZcFJLeG1ReWRrTTFsa3FBU09p?=
 =?utf-8?B?YStFYVV4cUxYSkRGdzUrSXcvcjM0UHdXZWVFYzhzREdUVWhOY0J3UDZ0N2Nm?=
 =?utf-8?B?RCswYzlzdld5RVVtZXpTMmIzVEVXcnJCZW4zdHFrbENoUVFPY0cwSmxhdHlw?=
 =?utf-8?B?TzhSVGZydm9CWFg4a0hhcDBnZGxHdnY4dEVaaWZIKytxVTJ3TTBacW1oZFh5?=
 =?utf-8?B?RVRpYTlsZHFzSmVucUpzTTY4ZEwyV3RVbFh5VWk3Y0NyemJkQnptdWxwZVZq?=
 =?utf-8?B?ZGZYZHBFeUdHb0RmZ0RFVEZUQ2dOOTJmeUkxWjNHL3RReWcvenVwMjV1R2FJ?=
 =?utf-8?B?NzhyYzU2M2xPNjVmcXUrVnlxUmFYcFlDOVUyYnJJb3pBWlUrRE1NODA0YkUz?=
 =?utf-8?B?ckJvempZQmx2WXBLRWNWTEcvWjJOZlhuODZla2luQmJ0T0dZK0dpN0RkZkRm?=
 =?utf-8?B?WldPQmx6VWN4S3p0OThORllKdTRBYmczcTU3ZXZxeFBnYmxud01FR0NlYklC?=
 =?utf-8?B?a1hIdE9lUWExUnNDa3ZOOE9vUk9kQjJWSWs1MTVPSjUzUlVqWkZZK05xQ0Jp?=
 =?utf-8?B?SjdtUWhiQ1I2OHJ4WjlaSnVQZEpKa001QmlES2xqc3kvUEVoNUxWQ1p1U2Rm?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33b34ce-85de-4a94-6f7a-08dad288c4d1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 04:10:09.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Jb1509TLSRojhFAV6hsDK8rzRtKTcoJ96TxFse6xRVBlFF5HycHP7T3owo8tR2CEvincDdFyIVjjRkjZWT8Ly1lHaRsGhxbwSlngjYwu3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8071
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/2022 8:27 PM, Greg Kroah-Hartman wrote:
> Caution: EXT Email
>
> On Fri, Oct 07, 2022 at 07:34:25PM +0530, Manjunatha Venkatesh wrote:
>> On 9/14/2022 8:39 PM, Arnd Bergmann wrote:
>>> Caution: EXT Email
>>>
>>> On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:
>>>
>>>> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
>>>> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
>>>> Firmware Download on every device boot. More details on the SR1XX Family
>>>> can be found athttps://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nxp.com%2Fproducts%2F%3AUWB-TRIMENSION&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8478b7c0aa694618aae608daa87430fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638007514231447184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=y3t8eT%2BIX1OP%2B1wu%2B8hWp2HI%2FhnZj32L%2BDCcIA7m9hs%3D&amp;reserved=0
>>>>
>>>> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
>>>> Interface (UCI).  The corresponding details are available in the FiRa
>>>> Consortium Website (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.firaconsortium.org%2F&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8478b7c0aa694618aae608daa87430fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638007514231447184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=xhFUUcJ7a3oU6pefXHTunBCI73%2Fy2PnnwsTn1KZbeFk%3D&amp;reserved=0).
>>> I know nothing about UWB, so I have no idea if the user interface
>>> you propose here makes sense. My guess is that there is a good chance
>>> that there are other implementations of UWB that would not work
>>> with this specific driver interface, so you probably need a
>>> slightly higher-level abstraction.
>>>
>>> We had an older subsystem that was called UWB and that got removed
>>> a while ago:
>>>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fstaging%2Fuwb%3Fid%3Dcaa6772db4c1deb5d9add48e95d6eab50699ee5e&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C8478b7c0aa694618aae608daa87430fa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638007514231447184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=gcF%2B%2FzD%2F0TWJ5AEJvXCGv5n%2FrPg2qXJigedOq4IeVPI%3D&amp;reserved=0
>>>
>>> Is that the same UWB or something completely different?
>> Basically, it is SPI device driver which supports UCI(Ultra-wide band
>> Command Interface) packet structure. It is not same as in mentioned link.
> Why isn't this just a normal SPI driver and you do the "UCI" commands
> from userspace through the device node there?
>
> I know I asked this before, but I can't remember the answer, sorry, so
> please include that in the changelog information when you resubmit.
>
> thanks,
>
> greg k-h
The IO Handshake needed with SR1XX Family of SOCs cannot use the RAW SPI
Module's APIs and hence custom APIs are added for communication with the
UWBS,
With this will get required throughput for UWBS use cases to avoid multiple
round trip between user  and kernel mode.
