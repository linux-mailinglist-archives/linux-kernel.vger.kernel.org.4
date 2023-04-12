Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B06DF657
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDLNBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:01:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2534C0;
        Wed, 12 Apr 2023 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILP2knkd8zCK1sf4k2EJ4GzX9qFOecb87G2CgDllGeA=;
 b=rsUKQU9c7A06O/yy9sgTTxdapV/qvWXnP3WzjM1R9Us6sdcWpTYOfLNbIlcP7XZpYqJaOCbNK0QDQVk7CVPNq4LWWIukwPMtmvo1aLQl6SNriB81zd3GQLgZ3P5NsIQMJDrUccMljTjEJnMKpkq+sN5Ae/KntUrNOOkEOGO9w5w=
Received: from DU2P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::32)
 by DU0PR08MB9631.eurprd08.prod.outlook.com (2603:10a6:10:448::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:01:31 +0000
Received: from DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::25) by DU2P250CA0027.outlook.office365.com
 (2603:10a6:10:231::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 13:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT020.mail.protection.outlook.com (100.127.143.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.29 via Frontend Transport; Wed, 12 Apr 2023 13:01:30 +0000
Received: ("Tessian outbound 945aec65ec65:v136"); Wed, 12 Apr 2023 13:01:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 316d41207d833f12
X-CR-MTA-TID: 64aa7808
Received: from 2febc3541596.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E1AC5131-6CDE-4048-A4E0-E87F4CA87FDB.1;
        Wed, 12 Apr 2023 13:01:24 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2febc3541596.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Apr 2023 13:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMkFy7Bvu8Wko3wt3OAzkwpI9goSEfFmCGuXax0G+YDIdBQ/PtCitf/k004O81xy9EOyZSu+RSWS9+70Ve0dUhB+hDhqUM26c9RiYDBhe1F5zrO+Gz9ykACjWOEwWzH3s7SOCWQ1AwsSZ8OjL3t3bUOke/Bco9TMUsA2l2VSjHp9SOMfIfzm3xewSPVb0ye79HPgdh9RNtKYcxjcWXtrXecP8qGEYOBbiWHQr00tGyD7OQJLA77hO4yORuIDSkPeWmu8SWNgBI8q9K0J7miHvz4RrkOshb7TQ9hznPv2FriHcbo1SLZakgnz9iAiKqyXxzfJdGP6UQ15jCDD7kbR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILP2knkd8zCK1sf4k2EJ4GzX9qFOecb87G2CgDllGeA=;
 b=LpRbLKJpIrQC62lQ80qnZssi57PigK8Dp4q6tF29gorTCZ7rFmoAus3/QlmVQ3ZQ+EU0jJ3FDig7wDFTQ8pS9x/cz/wrrGHEMDFx8o/hgR2aHq9RRaB1jbILyYupQOhgEiRmDX4MO4qgn1jTQITSlq7FsEIXU+V26wBfpt1W+bS6trjnSD9buI5A8cC9gJhr4Wdh1JJ7RPL1lSkpZHItUnbuTBBgFYik8UEV73vy/TMIg0eNP9fly3GAcMK64YV0MXUwa3dkNowr5OeMaFCpU0ZE5kDcau7EijMAgIcSNNCL12czftoLFe7Bzz0FR8Qes9Zsfu0WOzS79hyYQasHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILP2knkd8zCK1sf4k2EJ4GzX9qFOecb87G2CgDllGeA=;
 b=rsUKQU9c7A06O/yy9sgTTxdapV/qvWXnP3WzjM1R9Us6sdcWpTYOfLNbIlcP7XZpYqJaOCbNK0QDQVk7CVPNq4LWWIukwPMtmvo1aLQl6SNriB81zd3GQLgZ3P5NsIQMJDrUccMljTjEJnMKpkq+sN5Ae/KntUrNOOkEOGO9w5w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB6570.eurprd08.prod.outlook.com (2603:10a6:10:251::14)
 by AS2PR08MB8950.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 12 Apr
 2023 13:01:21 +0000
Received: from DB9PR08MB6570.eurprd08.prod.outlook.com
 ([fe80::6ca0:c6b0:2e2:3ef3]) by DB9PR08MB6570.eurprd08.prod.outlook.com
 ([fe80::6ca0:c6b0:2e2:3ef3%8]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:01:21 +0000
Message-ID: <b9cbfc6f-11b9-9daf-0c39-c5d6acc067ee@arm.com>
Date:   Wed, 12 Apr 2023 15:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND] uapi/linux/const.h: Prefer ISO-friendly __typeof__
Content-Language: en-GB
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Ruben Ayrapetyan <ruben.ayrapetyan@arm.com>
References: <20230411092747.3759032-1-kevin.brodsky@arm.com>
 <20230411210537.GA1800481@pevik> <20230411213946.GA1803920@pevik>
 <20230411172408.46a5b13a6cab27dda0c822b2@linux-foundation.org>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20230411172408.46a5b13a6cab27dda0c822b2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To DB9PR08MB6570.eurprd08.prod.outlook.com
 (2603:10a6:10:251::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB6570:EE_|AS2PR08MB8950:EE_|DBAEUR03FT020:EE_|DU0PR08MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e178ae2-54d9-4458-5900-08db3b560924
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iGxoiYG2HQjpJL9Gf9CTAMcp6boF56icm6CeHb5lWP8ZtmOaflaz75PYBrEx4HMSgZX+E6f+4AWIEN4oFh3pPmno3ivYKLaJbhVEuHM2uyiqv8Vss8quBqvQmitvUDbCLqBXB2EDkeBLW3CsQh6fUesRwbxypX9yZvbKH9C70GCIaTCjpftPN4Vr6mohGVyaoZ63RTLA694AImGimbkz4VFbMrY/gKV5CO90qwNprd+T3yVHl4Z27CJVkTbMqwTNAl7QDIIksbs711GbvVuYc38ToIxTJMblQkrtbFP30qGA2AfadO0kvrEj4MXLdJaWAIZLzkeJpOLzdiCYacmapMJkrvX59xSyrnrEhyLPsXXVg516xFC283DD3CtbqJy6kQJhauIMGfjJanRaLhbe6tgLMgz641BxAH3C4qxlRtGqa+UZ4cqu+SW/M5C7u2W0y/gXmY9WfLLINVWkfPFOXYa9dp3Gm7KrhS6Asujm4WvH0+NFEjfFkJ0JptkoiM+CgMT6FV0Z8VezVK2WJQZhGYikJBvox5yG1DJzQCKfHY2RbtBquR/cB8bJwH1suV0W+xhgu+BsM9pOsMOch8CC5Uq/IsNnA9913ktuDse9Vn6ZbRzwCexShVA2UDK/6QyEcJrjCOPgiLRYHi0JW+FT5w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6570.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(31686004)(966005)(66946007)(6486002)(8676002)(66556008)(66476007)(4326008)(54906003)(478600001)(41300700001)(110136005)(316002)(36756003)(31696002)(86362001)(83380400001)(2616005)(6506007)(6512007)(26005)(6666004)(53546011)(2906002)(44832011)(8936002)(5660300002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8950
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 106df942-8ea6-4283-d2a9-08db3b560316
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AM3MkKwOcJVan5uU/FjVx9h/QkhIkgVUxmlNqwZdDSLbt/eR1ADDQ6PTd6rhiBx1CgfP9v6/v9vANWYtKtB/XHJN6K6s+VmaCVwFb6bi6bJkEph++mR76XmOEdgOGctyMyIvlM45yV4YhhTkPQAYgqGRUnhgnomBSjg4kjXUohcexpKfbLqLLg7gf3cNgzVjgCM5v1G8JyZAs5uuM3MujbdusjbE08JlIZU28OkIm0VZUxroGUixS6BZyCgYWPCtEfBuwv0shicQ/PEgBhKlIYRjdbxI3ZVCa/OMHSIPVh95otzpXTY1Cgb5NcVDWKhoR45B6N4AID/wW2GiDL1aGrt7O3558Q03MMjWS/PTUHQAEOphUEZreg8fPCrInsCdB/lF077h8iCelv7y5uJaXaVVH0F8umSEHHeCbbf3xXq2xcm+eC1J13EiZWiSBuHZ0MmjVPXWeJW1kI2oei3yT9u65RSYlLWMbPt3/WWNfxNfJLox1KGsKbxEniORI0qBxze/96HuOhpmFR5RfH3ZO4D1CWpbROItsNZ4H6TOogtp43apYEMH6qE8m8picxFz6SkXulK7Arug5U1116S5jbM+cLpzmo7vfCsvDohVtCbemsAx2Tdc5F6dFZlis3Ke/LvedAdUSgk/y5WrbPlqZbTNhgmTV8UXVLEyoy+z6lXamZgTb/SosC4D9+kZtnAwdCbid3BaHEQ3kmE2XFvKyNygqURTqdw8q+6H+KywQbU=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(31686004)(478600001)(6666004)(31696002)(40460700003)(83380400001)(40480700001)(36756003)(81166007)(356005)(86362001)(82740400003)(47076005)(2616005)(36860700001)(2906002)(450100002)(966005)(6486002)(336012)(44832011)(26005)(110136005)(53546011)(316002)(6506007)(6512007)(54906003)(186003)(5660300002)(4326008)(8676002)(8936002)(41300700001)(82310400005)(70206006)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:01:30.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e178ae2-54d9-4458-5900-08db3b560924
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9631
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 02:24, Andrew Morton wrote:
> On Tue, 11 Apr 2023 23:39:46 +0200 Petr Vorel <pvorel@suse.cz> wrote:
>
>>> Hi Kevin,
>>>> typeof is (still) a GNU extension, which means that it cannot be
>>>> used when building ISO C (e.g. -std=3Dc99). It should therefore be
>>>> avoided in uapi headers in favour of the ISO-friendly __typeof__.
>>> IMHO UAPI are built with -std=3Dc90 -Wall -Werror=3Dimplicit-function-d=
eclaration
>>> (see usr/include/Makefile).
>>> But one or the other, you're right both require __typeof__.
>>> "If you are writing a header file that must work when included in ISO C
>>> programs, write __typeof__ instead of typeof."
>>> https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Typeof.html
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> Tested-by: Petr Vorel <pvorel@suse.cz>
>> IMHO problem was introduced when -std=3Dc90 was added (back then the cod=
e was in
>> include/uapi/linux/kernel.h).
> Well...  what actually _is_ the problem?  Presumably build issues under
> some circumstances.  Could we please see an instance of those issues
> and a description of the circumstances under which they occur?

This matters from a userspace perspective, not a kernel one. uapi
headers and their contents are expected to be usable in a variety of
situations, and in particular when building ISO C applications (with
-std=3Dc99 or similar).

This particular problem can be reproduced by trying to use the
__ALIGN_KERNEL macro directly in application code, say:

  #include <linux/const.h>

  int align(int x, int a)
  {
      return __KERNEL_ALIGN(x, a);
  }

and trying to build that with -std=3Dc99.

I do not believe this patch really fixes any other patch:
__ALIGN_KERNEL() has always used typeof, so it has never been
ISO-friendly. d6fc9fcbaa65 ("kbuild: compile-test exported headers to
ensure they are self-contained") could not have spotted this issue,
because the macro is never expanded when simply including uapi headers.
One could consider that 607ca46e97a1 ("UAPI: (Scripted) Disintegrate
include/linux") is the culprit because it moved the macro to
include/uapi as-is, but that's arguable.

>
>> Fixes: d6fc9fcbaa65 ("kbuild: compile-test exported headers to ensure th=
ey are self-contained")
> Might need a cc:stable, depending on the answers to the above.

Considering this issue has always been present, I do not believe it is
the case.

Thanks,
Kevin
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
