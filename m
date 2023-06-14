Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83AB72F186
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbjFNBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFNBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:18:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2D123;
        Tue, 13 Jun 2023 18:18:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGi1MA011136;
        Wed, 14 Jun 2023 01:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=SRXaDSoMEZoRNhVNw2qbALEM0h5KbqybD2z5ec0eV5w=;
 b=RAedWWeNu1Wv+qj6NbmjSDPPLtJihpMv1oPkDSxQhJrB0DRciqO0lsBWekXUtH0OJ96u
 JQjM53hTC1CgzhSbuUd5+1ttRSvVqfFk0rLpdJUNioVup1wigQNAgOJDFf5Q5aiJOSEc
 Gsj8VcVV58wzMdVrG/x2ACd9lrkEhbelbCfq8usPZlbNLmZH5AOFsEb9mKXQ7BYMzcpm
 DC6GhjzqVU7HcWovLjgKnTZfJqYOWEIYwr73zg191DpE0Nku8cLtNl0SZAVhEJBe97Ol
 g7KReOxPIyyZ9HZ4MIq91e6CPBHXPpdyIDf0aL28LaNRvFleVy4BEEHFrLkK+OseKQe1 cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdpd92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 01:18:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35E061N2008281;
        Wed, 14 Jun 2023 01:18:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmb66tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 01:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPMMvtpELvKGv3XWdmo3oAQP7+eC2EmSeJ0AWUDj4Vz73tEV/wF323FO7YVaoSGLltSnuP2m8WpkB0JDQqsgJMUnqmqaGppSAn8N+kbZiFW6ATB9It83teReGEc7DLSWuAiitQxdHKFnI5tDpVb8kdSl3mGt4QnhTFoBzhBWq4QhXt30SXAqZ2XuHsf4xyhLkIrRD6bipmMFkHraWCTASjrpHFCt3xBnBBGNHQVKWCHnnJ6OZ8XYGjFrZ6H0FaozvKfo+VPLXnvJ8SwjB1cPpQXjKXkcQqTULJzY2a3ANi7Fw0lKystR78gvlCstOHTWI37LNbRRl0ro9hg77ngcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRXaDSoMEZoRNhVNw2qbALEM0h5KbqybD2z5ec0eV5w=;
 b=Fku/T3cBYaaNyU5jgQIhzC+EfRnZajhn1bSh3koAC0ZhInm2guLe0HQGLZ6ssA5K6whEGd0PxArOB51VXeMNcSCrEsMm5xJdHstf13K8aVm5N5bMeGegGHP61mwM3izEJIJmQDxw+hvAnHzo8+qGWnw4Oh4XqhAgy1tyxEs72FkZHRS65x38VFu//+VUmE7E/0r85twdndH7Fm14ofEXbdb1DsFDQA/NbcXFqum2cE8IUQd5U3hjoRX1NaX6iq6V+iszAjXU82yJNKAgGfQWxlaCRODb32AICrii2pjSyjQJaEwb+MjzRIZcMGT6WgB7OHpXOmceHJwRvRh7SQa3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRXaDSoMEZoRNhVNw2qbALEM0h5KbqybD2z5ec0eV5w=;
 b=PnhtNhxrj5E48ihdjQ0raKIGMmwQj0vzCc9AO0wSVJrrNogKY8MDPL1XOXRe0j6Fg7KOejxRqXw+CGapNUoZyWUX6cjTXDBX85bZMuCje1FRxfzCSuubdm0exUF4TxU39ZWV1FDfMvK0K1UYlGxV2Dv1qrQxJ+mKWe0HXyNVUrU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4849.namprd10.prod.outlook.com (2603:10b6:208:321::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 01:18:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 01:18:18 +0000
Date:   Tue, 13 Jun 2023 21:18:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, zhangpeng.00@bytedance.com,
        akpm@linux-foundation.org, koct9i@gmail.com, david@redhat.com,
        ak@linux.intel.com, hughd@google.com, emunson@akamai.com,
        rppt@linux.ibm.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
Message-ID: <20230614011814.sz2l6z6wbaubabk2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        zhangpeng.00@bytedance.com, akpm@linux-foundation.org,
        koct9i@gmail.com, david@redhat.com, ak@linux.intel.com,
        hughd@google.com, emunson@akamai.com, rppt@linux.ibm.com,
        aarcange@redhat.com, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
 <ZIjOlU5EfVNt6NRU@x1n>
 <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e500ff-af9c-47d6-2d87-08db6c753c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTPdMzEjfvWi5sYehIyzTUY1f6oH3fY7HhghUuFSX7QpOXwmbIWq8uIL3J25hNOQRP2JD8qCX7WgcFugUe/D4BjiH7gwVK4HsniVMskmPM+/LvCQAh6XQtpyB8yPuZl++HXrdAAQ0EAhHosTUy4/s8hor5yt2IWCWBi7bE/pUMAjLbXsvw53JEJ6YUS+NI4qZy5U/n+MZtyIltLq75ol5HNXKLxglc+7xk/gPeKub/XRXhlalXYqPAheLL8iWNo2fd8SC0AKlQpP6G1Kc73QPb5+0WmQkg5X/CVAvaw9nDt5lmVNWj+YJPhjnI8VmA6/23sHvKQ1lFJNmPTw/dzDVZ2ZqnBCpjJybEj3w3pXFqu12bTVmTVHK61FxK/sRw3q/rJs6ottyVqu9pFkU4dv7T9peMMPiGiU+tzReVhFOAJLQixzI5YhymGmy+dL2nFuFMZ3S2jrNa3VZpPRZmmWAad2jt027TU8z4eMzrnQdXPoMzMK/XL0br6JkVHlUTD/SKYPjfmLPY9BT5kzGsA+suUZdlIS8CiOgJ+blAXiFTN8plzy0k9m2aIt/2JPxzO2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(6486002)(6666004)(83380400001)(38100700002)(86362001)(33716001)(26005)(6506007)(9686003)(6512007)(53546011)(1076003)(186003)(2906002)(54906003)(5660300002)(8936002)(316002)(7416002)(41300700001)(8676002)(4326008)(6916009)(66946007)(66556008)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXF5czdXWVY3NzRydStwUTl0VStTNTFsQXNRamtnay9RdDJCL3V1dkxDUWQ2?=
 =?utf-8?B?MTZOWkdydElTK1VobFRsdzZsMklDVUE1MXFrRTE4cS9NUzdiaEdPTFZBMXk0?=
 =?utf-8?B?ZmlVV2FmMXhJUG1uY0p5TUtDZXNEbndqWFN1ODR0Q2J6aWxKNytNRXV1L29h?=
 =?utf-8?B?Z1J0Y294VEMvaGVSRG5WampTTFZ4YWRGUXJkU1B6YnRZL2R2WWZONi9oZ0lL?=
 =?utf-8?B?alladGxZUmN5MUdhbjVlT09QZHhJOUpJSlhUaHh5TmVJbFFBYStaaFNSQjRB?=
 =?utf-8?B?bDUvSUF5RG1vWGNuTC9uczRuaUF0NDJMVUp2NzZLUisvVGZWL2ptMS8vMnlB?=
 =?utf-8?B?bDRaK0hmNDR0dlhtSWx3TGJNanRDR21xYmhiRi9pUm1kTWY3MTd1U2VZM2M3?=
 =?utf-8?B?cmNiN1FoWCtrSXFUNVhlTWJyeVNYaWpEd1hQTERpZE5iQ01MQ3Zhb0psYkhx?=
 =?utf-8?B?QXIweStVdUZueDd3cGp6M3dnKzFKUm4vSTZ2L1Nuemh2ME8ySUNHeFdrR2Fz?=
 =?utf-8?B?c29mUlEyVy92Qlc5V1V4dFFzZ25Nam0zSHRHcy9JdE81b25SMEdESUFyNDYw?=
 =?utf-8?B?VjlpVFppMU50VmRuelAxd253SEh4ZCtHYXlHQ0ZBU1A0ZnkyRVRlV3FmVlZ5?=
 =?utf-8?B?U21GNnhUd3M4TTQrbkF4aHpCMWc5NFBzbVRrallGSVVaYmZFS0FDSkxtN3Bj?=
 =?utf-8?B?YVIyUmdhRTFmU0JHVGI1SjY3Mk1jRnUwOGZ3SW5GaFVieEF1Y0I5MGpvbkd5?=
 =?utf-8?B?Ty92aDJ5cW9UMWQ4bHFFaEhvZktrdXJ6OE5zdHJ6N2FqUGFNeTRnS0d5d1hW?=
 =?utf-8?B?MVVVSnRFb3l2VU9rdnRmRHE4V0FXY3B5alMyN1Fsakc3ZU8wZ2V4VW9pS3dt?=
 =?utf-8?B?SGZQWG42cWgyODYxazZFb0V6MW9ZdFdWb3RpaHlXcGY2ZUY5eWgzcXNIVjJS?=
 =?utf-8?B?L2xrNzZxcTUyckFhWU5BMzgyOE9ONGQxMTliZ0plczBiSnJvZ3pCZ3BtNjBW?=
 =?utf-8?B?UnZqbEJsMmJMRlBlbFArOUlkQ2kzclpQbkJjQ3lsbzRQRTluOHZnU0g1cUF2?=
 =?utf-8?B?aFFNNlFtM2IwbGlzM2kwQjJscGtwWXpnUDd3ZDB2K0xOd2Jld2htNEpFSlV3?=
 =?utf-8?B?bVlDdmVmeVp5eUxMbHhlbHZCc1JET3BGYWZiZ0taak1RVWpDeWJMaE1FSFZV?=
 =?utf-8?B?SDAxdzNvK3hEa2JmaUpjbGdONUEzQ2c2b0tjRUFjcHBxYUphZVNyR1lHdXZ5?=
 =?utf-8?B?UnZzYkh5NU1SZG8rNitTQS9BTEk2TmhWM29wYS9WR0Qxb3RNVEY0bGNwc05X?=
 =?utf-8?B?THJCL09KWWpnK0ZPMDY2ZVdHOEZFT09EaE9OR05JcEt2RncyRFNwY1d5cDJB?=
 =?utf-8?B?VnZpdDRqcmgvUU9KdFlUSUVueVNEVERZeVR3OVBtQXZKU1JQeHVEaURlZEdt?=
 =?utf-8?B?SjFKY3g4TVV4c2NScmt4RmFGMktIejM2QXVieUlQYVBWSVhBNllOL3NDbkhX?=
 =?utf-8?B?dzNEV1VvdHovNDlrK1NhRFZtbW5zdFdHd2FXNmxBak8rSXpSeHphcnU2bWk3?=
 =?utf-8?B?UXdMeVNDL2NadnZ5L1ltTmpBWG85aVR5eE41azRuZlBZNENtMHIzWUw5N1dn?=
 =?utf-8?B?YU9EUVA1bjNHb1Yxd0dPd0ZyZ2c5eWREVkhTcTQ3NGZKR1luemg0ZUk0aVo5?=
 =?utf-8?B?QVhFMXkxc050TmFTb09Vc0ZjRG9mbjF4TGRhUWgvM1BlZGxwbXRweW5kd0ND?=
 =?utf-8?B?bzBaN09wMW1TZHp3RUhkNkt3ZGhkbC9QengvVnNyRGRkRFMzT1ZVSVhUdXM2?=
 =?utf-8?B?QzVENHRIY2xISTBwSE5Ibk5vajF6Q2V3NkxRbktHVXJEUEV5aERSdi9CRDY3?=
 =?utf-8?B?TEVXTldFM3VuL0lQQnFKemZ6TkpUcWxaM3FYeHYwcjVja0ZOclZTZDA5elVP?=
 =?utf-8?B?VitNckUwTlBFT1NRS1RTRWNueXhaZlZYYTdNdzFtVlBXRXRHbEVSaktOSE9I?=
 =?utf-8?B?R2kvSmdPemJSaldERFlLUGd2bjBOcXNDQmJzTzB4VXovVUsyYlhBVG9KYW90?=
 =?utf-8?B?NCt3Qi9CSStlV0srUmFBMWNEL2hRZjllQm5TS2d0S09UMkNxVkJFd21EODdR?=
 =?utf-8?B?ZUFlUUJnb1MxK1ZZemJiWkF0b3cwSExuZ1IwTTR5Q3k4eTQvbUxvVllVclRV?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RG9pZEE2SFN4TUU5Vy9jTWw5TUxtU0tSVHFhQ0M2QktvR2M0T3pFdEtkeGdX?=
 =?utf-8?B?MmQrNTdEdmNRNCtnRGNlWXpLaUdweGY0SzAwWEpBQmIwVW5qRllXazdTZWMz?=
 =?utf-8?B?WEQ5OTVkNHd5QzNSUlZSN09NZjRBSUVBNllqTFRSbFNZSXlMU2Y4MHQvSE1n?=
 =?utf-8?B?OFNEeWNTNzF5a1p5RXFSV2NNK3F0OVdrZWM4RlBDYTZHQzJYcGZQZURhNVl2?=
 =?utf-8?B?V1F0a0tLdnE0Q0tJVENkVDI1UC9qUDJNbXM4bTFwTTFIeVVySTdxOE9tS0M5?=
 =?utf-8?B?VUMxSEowaTc3WEIyZDdJSTZwU1FYNEF5d3BxNTVGUzFwSEpsQmpwbGg0RVNE?=
 =?utf-8?B?aWVRdXN3L25BclkxZDRNTnlVZzZVbGoyMEFrc29JdnE2YWwva2dNVTVFdUYz?=
 =?utf-8?B?dlVFRDdKWU9wTXpDdUVHZEFrZzBBQlZGTFNPcG4rWGMyTnQ4cThlTW56UStJ?=
 =?utf-8?B?OGVoN0llZDJ5Nk5VRlZnMDd6MitiZDdoRlpaL2piN0ZrZlQ0bVp6aDIvcmt3?=
 =?utf-8?B?MWZjQVlTZVdEV3UwWU1abHJNRDMyTnBRRm50Q2N3MHBEUUVucjNGeTdPZVdL?=
 =?utf-8?B?LzkzakIvTWorb1p3ajgvODY5SHdCQjRMSlJvbmwxemgvTXhkS0grN2FzdEty?=
 =?utf-8?B?T3JCSDFHc2ZEK2FwSEJvNnNOM0swTTJGYWdKU0xPRSsyeVNsSkF1NHNKNjhR?=
 =?utf-8?B?a3pOd2o1S0t5cHdHSmFxWVBZY1g0Ny8rcmdETDZOZWo4MlQzNkV0b1ZWYld5?=
 =?utf-8?B?WDRuUlNKNFBxZFdDeGdQV0svZmlpM2Z5UHpzWmJiN0p4andQSzR6NkhtbWZ6?=
 =?utf-8?B?WFV5aEVtZ0o2Z1hLb2JWS2Z4SmpTRnVQS2p3K0JTNklVNG5CdlRtZzE4RzVS?=
 =?utf-8?B?WFd5Yi9QTWFhL1paNEYyOXBTUmFZdWhJK1lxZUdYblE2Yy9rYW1SVmpqOERC?=
 =?utf-8?B?WWMvNnhwU291V2tIQXVOdHpBWjhuQ05nU3gzdm5SQ2o4TStMSS9iclUvb3Zp?=
 =?utf-8?B?a28wQkhEOEZVZFdqMUZOL0xBYkVwMTI1RkxtM0pmMCtiWDJQZUdKanh1SjlC?=
 =?utf-8?B?cG93VVVoeFd5eWo3Y3BiMVA5cDYvL3ZDQjU2Skg3aEpmaVU2SVlLSGtLZUR1?=
 =?utf-8?B?T0xSU1dUSmJhNnZ4NDE1WitxMitUT0xDZjhoUGlwazBHNS9aeFlsYmQ2OXNy?=
 =?utf-8?B?cHpseTVZRE5nRWpwRmx1R0FJVmRSNkl5M1oxdTA0ZUFnSmhRQytnNUwzeVV6?=
 =?utf-8?B?WGpmdXRjVzkzSjZQZ1VKMkxENkpPejFpZzZZbnhOSk1BbXpDS0U4NTEzUGpu?=
 =?utf-8?B?eElWdmhtTzg5bGU4dCsxL25abGFzbm4zT1ljOGRvREZTWW1IcWVUaUhTUDJG?=
 =?utf-8?B?dDRVak14WU5tMUpNSkg4aE56S2x5S1JON1dZK2szcFh2T01LSHJrdzNqK1h1?=
 =?utf-8?B?cXMrWDd1ZVNyaTZYM0htRmlVOEMyVU9XNVphTHRobmU1NXNyS2xXenV2N2N0?=
 =?utf-8?Q?YWek44=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e500ff-af9c-47d6-2d87-08db6c753c18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 01:18:17.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEu7qlXRxH9K0Z6UZcK43pNjbx6bCoZcQ8+9lV7rD5NEXWQ1y80rM+pc48XBizgnnlFqX1PlGymLEsd5E7XfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_24,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=811 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140008
X-Proofpoint-ORIG-GUID: OMDotedKp__7L2s05aihElVp_7_qJDlH
X-Proofpoint-GUID: OMDotedKp__7L2s05aihElVp_7_qJDlH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Xu <jeffxu@chromium.org> [230613 17:29]:
> Hello Peter,
>=20
> Thanks for responding.
>=20
> On Tue, Jun 13, 2023 at 1:16=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > Hi, Jeff,
> >
> > On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> > > + more ppl to the list.
> > >
> > > On Mon, Jun 12, 2023 at 6:04=E2=80=AFPM Jeff Xu <jeffxu@chromium.org>=
 wrote:
> > > >
> > > > Hello,
> > > >
> > > > There seems to be inconsistency in different VMA fixup
> > > > implementations, for example:
> > > > mlock_fixup will skip VMA that is hugettlb, etc, but those checks d=
o
> > > > not exist in mprotect_fixup and madvise_update_vma. Wouldn't this b=
e a
> > > > problem? the merge/split skipped by mlock_fixup, might get acted on=
 in
> > > > the madvice/mprotect case.
> > > >
> > > > mlock_fixup currently check for
> > > > if (newflags =3D=3D oldflags ||

newflags =3D=3D oldflags, then we don't need to do anything here, it's
already at the desired mlock.  mprotect does this, madvise does this..
probably.. it's ugly.

> > > > (oldflags & VM_SPECIAL) ||

It's special, merging will fail always.  I don't know about splitting,
but I guess we don't want to alter the mlock state on special mappings.

> > > > is_vm_hugetlb_page(vma) || vma =3D=3D get_gate_vma(current->mm) ||
> > > > vma_is_dax(vma) || vma_is_secretmem(vma))
> >
> > The special handling you mentioned in mlock_fixup mostly makes sense to=
 me.
> >
> > E.g., I think we can just ignore mlock a hugetlb page if it won't be
> > swapped anyway.
> >
> > Do you encounter any issue with above?
> >
> > > > Should there be a common function to handle VMA merge/split ?
> >
> > IMHO vma_merge() and split_vma() are the "common functions".  Copy Lore=
nzo
> > as I think he has plan to look into the interface to make it even easie=
r to
> > use.
> >
> The mprotect_fixup doesn't have the same check as mlock_fixup. When
> userspace calls mlock(), two VMAs might not merge or split because of
> vma_is_secretmem check, However, when user space calls mprotect() with
> the same address range, it will merge/split.  If mlock() is doing the
> right thing to merge/split the VMAs, then mprotect() is not ?

It looks like secretmem is mlock'ed to begin with so they don't want it
to be touched.  So, I think they will be treated differently and I think
it is correct.

Although, it would have been nice to have the comment above the function
kept up to date on why certain VMAs are filtered out.

>=20
> Also skipping merge of VMA might be OK, but skipping split doesn't,
> wouldn't that cause inconsistent between vma->vm_flags and what is
> provisioned in the page ?

I don't quite follow what you mean.  It seems like the mlock_fixup() is
skipped when we don't want the flag to be altered on a particular VMA.
Where do they get out of sync?

