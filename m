Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DF7186F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjEaQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjEaQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:01:33 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D912B;
        Wed, 31 May 2023 09:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8xcQH5D6y3JErzyz0049aVBbvPf7btKH1wo1MDT3EhWuv78leE2t9YdKKPFKAxppIrwADIqn4G63Gz0u6hpiaUhqvndfFDY3p9PEbZVWjz5jr1+OsD5E9EJ0ucV7uY9lw1TquAktFm4yWQZQsaL3JGwiUZeK0N/E3sPusFGNf8SDj2MRUuOoAq3l4qt4Fkj05oUELwoV7VlQFhIqbdduKDdiN6imxESlpipt8D11pV8Dv4oZljxEPBPF+/BPp7sn3okxxWpjq1RhulwPfW07yZB3eOSGNcfsD1NnxxRBqzCpX74aLIhe98CZE5lZKknrfqI1us1rq1Fbvz8VzgoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAJJHDvxT6WvPDgSLKpf+hfrsO9Te2WO4a69vyRkutM=;
 b=mqf5C1HKdSh3zUuwO166eFXBuIejTRDvE7LQMxIl64oanT5dmV5E3EFksg7qt5AqYusVejvKZSwn0UDJ3ggcQEw8fJL1pi9lExNC4Qn6s6FBo4jcP+WBVHn2a/5oAM6nPl9dqX+RunoNxZvNxh9Jw/feWMMsNAhNtmeBbMnP0uulRAK84wYA+wILi93tnjarGljAjWAgM/Lq0t+IwBBphdJ4XN/ZpP2fG1ksCiiL1kocl1NRmfRLCceKSm/VNm8y3PfmWV2oKdOznQZ15lBHejSnnRTAE377h4DBx2QEiUpQEtjSl19DliNllWjqG9cnUNnBQ/9b2vM0/Fe5NEYvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAJJHDvxT6WvPDgSLKpf+hfrsO9Te2WO4a69vyRkutM=;
 b=otMS955ircpaj/5BBrv49GmBbEtQ7QvzfynAeyfhn9Ajtd5nV9m78AFKcW7SuRcU/uQqhG3nk4vgPYHSNtS7x/1obSyVUYpP+kFVLMJmvRPl+eAC4ohcb5PW5glAQT1flyiMaRmA49YcsN0DZLgFOrxDH59QRno4qC8eKmOBd6N12HisBc61XoHLcqKmf86JKmEi8w1FTS8WDdUwj8I/n2ojauCZ7+lqJA1etTK20r8trddZfsFgnSjci8JyVwNAbbCezTvEo4Ae0k45XUtRcJTaPCUNB7y8A3wkTIX2N5LPDdiT8sL5Jqkxh5a4EQbFP5mr6wrBqauxFtMmbFFfGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VI1PR10MB3646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 16:01:27 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 16:01:27 +0000
