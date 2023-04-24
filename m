Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BFE6ECDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjDXN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjDXN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:27:21 -0400
X-Greylist: delayed 862 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 06:27:15 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055818E;
        Mon, 24 Apr 2023 06:27:14 -0700 (PDT)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O7Dclk006245;
        Mon, 24 Apr 2023 12:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=JZTrm3c1KDg+x6K/fz+PGJz9XOfiOPJ7gkEMzcnKreY=;
 b=Dvo4/u/NkhwA5mIbsJb3SZ3P1ocxyAFIMnlBUmwe7jXfUlusYisJL/5o9J7VfnNwWfjR
 xomY0wPLYfLPidUvfWcgmWC8RacoVBQzjcxcYnR/jY38VeaOYpX7IhWBwF3oYzZllC72
 DXyV20fJyktX5iudx5gzy7uppRC+akC9sbw/12lpxt9EQ3vTkdZFjnzafLDPGx2o2cZH
 Rf7nFlPMURRBLe+zsdVEGRTJsup+xhtIeqaRZmyu6OG1ZXGj2dUDM3LYugnqu//vLqpG
 HNY8Nk3tHxy6taHy4lXqIepcKoe4SgYmfnxyIxwBCsJ3PJvxWEcII2qc96Yw+ylWgaTu Zg== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3q47yv1nq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 12:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2Xi+PM8RQrtaZzhbcg+VHrIt4w3/cMuOWqZFt1zp7ojcilyyqjvWAv/deeLbKc0KGuRen4My2/Aa0HUbUNttnjKE4q1ofe0unzHzmG/fTtuRBebCetLFarFKr0wbU21CgvVRqv8E+KToefH0N2FR+6DunhqLW+hxve6RPySn6B0ZR67OQrZCDMNIrR6t8ZVEOnbdRZ6f0HIA7YNK+FkYtCDMyHzaJUqnLFMk8aIK7Pfi7CwJU3D9xximnxxpESWYyznQKnjxplD+bZujN3P/5yM2Q46K9GJsZduLsAP7oZ7YCZdTLx9NeK5k+ydfg1IXCY25WofFKtFpZzByPMJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZTrm3c1KDg+x6K/fz+PGJz9XOfiOPJ7gkEMzcnKreY=;
 b=Gw1CQ+9u6bhb9qcl6ug6RjhGrP8Bzmvm2/m8pGvOmhKSI2iUpNDiyybQrLG/jVjyltIE+MRwB56SDZd5ca1TSH3k0+nKiV4UFI4GxXSLX0UZJZ6GXnmcj4ea3VYG/gzYB+VResRJVVDQd/DmzNM+4tPwNbrPW2yLYVqjkpRp++prt5NRC3DJ13lccaM1NOV1yu++ve4jYNzGI4pwjr8n6GH6h3bQY+YGnF96WTiOvmQLQhVkqgqWp/CJX0GI4LvgINVjBD0pmV0MRtZJJ/9W6uzdG701THIgxiNEq1n6W3XkHHDyMGXrte22yB8Pewl3cWxdrFHPZJIxaJm2fcofYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fb::21)
 by PR3P193MB0780.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 12:20:48 +0000
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::957b:7571:77a6:c86a]) by AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::957b:7571:77a6:c86a%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 12:20:48 +0000
Message-ID: <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
Date:   Mon, 24 Apr 2023 14:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Content-Language: en-GB
To:     Mark Brown <broonie@kernel.org>, Yingsha Xu <ysxu@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
From:   Peter Enderborg <peter.enderborg@sony.com>
In-Reply-To: <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3fb::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1687:EE_|PR3P193MB0780:EE_
X-MS-Office365-Filtering-Correlation-Id: 635a3ed9-4b65-4712-1ea6-08db44be5641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGvO4KQDGbq3Z+aor0tzBk8j+Rylq64VWEdPaEoV3d3aQN57mGEKK1VCoSFkHT4fnYZ0qrs3CQ5/pQLHyz9dUxiptjwAZZUPDbQI/DBsoHSBsKic9R1lP/q+bvzLHGq/UyQSIRKB44IUC2bRQ/Zen9EpbMP4pDbr8S0PR2KP4azeioZnxIunjGc7D5eey2KP1xlbAS9/odbAckHAk522jfl96+yD4m4BHjtLQ0bZUA20L4tw96gt8JtJgw+KTa5vKbW/4khVSv7jXOpFSVpRkHVZHm8zJrnDmaRNrY38gHRKpajNYEF/evJ3Bv/5SXjUlC5EmB43l7Vmb67Cr/QuHv2xRtZUTOwl3UjAeAWbfakIYJPJiY8qm1HqVHZqDf9Io4rw4uJV6MnlsYcI05OoSc/TENSz1URUQEBi30nwTnBmjOIbMtgKXHe6PZ1RBDh9VlUMWwilmbcs8bJgEkvESeIolLXzR1a4fSXgnRrnZxmbYh1x8EzpG+MbPufQYWQcZqEVldya9HmrI/KuyGRnBnkamzhNb5HcT0M5UGsEnbqtkZQzn49aX/p1ribD845W7U5TZk7nLzlltCXU5/eczQDxcOPc701CgO7+j1c0TVhRQ0zfPLBcEGBSqf7vI/nU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB1687.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(44832011)(8676002)(8936002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(6512007)(186003)(53546011)(38100700002)(478600001)(52116002)(6486002)(6666004)(966005)(83380400001)(31686004)(2616005)(6506007)(110136005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG53UEwrSUo2S3k2OEZrTjc2UDduMm9xcXk0NU84Z0UrYVV0ZjJBRE4xMEFK?=
 =?utf-8?B?OXJ3N2FkbVgxUldzbDZCV2JVRFRITUR5L202YmxRamNEeitnM2thNXNXMjZ4?=
 =?utf-8?B?NDlhOVRnZEhxd0lhb2ZWclp4WmpsR2F3djNpazNJdEgxNk85S3doWVhjMXF6?=
 =?utf-8?B?MktYc25FMTFqSCtkbUlZQ0l1OG80SFlkU1MzUlZRa3o1WWttajZyV0hMM2lD?=
 =?utf-8?B?RktMTThTMWxFTnBHbDloVCtTM0hZY2c1NkVvRzFJMWs5bmg5OGZJMGNZTThI?=
 =?utf-8?B?bEdYVDVJendGcHFMQ2Uvc2lQay9vdGNHUHMydlNjYUZkTytEWmg5VERVajU4?=
 =?utf-8?B?b0hjWllMeVFjZUc3dC96dVRFS0RmNWZJSW1jL0UvQkhQNjdmVng1N2NSeFk0?=
 =?utf-8?B?dXlxdklQVi81eHB0TVl6eVVpVTByVnY5LzRLenNReEsvWGRxNU1LcVZpc3BZ?=
 =?utf-8?B?Sk5kcG5UZnpjZ1J4VzZLelE2bVN1QmQzYXV1dGticGt1NUY5a0dzOXVnVzdQ?=
 =?utf-8?B?YWxBalZJSmpLMFpYODY5N1ZHRDZCSHdtbVJCVXhPNlVQQUpMUFF2ZittemRB?=
 =?utf-8?B?Mzl0ZCtFOTdJc2VYM1hwVGNtck5adVV2eGJUUW1MMDhWdGZCSHp2alZRYjdO?=
 =?utf-8?B?Y2hLbUxHVERmd21McWhoVHhjYTNyaTRFayt5dWhhWVc3T0pDWmdWOEVNV2ZU?=
 =?utf-8?B?dHlMYzNMWnZwemtoSEZSR1dmaEM5TURnOThDblFXTit3TnRhWlZCTWZMeHA5?=
 =?utf-8?B?cm1wZkpkcE4xVTVNYkMzbzNuYUZ6QzlKNGY0UFRWM2YzcmJiUTdwaDR5ZzZX?=
 =?utf-8?B?SkhjK25tMjRBQ1doWDZRbWtTOWFrRnZ5Qms2L205NzJvY2hwNTFvWXFLWkpK?=
 =?utf-8?B?UUpnbkJtMlZSTXVLL3ZmM0RGKytGT1NCR0ZEL1hOT1Q5YlRZdnpaVEsxSzVp?=
 =?utf-8?B?azVlRXkwbi9lOFo5dEMrYk9vUE5QTXM1L2VodjJIU1VCVXByWWlGWjJicXZt?=
 =?utf-8?B?ZzI4QStRQkFLTEVGbEdlVzZtUmVLNUsxcmZZYTJTbVlMdG1LNTgrVVR0Nlow?=
 =?utf-8?B?NzUvTjFLdVQ2WUlZVDV2VWJvTFdCQlZGSG8vTFI2akV0bUp3SzE2cVgvL0J6?=
 =?utf-8?B?aDFoQ2c4dFQ3bHZnREZIMjhnakVsU29UZVBkYW0vTFdvY3FMZzVnY24weXZ0?=
 =?utf-8?B?R3lKQW15VklyZEl4NU8yUzEwaTNpdjB4cTJhcHZKWmVzbWhNL2haOEZkRitZ?=
 =?utf-8?B?QUtVZUNud3NnR0JUMjVQeHhOSUx2OHFobGoxNTMxU3BYV3A0dG1xb0ozU1Jj?=
 =?utf-8?B?Rm1vYUttY1lXbmRrVVc4TEsxUG42WUtuLzErdkRkUEsvYjd2OHVVRHVNUEkw?=
 =?utf-8?B?SlVTTTNVWGFOZnhTa0dZdXJLUGRFQThhcndVVXZwWFBHeFg0OTB6UjhjWEF4?=
 =?utf-8?B?dFZpMnhWSHZ4UUJtTXZPcUNZN29Ra3EzRi8zNFVZYnkrUTVsRzVFb2xRbm00?=
 =?utf-8?B?Nms0bVhvaUVHVUdVaVFiUVI0VUk0blFodG05OEE4RmpQOUkyc2ZUY05ma1Rw?=
 =?utf-8?B?ZmhwK2RqMlo0WHFtNXdySzRQck5OVEFHYkxjNkZDaUN3dHEwZzR6RDA5cDVU?=
 =?utf-8?B?Q1BtZFUvU21FNnp2aTM2ZzVkTDE5bitKNENOc2JOTWNScmJpdUFhVm0rVnlO?=
 =?utf-8?B?dlAxbVc5ZHMrUVBPOVhyQytqTkNjYUtsZXJSTHlQcHVTWVR2TFZtN1N5T3BV?=
 =?utf-8?B?bkpuTkRDdjNtc3UzdWlsRGMvWnpUeGlFY01WejI5MVZGRkIwN1IvSHQ3c2lt?=
 =?utf-8?B?elUvM29lczVodFVuWU84a2gvaC9adkxoSXFZdUtKNWxjZWw0V1dLSVA1NEIx?=
 =?utf-8?B?cy82TUNCanFxWlpLbmZRbG1EdVRRZmo3b3FpR3grQ2JQaUFkYmNjU1R2RUht?=
 =?utf-8?B?ZFRHaHhYZEtLWW9MS3VOV1lRUWJrVWV2QkdKcCtDemdGN0ovNitQSjl5SDNJ?=
 =?utf-8?B?aFhLUUVNOTdyV1daRngrZXFzRmtRaDRmaWd2bFBTa3dHYzN4NFltb2YxMHNX?=
 =?utf-8?B?YkJrYWQ3R3RRMDNVbGlDOXhxRzdJZ0h2dmcvU0JlNFBYNVNpOGR0WldpT3VW?=
 =?utf-8?B?Wk43cGQzTENERDdtS1FIMXBaejRSS293bHRrWnRlL1VNZ1hFaWRaWmZQTkR0?=
 =?utf-8?Q?7RL6yC6idH+snPgaHAdrhV5Md2WMxLSPPcjAuEbifEbe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XZGgpKyqJl2sfihxRaU8hnsX4G78FGZrhC3gbufKE2a5T2v9XCpjwT8xQxrO8msVsp2WELIRfSCLoLQzKBYSQ0znmn02w+w1I3SdBFBxOyU1UPuAiUW2xpbOkHuDuFmt9+/V89Qx6JDJ4q9Z3/u65z6T1vlje3XxXX6yGCCK8uWkY0DNk6GCRUUKxXiyrwAdjPYVijDC8Xz1OlZA6CRtXAsVuxPTVvuBSgaQY2vSkmzEtJuIoZ8UQpB4bswd5hS+Oo/CBB1A32R++ncMg2c2BAnYSrr7LqUCCjPmblnRKkHriU8TBM6vQzCiBhwf9AGmjW5p8mHxzwbhFJ5ytfUqX8gwaiWa9pdMrXsHop3NP+AjWLRNTq/2l4mXiVWqy+ew7sNpgUTQ4biTT51tpyQF8yHhin9VcXAp/XeKtAF8d2v2bsDjLAx4Ysxm2ykoDJFk4jI1Ll/z6YFoR7DbsfL3W4RoMwp9HjKznuszCHBcRIOwaUj8keDKzH3e1SEQEOSjqcXcUir8gpVLBvSLxyQnjXgADge+sHTTTqdU0+IZvx/W+n5fU4xeuFrKYqJfUJRqlDpJT0WNUq37bKvMIt31KbqKXobDjD0fitgfhLcN/KGEvtTbE1uEA7CIakwBV9INf+ubXM/PXDds3KMJ+Mh0v77ZllZefQ2J1He0Kz9TZZnQs/zNngZMVUP/g2v7/cjHRAazxMw1oCiHp5xAUxvmr6gUn+W6VJxurRsrM6FOhtvzAUOYMzog72FFxJQsYNxUCEDY4sFlgd5BJrOFXj9Oeb4EPwbqH1z897WVvRoCUi1nPxUn0xGkT78NIo5JdVscbxBaTWUCp9Nh2EIIZjKv9A5cCMVvdylrmzWvlsptvADC+lHr+h2z48ubuHnb7dJHJY5jAQgXP+OynQQoeb+Raqaicjy1Xwh+h+u4opSdOrU=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635a3ed9-4b65-4712-1ea6-08db44be5641
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 12:20:48.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPTlMJy06fNUW8azqoLpDrW2+y55SHnxBFgy58Afjs49nNPppSHmevSUxhLccxYerls0wc5h3c4yyFzYWof1bZBarjAb8hvJM6x7j6RqV98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0780
X-Proofpoint-ORIG-GUID: YDirB1PLGffVuy7QKN3ekVAgYjiDWgJ5
X-Proofpoint-GUID: YDirB1PLGffVuy7QKN3ekVAgYjiDWgJ5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: YDirB1PLGffVuy7QKN3ekVAgYjiDWgJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 13:54, Mark Brown wrote:
> On Sun, Apr 23, 2023 at 02:11:54PM +0800, Yingsha Xu wrote:
>> Smatch complains that:
>> dw_spi_debugfs_init() warn: 'dws->debugfs' is an error pointer
>>  or valid
>>
>> Debugfs checks are generally not supposed to be checked for errors
>> and it is not necessary here.
>>
>> Just delete the dead code.
> 
> This is very much a question of taste with a range of use cases
> available.

No. 
https://lkml.iu.edu/hypermail/linux/kernel/1901.2/05993.html
We can do things with the debug information without filesystem enabled.
