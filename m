Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AF2702F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbjEOOPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbjEOOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:14:55 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA51727
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1684160094;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cy1oFbmdQtSYLHm74D24mZIzp6ZjWtHqe06MhZi28QM=;
  b=YeaAFO8r2W2vMEnI/X5OtuScKwFAQH/6EovD7+wCbO8PDMcmHiTwnwa0
   bxlpA1t6tyNkooiRoMt6kLd93C91tKm0DZwhF4FY5Lfdi7tWbut/FM8j9
   p+ZjhoHOMw1FsvnN6/FlyzJWbxBqGADZhPFgr6cRDbBMydZd77LRAhWOo
   s=;
X-IronPort-RemoteIP: 104.47.57.169
X-IronPort-MID: 108965059
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:EwNl56yYMOC0pMVtLDJ6t+cXxyrEfRIJ4+MujC+fZmUNrF6WrkUEm
 mFLC27SOa6NZ2Tye9p0Ot7g8hkCuMLXz9VnSQY/rSAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+UIHUMja4mtC5QRjPK0T5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KXNi2
 a0+JSIsVxKalfiGx7ydDedRpNt2eaEHPKtH0p1h5RfwKK9/BLzmHeDN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjeVlVIguFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuiANJDSuDgq68CbFu7324yBTMVUHuAk/Sm1wnjXet+L
 BEu0397xUQ13AnxJjXnZDWyuFaNuh8RXYoWH+BSwBHdlILX7hyfC2xCSSROAPQitckrVXkp2
 0WPktfBGzNiqvuWRGib+7PSqim9URX5NkcHbC4ACAcAvd/qpdhqigqVF4gyVqmoktfyBDf8h
 SiQqzQzjKkSishN0Lin+VfAgHSnoZ2hohMJ2zg7l1mNtmtRDLNJraTxgbQHxZ6s9Lqkc2Q=
IronPort-HdrOrdr: A9a23:MWVvuKz8ncR9w4XmeCU4KrPw6L1zdoMgy1knxilNoHxuH/Bw9v
 re+cjzsCWftN9/Yh4dcLy7VpVoIkmsl6Kdg7NwAV7KZmCP1FdARLsI0WKI+UyCJ8SRzI9gPa
 cLSdkFNDXzZ2IK8PoTNmODYqodKNrsytHWuQ/HpU0dKT2D88tbnn9E4gDwKDwQeCB2QaAXOb
 C7/cR9qz+paR0sH7+G7ilsZZmkmzXT/qiWGCI7Ow==
X-Talos-CUID: 9a23:9Sn5GW/fnZSJxuTPQoCVv1w4NpEDf2/89XXJMVWIDmhPD7Ooa0DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AGl+QtQ7lvvvL4fq6zltNkGcvxoxx4YWjJkMIsa4?=
 =?us-ascii?q?0ttbZcnF2Ahaa0Q6eF9o=3D?=
X-IronPort-AV: E=Sophos;i="5.99,276,1677560400"; 
   d="scan'208";a="108965059"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2023 10:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc/qTDNn3Qe3zJTQ3VfR7tDvGXzDL7iJq9SFiarO6/johkkxVjvo6zfT0r17hIUUB6YoEO7OIBl0t+1B1Iciq5Fr7Qp6YeaA/bmU6H9QcYP+gO0BOdiTSzsnggNxisqg5MkuCBAZJFk3hCGZUKf5mfwFixxJH+qp5g5G1BMvv5/3STLrb3ZP/fkPgKcyMcsiTa9KyPBBfqJlbZpMCrwTzup+Dza8KBbEOkZKiqn2DW6SjRRv6sjU4OqfrY6RabRmkwmzXJBZXs/gnLGGL7XOTFeogQyjJuSmwdqCBKyMSAwo5ngDTkMkBbVh0rp1q6D/dDZSZnMXayDlRgqvng9ArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvQKgS41atxKT9eWU2cNmvS9MeAkqpaRPixzcx/Ujis=;
 b=j7ojaqz2ffw2YsU2hWNozstG0ntH1MZHEbDD11Bn4fkzHYK5gHa4ymfvSGDIR/JqO9NUJSrzpIgjtpgmqSPyX4aINOhVgJ7mMA63H703UiIe80VZzhh4v/rd0DEWJ3X6XYri2l7qv13ij2VDe3HuYzme5KX82m777tPlbWJpGx4o2dhE9jSIDhYN0TNXhjo/64gt/me6Y+JnqM+hTQ3GGBkrbiWqD4hIii9XkvyhK5cmroj57KXS+G0K8sf/JTiwo0zhZIRQQNxe0x6gxtY1QKOCXSK5T4KI+J9IMnrPITinbNSFYFPd5yNucQcx3JJIXYR0eYTarGAmRxqySRB5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvQKgS41atxKT9eWU2cNmvS9MeAkqpaRPixzcx/Ujis=;
 b=PNNoymYr5k+/ytIb7AYVmYK4PHV+Y7if12+OgxyAM/pH30WELkhJTqxK/9eMfxrnL8PPRhAR76MrJ/5FBDO38RJj4D/nFpjm0krNZoa47GCIfgBZ1ktu401tviEID1O+dQSkCUzYNFlW45RLIzl7hEIPnBny2iDw6hr/1e1PHPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5414.namprd03.prod.outlook.com (2603:10b6:5:2c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:14:49 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::81d5:6cc1:5b52:3e0b]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::81d5:6cc1:5b52:3e0b%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:14:49 +0000