Date:   Wed, 31 May 2023 18:01:22 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 0/1] leds: simatic-ipc-leds-gpio: add new model BX-21A
Message-ID: <20230531180122.12e1506c@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230531155457.31632-1-henning.schild@siemens.com>
References: <20230531155457.31632-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|VI1PR10MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: 906271a7-ed76-49d1-1419-08db61f04a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlzOGWfiAOQwkyPmvjdGHrWhNXPABC4KZjMuGRXIlOc5WyZTkhnZ0fy7H0LeQ/ZsJRL9RoHaTmiv1Dv8Qpv7I2oIe0bjuD1KsXUVgIjm6raEwzwhm+Ej/LSB+nL2sHLbhi/Wv2Cs1mOg2eE+HalZ9b2cVRw4gYDtFUd7NDfVK4d3gqSF9/vRMsoKgbqFHcoeEhjCAqwgqdvO51IkYZweqqGCdLGxKtnU9LzgWnluzru2pJydXaU6Bdw9A0FmICOHV8vEjClsx3PPKSxmJhmp3RNeL03agyho2xG3f25rstmRigab5NXqB4e2wgGcV9cWVQd93lCrlVyVJurCI3mMl1vnMHpm/gicoIaPMdXA2F0qiFkR3Z6aZ/i1vdRN8iAQZbHeakmVAktA6EFh/m2PSm/xcNOijVE+1QDvoh0HdKVRXSeKir/ss+4/DFquW0iH3OPC4ic7sfSeQBUVPW4vE5RkXxGhlOvZ8o+XGdtz0RyuNtaMwWW8Ltp2qQFX2rk1bktsuQ9X7RrGjSMx/QVZ6eIQHMYqueZlaa08PGj3DvEz/jPBJW4UXj5XnuUZhRZ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(1076003)(26005)(38100700002)(41300700001)(6486002)(6666004)(186003)(83380400001)(6506007)(9686003)(6512007)(478600001)(110136005)(82960400001)(66476007)(66946007)(316002)(5660300002)(8936002)(8676002)(66556008)(44832011)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rv2CJxeVdzyrGALf448G9tcEWLFH6d5IYKV5zOOOpI9ghVW3qmt3Ld/xTKqZ?=
 =?us-ascii?Q?e9vtqsxFEBEKO6QY9nXc/5USm5Xiuzyc+IBoGecpmaS/elj85UOXytnpkqd1?=
 =?us-ascii?Q?TV7PM69lBQUWaRGyIjbpLHDtFWE4ZjUFjN5aJjQqHz0Nr26zJlzOCTgAtd79?=
 =?us-ascii?Q?OyToZ9M6eCJgaqoJf8+ikhg/XuVi9JtOPtuBpLdNnKwv2kMUYmJ8BGCn5xIg?=
 =?us-ascii?Q?Vt0GNbeJb1Nzs+ebKViXLG0yO5DD/f5RFpMDlWaM/JtfN4ynkbJH6P8dVj4/?=
 =?us-ascii?Q?u+pcfICWos3mePtC/srg5UMC1ElE+nLi0zrH94RZmeYCaPQt4zacckzMqlR0?=
 =?us-ascii?Q?5fLYoC751Cg4lxIPu1emCGYGhytJkuND4DELzExA7BIwz+J/ZlDWBnNLtZBt?=
 =?us-ascii?Q?oiyB+G/bSf6KL3IH8DOCcY4uJTz8v7Zn0w25irNdZnimZSQXcmFpWxP3PpeC?=
 =?us-ascii?Q?9T+/NfETLJaMHaJx/WXow9xz5BFIKWV3yjXIz/ZHgDQiSQ11+mTHQJ4prD3U?=
 =?us-ascii?Q?y5q2zX74CyMO065GImHvZkFz4fbzA7SSn8QQLUgunxG/XyotXlEEnqo3Exx1?=
 =?us-ascii?Q?u6s6WynQM/uOtsCw+CAQTRFScYtOgYWjbFmyvRqudsl6Xc4d3JYijD7bd4HS?=
 =?us-ascii?Q?W95aWiMlE3o84r8qtHGuP+GgF4og1qiA4uD1sfHUnGTX5lPECQJMM/8lg967?=
 =?us-ascii?Q?cvjJpojJi++d129AGgXXj06oBK84hc6CbOX1B9vV3Nj6t6dLZ3jjK32aAf4n?=
 =?us-ascii?Q?cMNeQP0T37HQadbX1jIGCmQbDhbuy/q4zdI253jg+2QXDF2Pp76D3f5mgXDj?=
 =?us-ascii?Q?dn61D/mOsxaJSgs0ZIXiZrNw9G55eLnkHNNl0V6uowpDqDeRPxLMYULHErn6?=
 =?us-ascii?Q?/oXz1JwcNwHBmvDwOy5Tsrd3aM6TlWK54F2+Puir/o3IIfnGyTOkCvs1aREK?=
 =?us-ascii?Q?yPYEBs3H0LkHo1RsRphaZCjs7MxuL+FDe1/E80FmVY8ZYQaH4ZM+idSzxCBM?=
 =?us-ascii?Q?Js6vade00HSrvuRwDldoaUWzT09e6wMUsM0p5FBfcT+SUcR/d8yke57E9XjE?=
 =?us-ascii?Q?BML4kUrgB4M7jUZ0aW9wuCTKZDChdHvLPgerR346+oVrudKWlFwV/2vy25KH?=
 =?us-ascii?Q?niq+8JwTZ1p2vKe7fvVh0KnCZbJ3Ata/zMxzlEBh1Or0uwABuUl186UIPDUd?=
 =?us-ascii?Q?lAM14plL9CZ4OB4otQ5dx8f7SBQEvV3RRUZhXqi/fROXgA6GK7N70/8kPEsQ?=
 =?us-ascii?Q?xbYKWJwPo75usNdBjUmlzmE5A0mjnaT0b6PCgTdEopVBd5Yiji+jPS9VcrQ2?=
 =?us-ascii?Q?Bju+k6xb1koCckgEgWUdSaSEiAc5WDj5As0VkHlSlDrK0RvHJcd+WIZdt26S?=
 =?us-ascii?Q?2pi1b+5j+6JtusUQu2a70eFiTWE0ibeKEYs0GljPaqqyEvhLmTVUVtLLHHBJ?=
 =?us-ascii?Q?oHvwd7N/Ac8Gz4qTEQkheQ+RfwW+jJlXfJAlLHEXl/XM0E5DBWYuBCygCI2H?=
 =?us-ascii?Q?K4FoCwrgNt9e6Y/8C3l1L0wT4GDh11sw/rWe1P6L3UFe9ofAqVpWvvzh5cks?=
 =?us-ascii?Q?V6iM+CYM0e/F7hwqQYnUCSrI0Cxj4wrxUFK+96YJeGiI6N5x6MD1JpOP3nAh?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906271a7-ed76-49d1-1419-08db61f04a40
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 16:01:27.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZV0M3q1Flxc6KvQ23NWXeXagSszx22eJA3pvjhe3QZak15bn0XhTy5ZvXEtEDKLIktwl7yfkkNGFvC615xG+kfJbxS192InhjuEgGmIidy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 31 May 2023 17:54:56 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> This is a rather simple patch adding LED support for yet another
> Simatic IPC model.
> 
> Note that this is based on
>  "[PATCH v4 0/4] leds: simatic-ipc-leds-gpio: split up"

I have been waiting with this until the split is ready to merge and
until i got access to one of the machines. Got such a box today and the
last comments on that split seem promising, so here we go.

There is at least one similar IPC still to come, but that will likely
be contributed by someone else from Siemens. As we are trying to get
more people into upstream work.

Henning

> Henning Schild (1):
>   leds: simatic-ipc-leds-gpio: add new model BX-21A
> 
>  drivers/leds/simple/Kconfig                   | 13 +++++
>  drivers/leds/simple/Makefile                  |  1 +
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
>  .../simatic-ipc-leds-gpio-elkhartlake.c       | 57
> +++++++++++++++++++ drivers/platform/x86/simatic-ipc.c            |
> 3 + .../platform_data/x86/simatic-ipc-base.h      |  1 +
>  include/linux/platform_data/x86/simatic-ipc.h |  3 +-
>  7 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644
> drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> 

