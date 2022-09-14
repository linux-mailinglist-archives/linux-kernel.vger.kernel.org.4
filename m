Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC90F5B7F30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiINDG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiINDGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:06:21 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1C6CF55
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:06:18 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2gVMO015186;
        Wed, 14 Sep 2022 03:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=2NZhqdg3bkCmCSUQr3MnAes+PgmIYpKCYn37umJi54E=;
 b=IpQBuSH/sjjNTDeyIbtxKiKorVELFIQ6ee7wyylqls0CqegfD/UKSWnHtWDrXZFWDbvy
 YEvROA+9I5alwAP8NpaI1yl6bJPdOXAMLpwoXhTw9Dxz+Egz8j00yPt+KtH/5Twl2Rop
 7XA0QX90ZVOcFjDSb6bg4tqXjPyszcAF6PUB2XHZx6RvE42nz1+QIe3D6EDhVdwrFzNe
 sKKvuHDxOl4zDU2elKW7sRO9iPy1rPM3WCK2aROGU3+mwmOFJcZjyZvrxSuRPVVK75q0
 pr2BpioVti6QdLB7dJIy8u+ed34N7BZxdvxenwkkrcY1dQrgVpQKsvcQ5ymkNXEETmg5 eg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jk4tng2ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 03:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0f465EdDfIAusF1/3xV/XSdou1MUWD3u/ls+Vd2EzpBJ3kjWoWxlGPPQo8UrUIj43HgOJwsI7ObtU1yQ/zOGwWPtMH1ngOe8fCCmdWTBz97QNhAIiBf/Rk2I2hmKDA0DEVcADYWGWGSKwL4UpH6aBnowO7b400t51959BCAydDsEnnsZ+W9j0bwfFPc7VamKIuhk6BhttOJ9lAZf3Ca/9mMAy5RBPI+IRPME5wPloK8XjdtpcIy9PnlNE9f+giI3jW/ZA/yKtvAQBqpYZdiD9CvL9D00162WXmiIAUrNi7BNJxcccDi81ImyBBpGwuaezHmjWcmkH/LathubNMo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NZhqdg3bkCmCSUQr3MnAes+PgmIYpKCYn37umJi54E=;
 b=b6H5rXpE1yg/SrgOSyeGWXIjFJOKFF6zDyIcM/twt0ON+1pxFXw6I/4M5WvMFsVGXZyBUZuMPP+zeTgLnGxxj+w14oJbo0gvXysbaKbx9ShAGNBzgx4k3hNwGTJgMWzz4fJn2j+o/1YpDjaPYA4or2DYblIkS+UWiIbZwqXPvGA6nV/pr3LlH5eqHGQpSS+lUu5S4EhPIQCHJTLz12aAbkLnqcrS3XXPk2+GUAz2L1hotbANRL0LbTsLuWbPSyK8zs28FIy2zMk3FUjl2O57vTOXHnoRW3Y9zpe5+k6E3q++kSIMwt0hT9jzrEhmt0HLom51LJks4bFfZ/3lbiuEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:05:31 +0000
Received: from SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::5077:607a:fb5b:9cfd]) by SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::5077:607a:fb5b:9cfd%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 03:05:30 +0000
Message-ID: <948d4846-dd7e-04a3-51e7-588d266cc28e@windriver.com>
Date:   Wed, 14 Sep 2022 11:05:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace
 gd25q256_default_init with gd25q256_post_bfpt
Content-Language: en-US
To:     Vanessa Page <Vebpe@outlook.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220913084023.2451929-1-yaliang.wang@windriver.com>
 <MN2PR17MB3375BC0E5878B19651475413B8479@MN2PR17MB3375.namprd17.prod.outlook.com>
