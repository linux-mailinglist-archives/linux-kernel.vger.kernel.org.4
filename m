Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF163279F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKUPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiKUPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:14:21 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD362CFB9E;
        Mon, 21 Nov 2022 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669043383;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vwhDoO7tdiRatKyOMWQlRx1p7KK5kwcmauffhQUAy4I=;
  b=ag9YL9z3r48vWzBsdyaajvTq1w3FPx5gtxsPZlGlS+mQ/TTA+Yqf5eJi
   /O3R5Viake0jQoMvHAlSjLz++3M9HxnV1zmkcTSuJh7J1MAMRNMa7oKqS
   RtopoldzWusjA03gvXlXS9FVujx5umuKBoGoswKMU8pqqSCpvu6gsTS9e
   Q=;
X-IronPort-RemoteIP: 104.47.70.103
X-IronPort-MID: 84314400
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:cWUvpax7FqovEdqJYf96t+cjxirEfRIJ4+MujC+fZmUNrF6WrkUEn
 GIXCGmAa/3bamv0eY0gYNmy9k9Uv5bWz4BmTFc9/iAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTbaeYUidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U0HUMja4mtC5AVnP6kT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KWRV0
 OwzBj43VBbdjtL15ZaZS7A3rNt2eaEHPKtH0p1h5RfwKK9+BLrlHODN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvDCVlVQquFTuGIO9ltiiX8Jak1zev
 mvb12/4HgsbJJqUzj/tHneE1rOUxH+nANp6+LuQz7lxuW2vwlUpJz4fRAWgmcGW0FOXcocKQ
 6AT0m90xUQoz2SpRNTgWxyzoFafowURHdFXFoUS+AyLj6bZ/QudLmwFVSJaLswrstcsQj4n3
 UPPmMnmbRRtv6eSUmm17aqPoHW5Pi19BWUFfy4fCwwe/8PkvpownzrIVN9oFKPzhdrwcRnsz
 DSahCw/gagPl8kN1rX98V2vqzetoJfOZhQ46gXeQiSu6QYRTIS9T4Ws6FXdvbBMIe6xQlCfs
 T4Eks6F4eYmCZCLiTzLQeMREbXv7PGAWBXM0QBHHJQ78TmpvXm5cuh44Cl3DFV4LsEePzTuZ
 Sf7owpf7ZJXFHind6l6Z8S2EctC5aztE97NVf3OaNdKJJ9re2ev+CBoeF7V1mv1kWAynqwlf
 5SWa8ChCTAdE6sP5D63QfoNlLwm3CYzwUvNSp3hiReqy7yTYDiSU7htDbeVRuUw7afBqgOK9
 d9abpOO008GCLa4ZTTL+4kOK1xMNWI8GZ39t81QcKiEPxZiH2YiTfTWxNvNZrBYokicrc+Ql
 lnVZ6OS4AOXaaHvQelSVk1eVQ==
IronPort-HdrOrdr: A9a23:UQit+KPd2urfUMBcT6H255DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jztSWatN/eYgBEpTmlAtj5fZq6z+8P3WBxB8baYOCCggeVxe5ZjbcKrweQeBEWs9Qtr5
 uIEJIOd+EYb2IK6voSiTPQe7hA/DDEytHPuQ639QYQcegAUdAF0+4WMHf4LqUgLzM2eKbRWa
 DskPZvln6FQzA6f867Dn4KU6zqoMDKrovvZVorFgMq8w6HiBKv8frfHwKD1hkTfjtTyfN6mF
 K12TDR1+GGibWW2xXc32jc49B/n8bg8MJKAIihm9UYMTLljyevfcBEV6eZtD44jemz4BIBkc
 XKoT0nI8NvgkmhNV2dkF/I4U3NwTwu43jtxRuxhmbim9XwQHYfB9BajYxUXxPF4w541esMmJ
 5j7ia8jd56HBnAlCPy65zhUAxrrFO9pT4HnfQIh3JSfIMCYPt6rJAZ/mlSDJAcdRiKobwPIa
 1LNoXx9fxWeVSVYzTwuXRu+sWlWjAJEhKPUiE5y7mo+gkTuEo841oTxcQZkHtF3ok6UYN46+
 PNNbktvK1ST+cNBJgNStspcI+SMCjgUBjMOGWdLRDMD6ccIU/ArJbx/fEc+PyqQpoV15E/8a
 6xH2+wjVRCO34GNPf+n6Giqnv2MSeAtHXWu41jDqFCy/zBrOGBC1zHdLgs+/HQ0cn3TPerH8
 pbA6gmc8MLHVGeZ7qh4DeOKqW6CUNuJPH96exLLG6mk4bsFrDAkND9XbL6GIfNeAxUKV8XRE
 FzEQTOGA==
