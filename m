Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247877030FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbjEOPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbjEOPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:07:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB7113;
        Mon, 15 May 2023 08:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU9mtXbeK3q/NvBjGNhrVXmfkOaiuUnkLiOcPXHBtzMawmEuimTqskpSQdk4OWYQkLSDcHb+Ochx1+fM6gbA+11wL2JDtIViBsUVz43XyjipUICIoNqxOTqc7L9IpN50oFFdfANZ5RMJQgPwGG0V2v9FxUSVTMAGjd2Cl19gmEnnvr0NeNUmkK07QxuT/hghX3ywIircPOJxvaf5BYEEii8cMdsUfWHE9Ib9glHuHcmH8NWmrui6Cv9VOVzEkF6cy8EeafB8Sdie8pDKZjAM0sZ9mb2VExXCLdYzgQXGARfS+nVN+t2nnzsJ3v1WhfcxebChSYe0gcmjK/0gZbRjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdYPyJ3N3CEfgTawF7jvpdG5vLsMHOJiw4sdIqupTus=;
 b=KBPJ4jVA3542RqOS/5D185KcW9B1xWm5U6M3wW8WEB3FIPH6Qz2X9ClQLxVMq8WsZVUdPt3HL3gqdadfSOaOSJ6TLmJ93qYXxdAOycMBAZ4QvRhNdJFzW7nOG59KQtjMAHkH/dIjkpztyGBbaJPAP01pcZJXwOE6GxBj3fywVTLmCf3uFAgNapr+HVBWtnqP9Rq3+PSVbbUnj/prH+YVO7O6IdUnIXykamp2MhSLpcfa0S0eLRuj+dsbe+jCuJATc1tTun4zODYIJqEITJdYAqc7wbpIduFzTpxv7FOL+h766spnnHerH78TLoJGMd8IHb2iZp10D/HhKMlhKzjsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdYPyJ3N3CEfgTawF7jvpdG5vLsMHOJiw4sdIqupTus=;
 b=Re90cX8MuG6qpzdPQIw4ttpWpSOhYH8ZZdMz1irb7ER/fTejmddv8sRvlV5IkfB/0Zyl7VgKh8RUBx1Vlf4Ezwpe6R2fmRdUZzEVCJzmq6+fEloB+r2rWxONYPjQ4y880AGWsuOWjKKblKU8X/5CgggODJyOKBoggxe9AL1Kk7o7KDIjOxhYaBL+eY/ntH+jALuV7Aytt+o95Wfi3aPd/uOu2jRgRt89RSG21RM6JIbm6PH5mIjzqsYJEjicmKyRMGPdYBPf8HRUoyq1bpRMmvF01lHOAzL8oLgt+PapNxbsKv014lrCfpO5Ok7EN+HGSM2i6Esw+HmOG0Rbfpoy5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PA4PR10MB5588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:262::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:07:04 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:07:04 +0000