From:   Yaliang Wang <Yaliang.Wang@windriver.com>
In-Reply-To: <MN2PR17MB3375BC0E5878B19651475413B8479@MN2PR17MB3375.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SA0PR11MB4766.namprd11.prod.outlook.com
 (2603:10b6:806:92::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4766:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: c93af4fa-5690-49dc-44c1-08da95fdfb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUsM6DsqyFppzsTstT4ttRcCKpnqrbyiaDYUJ35ZMID/UEmGAEXLXPvQjmVz+xncJPofCNNmA2GbusRSLq6dR5iX8OydlUtwEkWWnTIPgQOCC/OAxHoJI2Tk9I8BkOtIrebikN3u3TUezVzOOJwMcw/iebNFuF+3mGuBTcZ52a7VzesJBkRNM6zDlB3mEeThfr1OvJTrBPaJ+zE/xJhCWU83EEK5GmFmVjPBeCGqLNLHeAHOJ218WWRykrYy8AMDbUxWJEmZEq5bNrKX/JV4NVpAqoQVccbHBTZNFhyKyK35ida+OQTeVvqh48eNQpfgUcBuDVlhQlfWDN+ydm2egVyDbQ+kvOXbMMcdxUC7HJUZUgfHpxOnexk/61nS/uY33M3zMARCgjt+zh4Tx26eXZj4liXjLy/PbOxnFh1SJfy2M2sukaAsUuVnguW2/QJ5w04M/HqmqbQIISoYOCgFotRVX0GnWthioLej1JDkV7qbHiTQ6HHkick4pAy+ab1XnfvJAr82pXnWjCmJkHQ9C2ln+KoisGEimJNCR9gO8+aWPXUiU915zvgB2VzESzbT4vRm54DRWEB3v+YoWNpkWR2LIGBYdc6C6L/YiCv+w2Tm/Kb4uHBycmItAbTvjSpBJQtWtINzKKRpQJ5MqNYvD4mtUe6a0CDAeXBMatfHW16gvbfHVVzO0kD+hwEMBOwGj8bU7ZRWEMDUAG3ONsIDiRmqJX97kUzuIdBBMdlH8mo5lDvavk6wWlI9IdcwdDDnhW1emljZwNNbnAKEZur11RvrJN7l8VOrH6OXeej8oi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4766.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39850400004)(376002)(451199015)(110136005)(54906003)(31686004)(6486002)(478600001)(8676002)(38100700002)(2906002)(966005)(186003)(83380400001)(4326008)(41300700001)(86362001)(66556008)(6666004)(31696002)(66476007)(66946007)(36756003)(6512007)(53546011)(316002)(5660300002)(6506007)(26005)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFN3cStDdzlVMUFxQ2lsSlNwUGlicFQ0MG43OHc4d3Evb3RmSDBQVWlLdlF5?=
 =?utf-8?B?SHladSttdXBuS2NtYVhFY1ExTlh3cWN6WkFkSVVSdEVZTGErSnRLS2l1elZj?=
 =?utf-8?B?TldNdEZ5SUFiRWVkcGhZQU0xbDBCVnNyUnVhU21RNXN2c3hONGpUcXF6Mno3?=
 =?utf-8?B?OGMyZmYrZk16WUswckJaYlZiWWNTYW9OeGFlNm56djcyWlN4TUhaemYzVkZM?=
 =?utf-8?B?NDRnQ25xZFRibVVkZjhRWnBhQ0E4MTRmeWl1RXJ3b0FwT1A1MzUxWTM0a2hw?=
 =?utf-8?B?UXVjVmh1Mk9YeFZNT01iQ3VPK2k3VGEzMWRZOEh4akJqNkN4Q24xYU5ob2pH?=
 =?utf-8?B?TFVrRVFqbnVGb0FSTE1ibVE1Q3diWWY4eDVYWlFDeE9ZZUJydmh3aTJySnRF?=
 =?utf-8?B?RUpXanlXNmxWdVZqbmQ2cnZCSlFZOG1sNHpmRWptUUpyazFzMzNDT2JKR2Rx?=
 =?utf-8?B?Uzk5dkIrSTFVM1lLOFlubTY4VmgvczhxUE42STMyOHpJZU1tSGNOK0haNTBS?=
 =?utf-8?B?K0NlMjZ3c1VaeU4rekMyYXdTMHVybzhMcko2bDAxdVRjRE1ORGJ3NG5yS3ly?=
 =?utf-8?B?U1JHcHJCNVJwdTE5VUhUOVQ0NUdCQzdpcTRuSjNzNzBIaXgvKzZnSlV0dmRJ?=
 =?utf-8?B?RlFuUTZFdHZBbVdURTl6Sm5tNCtwd0VDWlprdlNSSEt5VFVzNkhXa3lkaHpI?=
 =?utf-8?B?Z3NQNWVJUjJwN0tlYnNsc2FvQjMrUzhvSkkvV0o3d25uVFlEVUtOVUhWRGEv?=
 =?utf-8?B?c0piUVArSmlzRktCNWl4RHA1ZUZYRjh3NDJyUUV4NTNSd0N1Q0hXYUE5YjlU?=
 =?utf-8?B?UkJ3NEtVcjNZTG5QUWFSb3NXMG5PUnRIVGRBOFc5SXEyR1dTOWl1M2NwTU1I?=
 =?utf-8?B?Z0lnMEp1M3hpV0gyRHMzd2RCakh4ZzdNK042TTBvaTNCUzRBY3dTemlvbVI5?=
 =?utf-8?B?OGkyM1dXaUdlQ2xXcUxDdUQydy9TOGcwdzVYU0dxd01iRzVkVXlTQ05BQUFJ?=
 =?utf-8?B?a0E0RXp2WVF3c0FUQ3FDTldFV3JCTmx6MkdkZW5OWkZBRkVuYVh4SDM0N3pK?=
 =?utf-8?B?a2FIREpuUzRyYTB0WkVpS1hMNnMwYjlJS3VuSDVweXlLQU9mdDM4VStseWQ4?=
 =?utf-8?B?d3NYWkMvamFkajV2Skc1djNNbDZqYnF0LzFUMU4ySW5EaG1UUDV6S2Fzc3pD?=
 =?utf-8?B?SGRwYkdYQjBBakR6OFJweS9Zci92NEdFcStnY1NYWnJHWUg1amZGTTkzNWJh?=
 =?utf-8?B?dzlPZEx2U2dsb1JNWVowYk5vdzkzOVRFdDAvZ0VQN2VUUkduTVNiVzEyaVkv?=
 =?utf-8?B?bDlCN0R4U3V6SERvRzNVS2FsT25JdGhJVFNDeUErVThVbHR6VFVVNnhnK0Q1?=
 =?utf-8?B?KytpdndNMnMyYUpmR3pyaTAxUHBTbkFGV2J5UkQySWR4TGxVM0NNa1BUM1dR?=
 =?utf-8?B?TlZKeTNnZUVvYnZLQUFqYnRNbjRwblk0bncwVFZ4RkUyV2ZPZ1FPbDlhb2Q0?=
 =?utf-8?B?Q0VLSEZCVmZGRWdBTGxsa0tHTGJDSUJtUmVSN0xpNWZReER4azMwMlZBZ3ZS?=
 =?utf-8?B?ZkcweU1FQWJjaFhEZ3VuT2pCdCtnZ3BpSUJxNVZ4ZkNXNnovT3FGeG1lL3Nw?=
 =?utf-8?B?dXUzcWhvVFZLSGp2dmY2S05teWw1bk93L25jdTVRNkJpakZKSVErLzgvbk1R?=
 =?utf-8?B?UFFsSUh4Ym54bG5IUWg0Z2tiVWpkcnlKYm5YU1R6dFFNUER4YVJUaG5UY2tJ?=
 =?utf-8?B?VXFabmgyeHp4Ky96NWlZUkR2YzBCV1FKNXk1NzRKbFNEbU80M1I5aE11Nmht?=
 =?utf-8?B?dmpwODU3QzBHUmdSLzN6Y1cxSWNNUHkyOEJiM001K2RjSFFqQ0F4NmdpYjdT?=
 =?utf-8?B?K0sxVVByS2hFckttTk01bDFUTUNwbURPRGpoblU0M09LN05sR2J0b2NnRS9u?=
 =?utf-8?B?NHh4dTc2MXB5Um9zZWZoeVpISlB1T2ZQSjlMUjd1NE1qSDBxV0NyeWFXSXNX?=
 =?utf-8?B?MFpjeXoxNDlKaEJVT0N1eXNYc3dHWkF4aVNyMXo4RkJ5VWl1SklkZ0dYY0dY?=
 =?utf-8?B?dUE5cnVpVUV2YThBbE9uemxyZEVSOVNoMWFySnJNYUtnaDdhdldvMVh3eStw?=
 =?utf-8?B?c2pCd1pVN3JzbmFzdzVZMVVpdzF2YXoyQ0IzZDFxQk5YRzhDT2pVNlY0bFdB?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93af4fa-5690-49dc-44c1-08da95fdfb71
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4766.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:05:30.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ylpWr+k/3OqbccgQr8xN8lf/rDFw+R2zI0zMPGXs4llll0u1YWEN1G8dXQ/0GgmDLrOVtC2g0MOmj1wC4FIf4pSqnNHhngrvfblzHUfVb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-Proofpoint-GUID: _tQ5j9P-LSg8pk53TTgv5o_wdpk4-4SA
X-Proofpoint-ORIG-GUID: _tQ5j9P-LSg8pk53TTgv5o_wdpk4-4SA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140013
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the mail list can't receive the email, I'd like to send the 
email again.