X-IronPort-AV: E=Sophos;i="5.96,181,1665460800"; 
   d="scan'208";a="84314400"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 10:09:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOTO6nrLm4F2c9bVccIENHRkp2uFoO5G+KZl6fapw29fvllb1CCw3noHm6O6QLBADjgFPKWYjJBOFjSvyMdVVJvg1PwmA4mOZwvUf4GlY1gfq/FLgeO549n7C1ni5S6Je6X3VbtRfrgERru36iWtY4VTOEYWtfgi9exzPOWLPWRxsK64/0ML0hY1iP+reEBNTZbRCCnbg2WuuH3DA/8anPw2eZNpDUKLBBW/65q1eNauF6LpkVkEzUw9D5+L6UWWRda3eXNxu9jVAlz3WZs1QbyJA22D91zNq/X1H6BKlJESm1kVMUg/r2PcAmStOea+9c/1kgADS7eHkmVvBcX33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJAV3gu9bvonr8L5L+A08ezmPNN3r1cKnnOY5J8L51Y=;
 b=cknetg0hP9CTL0I0JA32Q/n4nwiZn2cL+7w43rY2bkhAq9Hte9RnxXPgn7nVcUIQipt/6zfH81ZH7Ou8iGDw2q6n2bnWChHTQA61r7PCogpHD1jEI8Umv9PsMNVYMcA1DjOVNxZBz3WM3ohSG5zSUYam9kVmh8IBldrMDpFy0MXhsV5L+XWILJiIXSLwuOJsZASNA+VtpLBiWZh4Ve4X89j1PPS4nYywj3fg5flNsEcd8nkQN8kc+G3T8LYHSDsQK89dHhr615FAuP2+bEdspA/cIFlTJHTrauG9osVrrwlOySg+0VECGgYzlaNPLF4UwcvqBFS4yfkmy3XHlBJDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJAV3gu9bvonr8L5L+A08ezmPNN3r1cKnnOY5J8L51Y=;
 b=WnPmzXo+pu2iq2ty6th09TgMLuOYV7oqdFHqXke/JbA3ul19qoC+YjG9xwBGww3VNdC6z3Yo6QXWwpZ4SPKdkD8b0SvG+vVsEdlQolZMTzLsuRf7ul/wNYmZWrZIP6/pWCP4vxM4pNt29Zc3YQYYVk5X9HDmYSyXLN06+uRw9W8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by SJ0PR03MB6748.namprd03.prod.outlook.com (2603:10b6:a03:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.24; Mon, 21 Nov
 2022 15:09:38 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 15:09:38 +0000
Date:   Mon, 21 Nov 2022 16:09:32 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y3uUrAJrD/MfZFv5@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <d1042d77-eb5a-6577-9ec6-e6a7997f15d7@suse.com>
 <Y3uLXq1diou2lHu4@Air-de-Roger>
 <53a21308-0948-66c9-86e0-d576ab884567@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53a21308-0948-66c9-86e0-d576ab884567@suse.com>
X-ClientProxiedBy: LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::14) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|SJ0PR03MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 51243e71-97b4-47a5-14ec-08dacbd2685c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +m8Q/lMKx2EdRA5s4Z3eqYB/W4BXscYz1L2G/UOSejEdoXwJWkHOtZf5Dl5G2pjVm3r0QdXEi8EZ2aWlQOl9D6CJrmwPra2lwiQ8uUPacsdjtD+DkZnwP/1dPCoave4qfKr8nheM08QPZLO0ShQ2tkgJbe9LCGTiMe6lmQ9wYk+nnUoA3IacpRgTAeBlkbsE2VREn+F8/c7Qnl/97PtWQOVeq3VAck4KB17FkW88a56SWb26pslCKZ3SI8gnE2Bbay6eSvZc7eEKhhhzDBHUzLQ5Iju19diPHBgOa1PLGkYn0t7n3leswY0rv/wXWvdtx2KVnDG861tsSCgEF++0p5XdUIJ6KFM3xE56+nMtFY5cl4jlXyBYAq7YQA+3poRsIr9uBhZfeg0XW9Q5jTB/vPnrDdJgSPLYwLXWUJCqVyZhStqTzRoawZEFJIgCkiophXfgy1AWcsdzy09fkKE72jckObUtSReIRn4Z2PCvCVMKymG7cYI3Ychk47k23RTz2gmOD0wBwBGHemJqCUYZkqQ3MkhkIdnVSjWcCjnp6SdcatVEJHGspc1wegiew8zxlui+qdgz7fE5VjqfnLJ9YdXZC4atCCkX48Q3I6M2b50DE3A/A2dbowIqkyDakmxwPUY7aZeDxSPZINIGY7PsYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(7416002)(5660300002)(6506007)(9686003)(41300700001)(26005)(66946007)(4326008)(66476007)(6916009)(8676002)(54906003)(66556008)(85182001)(316002)(8936002)(186003)(53546011)(6512007)(38100700002)(83380400001)(82960400001)(33716001)(2906002)(86362001)(6486002)(478600001)(6666004)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVPc0FGam04RGw4VWcxcjhIV0tuc2czWlkzRkpwQzF3ZnhLUFByRWtLbGZv?=
 =?utf-8?B?S29BS0V0TWZxN3hrQ1kvU0VsN01SSE5qMmtBNXVMVDZuKzBsekZTRlYxVXg4?=
 =?utf-8?B?dkpyZ21xN2xkb2NsWlFVLzFyZEg3NnlWejBBTFRPQmVIMEZDV01mbld0RDZJ?=
 =?utf-8?B?OS9xZkwxVFRXbXJVK095cWdyc0tBWDNjODIvZ1htQ3JTbS9Xdlh5T1k2Z3Vq?=
 =?utf-8?B?Wm1kcEpOcWxIdG9La1A5bHprTjBBckppZjR6YWtLQTBUZGFyMjdRZmFZa0NH?=
 =?utf-8?B?QnNremVLTjlkbngrOTE3N3lTWUxQNW9kWkxlcW92Z0VTd205b2s1VzRjVjFW?=
 =?utf-8?B?MytMN1VqUi9BZ08rakNCUlk0WlZhVlJlclcwNkFPTzllaEthUUgxV2p5b2VS?=
 =?utf-8?B?WDEremdUVFNOWnBiTzR1TDdsQkdLcG41T1J0QS81TlJwcWRpeEFCQk1sMFBN?=
 =?utf-8?B?dk9ZL2JhbEUwbkkzWnZjbkxUSEJzaHVZZ3hQR1MzWk1yc1A3Yy9QZS9leDZu?=
 =?utf-8?B?Ymhla0VLYkorcGlOV0p3UU5lemhoZFg0KzlUQi9pSEl0RGJaT0JyVi9tVmpS?=
 =?utf-8?B?WWkvNjBQbDBEQ2crZHBaV3FHY2gzT2d6NlFsckhqS3IvRjVZckdNUjFSQXFT?=
 =?utf-8?B?b1JZR1h4VG9iNEtOaHg1NDlid1lqVXNWZ2RSQlpaNnNlZlBCdEZyYzJWVHUx?=
 =?utf-8?B?UDg5a0szNFMzN3JNdURVRjdwamNsNFhnWG9QaG4rY2FVNEwwc3AzeU1COHVn?=
 =?utf-8?B?bzgxSEJUdTIzZ3JwT2NKQWEwMlpqVXhCamVHbEd4ZGZWNmg0VnlIT2VRZ25z?=
 =?utf-8?B?aC9hZEJBbklmc2VBM2xQZm5jNkpWZVVrZXBuQkhMUjBIVWFOemcxSjdMa0ZI?=
 =?utf-8?B?ajRoV2UrRHg4end3VFI1UjV2Y05jRTUrNGFqYnZmRFJXdXNOOW1hTnpLUTZn?=
 =?utf-8?B?eGVmcXRPdTBzS3hTTnVzN1VqL0ZmOUp2SHg3NFZKb0NWZm5VNXV3MEtBbFZV?=
 =?utf-8?B?QVFpb1lLUzcyNTVOcWN0K2xOdUxtU2tETFRjbjBZTUVDdlVNNFcxVnAvNUhl?=
 =?utf-8?B?ZDVYTkxjYVdCWE43dnM5S3d3RmJubzdtZ1VEV3dwenhrMGZ4a3NsY3J1WUFZ?=
 =?utf-8?B?bStNWURWV2t4b2pLNURIb3E2a2V0RXE0L1hRa0syNjZ2c2tqdFpLVlRtaEZ1?=
 =?utf-8?B?VkRxbi9pUEl1ME02NTNDRExDYVprNWcvRkdmS3ltbXMwVFpkNkMzaXVwQmwr?=
 =?utf-8?B?RGJ3K1NIRUV4aDZyY2lhbUNKMHdONEx6c1ZabGFYVnBzQnNDTS9nUHd4MDZr?=
 =?utf-8?B?UFRTZzdpeGVVMFVSTGFCdHZQNmw1QTVTUnpZcWtCZEtMckJYUDhkMi9ZVUxL?=
 =?utf-8?B?ZjFlM2hEQzVROWo5YnlxdWhGRElvaE5nekpCaTFhRk5tbGVWVll1Z0NpbmpD?=
 =?utf-8?B?UktTczlKRUxzOFdydkY1Y2pwVWhVcDdkbjMzd3ZhVlhNZDBSM2JjanptdFov?=
 =?utf-8?B?MDRNbHFmUCtxUDVxemZoS0xyNDFnYWN6cS9YVWlqZlkvNXhiR0pWVUo5ak1p?=
 =?utf-8?B?MVVIYXdyV05JZUtlVUt3WHl2ZzJyQmlBT0ZDbm1GVW4xYVdHNlZZTHpiUFF2?=
 =?utf-8?B?dDZ6K2psK1dobmtxbWl2cHNnei9ndHpKWWF1YStoZlFVbFBJZy9zV0tkL25Y?=
 =?utf-8?B?SjVDNWR1NGFHRm83TTlyUi9zRmxHaUFQeldJUUZ0L1FacWlWdGNhZ2JRekdn?=
 =?utf-8?B?ckVKUzFPVUo2aWczZThNWUNiZTBJK0JQUWpSd2dSazg2aTJZYlZBS0EyOFdw?=
 =?utf-8?B?U2R4RU5kR296Zmt1Q1JjcHI1L3piM25BV3ErZzFHa0RCVk9tRHRqai9McmtL?=
 =?utf-8?B?ck5KUExwWHk3Z0puVksrNDl6SStMeDhYRmpXQjlWWTAwRGdMUWZwU3RzU1Ja?=
 =?utf-8?B?QWd6aFdwR0E5L1ZUUWREUXU1SEpHSXMwMHRXeEtTbGczbzZpUkdCalBxTHlJ?=
 =?utf-8?B?bzVkeFZ1Q1NEcHBvMFNwYlZBb3JnQndmRmY3MWthVHBGLzVqcTN2SUdaTjUv?=
 =?utf-8?B?QWVwbW9zaUoyazdwNzltRTZIanBsVkFPK1puUC9QaHhxemJPMEc0SDFobE16?=
 =?utf-8?Q?57691Lhvt6dNzSuJ/BwPBLZka?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aWNoU2FmNGpXWkxldmMrMG95a1I1R3Q1Mk5IY2VUQlJ6QWE4Q3BjMDMrSVVE?=
 =?utf-8?B?emRmR083SUFzRG96am1CRHBTaXNXSFZodWtLbGhDekxtTU93RTQ0dGNVVVBR?=
 =?utf-8?B?Rkx1YklQclgzRlBBYUdhQWlSdGRUU0M0cytTcXFCY3Y5STMxS1lnbERWN3N5?=
 =?utf-8?B?c0EwTnNnMlg5UlJnSkRCSmczZlV6R1d1L1lLY29TU3BEc3dWbENGUGVFTU03?=
 =?utf-8?B?VE1VbVo0UkM3K3pEd0JyQUxvSTZsVHBVdmNiaE13RW5UbzM3bnVmS2pnSFVu?=
 =?utf-8?B?UXcrcW9xT1huOTFDL3N1dURvUEtBdXlsQkJFR3Q4Q3YzOFVGU1lMMXhFaitv?=
 =?utf-8?B?dHFpd3d5V2JFcHhveXFraTNkSk5URjlneUJhcEpobmJEUmowbjgxaHVNYzN1?=
 =?utf-8?B?cHJoMU95TmNNMHdYMFdOWGVMaFFxOExvRGZIN0VSbncrS0RrWVpOYnhBS2J1?=
 =?utf-8?B?cGo4a1AxamNhSi92MXJ6dy9jaWJzZGNZaVRnOVl6cENINHpoakhEYXFvTVVk?=
 =?utf-8?B?RDdsZEczYUYvSGI5N3hvcFZLMm5CWm5zNFE2dkNEVXp0aEZlRjlCQVBVL1Vi?=
 =?utf-8?B?bHRMWjlYV0xMemJ1dnlLMUVFcS83b3RZZjZNeGExTTI2V3QyTDVQRXMyZzVv?=
 =?utf-8?B?SzBUQmdWR24wbjZtZG5HZzJuRGt2VHJyZHBSZThDNThPeUNNbzIvb1VmWjc5?=
 =?utf-8?B?QURVVlpudXVvcDFmKzY1ZmlNZzBzazkyZ2JCcGxjdGpKNVNYamxIUm80L2o4?=
 =?utf-8?B?aXVvZkxjQVhxMEVVdzg1cm1VcjN0WkM2RTRNTmxBNnBQOUlEbXd0WFNGTFBV?=
 =?utf-8?B?N2c1Z1BVaW9aVElUVXFoL085OG1wM1E3NWp1Tk9BZ0l1QXFWV0RJaXVvVFA2?=
 =?utf-8?B?cmtuMExQT2FJa2MyY1hadCtTZ1IxYXowWXhXTS9idXl6UWRQa3dmb3JWMWQv?=
 =?utf-8?B?cEJVK3cyM2VhdVhJSTFaSWw1azZoaXgyMUEvTkxDZEhCdVZpYUN5Vkg4Y2Nt?=
 =?utf-8?B?QzNzVE45TjN2MFQ0YXVPSnVUaW1GdTI4Yk5XNUkyblZTcjVBeWxtN1lnS1Js?=
 =?utf-8?B?eEs2T3JsNU5mUWVhSHNvV1FVblowZHhhWXU1Z0t0U3JYZ28rbWt5OU9yOFFo?=
 =?utf-8?B?aVRONm9XL1l3dFB3MjN5MFhyVkRXdDhDNHMwdFU3NDJoVG1Sa0JHR2JKQWVh?=
 =?utf-8?B?TTl5bVJweG5hdFY3UkxmYjkrM3o3YWltSGxEZlZITjVMN1VXbFBzYlNxM0tC?=
 =?utf-8?B?dlUreUN6SVFWSnRIR0Z5UXlqT1lTZUxWRzZ2NWZwZ2xUQ2lJWXJaYVZIVFdv?=
 =?utf-8?B?V05wTXZicVFKbmhOWlVDMkFxcW1JQVJzMVNNeTBVREUySHhCOEpBZzNoMEJW?=
 =?utf-8?B?cGJ0bWRNam92UUhiRzJ3a1lhdUZ1OW9ENyt2czZ5MlpYalpNZDVHS1FXNDNo?=
 =?utf-8?B?L3Q4TlhUNUhRbXN1b3BndlZVOTg5SDZHaHl1eko3MVYrL2dNaWpmZXBOa3Iy?=
 =?utf-8?B?SVlXbmw0MXdtUkdOTnI4eFB6cTJKZVRBUEZnVy9Mc1NXYTlhNmU0ZTFpYVFx?=
 =?utf-8?Q?Aojtg4/SHeLkdpVSmXSPV8lA/T5AdQYuMyVEij4pnOzz15?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51243e71-97b4-47a5-14ec-08dacbd2685c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 15:09:38.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3forrIWn7Vs5WdyO4ni6dgCnVj+1YHKuXa4gFxzta/TS1TOoBMzFJ4rpZwOzpg3ySSbMxn6C8cgXzzezq7CFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6748
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:51:58PM +0100, Jan Beulich wrote:
> On 21.11.2022 15:29, Roger Pau Monné wrote:
> > On Mon, Nov 21, 2022 at 03:02:30PM +0100, Jan Beulich wrote:
> >> On 21.11.2022 11:21, Roger Pau Monne wrote:
> >>> @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
> >>>  		return false;
> >>>  	}
> >>>  
> >>> +	if (xen_initial_domain())
> >>> +		/*
> >>> +		 * When running as a Xen dom0 the number of processors Linux
> >>> +		 * sees can be different from the real number of processors on
> >>> +		 * the system, and we still need to execute _PDC for all of
> >>> +		 * them.
> >>> +		 */
> >>> +		return xen_processor_present(acpi_id);
> >>> +
> >>>  	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
> >>>  	cpuid = acpi_get_cpuid(handle, type, acpi_id);
> >>
> >> We had to deal with this in our XenoLinux forward ports as well, but at
> >> the time it appeared upstream I decided to make use of acpi_get_apicid()
> >> (which meanwhile was renamed to acpi_get_phys_id()). Wouldn't than be an
> >> option, eliminating the need for a Xen-specific new function?
> > 
> > While this would work for PV, it won't work on a PVH dom0, since the
> > ACPI MADT table is not the native one in that case, and thus the
> > Processor UIDs in the MADT don't match the ones in the Processor
> > objects/devices.
> 
> I wonder whether we can actually get away with this difference long term.
> I've gone back and looked at the commit introducing the code to build the
> replacement MADT, but there's no mention of either the reason for the
> changed numbering or the reason for limiting MADT entries to just the
> number of CPUs Dom0 will have. (Clearly we need distinct APIC IDs, at
> least until Xen becomes more flexible / correct in this regard. And
> clearly we'd need to "invent" ACPI IDs in case Dom0 had more vCPU-s than
> there are pCPU-s.)

Linux when running in PVH/HVM mode uses the ACPI Processor UID in the
MADT as the vCPU ID, so attempting to re-use the native UIDs doesn't
work.

We could expand the dom0 crafted MADT to make sure all the native ACPI
Processor UIDs are present in the crafted MADT, by adding them as not
present entries, but that seems more like a bodge than a proper
solution.  Even then those X2APIC entries would appear as offline by
the current checks, and thus won't get _PDC evaluated either.

Thanks, Roger.
