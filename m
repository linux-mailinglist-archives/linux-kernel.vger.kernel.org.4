Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04A0741570
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF1Ple (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:41:34 -0400
Received: from mail-dm6nam11on2101.outbound.protection.outlook.com ([40.107.223.101]:26287
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232506AbjF1PlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhCGRP/AeNirdQg+rhjEE0smyEBax2xZ9c+wb5sjp+FC6VDJVEedGn2aAH7oIod3aYu9STnIZLSxXo+Qyfejapgi71ufzni+EjOe+++Y0w8t3VGIPe09waEaCgH5aiWSrA14KgkRyEqC2w5dkBc/MRpiimUWq7uxKXBFRT/z4xXfzAX0NGCuIWKqHQpGflof8izQlAiFE4uVAG0eAKcVZa+9OruoUy/X4++CjmNe0RL3rxfX4iJnP85gtcsavmtxjv9pqsn2XQV+grTvBjLk0v/Hrf9zI/kT1q/nt+UxhHADVnF9aK6sJD0EM9EFAVbLadJ1hg+fndfq9TaLYcQSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvkj24T+ehx/XQGo/xamRnLrIopwwhfx+a6JJVeXlIU=;
 b=nAwBWbAG2zGHQL9RYsgEsldCFKEXUhjmdhsG+SUE0TV0gNzl7g6zPz8EKwZzCLIMwVaV1bzN2q0Jq83M37u9GJ5JhM03VNGAcaEa/kRXZ93Bvh6VwsJwMtN9XKL6s7YySkPb7RSv53sv80eZ8RsZ8p1JiFDGoK5UxB7cV7eAUO9ZNJQ76iG4hRShJy3+SXSUO+33eRJ6QLRcuqFK5MoB/4tR470CBUp6sa+Wa0R99/yfvczbZZXaLPfbr9AhswpMRn9kUa4+D0nOMxiGki9NhGDg3n6Ou9PnN9EG7t42OjKoIT4ThFXSTy1I/A14tDChLafDcif2FKUVjYeiK8Sa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvkj24T+ehx/XQGo/xamRnLrIopwwhfx+a6JJVeXlIU=;
 b=ebc30hAo0obm4+VuWSBxGn+gi0dNZWwFseYb9JSo0yBCk8ZaielOnrmnZRk4CAEcoIvVtDckGm0ei+nDjy3cnf9MVXUisUj3XhyLLg8TL9wjxIUdjd8H8jz4i3RFWg59D93D4vy+RdWFAQhKXTnp3HcAlgzxu+zT92R1z7nUSVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY1PR13MB6312.namprd13.prod.outlook.com (2603:10b6:a03:52c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 28 Jun
 2023 15:41:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 15:41:03 +0000
Date:   Wed, 28 Jun 2023 17:40:44 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ian Chen <yi.chen@saviah.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: networking: add UPF (User Plane Function
 in 5GC) description
Message-ID: <ZJxUfAyoHtABO2Sy@corigine.com>
References: <20230628085351.84016-1-yi.chen@saviah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628085351.84016-1-yi.chen@saviah.com>
X-ClientProxiedBy: AM0PR02CA0148.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY1PR13MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: ce934f8c-97ee-4956-eef2-08db77ee14a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orzA1r78Nz+eMQERCEBnFjg7CxASzvPRa+UNc05doQ+PffU0ZakCf3i3ndQeASz5BTr1esirmdOSEvRvZAdooaUc/yeVBdkoYkyAFjk/YqyxMhOg2vO7PrmHNoE50AHt8Z03jrSiaBxyMNffSWt+djKXlrdoEiO//rLI3t4v4UyYozsWpAgXYq5x8U/Z3vFQRtR1jN3NusACbiAGrVgdjlMekraJsXamfkTOfrQJhb9hUze/BS40MZrM4uK+//nOddTmipS60y3lK3G7SYAjtjzLOxbY64GaqKRn1cZxLY4uWC62ad+xKmwZ1BL4cg6M0EdAI5fCcIxdIyVWUIpz6b9L6xaKslplRIXQ3QqWEdQwN0B/rqtuAnrB5Q2/cZUWGu77Gdyznjq3IXoN2Oo7cU9zGYMOFZQ6uRsNhWtfZWnDc/GaqQb90oqbLD/ri/IN5Q79b3LwqIKoNxRtvZ7mKEw3BVkz0Mg6doNgKWc2YUfck98YT6QNpvpzbCpXs2Du/4BizaC+7++cJV3Tu5YP+/c5qlZ+rQneg1kC45UbUGO1Y4dm/f0SnBPdINTLFvAGE9G5f/m17CWF84zH4G0hJ+UZZ2snbTb91J/QV6pubQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(451199021)(66574015)(2906002)(186003)(6486002)(83380400001)(2616005)(38100700002)(6506007)(6512007)(6666004)(86362001)(966005)(41300700001)(478600001)(316002)(36756003)(66946007)(66556008)(4326008)(66476007)(6916009)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FrpPVEzxmh8XbNc6AIPrKNgoyWcW0UJwmUj8d7Yb3Tn4bicbGNg9LnKelAER?=
 =?us-ascii?Q?L90rZuknvNytVSPfGt3t7dja7oVNIHFkAfARxZjId1kFi4D0sgsDWPPU9e54?=
 =?us-ascii?Q?UO6cZizKEJs6QyzX2NHBhZ6kUGOvqoK0PiZDppl/rREIhApSZasN9UoxvO7W?=
 =?us-ascii?Q?YjcThJRF6+5RUJifdLqsXLw5xg47KIa4SaYO1cbf3YJ/B2cMEHqyVOrNVIrD?=
 =?us-ascii?Q?tI74rxWC554XYK8KwPFCbT+BbgPDqYv+nbLOZj/QT8TeS0tbEwofSh3Ro9IH?=
 =?us-ascii?Q?J9N5VYxaJttuctNxRjXaO5UOFREVBYqOCftZlzV5xhyYrBUK7hLDOUSK41lF?=
 =?us-ascii?Q?frVUkpJ7304ZDGlRuIMwcswpPgW+aHKegRVI/hN2lJQfKHNIHCsoIWyaNcC/?=
 =?us-ascii?Q?wAT+Bj0Hcqse4hKXxkZVFkNeM7wdQDy/HCsuJJm3vM+qzTVBQy/YkQ9cLrQa?=
 =?us-ascii?Q?N50A7UKdtrLCILGomwdfOdmqJJH6Wa3dLe04EQGnHlmJM7nj/Z3vHm5KIxrY?=
 =?us-ascii?Q?Swm/QVm4ueru4fRJ7HISlLd0mcfw4qEF+tun1JDjqyflBKz8MTb17qGGE7rF?=
 =?us-ascii?Q?A4ZnV63+oLF9FuKRiCJf8PVj+THngJD5C3NaN24t6Ii0TO3UbWzGYKzZSCLz?=
 =?us-ascii?Q?WboV+518ShbZG5PobeRgfiakcxkmYl1ViGo4dr0vef6np1ILKPHccFupQZOa?=
 =?us-ascii?Q?MsxluPDMq9h+4PujMLa9IwvzRbp/EDPORtjvtsQ2fz1HHuVcZy/1jfkUsgdd?=
 =?us-ascii?Q?N/MNwn8J9tl2ZYKVkrBir4RhqUVrZB+BVtGczcPlFKrY82lspidSbZ6UhW5G?=
 =?us-ascii?Q?HpAr6BuhkKaZC5IPh7Jfml24eNOGo9VMQK7+ZiJi9bPMbdx6FYf1hUaraP5E?=
 =?us-ascii?Q?gYpRS/NxNPeiJe903xmA7u8M5osgvVlCMSxq4ltImm05N1QJC8c+93ZoXXG0?=
 =?us-ascii?Q?Ljc/Cc7/FYj74rmt/KcYTDOVDyaQYNKLgr/w9eNPCDhAbqNoHFv/ZdBiAiLx?=
 =?us-ascii?Q?uSdTE9A8r1vFw2UZ27Slf8V97zNw/Wu+GtGN6A3Gv4+0AkigyBx/ZB72+7JL?=
 =?us-ascii?Q?/qyhPrbSuxci/WhmNnTlaeHWt+KN7SxdbHGVrBmqT9jDwMwG7m6mG9DPspXK?=
 =?us-ascii?Q?nHPlH7t9UMHXbsFVsWP6MTIwsN+pYVMnrt9DOr7UXLCuP2JCA9NRduj/T3vQ?=
 =?us-ascii?Q?OvuavjXFa8hzsPh28YhDJc2jhA94u2zqhKwFK3He63zTnAumSQZNgU8FdEDR?=
 =?us-ascii?Q?dJVj8YU3jutub98GzXFp7CiY3dTlDbkB2Spyv+wyv30WgUmSw5gNuJU9VI2/?=
 =?us-ascii?Q?7p4PevYCOWkeAgLOcflfo/6BrjI5vTZa1q4s74Q8msZoJ7kN5GdQM52uyo3V?=
 =?us-ascii?Q?p2fmPyjKCOCkKNO1xxVs6trPsMmWnbZl2dT16yXj/Pc9POGWe3tVJZwJfNQF?=
 =?us-ascii?Q?t4kEBZbuIH29NT0yRO9BePaOJVZ2zifQBZsctOkEKqwFoJsEJUUm+HNyzmRL?=
 =?us-ascii?Q?DIQHnX61aE38ZL4OG8xhz1LR0JNZ0dQLeqrcDXKcX2/ZnrQfIH1lAnP9Hl6p?=
 =?us-ascii?Q?AZmaUfdkxzmn6qaOC/R9GKAuEX69BGd9iObaY9X++Pm+pqABGRhTziBmYsCK?=
 =?us-ascii?Q?1eLVKrTslnxdXfesNkgE1F+XRSl6Zpj+djoLJD28D2lYgl2hb/f5I+ufe11u?=
 =?us-ascii?Q?Bwtg1w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce934f8c-97ee-4956-eef2-08db77ee14a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:41:03.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufjzskHRhoTXV0zvAx3MiCCS8bhcN39yEhNO1qpGxsZKbaT3KHHWLKsNHXLIlpv0/5LQ8mgQNbD2WTnqW0UKcDH/1u1vEwe3XL0qDLoFrTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6312
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:53:51PM +0800, Ian Chen wrote:
> Add the content of User Plane Function (UPF),
> which was defined in 3GPP specifications since release 15.
> 
> Signed-off-by: Ian Chen <yi.chen@saviah.com>

Hi Ian,

I'm assuming this is targeted at 'net-next', as opposed to 'net',
which is for fixes (I'm never sure with documentation). In any case,
the target tree should be included in the subject.

	Subject: [PATCH net-next v2] ...

If it is for net-next, then please repost when net-next reopens after July 10th.

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


> ---
>  Documentation/networking/gtp.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/gtp.rst b/Documentation/networking/gtp.rst
> index 9a7835cc1..c02aa34c4 100644
> --- a/Documentation/networking/gtp.rst
> +++ b/Documentation/networking/gtp.rst
> @@ -31,12 +31,12 @@ payload, such as LLC/SNDCP/RLC/MAC.
>  
>  At some network element inside the cellular operator infrastructure
>  (SGSN in case of GPRS/EGPRS or classic UMTS, hNodeB in case of a 3G
> -femtocell, eNodeB in case of 4G/LTE), the cellular protocol stacking
> +femtocell, eNodeB in case of 4G/LTE, gNobeB in case of 5G), the cellular protocol stacking
>  is translated into GTP *without breaking the end-to-end tunnel*.  So
>  intermediate nodes just perform some specific relay function.

I think it would be best to update the line-wrapping to keep lines
less than 80 columns wide.

>  
> -At some point the GTP packet ends up on the so-called GGSN (GSM/UMTS)
> -or P-GW (LTE), which terminates the tunnel, decapsulates the packet
> +At some point the GTP packet ends up on the so-called GGSN (GSM/UMTS),
> +P-GW (LTE), or UPF (5G), which terminates the tunnel, decapsulates the packet
>  and forwards it onto an external packet data network.  This can be
>  public internet, but can also be any private IP network (or even
>  theoretically some non-IP network like X.25).
> @@ -60,7 +60,7 @@ payload, called GTP-U.  It does not implement the 'control plane',
>  which is a signaling protocol used for establishment and teardown of
>  GTP tunnels (GTP-C).
>  
> -So in order to have a working GGSN/P-GW setup, you will need a
> +So in order to have a working GGSN/P-GW/UPF setup, you will need a
>  userspace program that implements the GTP-C protocol and which then
>  uses the netlink interface provided by the GTP-U module in the kernel
>  to configure the kernel module.
> @@ -162,7 +162,7 @@ Local GTP-U entity and tunnel identification
>  GTP-U uses UDP for transporting PDU's. The receiving UDP port is 2152
>  for GTPv1-U and 3386 for GTPv0-U.
>  
> -There is only one GTP-U entity (and therefore SGSN/GGSN/S-GW/PDN-GW
> +There is only one GTP-U entity (and therefore SGSN/GGSN/S-GW/PDN-GW/UPF
>  instance) per IP address. Tunnel Endpoint Identifier (TEID) are unique
>  per GTP-U entity.
>  
> -- 
> 2.38.1

-- 
pw-bot: changes-requested