Sorry, I didn't make it clear.
I'm doing this because the flash info member parse_sfdp is initialized 
to "true" by PARSE_SFDP macro, as you can see below
         { "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
                 PARSE_SFDP
                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | 
SPI_NOR_TB_SR_BIT6)
                 FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
                 .fixups = &gd25q256_fixups },

And when parse_sfdp is true, the function spi_nor_init_params() will 
call spi_nor_parse_sfdp() to initialize the parameters, and I can't see 
any other place to call the original default_init() hook in the fixups 
other than in spi_nor_init_params_deprecated()  -> 
spi_nor_manufacturer_init_params().

After checking the history of why we are adding this, that is to say the 
commit 48e4d973aefe ("mtd: spi-nor: Add a default_init() fixup hook for 
gd25q256") and the corresponding disscusions, I believe it was added for 
some reason, and we need to add back this function.

On 9/13/22 18:46, Vanessa Page wrote:
> **[Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Why are you doing this?
> ------------------------------------------------------------------------
> *From:* linux-mtd <linux-mtd-bounces@lists.infradead.org> on behalf of 
> yaliang.wang@windriver.com <yaliang.wang@windriver.com>
> *Sent:* Tuesday, September 13, 2022 4:40 AM
> *To:* tudor.ambarus@microchip.com <tudor.ambarus@microchip.com>; 
> pratyush@kernel.org <pratyush@kernel.org>; michael@walle.cc 
> <michael@walle.cc>; miquel.raynal@bootlin.com 
> <miquel.raynal@bootlin.com>; richard@nod.at <richard@nod.at>; 
> vigneshr@ti.com <vigneshr@ti.com>
> *Cc:* linux-mtd@lists.infradead.org <linux-mtd@lists.infradead.org>; 
> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> *Subject:* [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace 
> gd25q256_default_init with gd25q256_post_bfpt
> From: Yaliang Wang <Yaliang.Wang@windriver.com>
> 
> When utilizing PARSE_SFDP to initialize the flash parameter, the
> deprecated initializing method spi_nor_init_params_deprecated() and the
> function spi_nor_manufacturer_init_params() within it will never be
> executed, which results in the default_init hook function will also never
> be executed. As we do have quad enable function defined in BFPT, the
> post_bfpt hook will be the right place to tweak the function.
> 
> Cc: stable@vger.kernel.org
> Fixes: 047275f7de18 ("mtd: spi-nor: gigadevice: gd25q256: Init flash 
> based on SFDP")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
> ---
>   drivers/mtd/spi-nor/gigadevice.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c 
> b/drivers/mtd/spi-nor/gigadevice.c
> index 119b38e6fc2a..bdc4d73424af 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -8,19 +8,24 @@
> 
>   #include "core.h"
> 
> -static void gd25q256_default_init(struct spi_nor *nor)
> +static int
> +gd25q256_post_bfpt(struct spi_nor *nor,
> +                  const struct sfdp_parameter_header *bfpt_header,
> +                  const struct sfdp_bfpt *bfpt)
>   {
>           /*
>            * Some manufacturer like GigaDevice may use different
>            * bit to set QE on different memories, so the MFR can't
>            * indicate the quad_enable method for this case, we need
> -        * to set it in the default_init fixup hook.
> +        * to set it in the post_bfpt fixup hook.
>            */
>           nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
> +
> +       return 0;
>   }
> 
>   static const struct spi_nor_fixups gd25q256_fixups = {
> -       .default_init = gd25q256_default_init,
> +       .post_bfpt = gd25q256_post_bfpt,
>   };
> 
>   static const struct flash_info gigadevice_nor_parts[] = {
> -- 
> 2.34.1
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/ 
> <https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mtd/__;!!AjveYdw8EvQ!cFcIju_6rdasA67JAVB5Ww727YTj7uzWhJ8HjkRjEJmn-BFGWsga9mPTqCo_m8WFT4Jcu8Uj0iME34B3OOc$>