Message-ID: <da39b4a0-5bf9-c204-ee27-a7d3eebdc3f8@citrix.com>
Date:   Mon, 15 May 2023 15:14:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/retbleed: Add __x86_return_thunk alignment checks
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230515140726.28689-1-bp@alien8.de>
In-Reply-To: <20230515140726.28689-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DS7PR03MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cec8914-5c6c-44e1-3f2e-08db554ebe14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVqbC7kYUWxv6qSOfVIjI15jAJFg7RY2taYB9XryNnFkdlWN5q3wOjQDxN4jZwY6t3WvD3YR+/B27nLCDKJs+LDyfQeM40tyz9twNc0CP/sDhrQHOB+XEFWH5c82bCgksK3RmIwsnh323HUO07vjKZoGNBWH7DBfkMHdqBUlMlRafMCoNGavX5rkDef0a2fhUfjh1eFhyG2MvOAR+p3poXmDgrnHnUVK9kWIja/NCV9T8R6G3xEQJfQYjjEI0730GE02j38Y84VvqOkADihNyTfueBy6IWrsL5+BZcBdnnuvoCcm8JzRrdLuiMa0zkengVUeMte0HD2nGcGNVV3j+P1zm2zW/pZtyzpya1Q7DvDyH6qfv++qFi6Pu4oU+uTg1oiFFxEuIUpdOhq61XvU376scjDXGNv9Qm8pQXfY+x1gTQdotDhkGIq3onZ/PBWdriVE7Q/RtBzhJA1YpwKVjr1Ys1U/7cdZDeZ3ugqI0rIC2mq8xpCXlC34fXDY4M+sLynGtGcrWCw/+Hf7wwBInDGSa5a7VQikUgTb1/O8mbLgjBxz4SX35aeQrr9neelKwMbGEjiO1P/nVFipPEusBVL6IHo8/gtglEQBe/I4+J8FqfmuLxKOdv0p+XEOWt1OfPJQxXWGKPgrnmQPbL4rUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(53546011)(478600001)(6486002)(6666004)(110136005)(2616005)(6512007)(26005)(6506007)(186003)(4744005)(2906002)(36756003)(4326008)(38100700002)(66946007)(41300700001)(66556008)(82960400001)(66476007)(8676002)(8936002)(316002)(86362001)(5660300002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxPYWQ5dWlWNHJhZGVuTnJEVHpEc3FPYkV2cXJKbFlKQXFYWXNFd3FDcVJY?=
 =?utf-8?B?VWk1cmxXOWlCdXhacXYrd0FFUThqcmRPdWJTanl5eHh6T25wRmxRNXJROE5q?=
 =?utf-8?B?RGx0Q2wxYS9LMkVrRitJY1YySHEyR1I2VktBZy9qaGhKOTZxQng0SGtCKytS?=
 =?utf-8?B?YzhTLzJHS2oyOFNlQVJEZXJqTk1VYk1zdkc1NTdGUUtqU1lmRXpGS2kwdjha?=
 =?utf-8?B?QW1FcjhBdEtYRW52T0dYSTVrNlMxWGlCNVQwYS9SdXhPaXNYVEZIL2VyNHNy?=
 =?utf-8?B?UXYwVjJMUEs2UXNJR0YrWTVLekVuUGFTd3FnTzYraG5IeEVad0E0R0NNWWwy?=
 =?utf-8?B?Yyt5N3ZyRTlLNDFKcWhZOVpuSUU0bFNaY1RWRm1aajNRS2NjTjZHR2J5YjY0?=
 =?utf-8?B?d2RVUW1hdHBicnorekRTR3I3WnkzT0FxQit0bTJhWmVtSC9jcy8raDBidEQw?=
 =?utf-8?B?cmZGL21rc0tsbzJTQU56QnU4QWxYTGN2TUE3UVZsV0ZMWGZrbFFweGRMMGN4?=
 =?utf-8?B?dyt1UzhqNytQNnZwMkREY1VoaHlITXp1VHZQbWVuaTNaeFh1ck04UjJISWJh?=
 =?utf-8?B?QS9DREpUaVVYcjFacGlNM3lwRzZJL0VONm5UTkR0ckpnVVFnN3paL25jVTl5?=
 =?utf-8?B?K2tqWE5Ld21lcXM5QW5IWjZwQzhvMEdzVEFWMXY0Q2JjcVJxUG10RU5iZjhP?=
 =?utf-8?B?ZGZ3NlpMSTNOclNPc0RXM25QNjAvNXhvOS9HV0pxRlNpRlNKUVQxQUxpS1JY?=
 =?utf-8?B?RHdBMG5waFRHdzZFa2ZuYWVUUXF3MEFuZVhHclZSeGtjcjFkS3VySXNoZkta?=
 =?utf-8?B?TC9ubWtQRHYzWGtDclJJNm1XZW9ZOG5wbHNWQWVpaDh0RXRJL3lOS3grdmI3?=
 =?utf-8?B?Q2g0UkFJcHdleEc4UlRCU1FYTUMrc2pRYlRRMWRYbjNnRG9DeEpZTHV3ZG93?=
 =?utf-8?B?WkgzZTZPZXp3SXcvNEt0b1RFVXhhcktTS0E0UC80aER2d2JWOHhucGZaL1VB?=
 =?utf-8?B?azZrRFhqRDdSOTVvZ3IzQjZpYVBYM1BxUzJGbm9vVzhWSk1BeTQrSG0wUGRO?=
 =?utf-8?B?YmVqOWpqcWF6WVAwVmhxbFdtZXFqNk9RbEgzczNBOFBVcHpXVnFQTGo2OUV3?=
 =?utf-8?B?Rzdtd2NPZDIwUmdmUFg2WlNmWXZGZ2hJZ2RTQUpsRFlMUDlUWU9rRnNnaVdI?=
 =?utf-8?B?TXhLcW52YnNPSkNWbU1RUmszR2phYkluWWxMYU9Td3JDdlpRRVpRUk9oYkpT?=
 =?utf-8?B?TzkydXkvYTFqL00yYkVUSGxXLzlVUmtISXBjVllxQ3hORHNhQjJubHMrUzhJ?=
 =?utf-8?B?QVlWVDI5cSthQXovZVZ1TzRFSDBCQjkwekUwMWVYZG9DWXlZZG90MXNjWnA1?=
 =?utf-8?B?MmRNM3BiTkJuekRiRUJMYmdrU2Nhd3BmdnJ3VE9MVTE1bkxmNjlFRzBIVmpm?=
 =?utf-8?B?MWpvTEVjTUpEUEpyTDgveHZZREpwQ2JPb3hicm16bFIvaUVSeENlNkJmc0NO?=
 =?utf-8?B?MVQ3SU5uRUtTWTlXcmNUbElmMXZLd2FEUk8rdWZKK1lHclJFRmIycDNrd3F0?=
 =?utf-8?B?dUVCeUtMOC9rUWpyblJVSmdHdjJFNml6YTMyNzRTdlpFaVAzcndpa0lFcDZR?=
 =?utf-8?B?dTlnU3BadTIyNHdzbGpVeWFvdlJmU0hYM2tVRWJFdFc0WW5GSk1PdFIzMUxE?=
 =?utf-8?B?WnlORmowanh3WlBwZGVRbWNBTWNnSjF5U2VSQ2tMS1JGczBoVERtdndUSE8y?=
 =?utf-8?B?a2RYRkJtNVIvQU5USVJOMFJFaDBNcXZLdGlkc3hvbHd5TG9oYlA5MzBaMUR0?=
 =?utf-8?B?d1RUVzh6eXlWcEZvZDJXRVk3OHRLS3ZnQUFWQk9KcSt0eVhhYkRCcVc1ZDFJ?=
 =?utf-8?B?Y2kyNk9hUkoyK3NXeWluYVRzUzd5cHBYcXJJY0o0YmV2bFR3RlhsZExoTTV0?=
 =?utf-8?B?SENZWEwxbkl5UTVMWkxIemVJTGtRSmc5OWxKLzRKUWV5Q0xnSGVuZW44blBk?=
 =?utf-8?B?aW9lQUk4ZjNqVGdoVWVpQU1YVUJEdmtWV0NZU2ZoRVpWbkJ3NzhjUnBrSjBS?=
 =?utf-8?B?b1ZlbEQvYm9jc3M2VlBiSjgxSDdpQnp6WU1BcFdlSnhUN0VJRURTYkFRSklT?=
 =?utf-8?B?Zm9JTkxRdmtEUmZRVjRzTGZLb1lzamJubUtTU04xSDhWZ1M2aExlajhuekRs?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X2BbxprT1L8cvjg0H75f1JdEFMwdKeSYfiLXqQTYy8WzdG8TBz2JzPS20shDQ4K2XasarVwRAo6PCfzmWGFPFvL1wA8KHXkRJh1F2cedveOxv+Y8PpTnxwYysXX6Tb7aY5fROJdVJbP1jOju3aHQpFtry+CckRz1/1X9WfJa7ybxFe0JpEkprX6023BlrqP5+TMBz+qdYN7heJwMtsXXSPRNjmLuSbL7YxOogjX5iJ9eSuNyZ9wJIghIc0Gbi06YNk+zeXuCm4u2ZyVmoMgJ2TcZfABYcf4cOE2zeFQ3M+iG+arsxT3qXdtjpczesd/qc5N/CkcK+TOegHLgVVc5GRfYLa+TnPpGRbrexIFgXRfgsiz0XeYHCnfJcrLQeV36hWIoi0DLGd9qAr6O4F49kuHAxeVVMggmmV5j5SBUct7/dBimReqaSxlMoO7bJXp0+zah84UyFpmHi4bK5odUkTq6UThztxHjZNVYzpvBbSUOfLKx2SW6v2fxOjmr5UMPtATq1O6NYkqak98nfvPVZjS0/Q+syl2M3Cl08b+XHmUdVhfafV68WrchcixDQ8WjDVo3obRv5hCJ70dqxGSwrqtAbxUN81jx8dgzbTrA9WBWxTGE+jlntbwLX4IhRCP377axuqyMhcVzMDuzyx8TCsB0taGWMZ6+6S4fvUcmylGwByGOdsipHftWsRbC08s7/4va3n1uIS+6fntHQdWZIsYvWLHzEq4IYufxamk2zpkFd8I5bq2+31U3OiVLlj9xFl+n6TpRI7uBz9PaSZ7lwtmVIKsdfQG01518wFu7lzoMYm7K+9ql5PfohGxGsKrb
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cec8914-5c6c-44e1-3f2e-08db554ebe14
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:14:49.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tzd3414kZXPCJ+MyntYQKv2SiIy4PGMR0vXwK7apEQAezsHZfmM8JY3jdK7II/3fFIgNn8N3YutjCHmattNribNvdIhszKE1tqaI+4Nnea4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5414
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 3:07 pm, Borislav Petkov wrote:
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 25f155205770..03c885d3640f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -508,4 +508,8 @@ INIT_PER_CPU(irq_stack_backing_store);
>             "fixed_percpu_data is not at start of per-cpu area");
>  #endif
>  
> +#ifdef CONFIG_RETHUNK
> +. = ASSERT((__x86_return_thunk & 0x3f) == 0, "__x86_return_thunk not cacheline-aligned");

Probably best to say 64b aligned.  The safety property is to do with the
layout of the BTB, not of a cacheline.

FWIW,

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