Date:   Mon, 15 May 2023 17:06:54 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <20230515170654.7aaae69c@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230515121247.GB10825@google.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230513120818.21b99596@md1za8fc.ad001.siemens.net>
        <20230515095042.GE8963@google.com>
        <20230515120138.66e48bd4@md1za8fc.ad001.siemens.net>
        <20230515121247.GB10825@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PA4PR10MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 726b2731-51e9-4054-dbce-08db55560b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9T+i8W8n1Ls9Y8a48k+NpCK1qYWF+z+LkkiWZOKj+JRd/Ubkyle7WKgIe5o3+FoIFTooKP2vNIUlVKWt/Q0380NJV1g5PRLaSKVEEhTFpxC3rn46kzhhOv2nKv+62eASdSBuoaHfqjvQl7Rb1QJZKIFl81QlpTNpkF83p2VyyykRhXq+jYtIi2yQfzfmhMaCp7JzL/1BwoKIhGifc4nEQ0CEf3+mExN22aTv+mzfCcS6Eyws64Ki4lQpYsr49i6FGBfF2IshDfuinR1q3d+t50f3dg7w/ZCLF6r1rJkB5ukc/sHYvBKYfUisdAxgDQWgppeX9J/u6fQavcNgK9gPP1iPejG7xXgmKytKxVELRhpuMXG0vao2s0YJbaWk/pKP8NDpb/jSBznO4TteUwJTlrbTKZQwporMx7pMIRX/W2YmdkCXbr4iwtFYjxeOKQmYwDdZCWA/LU3GgVqxTvw4AR9eURIdmZJa18ofxkJlzoPoilvgLb92MGshuTjCzK+chZE2oK+aWuH/p6Ebp+GNbZ6Yu+vJ0RGf1DCq2u4nYws1sGQZnNUuhLNOIZku22GB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(54906003)(4326008)(6916009)(316002)(478600001)(66946007)(66556008)(66476007)(6486002)(6666004)(41300700001)(5660300002)(86362001)(44832011)(8676002)(38100700002)(8936002)(1076003)(9686003)(186003)(6512007)(6506007)(82960400001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y6uzkbj23t+vyCXMud/pdtdgqJIlzAQ6CF8wtF7QmQYlyQbeaZpsU0YnGesF?=
 =?us-ascii?Q?xMusdMPRoixRUZQnmJnaZ/O03H+DuryUiRED/KcKdmHJ20Hu2JU+Rov+MEY6?=
 =?us-ascii?Q?pM8nOY9fSXpTJglTyPt7oyR9In9hQ1udzCPpihqNxjjxWr98Z8Q71RsCrat+?=
 =?us-ascii?Q?0VcKLR0C0/0GDLUt+5zzDH12HvekJ+Q8RBXHkDLlHFWfvwR9xUAJRG5Jl8va?=
 =?us-ascii?Q?ny6TcopCCWWCYz8QUovSGz6kGJMLLRboYRxEUjl8FO6yaZWG/BYxkkA7poSi?=
 =?us-ascii?Q?Eph4kbTy0IuoGPVSJZM4cQ0w8BQVRHtYbrbpVk+whx66BCnWRJ7sxPpoIKFp?=
 =?us-ascii?Q?f3m2TJwT/3y6Vr2jJWxlV4q0i7BPaDrEnTIJlOwQzfgZ4Bk4P6QrOcuSZs1m?=
 =?us-ascii?Q?A6xYNV98G5O5jNpozZv4j6t9UJMVLkjuR4RBSn7Z3yWoJ4+JgToZuWijSDja?=
 =?us-ascii?Q?PY4pEvPE1Pe8GgZh04sYvT5sOJw2obh4Rbrjp0OVW6zcL6brbCzTjkl6rcvx?=
 =?us-ascii?Q?+uPlQmfSD91UYldGg2i9448hjU6zI0Jw6uEoVSkHoXiE/ynJH055iYLDrf1D?=
 =?us-ascii?Q?ouTVOMq8g3sNpGjQHf8x8N0Ep2LMa2SwWrCqZIYhm5XhVb/AZ2EHQOCDH/Ni?=
 =?us-ascii?Q?un4tRNvdytkIwu2FBM41zin9RIUaGOwUUFlAwH09fjp/iFdC8QmTmFL4P0Zb?=
 =?us-ascii?Q?KSX/C3DMP9odjxNVXPzFo7cUeeeJ3AEL2hvU8KIMgePHx2vGoeOS2mHsD6Jt?=
 =?us-ascii?Q?xVdxlhS968XGi7bO9NWlNAgl+YdEMJeGq+N5q5p+1m89XO1AHGIyh5VDv6ba?=
 =?us-ascii?Q?Mmn+NApfK9MrSOe5NwdML/I5YRWMTOpeitE1Juup9VdRUikNV4B5SHNwrR58?=
 =?us-ascii?Q?kdtrx3oJyEswuwPHvWLw1a3VhE44lR5JQOkACiCovzmRONFC7FZh33Huy70C?=
 =?us-ascii?Q?STxgVIY67fKU7k7b8g6AJkytYO3/fW9fyH/mF7jZYhm4jHtH4lGYJlBrDDPG?=
 =?us-ascii?Q?uKRuatS0l4oAf93loBdmx/hFedXOHPi30vmkOC4SQvs1slXd2Yo5LhoAjE26?=
 =?us-ascii?Q?xwOfUMEQZi4BImuh2/yp8plKSvO3s1hgoKpZbFBLF2P/J6yB7mvINFyAH7SM?=
 =?us-ascii?Q?1WUnkIoFAzo+6QlhV+9E88FN2rYneAnEPkzCUU9130zjw504hc+OMgKJMWMX?=
 =?us-ascii?Q?XrqsFqpYMiF8qmNLhSpGT9DCPChbjKMATgNgKb5nyeZPzMOc5g/IzHpj+Tj0?=
 =?us-ascii?Q?byeLfY++qE0gni3B0uZ4zbr8axEf8dyJXInhAEeTQtQwW7rYGoOXU0wtQgnm?=
 =?us-ascii?Q?nhIFdPvsmDFO8g5U/OOSDwxzANvSvb5ZPLLCq0+0PfnHGPp2/ZynKr6wpR7x?=
 =?us-ascii?Q?PIYnlkQfnXcjRbVuYe/i/CQNZv3hyZRT5dW8TDPMvRHH6ca2x1FjBxvPWry3?=
 =?us-ascii?Q?WVpE40vceTQt7zorTL6ZR7KyikAS9fKwGec/CLVS8H1bNvQh75fnDHlGLuwW?=
 =?us-ascii?Q?nJLMIPgwWvrq05FpSLrueTE/f0vDeKGyTeyDSUUHnMi/frYWJcyQjF9ovgt9?=
 =?us-ascii?Q?xniM3Y0ivA6zf2HO+kLOL50apIdQfIB9xHb/qYTLx0W2YhZ5BsuzwIn7POO9?=
 =?us-ascii?Q?ybppwMMLr+xrJgcPlxbzBJdpsQiQQx+hJAH4ZqvqSOrt9LnpTbZZ2b87rnvt?=
 =?us-ascii?Q?yOLCkQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726b2731-51e9-4054-dbce-08db55560b01
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:07:04.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PHTpTj3fIsLB0qO3G+0XDYJvxnA3siRnBTGSpCbsXj4DCb7Vddz9XaE/siKrBnaNz8F8LGzwiacu7/hIXUAM31PI1Kg8ewmL5Wo1hRE3cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 15 May 2023 13:12:47 +0100
schrieb Lee Jones <lee@kernel.org>:

> On Mon, 15 May 2023, Henning Schild wrote:
> 
> > Am Mon, 15 May 2023 10:50:42 +0100
> > schrieb Lee Jones <lee@kernel.org>:
> >   
> > > On Sat, 13 May 2023, Henning Schild wrote:
> > >   
> > > > Ping.
> > > > 
> > > > As far as i remember this one should be ready to merge.
> > > > 
> > > > ACKed by Hans, and Andy had no objections given the maintainers
> > > > would accept the patches.
> > > > 
> > > > So i think it is the maintainers turn now, Pavel and/or Lee i
> > > > guess.    
> > > 
> > > Looks like there are lots of mail threads in reply to each of the
> > > patches.  If these culminated in acceptance, please collect all
> > > of the Acks you've received until this point and submit a
> > > [RESEND].  If there are changes to be made still, please do the
> > > same but submit as a new version.  
> > 
> > Ok i will send it again and include the ACK from Hans. There would
> > be no code change. Please review the code already, if you find it
> > acceptable we might receive a second ACK from Andy.  
> 
> Not sure what you mean by 'already'.
> 
> I shall not be reviewing this set until it is resent, thanks.

I just sent that v3 you requested. It has one Ack from Hans in p3. And
some minor style things from Andy, which i decided to take in when
having to rebase and test once more.

Looking forward to your feedback on that v3.

regards,
Henning
