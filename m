Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F16DC3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjDJHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDJHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:05:53 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2026.outbound.protection.outlook.com [40.92.49.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACDD2132
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 00:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WphdeQe4Qt3DMOkvYlo2RJ52SSbOva8Iz2mpRM3L/uaLDcmBXcJbxvQXzmtDifufPLELRGGGTI3aBd/nKllS1BAQWhXybtHTQTGd1pPXFlsNttVoOWrM9zuedIh5BSS0yRLGsa+OGxs4JbaCy91pHE0G9M0dlGC1wo0TTJ+yBvfEiy5Dm8Rx9OPD2CpK0O1OYBE2N0d29BD5EPJT5V3jOVoMxSVpb59MP65htUdoQKHUNbPyNQ4vAwWxM9TPaxQD8r4mQk8k5x3sPg1JdgSbLb30RnRAYAcaGTo53zykiB2njZRXLSltxkeJ9bSNyZugwcT4bBlqOMu5fmXlCMUzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9G1IDdCLP3HE2jqWG/cDkJlLlXg6fI/BXVU7R1ny5U=;
 b=Dj7QfNg1ueyVZ+yzkO/VXs5qtxHTKO1LVneO+bUvTugh5bQH8VNk8FBkaY7llK0/jfjjJVFOMUoUkviCAlNGeOGr1x8pH7SBI5jK9IfV1Ig3X33NRMZygMT/rw8zQ4FE4azAJ3LF/EVtu2HZ1+eIjW3OhZSzRCpgLkFHk2fpxxx8LCfr4FJjqYB3g0DwBc+Qah83zEPh2H07T49mz0CRKvLGWY2D2KgslRHDfw12cxshS4lVZjkjHq59UonxOLzOP2LzxT2HTzqG7nirKLYnCPRn7t6U6ui/pHk9RE5HvLd4toardbLVfJZxqbcemd8YwIDzRKn3fvJQ2+GlAT2GaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9G1IDdCLP3HE2jqWG/cDkJlLlXg6fI/BXVU7R1ny5U=;
 b=j/Gp4VumlxM/JLpdVuJ+fwtDFcKW7BKevtB78HTQV/lVO5LcbFTeOHEU6DYTD62WNbSTJpyicXWVjIsxfiZ1TKaZ8IfdoonXNw87P7AB0dQ1CJbqfCDmx79LWnbA+YlU+X0CfFa3FEV3RKaGj9j/Jixg8ReABV43XNPt73gJTb0/g7MzalMvojqO+DgvSCJjkuswe+STq1yJ2cU2+bZ8oWxsOp9+3r8WNa//5n4mjtw/ZlCYnRdW0OcTpkflHQs/+OJT1pcJBjcWeKsG6sxQ1waUCZD8/kx38opXZtU0KGvRzAC8FhTF1thzLF4vV5f9/E0HVvHcskA1VcmHAoec8w==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 AM7P189MB0725.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:111::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.36; Mon, 10 Apr 2023 07:05:47 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::5849:317a:3d56:7846]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::5849:317a:3d56:7846%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 07:05:47 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-6.3-rc6/lib/maple_tree.c: Two style issues
Thread-Topic: linux-6.3-rc6/lib/maple_tree.c: Two style issues
Thread-Index: AQHZa3oGkjmGjA5gLkua9Txw7MMTQQ==
Date:   Mon, 10 Apr 2023 07:05:47 +0000
Message-ID: <DB6P189MB0568CB290411B23A176511239C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [1hIiXfPIiFpzb6MaMFHe/ZgpzYQQN00w]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|AM7P189MB0725:EE_
x-ms-office365-filtering-correlation-id: 869081db-bfce-42b7-1f8e-08db399202b0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyZeYUOxdns5YvB8My9QjWPzgHi9jV77fNVlKuF3NyWuPptXKQ/UvponlIdxqFV1+D1daaEzbAGBmLAV6W+qRJCFoS25mxKyjVNV0KA4SEWeuKKze1bD0Cg1RHThqKkKj61uUeKZqzOFCXb6UZ9AMw1C1N3GvZswtqzlGFOgmKd9YHsfb+zktfNTc8Ul36Tu9ItsEn7hS+S+97QkPzKtSVbXXp51AmbBGAtVNWzzA9+kISx6jZ9ObH3PDmp/T2sqE8QMKCloeXpC+S0fs/ZkCz4o0FQS7jkzH6220MTIb+P/oHJUsIQ5toNSV1BJaJb2kBLp4JZWcfDIohAPT1u1F9Ab2KqY/WuY7VKgZ804DGUhKnglKajcsjAfNS83SBIrn3ewew4JBezV8+j0rkYs47+jIbGGUJtO5ccBNhuWbZp7O/+//YPXPM3XgMBeEXq9YCqngqbKbEgXcOIGgZ2YBCP75WeLzyrxv7BCfmYupW5UhMJ+8frssoRbAUqN0jQy300A9RrBsnnzdLWbRbyQNXfPBiCh/W087GRHY/xOU2TTcKblVCmQxc9TEQFxHGpR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yapSnAfobcgMiw4L2vzq6jlS+AUfvQzkX2Q9ln4TkYTGlEoOLDI7JYSipM?=
 =?iso-8859-1?Q?1WV1csWgXOI/UzmL0SaTItwLBoyxg9aWCGDOUnPpKIFfT4D0N0+TD+vOaT?=
 =?iso-8859-1?Q?pe6/t2NU5Swf7cjUpnVuJfSZGIKJqcJnkEDRrbDWNdo4Yt2NtJnVtwVizK?=
 =?iso-8859-1?Q?s+H0hrC7oTRGVfCG4rsC5Snc9lI5ZMrIvPxAKUWiZ+BVABYku3whmrdecI?=
 =?iso-8859-1?Q?2UJkB4C5Pi51i9HYXWvrWulTZeVWcfolq9pO3tCZbGvni03+GpfyxFaqL7?=
 =?iso-8859-1?Q?kaFuSYz3gZJBHrXT6YfP+EwGfzDfiDEY0FJXqIJAQeUghYDSfyOxiCqw3k?=
 =?iso-8859-1?Q?qGeVVlF1+m0OHNtEnN3l7rxkvvxVbRnJ47PQb6tqUrwDumdQL+rwZZ07Ai?=
 =?iso-8859-1?Q?LNxkuBn421zhC4WXLpqxsulnKJKMVzjo2C6fUfNlXLk4HXUvW3OOdX+OXB?=
 =?iso-8859-1?Q?uOJMD4KaCbs3yFWKv29afL7g/5AnPaNTGFQNkMEGTU1RuZsziSeVwKOSJu?=
 =?iso-8859-1?Q?ItlTTVzk7O/1Cxg9c9WdvtjND4F5dZeTNQqXa1QeeUDRyt0BSbpKxAdYWS?=
 =?iso-8859-1?Q?dGf/bpG5kVfXc/jl6dVqB7FcfLAj0PkWFzbIfQwLLVZEnODhyGCVnzmeLf?=
 =?iso-8859-1?Q?WojNtwflHiDb3oM8EX2MxFt03hOf0gauc3nLEpc1qL4ATbgM9fvpBwZLG/?=
 =?iso-8859-1?Q?S+HcqBWF7aZikwHK8/mz6buiWOPoYITfWsRDdIlQYS3hqnmxBMAyV6KPq1?=
 =?iso-8859-1?Q?3xzX+wQE7T7ozWj6UsJ7nS6zCtKQueLXlU6py/aNOAc/Aryz5cGAyMy3ed?=
 =?iso-8859-1?Q?vgxxUiVaAVnQtWWLxY7AdNam74QayAcRNBFp5aUWyr6BBmTaP8R2heW+xz?=
 =?iso-8859-1?Q?JuWQ8vRmMEzEzSRiv54Fa9ItkWCKWhbnzc47S/vIoYtiKlAxYo3flBXgxt?=
 =?iso-8859-1?Q?HgUp9CvkRKOpeevXjzwzcHc/Bl6Ei9WxVp3a87fSM7LLRYTWP/NP06sUFw?=
 =?iso-8859-1?Q?cDx5AToOWk+EjqHsl9TX/JiTSKjx8sMgprbsVBe8Dy/iJ+9y3E+bKWOTie?=
 =?iso-8859-1?Q?/E7Y4U+z1o1nDWNNy5yBr13Gbvb2wK1+3WoT8hDUaqUKRQHenXVs4HwP2m?=
 =?iso-8859-1?Q?eUJvVRNuF5sTiC1Qe4iIMze7+Qj4g5+wUgEwzDqIPZRTKUWx0oMLSwRHJR?=
 =?iso-8859-1?Q?DM0qlOvHPD8JcvFbGvgfwN80CyITkmjzgynwEmAYe6nke5jHcMuIvX+G?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 869081db-bfce-42b7-1f8e-08db399202b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 07:05:47.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0725
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
1.=0A=
=0A=
linux-6.3-rc6/lib/maple_tree.c:1951:21: style: Array index 'split' is used =
before limits check. [arrayIndexThenCheck]=0A=
=0A=
Source code is =0A=
=0A=
=A0 =A0 =A0 =A0 while (((bn->pivot[split] - min) < slot_count - 1) &&=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(split < slot_count - 1) && (b_end - split >=
 slot_min))=0A=
=0A=
Suggest move limits check to before use.=0A=
=0A=
2.=0A=
=0A=
linux-6.3-rc6/lib/maple_tree.c:3289:11: warning: Size of pointer 'pivs' use=
d instead of size of its data. [pointerSize]=0A=
=0A=
Source code is=0A=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0memset(pivs + tmp, 0,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(unsigned long *) * (max_p - t=
mp));=0A=
=0A=
but=0A=
=0A=
=A0 =A0 unsigned long *l_pivs, *pivs, gap;=0A=
=0A=
Pointers and long don't have to be the same size. Suggest code rework.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
